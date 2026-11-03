#!/usr/bin/env nu
# Scaffold a new tree, like `forester new`.
#
# Creates content/<prefix>-XXXX.typ (or content/<dir>/<prefix>-XXXX.typ), where
# XXXX is the next free base-36 number for the prefix (0001, …, 0009, 000A, …),
# scanned from the file names under content/. As in Forester, the file name is
# the tree's address and its URL: jc-000A.typ publishes at /jc-000A/; folders
# only organize files.
#
# Examples:
#   nu scripts/new-tree.nu "Embedding"
#   nu scripts/new-tree.nu "Functor" -x definition -a jc-0001
#   nu scripts/new-tree.nu "Jon Sterling" -n jonmsterling -x person
#   nu scripts/new-tree.nu "Forester" -x reference -d refs

const DIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"

def to-base36 [n: int] {
  mut n = $n
  mut out = ""
  while $n > 0 {
    $out = ($DIGITS | str substring ($n mod 36)..($n mod 36)) + $out
    $n = $n // 36
  }
  $out | fill --alignment right --character '0' --width 4
}

def from-base36 [s: string] {
  $s | split chars | reduce --fold 0 {|c, n| $n * 36 + ($DIGITS | str index-of $c) }
}

def main [
  title: string                 # Tree title (required)
  --prefix (-p): string = "jc"  # Address prefix: <prefix>-0001, <prefix>-0002, …
  --name (-n): string = ""      # Use this address instead of the next numbered one
  --taxon (-x): string = ""     # Kind of tree: definition, theorem, person, reference, …
  --dir (-d): string = ""       # Sub-folder under content/ (organization only)
  --author (-a): string = ""    # Comma-separated authors: tree addresses or names
] {
  if ($prefix !~ '^[a-z0-9]+$') {
    error make { msg: $"Prefix must be lowercase letters and digits: '($prefix)'" }
  }
  let root = ($env.FILE_PWD | path dirname)
  let content = $"($root)/content"

  let existing = (glob $"($content)/**/*.typ" | each { |f| $f | path parse | get stem })
  let addr = if ($name | is-empty) {
    let last = (
      $existing
      | each { |s| $s | parse --regex ('^' + $prefix + '-(?<n>[0-9A-Z]{4})$') }
      | flatten
      | each { |r| from-base36 $r.n }
      | append 0 | math max
    )
    $"($prefix)-(to-base36 ($last + 1))"
  } else { $name }
  if $addr in $existing {
    error make { msg: $"A tree with the address '($addr)' already exists." }
  }

  let dir = if ($dir | is-empty) { $content } else { $"($content)/($dir)" }
  let file = $"($dir)/($addr).typ"

  # Typst value for a list of strings: "a" / ("a", "b")
  let authors = ($author | split row ',' | each { |a| $a | str trim } | where { |a| $a != "" })
  let today = (date now | format date "%Y-%m-%d")

  mut lines = [
    '#import "@tola/source:0.0.0": tola-meta'
    '#import "/templates/tree.typ": transclude, tree-link'
    ''
    '#tola-meta(('
    ('  title: "' + $title + '",')
  ]
  if not ($taxon | is-empty) {
    $lines = ($lines | append ('  taxon: "' + $taxon + '",'))
  }
  $lines = ($lines | append ('  date: "' + $today + '",'))
  if ($authors | length) == 1 {
    $lines = ($lines | append ('  author: "' + ($authors | first) + '",'))
  } else if ($authors | length) > 1 {
    $lines = ($lines | append ('  author: (' + ($authors | each { |a| '"' + $a + '"' } | str join ', ') + '),'))
  }
  $lines = ($lines | append [
    '))'
    ''
    '// Link a tree with #tree-link("<addr>"), embed one with #transclude("<addr>").'
  ])

  mkdir $dir
  ($lines | str join "\n") + "\n" | save $file
  print $"Created ($file)"
  print $"        will publish at /($addr)/"
}
