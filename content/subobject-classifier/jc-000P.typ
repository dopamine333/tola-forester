#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "Defining the subobject classifier",
  date: "2026-11-03",
  author: "Justin",
))

#let square = cd($
  Gamma edge(y, ->) edge("d", x, ->, label-side: #right) & T edge("d", t, "hook->", label-side: #left) \
  T edge(t, "hook->", label-side: #right) & Omega
$)

#let pullback = cd($
  T edge(id_T, "=") edge("d", id_T, "=", label-side: #right) & T edge("d", t, "hook->", label-side: #left) \
  T edge(t, "hook->", label-side: #right) & Omega
$)

- Representable functors: internalization.
- Indicator functions; unpacking naturality.
- The Yoneda lemma: find the one essential construction.
- Compute the inclusion map of the universal subobject $T arrow.r.hook Omega$.

Now we have enough courage to look at the definition of the subobject classifier. From now on, we assume that our category $cal(C)$ has pullbacks and a terminal object, and is locally small and well-powered.

#transclude("jc-000Q")

From the discussion above, we expect the naturality of $chi$ to give us a uniform way to convert a subobject of $A$ into a morphism into $Omega$. We may also use the Yoneda lemma to find the essential core of $chi$. Moreover, the isomorphism part of $chi$ says that every subobject is completely characterized by an arrow into $Omega$. We encourage the reader to play around with the naturality of $chi$ and see what the examples in the previous sections correspond to; you may be able to guess all the constructions we will do in the sections below.

Let's unpack the definition of the subobject classifier:

$ chi : & quad Sub tilde.equiv hom_cal(C)(-, Omega) \
  chi_A : & Sub(A) tilde.equiv hom_cal(C)(A, Omega) \
  chi_A : & quad quad u |-> chi_A (u) #sym.eq.colon chi_u $

First, $chi$ is a natural transformation; it has a component $chi_A : Sub(A) -> hom_cal(C)(A, Omega)$ for each object $A$. Let's denote the image of a subobject $u in Sub(A)$ under $chi_A$ by $chi_u := chi_A (u)$. Notice that we can infer the object $A$ from the target of the #tree-link("jc-000X")[monomorphism] $u : U arrow.r.hook A$, so it is appropriate that the notation $chi_u$ does not mention $A$. We call $chi_u$ the indicator (or characteristic) function of $u$.

The naturality of $chi$ gives (can you guess what it is just by recalling the functoriality of $Sub$ and $hom_cal(C)(-, Omega)$, without drawing the naturality square?), for any morphism $f : A -> B$, that

#cd(
  node((0, 0), $B$),
  node((0, 1), $A$),
  edge((0, 1), (0, 0), $f$, "->", label-side: left),
  node((1, 0), $Sub(B)$),
  node((2, 0), $hom_cal(C)(B, Omega)$),
  node((1, 1), $Sub(A)$),
  node((2, 1), $hom_cal(C)(A, Omega)$),
  edge((1, 0), (2, 0), $chi_B$, "->"),
  edge((1, 0), (1, 1), $f^(-1)$, "->", label-side: right),
  edge((2, 0), (2, 1), $(compose f)$, "->", label-side: right),
  edge((1, 1), (2, 1), $chi_A$, "->", label-side: right),
  node((3, 0), $u$),
  node((4, 0), $chi_u$),
  node((3, 1), $f^(-1)(u)$),
  node((4, 1), $chi_(f^(-1)(u)) = chi_u f$),
  edge((3, 0), (4, 0), "|->"),
  edge((3, 0), (3, 1), "|->"),
  edge((4, 0), (4, 1), "|->"),
  edge((3, 1), (4, 1), "|->"),
)

commutes, that is, $chi_(f^(-1)(u)) = chi_u f$ for every subobject $u in Sub(B)$. (Compare this with the set-theoretic indicator function of a subset!)

Since $chi$ is an isomorphism, every morphism into $Omega$ should be the indicator function of some subobject. In fact, we can compute this subobject explicitly. The Yoneda lemma tells us to consider the universal subobject $t : T arrow.r.hook Omega in Sub(Omega)$, defined by

$ chi_Omega & : Sub(Omega) tilde.equiv hom_cal(C)(Omega, Omega) \
  chi_Omega & : t |-> id_Omega $

For any morphism $f : A -> Omega$, applying naturality to $f : A -> Omega$ and $t in Sub(Omega)$ gives

$ chi_(f^(-1)(t)) & = chi_t f \
  & = id_Omega f \
  & = f $

That is, $hom_cal(C)(A, Omega) -> Sub(A), f |-> f^(-1)(t)$ is the inverse of $chi$: every subobject is just a preimage of the universal subobject $t$!

#transclude("jc-000R")

Finally, we can also compute the #tree-link("jc-000X")[monomorphism] $t : T arrow.r.hook Omega$ as the indicator function of some subobject. To show off the proof techniques of category theory, we compute $t^(-1)(t)$ in three ways:

- Computing $t^(-1)(t)$ by pullback: consider a cone $T attach(<-, t: x) Gamma attach(->, t: y) T$ over the diagram $T attach(arrow.r.hook, t: t) Omega attach(arrow.l.hook, t: t) T$:

  #square

  We have two pieces of data, $x$ and $y$, and one constraint, $t x = t y$. Since $t$ is #tree-link("jc-000X")[monic], $x = y$. So a cone over $T attach(arrow.r.hook, t: t) Omega attach(arrow.l.hook, t: t) T$ really consists of one piece of data, $x : Gamma -> T$, without any constraint; it holds the same data as a cone over the diagram consisting of the single object $T$. But the limit of the diagram consisting of the single object $T$ is $T$ with the universal cone $id_T : T -> T$. So we claim that the following is a pullback square:

  #pullback

  Indeed, it commutes: $t id_T = t id_T$. Given any cone $T attach(<-, t: x) Gamma attach(->, t: y) T$ with $t x = t y$:

  #cd(
    node((0, 0), $Gamma$),
    node((1, 1), $T$),
    node((2, 1), $T$),
    node((1, 2), $T$),
    node((2, 2), $Omega$),
    edge((0, 0), (1, 1), $exists! phi$, "-->"),
    edge((0, 0), (2, 1), $y$, "->", bend: 30deg),
    edge((0, 0), (1, 2), $x$, "->", bend: -30deg, label-side: right),
    edge((1, 1), (2, 1), $id_T$, "="),
    edge((1, 1), (1, 2), $id_T$, "=", label-side: right),
    edge((2, 1), (2, 2), $t$, "hook->", label-side: left),
    edge((1, 2), (2, 2), $t$, "hook->", label-side: right),
  )

  since $t x = t y$ and $t$ is #tree-link("jc-000X")[monic], $x = y$.
- Existence of $phi$: take $phi := x : Gamma -> T$; then $x = id_T x$ and $y = x = id_T x$.
- Uniqueness of $phi$: if $psi : Gamma -> T$ satisfies $x = id_T psi$ and $y = id_T psi$, then $x = id_T psi = psi$. \
  (In general, the pullback of a #tree-link("jc-000X")[monomorphism] along itself is the identity map.)

Therefore, $t^(-1)(t) tilde.op id_T in Sub(T)$ and $t = chi_(id_T)$.

- Computing $t^(-1)(t)$ by the Yoneda lemma: in general, the existence of a pullback of the diagram $A attach(->, t: f) C attach(<-, t: g) B$ says exactly that we have an object $A times_C B$ and an isomorphism

  $ hom_cal(C)(Gamma, A times_C B) tilde.equiv {(x, y) in hom_cal(C)(Gamma, A) times hom_cal(C)(Gamma, B) bar.v f x = g y} $

  natural in $Gamma$. Don't be scared by this statement. Think about the functoriality of the functors on both sides (verify that the right-hand side is a functor in $Gamma$! It sends an object $Gamma$ to the collection of cones over the diagram $A attach(->, t: f) C attach(<-, t: g) B$ with apex $Gamma$, and it acts on morphisms by precomposition). Follow the process above to unpack the naturality and find the universal element; you will see that it is exactly the universal property of the pullback.

To compute the pullback $T times_Omega T$ of the diagram $T attach(arrow.r.hook, t: t) Omega attach(arrow.l.hook, t: t) T$, the machinery of the Yoneda lemma and representable functors lets us do the following computation:

$ & hom_cal(C)(Gamma, T times_Omega T) \
  tilde.equiv & {(x, y) in hom_cal(C)(Gamma, T) times hom_cal(C)(Gamma, T) bar.v t x = t y} \
  tilde.equiv & {(x, y) in hom_cal(C)(Gamma, T) times hom_cal(C)(Gamma, T) bar.v x = y} \
  tilde.equiv & {x in hom_cal(C)(Gamma, T) bar.v "True"} \
  = & hom_cal(C)(Gamma, T) $

This is an isomorphism natural in $Gamma$ (why?). So by the Yoneda lemma, $T times_Omega T tilde.equiv T$, and the universal cone is given by the element corresponding to $id_T in hom_cal(C)(T, T)$ (why?):

$ & {(x, y) in hom_cal(C)(T, T) times hom_cal(C)(T, T) bar.v t x = t y} & in.rev (id_T, id_T) \
  tilde.equiv & {(x, y) in hom_cal(C)(T, T) times hom_cal(C)(T, T) bar.v x = y} & in.rev (id_T, id_T) \
  tilde.equiv & {x in hom_cal(C)(T, T) bar.v "True"} & in.rev id_T \
  = & hom_cal(C)(T, T) & in.rev id_T $

so the following is a pullback square:

#pullback

Therefore, $t^(-1)(t) tilde.op id_T in Sub(T)$ and $t = chi_(id_T)$.

- Computing $t^(-1)(t)$ with generalized elements: by the definition of preimage, for every generalized element $x$ of $T$, we have

  $ x in t^(-1)(t) <=> t x in t $

  But $t x = t x$, so $t x in t$ for every $x$. So $t^(-1)(t)$ is the greatest subobject in $Sub(T)$. Therefore, $t^(-1)(t) tilde.op id_T in Sub(T)$ and $t = chi_(id_T)$.

Comparing these three proofs is very interesting. Personally, I like the second method the most: the Yoneda lemma gives us a strong, flexible and intuitive way to think about an object defined as the representing object of some functor. This covers examples like limits, exponential objects, the subobject classifier, and more. But in principle it can be wordy: one needs to justify that every step in the computation is natural and an isomorphism, write down how elements are sent, and check the properties.
