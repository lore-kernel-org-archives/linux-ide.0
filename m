From: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 09/13] ARM: dts: sun8i: r40: add sata node
Date: Fri, 31 Aug 2018 12:54:12 +0200
Message-ID: <20180831105412.GD16301@Red>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-10-clabbe.montjoie@gmail.com>
 <20180831073500.zubqpvar4yhjqrge@flea>
 <20180831075631.GB16301@Red>
 <20180831102021.idz42sfgldihpkrp@flea>
Reply-To: clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBD7YLCN32UNBBWF4UTOAKGQEFED2NVI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20180831102021.idz42sfgldihpkrp@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Cc: axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Fri, Aug 31, 2018 at 12:20:21PM +0200, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org wrote:
> On Fri, Aug 31, 2018 at 09:56:31AM +0200, Corentin Labbe wrote:
> > On Fri, Aug 31, 2018 at 09:35:00AM +0200, Maxime Ripard wrote:
> > > On Thu, Aug 30, 2018 at 09:01:16PM +0200, Corentin Labbe wrote:
> > > > R40 have a sata controller which is the same as A20.
> > > > This patch adds a DT node for it.
> > > > 
> > > > Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> > > > Signed-off-by: Corentin Labbe <clabbe.montjoie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > ---
> > > >  arch/arm/boot/dts/sun8i-r40.dtsi | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > index 852c2ccc3268..d6b5820da850 100644
> > > > --- a/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > +++ b/arch/arm/boot/dts/sun8i-r40.dtsi
> > > > @@ -550,6 +550,29 @@
> > > >  			#size-cells = <0>;
> > > >  		};
> > > >  
> > > > +		ahci: sata@1c18000 {
> > > > +			compatible = "allwinner,sun8i-r40-ahci";
> > > > +			reg = <0x01c18000 0x1000>;
> > > > +			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> > > > +			clocks = <&ccu CLK_BUS_SATA>, <&ccu CLK_SATA>;
> > > > +			resets = <&ccu RST_BUS_SATA>;
> > > > +			resets-name = "ahci";
> > > > +			#address-cells = <1>;
> > > > +			#size-cells = <0>;
> > > > +			status = "disabled";
> > > > +
> > > > +			sata_port: sata-port@0 {
> > > > +				reg = <0>;
> > > > +				phys = <&sata_phy>;
> > > > +			};
> > > > +		};
> > > > +
> > > > +		sata_phy: sata-phy@1c180c0  {
> > > > +			compatible = "allwinner,sun8i-r40-sata-phy";
> > > > +			reg = <0x1c180c0 0x200>;
> > > 
> > > Overlapping devices in the DTS is not ok.
> > > 
> > 
> > I do the same than arch/arm/boot/dts/berlin2.dtsi (sata@e90000
> > phy@e900a0)
> >
> > But since it is not a good justification, it seems that regmap is my
> > only solution ?
> 
> I'm not even sure why you are moving the phy out of its original node
> (and driver).
> 

For using the phy-supply already handled by the code.
The other choice is to add another xxx-supply to ahci_platform.
Or to use hackily port_regulator for this regulator.
