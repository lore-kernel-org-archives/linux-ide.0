From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 14/14] ARM: sun7i: dts: Add ahci / sata support
Date: Mon, 03 Feb 2014 23:10:51 +0100
Message-ID: <52F013EB.4050900@redhat.com>
References: <1390417489-5354-1-git-send-email-hdegoede@redhat.com> <1390417489-5354-15-git-send-email-hdegoede@redhat.com> <20140131134638.GH2950@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB5FHYCLQKGQEDTT6ABA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140131134638.GH2950@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On 01/31/2014 02:46 PM, Maxime Ripard wrote:
> On Wed, Jan 22, 2014 at 08:04:49PM +0100, Hans de Goede wrote:
>> This patch adds sunxi sata support to A20 boards that have such a connec=
tor. Some boards also feature a regulator via a GPIO and support for this i=
s also added.
>>=20
>> Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org> Signed-off-by: Hans=
 de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> --- arch/arm/boot/dts/sun7i-a20-cubieboard2=
.dts     |  6 ++++++ arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 20 +=
+++++++++++++++++++ arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |  6 ++=
++++ arch/arm/boot/dts/sun7i-a20.dtsi                |  8 ++++++++ 4 files =
changed, 40 insertions(+)
>>=20
>> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot=
/dts/sun7i-a20-cubieboard2.dts index 48777cd..1cab521 100644 --- a/arch/arm=
/boot/dts/sun7i-a20-cubieboard2.dts +++ b/arch/arm/boot/dts/sun7i-a20-cubie=
board2.dts @@ -13,6 +13,7 @@
>>=20
>> /dts-v1/; /include/ "sun7i-a20.dtsi" +/include/ "sunxi-ahci-reg.dtsi"
>>=20
>> / { model =3D "Cubietech Cubieboard2"; @@ -28,6 +29,11 @@ status =3D "ok=
ay"; };
>>=20
>> +		ahci: sata@01c18000 { +			target-supply =3D <&reg_ahci_5v>; +			statu=
s =3D "okay"; +		}; + pinctrl@01c20800 { mmc0_cd_pin_cubieboard2: mmc0_cd_p=
in@0 { allwinner,pins =3D "PH1"; diff --git a/arch/arm/boot/dts/sun7i-a20-c=
ubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts index 2684f27..1=
247ea1 100644 --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts +++ b/arch/a=
rm/boot/dts/sun7i-a20-cubietruck.dts @@ -13,6 +13,7 @@
>>=20
>> /dts-v1/; /include/ "sun7i-a20.dtsi" +/include/ "sunxi-ahci-reg.dtsi"
>>=20
>> / { model =3D "Cubietech Cubietruck"; @@ -28,6 +29,11 @@ status =3D "oka=
y"; };
>>=20
>> +		ahci: sata@01c18000 { +			target-supply =3D <&reg_ahci_5v>; +			statu=
s =3D "okay"; +		}; + pinctrl@01c20800 { mmc0_cd_pin_cubietruck: mmc0_cd_pi=
n@0 { allwinner,pins =3D "PH1"; @@ -36,6 +42,13 @@ allwinner,pull =3D <0>; =
};
>>=20
>> +			ahci_pwr_pin_cubietruck: ahci_pwr_pin@1 { +				allwinner,pins =3D "P=
H12"; +				allwinner,function =3D "gpio_out"; +				allwinner,drive =3D <0>;=
 +				allwinner,pull =3D <0>; +			}; + led_pins_cubietruck: led_pins@0 { al=
lwinner,pins =3D "PH7", "PH11", "PH20", "PH21"; allwinner,function =3D "gpi=
o_out"; @@ -84,4 +97,11 @@ gpios =3D <&pio 7 7 0>; }; }; + +	regulators { +=
		reg_ahci_5v: ahci-5v { +			pinctrl-0 =3D <&ahci_pwr_pin_cubietruck>; +			=
gpio =3D <&pio 7 12 0>; +		}; +	}; }; diff --git a/arch/arm/boot/dts/sun7i-=
a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts i=
ndex
>> bf6f6c8..f135886 100644 --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micr=
o.dts +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts @@ -13,6 +13,7 =
@@
>>=20
>> /dts-v1/; /include/ "sun7i-a20.dtsi" +/include/ "sunxi-ahci-reg.dtsi"
>>=20
>> / { model =3D "Olimex A20-Olinuxino Micro"; @@ -37,6 +38,11 @@ status =
=3D "okay"; };
>>=20
>> +		ahci: sata@01c18000 { +			target-supply =3D <&reg_ahci_5v>; +			statu=
s =3D "okay"; +		}; + pinctrl@01c20800 { mmc0_cd_pin_olinuxinom: mmc0_cd_pi=
n@0 { allwinner,pins =3D "PH1"; diff --git a/arch/arm/boot/dts/sun7i-a20.dt=
si b/arch/arm/boot/dts/sun7i-a20.dtsi index c9c123a..0657bad 100644 --- a/a=
rch/arm/boot/dts/sun7i-a20.dtsi +++ b/arch/arm/boot/dts/sun7i-a20.dtsi @@ -=
347,6 +347,14 @@ status =3D "disabled"; };
>>=20
>> +		ahci: sata@01c18000 { +			compatible =3D "allwinner,sun4i-a10-ahci"; =
+			reg =3D <0x01c18000 0x1000>; +			interrupts =3D <0 56 1>;
>=20
> This is supposed to be a level triggered interrupt, not an edge triggered=
 one.

Good catch, will fix for the next version.

Regards,

Hans
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLwE+sACgkQF3VEtJrzE/tKaACgmEEVd28Oubd7hEy5chG3/XM9
0x0AmwctbAFVFC9OCBaNZix8cX3d/CAI
=3Dotiv
-----END PGP SIGNATURE-----

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
