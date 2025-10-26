#let dateformat = "[day].[month].[year]"
#let language = "en"
#let fsize = 11pt
#let columnsnr = 1
#let author = "Georgiy Shevoroshkin"
#let title = "Template"
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

#set document(author: author, title: title, date: datetime.today())
#set page(flipped: false, columns: columnsnr, margin: if (columnsnr < 2) {
  (top: 2cm, left: 1.5cm, right: 1.5cm, bottom: 2cm)
} else {
  0.5cm
}, footer: context[
  #set text(font: font.font, size: 0.9em)
  #title
  #h(1fr)
  #languages.at(language).page #counter(page).display()
], header: context[
  #set text(font: font.font, size: 0.9em)
  #author
  #h(1fr)
  #datetime.today().display(dateformat)
])
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
