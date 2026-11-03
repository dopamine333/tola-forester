#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "Outline",
  date: "2026-11-03",
  author: "Justin",
))

Intro

- Somehow you are interested in topoi, and so in the subobject classifier.
- The definition of the subobject classifier on Wikipedia.

Defining subobjects

- Factoring through.
- The equivalence relation.

Examples

- The greatest subobject $id_A : A arrow.r.hook A$.
- The diagonal embedding $Delta_A := chevron.l id_A, id_A chevron.r : A arrow.r.hook A times A$.
- Intersection: the pullback of $U arrow.r.hook A$ and $V arrow.r.hook A$.

Defining the subobject functor

- Pullbacks are well defined.
- Smallness.

The greatest subobject as a natural transformation ${*} -> Sub$

- The pullback of the identity.
- Naturality: essentially, there is only one construction.
- In the presence of a terminal object, a uniform choice of subobjects corresponds to a subobject of $1$.
- The Yoneda lemma: find the one essential construction, the universal element $id_1 : 1 arrow.r.hook 1$.

Defining the subobject classifier

- Representable functors: internalization.
- Indicator functions; unpacking naturality.
- The Yoneda lemma: find the one essential construction.
- Compute the inclusion map of the universal subobject $T arrow.r.hook Omega$.

Translating the greatest subobject

- As a natural transformation ${*} -> hom(-, Omega)$, or as a universal element $1 -> Omega$.
- Prove that $T arrow.r.hook Omega$ and $1 arrow.r.hook Omega$ are the same subobject, getting back to the Wikipedia definition.

Outro

- Naturality: uniform constructions.
- Representable functors: internalizing natural transformations as morphisms.
- Exercise: prove that the uniform construction of the diagonal embedding is NOT a natural transformation (!!!), and prove that $x = y$ iff $eq_A chevron.l x, y chevron.r = "true"_Gamma$; this internalizes the equality of morphisms.
- Exercise: write the uniform construction of intersection as a natural transformation $Sub times Sub -> Sub$ and as a universal element $and : Omega times Omega -> Omega$, and prove that $and chevron.l p, q chevron.r = "true"_Gamma$ iff $p = "true"_Gamma$ and $q = "true"_Gamma$; this internalizes the logical "and".
