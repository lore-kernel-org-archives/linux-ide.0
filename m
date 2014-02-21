From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 17/18] ARM: sun4i: dt: Add ahci / sata support
Date: Fri, 21 Feb 2014 19:15:19 +0100
Message-ID: <20140221181519.GC3931@lukather>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-18-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBU5RT2MAKGQELNZLKCQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392811320-3132-18-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org


--n/aVsWSeQ4JHkrmm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Wed, Feb 19, 2014 at 01:01:59PM +0100, Hans de Goede wrote:
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
>  arch/arm/boot/dts/sunxi-ahci-reg.dtsi      | 36 ++++++++++++++++++++++++=
++++++
>  4 files changed, 54 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sunxi-ahci-reg.dtsi
>=20
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/su=
n4i-a10-a1000.dts
> index cbd2e13..d6ec839 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -35,6 +35,10 @@
>  			};
>  		};
> =20
> +		ahci: sata@01c18000 {
> +			status =3D "okay";
> +		};
> +
>  		pinctrl@01c20800 {
>  			emac_power_pin_a1000: emac_power_pin@0 {
>  				allwinner,pins =3D "PH15";
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/d=
ts/sun4i-a10-cubieboard.dts
> index b139ee6..6df237d8 100644
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
> @@ -33,6 +34,11 @@
>  			};
>  		};
> =20
> +		ahci: sata@01c18000 {
> +			target-supply =3D <&reg_ahci_5v>;
> +			status =3D "okay";
> +		};
> +
>  		pinctrl@01c20800 {
>  			led_pins_cubieboard: led_pins@0 {
>  				allwinner,pins =3D "PH20", "PH21";
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a=
10.dtsi
> index 336dbec..454077a 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -338,6 +338,14 @@
>  			#size-cells =3D <0>;
>  		};
> =20
> +		ahci: sata@01c18000 {
> +			compatible =3D "allwinner,sun4i-a10-ahci";
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
> index 0000000..7072af1
> --- /dev/null
> +++ b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi
> @@ -0,0 +1,36 @@
> +/*
> + * sunxi boards sata target power supply common code


Since IIRC we have pretty much the same needs for the USB, can't we
just drop the SATA specific mention and use it as the common DTSI for
the usual regulators?

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTB5e2AAoJEBx+YmzsjxAg4SoP/0Xi/q+CGFs0m2wDTl5v6NmT
dJKbOI1zkWpjR7lmlQvWkkiKycxa+dfOJNKFn4eeYCMywyY7PsU+8sRTXjq+bz/w
xWPikXEyhDiX0TEcXDMUTJGrLy/bWQIkvhy3sdfiCFOzVLhMIkBFo+x+DDad7Kms
+zy07p2CXo79oFFN4ijIgFmzhgzt9XneMWyGERAFZx9Qkxwx5O8ruw91vsn9JKo1
FbHQw4ZcTO4eNuWHqYcBZkl7uQ2h909554wtCnduEA+CbeDZe1SSS0t+pPRnRkdj
iP2jaKCZ8Rwi5jMQQyiZa5EO5+A3KAfalQf94wzi1jnp/PV/BTFN1ceaRjHmiMGa
yEobu+QDIWY974VwUGCz3ou+pl/5oYak9kc+bH3SsMG3kP5q9aHJQUQILRuRQTRz
3Pzs4jaoW98Uf5KAOuw2HcNSv/4TvssswTWCxdRR44q7E9WfGYYQUIEraYUxT3sC
s0HowdiPJlgtQPIP+tQE7mGw1JpZKsCQ8L7um/VLW/8IANq0+g/K8Cs5v/xNf79W
W079UzV6Hmp+XJ2azZETiFHq5My0tnidm5HsOL4TnG7YX7T9iJbOAUbCgGQW68RK
60ZzLEobO0cDRHpy4aX1fLTsuAR9pZGDUQkCdlLc7UDesRJqPzrAJEI8OeNpz+P7
HbjtBFPi8j2JKHmOUiTA
=/XOp
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--
