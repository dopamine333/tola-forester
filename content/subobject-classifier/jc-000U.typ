#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "outro",
  date: "2026-11-03",
  author: "Justin",
))

- naturally: uniform construction
- representable functor: internalize natural transformation as morphism
- exercise: prove uniform construction of diagonal embedding is NOT natural transformation !!! and prove $x = y$ iff $eq_A chevron.l x, y chevron.r = "true"_Gamma$, it internalize the equality of morphisom.
- exercise: write the uniform construction of intersection as natural transformation $Sub times Sub -> Sub$ and as a universal element $and : Omega times Omega -> Omega$, and prove that $and chevron.l p, q chevron.r = "true"_Gamma$ iff $p = "true"_Gamma$ and $q = "true"_Gamma$, it internalize the logic "and".

...

#transclude("jc-000V")
#transclude("jc-000W")
