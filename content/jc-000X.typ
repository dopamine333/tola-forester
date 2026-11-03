#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "monomorphism",
  taxon: "Definition",
  date: "2026-11-03",
  author: "Justin",
))

A morphism $m : A -> B$ in a category $cal(C)$ is a *monomorphism* (or is *monic*), written $m : A arrow.r.hook B$, if it can be cancelled on the left: for all morphisms $x, y : Gamma -> A$ with the same source,

$ m x = m y ==> x = y. $

In the notation of #tree-link("jc-0005")[generalized elements], postcomposition with $m$ never identifies two different generalized elements of $A$: for every context $Gamma$, the function

$ (m compose -) : hom_cal(C)(Gamma, A) -> hom_cal(C)(Gamma, B) $

is injective. In $Set$, the monomorphisms are exactly the injective functions.
