#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link
#import "/lib/macros.typ": *

#tola-meta((
  title: "generalized element",
  taxon: "Definition",
  date: "2026-11-03",
  author: "Justin",
))

Let $cal(C)$ be a category and $A$ an object of $cal(C)$. A generalized element of $A$ is a morphism into $A$

$ x : Gamma -> A $

where $Gamma$, the source of $x$, is called the context of $x$. In the case where $cal(C)$ has a terminal object $1$ and the context of $x$ is $1$, $x$ is called a global element of $A$.
