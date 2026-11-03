// content/index.typ — the root tree, published at /.
#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link

#tola-meta((title: "Forest"))

The root of the forest. Create a tree with `nu scripts/new-tree.nu "Title"`, then link it here with `#tree-link("…")` or embed it with `#transclude("…")`.
