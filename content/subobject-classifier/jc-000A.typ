#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Exercise",
  date: "2026-11-03",
  author: "Justin",
))

+ $u <= v$ iff $u$ factors through $v$.
+ The relation $<=$ on #tree-link("jc-000X")[monomorphisms] into $A$ is a preorder.
+ The relation $tilde.op$ is an equivalence relation on #tree-link("jc-000X")[monomorphisms] into $A$.
+ $x in u$ and $u <= v$ are well defined with respect to the equivalence relation $tilde.op$; that is, if $u tilde.op u'$ then $x in u$ iff $x in u'$, and if $u tilde.op u'$ and $v tilde.op v'$ then $u <= v$ iff $u' <= v'$.
