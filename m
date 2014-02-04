From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 13/14] ARM: sun4i: dts: Add ahci / sata support
Date: Tue, 4 Feb 2014 10:44:06 +0100
Message-ID: <20140204094406.GM25625@lukather>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
 <1390417489-5354-14-git-send-email-hdegoede@redhat.com>
 <20140131134505.GG2950@lukather>
 <52EF70E2.6070803@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Aaj1jBvBEV7KRjLi"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBH7NYKLQKGQEDXD4TVQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52EF70E2.6070803-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--Aaj1jBvBEV7KRjLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2014 at 11:35:14AM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 01/31/2014 02:45 PM, Maxime Ripard wrote:
> >Hi Hans,
> >
> >On Wed, Jan 22, 2014 at 08:04:48PM +0100, Hans de Goede wrote:
> >>From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
> >>
> >>This patch adds sunxi sata support to A10 boards that have such a conne=
ctor.
> >>Some boards also feature a regulator via a GPIO and support for this is=
 also
> >>added.
> >>
> >>Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
> >>Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>---
> >>  arch/arm/boot/dts/sun4i-a10-a1000.dts      |  4 ++++
> >>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  6 +++++
> >>  arch/arm/boot/dts/sun4i-a10.dtsi           |  8 +++++++
> >>  arch/arm/boot/dts/sunxi-ahci-reg.dtsi      | 38 +++++++++++++++++++++=
+++++++++
> >
> >I'm still half convinced about this at the moment, given the number of
> >platforms we support, we can always change it back if things become too =
messy.
>=20
> I assume that this =3D=3D sunxi-ahci-reg.dtsi ?  To be sure I understand
> you correctly, you're ok with going this route for now, right ?

Yep.

> How about the same for the usb ohci/ehci controller dts patches ? Current=
ly they
> are still using the put a regulator node in each dts file model, which le=
ads to
> a lot of boilerplate code. So I would like to move to the same model as I=
'm
> using here for the sata supply.

That would make sense too.

> >>  4 files changed, 56 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/sunxi-ahci-reg.dtsi
> >>
> >>diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/=
sun4i-a10-a1000.dts
> >>index aef8207..3fb7305 100644
> >>--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >>+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >>@@ -48,6 +48,10 @@
> >>  			status =3D "okay";
> >>  		};
> >>
> >>+		ahci: sata@01c18000 {
> >>+			status =3D "okay";
> >>+		};
> >>+
> >>  		pinctrl@01c20800 {
> >>  			mmc0_cd_pin_a1000: mmc0_cd_pin@0 {
> >>  				allwinner,pins =3D "PH1";
> >>diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot=
/dts/sun4i-a10-cubieboard.dts
> >>index f50fb2b..6ae1110 100644
> >>--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> >>+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> >>@@ -12,6 +12,7 @@
> >>
> >>  /dts-v1/;
> >>  /include/ "sun4i-a10.dtsi"
> >>+/include/ "sunxi-ahci-reg.dtsi"
> >>
> >>  / {
> >>  	model =3D "Cubietech Cubieboard";
> >>@@ -51,6 +52,11 @@
> >>  			status =3D "okay";
> >>  		};
> >>
> >>+		ahci: sata@01c18000 {
> >>+			target-supply =3D <&reg_ahci_5v>;
> >>+			status =3D "okay";
> >>+		};
> >>+
> >>  		pinctrl@01c20800 {
> >>  			mmc0_cd_pin_cubieboard: mmc0_cd_pin@0 {
> >>  				allwinner,pins =3D "PH1";
> >>diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i=
-a10.dtsi
> >>index 4736dd2..198dcda 100644
> >>--- a/arch/arm/boot/dts/sun4i-a10.dtsi
> >>+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> >>@@ -331,6 +331,14 @@
> >>  			status =3D "disabled";
> >>  		};
> >>
> >>+		ahci: sata@01c18000 {
> >>+			compatible =3D "allwinner,sun4i-a10-ahci";
> >
> >To be consistent with the rest of the sun4i devices compatible, It
> >should be sun4i-ahci.
> >
> >However, since these devices don't use the same compatible pattern as
> >their own machine compatible, and are consisent with the rest of the
> >compatibles for the other SoCs, we can probably make this a go to
> >transition progressively to this pattern.
>=20
> Ack, I think it would be good to be consistent and try to use
> sun?i-aXX-foo everywhere. I noticed that we already use that in various
> places, so I thought it would be good to do that for all new dts bindings.

Yes, that's my plan.

> >I'll cook up some patches for the other devices.
>=20
> Thanks.

And I sent them on sunday.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Aaj1jBvBEV7KRjLi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS8LZmAAoJEBx+YmzsjxAgpOEQALOp2Q/CiSHX0S3J9EonHI+2
3QwHv6m8m5bc+EJWsT1hI7uCjc9yCpBc9WhxaLb10llk6uNBca53GRzJQTOyFONh
yoslpAcFgVbb7Au80DGj3MtxVYdesRSDGH+/SPgS3YPFoyOv6RsZilu/XMTbDsA8
at7wXS77kUdA5s+uqR6YCVxFeipW4whGxhKVOHVWmhhcZhlpUGuoWAyWjyTH4Sil
ukBiCcSYFM9nY7fUBtx9LY7N5uo7avFMap1nzyFGd2VfFORnqHBH+DxxFGwg1fBs
81HFV1wNzIFSBOXfKeQu9vnf3jPp86k04i8PSzhR0Vt1YJQVYjH3UlfwSmbn3Ffu
8mtULu2vODh6aON1evq4YFli9cV+SUEs+8lSMDjppKnn6muty1MzSexWpAaFT3dG
IhGBKgfoJWtxY8a+fi8PMqGjB7DHqnMHAbIdKrCFKoayjHvmMxnCY5jpVVkjOEy/
mcnbvfM0GHaSuH5CwPLwk2bsrC+yBw4Rw9XYgfZmr8qpp+oWBxP4/C65pBUWSMe+
yKplzZ/ncJoZxRH79gxdUtma9eav0GwnbPIPrWsmDyygk9M/mkJ9K9mzSJWBOyxV
dhxFIqxyyiodhyfYnLEYHwlcFKg8x8ce3YoSQcmHM/2X/V2pHnJkCutvBGfK1T84
fz+go5moiw5q6LmvN5DR
=HhRE
-----END PGP SIGNATURE-----

--Aaj1jBvBEV7KRjLi--
