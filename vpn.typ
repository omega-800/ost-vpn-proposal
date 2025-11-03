#import "./lib.typ": *

#show: project.with(title: "Proposal for changing the OST VPN")

= Notice

This document is incomplete and a work in progress.

= Context

The OST-VPN Solution currently relies on @entraid (@saml) authentication for
Cisco SSL-VPN. Users can connect to the @vpn through the recommended cisco
secure client @ostauthvpn or any compatible client supporting the AnyConnect
protocol, such as openconnect @openconnect.

= Argumentation

This Proposal is based on the "Proposal for changing the OST Auth solution".
Therefore, all of the talking points regarding open- and closed-source software
apply to the arguments for an alternative VPN implementation as well.

Multiple instances of students or professors asking for an alternative, open-source solution have been documented /*@strongswan*/ .

= Proposal


