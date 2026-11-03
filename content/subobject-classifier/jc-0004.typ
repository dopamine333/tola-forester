#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "generalize element",
  date: "2026-11-03",
  author: "Justin",
))

let C be a category. in general, for a object A in C, we can't talk about an element of A. but from the category semantic of type theory or in the lens of yoneda lemma. it seem to be a great idea to consider the *_generalize element_* of A.

#transclude("jc-0005")

the notation of generalize element make the reason about object very like a "set". the yoneda embedding $upright(y) : cal(C) -> Psh(cal(C)), A |-> hom_cal(C)(-, A)$ can be view as the convert from an object to it's generalize element sorted by contexts (where Psh(C) := Set^(C^op) is the presheaf category of C and we should assume C is locally small so the output of hom(-, A) is a set). the following exercise give more intuition about the generalize element notation:

#transclude("jc-0006")

the name of the global element come from the understanding: if we have a global element c : 1 → A, we can form the generalize element $c !_Gamma : Gamma -> A$ for each object Γ, where $!_Gamma : Gamma -> 1$ denote the unique map into the terminal object. such collection of generalize element ${c !_Gamma}_(Gamma in C)$ is invariant under "context substitution" in the sense that $c !_Gamma sigma = c !_Delta$ for all morphism $sigma : Delta -> Gamma$ since $!_Gamma sigma = !_Delta$. conversely, if we have a collection of generalize element ${c_Gamma : Gamma -> A}_(Gamma in C)$ invariant under context substitution i.e. $c_Gamma sigma = c_Delta$ for all morphism $sigma : Delta -> Gamma$, then take $c_1 : 1 -> A$ we have $c_1 !_Gamma = c_Gamma$ for each object $Gamma$.
