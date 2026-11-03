#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "outline",
  date: "2026-11-03",
  author: "Justin",
))

intro

- somehow you are interesting in topos and so subobject classifier
- definition of subobject classifier in wiki

define subobject

- factor through
- equivalence relation

example

- greatest subobject $id_A : A arrow.r.hook A$
- diagonal embedding $Delta_A := chevron.l id_A, id_A chevron.r : A arrow.r.hook A times A$
- intersection: pullback of $U arrow.r.hook A$ and $V arrow.r.hook A$.

define subobject functor

- pullback well defined
- smallness

greatest subobject as natural transformation ${*} -> Sub$

- pullback of identity
- naturality: essentially, there are only one construction
- in the presence of terminal object, a uniform choice of subobjects ↔ a subobject of $1$
- Yoneda lemma: find the essential one construction, universal element $id_1 : 1 arrow.r.hook 1$

define subobject classifier

- representable functor: internalisation
- indicator function, unpack naturality
- Yoneda lemma: find the essential one construction
- compute the inclusion map of the universal subobject $T arrow.r.hook Omega$

translate the greatest subobject

- as natural transformation ${*} -> hom(-, Omega)$ or as universal element $1 -> Omega$.
- prove $T arrow.r.hook Omega$ and $1 arrow.r.hook Omega$ are the same subobject, back to wiki definition.

outro

- naturally: uniform construction
- representable functor: internalize natural transformation as morphism
- exercise: prove uniform construction of diagonal embedding is NOT natural transformation !!! and prove $x = y$ iff $eq_A chevron.l x, y chevron.r = "true"_Gamma$, it internalize the equality of morphisom.
- exercise: write the uniform construction of intersection as natural transformation $Sub times Sub -> Sub$ and as a universal element $and : Omega times Omega -> Omega$, and prove that $and chevron.l p, q chevron.r = "true"_Gamma$ iff $p = "true"_Gamma$ and $q = "true"_Gamma$, it internalize the logic "and".
