From: Greg KH <greg@kroah.com>
Subject: Re: long boot delay for SATA cdrom on current 2.6.17-git
Date: Fri, 30 Jun 2006 15:10:52 -0700
Message-ID: <20060630221052.GA4196@kroah.com>
References: <20060630025341.GA4675@kroah.com> <20060630044912.GA2592@htj.dyndns.org> <20060630052021.GA4722@kroah.com> <20060630052633.GF23844@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kroah.org ([69.55.234.183]:6853 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751302AbWF3WLU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jun 2006 18:11:20 -0400
Content-Disposition: inline
In-Reply-To: <20060630052633.GF23844@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Fri, Jun 30, 2006 at 02:26:33PM +0900, Tejun Heo wrote:
> On Thu, Jun 29, 2006 at 10:20:22PM -0700, Greg KH wrote:
> > On Fri, Jun 30, 2006 at 01:49:12PM +0900, Tejun Heo wrote:
> > > On Thu, Jun 29, 2006 at 07:53:41PM -0700, Greg KH wrote:
> > > > This laptop does not have a SATA hard drive, only a SATA cdrom drive.
> > > > I've included the boot log below and trimmed it after the delay
> > > > happened, as I doubt anything after it would be relevant.
> > > > 
> > > > Is there any patch I can test to help fix this?
> > > 
> > > This seems to be the ghost device problem which occurs when the first
> > > device is ATAPI but the second slot is empty.
> > > 
> > > > My .config is also attached, if that helps any.
> > > 
> > > Please try the following patch.
> > 
> > Yeah, that worked great, no timeout issues anymore!  Do you want to see
> > the boot log again from this?
> 
> Great.  :-)
> 
> I don't need the successful boot log but I want to see why it wasn't a
> problem in 2.6.17.  Can you apply the following patch to 2.6.17 and
> post the result?

Sure, here's the logs for when I boot 2.6.17 with your patch:

thanks,

greg k-h

-----------------

[4294667.296000] Linux version 2.6.17 (greg@blue) (gcc version 3.4.6 (Gentoo 3.4.6-r1, ssp-3.4.5-1.0, pie-8.7.9)) #109 Fri Jun 30 14:54:34 PDT 2006
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[4294667.296000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[4294667.296000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000003f690000 (usable)
[4294667.296000]  BIOS-e820: 000000003f690000 - 000000003f698000 (ACPI data)
[4294667.296000]  BIOS-e820: 000000003f698000 - 000000003f700000 (ACPI NVS)
[4294667.296000]  BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
[4294667.296000]  BIOS-e820: 00000000e0000000 - 00000000f0010000 (reserved)
[4294667.296000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[4294667.296000] Warning only 896MB will be used.
[4294667.296000] Use a HIGHMEM enabled kernel.
[4294667.296000] 896MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 229376
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:0
[4294667.296000]   Normal zone: 225280 pages, LIFO batch:31
[4294667.296000] DMI 2.3 present.
[4294667.296000] ACPI: RSDP (v000 FUJ                                   ) @ 0x000f5860
[4294667.296000] ACPI: RSDT (v001 FUJ    FJNB1A5  0x01160000 FUJ  0x00000100) @ 0x3f691448
[4294667.296000] ACPI: FADT (v001 FUJ    FJNB1A5  0x01160000 FUJ  0x00000100) @ 0x3f697f8c
[4294667.296000] ACPI: MADT (v001 FUJ    FJNB1A5  0x01160000 FUJ  0x00000100) @ 0x3f6978ad
[4294667.296000] ACPI: SSDT (v001 FUJ    FJNB1A5  0x01160000 INTL 0x20030522) @ 0x3f697907
[4294667.296000] ACPI: SSDT (v001 FUJ    FJNB1A5  0x01160000 INTL 0x20030522) @ 0x3f697d4c
[4294667.296000] ACPI: MCFG (v001 FUJ    FJNB1A5  0x01160000 FUJ  0x00000100) @ 0x3f697f28
[4294667.296000] ACPI: BOOT (v001 FUJ    FJNB1A5  0x01160000 FUJ  0x00000100) @ 0x3f697f64
[4294667.296000] ACPI: DSDT (v001 FUJ    FJNB1A5  0x01160000 MSFT 0x0100000e) @ 0x00000000
[4294667.296000] ACPI: PM-Timer IO Port: 0x1008
[4294667.296000] ACPI: Local APIC address 0xfee00000
[4294667.296000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[4294667.296000] Processor #0 6:13 APIC version 20
[4294667.296000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[4294667.296000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[4294667.296000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[4294667.296000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[4294667.296000] ACPI: IRQ0 used by override.
[4294667.296000] ACPI: IRQ2 used by override.
[4294667.296000] ACPI: IRQ9 used by override.
[4294667.296000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[4294667.296000] Using ACPI (MADT) for SMP configuration information
[4294667.296000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=/dev/hda2 resume=/dev/hda3 vga=0x0305
[4294667.296000] mapped APIC to ffffd000 (fee00000)
[4294667.296000] mapped IOAPIC to ffffc000 (fec00000)
[4294667.296000] Enabling fast FPU save and restore... done.
[4294667.296000] Enabling unmasked SIMD FPU exception support... done.
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[4294667.296000] Detected 1297.486 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour dummy device 80x25
[4294670.264000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[4294670.265000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[4294670.288000] Memory: 905660k/917504k available (2141k kernel code, 11368k reserved, 809k data, 184k init, 0k highmem)
[4294670.288000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[4294670.349000] Calibrating delay using timer specific routine.. 2597.21 BogoMIPS (lpj=1298607)
[4294670.349000] Mount-cache hash table entries: 512
[4294670.349000] CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
[4294670.349000] CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
[4294670.349000] CPU: L1 I cache: 32K, L1 D cache: 32K
[4294670.349000] CPU: L2 cache: 2048K
[4294670.349000] CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
[4294670.349000] CPU: Intel(R) Pentium(R) M processor 1.30GHz stepping 08
[4294670.349000] Checking 'hlt' instruction... OK.
[4294670.353000] SMP alternatives: switching to UP code
[4294670.353000] Freeing SMP alternatives: 0k freed
[4294670.359000] ENABLING IO-APIC IRQs
[4294670.359000] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[4294670.470000] NET: Registered protocol family 16
[4294670.470000] ACPI: bus type pci registered
[4294670.470000] PCI: Using MMCONFIG
[4294670.471000] Setting up standard PCI resources
[4294670.471000] ACPI: Subsystem revision 20060127
[4294670.477000] ACPI: Interpreter enabled
[4294670.477000] ACPI: Using IOAPIC for interrupt routing
[4294670.477000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[4294670.477000] PCI: Probing PCI hardware (bus 00)
[4294670.481000] PCI: Scanning bus 0000:00
[4294670.482000] PCI: Found 0000:00:00.0 [8086/2590] 000600 00
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:00.0
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:00.0
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:00.0
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:00.0
[4294670.482000] PCI: Found 0000:00:02.0 [8086/2592] 000300 00
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:02.0
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:02.0
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:02.0
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:02.0
[4294670.482000] Boot video device is 0000:00:02.0
[4294670.482000] PCI: Found 0000:00:02.1 [8086/2792] 000380 00
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:02.1
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:02.1
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:02.1
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:02.1
[4294670.482000] PCI: Found 0000:00:1b.0 [8086/2668] 000403 00
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:1b.0
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:1b.0
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:1b.0
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:1b.0
[4294670.482000] PCI: Found 0000:00:1d.0 [8086/2658] 000c03 00
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:1d.0
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:1d.0
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:1d.0
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:1d.0
[4294670.482000] PCI: Found 0000:00:1d.1 [8086/2659] 000c03 00
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:1d.1
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:1d.1
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:1d.1
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:1d.1
[4294670.482000] PCI: Found 0000:00:1d.2 [8086/265a] 000c03 00
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:1d.2
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:1d.2
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:1d.2
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:1d.2
[4294670.482000] PCI: Found 0000:00:1d.7 [8086/265c] 000c03 00
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:1d.7
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:1d.7
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:1d.7
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:1d.7
[4294670.482000] PCI: Found 0000:00:1e.0 [8086/2448] 000604 01
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:1e.0
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:1e.0
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:1e.0
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:1e.0
[4294670.482000] PCI: Found 0000:00:1f.0 [8086/2641] 000601 00
[4294670.482000] PCI: Calling quirk c01eb5e0 for 0000:00:1f.0
[4294670.482000] PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[4294670.482000] PCI quirk: region 1180-11bf claimed by ICH6 GPIO
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:1f.0
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:1f.0
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:1f.0
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:1f.0
[4294670.482000] PCI: Found 0000:00:1f.1 [8086/266f] 000101 00
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:1f.1
[4294670.482000] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:1f.1
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:1f.1
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:1f.1
[4294670.482000] PCI: Found 0000:00:1f.2 [8086/2653] 000101 00
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:1f.2
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:1f.2
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:1f.2
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:1f.2
[4294670.482000] PCI: Found 0000:00:1f.3 [8086/266a] 000c05 00
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:00:1f.3
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:00:1f.3
[4294670.482000] PCI: Calling quirk c02a0f40 for 0000:00:1f.3
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:00:1f.3
[4294670.482000] PCI: Fixups for bus 0000:00
[4294670.482000] PCI: Scanning behind PCI bridge 0000:00:1e.0, config 070600, pass 0
[4294670.482000] PCI: Scanning bus 0000:06
[4294670.482000] PCI: Found 0000:06:03.0 [1180/0476] 000607 02
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:06:03.0
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:06:03.0
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:06:03.0
[4294670.482000] PCI: Found 0000:06:03.1 [1180/0552] 000c00 00
[4294670.482000] PCI: Calling quirk c01ebcb0 for 0000:06:03.1
[4294670.482000] PCI: Calling quirk c02a0d30 for 0000:06:03.1
[4294670.482000] PCI: Calling quirk c02a1140 for 0000:06:03.1
[4294670.482000] PCI: Found 0000:06:03.2 [1180/0822] 000805 00
[4294670.483000] PCI: Calling quirk c01ebcb0 for 0000:06:03.2
[4294670.483000] PCI: Calling quirk c02a0d30 for 0000:06:03.2
[4294670.483000] PCI: Calling quirk c02a1140 for 0000:06:03.2
[4294670.483000] PCI: Found 0000:06:03.3 [1180/0592] 000880 00
[4294670.483000] PCI: Calling quirk c01ebcb0 for 0000:06:03.3
[4294670.483000] PCI: Calling quirk c02a0d30 for 0000:06:03.3
[4294670.483000] PCI: Calling quirk c02a1140 for 0000:06:03.3
[4294670.483000] PCI: Found 0000:06:03.4 [1180/0852] 000880 00
[4294670.483000] PCI: Calling quirk c01ebcb0 for 0000:06:03.4
[4294670.483000] PCI: Calling quirk c02a0d30 for 0000:06:03.4
[4294670.483000] PCI: Calling quirk c02a1140 for 0000:06:03.4
[4294670.483000] PCI: Found 0000:06:04.0 [10ec/8139] 000200 00
[4294670.483000] PCI: Calling quirk c01ebcb0 for 0000:06:04.0
[4294670.483000] PCI: Calling quirk c02a0d30 for 0000:06:04.0
[4294670.483000] PCI: Calling quirk c02a1140 for 0000:06:04.0
[4294670.483000] PCI: Found 0000:06:05.0 [8086/4223] 000280 00
[4294670.483000] PCI: Calling quirk c01ebcb0 for 0000:06:05.0
[4294670.483000] PCI: Calling quirk c02a0d30 for 0000:06:05.0
[4294670.483000] PCI: Calling quirk c02a0f40 for 0000:06:05.0
[4294670.483000] PCI: Calling quirk c02a1140 for 0000:06:05.0
[4294670.483000] PCI: Fixups for bus 0000:06
[4294670.483000] PCI: Transparent bridge - 0000:00:1e.0
[4294670.483000] PCI: Scanning behind PCI bridge 0000:06:03.0, config 070706, pass 0
[4294670.483000] PCI: Scanning behind PCI bridge 0000:06:03.0, config 070706, pass 1
[4294670.483000] PCI: Bus #07 (-#0a) is hidden behind transparent bridge #06 (-#07) (try 'pci=assign-busses')
[4294670.483000] Please report the result to linux-kernel to fix this permanently
[4294670.483000] PCI: Bus scan for 0000:06 returning with max=0a
[4294670.483000] PCI: Scanning behind PCI bridge 0000:00:1e.0, config 070600, pass 1
[4294670.483000] PCI: Bus scan for 0000:00 returning with max=0a
[4294670.483000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[4294670.487000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[4294670.491000] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[4294670.491000] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[4294670.491000] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[4294670.492000] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[4294670.492000] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[4294670.492000] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[4294670.493000] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[4294670.493000] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[4294670.496000] SCSI subsystem initialized
[4294670.496000] PCI: Using ACPI for IRQ routing
[4294670.496000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[4294670.496000] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[4294670.496000]   got res [52000000:5207ffff] bus [52000000:5207ffff] flags 200 for BAR 0 of 0000:00:02.1
[4294670.496000] PCI: moved device 0000:00:02.1 resource 0 (200) to 52000000
[4294670.496000]   got res [b0103000:b0103fff] bus [b0103000:b0103fff] flags 200 for BAR 0 of 0000:06:03.0
[4294670.496000] PCI: moved device 0000:06:03.0 resource 0 (200) to b0103000
[4294670.496000] PCI: Bus 7, cardbus bridge: 0000:06:03.0
[4294670.496000]   IO window: 00002400-000024ff
[4294670.496000]   IO window: 00002800-000028ff
[4294670.496000]   PREFETCH window: 50000000-51ffffff
[4294670.496000]   MEM window: 54000000-55ffffff
[4294670.496000] PCI: Bridge: 0000:00:1e.0
[4294670.496000]   IO window: 2000-2fff
[4294670.496000]   MEM window: b0100000-b01fffff
[4294670.496000]   PREFETCH window: 50000000-51ffffff
[4294670.496000] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[4294670.496000] ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low) -> IRQ 16
[4294670.496000] NET: Registered protocol family 2
[4294670.505000] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[4294670.505000] TCP established hash table entries: 131072 (order: 7, 524288 bytes)
[4294670.505000] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[4294670.505000] TCP: Hash tables configured (established 131072 bind 65536)
[4294670.505000] TCP reno registered
[4294670.506000] Simple Boot Flag at 0x7f set to 0x1
[4294670.506000] Initializing Cryptographic API
[4294670.506000] io scheduler noop registered
[4294670.506000] io scheduler anticipatory registered (default)
[4294670.506000] io scheduler deadline registered
[4294670.506000] io scheduler cfq registered
[4294670.506000] PCI: Calling quirk c01ebb70 for 0000:00:00.0
[4294670.506000] PCI: Calling quirk c01ebe30 for 0000:00:00.0
[4294670.506000] PCI: Calling quirk c0285750 for 0000:00:00.0
[4294670.506000] PCI: Calling quirk c01ebb70 for 0000:00:02.0
[4294670.506000] PCI: Calling quirk c01ebe30 for 0000:00:02.0
[4294670.506000] PCI: Calling quirk c0285750 for 0000:00:02.0
[4294670.506000] PCI: Calling quirk c01ebb70 for 0000:00:02.1
[4294670.506000] PCI: Calling quirk c01ebe30 for 0000:00:02.1
[4294670.506000] PCI: Calling quirk c0285750 for 0000:00:02.1
[4294670.506000] PCI: Calling quirk c01ebb70 for 0000:00:1b.0
[4294670.506000] PCI: Calling quirk c01ebe30 for 0000:00:1b.0
[4294670.506000] PCI: Calling quirk c0285750 for 0000:00:1b.0
[4294670.506000] PCI: Calling quirk c01ebb70 for 0000:00:1d.0
[4294670.506000] PCI: Calling quirk c01ebe30 for 0000:00:1d.0
[4294670.506000] PCI: Calling quirk c0285750 for 0000:00:1d.0
[4294670.506000]  0000:00:1d.0: uhci_check_and_reset_hc: legsup = 0x003b
[4294670.506000]  0000:00:1d.0: Performing full reset
[4294670.506000] PCI: Calling quirk c01ebb70 for 0000:00:1d.1
[4294670.506000] PCI: Calling quirk c01ebe30 for 0000:00:1d.1
[4294670.506000] PCI: Calling quirk c0285750 for 0000:00:1d.1
[4294670.506000]  0000:00:1d.1: uhci_check_and_reset_hc: legsup = 0x0010
[4294670.506000]  0000:00:1d.1: Performing full reset
[4294670.506000] PCI: Calling quirk c01ebb70 for 0000:00:1d.2
[4294670.506000] PCI: Calling quirk c01ebe30 for 0000:00:1d.2
[4294670.506000] PCI: Calling quirk c0285750 for 0000:00:1d.2
[4294670.506000]  0000:00:1d.2: uhci_check_and_reset_hc: legsup = 0x0010
[4294670.506000]  0000:00:1d.2: Performing full reset
[4294670.506000] PCI: Calling quirk c01ebb70 for 0000:00:1d.7
[4294670.506000] PCI: Calling quirk c01ebe30 for 0000:00:1d.7
[4294670.506000] PCI: Calling quirk c0285750 for 0000:00:1d.7
[4294670.506000] PCI: Calling quirk c01ebb70 for 0000:00:1e.0
[4294670.506000] PCI: Calling quirk c01ebe30 for 0000:00:1e.0
[4294670.506000] PCI: Calling quirk c0285750 for 0000:00:1e.0
[4294670.506000] PCI: Calling quirk c01ebb70 for 0000:00:1f.0
[4294670.506000] PCI: Calling quirk c01ebe30 for 0000:00:1f.0
[4294670.507000] PCI: Calling quirk c0285750 for 0000:00:1f.0
[4294670.507000] PCI: Calling quirk c01ebb70 for 0000:00:1f.1
[4294670.507000] PCI: Calling quirk c01ebe30 for 0000:00:1f.1
[4294670.507000] PCI: Calling quirk c0285750 for 0000:00:1f.1
[4294670.507000] PCI: Calling quirk c01ebb70 for 0000:00:1f.2
[4294670.507000] PCI: Calling quirk c01ebe30 for 0000:00:1f.2
[4294670.507000] PCI: Calling quirk c0285750 for 0000:00:1f.2
[4294670.507000] PCI: Calling quirk c01ebb70 for 0000:00:1f.3
[4294670.507000] PCI: Calling quirk c01ebe30 for 0000:00:1f.3
[4294670.507000] PCI: Calling quirk c0285750 for 0000:00:1f.3
[4294670.507000] PCI: Calling quirk c01ebb70 for 0000:06:03.0
[4294670.507000] PCI: Calling quirk c0285750 for 0000:06:03.0
[4294670.507000] PCI: Calling quirk c01ebb70 for 0000:06:03.1
[4294670.507000] PCI: Calling quirk c0285750 for 0000:06:03.1
[4294670.507000] PCI: Calling quirk c01ebb70 for 0000:06:03.2
[4294670.507000] PCI: Calling quirk c0285750 for 0000:06:03.2
[4294670.507000] PCI: Calling quirk c01ebb70 for 0000:06:03.3
[4294670.507000] PCI: Calling quirk c0285750 for 0000:06:03.3
[4294670.507000] PCI: Calling quirk c01ebb70 for 0000:06:03.4
[4294670.507000] PCI: Calling quirk c0285750 for 0000:06:03.4
[4294670.507000] PCI: Calling quirk c01ebb70 for 0000:06:04.0
[4294670.507000] PCI: Calling quirk c0285750 for 0000:06:04.0
[4294670.507000] PCI: Calling quirk c01ebb70 for 0000:06:05.0
[4294670.507000] PCI: Calling quirk c01ebe30 for 0000:06:05.0
[4294670.507000] PCI: Calling quirk c0285750 for 0000:06:05.0
[4294670.507000] vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 1536k, total 7872k
[4294670.507000] vesafb: mode is 1024x768x8, linelength=1024, pages=9
[4294670.507000] vesafb: protected mode interface info at 00ff:44f0
[4294670.507000] vesafb: scrolling: redraw
[4294670.507000] vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
[4294670.529000] Console: switching to colour frame buffer device 128x48
[4294670.529000] fb0: VESA VGA frame buffer device
[4294670.530000] ACPI: AC Adapter [AC] (on-line)
[4294670.530000] ACPI: Battery Slot [CMB1] (battery present)
[4294670.531000] ACPI: Battery Slot [CMB2] (battery absent)
[4294670.531000] ACPI: Power Button (FF) [PWRF]
[4294670.531000] ACPI: Lid Switch [LID]
[4294670.531000] ACPI: Power Button (CM) [PWRB]
[4294670.531000] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[4294670.532000] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[4294670.534000] Real Time Clock Driver v1.12ac
[4294670.534000] Linux agpgart interface v0.101 (c) Dave Jones
[4294670.534000] agpgart: Detected an Intel 915GM Chipset.
[4294670.536000] agpgart: Detected 7932K stolen memory.
[4294670.556000] agpgart: AGP aperture is 256M @ 0xc0000000
[4294670.557000] intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM chipsets
[4294670.557000] intelfb: Version 0.9.2
[4294670.557000] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[4294670.557000] intelfb: Cannot reserve FB region.
[4294670.561000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[4294670.565000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294670.569000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4294670.573000] ICH6: IDE controller at PCI slot 0000:00:1f.1
[4294670.576000] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
[4294670.580000] ICH6: chipset revision 4
[4294670.584000] ICH6: not 100% native mode: will probe irqs later
[4294670.588000]     ide0: BM-DMA at 0x1410-0x1417, BIOS settings: hda:DMA, hdb:pio
[4294670.592000] Probing IDE interface ide0...
[4294670.856000] hda: TOSHIBA MK6006GAH, ATA DISK drive
[4294671.471000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294671.475000] Probing IDE interface ide1...
[4294671.988000] hda: max request size: 512KiB
[4294672.015000] hda: 117210240 sectors (60011 MB), CHS=16383/255/63, UDMA(100)
[4294672.019000] hda: cache flushes supported
[4294672.023000]  hda: hda1 hda2 hda3 hda4
[4294672.040000] libata version 1.20 loaded.
[4294672.040000] piix_init: pci_module_init
[4294672.044000] ata_piix 0000:00:1f.2: version 1.05
[4294672.044000] ata_piix 0000:00:1f.2: MAP [ P0 P2 XX XX ]
[4294672.048000] ata_piix 0000:00:1f.2: invalid MAP value 0
[4294672.052000] ata_pci_init_one: ENTER
[4294672.055000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 18
[4294672.059000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[4294672.059000] ata_device_add: ENTER
[4294672.063000] ata_host_add: ENTER
[4294672.067000] ata_port_start: prd alloc, virt f7e55000, dma 37e55000
[4294672.070000] ata1: SATA max UDMA/133 cmd 0x1498 ctl 0x140E bmdma 0x1480 irq 18
[4294672.074000] ata_host_add: ENTER
[4294672.078000] ata_port_start: prd alloc, virt f7cfb000, dma 37cfb000
[4294672.081000] ata2: SATA max UDMA/133 cmd 0x1490 ctl 0x140A bmdma 0x1488 irq 18
[4294672.085000] ata_device_add: probe begin
[4294672.089000] ata_device_add: ata1: bus probe begin
[4294672.093000] piix_sata_probe: ata1: ENTER, pcs=0x11 base=0
[4294672.198000] piix_sata_probe: ata1: LEAVE, pcs=0x11 present_mask=0x1
[4294672.201000] ata_std_softreset: ENTER ata1
[4294672.205000] ata_std_softreset: about to softreset, devmask=3
[4294672.209000] ata_bus_softreset: ata1: bus reset via SRST
[4294672.364000] ata_dev_classify: found ATAPI device by sig
[4294672.367000] ata_dev_classify: found ATAPI device by sig
[4294672.371000] ata_std_softreset: EXIT, classes[0]=3 [1]=3
[4294672.375000] ata_std_postreset: ENTER
[4294672.378000] ata_std_postreset: EXIT
[4294672.382000] ata_dev_read_id: ENTER, host 1, dev 0
[4294672.537000] ata_exec_command_pio: ata1: cmd 0xA1
[4294672.543000] ata_pio_sector: data read
[4294672.546000] ata_dev_configure: ENTER, host 1, dev 0
[4294672.550000] ata1: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0407
[4294672.550000] ata_dump_id: 49==0x0f00  53==0x0006  63==0x0007  64==0x0003  75==0x0000  
[4294672.553000] ata_dump_id: 80==0x0078  81==0x0000  82==0x0000  83==0x0000  84==0x0000  
[4294672.557000] ata_dump_id: 88==0x0407  93==0x4000
[4294672.560000] ata1: dev 0 ATAPI, max UDMA/33
[4294672.563000] ata1(0): applying bridge limits
[4294672.566000] ata_dev_configure: EXIT, drv_stat = 0x50
[4294672.569000] ata_dev_read_id: ENTER, host 1, dev 1
[4294672.723000] ata_exec_command_pio: ata1: cmd 0xA1
[4294672.726000] ata1: PIO error
[4294672.729000] ata1: dev 1 failed to IDENTIFY (I/O error)
[4294672.732000] ata_dev_set_xfermode: set features - xfer mode
[4294672.735000] ata_exec_command_pio: ata1: cmd 0xEF
[4294672.738000] ata_host_intr: ata1: protocol 1 (dev_stat 0x50)
[4294672.741000] ata_dev_set_xfermode: EXIT, err_mask=0
[4294672.744000] ata_dev_read_id: ENTER, host 1, dev 0
[4294672.898000] ata_exec_command_pio: ata1: cmd 0xA1
[4294672.904000] ata_pio_sector: data read
[4294672.907000] ata_dev_configure: ENTER, host 1, dev 0
[4294672.910000] ata_dump_id: 49==0x0f00  53==0x0006  63==0x0007  64==0x0003  75==0x0000  
[4294672.913000] ata_dump_id: 80==0x0078  81==0x0000  82==0x0000  83==0x0000  84==0x0000  
[4294672.916000] ata_dump_id: 88==0x0407  93==0x4000
[4294672.919000] ata_dev_configure: EXIT, drv_stat = 0x50
[4294672.922000] ata_dev_set_mode: xfer_shift=8, xfer_mode=0x42
[4294672.925000] ata1: dev 0 configured for UDMA/33
[4294672.927000] ata_device_add: ata1: bus probe end
[4294672.930000] scsi0 : ata_piix
[4294672.933000] ata_device_add: ata2: bus probe begin
[4294672.936000] piix_sata_probe: ata2: ENTER, pcs=0x15 base=2
[4294673.040000] piix_sata_probe: ata2: LEAVE, pcs=0x15 present_mask=0x0
[4294673.042000] ata2: SATA port has no device.
[4294673.045000] ata_device_add: ata2: bus probe end
[4294673.048000] scsi1 : ata_piix
[4294673.051000] ata_device_add: host probe begin
[4294673.054000] ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 24 00 00 00 1d
[4294673.054000] ata_sg_setup: 1 sg elements mapped
[4294673.054000] ata_exec_command_pio: ata1: cmd 0xA0
[4294673.062000] atapi_packet_task: busy wait
[4294673.065000] atapi_packet_task: send cdb
[4294673.069000] ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
[4294673.072000] ata_scsi_dump_cdb: CDB (1:0,0,0) 12 00 00 00 60 00 00 00 1d
[4294673.072000] ata_sg_setup: 1 sg elements mapped
[4294673.072000] ata_exec_command_pio: ata1: cmd 0xA0
[4294673.081000] atapi_packet_task: busy wait
[4294673.084000] atapi_packet_task: send cdb
[4294673.087000] ata_host_intr: ata1: protocol 6 (dev_stat 0x50)
[4294673.090000]   Vendor: MATSHITA  Model: DVD-RAM UJ-832S   Rev: 1.60
[4294673.093000]   Type:   CD-ROM                             ANSI SCSI revision: 05
[4294673.096000] piix_init: done
[4294673.102000] i8042.c: Detected active multiplexing controller, rev 1.1.
[4294673.107000] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[4294673.110000] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[4294673.113000] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[4294673.116000] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[4294673.119000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294673.122000] mice: PS/2 mouse device common for all mice
[4294673.125000] ts: Compaq touchscreen protocol output
[4294673.128000] input: PC Speaker as /class/input/input0
[4294673.131000] TCP bic registered
[4294673.134000] Initializing IPsec netlink socket
[4294673.137000] NET: Registered protocol family 1
[4294673.140000] NET: Registered protocol family 17
[4294673.143000] NET: Registered protocol family 15
[4294673.146000] NET: Registered protocol family 8
[4294673.148000] NET: Registered protocol family 20
[4294673.152000] Using IPI Shortcut mode
[4294673.155000] swsusp: Resume From Partition /dev/hda3
[4294673.155000] PM: Checking swsusp image.
[4294673.188000] PM: Resume from disk failed.
[4294673.188000] ACPI wakeup devices: 
[4294673.191000] PCIB MODM AZAL  LID 
[4294673.193000] ACPI: (supports S0 S3 S4 S5)
[4294673.196000] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[4294673.224000] kjournald starting.  Commit interval 5 seconds
[4294673.227000] EXT3-fs: mounted filesystem with ordered data mode.
[4294673.229000] VFS: Mounted root (ext3 filesystem) readonly.
[4294673.232000] Freeing unused kernel memory: 184k freed
[4294673.452000] input: AT Translated Set 2 keyboard as /class/input/input1
[4294674.153000] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1a0b1, caps: 0xa04713/0x202000
[4294674.197000] input: SynPS/2 Synaptics TouchPad as /class/input/input2
[4294676.599000] 8139too Fast Ethernet driver 0.9.27
[4294676.602000] ACPI: PCI Interrupt 0000:06:04.0[A] -> GSI 20 (level, low) -> IRQ 19
[4294676.605000] eth0: RealTek RTL8139 at 0xf8830400, 00:0b:5d:96:e2:76, IRQ 19
[4294676.608000] eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
[4294676.608000] i801_smbus 0000:00:1f.3: I801 using PCI Interrupt for SMBus.
[4294676.608000] i801_smbus 0000:00:1f.3: SMBREV = 0x4
[4294676.608000] i801_smbus 0000:00:1f.3: I801_smba = 0x14A0
[4294676.608000] i2c_adapter i2c-0: adapter [SMBus I801 adapter at 14a0] registered
[4294676.643000] 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
[4294676.661000] sdhci: Secure Digital Host Controller Interface driver, 0.11
[4294676.664000] sdhci: Copyright(c) Pierre Ossman
[4294676.668000] ACPI: PCI Interrupt 0000:06:03.2[A] -> GSI 16 (level, low) -> IRQ 16
[4294676.771000] mmc0: SDHCI at 0xb0100800 irq 16 PIO
[4294676.915000] usbcore: registered new driver usbfs
[4294676.918000] usbcore: registered new driver hub
[4294677.117000] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
[4294677.120000] PCI: Setting latency timer of device 0000:00:1b.0 to 64
[4294677.146000] USB Universal Host Controller Interface driver v3.0
[4294677.163000] ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
[4294677.346000] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 20
[4294677.350000] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[4294677.350000] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[4294677.354000] drivers/usb/core/inode.c: creating file 'devices'
[4294677.354000] drivers/usb/core/inode.c: creating file '001'
[4294677.354000] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[4294677.357000] uhci_hcd 0000:00:1d.0: detected 2 ports
[4294677.361000] uhci_hcd 0000:00:1d.0: uhci_check_and_reset_hc: cmd = 0x0000
[4294677.361000] uhci_hcd 0000:00:1d.0: Performing full reset
[4294677.361000] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00001420
[4294677.365000] usb usb1: default language 0x0409
[4294677.365000] usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
[4294677.365000] usb usb1: Product: UHCI Host Controller
[4294677.369000] usb usb1: Manufacturer: Linux 2.6.17 uhci_hcd
[4294677.372000] usb usb1: SerialNumber: 0000:00:1d.0
[4294677.376000] usb usb1: uevent
[4294677.376000] usb usb1: configuration #1 chosen from 1 choice
[4294677.380000] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[4294677.380000] usb 1-0:1.0: uevent
[4294677.380000] hub 1-0:1.0: usb_probe_interface
[4294677.380000] hub 1-0:1.0: usb_probe_interface - got id
[4294677.380000] hub 1-0:1.0: USB hub found
[4294677.383000] hub 1-0:1.0: 2 ports detected
[4294677.387000] hub 1-0:1.0: standalone hub
[4294677.387000] hub 1-0:1.0: no power switching (usb 1.0)
[4294677.387000] hub 1-0:1.0: individual port over-current protection
[4294677.387000] hub 1-0:1.0: power on to power good time: 2ms
[4294677.387000] hub 1-0:1.0: local power source is good
[4294677.488000] drivers/usb/core/inode.c: creating file '001'
[4294677.488000] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 18
[4294677.491000] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[4294677.491000] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[4294677.495000] drivers/usb/core/inode.c: creating file '002'
[4294677.495000] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[4294677.499000] uhci_hcd 0000:00:1d.1: detected 2 ports
[4294677.502000] uhci_hcd 0000:00:1d.1: uhci_check_and_reset_hc: cmd = 0x0000
[4294677.502000] uhci_hcd 0000:00:1d.1: Performing full reset
[4294677.502000] uhci_hcd 0000:00:1d.1: irq 18, io base 0x00001440
[4294677.506000] usb usb2: default language 0x0409
[4294677.506000] usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
[4294677.506000] usb usb2: Product: UHCI Host Controller
[4294677.509000] usb usb2: Manufacturer: Linux 2.6.17 uhci_hcd
[4294677.513000] usb usb2: SerialNumber: 0000:00:1d.1
[4294677.516000] usb usb2: uevent
[4294677.516000] usb usb2: configuration #1 chosen from 1 choice
[4294677.519000] usb usb2: adding 2-0:1.0 (config #1, interface 0)
[4294677.519000] usb 2-0:1.0: uevent
[4294677.520000] hub 2-0:1.0: usb_probe_interface
[4294677.520000] hub 2-0:1.0: usb_probe_interface - got id
[4294677.520000] hub 2-0:1.0: USB hub found
[4294677.523000] hub 2-0:1.0: 2 ports detected
[4294677.526000] hub 2-0:1.0: standalone hub
[4294677.526000] hub 2-0:1.0: no power switching (usb 1.0)
[4294677.526000] hub 2-0:1.0: individual port over-current protection
[4294677.526000] hub 2-0:1.0: power on to power good time: 2ms
[4294677.526000] hub 2-0:1.0: local power source is good
[4294677.526000] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[4294677.627000] drivers/usb/core/inode.c: creating file '001'
[4294677.627000] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
[4294677.630000] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[4294677.630000] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[4294677.634000] drivers/usb/core/inode.c: creating file '003'
[4294677.634000] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[4294677.637000] uhci_hcd 0000:00:1d.2: detected 2 ports
[4294677.641000] uhci_hcd 0000:00:1d.2: uhci_check_and_reset_hc: cmd = 0x0000
[4294677.641000] uhci_hcd 0000:00:1d.2: Performing full reset
[4294677.641000] uhci_hcd 0000:00:1d.2: irq 17, io base 0x00001460
[4294677.645000] usb usb3: default language 0x0409
[4294677.645000] usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
[4294677.645000] usb usb3: Product: UHCI Host Controller
[4294677.648000] usb usb3: Manufacturer: Linux 2.6.17 uhci_hcd
[4294677.652000] usb usb3: SerialNumber: 0000:00:1d.2
[4294677.656000] usb usb3: uevent
[4294677.656000] usb usb3: configuration #1 chosen from 1 choice
[4294677.659000] usb usb3: adding 3-0:1.0 (config #1, interface 0)
[4294677.659000] usb 3-0:1.0: uevent
[4294677.659000] hub 3-0:1.0: usb_probe_interface
[4294677.659000] hub 3-0:1.0: usb_probe_interface - got id
[4294677.659000] hub 3-0:1.0: USB hub found
[4294677.663000] hub 3-0:1.0: 2 ports detected
[4294677.666000] hub 3-0:1.0: standalone hub
[4294677.666000] hub 3-0:1.0: no power switching (usb 1.0)
[4294677.666000] hub 3-0:1.0: individual port over-current protection
[4294677.666000] hub 3-0:1.0: power on to power good time: 2ms
[4294677.666000] hub 3-0:1.0: local power source is good
[4294677.666000] hub 2-0:1.0: state 7 ports 2 chg 0000 evt 0000
[4294677.767000] drivers/usb/core/inode.c: creating file '001'
[4294677.767000] hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0002
[4294677.767000] uhci_hcd 0000:00:1d.2: port 1 portsc 009b,00
[4294677.767000] hub 3-0:1.0: port 1, status 0101, change 0003, 12 Mb/s
[4294677.767000] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 20
[4294677.771000] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[4294677.771000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[4294677.774000] drivers/usb/core/inode.c: creating file '004'
[4294677.774000] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
[4294677.778000] ehci_hcd 0000:00:1d.7: reset hcs_params 0x103206 dbg=1 cc=3 pcc=2 ordered !ppc ports=6
[4294677.778000] ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit addr
[4294677.778000] ehci_hcd 0000:00:1d.7: debug port 1
[4294677.781000] PCI: cache line size of 32 is not supported by device 0000:00:1d.7
[4294677.781000] ehci_hcd 0000:00:1d.7: supports USB remote wakeup
[4294677.781000] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xb0004000
[4294677.784000] ehci_hcd 0000:00:1d.7: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
[4294677.788000] ehci_hcd 0000:00:1d.7: init command 010001 (park)=0 ithresh=1 period=1024 RUN
[4294677.788000] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[4294677.792000] usb usb4: default language 0x0409
[4294677.792000] usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
[4294677.792000] usb usb4: Product: EHCI Host Controller
[4294677.795000] usb usb4: Manufacturer: Linux 2.6.17 ehci_hcd
[4294677.799000] usb usb4: SerialNumber: 0000:00:1d.7
[4294677.802000] usb usb4: uevent
[4294677.802000] usb usb4: configuration #1 chosen from 1 choice
[4294677.805000] usb usb4: adding 4-0:1.0 (config #1, interface 0)
[4294677.805000] usb 4-0:1.0: uevent
[4294677.805000] hub 4-0:1.0: usb_probe_interface
[4294677.805000] hub 4-0:1.0: usb_probe_interface - got id
[4294677.805000] hub 4-0:1.0: USB hub found
[4294677.808000] hub 4-0:1.0: 6 ports detected
[4294677.812000] hub 4-0:1.0: standalone hub
[4294677.812000] hub 4-0:1.0: no power switching (usb 1.0)
[4294677.812000] hub 4-0:1.0: individual port over-current protection
[4294677.812000] hub 4-0:1.0: Single TT
[4294677.812000] hub 4-0:1.0: TT requires at most 8 FS bit times (666 ns)
[4294677.812000] hub 4-0:1.0: power on to power good time: 20ms
[4294677.812000] hub 4-0:1.0: local power source is good
[4294677.812000] uhci_hcd 0000:00:1d.2: port 1 portsc 0082,00
[4294677.913000] drivers/usb/core/inode.c: creating file '001'
[4294677.916000] hub 3-0:1.0: debounce: port 1: total 125ms stable 100ms status 0x100
[4294677.916000] hub 4-0:1.0: state 7 ports 6 chg 0000 evt 0000
[4294677.916000] ehci_hcd 0000:00:1d.7: GetStatus port 5 status 001803 POWER sig=j CSC CONNECT
[4294677.916000] hub 4-0:1.0: port 5, status 0501, change 0001, 480 Mb/s
[4294678.020000] hub 4-0:1.0: debounce: port 5: total 100ms stable 100ms status 0x501
[4294678.071000] ehci_hcd 0000:00:1d.7: port 5 full speed --> companion
[4294678.071000] ehci_hcd 0000:00:1d.7: GetStatus port 5 status 003801 POWER OWNER sig=j CONNECT
[4294678.267000] hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0002
[4294678.267000] uhci_hcd 0000:00:1d.2: port 1 portsc 0093,00
[4294678.267000] hub 3-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
[4294678.371000] hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
[4294678.473000] usb 3-1: new full speed USB device using uhci_hcd and address 2
[4294678.488000] uhci_hcd 0000:00:1d.0: suspend_rh (auto-stop)
[4294678.504000] EXT3 FS on hda2, internal journal
[4294678.594000] usb 3-1: ep0 maxpacket = 8
[4294678.616000] usb 3-1: default language 0x0409
[4294678.625000] usb 3-1: new device strings: Mfr=0, Product=1, SerialNumber=0
[4294678.625000] usb 3-1: Product: Fingerprint Sensor
[4294678.625000] usb 3-1: uevent
[4294678.625000] usb 3-1: configuration #1 chosen from 1 choice
[4294678.627000] uhci_hcd 0000:00:1d.1: suspend_rh (auto-stop)
[4294678.628000] usb 3-1: adding 3-1:1.0 (config #1, interface 0)
[4294678.628000] usb 3-1:1.0: uevent
[4294678.628000] drivers/usb/core/inode.c: creating file '002'
[4294678.628000] hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0002
[4294679.112000] kjournald starting.  Commit interval 5 seconds
[4294679.112000] EXT3 FS on hda4, internal journal
[4294679.112000] EXT3-fs: mounted filesystem with ordered data mode.
[4294679.224000] Adding 2104504k swap on /dev/hda3.  Priority:-1 extents:1 across:2104504k
