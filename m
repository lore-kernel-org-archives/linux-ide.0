From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Tue, 12 Jan 2016 15:24:19 +0100
Message-ID: <4689728.Nn3Rl2cUeP@wuerfel>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com> <9923043.nz8DJ6lRiJ@wuerfel> <5693FAC2.4070003@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5693FAC2.4070003-5C7GfCeVMHo@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brijesh Singh <brijesh.singh-5C7GfCeVMHo@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-ide@vger.kernel.org

On Monday 11 January 2016 12:56:02 Brijesh Singh wrote:
> Hi Arnd,
> 
> Thanks for all your valuable feedbacks.
> 
> On 01/08/2016 04:47 PM, Arnd Bergmann wrote:
> >>
> >> libata-*.c implements the "Enclosure management" style led messages but also has hooks
> >> to register a custom led control callback. Since Seattle platform does not support
> >> the "Enclosure management" registers hence ata_port_info we are setting a ATA_FLAG_EM | ATA_FLAG_SW_ACIVITY 
> >> to indicate that we can still handle the led messages by our registered callback. I see
> >> that sata_highbank driver is doing something similar.
> > 
> > But if the LEDs are the only thing that is special, I think it makes
> > more sense to extend the generic driver. This is similar to how the
> > ahci driver knows how to deal with external PHY, clk, regulator etc
> > resources. All of those are not part of the AHCI spec, but are common
> > enough that we want to have them done in a single driver.
> > 
> > We really should not need a special driver just for handling LEDs
> > when we already deal with more complex stuff, and we have a proper
> > abstraction for LEDs in the kernel.
> > 
> 
> I took a quick look at LED class and saw ledtrig-ide-disk.c (ledtrig_ide_activity). It seems this approach was used
> in deprecate ide-disk driver for blinking the activity led. Are you thinking that we implement something similar
> in libahci to control the LED blinking? 

Yes. I'm not overly familiar with the LED framework, but it seems to me that
something along those lines is the right idea. Note that the driver predates
devicetree and it only handles a single LED, so you probably need to do
something a bit more sophisticated to handle each LED separately and connect
it do the right disk through DT.

We actually seem to have quite a number of platforms relying on this:

$ git grep -w "ide-disk"
Documentation/devicetree/bindings/leds/common.txt:     "ide-disk" - LED indicates disk activity
Documentation/devicetree/bindings/leds/leds-gpio.txt:           linux,default-trigger = "ide-disk";
arch/arm/boot/dts/am57xx-beagle-x15.dts:                        linux,default-trigger = "ide-disk";
arch/arm/boot/dts/kirkwood-ns2lite.dts:                 linux,default-trigger = "ide-disk";
arch/arm/boot/dts/kirkwood-topkick.dts:                 linux,default-trigger = "ide-disk";
arch/arm/mach-davinci/board-dm644x-evm.c:               .default_trigger = "ide-disk", },
arch/arm/mach-omap1/board-osk.c:                        .default_trigger = "ide-disk", },
arch/arm/mach-pxa/spitz.c:              .default_trigger        = "ide-disk",
arch/mips/txx9/generic/setup.c:         "ide-disk",
arch/mips/txx9/rbtx4939/setup.c:                "ide-disk",
arch/powerpc/boot/dts/mpc8315erdb.dts:                  linux,default-trigger = "ide-disk";
arch/powerpc/boot/dts/mpc8377_rdb.dts:                  linux,default-trigger = "ide-disk";
arch/powerpc/boot/dts/mpc8378_rdb.dts:                  linux,default-trigger = "ide-disk";
arch/powerpc/boot/dts/mpc8379_rdb.dts:                  linux,default-trigger = "ide-disk";
arch/unicore32/kernel/gpio.c:           .default_trigger = "ide-disk", },
drivers/leds/leds-hp6xx.c:      .default_trigger        = "ide-disk",
drivers/leds/trigger/Makefile:obj-$(CONFIG_LEDS_TRIGGER_IDE_DISK)       += ledtrig-ide-disk.o
drivers/leds/trigger/ledtrig-camera.c: * based on ledtrig-ide-disk.c
drivers/leds/trigger/ledtrig-ide-disk.c:        led_trigger_register_simple("ide-disk", &ledtrig_ide);
drivers/macintosh/Kconfig:        and the ide-disk LED trigger and configure appropriately through
drivers/macintosh/via-pmu-led.c:        .default_trigger = "ide-disk",

I suspect this used to work in the past, but got broken when people moved
away from drivers/ide to drivers/ata, and nobody properly debugged the problem.

If you fix this right, the LEDs on all those platforms should light up again.

> Looking at current libahci gives me feeling that LED's are considered as
>  part of AHCI enclosure management implementation and hence LED triggers
> are not exposed outside the library. 
> If I am missing something then please correct me.

Yes, this sounds correct.
  
> > A syscon is defined as (roughly) a group of otherwise unrelated registers
> > that happen to be part of the same physical register area because the SoC
> > designer couldn't find a proper abstraction for them. When you define
> > a register area with a single byte in it, that is not a syscon.
> > 
> >>
> >>                 sata@e0300000 {
> >>                         compatible = "amd,seattle-ahci";
> >>                         reg = <0x0 0xe0300000 0x0 0xf0000>;
> >>                         interrupts = <0x0 0x163 0x4>;
> >>                         amd,sgpio-ctrl = <&sgpio0>;
> >>                         dma-coherent;
> >>                 };
> >>
> > 
> > 
> > The sata node should list "generic-ahci" so we can bind the normal
> > driver. You can leave the "amd,seattle-ahci" in addition in case we
> > ever need to know the difference to work around a bug, but it's really
> > not needed for the LED.
> > 
> >> SGPIO0 (0xe0000078) and SGPIO1 (0xe000007C) does not belong to any system control register set.
> >> They are meant to be used by SATA driver only and no other driver should every touch it. It almost feels
> >> its just extension of the IP block but it just happened to be way out of the IP block range.
> >> Other register near to 0xe000_0078 and 0xe000_007C should not be mapped by OS.
> > 
> > That is quite normal, a lot of chips have register blocks where one
> > register is meant for one device only. E.g. the clock controller may have
> > one register for controlling the clocks of the AHCI device. In the old
> > days, we would have hacks like what you did to turn on the clocks by poking
> > the register from the SATA driver, but now we abstract those things using
> > generic subsystems.
> > 
> > I think you either want a special led controller device node that
> > refers to the syscon device and exports the LEDs so they can be
> > accessed by the AHCI device, or do it in the device that contains
> > the registers.
> > 
> >> But this syscon approach also brings another problem. Currently my code is pretty simple for mapping this regs
> >>
> >> +       plat_data->sgpio_ctrl = devm_ioremap_resource(dev,
> >> +                             platform_get_resource(pdev, IORESOURCE_MEM, 1));
> >> +       if (IS_ERR(plat_data->sgpio_ctrl))
> >> +               return &ahci_port_info;
> >> +
> >>
> >> The above code works on ACPI and DT cases. But if we go with syncon approach
> >> then we need to handle DT and ACPI differently. Because sycon will provide
> >> struct regmap instead of struct resources and also make reading/writing a 
> >> bit different. I was trying to minimize the DT vs ACPI changes in the driver
> >> (other than binding) hence I think defining two ranges in sata controller
> >> reg property was much cleaner and it aligns with DSDT.
> > 
> > Isn't this the thing that ACPI based firmware would handle using AML anyway?
> > I don't think the server people would be too happy to add a new driver
> > each time a SATA controller does the LEDs slightly differently, and this
> > is really the kind of platform specific hack that AML is meant for.
> > 
> Sorry I am not able understand your comment, Could you please explain me what you mean by AML is meant for this kind of platform specific hack ?
>

I meant the sgpio register should not be exposed through a resource on
an ACPI based system but the access be hidden behind a call into an AML
method.

You basically extend the generic AHCI driver to understand three ways of
blinking the LEDS:

a) standard AHCI enclosure management
b) the Linux LED subsystem using whatever LED implementation the platform provides
c) calling into the ACPI interpreter to do platform specific hacks

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
