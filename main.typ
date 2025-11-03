#import "./lib.typ": *

#show: project.with(title: "Proposal for changing the OST Auth solution", subtitle: "Striving for a more open educational environment")

= Context

The OST Auth Solution currently relies on @entraid (@saml) for
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
