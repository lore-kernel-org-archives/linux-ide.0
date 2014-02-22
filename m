From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 17/18] ARM: sun4i: dt: Add ahci / sata support
Date: Sat, 22 Feb 2014 20:10:54 +0100
Message-ID: <5308F63E.3070300@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com> <1392811320-3132-18-git-send-email-hdegoede@redhat.com> <20140221181519.GC3931@lukather> <53087755.3090608@redhat.com> <20140222171516.GA3610@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBR7MUOMAKGQESYCHDFA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140222171516.GA3610@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, Richard Zhu <Hong-Xing.Zhu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On 02/22/2014 06:15 PM, Maxime Ripard wrote:
> On Sat, Feb 22, 2014 at 11:09:25AM +0100, Hans de Goede wrote:
>> Hi Maxime,
>>=20
>> On 02/21/2014 07:15 PM, Maxime Ripard wrote:
>>> Hi Hans,
>>>=20
>>> On Wed, Feb 19, 2014 at 01:01:59PM +0100, Hans de Goede wrote:
>>>> From: Oliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
>>>>=20
>>>> This patch adds sunxi sata support to A10 boards that have such a conn=
ector. Some boards also feature a regulator via a GPIO and support for this=
 is also added.
>>>>=20
>>>> Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org> Signed-off-by: Ha=
ns de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> --- arch/arm/boot/dts/sun4i-a10-a1000.dts=
      |  4 ++++ arch/arm/boot/dts/sun4i-a10-cubieboard.dts |  6 +++++ arch/=
arm/boot/dts/sun4i-a10.dtsi           |  8 +++++++ arch/arm/boot/dts/sunxi-=
ahci-reg.dtsi      | 36 ++++++++++++++++++++++++++++++ 4 files changed, 54 =
insertions(+) create mode 100644 arch/arm/boot/dts/sunxi-ahci-reg.dtsi
>>>>=20
>>>> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts=
/sun4i-a10-a1000.dts index cbd2e13..d6ec839 100644 --- a/arch/arm/boot/dts/=
sun4i-a10-a1000.dts +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts @@ -35,6 +3=
5,10 @@ }; };
>>>>=20
>>>> +		ahci: sata@01c18000 { +			status =3D "okay"; +		}; + pinctrl@01c208=
00 { emac_power_pin_a1000: emac_power_pin@0 { allwinner,pins =3D "PH15"; di=
ff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/s=
un4i-a10-cubieboard.dts index b139ee6..6df237d8 100644 --- a/arch/arm/boot/=
dts/sun4i-a10-cubieboard.dts +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.d=
ts @@ -12,6 +12,7 @@
>>>>=20
>>>> /dts-v1/; /include/ "sun4i-a10.dtsi" +/include/ "sunxi-ahci-reg.dtsi"
>>>>=20
>>>> / { model =3D "Cubietech Cubieboard"; @@ -33,6 +34,11 @@ }; };
>>>>=20
>>>> +		ahci: sata@01c18000 { +			target-supply =3D <&reg_ahci_5v>; +			sta=
tus =3D "okay"; +		}; + pinctrl@01c20800 { led_pins_cubieboard: led_pins@0 =
{ allwinner,pins =3D "PH20", "PH21"; diff --git a/arch/arm/boot/dts/sun4i-a=
10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi index 336dbec..454077a 100644 --=
- a/arch/arm/boot/dts/sun4i-a10.dtsi +++ b/arch/arm/boot/dts/sun4i-a10.dtsi=
 @@ -338,6 +338,14 @@ #size-cells =3D <0>; };
>>>>=20
>>>> +		ahci: sata@01c18000 { +			compatible =3D "allwinner,sun4i-a10-ahci"=
; +			reg =3D <0x01c18000 0x1000>; +			interrupts =3D <56>; +			clocks =3D =
<&pll6 0>, <&ahb_gates 25>; +			status =3D "disabled"; +		}; + intc: interr=
upt-controller@01c20400 { compatible =3D "allwinner,sun4i-ic"; reg =3D <0x0=
1c20400 0x400>; diff --git a/arch/arm/boot/dts/sunxi-ahci-reg.dtsi b/arch/a=
rm/boot/dts/sunxi-ahci-reg.dtsi new file mode 100644 index 0000000..7072af1=
 --- /dev/null +++ b/arch/arm/boot/dts/sunxi-ahci-reg.dtsi @@ -0,0 +1,36 @@=
 +/* + * sunxi boards sata target power supply common code
>>>=20
>>>=20
>>> Since IIRC we have pretty much the same needs for the USB, can't we jus=
t drop the SATA specific mention and use it as the common DTSI for the usua=
l regulators?
>>=20
>> On most boards with sata, there will also be 1 or 2 usb regulators, so w=
e need differently named regulator nodes for all 3 of ahci, usb1 and usb2 v=
bus. On some boards how ever we may only need the usb regulators.
>=20
> Yes, obviously...
>=20
>> So if you look in my current personal sunxi-devel tree you will see sepa=
rate dtsi files for both ahci and usb regulators,
>=20
> And this is precisely what I don't understand. Why do you *need* differen=
t DTSI files. If there's common regulators, that are used on most boards, f=
ine, create a common regulators files. But why do you have to create a DTSI=
 to define only one regulator.
>=20
>> another advantage of having these separate is that the gpio controlling =
the regulator can be pre-populated with the reference design gpio which is =
used in most boards, so that the ahci specific code in the dts becomes only=
 the ahci: sata@... node.
>=20
> I understand very well the advantages of what having a reference regulato=
rs bring. What I don't understand is the benefits of having "topics" regula=
tors DTSI.

Ok, so let me try to explain:

With topics regulator files, the ahci bits look something like this
for a board using the reference design gpio:

/include/ "sunxi-ahci-reg.dtsi"

...

		ahci: sata@01c18000 {
			target-supply =3D <&reg_ahci_5v>;
			status =3D "okay";
		};

If we put all regulators in one file, then the ahci regulator cannot
be enabled (so it will have status =3D "disabled) by default since most
boards don't have it, so things would change into:

/include/ "sunxi-common-regulators.dtsi"

...

		ahci: sata@01c18000 {
			target-supply =3D <&reg_ahci_5v>;
			status =3D "okay";
		};

...

        reg_ahci_5v: ahci-5v {
		status =3D "okay";
        };

Notice the addition of the 2nd node. This is why I ended up doing
2 separate dtsi files for the ahci and for the usb regulators.

To me saying:

/include/ "sunxi-ahci-reg.dtsi"

Makes it clear to the reader that the board has a ahci target-supply
regulator, so enabling it separately seems being overly verbose.

Of course of we change it to:

/include/ "sunxi-common-regulators.dtsi"

Then the verbosity / explicit enabling of various regulators becomes a
good thing, as it is not directly clear what the include does.

But if we do this, then for many boards we end up replacing:

/include/ "sunxi-ahci-reg.dtsi"
/include/ "sun4i-a10-usb-vbus-reg.dtsi"

With:

/include/ "sunxi-common-regulators.dtsi"

        reg_ahci_5v: ahci-5v {
		status =3D "okay";
        };

        reg_usb1_vbus: usb1-vbus {
		status =3D "okay";
        };

        reg_usb2_vbus: usb2-vbus {
		status =3D "okay";
        };

I prefer the shorter version, but I can completely understand if
you prefer the slightly more verbose version, this would also
get rid of having different usb regulator dtsi files for sun4i /
sun5i (as sun5i only has 1 usb host).

I hope this helps explain my reasoning, as said I'm fine with
either way, if you want to change over to a single file +
explicit enabling, let me know and I'll respin the ahci dts
patches.  Note I'm going on vacation for a week starting Monday,
so you likely won't get a new version until next weekend.

Regards,

Hans


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMI9jgACgkQF3VEtJrzE/tkEQCgm1V2Nga+RxsTELQUJxIl2Go3
4dkAnRK0CjK1YEapqN0anp2iltgp7smc
=3DfBXT
-----END PGP SIGNATURE-----

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
