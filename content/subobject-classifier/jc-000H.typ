#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "Subobject functor",
  taxon: "Proposition",
  date: "2026-11-03",
  author: "Justin",
))

Let $cal(C)$ be a well-powered category with pullbacks. We have the subobject functor

$ Sub : cal(C)^"op" & -> Set \
  A & |-> Sub(A) \
  f : A -> B & |-> f^(-1) : Sub(B) -> Sub(A) $

mapping an object $A$ to the set of all subobjects of $A$, and a morphism $f : A -> B$ to the preimage function $f^(-1) : Sub(B) -> Sub(A)$, which sends a subobject $u in Sub(B)$ of $B$ to the unique subobject $f^(-1)(u) in Sub(A)$ of $A$ such that $x in f^(-1)(u) <=> f x in u$ for every generalized element $x$ of $A$. Equivalently, $f^(-1)(u)$ is defined as the pullback of $u$ along $f$:

#cd($
  f^(-1)(U) edge(->) edge("d", f^(-1)(u), "hook->", label-side: #right) & U edge("d", u, "hook->", label-side: #left) \
  A edge(f, ->, label-side: #right) & B
$)
