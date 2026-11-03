#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "Outro",
  date: "2026-11-03",
  author: "Justin",
))

- Naturality: uniform constructions.
- Representable functors: internalizing natural transformations as morphisms.
- Exercise: prove that the uniform construction of the diagonal embedding is NOT a natural transformation (!!!), and prove that $x = y$ iff $eq_A chevron.l x, y chevron.r = "true"_Gamma$; this internalizes the equality of morphisms.
- Exercise: write the uniform construction of intersection as a natural transformation $Sub times Sub -> Sub$ and as a universal element $and : Omega times Omega -> Omega$, and prove that $and chevron.l p, q chevron.r = "true"_Gamma$ iff $p = "true"_Gamma$ and $q = "true"_Gamma$; this internalizes the logical "and".

...

#transclude("jc-000V")
#transclude("jc-000W")
