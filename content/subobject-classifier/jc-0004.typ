#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "Generalized elements",
  date: "2026-11-03",
  author: "Justin",
))

Let $cal(C)$ be a category. In general, for an object $A$ in $cal(C)$, we can't talk about an element of $A$. But from the categorical semantics of type theory, or through the lens of the Yoneda lemma, it seems to be a great idea to consider the *_generalized elements_* of $A$.

#transclude("jc-0005")

The notation of generalized elements makes reasoning about objects very much like reasoning about "sets". The Yoneda embedding $upright(y) : cal(C) -> Psh(cal(C)), A |-> hom_cal(C)(-, A)$ can be viewed as converting an object into its generalized elements, sorted by context (where $Psh(cal(C)) := Set^(cal(C)^"op")$ is the presheaf category of $cal(C)$, and we should assume $cal(C)$ is locally small so that $hom_cal(C)(-, A)$ takes values in sets). The following exercise gives more intuition about the notation of generalized elements:

#transclude("jc-0006")

The name "global element" comes from the following understanding: if we have a global element $c : 1 -> A$, we can form the generalized element $c !_Gamma : Gamma -> A$ for each object $Gamma$, where $!_Gamma : Gamma -> 1$ denotes the unique map into the terminal object. Such a collection of generalized elements ${c !_Gamma}_(Gamma in cal(C))$ is invariant under "context substitution", in the sense that $c !_Gamma sigma = c !_Delta$ for every morphism $sigma : Delta -> Gamma$, since $!_Gamma sigma = !_Delta$. Conversely, if we have a collection of generalized elements ${c_Gamma : Gamma -> A}_(Gamma in cal(C))$ invariant under context substitution, i.e. $c_Gamma sigma = c_Delta$ for every morphism $sigma : Delta -> Gamma$, then taking $c_1 : 1 -> A$, we have $c_1 !_Gamma = c_Gamma$ for each object $Gamma$.
