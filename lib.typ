#let dateformat = "[day].[month].[year]"
#let language = "en"
#let fsize = 11pt
#let columnsnr = 1
#let author = "Georgiy Chirokikh Shevoroshkin"
#let title = "Proposal for changing the OST Auth solution"
#let font = (
  font: "Arimo Nerd Font", lang: language, region: "ch", size: fsize, fill: rgb("000000"),
)
#let languages = (
  de: (
    page: "Seite", chapter: "Kapitel", toc: "Inhaltsverzeichnis", term: "Begriff", definition: "Bedeutung", summary: "Zusammenfassung",
  ), en: (
    page: "Page", chapter: "Chapter", toc: "Contents", term: "Term", definition: "Definition", summary: "Summary",
  ),
)
#let infoblock(title, ..content) = [
  #assert(
    title != none and title != "", message: "Sorry, Block title is required.",
  )
  #grid(
    columns: (20%, auto), column-gutter: 1.25em, row-gutter: 0.2em, align: (left + top, left + top), [#align(left)[ #text(weight: "bold", size: 11pt)[#title] ]], [#content.pos().join([\ \ ])],
  )
  #v(0.5em)
]

#set columns(columnsnr, gutter: 2em)
#set text(..font)
#set enum(numbering: "1.a)")
#set table.cell(breakable: false)
#set table(
  stroke: (x, y) => (left: if x > 0 { 0.07em }, top: if y > 0 { 0.07em }), inset: 0.5em,
)
#set quote(block: true, quotes: true)
#set outline(indent: 0em)

#set outline(indent: auto)
#set par(justify: true)
