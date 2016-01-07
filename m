From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Fri, 08 Jan 2016 00:42:54 +0100
Message-ID: <4983521.tEaWggKCCv@wuerfel>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com> <4652600.rUhSEOUPkl@wuerfel> <568EE596.3060005@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:54692 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbcAGXnr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jan 2016 18:43:47 -0500
In-Reply-To: <568EE596.3060005@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-ide@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, tj@kernel.org

On Thursday 07 January 2016 16:24:22 Brijesh Singh wrote:
> >> +
> >> +Examples:
> >> +        sata0@e0300000 {
> >> +            compatible = "amd,seattle-ahci";
> >> +            reg = <0x0 0xe0300000 0x0 0xf0000>, <0x0 0xe0000078 0x0 0x1>;
> > 
> > Looking at the register values, I doubt that the SGPIO is actually part of the
> > sata device. More likely, you are pointing in the middle of an actual
> > GPIO controller.
> > 
> 
> That address is SGPIO control register for SATA. The current hardware implementation to control activity LED is not ideal.

Of course its a control register "for" SATA, what I meant is that it's
not part "of" the SATA IP block, which is hopefully a standard AHCI
compliant part as required by SBSA.

> A57 does not have access to GPIO's connected to backplane controller
> instead SoC has exposed two SGPIO control registers (LSIOC_SGPIO_CONTROL0:
> 0xE000_0078 and LSIOC_SGPIO_CONTROL1: 0xE000_007C) to A57. All we 
> need to do is to program these registers based on the disk activity.
> The firmware running on A5 reads the values and generate proper SGPIO
> timing and toggles the LEDs etc.

It still sounds like SGPIO is not part of the AHCI standard spec, but
rather a subset of a device called LSIOC.

> These registers are defined in SATA0/1 DSDT resource template and also
> documented in SoC BKDG. I just noticed that BKDG has wrong register
> definition so will ask documentation folks to fix that.
> 
> This driver is using SGPIO LED control similar to sata_highbank [1]
> except bit bang GPIO (which is done by firmware).
> 
> [1] http://lxr.free-electrons.com/source/drivers/ata/sata_highbank.c#L140

This one is rather different: there is a single device that combines
registers for AHCI, the PHY attached to it and the LED. This is not
SBSA compliant of course, and it requires having a special driver.

What you have instead looks like a regular AHCI implementation that
should just work with the standard driver as long as you describe how
it gets its LEDs.

	Arnd
