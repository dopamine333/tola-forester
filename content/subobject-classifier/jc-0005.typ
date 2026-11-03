#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "generalize element",
  taxon: "Definition",
  date: "2026-11-03",
  author: "Justin",
))

Let C be a category, A be an object of C. a generalize element of A is a morphism into A

$ x : Gamma -> A $

where Γ, the source of x, is called the context of x. in the case C has terminal object 1, and the context of x is 1, x is called a global element of A.
