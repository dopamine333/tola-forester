#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "translate the greatest subobject",
  date: "2026-11-03",
  author: "Justin",
))

- as natural transformation ${*} -> hom(-, Omega)$ or as universal element $1 -> Omega$.
- prove $T arrow.r.hook Omega$ and $1 arrow.r.hook Omega$ are the same subobject, back to wiki definition.

In previous section, we see the subobject classifier gives the following data

- an universal subobject $t : T arrow.r.hook Omega$. (in fact, $t = chi_(id_T) : T arrow.r.hook Omega$)
- for any subobject $u in Sub(A)$, we have an unique morphism $chi_u : A -> Omega$ such that $u tilde.op chi_u^(-1)(t)$.

in this section, we want to see how subobject classifier *_internalize_* some special subobjects into morphisms in the underline category. Externally, we have concepts:

- the equality of morphism $f = g$,
- the membership of an generalized element $x in u$ are in a subobject,
- the logic "and", or the intersection subobject $u inter v$. \
  we claim that, we can convert each these concept as an morphism $p : A -> Omega$ and we have an collection of specified morphsim called $"true"_A : A -> Omega$ for each $A$, such that $p = "true"_A$ are equivalent to $f = g$, $x in u$, or $q_1 = "true"_A and q_2 = "true"_A$.

first, we focus on finding what is the $"true"$.

recall the greatest subobject $id_A : A arrow.r.hook A in Sub(A)$, we seen this construction are so uniform such that the assignment

$ pt & -> Sub \
  {*} & -> Sub(A) \
  * & |-> id_A $

form a natural transformation. now, using the concept of representable functor, the constant singleton set $pt$ is represented by the terminal object $1$, and the subobject functor $Sub$ is represented by the subobject classifier $Omega$, so we have

$ hom_cal(C)(-, 1) tilde.equiv pt -> Sub tilde.equiv hom_cal(C)(-, Omega) $

it send $!_A |-> * |-> id_A |-> chi_(id_A)$ and naturality say $chi_(id_B) = chi_(id_A) f$ for all morphism $f : B -> A$. by Yoneda lemma, compute $id_1 |-> * |-> id_1 |-> chi_(id_1)$, we get an universal element $chi_(id_1) : 1 -> Omega$ such that $chi_(id_A) = chi_(id_1) !_A$ for all object $A$.

#transclude("jc-000T")

if you did't shoot out WOW here, you should go back and do all of three Key Exercises above.

spoiler warning!!!

both $t, chi_(id_1) in Sub(Omega)$ has the property that, for all $u in Sub(A)$ generalized element $x : Gamma -> A$ of A, we have

$ x in u <=> chi_u x in t \
  x in u <=> chi_u x in chi_(id_1) $

both act like the "true"! indeed, take $u := t$ in second equation, we have $x in t <=> chi_t x in chi_(id_1)$ but $chi_t = id_Omega$ by construction, so $t tilde.op chi_(id_1) in Sub(Omega)$ they are indeed the same subobject!

proof of equation 1: by the property of $t$, we have $u tilde.op chi_u^(-1)(t)$. expand the definition of $tilde.op$ and preimage, we are done. \
proof of equation 2: first, we have $x in u <=> x^(-1)(u) tilde.op id_Gamma$, since

$ x in u <=> x id_Gamma in u <=> id_Gamma in x^(-1)(u) <=> id_Gamma <= x^(-1)(u) <=> id_Gamma tilde.op x^(-1)(u) $

where we used $id_Gamma <= x^(-1)(u)$ iff $id_Gamma$ factor through $x^(-1)(u)$ and $id_Gamma$ is the greatest subobject. \
next, we will show $x^(-1)(u) tilde.op id_Gamma <=> chi_u x in chi_(id_1)$. if $x^(-1)(u) tilde.op id_Gamma$, take $chi$ at both side, we get

$ mat(
  delim: #none,
  chi_(x^(-1)(u)), =, chi_(id_Gamma);
  ||, , ||;
  chi_u x, , chi_(id_1) !_Gamma;
) $

where two vertical equality use the naturality of $u |-> chi_u$ and $!_A |-> chi_(id_A)$. therefore, $chi_u x in chi_(id_1)$. \
Conversely, if $chi_u x in chi_(id_1)$, say $chi_u x = chi_(id_1) y$ for some $y : Gamma -> 1$. again, by naturality, $chi_(x^(-1)(u)) = chi_u x = chi_(id_1) y = chi_(id_Gamma)$, therefore $x^(-1)(u) tilde.op id_Gamma$.

We should give the universal subobject a new name $"true" : 1 arrow.r.hook Omega, "ture" := chi_(id_1)$ then $"true" tilde.op t in Sub(Omega)$. it can be understand as a global element of $Omega$. so it also correspond to a collection of morphism $"true"_A : A -> Omega$ (in fact, $"true"_A = chi_(id_A), "true"_1 = "true"$) which is invariant under context substitution: $"true"_Gamma = "true"_Delta sigma$ for all $sigma : Delta -> Gamma$ and so

$ "true"_A = "true" !_A $

for all object $A$.

Finally, rewrite above results, we have

$ x in u <=> chi_u x = "true" !_Gamma $

for all subobject $u in Sub(A)$ and generalized element $x$ of $A$. Equivalently, the following

#cd($
  U edge(!_U, ->) edge("d", u, ->, label-side: #right) & 1 edge("d", op("true"), "hook->", label-side: #left) \
  A edge(chi_u, ->, label-side: #right) & Omega
$)

is a pullback square, for all subobject $u in Sub(A)$.
