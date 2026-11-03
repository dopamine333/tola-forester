#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "Subobjects",
  date: "2026-11-03",
  author: "Justin",
))

To generalize subsets, we should look at #tree-link("jc-000X")[monomorphisms] $i : U arrow.r.hook A$. In the notation of generalized elements, the condition for $i : U arrow.r.hook A$ to be a #tree-link("jc-000X")[monomorphism] is: for all generalized elements $x, y$ of $U$ with the same context, if $i x = i y$ then $x = y$ (notice that $i x$ and $i y$ are generalized elements of $A$). So postcomposition with $i$ can be seen as an inclusion of the generalized elements of $U$ into those of $A$.

We can recover the notions of an element lying in a subset, of the inclusion relation between two subsets, and of when two subsets are considered equal.

#transclude("jc-0008")

Notice that such a $phi$ is unique: if we have $phi, psi : Gamma -> U$ with $x = u phi$ and $x = u psi$, then $u phi = u psi$ implies $phi = psi$ by the #tree-link("jc-000X")[monicity] of $u$. So it is appropriate that the notation $x in u$ does not mention $phi$.

#transclude("jc-0009")

The following exercise shows that the definition of $u <= v$ behaves as we expect and matches the definition on the nLab.

#transclude("jc-000A")

We close this section by giving the definition of the *_subobjects_* of an object $A$.

#transclude("jc-000B")
