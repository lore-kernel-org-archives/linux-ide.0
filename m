From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Fri, 08 Jan 2016 09:46:50 +0100
Message-ID: <10869853.plxna0HzWE@wuerfel>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com> <4983521.tEaWggKCCv@wuerfel> <568F14E0.4060107@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64780 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbcAHIrd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jan 2016 03:47:33 -0500
In-Reply-To: <568F14E0.4060107@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-ide@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, tj@kernel.org

On Thursday 07 January 2016 19:46:08 Brijesh Singh wrote:
> Hi,
> 
> On 01/07/2016 05:42 PM, Arnd Bergmann wrote:
> > On Thursday 07 January 2016 16:24:22 Brijesh Singh wrote:
> >>>> +
> >>>> +Examples:
> >>>> +        sata0@e0300000 {
> >>>> +            compatible = "amd,seattle-ahci";
> >>>> +            reg = <0x0 0xe0300000 0x0 0xf0000>, <0x0 0xe0000078 0x0 0x1>;
> >>>
> >>> Looking at the register values, I doubt that the SGPIO is actually part of the
> >>> sata device. More likely, you are pointing in the middle of an actual
> >>> GPIO controller.
> >>>
> >>
> >> That address is SGPIO control register for SATA. The current hardware implementation to control activity LED is not ideal.
> >
> > Of course its a control register "for" SATA, what I meant is that it's
> > not part "of" the SATA IP block, which is hopefully a standard AHCI
> > compliant part as required by SBSA.
> >
> Yes, its not part of SATA IP block. We just need a method of pass  SGPIO 
> control register address to driver.
> 
> Should I consider adding a property "sgpio-ctrl" to pass the register 
> address ?
> 
> e.g
> 
> sata0@e0300000 {
>    compatible = "amd,seattle-ahci";
>    reg = <0 0xe0300000 0 0x800>;
>    amd,sgpio-ctrl = <0xe0000078>;
>    interrupts = <0 355 4>;
>    clocks = <&sataclk_333mhz>;
>    dma-coherent;
> };

We generally don't refer to register locations with properties other than
'reg', so that approach would be worse. What I'd suggest you do is to
have the sgpio registers in a separate device node, and use the LED
binding to access it, see
 
Documentation/devicetree/bindings/leds/common.txt

It seems that none of the drivers/ata/ drivers use the leds interface
today, but that can be added to libata-*.c whenever the appropriate
properties are there.

> > This one is rather different: there is a single device that combines
> > registers for AHCI, the PHY attached to it and the LED. This is not
> > SBSA compliant of course, and it requires having a special driver.
> >
> > What you have instead looks like a regular AHCI implementation that
> > should just work with the standard driver as long as you describe how
> > it gets its LEDs.
> >
> Yes, its regular AHCI implementation and works well with ahci_platform 
> driver. In standard ahci_platform driver activity LEDs are blinked 
> through enclosure management interface. Given the current hardware 
> limitation it seems like creating a new driver would be cleaner. I am 
> open to suggestion.

I'd say the code in drivers/ata should be kept completely generic, referring
only to the include/linux/leds.h interfaces and properties added to
Documentation/devicetree/bindings/ata/ahci-platform.txt (if any).

For the driver that actually owns the register, it depends a bit on how
the hardware is structured, and you'd need to look at the datasheet (or
talk to a hardware designer) for that.

I suspect we should have a node for the entire block of registers
around the SGPIO, presumably something like

	syscon@0xe0000000 {
		compatible = "amd,$SOC_ID"-lsioc", "syscon";
		reg = <0xe0000000 0x1000>; /* find the actual length in the datasheet */
	};

That way, any driver that ends up needing a register from this block
can use the syscon interface to get hold of a mapping, and/or you can
have a high-level driver to expose other functionalities. It's probably
best to start doing it either entirely using syscon references from
other drivers, or using no syscon references, and putting everything into
a driver for the register set, but as I said it depends a lot on what
else is in there.

Can you send me a register list of the 0xe0000000 segment for reference?


	Arnd
