#import "./lib.typ": *

#let supporter = (name, email) => ([#name], [#link("mailto:" + email)])
#show table.cell.where(y: 0): emph
#show math.equation: set text(font: "Fira Math")
#show raw: set text(font: "Fira Code")
#let link-underline = luma(30)
#let link-background = rgb("#fafafa")
#let hsize = 16pt
#show heading.where(level: 1): it => {
  text(hsize, weight: "bold", top-edge: 5mm, it.body)
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
  stroke: (x, y) => (left: if x > 0 { 0.07em }, top: if y > 0 { 0.07em }), inset: 0.5em, gutter: auto, fill: none,
)

#set document(author: author, title: title, date: datetime.today())
#set page(flipped: false, columns: 1, margin: 2cm)
#set par(justify: true)

#place(
  top + left, dx: -35mm, dy: 5mm, image("resources/Background.png", width: 245mm, height: auto, fit: "cover"),
)
#place(
  top + left, dx: -20mm, dy: -40mm, image("resources/Overlay.png", width: 210mm, height: 300mm, fit: "cover"),
)
#place(
  bottom + right, dy: 0mm, table(
    stroke: none, align: left, columns: 50%, text(weight: "bold", 24pt, title), text(hsize, "Striving for a more open educational environment"), v(0.5em), text("Author"), text(12pt, author), v(0.5em), text("Contributors"), text(12pt, "Fynn Gächter, Marco Kuoni, Ramon Bister"),
  ),
)

#set page(
  flipped: false, columns: 1, margin: (top: 2.5cm, left: 1.5cm, right: 1.5cm, bottom: 1.5cm), footer: context[
    #set text(font: font.font, size: 0.9em)
    #table(
      columns: (1fr, auto, 1fr), stroke: none, inset: 0mm, [#title], [ #languages.at(language).page #counter(page).display() ], [ #set align(right)
        #datetime.today().display("[day].[month].[year]") ],
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

The OST-VPN Solution currently relies on @entraid (@saml) authentication for
services such as the
#link("https://wiki.ost.ch", "Confluence wiki"),
#link("https://unterricht.ost.ch", "\"Unterricht\" webservice") and Cisco
SSL-VPN. Users can connect to the @vpn through the recommended cisco secure
client @ostauthvpn or any compatible client supporting the AnyConnect protocol,
such as openconnect @openconnect. EntraID, developed by Microsoft, provides
identity management and facilitates integration with the broader Microsoft
ecosystem.

= Argumentation

Universities can play an exemplary role by using and contributing to @foss
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
implementation of FOSS @Hartwagner.

While the management of identities via EntraID may offer conveniences, the
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
and institutional contexts. Through the usage of EntraID the administrators are
forced to supply each student with a Microsoft account, thus contributing to the
data harvest and monopoly position of the corporation.

The adoption of on-premise and open-source software solutions ensures the
sovereignty and security of end-user data. Users are more likely to develop
advanced technical skills and engage in collaborative learning, as well as a
heightened awareness of ethical software practices and responsible @it
behaviors. Moreover, the organizing body gains comprehensive control over its
data and infrastructure, enabling the development of tailored solutions. This
approach enhances risk management and fosters an environment of active
development, ultimately benefiting the broader open-source ecosystem and the
solutions built upon it @BOSB.

To showcase a positive example, the Microsoft Authenticator app is not required
for client authentication, though it is recommended @ostauthvpn. This
flexibility enables the use of provider- and device-agnostic @otp software,
promoting inclusivity for individuals who choose FOSS out of ethical or personal
reasons. However, several aspects of the current OST infrastructure still
restrict this possibility, notably in areas such as email and authentication. By
integrating additional authentication options, one can reduce dependency on
proprietary technologies and mitigate the associated risks. This effort not only
promotes ethical practices but also empowers users to engage with the services
in a manner that respects their preferences and needs.

#pagebreak()

= Proposal

Transitioning the entire Microsoft-based ecosystem at OST University to a fully
open-source model is undoubtedly a monumental undertaking. However, introducing
the capability to connect to services like the VPN or wiki through alternative
authentication methods beyond EntraID @sso would represent a significant first
step in the right direction. This change would align with the institution's
commitment to openness and accessibility and create a path for an independent
and inclusive future.

As an initial step, it is feasible to implement authorization through
open-source access management solutions such as Keycloak @keycloak in
conjunction with OpenID Connect @openid (based on OAuth 2.0 @OAuthRFC) without
altering the existing identity infrastructure. This integration has already been
successfully executed in the #link("https://lab.network.garden", "Network Garden Lab environment").
A depiction of the user accessing a service using this method is illustrated in
@fig1.

#figure(
  image("keycloak_auth_diagram.png"), caption: "Service access and auth process",
) <fig1>

Although alternative open-source @iam projects like Shibboleth @shibboleth or
Gluu @gluu exist, Keycloak provides an all-in-one solution, proving to be
versatile enough for large organizations with complex access management schemes.
Furthermore, the knowledge gained from implementing keycloak in the
aforementioned Lab environment can be leveraged in creating an overarching and
standardized auth solution for the multitude of services which OST provides.

= Future considerations

Once the services requiring authentication and authorization are configured to
utilize an open source IAM framework like Keycloak, the full identity
management process can be more easily taken over from EntraID by said framework.
Further steps would include data migration, policy configuration, testing,
monitoring and finally decomissioning EntraID.

#pagebreak()

= Supporters

Many thanks go out to all of the honorable supporters of this Project, which
include

#figure(
  table(
    columns: (1fr, 1fr), table.header([*Name*], [*Email*]), ..supporter("Carina Schmitt", "carina.schmitt@ost.ch"), ..supporter("Claude Bregenzer", "claude.bregenzer@ost.ch"), ..supporter("Edoardo Balsamo", "edoardo.balsamo@ost.ch"), ..supporter("Elia Schenker", "elia.schenker@ost.ch"), ..supporter("Fynn Gächter", "fynn.gaechter@ost.ch"), ..supporter("Gioele Petrillo", "gioele.petrillo@ost.ch"), ..supporter("Giuliano Gianola", "giuliano.gianola@ost.ch"), ..supporter("Jasmin Fässler", "jasmin.faessler@ost.ch"), ..supporter("Lukas Hunziker", "lukas.hunziker@ost.ch"), ..supporter("Marco Kuoni", "marco.kuoni@ost.ch"), ..supporter("Nathanael Fässler", "nathanael.faessler@ost.ch"), ..supporter("Nico Michael Rudolph", "nico.rudolph@ost.ch"), ..supporter("Oliver Clerc", "oliver.clerc@ost.ch"), ..supporter("Raphael Das Gupta", "raphael.dasgupta@ost.ch"), ..supporter("Samuel Meuli", "samuel.meuli@ost.ch"), ..supporter("Simon Böni", "simon.boeni@ost.ch"), ..supporter("Ramon Bister", "ramon.bister@ost.ch"),
  ), caption: "Supporters",
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
  #glossary_entry(
    "EntraID", [
      Microsoft Entra ID (formerly known as Microsoft Azure Active Directory or
      EntraID)
    ],
  ) <entraid>
  #glossary_entry("IAM", [
    Identity and Access Management
  ]) <iam>
  #glossary_entry("IT", [
    Information Technology
  ]) <it>
]
#outline_glossary()

#pagebreak()

= Illustrations
#outline(title: none, target: figure.where(kind: image))

= Tables

#outline(title: none, target: figure.where(kind: table))
