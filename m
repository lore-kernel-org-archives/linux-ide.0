From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: Re: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
Date: Fri, 31 Aug 2018 20:58:33 +0800
Message-ID: <726cc22e89b058a708df0f3fc2523af42b8c3518.camel@aosc.io>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
	 <20180830190120.722-10-clabbe.montjoie@gmail.com>
	 <20180831073500.zubqpvar4yhjqrge@flea> <20180831075631.GB16301@Red>
	 <20180831102021.idz42sfgldihpkrp@flea> <20180831105412.GD16301@Red>
	 <CAGb2v65m73mZkQ9qbYne-utZPujEvRftYGz5kYCx=8t-C-=DJQ@mail.gmail.com>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBCHXUTOAKGQEJZHLIIA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v65m73mZkQ9qbYne-utZPujEvRftYGz5kYCx=8t-C-=DJQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, LABBE Corentin <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

=E5=9C=A8 2018-08-31=E4=BA=94=E7=9A=84 19:31 +0800=EF=BC=8CChen-Yu Tsai=E5=
=86=99=E9=81=93=EF=BC=9A
> On Fri, Aug 31, 2018 at 6:54 PM Corentin Labbe
> <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >=20
> > On Fri, Aug 31, 2018 at 12:20:21PM +0200, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
> >  wrote:
> > > On Fri, Aug 31, 2018 at 09:56:31AM +0200, Corentin Labbe wrote:
> > > > On Fri, Aug 31, 2018 at 09:35:00AM +0200, Maxime Ripard wrote:
> > > > > On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe
> > > > > wrote:
> > > > > > R40 have a sata controller which is the same as A20.
> > > > > > This patch adds a DT node for it.
> > > > > >=20
> > > > > > Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> > > > > > Signed-off-by: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > > > ---
> > > > > >  arch/arm/boot/dts/sun8i-r40.dtsi | 23
> > > > > > +++++++++++++++++++++++
> > > > > >  1 file changed, 23 insertions(+)
> > > > > >=20
> > > > > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > > b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > > index 852c2ccc3268..d6b5820da850 100644
> > > > > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > > > @@ -550,6 +550,29 @@
> > > > > >                         #size-cells =3D <0>;
> > > > > >                 };
> > > > > >=20
> > > > > > +               ahci: sata@1c18000 {
> > > > > > +                       compatible =3D "allwinner,sun8i-r40-
> > > > > > ahci";
> > > > > > +                       reg =3D <0x01c18000 0x1000>;
> > > > > > +                       interrupts =3D <GIC_SPI 56
> > > > > > IRQ_TYPE_LEVEL_HIGH>;
> > > > > > +                       clocks =3D <&ccu CLK_BUS_SATA>, <&ccu
> > > > > > CLK_SATA>;
> > > > > > +                       resets =3D <&ccu RST_BUS_SATA>;
> > > > > > +                       resets-name =3D "ahci";
> > > > > > +                       #address-cells =3D <1>;
> > > > > > +                       #size-cells =3D <0>;
> > > > > > +                       status =3D "disabled";
> > > > > > +
> > > > > > +                       sata_port: sata-port@0 {
> > > > > > +                               reg =3D <0>;
> > > > > > +                               phys =3D <&sata_phy>;
> > > > > > +                       };
> > > > > > +               };
> > > > > > +
> > > > > > +               sata_phy: sata-phy@1c180c0  {
> > > > > > +                       compatible =3D "allwinner,sun8i-r40-
> > > > > > sata-phy";
> > > > > > +                       reg =3D <0x1c180c0 0x200>;
> > > > >=20
> > > > > Overlapping devices in the DTS is not ok.
> > > > >=20
> > > >=20
> > > > I do the same than arch/arm/boot/dts/berlin2.dtsi (sata@e90000
> > > > phy@e900a0)
> > > >=20
> > > > But since it is not a good justification, it seems that regmap
> > > > is my
> > > > only solution ?
> > >=20
> > > I'm not even sure why you are moving the phy out of its original
> > > node
> > > (and driver).
> > >=20
> >=20
> > For using the phy-supply already handled by the code.
> > The other choice is to add another xxx-supply to ahci_platform.
> > Or to use hackily port_regulator for this regulator.
>=20
> The PHY registers are in the AHCI's "vendor specific registers"
> region. Following that are the per-port registers, which the ahci
> driver will need access to. This doesn't look like it should
> deserve a separate device node.
>=20
> What's wrong with handling the regulator directly in the ahci-sunxi
> PHY init code?

I remember I sent a patch that did this some times ago, and gets
rejected.

>=20
> ChenYu

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
