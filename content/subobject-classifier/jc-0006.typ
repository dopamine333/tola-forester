#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Exercise",
  date: "2026-11-03",
  author: "Justin",
))

Let $cal(C)$ be a category and $f, g : X -> Y$ two morphisms in $cal(C)$. Show that $f = g$ if and only if $f x = g x$ for every generalized element $x$ of $X$ (where $f x$ denotes the composite $f compose x$).
