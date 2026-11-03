#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "subobject",
  date: "2026-11-03",
  author: "Justin",
))

For the generalization of a subset, we should look about a monomorphism $i : U arrow.r.hook A$. in the notation of generalized element, the condition of $i : U arrow.r.hook A$ being a monomorphism is: for all generalized element x, y of U with the same context, if ix = iy then x = y (notice ix, iy is a generalized element of A) . so the postcomposition by i can be seen as a inclusion from the generalized element of U to it of A.

we can recover the notation of a element lying a subset, the inclusion relation between two subset and when two subset are consider equal.

#transclude("jc-0008")

notice such φ is unique since if we have φ, ψ : Γ → U with x = u φ and x = u ψ then u φ = u ψ implies φ = ψ by the monoticity of u. so the notation x ∈ u do not mention about φ is appropriate.

#transclude("jc-0009")

the following exercise make should the definition of $u <= v$ has behaviour we expected and match the definition of in nlab.

#transclude("jc-000A")

we should closed this section by given the definition of the *_subobjects_* of an object A.

#transclude("jc-000B")
