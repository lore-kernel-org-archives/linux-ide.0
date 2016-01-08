From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Fri, 08 Jan 2016 23:47:53 +0100
Message-ID: <9923043.nz8DJ6lRiJ@wuerfel>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com> <10869853.plxna0HzWE@wuerfel> <5690367E.8060609@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:59666 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251AbcAHWsu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Jan 2016 17:48:50 -0500
In-Reply-To: <5690367E.8060609@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-ide@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, tj@kernel.org

On Friday 08 January 2016 16:21:50 Brijesh Singh wrote:
> >> Should I consider adding a property "sgpio-ctrl" to pass the register 
> >> address ?
> >>
> >> e.g
> >>
> >> sata0@e0300000 {
> >>    compatible = "amd,seattle-ahci";
> >>    reg = <0 0xe0300000 0 0x800>;
> >>    amd,sgpio-ctrl = <0xe0000078>;
> >>    interrupts = <0 355 4>;
> >>    clocks = <&sataclk_333mhz>;
> >>    dma-coherent;
> >> };
> > 
> > We generally don't refer to register locations with properties other than
> > 'reg', so that approach would be worse. What I'd suggest you do is to
> > have the sgpio registers in a separate device node, and use the LED
> > binding to access it, see
> >  
> > Documentation/devicetree/bindings/leds/common.txt
> > 
> > It seems that none of the drivers/ata/ drivers use the leds interface
> > today, but that can be added to libata-*.c whenever the appropriate
> > properties are there.
> >
> 
> libata-*.c implements the "Enclosure management" style led messages but also has hooks
> to register a custom led control callback. Since Seattle platform does not support
> the "Enclosure management" registers hence ata_port_info we are setting a ATA_FLAG_EM | ATA_FLAG_SW_ACIVITY 
> to indicate that we can still handle the led messages by our registered callback. I see
> that sata_highbank driver is doing something similar.

But if the LEDs are the only thing that is special, I think it makes
more sense to extend the generic driver. This is similar to how the
ahci driver knows how to deal with external PHY, clk, regulator etc
resources. All of those are not part of the AHCI spec, but are common
enough that we want to have them done in a single driver.

We really should not need a special driver just for handling LEDs
when we already deal with more complex stuff, and we have a proper
abstraction for LEDs in the kernel.

> > 
> > That way, any driver that ends up needing a register from this block
> > can use the syscon interface to get hold of a mapping, and/or you can
> > have a high-level driver to expose other functionalities. It's probably
> > best to start doing it either entirely using syscon references from
> > other drivers, or using no syscon references, and putting everything into
> > a driver for the register set, but as I said it depends a lot on what
> > else is in there.
> > 
> > Can you send me a register list of the 0xe0000000 segment for reference?
> >
> Thanks for pointing syncon, are you thinking something like this ?
> 
>                 sgpio0: syscon@e0000078 {
>                         compatible = "amd, seattle-sgpio", syscon";
>                         reg = <0x0 0xe0000078 0x0 0x1>;
>                 };

A syscon is defined as (roughly) a group of otherwise unrelated registers
that happen to be part of the same physical register area because the SoC
designer couldn't find a proper abstraction for them. When you define
a register area with a single byte in it, that is not a syscon.

> 
>                 sata@e0300000 {
>                         compatible = "amd,seattle-ahci";
>                         reg = <0x0 0xe0300000 0x0 0xf0000>;
>                         interrupts = <0x0 0x163 0x4>;
>                         amd,sgpio-ctrl = <&sgpio0>;
>                         dma-coherent;
>                 };
> 


The sata node should list "generic-ahci" so we can bind the normal
driver. You can leave the "amd,seattle-ahci" in addition in case we
ever need to know the difference to work around a bug, but it's really
not needed for the LED.

> SGPIO0 (0xe0000078) and SGPIO1 (0xe000007C) does not belong to any system control register set.
> They are meant to be used by SATA driver only and no other driver should every touch it. It almost feels
> its just extension of the IP block but it just happened to be way out of the IP block range.
> Other register near to 0xe000_0078 and 0xe000_007C should not be mapped by OS.

That is quite normal, a lot of chips have register blocks where one
register is meant for one device only. E.g. the clock controller may have
one register for controlling the clocks of the AHCI device. In the old
days, we would have hacks like what you did to turn on the clocks by poking
the register from the SATA driver, but now we abstract those things using
generic subsystems.

I think you either want a special led controller device node that
refers to the syscon device and exports the LEDs so they can be
accessed by the AHCI device, or do it in the device that contains
the registers.

> But this syscon approach also brings another problem. Currently my code is pretty simple for mapping this regs
> 
> +       plat_data->sgpio_ctrl = devm_ioremap_resource(dev,
> +                             platform_get_resource(pdev, IORESOURCE_MEM, 1));
> +       if (IS_ERR(plat_data->sgpio_ctrl))
> +               return &ahci_port_info;
> +
> 
> The above code works on ACPI and DT cases. But if we go with syncon approach
> then we need to handle DT and ACPI differently. Because sycon will provide
> struct regmap instead of struct resources and also make reading/writing a 
> bit different. I was trying to minimize the DT vs ACPI changes in the driver
> (other than binding) hence I think defining two ranges in sata controller
> reg property was much cleaner and it aligns with DSDT.

Isn't this the thing that ACPI based firmware would handle using AML anyway?
I don't think the server people would be too happy to add a new driver
each time a SATA controller does the LEDs slightly differently, and this
is really the kind of platform specific hack that AML is meant for.

	Arnd
