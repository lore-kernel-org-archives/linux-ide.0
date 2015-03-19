From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: brcmstb: add nodes for SATA controller and
 PHY
Date: Thu, 19 Mar 2015 12:11:05 -0700
Message-ID: <20150319191105.GU32500@ld-irv-0074>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
 <1426728222-8197-5-git-send-email-computersforpeace@gmail.com>
 <550AAEA1.5080301@redhat.com>
 <20150319155358.GA19571@brian-ubuntu>
 <550B0118.3040104@redhat.com>
 <20150319173640.GS32500@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33729 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbCSTLO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Mar 2015 15:11:14 -0400
Content-Disposition: inline
In-Reply-To: <20150319173640.GS32500@ld-irv-0074>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Replying to myself, because I may or may not like having conversations
with myself :)

On Thu, Mar 19, 2015 at 10:36:40AM -0700, Brian Norris wrote:
> On Thu, Mar 19, 2015 at 06:02:16PM +0100, Hans de Goede wrote:
> > On 19-03-15 16:53, Brian Norris wrote:
> > >On Thu, Mar 19, 2015 at 12:10:25PM +0100, Hans de Goede wrote:
> > >>On 19-03-15 02:23, Brian Norris wrote:
> > >>>Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> > >>>---
> > >>>Light dependency on:
> > >>>   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331921.html
> > >>>for the surrounding text.
> > >>>
> > >>>  arch/arm/boot/dts/bcm7445.dtsi | 36 ++++++++++++++++++++++++++++++++++++
> > >>>  1 file changed, 36 insertions(+)
> > >>>
> > >>>diff --git a/arch/arm/boot/dts/bcm7445.dtsi b/arch/arm/boot/dts/bcm7445.dtsi
> > >>>index 9eaeac8dce1b..7a7c4d8c2afe 100644
> > >>>--- a/arch/arm/boot/dts/bcm7445.dtsi
> > >>>+++ b/arch/arm/boot/dts/bcm7445.dtsi
> > >>>@@ -108,6 +108,42 @@
> > >>>  			brcm,int-map-mask = <0x25c>, <0x7000000>;
> > >>>  			brcm,int-fwd-mask = <0x70000>;
> > >>>  		};
> > >>>+
> > >>>+		sata@f045a000 {
> > >>>+			compatible = "brcm,bcm7445-ahci", "brcm,sata3-ahci";
> > >>>+			reg-names = "ahci", "top-ctrl";
> > >>>+			reg = <0x45a000 0xa9c>, <0x458040 0x24>;
> > >>
> > >>Why not simply drop the second register range here, and the minimal top-ctrl
> > >>poking you need in the phy driver's phy_init function ?
> > >
> > >I agree it's a little ugly, but your recommended solution will not work.
> > >
> > >The 'top-ctrl' register range includes several SATA functionalities,
> > >some of which are required for the PHY and some of which are definitely
> > >required for the SATA driver.
> > 
> > I see, but the phy driver is required for the SATA driver anyways,
> > and since the BUS_CTRL setting seems to be static it might just as
> > well be set by the phy driver. The phy driver also poking some
> > common sata glue bits like this busctrl register is not unheard of,
> > esp. when these glue bits are in the phy register range.

I realized I *do* still have some reservations about moving the
SATA_TOP_CTRL register range under the PHY DT binding; it's because all
arguments for it seem to rest on descriptions of how the software would
*like* to handle it. It's not at all about describing the hardware
correctly.

I still see SATA_TOP_CTRL as a register resource that belongs to the
SATA controller, not to the PHY. It just happens that it has a few
registers in it that are also for use in the PHY.

So, to best describe the *hardware*, it seems we might split top-ctrl
into 3 portions, where the middle gets assigned to a phy description,
and the first and last belong to the SATA controller description.

But to most easily describe how *software* would best handle them, we
might stick all the custom stuff (i.e., all of top-ctrl + phy) into the
PHY description.

I still think that, practically speaking, the latter should work just
fine, and it's only a theoretical concern that suggests the former.

Thoughts?

> > >We have:
> > >
> > >0x00   VERSION
> > >0x04   BUS_CTRL
> > >0x08   TP_CTRL
> > >0x0C   PHY_CTRL_1
> > >0x10   PHY_CTRL_2
> > >0x14   PHY_CTRL_3
> > >0x18   PHY_CTRL_4
> > >0x1C   TP_OUT
> > >0x20   CLIENT_INIT_CTRL

[snip rest]

Brian
