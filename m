From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: brcmstb: add nodes for SATA controller and
 PHY
Date: Thu, 19 Mar 2015 10:36:40 -0700
Message-ID: <20150319173640.GS32500@ld-irv-0074>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
 <1426728222-8197-5-git-send-email-computersforpeace@gmail.com>
 <550AAEA1.5080301@redhat.com>
 <20150319155358.GA19571@brian-ubuntu>
 <550B0118.3040104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36343 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbbCSRgw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Mar 2015 13:36:52 -0400
Content-Disposition: inline
In-Reply-To: <550B0118.3040104@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Mar 19, 2015 at 06:02:16PM +0100, Hans de Goede wrote:
> On 19-03-15 16:53, Brian Norris wrote:
> >On Thu, Mar 19, 2015 at 12:10:25PM +0100, Hans de Goede wrote:
> >>On 19-03-15 02:23, Brian Norris wrote:
> >>>Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> >>>---
> >>>Light dependency on:
> >>>   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331921.html
> >>>for the surrounding text.
> >>>
> >>>  arch/arm/boot/dts/bcm7445.dtsi | 36 ++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 36 insertions(+)
> >>>
> >>>diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
> >>>index 9eaeac8dce1b..7a7c4d8c2afe 100644
> >>>--- a/arch/arm/boot/dts/bcm7445.dtsi
> >>>+++ b/arch/arm/boot/dts/bcm7445.dtsi
> >>>@@ -108,6 +108,42 @@
> >>>  			brcm,int-map-mask = <0x25c>, <0x7000000>;
> >>>  			brcm,int-fwd-mask = <0x70000>;
> >>>  		};
> >>>+
> >>>+		sata@f045a000 {
> >>>+			compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
> >>>+			reg-names = "ahci", "top-ctrl";
> >>>+			reg = <0x45a000 0xa9c>, <0x458040 0x24>;
> >>
> >>Why not simply drop the second register range here, and the minimal top-ctrl
> >>poking you need in the phy driver's phy_init function ?
> >
> >I agree it's a little ugly, but your recommended solution will not work.
> >
> >The 'top-ctrl' register range includes several SATA functionalities,
> >some of which are required for the PHY and some of which are definitely
> >required for the SATA driver.
> 
> I see, but the phy driver is required for the SATA driver anyways,
> and since the BUS_CTRL setting seems to be static it might just as
> well be set by the phy driver. The phy driver also poking some
> common sata glue bits like this busctrl register is not unheard of,
> esp. when these glue bits are in the phy register range.
> 
> >We have:
> >
> >0x00   VERSION
> >0x04   BUS_CTRL
> >0x08   TP_CTRL
> >0x0C   PHY_CTRL_1
> >0x10   PHY_CTRL_2
> >0x14   PHY_CTRL_3
> >0x18   PHY_CTRL_4
> >0x1C   TP_OUT
> >0x20   CLIENT_INIT_CTRL
> >
> >We *definitely* need the BUS_CTRL register in the SATA driver, since it
> >controls the endianness of the AHCI register set as well as a few other
> >important bits we may use in the future.
> 
> Are these bits non static, e.g. something which you may want to change at
> another time then init/shutdown/suspend/resume ? If they are static I still
> think this all clearly belongs in the phy driver, since this looks a lot
> like it is a single hardware block.

They are mostly static. I can't see right now anything (outside of the
PHY ctrl registers) that might ever need handled dynamically.

> If otoh these other bits may need runtime poking for e.g. sata error recovery,
> then I can understand why you want the bus ctrl register in the sata driver,
> but in that case it should only be mapped by the sata driver, and the phy driver
> register ranges should not cover it.
> 
> >So we can't just "drop" the
> >"minimal poking" and expect things to work, just because that makes the
> >device tree look nicer :)
> 
> I was not suggesting to drop it I was suggesting moving the poke to phy_init,
> and given the registermap you've shown above I still think that this belongs
> more in the phy driver then anywhere else.

Implicit in my statements so far was the assumption that the AHCI
platform driver would actually use info from the AHCI registers before
bringing up the PHY. For instance, my driver used to do something like
this:

0. configure AHCI register endianness
1. check AHCI HOST_PORTS_IMPL
2. enable phy(s) for port(s) that are available

(This would automatically account for cases where one or more port(s) are
OTP'd out.)

Such a sequence would require that the AHCI registers are prepared for
use before the PHY driver ever comes into play. But I now see that such
a sequence is not done, and that your suggestion would actually work.
The OTP cases can be handled by disabling the PHY subnodes in the device
tree.

BTW, BUS_CTRL also contains a bit for allowing re-configuration of the
AHCI CAPS register, and we'll probably need to use this soon. I see that
this would probably actually be a PHY-dependent operation, since we will
have some SoCs where features are buggy and should be disabled, and
conversely other SoCs where new features are disabled by default, but
can be enabled after silicon verification confirms they are "good."
(Particularly: AHCI link power management.) I'm not sure whether these
would be properties of the SATA driver or of the PHY driver.

All in all, I think I'm leaning toward your suggestion of moving this
all to the phy driver, and just using 'generic-ahci' directly. I would,
of course, still like to define a 'brcm,bcm7445-ahci' compatible string,
in case we need to differentiate from other 'generic' AHCI eventually.

> >The problem is what to do with the PHY_CTRL registers that are kept in
> >the middle of the block. These really belong as part of the PHY
> >power-on/power-off control sequence (i.e., PHY driver).
> >
> >Do you have any better suggestions that don't involve dropping the
> >BUS_CTRL register from the SATA driver?
> 
> Nope, if you really believe that the bus-ctrl register should be part of
> the sata driver, then please just split the register ranges at a per register
> level, to remove the overlap + the hack of not claiming the resource on one side.

I though of that earlier, but that's even uglier IMO :)

Unless my comments earlier in the email change, I think I'll lean toward
your former suggestion, actually.

> >>This avoids the weird / ugly register overlap with the phy driver, and I think you
> >>can then just use the ahci_platform driver unmodified.
> >>
> >>>+			interrupts = <GIC_SPI 30 0>;
> >>>+			#address-cells = <1>;
> >>>+			#size-cells = <0>;
> >>>+
> >>>+			sata0: sata-port@0 {
> >>>+				reg = <0>;
> >>>+				phys = <&sata_phy 0>;
> >>>+			};
> >>>+
> >>>+			sata1: sata-port@1 {
> >>>+				reg = <1>;
> >>>+				phys = <&sata_phy 1>;
> >>>+			};
> >>>+		};
> >>>+
> >>>+		sata_phy: sata-phy@f0458100 {
> >>>+			compatible = "brcm,bcm7445-sata-phy", "brcm,phy-sata3";
> >>>+			reg = <0x458100 0x1e00>, <0x45804c 0x10>;
> >>
> >>Why not simply use: reg = <0x458000 0x2000>, to me it seems that what you should
> >>really be using here.
> >
> >0x458000 to 0x45800f and 0x458080 to 0x4580af belong to a debug
> >interrupt controller, which handles bus error handling. It's currently
> >unused, and it definitely doesn't belong here.
> >
> >The 'phy' register range is actually documented as two sets of identical
> >registers:
> >
> >0x458100 - 0x458fff  Port0 SATA PHY registers
> >0x459100 - 0x459fff  Port1 SATA PHY registers
> >
> >with a hole between them. I definitely don't want to do the combining
> >that you suggested, but I could probably split them apart if that really
> >helps...
> 
> If this is the documented register range, then I think that splitting them makes
> sense, and assuming that the init code for both ports is the same it may
> even make for cleaner code.

Eh, it doesn't do too much for the code. We'll just now have to grab two
different resources "by name", and then do the register reads/writes by
pulling from two different __iomem regions, instead of a single one plus
an offset of (0x1000 * portnum). Not much difference.

But yes, I can split the regions if that helps make the description
better (TM).

Brian
