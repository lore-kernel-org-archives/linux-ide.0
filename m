From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/5] ARM: dts: brcmstb: add nodes for SATA controller and
 PHY
Date: Thu, 19 Mar 2015 08:53:58 -0700
Message-ID: <20150319155358.GA19571@brian-ubuntu>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
 <1426728222-8197-5-git-send-email-computersforpeace@gmail.com>
 <550AAEA1.5080301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550AAEA1.5080301-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi Hans,

Thanks for the review.

On Thu, Mar 19, 2015 at 12:10:25PM +0100, Hans de Goede wrote:
> On 19-03-15 02:23, Brian Norris wrote:
> >Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >---
> >Light dependency on:
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331921.html
> >for the surrounding text.
> >
> >  arch/arm/boot/dts/bcm7445.dtsi | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
> >index 9eaeac8dce1b..7a7c4d8c2afe 100644
> >--- a/arch/arm/boot/dts/bcm7445.dtsi
> >+++ b/arch/arm/boot/dts/bcm7445.dtsi
> >@@ -108,6 +108,42 @@
> >  			brcm,int-map-mask = <0x25c>, <0x7000000>;
> >  			brcm,int-fwd-mask = <0x70000>;
> >  		};
> >+
> >+		sata@f045a000 {
> >+			compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
> >+			reg-names = "ahci", "top-ctrl";
> >+			reg = <0x45a000 0xa9c>, <0x458040 0x24>;
> 
> Why not simply drop the second register range here, and the minimal top-ctrl
> poking you need in the phy driver's phy_init function ?

I agree it's a little ugly, but your recommended solution will not work.

The 'top-ctrl' register range includes several SATA functionalities,
some of which are required for the PHY and some of which are definitely
required for the SATA driver. We have:

0x00   VERSION
0x04   BUS_CTRL
0x08   TP_CTRL
0x0C   PHY_CTRL_1
0x10   PHY_CTRL_2
0x14   PHY_CTRL_3
0x18   PHY_CTRL_4
0x1C   TP_OUT
0x20   CLIENT_INIT_CTRL

We *definitely* need the BUS_CTRL register in the SATA driver, since it
controls the endianness of the AHCI register set as well as a few other
important bits we may use in the future. So we can't just "drop" the
"minimal poking" and expect things to work, just because that makes the
device tree look nicer :)

The problem is what to do with the PHY_CTRL registers that are kept in
the middle of the block. These really belong as part of the PHY
power-on/power-off control sequence (i.e., PHY driver).

Do you have any better suggestions that don't involve dropping the
BUS_CTRL register from the SATA driver?

> This avoids the weird / ugly register overlap with the phy driver, and I think you
> can then just use the ahci_platform driver unmodified.
> 
> >+			interrupts = <GIC_SPI 30 0>;
> >+			#address-cells = <1>;
> >+			#size-cells = <0>;
> >+
> >+			sata0: sata-port@0 {
> >+				reg = <0>;
> >+				phys = <&sata_phy 0>;
> >+			};
> >+
> >+			sata1: sata-port@1 {
> >+				reg = <1>;
> >+				phys = <&sata_phy 1>;
> >+			};
> >+		};
> >+
> >+		sata_phy: sata-phy@f0458100 {
> >+			compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
> >+			reg = <0x458100 0x1e00>, <0x45804c 0x10>;
> 
> Why not simply use: reg = <0x458000 0x2000>, to me it seems that what you should
> really be using here.

0x458000 to 0x45800f and 0x458080 to 0x4580af belong to a debug
interrupt controller, which handles bus error handling. It's currently
unused, and it definitely doesn't belong here.

The 'phy' register range is actually documented as two sets of identical
registers:

0x458100 - 0x458fff  Port0 SATA PHY registers
0x459100 - 0x459fff  Port1 SATA PHY registers

with a hole between them. I definitely don't want to do the combining
that you suggested, but I could probably split them apart if that really
helps...

(BTW, I realized I have my math wrong, and each port has length 0xf00,
not 0xe00. So the range I posted should actually be <0x458100 0x1f00>.)

> >+			reg-names = "phy", "port-ctrl";
> >+			#phy-cells = <1>;
> >+			#address-cells = <0x1>;
> >+			#size-cells = <0x0>;
> >+
> >+			sata-phy@0 {
> >+				reg = <0>;
> >+			};
> >+
> >+			sata-phy@1 {
> >+				reg = <1>;
> >+			};
> >+		};
> >  	};
> >
> >  	smpboot {
> >

Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
