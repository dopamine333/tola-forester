#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Example",
  date: "2026-11-03",
  author: "Justin",
))

assume the category has pullback. Let u : U → A, v: V → A be a subobject of A. a subobject w of A is a intersection of u and v if x ∈ w iff x ∈ u and x ∈ v. if a intersection exist, and it is unique and well-defined. consider the pullback of v along u:

#cd($
  u^(-1)(V) edge(u|_v, "hook->") edge("d", u^(-1)(v), "hook->", label-side: #right) & V edge("d", v, "hook->", label-side: #left) \
  U edge(u, "hook->", label-side: #right) & A
$)

then the subobject of A defined by the composition $u^(-1)(V) attach(arrow.r.hook, t: u^(-1)(v)) U attach(arrow.r.hook, t: u) A$ is the intersection of u and v, denote by $u inter v$.
