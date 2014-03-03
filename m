From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 17/18] ARM: sun4i: dt: Add ahci / sata support
Date: Mon, 3 Mar 2014 10:33:15 +0100
Message-ID: <20140303093315.GS607@lukather>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-18-git-send-email-hdegoede@redhat.com>
 <20140221181519.GC3931@lukather>
 <53087755.3090608@redhat.com>
 <20140222171516.GA3610@lukather>
 <5308F63E.3070300@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WWBpDPuG52WufD7Q"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBSEZ2GMAKGQENR6TJOQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5308F63E.3070300-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--WWBpDPuG52WufD7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sat, Feb 22, 2014 at 08:10:54PM +0100, Hans de Goede wrote:
> >>> Since IIRC we have pretty much the same needs for the USB, can't
> >>> we just drop the SATA specific mention and use it as the common
> >>> DTSI for the usual regulators?
> >>=20
> >> On most boards with sata, there will also be 1 or 2 usb
> >> regulators, so we need differently named regulator nodes for all
> >> 3 of ahci, usb1 and usb2 vbus. On some boards how ever we may
> >> only need the usb regulators.
> >=20
> > Yes, obviously...
> >=20
> >> So if you look in my current personal sunxi-devel tree you will
> >> see separate dtsi files for both ahci and usb regulators,
> >=20
> > And this is precisely what I don't understand. Why do you *need*
> > different DTSI files. If there's common regulators, that are used
> > on most boards, fine, create a common regulators files. But why do
> > you have to create a DTSI to define only one regulator.
> >=20
> >> another advantage of having these separate is that the gpio
> >> controlling the regulator can be pre-populated with the reference
> >> design gpio which is used in most boards, so that the ahci
> >> specific code in the dts becomes only the ahci: sata@... node.
> >=20
> > I understand very well the advantages of what having a reference
> > regulators bring. What I don't understand is the benefits of
> > having "topics" regulators DTSI.
>=20
> Ok, so let me try to explain:
>=20
> With topics regulator files, the ahci bits look something like this
> for a board using the reference design gpio:
>=20
> /include/ "sunxi-ahci-reg.dtsi"
>=20
> ...
>=20
> 		ahci: sata@01c18000 {
> 			target-supply =3D <&reg_ahci_5v>;
> 			status =3D "okay";
> 		};
>=20
> If we put all regulators in one file, then the ahci regulator cannot
> be enabled (so it will have status =3D "disabled) by default since most
> boards don't have it, so things would change into:
>=20
> /include/ "sunxi-common-regulators.dtsi"
>=20
> ...
>=20
> 		ahci: sata@01c18000 {
> 			target-supply =3D <&reg_ahci_5v>;
> 			status =3D "okay";
> 		};
>=20
> ...
>=20
>         reg_ahci_5v: ahci-5v {
> 		status =3D "okay";
>         };
>=20
> Notice the addition of the 2nd node. This is why I ended up doing
> 2 separate dtsi files for the ahci and for the usb regulators.
>=20
> To me saying:
>=20
> /include/ "sunxi-ahci-reg.dtsi"
>=20
> Makes it clear to the reader that the board has a ahci target-supply
> regulator, so enabling it separately seems being overly verbose.
>=20
> Of course of we change it to:
>=20
> /include/ "sunxi-common-regulators.dtsi"
>=20
> Then the verbosity / explicit enabling of various regulators becomes a
> good thing, as it is not directly clear what the include does.
>=20
> But if we do this, then for many boards we end up replacing:
>=20
> /include/ "sunxi-ahci-reg.dtsi"
> /include/ "sun4i-a10-usb-vbus-reg.dtsi"
>=20
> With:
>=20
> /include/ "sunxi-common-regulators.dtsi"
>=20
>         reg_ahci_5v: ahci-5v {
> 		status =3D "okay";
>         };
>=20
>         reg_usb1_vbus: usb1-vbus {
> 		status =3D "okay";
>         };
>=20
>         reg_usb2_vbus: usb2-vbus {
> 		status =3D "okay";
>         };
>=20
> I prefer the shorter version, but I can completely understand if
> you prefer the slightly more verbose version, this would also
> get rid of having different usb regulator dtsi files for sun4i /
> sun5i (as sun5i only has 1 usb host).
>=20
> I hope this helps explain my reasoning, as said I'm fine with
> either way, if you want to change over to a single file +
> explicit enabling, let me know and I'll respin the ahci dts
> patches.  Note I'm going on vacation for a week starting Monday,
> so you likely won't get a new version until next weekend.

Yes, I strongly prefer the second case. That allows to have a
good-enough degree of factorisation, while not having anything
happening behind the scenes.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--WWBpDPuG52WufD7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTFExbAAoJEBx+YmzsjxAgWPcQAJrRCQu1GGwHKfLF86OA4rvG
TtEuNrm1FknpzY81jjCfUiZMoEtM02vVItqWksUh5/nXEAg7yT52EOduCVfnUfQ5
jeTLFU8xKbbekyBZtG6fgLGgJxokF3lpS15d3kRKUIUR2BNtMmErIBq7+bVbgpRS
99K+QjY9uXFxgb8q3NywszLPe8Asl3QT8SC5lK5jD/dQvtc2ga0cpEZ3AxFiTU24
W4s6XhGZC2yTaQijyClBtHd+zKITOl6BMhFDufmk8ylE5m9nDtJI8DOGEBzMQlnX
Ozb3ZeZki1SzXcWagkQG6Uw1FCECwNcOrI5D3UYxoJgz08lV7994JSyI6Ea4LMSD
D1PfM7kiM0bbuyzNph4qvUIi6guHM46j0iuInUTJAETEr55lZE4DzKrrSEhWdfnk
ZYKtHQ1p7JsQPnVvwFDP1Y0b+4ZjNfHgTLVuG0TI2OAeHg05NGX7GOrUZq1YmmGH
jE9sqPcaZM6MvylX0aVW1cnYpIzk0c49ignRq6SBlALJIL96+zf5GGhj3hDp7uD6
NMbvzJ/AQnez5NMDhgpFjmrAGZI5sFQF6cprp9PBjUep3U666sRUqmCQ8q0qy5RW
1ovtgZMdiWHWwARdwBf8DlpwuPRpo68dtX7vHzJsD0ZOpYsX84gy154uX0ZkO1T5
Xfarudn3fcrrxaHmRRre
=cUdb
-----END PGP SIGNATURE-----

--WWBpDPuG52WufD7Q--
