From: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Fri, 8 Jan 2016 16:21:50 -0600
Message-ID: <5690367E.8060609@amd.com>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
 <4983521.tEaWggKCCv@wuerfel> <568F14E0.4060107@amd.com>
 <10869853.plxna0HzWE@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-by2on0097.outbound.protection.outlook.com ([207.46.100.97]:33696
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755833AbcAHWYD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jan 2016 17:24:03 -0500
In-Reply-To: <10869853.plxna0HzWE@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: brijesh.singh@amd.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-ide@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, tj@kernel.org

Hi,


>> Should I consider adding a property "sgpio-ctrl" to pass the register 
>> address ?
>>
>> e.g
>>
>> sata0@e0300000 {
>>    compatible = "amd,seattle-ahci";
>>    reg = <0 0xe0300000 0 0x800>;
>>    amd,sgpio-ctrl = <0xe0000078>;
>>    interrupts = <0 355 4>;
>>    clocks = <&sataclk_333mhz>;
>>    dma-coherent;
>> };
> 
> We generally don't refer to register locations with properties other than
> 'reg', so that approach would be worse. What I'd suggest you do is to
> have the sgpio registers in a separate device node, and use the LED
> binding to access it, see
>  
> Documentation/devicetree/bindings/leds/common.txt
> 
> It seems that none of the drivers/ata/ drivers use the leds interface
> today, but that can be added to libata-*.c whenever the appropriate
> properties are there.
>

libata-*.c implements the "Enclosure management" style led messages but also has hooks
to register a custom led control callback. Since Seattle platform does not support
the "Enclosure management" registers hence ata_port_info we are setting a ATA_FLAG_EM | ATA_FLAG_SW_ACIVITY 
to indicate that we can still handle the led messages by our registered callback. I see
that sata_highbank driver is doing something similar.
 
>> Yes, its regular AHCI implementation and works well with ahci_platform 
>> driver. In standard ahci_platform driver activity LEDs are blinked 
>> through enclosure management interface. Given the current hardware 
>> limitation it seems like creating a new driver would be cleaner. I am 
>> open to suggestion.
> 
> I'd say the code in drivers/ata should be kept completely generic, referring
> only to the include/linux/leds.h interfaces and properties added to
> Documentation/devicetree/bindings/ata/ahci-platform.txt (if any).
> 
> For the driver that actually owns the register, it depends a bit on how
> the hardware is structured, and you'd need to look at the datasheet (or
> talk to a hardware designer) for that.
> 
> I suspect we should have a node for the entire block of registers
> around the SGPIO, presumably something like
> 
> 	syscon@0xe0000000 {
> 		compatible = "amd,$SOC_ID"-lsioc", "syscon";
> 		reg = <0xe0000000 0x1000>; /* find the actual length in the datasheet */
> 	};
> 
> That way, any driver that ends up needing a register from this block
> can use the syscon interface to get hold of a mapping, and/or you can
> have a high-level driver to expose other functionalities. It's probably
> best to start doing it either entirely using syscon references from
> other drivers, or using no syscon references, and putting everything into
> a driver for the register set, but as I said it depends a lot on what
> else is in there.
> 
> Can you send me a register list of the 0xe0000000 segment for reference?
>
Thanks for pointing syncon, are you thinking something like this ?

                sgpio0: syscon@e0000078 {
                        compatible = "amd, seattle-sgpio", syscon";
                        reg = <0x0 0xe0000078 0x0 0x1>;
                };

                sata@e0300000 {
                        compatible = "amd,seattle-ahci";
                        reg = <0x0 0xe0300000 0x0 0xf0000>;
                        interrupts = <0x0 0x163 0x4>;
                        amd,sgpio-ctrl = <&sgpio0>;
                        dma-coherent;
                };

SGPIO0 (0xe0000078) and SGPIO1 (0xe000007C) does not belong to any system control register set.
They are meant to be used by SATA driver only and no other driver should every touch it. It almost feels
its just extension of the IP block but it just happened to be way out of the IP block range.
Other register near to 0xe000_0078 and 0xe000_007C should not be mapped by OS.

But this syscon approach also brings another problem. Currently my code is pretty simple for mapping this regs

+       plat_data->sgpio_ctrl = devm_ioremap_resource(dev,
+                             platform_get_resource(pdev, IORESOURCE_MEM, 1));
+       if (IS_ERR(plat_data->sgpio_ctrl))
+               return &ahci_port_info;
+

The above code works on ACPI and DT cases. But if we go with syncon approach then we need to handle DT and ACPI differently. Because sycon will provide struct regmap instead of struct resources and also make reading/writing a bit different. I was trying to minimize the DT vs ACPI changes in the driver (other than binding) hence I think defining two ranges in sata controller reg property was much cleaner and it aligns with DSDT.

Just for reference the SATA DSDT looks like this:

Device (SATA0)
{
	.....

	Name(_CRS, ResourceTemplate()
	{
		Memory32Fixed(ReadWrite, 0xE03000000, 0x000010000)
		Interrupt(ResourceConsumer, Level, ActiveHigh Exclusive,,,) { 387}
		Memory32Fixed(ReadWrite, 0xE00000078, 1)
	}

	......
}

> 
> 	Arnd
> 
