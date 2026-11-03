// lib/macros.typ — notation shared by the trees, like a Forester macros tree.
// It lives outside content/, so it is not itself a tree.
#import "@preview/fletcher:0.5.8": diagram, edge, node

#let id = math.op("id")
#let Sub = math.op("Sub")
#let hom = math.op("hom")
#let Psh = math.op("Psh")
#let Set = math.op("Set")
#let eq = math.op("eq")

/// The constant singleton functor, underlined. Typst's MathML export drops
/// `underline`, so the bar is a border on a MathML <mrow>.
#let pt = html.elem("mrow", attrs: (style: "border-bottom: 0.06em solid currentColor"), ${*}$)

/// A commutative diagram (fletcher), centred, as inline SVG — where Forester
/// would render a LaTeX diagram.
#let cd(..args) = html.div(
  style: "display: flex; justify-content: center; margin: 0.5em 0 1em",
  html.frame(diagram(spacing: (2.5em, 2.2em), ..args)),
)
