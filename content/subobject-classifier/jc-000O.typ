#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Exercise",
  date: "2026-11-03",
  author: "Justin",
))

In starting paragraph, we explained why a morphism from terminal object $1 -> A$ called a global object. Revised that section, and rewrite the condition "invariant under context substitution" as natural transformation and show that we have the bijection

$ hom_(Psh(cal(C)))(pt, hom_cal(C)(-, A)) tilde.equiv hom_cal(C)(1, A) $

(bonus, it is also natural in $A$)
