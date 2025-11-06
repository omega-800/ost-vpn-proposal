#let author = "Georgiy Chirokikh Shevoroshkin"
#let date = datetime.today().display("[day].[month].[year]")
#let language = "en"
#let fsize = 11pt
#let hsize = 16pt
#let columnsnr = 1
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
#let supporter = (name, email) => ([#name], [#link("mailto:" + email)])
#let link-underline = luma(30)
#let link-background = rgb("#fafafa")

#let glossary-entry(name, description) = {
  figure([
    #grid(columns: (3fr, 8fr), gutter: 5mm, [
      #align(left, text(size: 12pt, [*#name*]))
    ], align(left, description))
    #line(length: 100%, stroke: 0.5pt + rgb("#c4c4c4"))
  ], kind: "glossary-entry", supplement: name)
}
#let glossary = (
  OSS: ( desc: [Open Source Software], link: <oss>),
  OER:(desc: [ Open Educational Resources ],link: <oer>),
  OTP:(desc: [ One Time Password ],link: <otp>),
  FOSS:(desc: [ Free and Open Source Software ],link: <foss>),
  SSO:(desc: [ Single Sign-On ],link: <sso>),
  SAMLv2:(desc: [ Security Assertion Markup Language 2.0 ],link: <saml>),
  SSL:(desc: [ Secure Sockets Layer ],link: <ssl>),
  VPN:(desc: [ Virtual Private Network ],link: <vpn>),
  EntraID:(desc: [ Microsoft Entra ID (formerly known as Microsoft Azure Active Directory or Azure AD) ],link: <entraid>),
  IAM:(desc: [ Identity and Access Management ],link: <iam>),
  IT:(desc: [ Information Technology ],link: <it>),
)
#let g = (k) => link(glossary.at(k).link, k)
#let outline-glossary = () => glossary.pairs().map(((k,v)) => 
  [#glossary-entry(k, v.desc) #v.link]
).join()

#let project(title: "", body) = {
 let subtitle = "Striving for a more open educational environment"
  show table.cell.where(y: 0): emph
  show math.equation: set text(font: "Fira Math")
  show raw: set text(font: "Fira Code")
  show heading.where(level: 1): it => {
    text(hsize, weight: "bold", top-edge: 5mm, it.body)
  }

  show link: it => {
    highlight([
      #set text(weight: 500)
      #underline(offset: 0.7mm, stroke: link-underline, it)
    ], fill: link-background)
  }
  show ref: it => {
    highlight([
      #set text(weight: 500)
      #underline(offset: 0.7mm, stroke: link-underline, it)
    ], fill: link-background)
  }
  set columns(columnsnr, gutter: 2em)
  set text(..font)
  set enum(numbering: "1.a)")
  set quote(block: true, quotes: true)
  set par(justify: true)
  set document(author: author, title: title, date: datetime.today())
  set page(flipped: false, columns: 1, margin: 2cm)
  set table.cell(breakable: false)
  set table(
    stroke: (x, y) => (left: if x > 0 { 0.07em }, top: if y > 0 { 0.07em }), inset: 0.5em, gutter: auto, fill: none,
  )

  place(
    top + left, dx: -35mm, dy: 5mm, image("resources/Background.png", width: 245mm, height: auto, fit: "cover"),
  )
  place(
    top + left, dx: -20mm, dy: -40mm, image("resources/Overlay.png", width: 210mm, height: 300mm, fit: "cover"),
  )
  place(
    bottom + right, dy: 0mm, table(
      stroke: none, align: left, columns: 50%, text(weight: "bold", 24pt, title), text(hsize, subtitle), v(0.5em), text("Author"), text(12pt, author), v(0.5em), text("Contributors"), text(12pt, "Fynn Gächter, Marco Kuoni, Ramon Bister"),
    ),
  )

  set page(
    flipped: false, columns: 1, margin: (top: 2.5cm, left: 1.5cm, right: 1.5cm, bottom: 1.5cm), footer: context[
      #set text(font: font.font, size: 0.9em)
      #table(
        columns: (1fr, auto, 1fr), stroke: none, inset: 0mm, [#title], [ #languages.at(language).page #counter(page).display() ], [ #set align(right)
          #date ],
      )
    ], header: context[
      #set text(font: font.font, size: 0.9em)
      #author
    ], foreground: context[
      #place(
        top + right, dx: -15mm, dy: 6mm, image("resources/OST-Logo.png", width: auto, height: 15mm, fit: "cover"),
      )
    ],
  )
  pagebreak()
  text("Outline", weight: "bold", size: hsize)
  v(1em)
  outline(title: none, indent: auto)
  pagebreak()

  set par(justify: true)
  body

  pagebreak()

  [= Supporters

    Many thanks go out to all of the honorable supporters of this project, which
    include]

  figure(
    table(
      columns: (1fr, 1fr), table.header([*Name*], [*Email*]), 
      ..supporter("Carina Schmitt", "carina.schmitt@ost.ch"), 
      ..supporter("Claude Bregenzer", "claude.bregenzer@ost.ch"), 
      ..supporter("Edoardo Balsamo", "edoardo.balsamo@ost.ch"), 
      ..supporter("Elia Schenker", "elia.schenker@ost.ch"), 
      ..supporter("Florian Bruhin", "florian.bruhin@ost.ch"), 
      ..supporter("Fynn Gächter", "fynn.gaechter@ost.ch"), 
      ..supporter("Gioele Petrillo", "gioele.petrillo@ost.ch"), 
      ..supporter("Giuliano Gianola", "giuliano.gianola@ost.ch"), 
      ..supporter("Jasmin Fässler", "jasmin.faessler@ost.ch"), 
      ..supporter("Lukas Hunziker", "lukas.hunziker@ost.ch"), 
      ..supporter("Marco Kuoni", "marco.kuoni@ost.ch"), 
      ..supporter("Nathanael Fässler", "nathanael.faessler@ost.ch"), 
      ..supporter("Nico Michael Rudolph", "nico.rudolph@ost.ch"), 
      ..supporter("Oliver Clerc", "oliver.clerc@ost.ch"), 
      ..supporter("Ramon Bister", "ramon.bister@ost.ch"),
      ..supporter("Raphael Das Gupta", "raphael.dasgupta@ost.ch"), 
      ..supporter("Samuel Meuli", "samuel.meuli@ost.ch"), 
      ..supporter("Simon Böni", "simon.boeni@ost.ch"), 
      ..supporter("Stefan F. Keller", "stefan.keller@ost.ch"), 
      ..supporter("Yannick Ott", "yannick.ott@ost.ch"),
    ), caption: "Supporters",
  )

  pagebreak()

  [= Glossary]

  outline-glossary()

  pagebreak()

  bibliography("citations.bib")

  pagebreak()

  [= Illustrations]

  outline(title: none, target: figure.where(kind: image))

  [= Tables]

  outline(title: none, target: figure.where(kind: table))
}
