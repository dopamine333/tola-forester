#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Example",
  date: "2026-11-03",
  author: "Justin",
))

Fix an object $A$. The identity $id_A : A arrow.r.hook A$ is #tree-link("jc-000X")[monic]. It represents the maximum subobject of $A$, i.e. for every subobject $u$ of $A$, we have $u <= id_A$. In other words, it "collects" all elements of $A$: for every generalized element $x$ of $A$, we have $x in id_A$.
