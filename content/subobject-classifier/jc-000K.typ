#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: [The greatest subobject as a natural transformation ${*} -> Sub$],
  date: "2026-11-03",
  author: "Justin",
))

- The pullback of the identity.
- Naturality: essentially, there is only one construction.
- In the presence of a terminal object, a uniform choice of subobjects corresponds to a subobject of $1$.
- The Yoneda lemma: find the one essential construction, the universal element $id_1 : 1 arrow.r.hook 1$.

Now that we have established the subobject functor, before we step into the subobject classifier, I want to change perspective and look at the greatest subobject $id_A : A arrow.r.hook A$ again.

The construction of $id_A : A arrow.r.hook A$ does not seem to depend on the object $A$: we can do this "uniform" construction for every object. And maybe there is only one "essential" subobject.

This construction is "uniform" in the sense that we have $id_A in Sub(A)$ for each object $A$, and the functoriality of $Sub$ preserves $id_A$; namely, for any $f : A -> B$, we have $f^(-1)(id_B) tilde.op id_A$.

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

Indeed, for every generalized element $x$ of $A$, we have $x = id_A x$ and $f x = id_B f x$, so both $x in id_A$ and $f x in id_B$ (i.e. $x in f^(-1)(id_B)$) hold; hence $id_A tilde.op f^(-1)(id_B)$.

This is exactly the idea of a natural transformation! Let $pt : cal(C)^"op" -> Set$ be the contravariant constant functor sending every object to the singleton set ${*}$ and every morphism to the identity $id_({*})$ on the singleton set. We can state the uniformity of picking the subobject $id_A$ for each object $A$ as follows: we have a natural transformation defined by

$ eta & : pt -> Sub \
  eta_A & : {*} -> Sub(A) \
  eta_A & : * |-> id_A $

Naturality says that for any $f : A -> B$, the following diagram commutes:

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

so $id_A tilde.op f^(-1)(id_B)$!

Naturality describes the "uniform" part, and the Yoneda lemma helps us find the "essential" core. Recall the definition of the terminal object $1$: for any object $A$, there is one and only one arrow $!_A : A -> 1$ from $A$ into $1$; in other words, $hom_cal(C)(A, 1)$ is a singleton set, so we have a bijection of sets

$ {*} tilde.equiv hom_cal(C)(A, 1), * |-> !_A $

Moreover, this bijection is natural in $A$ (the assignment of $!_A$ to each object $A$ is also uniform); that is, the following defines a natural transformation (in fact, a natural isomorphism, since every component is a bijection):

$ xi & : pt tilde.equiv hom_cal(C)(-, 1) \
  xi_A & : {*} tilde.equiv hom_cal(C)(A, 1) \
  xi_A & : * |-> !_A $

Using the fact that the functoriality of $hom_cal(C)(-, 1)$ is given by precomposition $(compose f) : hom_cal(C)(B, 1) -> hom_cal(C)(A, 1)$, one can check that the naturality of $xi$ says $!_A = !_B f$ for every $f : A -> B$. Composing them, we get a natural transformation

$ theta := eta xi^(-1) : hom_cal(C)(-, 1) attach(tilde.equiv, t: xi^(-1)) pt attach(->, t: eta) Sub $

whose component at $A$ is $hom_cal(C)(A, 1) -> Sub(A), !_A |-> id_A$.

Think about how to make a uniform mapping that sends a morphism $f : A -> 1$ to a subobject $u_f in Sub(A)$ of $A$, where the mapping has to work for every object $A$. If we have a subobject $v in Sub(1)$ of $1$, we can use the functoriality of $Sub$ to get $f^(-1)(v) in Sub(A)$. It turns out that this is the only way to make such a uniform mapping! The trick is that we can use $id_1 : 1 -> 1$ to detect such a uniform mapping!

Consider the component of $theta : hom_cal(C)(-, 1) -> Sub$ at $1$, with input $id_1$:

$ theta_1 & : hom_cal(C)(1, 1) -> Sub(1) \
  theta_1 & : id_1 = !_1 |-> id_1 $

(On the left-hand side, $id_1 : 1 -> 1$ is a morphism; on the right-hand side, $id_1 : 1 arrow.r.hook 1$ is a subobject in $Sub(1)$.) \
Naturality recovers every component from the "essential" subobject $id_1 in Sub(1)$: for any object $A$, we have the morphism $!_A : A -> 1$, and by naturality the following diagram commutes:

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

so $id_A tilde.op !_A^(-1)(id_1) in Sub(A)$. Every greatest subobject $id_A in Sub(A)$ is a _shadow_ of the "essential" core $id_1 in Sub(1)$, in the sense that $id_A$ is the preimage of $id_1$ under $!_A$ for every object $A$.

This process of finding the "essential" core is basically the proof of the Yoneda lemma and the idea behind representable functors. We state three theorems and definitions that we will use in the following paragraphs. I suggest also looking at the nLab for more detail, but don't worry about these statements: we will unpack the proofs wherever we use these theorems.

#transclude("jc-000L")
#transclude("jc-000M")
#transclude("jc-000N")
#transclude("jc-000O")
