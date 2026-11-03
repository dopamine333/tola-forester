#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "Translating the greatest subobject",
  date: "2026-11-03",
  author: "Justin",
))

- As a natural transformation ${*} -> hom(-, Omega)$, or as a universal element $1 -> Omega$.
- Prove that $T arrow.r.hook Omega$ and $1 arrow.r.hook Omega$ are the same subobject, getting back to the Wikipedia definition.

In the previous section, we saw that the subobject classifier gives us the following data:

- a universal subobject $t : T arrow.r.hook Omega$ (in fact, $t = chi_(id_T) : T arrow.r.hook Omega$);
- for every subobject $u in Sub(A)$, a unique morphism $chi_u : A -> Omega$ such that $u tilde.op chi_u^(-1)(t)$.

In this section, we want to see how the subobject classifier *_internalizes_* some special subobjects as morphisms in the underlying category. Externally, we have the following concepts:

- the equality of morphisms $f = g$,
- the membership $x in u$ of a generalized element in a subobject,
- the logical "and", or the intersection subobject $u inter v$. \
  We claim that we can convert each of these concepts into a morphism $p : A -> Omega$, and that we have a collection of specified morphisms $"true"_A : A -> Omega$, one for each $A$, such that $p = "true"_A$ is equivalent to $f = g$, to $x in u$, or to $q_1 = "true"_A and q_2 = "true"_A$, respectively.

First, we focus on finding out what $"true"$ is.

Recall the greatest subobject $id_A : A arrow.r.hook A in Sub(A)$. We have seen that this construction is so uniform that the assignment

$ pt & -> Sub \
  {*} & -> Sub(A) \
  * & |-> id_A $

forms a natural transformation. Now, using the concept of representable functors: the constant singleton functor $pt$ is represented by the terminal object $1$, and the subobject functor $Sub$ is represented by the subobject classifier $Omega$, so we have

$ hom_cal(C)(-, 1) tilde.equiv pt -> Sub tilde.equiv hom_cal(C)(-, Omega) $

It sends $!_A |-> * |-> id_A |-> chi_(id_A)$, and naturality says $chi_(id_B) = chi_(id_A) f$ for every morphism $f : B -> A$. By the Yoneda lemma, computing $id_1 |-> * |-> id_1 |-> chi_(id_1)$, we get a universal element $chi_(id_1) : 1 -> Omega$ such that $chi_(id_A) = chi_(id_1) !_A$ for every object $A$.

#transclude("jc-000T")

If you didn't shout "WOW" here, you should go back and do all three Key Exercises above.

Spoiler warning!!!

Both $t$ and $chi_(id_1) in Sub(Omega)$ have the property that for every $u in Sub(A)$ and every generalized element $x : Gamma -> A$ of $A$, we have

$ x in u <=> chi_u x in t \
  x in u <=> chi_u x in chi_(id_1) $

Both act like "true"! Indeed, taking $u := t$ in the second equation, we get $x in t <=> chi_t x in chi_(id_1)$; but $chi_t = id_Omega$ by construction, so $t tilde.op chi_(id_1) in Sub(Omega)$: they are indeed the same subobject!

Proof of equation 1: by the property of $t$, we have $u tilde.op chi_u^(-1)(t)$. Expanding the definitions of $tilde.op$ and of preimages, we are done. \
Proof of equation 2: first, we have $x in u <=> x^(-1)(u) tilde.op id_Gamma$, since

$ x in u <=> x id_Gamma in u <=> id_Gamma in x^(-1)(u) <=> id_Gamma <= x^(-1)(u) <=> id_Gamma tilde.op x^(-1)(u) $

where we used that $id_Gamma <= x^(-1)(u)$ iff $id_Gamma$ factors through $x^(-1)(u)$, and that $id_Gamma$ is the greatest subobject. \
Next, we show $x^(-1)(u) tilde.op id_Gamma <=> chi_u x in chi_(id_1)$. If $x^(-1)(u) tilde.op id_Gamma$, applying $chi$ to both sides, we get

$ mat(
  delim: #none,
  chi_(x^(-1)(u)), =, chi_(id_Gamma);
  ||, , ||;
  chi_u x, , chi_(id_1) !_Gamma;
) $

where the two vertical equalities use the naturality of $u |-> chi_u$ and of $!_A |-> chi_(id_A)$. Therefore, $chi_u x in chi_(id_1)$. \
Conversely, if $chi_u x in chi_(id_1)$, say $chi_u x = chi_(id_1) y$ for some $y : Gamma -> 1$, then again by naturality, $chi_(x^(-1)(u)) = chi_u x = chi_(id_1) y = chi_(id_Gamma)$; therefore $x^(-1)(u) tilde.op id_Gamma$.

We should give the universal subobject a new name: $"true" : 1 arrow.r.hook Omega$, $"true" := chi_(id_1)$; then $"true" tilde.op t in Sub(Omega)$. It can be understood as a global element of $Omega$, so it also corresponds to a collection of morphisms $"true"_A : A -> Omega$ (in fact, $"true"_A = chi_(id_A)$ and $"true"_1 = "true"$) which is invariant under context substitution: $"true"_Gamma sigma = "true"_Delta$ for every $sigma : Delta -> Gamma$, and so

$ "true"_A = "true" !_A $

for every object $A$.

Finally, rewriting the results above, we have

$ x in u <=> chi_u x = "true" !_Gamma $

for every subobject $u in Sub(A)$ and generalized element $x$ of $A$. Equivalently, the following

#cd($
  U edge(!_U, ->) edge("d", u, ->, label-side: #right) & 1 edge("d", op("true"), "hook->", label-side: #left) \
  A edge(chi_u, ->, label-side: #right) & Omega
$)

is a pullback square for every subobject $u in Sub(A)$.
