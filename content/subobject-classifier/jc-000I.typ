#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  taxon: "Key Exercise",
  date: "2026-11-03",
  author: "Justin",
))

Assume pullbacks exist, and let $u$ be a subobject of $A$. Show that $x in u$ iff $x^(-1)(u) tilde.op id_Gamma$ for every generalized element $x : Gamma -> A$ of $A$. This says that every proposition like $x in u$ can be written as an equality of subobjects. Using the diagonal embedding above ($x = y$ iff $chevron.l x, y chevron.r in Delta_A$), the primitive predicates of the language become equalities of subobjects!
