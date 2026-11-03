// Forester's page behaviour, for every tree page (see templates/render.typ):
// - clicking a tree's header folds or unfolds its body;
// - clicking a table-of-contents entry jumps to that tree and highlights it;
// - hovering a link to another tree previews it;
// - Ctrl-K / ⌘-K opens a search box over every tree (forest.json).
(function () {
  "use strict";

  // ---- Folding ----
  document.addEventListener("click", function (e) {
    var header = e.target.closest("section.block > header");
    if (!header || e.target.closest("a") || String(window.getSelection())) return;
    var body = header.nextElementSibling;
    if (body && body.classList.contains("mainmatter")) body.classList.toggle("collapsed");
  });

  // ---- Table of contents ----
  var highlighted = null;
  document.addEventListener("click", function (e) {
    var entry = e.target.closest("#toc [data-target]");
    if (!entry || e.target.closest("a")) return;
    var section = document.getElementById(entry.dataset.target.slice(1));
    if (!section) return;
    for (var el = section.parentElement; el; el = el.parentElement) {
      if (el.classList.contains("mainmatter")) el.classList.remove("collapsed");
    }
    if (highlighted) highlighted.classList.remove("highlighted");
    section.classList.add("highlighted");
    highlighted = section;
    section.scrollIntoView({ behavior: "smooth", block: "start" });
    history.replaceState(null, "", entry.dataset.target);
  });

  // ---- Link previews ----
  var preview = document.createElement("div");
  preview.className = "link-preview";
  document.body.appendChild(preview);
  var pages = {};
  var hovered = null;
  var timer = null;

  function load(url) {
    if (!pages[url]) {
      pages[url] = fetch(url)
        .then(function (r) { return r.ok ? r.text() : null; })
        .then(function (html) {
          if (!html) return null;
          var doc = new DOMParser().parseFromString(html, "text/html");
          return doc.querySelector("#grid-wrapper > article > section.block");
        });
    }
    return pages[url];
  }

  function show(a) {
    load(a.href).then(function (tree) {
      if (hovered !== a || !tree) return;
      preview.replaceChildren(document.importNode(tree, true));
      var r = a.getBoundingClientRect();
      var top = r.bottom + 6 + 210 > window.innerHeight ? r.top - 216 : r.bottom + 6;
      var left = Math.min(r.left, window.innerWidth - preview.offsetWidth - 16);
      preview.style.top = Math.max(8, top) + "px";
      preview.style.left = Math.max(8, left) + "px";
      preview.style.display = "block";
    }).catch(function () {});
  }

  function hide() {
    hovered = null;
    clearTimeout(timer);
    preview.style.display = "none";
  }

  document.addEventListener("mouseover", function (e) {
    var a = e.target.closest(".mainmatter a[href], .metadata a[href]");
    if (!a || a === hovered || a.closest(".link-preview")) return;
    if (a.origin !== location.origin || a.pathname === location.pathname || a.hash) return;
    hide();
    hovered = a;
    timer = setTimeout(function () { show(a); }, 300);
  });

  document.addEventListener("mouseout", function (e) {
    if (hovered && e.target.closest("a") === hovered && !hovered.contains(e.relatedTarget)) hide();
  });

  // ---- Search ----
  var manifest = document.querySelector('meta[name="forest-manifest"]');
  var trees = null;
  var dialog = document.createElement("dialog");
  dialog.className = "search";
  dialog.innerHTML = '<input type="search" placeholder="Search for trees…" aria-label="Search for trees"><ul></ul>';
  document.body.appendChild(dialog);
  var input = dialog.querySelector("input");
  var list = dialog.querySelector("ul");
  var results = [];
  var active = 0;

  function matches(tree, words) {
    var text = (tree.title + " " + tree.addr + " " + (tree.taxon || "")).toLowerCase();
    return words.every(function (w) { return text.indexOf(w) !== -1; });
  }

  function render() {
    var words = input.value.toLowerCase().split(/\s+/).filter(Boolean);
    results = (trees || []).filter(function (t) { return matches(t, words); }).slice(0, 100);
    active = Math.min(active, Math.max(0, results.length - 1));
    list.replaceChildren();
    if (results.length === 0) {
      var none = document.createElement("li");
      none.className = "empty";
      none.textContent = trees ? "No trees found." : "Loading…";
      list.appendChild(none);
      return;
    }
    results.forEach(function (t, i) {
      var li = document.createElement("li");
      if (i === active) li.className = "active";
      var a = document.createElement("a");
      a.href = t.url;
      if (t.taxon) {
        var taxon = document.createElement("span");
        taxon.className = "taxon";
        taxon.textContent = t.taxon + ". ";
        a.appendChild(taxon);
      }
      a.appendChild(document.createTextNode(t.title));
      var slug = document.createElement("span");
      slug.className = "slug";
      slug.textContent = "[" + t.addr + "]";
      a.appendChild(slug);
      li.appendChild(a);
      list.appendChild(li);
    });
    var current = list.children[active];
    if (current) current.scrollIntoView({ block: "nearest" });
  }

  function open() {
    if (!trees && manifest) {
      fetch(manifest.content)
        .then(function (r) { return r.json(); })
        .then(function (data) {
          trees = data.sort(function (a, b) { return a.title.localeCompare(b.title); });
          render();
        })
        .catch(function () {});
    }
    input.value = "";
    active = 0;
    render();
    dialog.showModal();
    input.focus();
  }

  input.addEventListener("input", function () {
    active = 0;
    render();
  });

  input.addEventListener("keydown", function (e) {
    if (e.key === "ArrowDown" || e.key === "ArrowUp") {
      e.preventDefault();
      var step = e.key === "ArrowDown" ? 1 : -1;
      active = (active + step + results.length) % Math.max(1, results.length);
      render();
    } else if (e.key === "Enter" && results[active]) {
      e.preventDefault();
      location.href = results[active].url;
    }
  });

  dialog.addEventListener("click", function (e) {
    if (e.target === dialog) dialog.close();
  });

  document.addEventListener("keydown", function (e) {
    if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === "k") {
      e.preventDefault();
      if (dialog.open) dialog.close();
      else open();
    }
  });
})();
