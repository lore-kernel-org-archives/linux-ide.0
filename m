From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 14/14] ARM: sun7i: dts: Add ahci / sata support
Date: Fri, 31 Jan 2014 14:46:38 +0100
Message-ID: <20140131134638.GH2950@lukather>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com>
 <1390417489-5354-15-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p1Od3smaOkJqivj4"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBQ6MWCLQKGQEY6E3VCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390417489-5354-15-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--p1Od3smaOkJqivj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2014 at 08:04:49PM +0100, Hans de Goede wrote:
> This patch adds sunxi sata support to A20 boards that have such a connect=
or.
> Some boards also feature a regulator via a GPIO and support for this is a=
lso
> added.
>=20
> Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |  6 ++++++
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |  6 ++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi                |  8 ++++++++
>  4 files changed, 40 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/=
dts/sun7i-a20-cubieboard2.dts
> index 48777cd..1cab521 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -13,6 +13,7 @@
> =20
>  /dts-v1/;
>  /include/ "sun7i-a20.dtsi"
> +/include/ "sunxi-ahci-reg.dtsi"
> =20
>  / {
>  	model =3D "Cubietech Cubieboard2";
> @@ -28,6 +29,11 @@
>  			status =3D "okay";
>  		};
> =20
> +		ahci: sata@01c18000 {
> +			target-supply =3D <&reg_ahci_5v>;
> +			status =3D "okay";
> +		};
> +
>  		pinctrl@01c20800 {
>  			mmc0_cd_pin_cubieboard2: mmc0_cd_pin@0 {
>  				allwinner,pins =3D "PH1";
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/d=
ts/sun7i-a20-cubietruck.dts
> index 2684f27..1247ea1 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -13,6 +13,7 @@
> =20
>  /dts-v1/;
>  /include/ "sun7i-a20.dtsi"
> +/include/ "sunxi-ahci-reg.dtsi"
> =20
>  / {
>  	model =3D "Cubietech Cubietruck";
> @@ -28,6 +29,11 @@
>  			status =3D "okay";
>  		};
> =20
> +		ahci: sata@01c18000 {
> +			target-supply =3D <&reg_ahci_5v>;
> +			status =3D "okay";
> +		};
> +
>  		pinctrl@01c20800 {
>  			mmc0_cd_pin_cubietruck: mmc0_cd_pin@0 {
>  				allwinner,pins =3D "PH1";
> @@ -36,6 +42,13 @@
>  				allwinner,pull =3D <0>;
>  			};
> =20
> +			ahci_pwr_pin_cubietruck: ahci_pwr_pin@1 {
> +				allwinner,pins =3D "PH12";
> +				allwinner,function =3D "gpio_out";
> +				allwinner,drive =3D <0>;
> +				allwinner,pull =3D <0>;
> +			};
> +
>  			led_pins_cubietruck: led_pins@0 {
>  				allwinner,pins =3D "PH7", "PH11", "PH20", "PH21";
>  				allwinner,function =3D "gpio_out";
> @@ -84,4 +97,11 @@
>  			gpios =3D <&pio 7 7 0>;
>  		};
>  	};
> +
> +	regulators {
> +		reg_ahci_5v: ahci-5v {
> +			pinctrl-0 =3D <&ahci_pwr_pin_cubietruck>;
> +			gpio =3D <&pio 7 12 0>;
> +		};
> +	};
>  };
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/b=
oot/dts/sun7i-a20-olinuxino-micro.dts
> index bf6f6c8..f135886 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> @@ -13,6 +13,7 @@
> =20
>  /dts-v1/;
>  /include/ "sun7i-a20.dtsi"
> +/include/ "sunxi-ahci-reg.dtsi"
> =20
>  / {
>  	model =3D "Olimex A20-Olinuxino Micro";
> @@ -37,6 +38,11 @@
>  			status =3D "okay";
>  		};
> =20
> +		ahci: sata@01c18000 {
> +			target-supply =3D <&reg_ahci_5v>;
> +			status =3D "okay";
> +		};
> +
>  		pinctrl@01c20800 {
>  			mmc0_cd_pin_olinuxinom: mmc0_cd_pin@0 {
>  				allwinner,pins =3D "PH1";
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a=
20.dtsi
> index c9c123a..0657bad 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -347,6 +347,14 @@
>  			status =3D "disabled";
>  		};
> =20
> +		ahci: sata@01c18000 {
> +			compatible =3D "allwinner,sun4i-a10-ahci";
> +			reg =3D <0x01c18000 0x1000>;
> +			interrupts =3D <0 56 1>;

This is supposed to be a level triggered interrupt, not an edge
triggered one.

Thanks for your work!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--p1Od3smaOkJqivj4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJS66k+AAoJEBx+YmzsjxAg3GkP/j0Gxm5adLFgTyetGtvwsyWn
y8uHZwUcRPdY3up1Ip11NJC5FJjC36FWbXaFfrA8vVrZ/0GIyedqaxuMWHFuXXY4
CrAWtzIOI6zf6dZ3UtVdNe056iy0GJk3pamFZvqiakcePKTpNs55tQHY7jm1hhKo
VH+IgQismkQl3fOSGnGMp5FUxLP3q+gSCksVsLbjJQAvQfwelfg9FWFz7TI1uX2b
pEusjUImjXyAswI8tJAhjHyl3nE1ZJKVec0mdKM2TjWQwXoZ7xunKBz9Z68EWgkL
gN2xC0a+qoZ28cGhVl6pbibyB12QvOdD7ATRmnI9u6Drqt+BESnHlAWjFFc+RlYy
c9r/y0QCHt303bsFd0Ito4smz62V1F0n2SLgshGOfAMVXFyjdCR6z1HnmREeS5K7
Bwz/En+hvqzznhOK8Tke39qWublk4FJzgdxF866LlgYnrVM1SrVeBr0+jtrVX80a
OGyzHIHGd/J2kZB4Am+ZZpioKKhQ3soI1Cc5BFm985nF2mv/VPBCiy0XZjfos43o
2NnklGE85s4k+vjipRiyCJFOTRXZN0OxHVtsRPXmTTW+dQKxjmpa++s9UTiqRm+j
zXb1J7ov+pXEB0ZAr3jp44BdHoxo6fYO0T8pqjWG9/OXgj2DnqCYcf6k7BusCb2k
WbvvLV/L+K6gaQePU6Wl
=0K1a
-----END PGP SIGNATURE-----

--p1Od3smaOkJqivj4--
