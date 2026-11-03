#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "define subobject classifier",
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

- representable functor: internalisation
- indicator function, unpack naturality
- Yoneda lemma: find the essential one construction
- compute the inclusion map of the universal subobject $T arrow.r.hook Omega$

now we have enough courage to see the definition of subobject classifier. from now on, we will assume our category $cal(C)$ has pullback, terminal object, is locally small and well-powered.

#transclude("jc-000Q")

from above discussion, we have expected the naturality of $chi$ gives we a uniform way to convert a subobject of A to a morphism into Ω. we may also use yoneda lemma to find the essential core of $chi$. more over, the isomorphism part of $chi$ say all subobject are totally characterised by the arrow into $Omega$. we encourage the reader to play around the naturality of $chi$ and see how the example in above paragraph corresponded to, you may guess all the construction we will do in the below section.

Let's unpack the definition of subobject classifier

$ chi : & quad Sub tilde.equiv hom_cal(C)(-, Omega) \
  chi_A : & Sub(A) tilde.equiv hom_cal(C)(A, Omega) \
  chi_A : & quad quad u |-> chi_A (u) #sym.eq.colon chi_u $

first, $chi$ is a natural transformation it has components $chi_A : Sub(A) -> hom_cal(C)(A, Omega)$ for each object A. let's denote the image of a subobject $u in Sub(A)$ under $chi_A$ as $chi_u := chi_A (u)$, notice we can infer the object $A$ by the target of the monomorphism $u : U arrow.r.hook A$, so the notation $chi_u$ do not mention about $A$ is appropriate. we call $chi_u$ the indicator (or characteristic) function of $u$.

the naturality of $chi$ gives (can you guess what it is by just recall the functorial of $Sub$ and $hom_cal(C)(-, Omega)$ without drawing the natural square?), for any morphism $f : A -> B$, we have

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

commutes, that is, $chi_(f^(-1)(u)) = chi_u f$ for any subobject $u in Sub(B)$. (compare it to set-theoretic indicator function of a subset!)

Since $chi$ is isomorphism, all morphism into $Omega$ should be the indicator function for some subobject, in fact, we can compute this subobject explicitly: Yoneda lemma tell us, we should consider the universal subobject $t : T arrow.r.hook Omega in Sub(Omega)$ defined by

$ chi_Omega & : Sub(Omega) tilde.equiv hom_cal(C)(Omega, Omega) \
  chi_Omega & : t |-> id_Omega $

For any morphism $f : A -> Omega$, apply naturality to $f : A -> Omega$ and $t in Sub(Omega)$ then

$ chi_(f^(-1)(t)) & = chi_t f \
  & = id_Omega f \
  & = f $

that is, $hom_cal(C)(A, Omega) -> Sub(A), f |-> f^(-1)(t)$ give us the inverse of $chi$. all subobjects just a preimage of the universal subobject $t$!

#transclude("jc-000R")

Finally, we can also compute the monomorphism $t : T arrow.r.hook Omega$ as an indicator function of some subobject. for the sake of showing the proof technical of category theory, we compute $t^(-1)(t)$ in three ways:

- compute $t^(-1)(t)$ by pullback: consider a cone $T attach(<-, t: x) Gamma attach(->, t: y) T$ of the diagram $T attach(arrow.r.hook, t: t) Omega attach(arrow.l.hook, t: t) T$:

  #square

  we have two data $x, y$ and one constraint, $t x = t y$. since $t$ is monic, $x = y$. so a cone of $T attach(arrow.r.hook, t: t) Omega attach(arrow.l.hook, t: t) T$ really has one data $x : Gamma -> T$ without any constraint; it holds the same data as a cone of the diagram consisting of a single object $T$. but the limit of the diagram that consists of a single object $T$ is $T$ with the universal cone $id_T : T -> T$. so we claim: the following is a pullback diagram

  #pullback

  indeed, it commutes $t id_T = t id_T$. given any cone $T attach(<-, t: x) Gamma attach(->, t: y) T$ with $t x = t y$:

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

  since $t x = t y$ and $t$ is monic, $x = y$.
- existence of $phi$: take $phi := x : Gamma -> T$ and we have $x = id_T x$ and $y = x = id_T x$.
- uniqueness of $phi$: if $psi : Gamma -> T$ such that $x = id_T psi$ and $y = id_T psi$ than $x = id_T psi = psi$. \
  (in general, a pullback of monomorphism of itself is the identity map.)

Therefore, $t^(-1)(t) tilde.op id_T in Sub(T)$ and $t = chi_(id_T)$.

- compute $t^(-1)(t)$ by Yoneda lemma: in general, the existence of pullback of the diagram $A attach(->, t: f) C attach(<-, t: g) B$ is exactly to say we have an object $A times_C B$ and a isomorphism

  $ hom_cal(C)(Gamma, A times_C B) tilde.equiv {(x, y) in hom_cal(C)(Gamma, A) times hom_cal(C)(Gamma, B) bar.v f x = g y} $

  natural in $Gamma$. don't be scary about this statement. think about the functorial of functors at both side (verify the right hand side is a functor in $Gamma$! it send a object $Gamma$ to the collection of cones of the diagram $A attach(->, t: f) C attach(<-, t: g) B$ out from $Gamma$, and functorial is act by precomposition). follow the process above to unpack the naturality and find the universal element, you will see it is exact the universal property of pullback.)

To compute the pullback $T times_Omega T$ of the diagram $T attach(arrow.r.hook, t: t) Omega attach(arrow.l.hook, t: t) T$. the machinery of Yoneda lemma and representable functor, enable us to do the following computation:

$ & hom_cal(C)(Gamma, T times_Omega T) \
  tilde.equiv & {(x, y) in hom_cal(C)(Gamma, T) times hom_cal(C)(Gamma, T) bar.v t x = t y} \
  tilde.equiv & {(x, y) in hom_cal(C)(Gamma, T) times hom_cal(C)(Gamma, T) bar.v x = y} \
  tilde.equiv & {x in hom_cal(C)(Gamma, T) bar.v "True"} \
  = & hom_cal(C)(Gamma, T) $

is an isomorphism natural in $Gamma$ (why?). So by Yoneda lemma, $T times_Omega T tilde.equiv T$ and the univeral cone is given by the element corresponding to the $id_T in hom_cal(C)(T, T)$ (why?):

$ & {(x, y) in hom_cal(C)(T, T) times hom_cal(C)(T, T) bar.v t x = t y} & in.rev (id_T, id_T) \
  tilde.equiv & {(x, y) in hom_cal(C)(T, T) times hom_cal(C)(T, T) bar.v x = y} & in.rev (id_T, id_T) \
  tilde.equiv & {x in hom_cal(C)(T, T) bar.v "True"} & in.rev id_T \
  = & hom_cal(C)(T, T) & in.rev id_T $

so the following is a pullback square

#pullback

Therefore, $t^(-1)(t) tilde.op id_T in Sub(T)$ and $t = chi_(id_T)$.

- compute $t^(-1)(t)$ by generalized element: by definition of preimage, for all generalized element $x$ of $T$, we have

  $ x in t^(-1)(t) <=> t x in t $

  but $t x = t x$ so $t x in t$ for any $x$. so $t^(-1)(t)$ is the greatest subobject in $Sub(t)$. Therefore, $t^(-1)(t) tilde.op id_T in Sub(T)$ and $t = chi_(id_T)$.

the comparison of this three proof is very interesting. i personal like the second method the most, Yoneda lemma gives we a strong, flexible and intuitive way to think about an object defined as some representing object of a functor. it includes example like limit, exponential object, subobject classifier and more. but in principle, it may be wordy: one need to justify every step in the computation is natural and isomorphism, and write down how elements were send and check properties.
