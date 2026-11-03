#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Example",
  date: "2026-11-03",
  author: "Justin",
))

Let $f : A -> B$ be a morphism and $u : U arrow.r.hook B$ a subobject of $B$. A subobject $v : V arrow.r.hook A$ of $A$ is called a preimage of $u$ under $f$ if for every generalized element $x$ of $A$, $x in v$ iff $f x in u$.

One can check that the preimage of $u$ under $f$ is unique (up to the equivalence $tilde.op$ of subobjects) and well defined (it does not depend on the representative of the equivalence class of subobjects):

- If $v, v'$ are preimages of $u$ under $f$, then $v tilde.op v'$, since $x in v$ iff $f x in u$ iff $x in v'$ for every generalized element $x$ of $A$.
- If $u tilde.op u'$ and $v, v'$ are preimages of $u, u'$ under $f$ respectively, then $v tilde.op v'$, since $x in v <=> f x in u <=> f x in u' <=> x in v'$ for every generalized element $x$ of $A$. \
  So if a preimage of $u$ under $f$ exists, we can denote it by $f^(-1)(u) : f^(-1)(U) arrow.r.hook A$.

Taking preimages is functorial in the following sense (assuming all preimages exist):

- If $u$ is a subobject of $A$, then $id_A^(-1)(u) tilde.op u$, since $x in id_A^(-1)(u) <=> id_A x in u <=> x in u$ for every generalized element $x$ of $A$.
- If $u$ is a subobject of $C$ and $f : A -> B$, $g : B -> C$ are morphisms, then $(g f)^(-1)(u) tilde.op f^(-1)(g^(-1)(u))$, since $x in (g f)^(-1)(u) <=> g f x in u <=> f x in g^(-1)(u) <=> x in f^(-1)(g^(-1)(u))$ for every generalized element $x$ of $A$.

How do we show that a preimage exists? For a generalized element $x : Gamma -> A$, unpacking the condition $f x in u$ gives $f x = u y$ for some $y : Gamma -> U$, and we see a square:

#cd($
  Gamma edge(y, ->) edge("d", x, ->, label-side: #right) & U edge("d", u, "hook->", label-side: #left) \
  A edge(f, ->, label-side: #right) & B
$)

This gives me a strong belief that preimages are related to pullbacks. In the category of sets, the pullback of the inclusion map of a subset along a function is indeed the preimage. So we try:

If the category $cal(C)$ has pullbacks, let $f : A -> B$ be a morphism and $u : U arrow.r.hook B$ a subobject of $B$. Consider the pullback square of $u$ along $f$:

#cd($
  V edge(f|_v, ->) edge("d", v, "hook->", label-side: #right) & U edge("d", u, "hook->", label-side: #left) \
  A edge(f, ->, label-side: #right) & B
$)

We want to show that $v : V arrow.r.hook A$ is the preimage of $u$ under $f$. (Notice that the pullback of a #tree-link("jc-000X")[monomorphism] is again a #tree-link("jc-000X")[monomorphism], so since $u$ is #tree-link("jc-000X")[monic], $v$ is too.)

Let $x : Gamma -> A$ be a generalized element of $A$. See the following diagram to keep track of the arrows:

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

- If $x in v$, say $x = v y$ for some $y : Gamma -> V$, then since the pullback square commutes, \
  $f x = f v y = u f|_v y$, so $f x in u$.
- Conversely, if $f x in u$, say $f x = u z$ for some $z : Gamma -> U$, then $(Gamma, x, z)$ forms a cone over the diagram $A attach(->, t: f) B attach(arrow.l.hook, t: u) U$. By the universal property of the pullback $V$, there exists a unique $y : Gamma -> V$ such that $x = v y$ and $z = f|_v y$. So $x in v$. ∎
