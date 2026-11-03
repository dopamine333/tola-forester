#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Example",
  date: "2026-11-03",
  author: "Justin",
))

Let f : A → B be a morphism, u : U → B be a subobject of B. a subobject v : V → A of A is called a preimage of u under f, if for all generalize element x of A, x ∈ v iff fx ∈ u.

one can check the preimage of u under f is unique (upto subobject equivalent \~) and well-defined (do not depend on the representative of the subobject equivalent class)

- if v, v' are a preimage of u under f, then v \~ v': since x ∈ v iff fx ∈ u iff x ∈ v' for all generalize element x of A.
- if u \~ u', v, v' a the preimage of u, u' under f respectively, then $v tilde.op v'$ : since $x in v <=> f x in u <=> f x in u' <=> x in v'$ for all generalize element x of A. \
  so if a preimage of u under f exist, we can denote it by $f^(-1)(u) : f^(-1)(U) arrow.r.hook A$.

taking preimage is functorial in the sense that: (assume all preimage exist)

- if u is a subobject of A, then $id_A^(-1)(u) tilde.op u$: since $x in id_A^(-1)(u) <=> id_A x in u <=> x in u$ for all generalized element x of A.
- if u is a subobject of C, f: A → B, g :B → C morphism, then $(g f)^(-1)(u) tilde.op f^(-1)(g^(-1)(u))$: since $x in (g f)^(-1)(u) <=> g f x in u <=> f x in g^(-1)(u) <=> x in f^(-1)(g^(-1)(u))$ for all generalized element x of A.

how to show the existence of preimage? for a generalized element $x : Gamma -> A$, unpack the condition $f x in u$, we get $f x = u y$ for some $y : Gamma -> U$, we see a square diagram:

#cd($
  Gamma edge(y, ->) edge("d", x, ->, label-side: #right) & U edge("d", u, "hook->", label-side: #left) \
  A edge(f, ->, label-side: #right) & B
$)

it gives me a strong belief that preimage is related to pullback. In set category, a pullback of a inclusion map of a subset along a function is indeed the preimage. so we try:

if the category C has pullback, Let f : A → B be a morphism, u : U → B be a subobject of B. Consider the pullback square of u along f:

#cd($
  V edge(f|_v, ->) edge("d", v, "hook->", label-side: #right) & U edge("d", u, "hook->", label-side: #left) \
  A edge(f, ->, label-side: #right) & B
$)

We want to show that, $v : V arrow.r.hook A$ is the preimage of u under f. (notice the pullback of a monomorphism is again a monomorphism, since u is monic, so v is monic too).

Let $x : Gamma -> A$ is a generalize element of A. See the following diagram for keep track the arrows:

#cd(
  node((0, 0), $Gamma$),
  node((1, 1), $V$),
  node((2, 1), $U$),
  node((1, 2), $A$),
  node((2, 2), $B$),
  edge((0, 0), (1, 1), $y$, "->"),
  edge((0, 0), (2, 1), $z$, "->", bend: 30deg),
  edge((0, 0), (1, 2), $x$, "->", bend: -30deg, label-side: right),
  edge((1, 1), (2, 1), $f|_v$, "->"),
  edge((1, 1), (1, 2), $v$, "hook->", label-side: right),
  edge((2, 1), (2, 2), $u$, "hook->", label-side: left),
  edge((1, 2), (2, 2), $f$, "->", label-side: right),
)

- If x ∈ v, say x = v y for some y : Γ → V, since the pullback diagram commutes, \
  $f x = f v y = u f|_v y$ so $f x in u$.
- Conversely, if f x ∈ u, say f x = u z for some $z : Gamma -> U$, then $(Gamma, x, z)$ from a cone of the diagram $A attach(->, t: f) B attach(arrow.l.hook, t: u) U$, by the universal property of the pullback V, there exist unique $y : Gamma -> V$ such that $x = v y$ and $z = f|_v y$. so x ∈ v. ∎
