#import "@tola/source:0.0.0": tola-meta
#import "/templates/tree.typ": transclude, tree-link

#tola-meta((
  title: "Intro",
  date: "2026-11-03",
  author: "Justin",
))

The subobject classifier seems to be very important for defining a topos, although I don't know what a topos is. In the process of understanding the definition of the subobject classifier, I think I gained more experience in playing around with representable functors, the Yoneda lemma, and natural transformations.

This post will introduce some concepts related to subobjects in a general category, and show how the subobject classifier *_internalizes_* these ideas. Many categorical definitions involving representable functors seem to be trying to internalize some external structure of the category; we will see more precise examples of this.
