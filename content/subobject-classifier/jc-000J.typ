#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Example",
  date: "2026-11-03",
  author: "Justin",
))

Assume the category has pullbacks. Let $u : U arrow.r.hook A$ and $v : V arrow.r.hook A$ be subobjects of $A$. A subobject $w$ of $A$ is an intersection of $u$ and $v$ if $x in w$ iff $x in u$ and $x in v$. An intersection, if it exists, is unique and well defined. Consider the pullback of $v$ along $u$:

#cd($
  u^(-1)(V) edge(u|_v, "hook->") edge("d", u^(-1)(v), "hook->", label-side: #right) & V edge("d", v, "hook->", label-side: #left) \
  U edge(u, "hook->", label-side: #right) & A
$)

Then the subobject of $A$ given by the composite $u^(-1)(V) attach(arrow.r.hook, t: u^(-1)(v)) U attach(arrow.r.hook, t: u) A$ is the intersection of $u$ and $v$, denoted by $u inter v$.
