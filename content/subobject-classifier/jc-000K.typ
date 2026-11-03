#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: [greatest subobject as natural transformation ${*} -> Sub$],
  date: "2026-11-03",
  author: "Justin",
))

- pullback of identity
- naturality: essentially, there are only one construction
- in the presence of terminal object, a uniform choice of subobjects ↔ a subobject of $1$
- Yoneda lemma: find the essential one construction, universal element $id_1 : 1 arrow.r.hook 1$

now we established the subobject functor, before we step into subobject classifier, i want to change a perceptive to see the greatest subobject $id_A : A arrow.r.hook A$ again.

the construction of $id_A : A arrow.r.hook A$ seem do not depend on the object $A$, we can do this "uniform" construction all over any object. and maybe, there are the only one "essentials" subobject.

this construction are "uniform" in the sense that: we have $id_A in Sub(A)$ for each object $A$ and the functorial of $Sub$ preserve $id_A$, namely, for any $f : A -> B$, we have $f^(-1)(id_B) tilde.op id_A$.

#cd(
  node((0, 0), $B$),
  node((0, 1), $A$),
  edge((0, 1), (0, 0), $f$, "->", label-side: left),
  node((1, 0), $Sub(B)$),
  node((1, 1), $Sub(A)$),
  edge((1, 0), (1, 1), $f^(-1)$, "->", label-side: right),
  node((2, 0), $id_B$),
  node((2, 1), $id_A tilde.op f^(-1)(id_B)$),
  edge((2, 0), (2, 1), "|->"),
)

indeed, for all generalized element $x$ of $A$, we have $x = id_A x$ and $f x = id_B f x$, so $x in id_A$ and $f x in id_B$ i.e. $x in f^(-1)(id_B)$ are both hold, so $id_A tilde.op f^(-1)(id_B)$.

this is exactly the ideal of natural transformation! let $pt : cal(C)^"op" -> Set$ be the contravariant constant functor sending all object to the singleton set ${*}$ and all morphism to identity on singleton set $id_({*})$. we can state uniformness of picking one subobject $id_A$ for each object A as: We have a natural transformation defined by:

$ eta & : pt -> Sub \
  eta_A & : {*} -> Sub(A) \
  eta_A & : * |-> id_A $

the naturality says for any $f : A -> B$, the following diagram commutes:

#cd(
  node((0, 0), $B$),
  node((0, 1), $A$),
  edge((0, 1), (0, 0), $f$, "->", label-side: left),
  node((1, 0), ${*}$),
  node((2, 0), $Sub(B)$),
  node((1, 1), ${*}$),
  node((2, 1), $Sub(A)$),
  edge((1, 0), (2, 0), $eta_B$, "->"),
  edge((1, 0), (1, 1), $id_({*})$, "=", label-side: right),
  edge((2, 0), (2, 1), $f^(-1)$, "->", label-side: right),
  edge((1, 1), (2, 1), $eta_A$, "->", label-side: right),
  node((3, 0), $*$),
  node((4, 0), $id_B$),
  node((3, 1), $*$),
  node((4, 1), $id_A tilde.op f^(-1)(id_B)$),
  edge((3, 0), (4, 0), "|->"),
  edge((3, 0), (3, 1), "|->"),
  edge((4, 0), (4, 1), "|->"),
  edge((3, 1), (4, 1), "|->"),
)

so $id_A tilde.op f^(-1)(id_B)$ !

the naturality given described the "uniform" part, and the Yoneda lemma given help us to find the "essential" core. recall the definition of terminal object $1$, it has the property that, for any object $A$, we have one and only one arrow $!_A : A -> 1$ from A into $1$, in other word, $hom_cal(C)(A, 1)$ is a singleton set, so we have a set bijection

$ {*} tilde.equiv hom_cal(C)(A, 1), * |-> !_A $

more over, this bijection is natural in $A$, (the assignment of $!_A$ for each object $A$ is also uniform), that is, the following defined a natural transformation (in fact, natural isomorphism, since every component is bijection)

$ xi & : pt tilde.equiv hom_cal(C)(-, 1) \
  xi_A & : {*} tilde.equiv hom_cal(C)(A, 1) \
  xi_A & : * |-> !_A $

one can check, using the fact the functorial of $hom_cal(C)(-, 1)$ is the postcomposition by $(compose f) : hom_cal(C)(B, 1) -> hom_cal(C)(A, 1)$, the naturality of $xi$ is $!_A = !_B f$ for all $f : A -> B$. composite them, we get a natural transformation:

$ theta := eta xi^(-1) : hom_cal(C)(-, 1) attach(tilde.equiv, t: xi^(-1)) pt attach(->, t: eta) Sub $

whose component at $A$ is $hom_cal(C)(A, 1) -> Sub(A), !_A |-> id_A$.

think about how to make a uniform mapping that send a morphism $f : A -> 1$ to a subobject $u_f in Sub(A)$ of A, and this mapping need to work for all object $A$. if we have a subobject $v in Sub(1)$ of 1, we can use the functorial of $Sub$ to get $f^(-1)(v) in Sub(A)$. it turns out is the only way to make a such uniform mapping! the trick is, we can use $id_1 : 1 -> 1$ to detect such uniform mapping!

consider the component of $theta : hom_cal(C)(-, 1) -> Sub$ at $1$ and input $id_1$:

$ theta_1 & : hom_cal(C)(1, 1) -> Sub(1) \
  theta_1 & : id_1 = !_1 |-> id_1 $

(the left hand side $id_1 : 1 -> 1$, the right hand side $id_1 : 1 arrow.r.hook 1$ is a subobject of $Sub(1)$) \
the naturality recover all component from the "essential" subobject $id_1 in Sub(1)$: for any object $A$, we have the morphism $!_A : A -> 1$, by naturality, the following diagram commutes:

#cd(
  node((0, 0), $1$),
  node((0, 1), $A$),
  edge((0, 1), (0, 0), $!_A$, "->", label-side: left),
  node((1, 0), $hom_cal(C)(1, 1)$),
  node((2, 0), $Sub(1)$),
  node((1, 1), $hom_cal(C)(A, 1)$),
  node((2, 1), $Sub(A)$),
  edge((1, 0), (2, 0), $theta_1$, "->"),
  edge((1, 0), (1, 1), $(compose !_A)$, "->", label-side: left),
  edge((2, 0), (2, 1), $!_A^(-1)$, "->", label-side: right),
  edge((1, 1), (2, 1), $theta_A$, "->", label-side: right),
  node((3, 0), $id_1 = !_1$),
  node((4, 0), $id_1$),
  node((3, 1), $id_1 !_A = !_A$),
  node((4, 1), $id_A tilde.op !_A^(-1)(id_1)$),
  edge((3, 0), (4, 0), "|->"),
  edge((3, 0), (3, 1), "|->"),
  edge((4, 0), (4, 1), "|->"),
  edge((3, 1), (4, 1), "|->"),
)

so $id_A tilde.op !_A^(-1)(id_1) in Sub(A)$. all greatest subobject $id_A in Sub(A)$ are the _shadow_ of the "essential" core $id_1 in Sub(1)$ in the way $id_A$ are preimage of $id_1$ under $!_A$ for all object A.

this process of find the "essential" core are basically the proof of yoneda lemma and the representable functor. we state three theorem and definition that we will use in the following paragraph. i suggested also see nlab to find more detail. but also don't worry about these statement, we will unpack the proof in the most use of these theorem.

#transclude("jc-000L")
#transclude("jc-000M")
#transclude("jc-000N")
#transclude("jc-000O")
