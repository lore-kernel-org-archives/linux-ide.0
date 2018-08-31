From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
Date: Fri, 31 Aug 2018 15:58:34 +0800
Message-ID: <CAGb2v65dWmFxacx16taTdDf0WO4vCJfJLrf=7Vh6RtJEjHdH5A@mail.gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-10-clabbe.montjoie@gmail.com> <20180831073500.zubqpvar4yhjqrge@flea>
 <20180831075631.GB16301@Red>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831075631.GB16301@Red>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, axboe@kernel.dk, Hans de Goede <hdegoede@redhat.com>, Kishon Vijay Abraham I <kishon@ti.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>, Icenowy Zheng <icenowy@aosc.io>
List-Id: linux-ide@vger.kernel.org

On Fri, Aug 31, 2018 at 3:56 PM Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
>
> On Fri, Aug 31, 2018 at 09:35:00AM +0200, Maxime Ripard wrote:
> > On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe wrote:
> > > R40 have a sata controller which is the same as A20.
> > > This patch adds a DT node for it.
> > >
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > index 852c2ccc3268..d6b5820da850 100644
> > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > @@ -550,6 +550,29 @@
> > >                     #size-cells = <0>;
> > >             };
> > >
> > > +           ahci: sata@1c18000 {
> > > +                   compatible = "allwinner,sun8i-r40-ahci";
> > > +                   reg = <0x01c18000 0x1000>;
> > > +                   interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > > +                   clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > > +                   resets = <&ccu RST_BUS_SATA>;
> > > +                   resets-name = "ahci";
> > > +                   #address-cells = <1>;
> > > +                   #size-cells = <0>;
> > > +                   status = "disabled";
> > > +
> > > +                   sata_port: sata-port@0 {
> > > +                           reg = <0>;
> > > +                           phys = <&sata_phy>;
> > > +                   };
> > > +           };
> > > +
> > > +           sata_phy: sata-phy@1c180c0  {
> > > +                   compatible = "allwinner,sun8i-r40-sata-phy";
> > > +                   reg = <0x1c180c0 0x200>;
> >
> > Overlapping devices in the DTS is not ok.
> >
>
> I do the same than arch/arm/boot/dts/berlin2.dtsi (sata@e90000 phy@e900a0)
> But since it is not a good justification, it seems that regmap is my only solution ?

Since you are effectively splitting one device node into two, you should
adjust the original (ahci) device nodes register range.

ChenYu
