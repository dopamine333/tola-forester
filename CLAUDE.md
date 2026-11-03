# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A content-free [Tola SSG](https://github.com/tola-rs/tola-ssg) (v0.8.1) theme that reproduces [Forester](https://www.forester-notes.org/index/): a forest of small, addressed notes ("trees") that link and transclude each other, with Forester's look (its CC0 `style.css`, Inria Sans, Latin Modern Math) and features (taxa, numbered transclusions, metadata line, table of contents, back matter, link previews, Ctrl-K search). Tola compiles a **Typst** (`.typ`) program into the HTML site. `content/` holds only the root tree `index.typ`.

## Commands

- `tola dev` — live-reload dev server at http://127.0.0.1:5277 (`[server]` / `[dev]` in `tola.toml`).
- `tola check` — full build and link check without writing `public/`; the quickest "does it work" check.
- `tola build` — production build into `public/` (Tola owns and replaces it).
- `tola help "@tola/document"`, `tola help "[assets]"`, `tola skill` — the installed version's own reference. Tola's API changes between builds, so trust these over memory.
- `nu scripts/new-tree.nu "Title"` — like `forester new`: writes `content/<prefix>-XXXX.typ` with the next free base-36 number for the prefix (`jc-0009` → `jc-000A`), scanned from file names. Flags: `-p/--prefix` (default `jc`), `-n/--name` (a chosen address, e.g. `jonmsterling`), `-x/--taxon`, `-d/--dir` (sub-folder), `-a/--author` (comma-separated).
- No test suite. "Correctness" = the build succeeds; metadata, link and asset validation run at build time (`[build.references]` is all `"error"`).

The shell is `nu` (Nushell), not bash.

## Architecture

```
site.typ               Root program: select-trees, render-tree for each, 404.html, forest.json.
templates/model.typ    Tree schema, address (= file name), route, site-trees() / tree-entry().
templates/tree.typ     How a tree looks anywhere: heading (taxon, title, [addr]), metadata line,
                       plus the helpers content files import: transclude, tree-link.
templates/render.typ   The page: « Home link, the tree, back matter, table of contents; 404; forest.json.
assets/styles/style.css   Forester's stylesheet, adapted to Typst's markup.
assets/scripts/forest.js  Folding, TOC jumps, link previews, Ctrl-K search.
assets/fonts/          Inria Sans (OFL) and Latin Modern Math (GUST), self-hosted like forester-notes.org.
lib/macros.typ         Notation shared by trees (id, Sub, hom, the underlined constant functor `pt`)
                       and `cd(...)`, a fletcher commutative diagram as inline SVG. Outside content/,
                       so it is not a tree — like Forester's macros.
```

### Trees and addresses

As in Forester, **every file under `content/` is a tree and its address is its file name** without `.typ`: `content/jc-0001.typ` (or `content/notes/jc-0001.typ` — folders only organize) is `jc-0001`, published at `/jc-0001/`. `content/index.typ` is the root tree at `/`, whose « Home link is hidden. Two files with the same name fail the build (`select-trees`). Renaming a file changes its address and URL.

A tree is a metadata declaration plus a body:
```typ
#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link

#tola-meta((title: "Functor", taxon: "definition", date: "2026-11-03", author: "jc-0001"))

A body in Typst markup, linking #tree-link("jc-0002") and embedding:

#transclude("jc-0003")
```
`tola-meta` must be called directly in the content file, once. Fields (`tree-schema` in `model.typ`; unknown fields fail the build): `title`, `taxon` (shown capitalized: "Definition. Title", or "Definition 1.2. Title" when numbered), `date` (one `"YYYY-MM-DD"` or several), `author` / `contributor` (addresses of Person trees — linked by title — or plain names), and the metadata-line fields `position`, `institution`, `venue`, `doi`, `orcid`, `external`.

Helpers (`templates/tree.typ`):
- `#tree-link("addr")` / `#tree-link("addr")[text]` — Forester's `[[addr]]`; text defaults to the title. Plain `#link("/addr/")[…]` works too.
- `#transclude("addr", numbered: true, expanded: true, show-metadata: false, show-heading: true)` — Forester's `\transclude`. The section number is a CSS counter; a tree that ends up transcluding itself fails as Typst's cyclic include (the `include` deliberately runs outside `context`).

### Back matter and the link graph

A tree page ends with Forester's back matter, each entry showing the tree's heading over its folded body: **References** (Reference-taxon trees it or its transclusions link to), **Context** (trees transcluding it directly), **Backlinks**, **Related** (other trees it links to) and **Contributions** (for a Person tree: trees naming it author/contributor). They come from `references()` in `@tola/document`, so:
- Only native `link`s count. Author names, TOC bullets and « Home use raw `html.a` so they don't.
- `transclude` writes regions: `<tx-head>` (heading), `<tx-body>` (body: its links belong to the transcluded tree) and `<tx-slug>` (the `[addr]` link that makes this page the transcluded tree's Context). The back matter is `<bm>` and the TOC `<toc>`; links in either never count. Don't reuse these labels.
- `<tx-open>` / `<tx-close>` metadata markers around each transclusion build the table of contents (`toc` in `render.typ`). Section ids carry a running number (`tree-<addr>-<n>`) because one tree can appear several times on a page, and Tola rejects duplicate ids.

### Styling and behaviour

`style.css` is Forester's stylesheet; keep it Forester's. Typst writes native `<a>`s, so local links (dotted) and external ones (solid, `href^="http"`) are told apart by selector instead of Forester's `.link.local` / `.link.external` spans. Math is Typst's MathML, set in Latin Modern Math. `forest.js` folds a section when its header is clicked, jumps to and highlights a TOC entry's section, previews a hovered tree link (fetching that page), and opens the search box on Ctrl-K / ⌘-K over `forest.json` (written by `render-manifest`, URL in the `forest-manifest` `<meta>`).

`[assets] trees` in `tola.toml` publishes `assets/{styles,scripts,fonts,images}` at `/styles/`, `/scripts/`, `/fonts/`, `/images/`. Reference files in the `<head>` with `asset-url(...)`; `style.css` loads fonts by relative URL (`../fonts/…`).

`public/`, `.tola/` (cache/logs) and `.tola-build.lock` are gitignored — never commit build output.
