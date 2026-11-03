#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Exercise",
  date: "2026-11-03",
  author: "Justin",
))

In the opening section, we explained why a morphism $1 -> A$ out of the terminal object is called a global element. Revisit that section, rewrite the condition "invariant under context substitution" as a natural transformation, and show that we have the bijection

$ hom_(Psh(cal(C)))(pt, hom_cal(C)(-, A)) tilde.equiv hom_cal(C)(1, A) $

(Bonus: it is also natural in $A$.)
