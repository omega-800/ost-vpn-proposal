#import "./lib.typ": *

#show: project.with(title: "Proposal for changing the OST VPN")

#let glossary = (
  OSS: ( desc: [Open Source Software], link: <oss>),
  SAMLv2:(desc: [ Security Assertion Markup Language 2.0 ],link: <saml>),
  SSL:(desc: [ Secure Sockets Layer ],link: <ssl>),
  VPN:(desc: [ Virtual Private Network ],link: <vpn>),
  EntraID:(desc: [ Microsoft Entra ID (formerly known as Microsoft Azure Active Directory or Azure AD) ],link: <entraid>),
  "IKEv2/IPSec": (desc: [VPN protocol combination of Internet Key Exchange version 2 and Internet Protocol Security], link: <ikev2>)
)
#let g = (k) => link(glossary.at(k).link, k)
#let outline-glossary = () => glossary.pairs().map(((k,v)) => 
  [#glossary-entry(k, v.desc) #v.link]
).join()

= Context

This Proposal is based on the #link("https://raw.githubusercontent.com/omega-800/ost-vpn-proposal/refs/heads/main/main.pdf","Proposal for changing the OST Auth solution").
Consequently, all points regarding open-source and closed-source software (e.g.
lower cost of ownership, flexibility, data sovereignty) remain applicable to the
arguments supporting an alternative VPN implementation.

The OST-VPN Solution currently utilizes #g("EntraID") (#g("SAMLv2"))
authentication for Cisco SSL-VPN. Users can connect to the #g("VPN") through the
recommended cisco secure client @ostauthvpn or any compatible client supporting
the AnyConnect protocol, such as openconnect @openconnect.

There have been multiple requests from students and faculty for an #g("OSS") solution.
Notably, Andreas Steffen, the creator of StrongSwan @strongswan, has suggested
its implementation for the OST VPN. Raphael Das Gupta also had inquired about an
open-source alternative to Microsoft Authenticator @mauthalt.

= Proposal

In addition to providing privacy-compliant and non-discriminatory remote access
to the OST Network, an alternative solution may enhance both performance and
security. StrongSwan presents itself as a compelling alternative, having been
developed by Andreas Steffen, a former Professor at OST. The internal knowledge
base can be effectively leveraged to facilitate this implementation. Moreover,
StrongSwan offers a high degree of customizability and custom plugins, so that
the requirements of complex environments can be met.

Furthermore, the #g("IKEv2/IPSec") Protocol demonstrates superior performance in
high-traffic situations compared to alternative solutions such as OpenVPN
@openvpn or Wireguard @wireguard as evaluated by C. T. J. Xiang @XiangVPNPerf
and F. Pohl @PohlVPNPerf.

StrongSwan's use of IKEv2/IPSec also offers robust encryption and integrity
checks, providing better data protection compared to SSL-based protocols. Its
open-source nature allows for third-party audits and transparency, ensuring
there are no undisclosed vulnerabilities. In contrast, Cisco's proprietary
system limits visibility into the underlying security mechanisms.

#pagebreak()

= Glossary

#outline-glossary()

