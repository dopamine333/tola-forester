// site.typ — the root program (`[build] entry` in tola.toml).
// Every file under content/ is a tree: it is validated against the schema in
// templates/model.typ and rendered to its own page by templates/render.typ.
#import "@tola/site:0.0.0": site
#import "@tola/source:0.0.0": all-sources
#import "/templates/model.typ": select-trees
#import "/templates/render.typ": render-manifest, render-not-found, render-tree

#set text(
  lang: site.language.lang,
  script: site.language.script,
  region: site.language.region,
)

#let trees = select-trees(all-sources())

#for tree in trees { render-tree(tree) }

#render-not-found()

#render-manifest(trees)
