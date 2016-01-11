From: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Mon, 11 Jan 2016 12:56:02 -0600
Message-ID: <5693FAC2.4070003@amd.com>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
 <10869853.plxna0HzWE@wuerfel> <5690367E.8060609@amd.com>
 <9923043.nz8DJ6lRiJ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bl2on0092.outbound.protection.outlook.com ([65.55.169.92]:51090
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934077AbcAKS6S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Jan 2016 13:58:18 -0500
In-Reply-To: <9923043.nz8DJ6lRiJ@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: brijesh.singh@amd.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-ide@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, tj@kernel.org

Hi Arnd,

Thanks for all your valuable feedbacks.

On 01/08/2016 04:47 PM, Arnd Bergmann wrote:
>>
>> libata-*.c implements the "Enclosure management" style led messages but also has hooks
>> to register a custom led control callback. Since Seattle platform does not support
>> the "Enclosure management" registers hence ata_port_info we are setting a ATA_FLAG_EM | ATA_FLAG_SW_ACIVITY 
>> to indicate that we can still handle the led messages by our registered callback. I see
>> that sata_highbank driver is doing something similar.
> 
> But if the LEDs are the only thing that is special, I think it makes
> more sense to extend the generic driver. This is similar to how the
> ahci driver knows how to deal with external PHY, clk, regulator etc
> resources. All of those are not part of the AHCI spec, but are common
> enough that we want to have them done in a single driver.
> 
> We really should not need a special driver just for handling LEDs
> when we already deal with more complex stuff, and we have a proper
> abstraction for LEDs in the kernel.
> 

I took a quick look at LED class and saw ledtrig-ide-disk.c (ledtrig_ide_activity). It seems this approach was used
in deprecate ide-disk driver for blinking the activity led. Are you thinking that we implement something similar
in libahci to control the LED blinking? Looking at current libahci gives me feeling that LED's are considered as
 part of AHCI enclosure management implementation and hence LED triggers are not exposed outside the library. 
If I am missing something then please correct me.
 
> 
> A syscon is defined as (roughly) a group of otherwise unrelated registers
> that happen to be part of the same physical register area because the SoC
> designer couldn't find a proper abstraction for them. When you define
> a register area with a single byte in it, that is not a syscon.
> 
>>
>>                 sata@e0300000 {
>>                         compatible = "amd,seattle-ahci";
>>                         reg = <0x0 0xe0300000 0x0 0xf0000>;
>>                         interrupts = <0x0 0x163 0x4>;
>>                         amd,sgpio-ctrl = <&sgpio0>;
>>                         dma-coherent;
>>                 };
>>
> 
> 
> The sata node should list "generic-ahci" so we can bind the normal
> driver. You can leave the "amd,seattle-ahci" in addition in case we
> ever need to know the difference to work around a bug, but it's really
> not needed for the LED.
> 
>> SGPIO0 (0xe0000078) and SGPIO1 (0xe000007C) does not belong to any system control register set.
>> They are meant to be used by SATA driver only and no other driver should every touch it. It almost feels
>> its just extension of the IP block but it just happened to be way out of the IP block range.
>> Other register near to 0xe000_0078 and 0xe000_007C should not be mapped by OS.
> 
> That is quite normal, a lot of chips have register blocks where one
> register is meant for one device only. E.g. the clock controller may have
> one register for controlling the clocks of the AHCI device. In the old
> days, we would have hacks like what you did to turn on the clocks by poking
> the register from the SATA driver, but now we abstract those things using
> generic subsystems.
> 
> I think you either want a special led controller device node that
> refers to the syscon device and exports the LEDs so they can be
> accessed by the AHCI device, or do it in the device that contains
> the registers.
> 
>> But this syscon approach also brings another problem. Currently my code is pretty simple for mapping this regs
>>
>> +       plat_data->sgpio_ctrl = devm_ioremap_resource(dev,
>> +                             platform_get_resource(pdev, IORESOURCE_MEM, 1));
>> +       if (IS_ERR(plat_data->sgpio_ctrl))
>> +               return &ahci_port_info;
>> +
>>
>> The above code works on ACPI and DT cases. But if we go with syncon approach
>> then we need to handle DT and ACPI differently. Because sycon will provide
>> struct regmap instead of struct resources and also make reading/writing a 
>> bit different. I was trying to minimize the DT vs ACPI changes in the driver
>> (other than binding) hence I think defining two ranges in sata controller
>> reg property was much cleaner and it aligns with DSDT.
> 
> Isn't this the thing that ACPI based firmware would handle using AML anyway?
> I don't think the server people would be too happy to add a new driver
> each time a SATA controller does the LEDs slightly differently, and this
> is really the kind of platform specific hack that AML is meant for.
> 
Sorry I am not able understand your comment, Could you please explain me what you mean by AML is meant for this kind of platform specific hack ?

"SATA0" and "SATA1" DSDT Resource template contains two resources (#0 SATA block register and #1 SGPIO control register).

Device (SATA0)
{
	Name(_CRS, ResourceTemplate()
	{
		Memory32Fixed(ReadWrite, 0xE03000000, 0x000010000)
		Interrupt(ResourceConsumer, Level, ActiveHigh Exclusive,,,) { 387}
		Memory32Fixed(ReadWrite, 0xE00000078, 1)
	}
}

Device (SATA1)
{
	Name(_CRS, ResourceTemplate()
	{
		Memory32Fixed(ReadWrite, 0xE0D100000, 0x000010000)
		Interrupt(ResourceConsumer, Level, ActiveHigh Exclusive,,,) { 393}
		Memory32Fixed(ReadWrite, 0xE0000007C, 1)
	}
}

The generic ahci platform driver calls ahci_platform_get_resources() to get the resources.
ahci_platform_get_resources() maps the resource #0. Since the SGPIO control resource is part of SATA device
resource hence I could simply ioremap resource #1 for both DT and ACPI cases.  Since windows driver is making
use of same DSDT hence its going to be tricky to modify the DSDT to create a new device entry for SATA LED.

Before creating a new driver, I did attempt to extend the existing ahci_platform driver and was able to get it working but it was not looking good hence created a new driver. One of the issue was knowing when to map
the SGPIO control register in ACPI case. ahci_platform driver does binding based on _CLS mask so I was not sure
whether doing ioremap of resource#1 is safe and would not cause problem on non Seattle platform. If you want then
i can send you patch for quick comment and see if that make sense instead of adding a new driver.

 
> 	Arnd
> 
