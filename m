From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 13/14] ARM: sun4i: dts: Add ahci / sata support
Date: Fri, 31 Jan 2014 14:45:05 +0100
Message-ID: <20140131134505.GG2950@lukather>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
 <1390417489-5354-14-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x38akuY2VS0PywU3"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBQ6MWCLQKGQEY6E3VCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390417489-5354-14-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--x38akuY2VS0PywU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Wed, Jan 22, 2014 at 08:04:48PM +0100, Hans de Goede wrote:
> From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
>=20
> This patch adds sunxi sata support to A10 boards that have such a connect=
or.
> Some boards also feature a regulator via a GPIO and support for this is a=
lso
> added.
>=20
> Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun4i-a10-a1000.dts      |  4 ++++
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  6 +++++
>  arch/arm/boot/dts/sun4i-a10.dtsi           |  8 +++++++
>  arch/arm/boot/dts/sunxi-ahci-reg.dtsi      | 38 ++++++++++++++++++++++++=
++++++

I'm still half convinced about this at the moment, given the number of
platforms we support, we can always change it back if things become too mes=
sy.

>  4 files changed, 56 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sunxi-ahci-reg.dtsi
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/su=
n4i-a10-a1000.dts
> index aef8207..3fb7305 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -48,6 +48,10 @@
>  			status =3D "okay";
>  		};
> =20
> +		ahci: sata@01c18000 {
> +			status =3D "okay";
> +		};
> +
>  		pinctrl@01c20800 {
>  			mmc0_cd_pin_a1000: mmc0_cd_pin@0 {
>  				allwinner,pins =3D "PH1";
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/d=
ts/sun4i-a10-cubieboard.dts
> index f50fb2b..6ae1110 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -12,6 +12,7 @@
> =20
>  /dts-v1/;
>  /include/ "sun4i-a10.dtsi"
> +/include/ "sunxi-ahci-reg.dtsi"
> =20
>  / {
>  	model =3D "Cubietech Cubieboard";
> @@ -51,6 +52,11 @@
>  			status =3D "okay";
>  		};
> =20
> +		ahci: sata@01c18000 {
> +			target-supply =3D <&reg_ahci_5v>;
> +			status =3D "okay";
> +		};
> +
>  		pinctrl@01c20800 {
>  			mmc0_cd_pin_cubieboard: mmc0_cd_pin@0 {
>  				allwinner,pins =3D "PH1";
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a=
10.dtsi
> index 4736dd2..198dcda 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -331,6 +331,14 @@
>  			status =3D "disabled";
>  		};
> =20
> +		ahci: sata@01c18000 {
> +			compatible =3D "allwinner,sun4i-a10-ahci";

To be consistent with the rest of the sun4i devices compatible, It
should be sun4i-ahci.

However, since these devices don't use the same compatible pattern as
their own machine compatible, and are consisent with the rest of the
compatibles for the other SoCs, we can probably make this a go to
transition progressively to this pattern.

I'll cook up some patches for the other devices.

> +			reg =3D <0x01c18000 0x1000>;
> +			interrupts =3D <56>;
> +			clocks =3D <&pll6 0>, <&ahb_gates 25>;
> +			status =3D "disabled";
> +		};
> +
>  		intc: interrupt-controller@01c20400 {
>  			compatible =3D "allwinner,sun4i-ic";
>  			reg =3D <0x01c20400 0x400>;
> diff --git a/arch/arm/boot/dts/sunxi-ahci-reg.dtsi b/arch/arm/boot/dts/su=
nxi-ahci-reg.dtsi
> new file mode 100644
> index 0000000..955b197
> --- /dev/null
> +++ b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
> @@ -0,0 +1,38 @@
> +/*
> + * sunxi boards sata target power supply common code
> + *
> + * Copyright 2014 - Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/ {
> +	soc@01c00000 {
> +		ahci_pwr_pin_a: ahci_pwr_pin@0 {
> +			allwinner,pins =3D "PB8";
> +			allwinner,function =3D "gpio_out";
> +			allwinner,drive =3D <0>;
> +			allwinner,pull =3D <0>;
> +		};

This should be under the pinctrl node.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--x38akuY2VS0PywU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS66jhAAoJEBx+YmzsjxAgnNEQAK5tzBQ5AzZSGaHwoFTjTQnF
Gjw2QspnW3cZDZ/WLRxN7fRBBC+AgyF+g0QPOC1Oe85/dq8nB3j3dOJ3wtt1sOIB
aRCL6ha1T0wario4KvzYBwhG9e9bZ07CuWdYxtzo8Weh4coAG6EiOu0M2ilYkK9f
D1qmwHWVHfB0JC1aBs24yFdvKUV+CPIodslYaSZwOM2FjsE8hnx/Xpqd6ef/VbQl
tGPgMGp0Kz5clo+j7BuVrs8uRnBvSloCG06LNGEHKpiQkKQbtGAKSu9tGUeq2DqE
0Z5q+sbdQZTLy0geUyhBqFZkXGKAGIxy4JRwe1YaY7u6u3Xw7DYrw+UjHqHWoGOJ
cYPvPYDfpqftaKyL4KF+40SZP+NCUoUpbhl6oqqBFqAfNvk99aqxcR5DfyyDm1xz
shSb9Ut9gll1VoI7PEyBvSe2uX3nXv46M54nLGlmkjF79RNtarb5EvTKSpaoEska
dki2k0K5INZQjoLf/d7slMm9CzBQnOn9oftjX46UWj2qayDrzlLItnucp5UJYNnm
U+f7WHlsW05Aj6bV0p1RBNMMmPbXtLrGrRjetKHdluQJQEt6Jf2ElkLStr92bXvL
6JLnWfS7S6PEp3dhGrsWEdv62fGTfefg3SMoeWkOQREkAdmtl52Br/1SX4DKBwVU
ScRtLoCr3xUFDz7MME2K
=aA+g
-----END PGP SIGNATURE-----

--x38akuY2VS0PywU3--
