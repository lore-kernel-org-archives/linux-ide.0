From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 17/18] ARM: sun4i: dt: Add ahci / sata support
Date: Sat, 22 Feb 2014 18:15:16 +0100
Message-ID: <20140222171516.GA3610@lukather>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-18-git-send-email-hdegoede@redhat.com>
 <20140221181519.GC3931@lukather>
 <53087755.3090608@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBQ5YUOMAKGQENWAMU3Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53087755.3090608-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2014 at 11:09:25AM +0100, Hans de Goede wrote:
> Hi Maxime,
>=20
> On 02/21/2014 07:15 PM, Maxime Ripard wrote:
> >Hi Hans,
> >
> >On Wed, Feb 19, 2014 at 01:01:59PM +0100, Hans de Goede wrote:
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
> >>  arch/arm/boot/dts/sunxi-ahci-reg.dtsi      | 36 +++++++++++++++++++++=
+++++++++
> >>  4 files changed, 54 insertions(+)
> >>  create mode 100644 arch/arm/boot/dts/sunxi-ahci-reg.dtsi
> >>
> >>diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/=
sun4i-a10-a1000.dts
> >>index cbd2e13..d6ec839 100644
> >>--- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >>+++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> >>@@ -35,6 +35,10 @@
> >>  			};
> >>  		};
> >>
> >>+		ahci: sata@01c18000 {
> >>+			status =3D "okay";
> >>+		};
> >>+
> >>  		pinctrl@01c20800 {
> >>  			emac_power_pin_a1000: emac_power_pin@0 {
> >>  				allwinner,pins =3D "PH15";
> >>diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot=
/dts/sun4i-a10-cubieboard.dts
> >>index b139ee6..6df237d8 100644
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
> >>@@ -33,6 +34,11 @@
> >>  			};
> >>  		};
> >>
> >>+		ahci: sata@01c18000 {
> >>+			target-supply =3D <&reg_ahci_5v>;
> >>+			status =3D "okay";
> >>+		};
> >>+
> >>  		pinctrl@01c20800 {
> >>  			led_pins_cubieboard: led_pins@0 {
> >>  				allwinner,pins =3D "PH20", "PH21";
> >>diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i=
-a10.dtsi
> >>index 336dbec..454077a 100644
> >>--- a/arch/arm/boot/dts/sun4i-a10.dtsi
> >>+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> >>@@ -338,6 +338,14 @@
> >>  			#size-cells =3D <0>;
> >>  		};
> >>
> >>+		ahci: sata@01c18000 {
> >>+			compatible =3D "allwinner,sun4i-a10-ahci";
> >>+			reg =3D <0x01c18000 0x1000>;
> >>+			interrupts =3D <56>;
> >>+			clocks =3D <&pll6 0>, <&ahb_gates 25>;
> >>+			status =3D "disabled";
> >>+		};
> >>+
> >>  		intc: interrupt-controller@01c20400 {
> >>  			compatible =3D "allwinner,sun4i-ic";
> >>  			reg =3D <0x01c20400 0x400>;
> >>diff --git a/arch/arm/boot/dts/sunxi-ahci-reg.dtsi b/arch/arm/boot/dts/=
sunxi-ahci-reg.dtsi
> >>new file mode 100644
> >>index 0000000..7072af1
> >>--- /dev/null
> >>+++ b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
> >>@@ -0,0 +1,36 @@
> >>+/*
> >>+ * sunxi boards sata target power supply common code
> >
> >
> >Since IIRC we have pretty much the same needs for the USB, can't we
> >just drop the SATA specific mention and use it as the common DTSI for
> >the usual regulators?
>=20
> On most boards with sata, there will also be 1 or 2 usb regulators,
> so we need differently named regulator nodes for all 3 of ahci,
> usb1 and usb2 vbus. On some boards how ever we may only need the
> usb regulators.

Yes, obviously...

> So if you look in my current personal sunxi-devel tree you will see
> separate dtsi files for both ahci and usb regulators,

And this is precisely what I don't understand. Why do you *need*
different DTSI files. If there's common regulators, that are used on
most boards, fine, create a common regulators files. But why do you
have to create a DTSI to define only one regulator.

> another advantage of having these separate is that the gpio controlling
> the regulator can be pre-populated with the reference design gpio which
> is used in most boards, so that the ahci specific code in the dts
> becomes only the ahci: sata@... node.

I understand very well the advantages of what having a reference
regulators bring. What I don't understand is the benefits of having
"topics" regulators DTSI.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTCNsjAAoJEBx+YmzsjxAgMMgP/RLAqvGd8FLRBDuGA30Tm3Dj
7FVvmqscbLZ2wRZl4CQVZAtaOPn3sC5BaWoEXfrHjSDoNymrCGtx5k7bd4qON7PH
INbZVB4Uyot+93P/f7MabCnlXc8KuVEizza/Q0F8Q2PQ6awGxE+CwrXZ4jp8VxLR
MdD2htf4hIamk9zJzUBEtueuqK+3G7TrlF6QUGxujkvW9PkbWURX3GdtznHhC8DF
zeh0BaOYs5jyoohTlTeuCDTgKArVAgspRcYhcuygIgCMeFthjAjz/KGZMkpZKEoC
T5J63OXRNws5QY9rAoVBOHpSYLUuxHf5R8GIMmbYGO6AYNOJsUEQadUQ3C2giiTO
BYkXGZVfJSpVg2+wk+Ais3jBhyPhBXjWwfS8to0HF4/yy5oIOSQm/qWr64PZD+Pv
ZOhPjNNkVJL9Sdh++Nm1iVLs+qpaBvPvh4wtqVyiP7B9e1Gb1CjPGN4uusVDsiMo
4z0JcIch9NM0nyrSJApmBlNHS+/oiDn4qhYtDGM+0eaodxVuwAyXISFRVjzVVH25
is8mB0b+uEJcruOkhV6hMKwOWxiLGqoURyBWjKBTnrUfzLscbNizwAvIVecOMMcB
aPaKtThFjUD9rmhcLMyyWSoKuv4922V/P3XVWVocnKeHLt/5yS68XWp28gpLiC3k
+0m2JAu2VUCqJWT5tzut
=p533
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
