#import "./lib.typ": *

#let supporter = (name, email) => ([#name],[#link("mailto:"+email)])
#show table.cell.where(y: 0): emph
#show math.equation: set text(font: "Fira Math")
#show raw: set text(font: "Fira Code")
#let link-underline = luma(30)
#let link-background = rgb("#fafafa")
#let hsize = 16pt
#show heading.where(level: 1): it => {
  text(hsize, weight: "bold", top-edge: 1mm, it.body)
}

#show link: it => {
  highlight([
    #set text(weight: 500)
    #underline(offset: 0.7mm, stroke: link-underline, it)
  ], fill: link-background)
}
#show ref: it => {
  highlight([
    #set text(weight: 500)
    #underline(offset: 0.7mm, stroke: link-underline, it)
  ], fill: link-background)
}
#set table(
  stroke: (x, y) => (
  left: if x > 0 { 0.07em },
  top: if y > 0 { 0.07em },
),
  inset: 0.5em,
  gutter: auto,
  fill: none,
)

#set document(author: author, title: title, date: datetime.today())
#set page(flipped: false, columns: 1, margin: 2cm)

#place(
  top + left, dx: -35mm, dy: 5mm, image("resources/Background.png", width: 245mm, height: auto, fit: "cover"),
)
#place(
  top + left, dx: -20mm, dy: -40mm, image("resources/Overlay.png", width: 210mm, height: 300mm, fit: "cover"),
)
#place(
  bottom + right, dy: 0mm, table(
    stroke: none, align: left, columns: 50%, 
    text(weight: "bold", 24pt, title), 
    text(hsize, "Striving for a more open educational environment"), 
    v(0.5em), 
    text("Authors"), 
    text(12pt, author), 
    v(0.5em), 
    text("Contributors"), 
    text(12pt, "Fynn Gächter, Marco Kuoni"), 
  ),
)

#set page(
  flipped: false, columns: 1, 
  margin: (top: 2.5cm, left: 1.5cm, right: 1.5cm, bottom: 1.5cm), footer: context[
    #set text(font: font.font, size: 0.9em)
    #table(
      columns: (1fr, auto, 1fr),
      stroke: none,
      inset: 0mm,
      [#title],
      [ #languages.at(language).page #counter(page).display() ],
      [ #set align(right) 
      #datetime.today().display("[day].[month].[year]")]
    ,
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
#pagebreak()
#text("Outline", weight: "bold", size: hsize)
#v(1em)
#outline(title: none, indent: auto)
#pagebreak()

= Context

The OST-VPN Solution currently relies on @azuread (@saml) authentication for
Cisco SSL-VPN. Users can connect to the @vpn through the recommended cisco
secure client @ostauthvpn or any compatible client supporting the AnyConnect
protocol, such as openconnect @openconnect. Azure AD, developed by Microsoft,
facilitates integration with the broader Microsoft ecosystem.

= Argumentation

Universities can play an exemplary role by using and contributing to FOSS
through advisory, analytical, and evaluative activities. They possess unique
forms of expertise and a degree of independence that can add significant value.
These activities can indeed foster learning and improvement in the spirit of the
Humboldtian educational ideal. Collaboration with the wider FOSS community is
essential to ensure genuine openness, mutual learning, and innovation. In
addition, sovereignty, data security, and inclusion should be key priorities.
Educational institutions are key in providing information in a neutral and
non-discriminatory manner, thereby establishing a standart for @oer, open
research and the free exchange of information @BOSB. This responsibility can
only be fulfilled when accessibility for all is guaranteed through the
implementation of @foss @Hartwagner.

While the management of services via Azure AD may offer conveniences, the
reliance on a multi-trillion-dollar corporation's closed-source software
presents a multitude of risks and worries particularily in, but not limited to,
educational and research contexts. These risks encompass:

- Vendor Lock-In: Dependency on proprietary platforms limits flexibility and
  adaptability. @kelch
- Incompatibility with Legacy Hardware: Potential exclusion of users employing
  older technologies. @bildungdigital
- Security Concerns: Heightened risks associated with centralized control and data
  management. @BandyopadhyayICT
- Licensing Costs: Ongoing fees may strain institutional budgets and resources.
  @BandyopadhyayICT @BOSB
- Ethical Considerations: Dependence on commercial entities raises questions about
  corporate governance in educational settings. @Pudelko2023

Moreover, the monopolistic behavior and tracking practices associated with
global corporations, in this case Microsoft, pose significant risks to security
@mssc, privacy @mscp and democratic ideals @msfs. Past incidents have
highlighted the potential ramifications of these behaviors in both individual
and institutional contexts.

Fortunately, for client authentication, the Microsoft Authenticator app is not
required, though it is recommended @ostauthvpn. The flexibility enables the use
of provider- and device-agnostic @otp software, promoting inclusivity for
individuals who choose FOSS out of ethical or personal reasons. However, several
aspects of the current OST infrastructure still restrict this possibility,
notably in areas such as email and VPN authentication.

= Proposal

Transitioning the entire Microsoft-based ecosystem at OST University to a fully
open-source model is undoubtedly a monumental undertaking. However, introducing
the capability to connect to the VPN through alternative methods beyond AzureAD
would represent a significant first step in the right direction. This change
would support inclusivity and align with the institution's commitment to
openness and accessibility.

By integrating additional authentication options, one can reduce dependency on
proprietary technologies and mitigate the associated risks. This effort not only
promotes ethical practices but also empowers users to engage with the services
in a manner that respects their preferences and needs.

#pagebreak()

= Supporters

Many thanks go out to all of the honorable supporters of this Project, which include

#figure(
  table(columns:(auto,1fr),
    table.header([*Name*], [*Email*]),
    ..supporter("Fynn Gächter", "fynn.gaechter@ost.ch"),
    ..supporter("Marco Kuoni", "marco.kuoni@ost.ch"),
    ..supporter("Oliver Clerc", "oliver.clerc@ost.ch"),
    ..supporter("Giuliano Gianola", "giuliano.gianola@ost.ch"),
    ..supporter("Lukas Hunziker", "lukas.hunziker@ost.ch"),
    ..supporter("Jasmin Fässler", "jasmin.faessler@ost.ch"),
    ..supporter("Edoardo Balsamo", "edoardo.balsamo@ost.ch"),
    ..supporter("Nico Michael Rudolph", "nico.rudolph@ost.ch"),
  ), 
  caption: "Supporters"
)


#pagebreak()

#bibliography("citations.bib")

#pagebreak()

= Glossary

#let glossary_entry(name, description) = {
  figure([
    #grid(columns: (3fr, 8fr), gutter: 5mm, [
      #align(left, text(size: 12pt, [*#name*]))
    ], align(left, description))
    #line(length: 100%, stroke: 0.5pt + rgb("#c4c4c4"))
  ], kind: "glossary_entry", supplement: name)
}

#let outline_glossary() = [
  #glossary_entry("OSS", [
    Open Source Software
  ]) <oss>
  #glossary_entry("OER", [
    Open Educational Resources
  ]) <oer>
  #glossary_entry("OTP", [
    One Time Password
  ]) <otp>
  #glossary_entry("FOSS", [
    Free and Open Source Software
  ]) <foss>
  #glossary_entry("SSO", [
    Single Sign-On
  ]) <sso>
  #glossary_entry("SAMLv2", [
    Security Assertion Markup Language 2.0
  ]) <saml>
  #glossary_entry("SSL", [
    Secure Sockets Layer
  ]) <ssl>
  #glossary_entry("VPN", [
    Virtual Private Network
  ]) <vpn>
  #glossary_entry("Azure AD", [
    Azure Active Directory
  ]) <azuread>
]
#outline_glossary()

#pagebreak()

= Tables

#outline(title: none, target: figure.where(kind: table))

#pagebreak()
