From: Greg KH <greg@kroah.com>
Subject: long boot delay for SATA cdrom on current 2.6.17-git
Date: Thu, 29 Jun 2006 19:53:41 -0700
Message-ID: <20060630025341.GA4675@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kroah.org ([69.55.234.183]:36800 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964928AbWF3CyF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Jun 2006 22:54:05 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With Linus's current -git tree (like 2.6.17-git13), it takes a long time
to boot my laptop.  Turns out the SATA cdrom discovery process is taking
up many seconds.

This laptop does not have a SATA hard drive, only a SATA cdrom drive.
I've included the boot log below and trimmed it after the delay
happened, as I doubt anything after it would be relevant.

Is there any patch I can test to help fix this?

My .config is also attached, if that helps any.

thanks,

greg k-h


[    0.000000] Linux version 2.6.17-git15-gkh (greg@blue) (gcc version 3.4.6 (Gentoo 3.4.6-r1, ssp-3.4.5-1.0, pie-8.7.9)) #106 Thu Jun 29 18:01:44 PDT 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003f690000 (usable)
[    0.000000]  BIOS-e820: 000000003f690000 - 000000003f698000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003f698000 - 000000003f700000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0010000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] Warning only 896MB will be used.
[    0.000000] Use a HIGHMEM enabled kernel.
[    0.000000] 896MB LOWMEM available.
[    0.000000] On node 0 totalpages: 229376
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   Normal zone: 225280 pages, LIFO batch:31
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 FUJ                                   ) @ 0x000f5860
[    0.000000] ACPI: RSDT (v001 FUJ    FJNB1A5  0x01160000 FUJ  0x00000100) @ 0x3f691448
[    0.000000] ACPI: FADT (v001 FUJ    FJNB1A5  0x01160000 FUJ  0x00000100) @ 0x3f697f8c
[    0.000000] ACPI: MADT (v001 FUJ    FJNB1A5  0x01160000 FUJ  0x00000100) @ 0x3f6978ad
[    0.000000] ACPI: SSDT (v001 FUJ    FJNB1A5  0x01160000 INTL 0x20030522) @ 0x3f697907
[    0.000000] ACPI: SSDT (v001 FUJ    FJNB1A5  0x01160000 INTL 0x20030522) @ 0x3f697d4c
[    0.000000] ACPI: MCFG (v001 FUJ    FJNB1A5  0x01160000 FUJ  0x00000100) @ 0x3f697f28
[    0.000000] ACPI: BOOT (v001 FUJ    FJNB1A5  0x01160000 FUJ  0x00000100) @ 0x3f697f64
[    0.000000] ACPI: DSDT (v001 FUJ    FJNB1A5  0x01160000 MSFT 0x0100000e) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 6:13 APIC version 20
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
[    0.000000] Detected 598.737 MHz processor.
[   15.483555] Built 1 zonelists.  Total pages: 229376
[   15.483561] Kernel command line: root=/dev/hda2 resume=/dev/hda3 vga=0x0305
[   15.484092] mapped APIC to ffffd000 (fee00000)
[   15.484099] mapped IOAPIC to ffffc000 (fec00000)
[   15.484105] Enabling fast FPU save and restore... done.
[   15.484111] Enabling unmasked SIMD FPU exception support... done.
[   15.484118] Initializing CPU#0
[   15.484211] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   15.484375] Console: colour dummy device 80x25
[   15.485056] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   15.486463] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   15.525515] Memory: 905576k/917504k available (2197k kernel code, 11452k reserved, 829k data, 184k init, 0k highmem)
[   15.525536] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   15.585178] Calibrating delay using timer specific routine.. 1198.39 BogoMIPS (lpj=599199)
[   15.585271] Mount-cache hash table entries: 512
[   15.585466] CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
[   15.585486] CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000
[   15.585508] CPU: L1 I cache: 32K, L1 D cache: 32K
[   15.585522] CPU: L2 cache: 2048K
[   15.585530] CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000180 00000000 00000000
[   15.585562] CPU: Intel(R) Pentium(R) M processor 1.30GHz stepping 08
[   15.585580] Checking 'hlt' instruction... OK.
[   15.589284] SMP alternatives: switching to UP code
[   15.589295] Freeing SMP alternatives: 0k freed
[   15.589305] ACPI: Core revision 20060608
[   15.599775] ENABLING IO-APIC IRQs
[   15.600020] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   15.711431] PM: Adding info for No Bus:platform
[   15.711903] Time:  2:27:02  Date: 05/30/106
[   15.711954] NET: Registered protocol family 16
[   15.712094] ACPI: bus type pci registered
[   15.712109] PCI: Using MMCONFIG
[   15.713004] Setting up standard PCI resources
[   15.726093] ACPI: Interpreter enabled
[   15.726105] ACPI: Using IOAPIC for interrupt routing
[   15.726383] PM: Adding info for acpi:acpi
[   15.726882] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   15.726896] PCI: Probing PCI hardware (bus 00)
[   15.726911] PM: Adding info for No Bus:pci0000:00
[   15.736260] PCI: Scanning bus 0000:00
[   15.736279] PCI: Found 0000:00:00.0 [8086/2590] 000600 00
[   15.736287] Turning off bus mastering on 0000:00:00.0
[   15.736316] PCI: Calling quirk c01f1b90 for 0000:00:00.0
[   15.736323] PCI: Calling quirk c02adc20 for 0000:00:00.0
[   15.736330] PCI: Calling quirk c02ade30 for 0000:00:00.0
[   15.736336] PCI: Calling quirk c02ae030 for 0000:00:00.0
[   15.736354] PCI: Found 0000:00:02.0 [8086/2592] 000300 00
[   15.736376] PCI: Calling quirk c01f1b90 for 0000:00:02.0
[   15.736383] PCI: Calling quirk c02adc20 for 0000:00:02.0
[   15.736389] PCI: Calling quirk c02ade30 for 0000:00:02.0
[   15.736396] PCI: Calling quirk c02ae030 for 0000:00:02.0
[   15.736401] Boot video device is 0000:00:02.0
[   15.736417] PCI: Found 0000:00:02.1 [8086/2792] 000380 00
[   15.736438] PCI: Calling quirk c01f1b90 for 0000:00:02.1
[   15.736445] PCI: Calling quirk c02adc20 for 0000:00:02.1
[   15.736451] PCI: Calling quirk c02ade30 for 0000:00:02.1
[   15.736458] PCI: Calling quirk c02ae030 for 0000:00:02.1
[   15.736543] PCI: Found 0000:00:1b.0 [8086/2668] 000403 00
[   15.736554] Turning off bus mastering on 0000:00:1b.0
[   15.736605] PCI: Calling quirk c01f1b90 for 0000:00:1b.0
[   15.736612] PCI: Calling quirk c02adc20 for 0000:00:1b.0
[   15.736618] PCI: Calling quirk c02ade30 for 0000:00:1b.0
[   15.736624] PCI: Calling quirk c02ae030 for 0000:00:1b.0
[   15.736644] PCI: Found 0000:00:1d.0 [8086/2658] 000c03 00
[   15.736654] Turning off bus mastering on 0000:00:1d.0
[   15.736705] PCI: Calling quirk c01f1b90 for 0000:00:1d.0
[   15.736711] PCI: Calling quirk c02adc20 for 0000:00:1d.0
[   15.736718] PCI: Calling quirk c02ade30 for 0000:00:1d.0
[   15.736724] PCI: Calling quirk c02ae030 for 0000:00:1d.0
[   15.736741] PCI: Found 0000:00:1d.1 [8086/2659] 000c03 00
[   15.736751] Turning off bus mastering on 0000:00:1d.1
[   15.736803] PCI: Calling quirk c01f1b90 for 0000:00:1d.1
[   15.736809] PCI: Calling quirk c02adc20 for 0000:00:1d.1
[   15.736816] PCI: Calling quirk c02ade30 for 0000:00:1d.1
[   15.736822] PCI: Calling quirk c02ae030 for 0000:00:1d.1
[   15.736839] PCI: Found 0000:00:1d.2 [8086/265a] 000c03 00
[   15.736849] Turning off bus mastering on 0000:00:1d.2
[   15.736900] PCI: Calling quirk c01f1b90 for 0000:00:1d.2
[   15.736907] PCI: Calling quirk c02adc20 for 0000:00:1d.2
[   15.736913] PCI: Calling quirk c02ade30 for 0000:00:1d.2
[   15.736919] PCI: Calling quirk c02ae030 for 0000:00:1d.2
[   15.736960] PCI: Found 0000:00:1d.7 [8086/265c] 000c03 00
[   15.736970] Turning off bus mastering on 0000:00:1d.7
[   15.737021] PCI: Calling quirk c01f1b90 for 0000:00:1d.7
[   15.737028] PCI: Calling quirk c02adc20 for 0000:00:1d.7
[   15.737034] PCI: Calling quirk c02ade30 for 0000:00:1d.7
[   15.737040] PCI: Calling quirk c02ae030 for 0000:00:1d.7
[   15.737066] PCI: Found 0000:00:1e.0 [8086/2448] 000604 01
[   15.737091] PCI: Calling quirk c01f1b90 for 0000:00:1e.0
[   15.737098] PCI: Calling quirk c02adc20 for 0000:00:1e.0
[   15.737104] PCI: Calling quirk c02ade30 for 0000:00:1e.0
[   15.737118] PCI: Calling quirk c02ae030 for 0000:00:1e.0
[   15.737138] PCI: Found 0000:00:1f.0 [8086/2641] 000601 00
[   15.737148] Turning off bus mastering on 0000:00:1f.0
[   15.737212] PCI: Calling quirk c01f14c0 for 0000:00:1f.0
[   15.737223] PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[   15.737237] PCI quirk: region 1180-11bf claimed by ICH6 GPIO
[   15.737248] PCI: Calling quirk c01f1b90 for 0000:00:1f.0
[   15.737255] PCI: Calling quirk c02adc20 for 0000:00:1f.0
[   15.737261] PCI: Calling quirk c02ade30 for 0000:00:1f.0
[   15.737267] PCI: Calling quirk c02ae030 for 0000:00:1f.0
[   15.737285] PCI: Found 0000:00:1f.1 [8086/266f] 000101 00
[   15.737295] Turning off bus mastering on 0000:00:1f.1
[   15.737346] PCI: Calling quirk c01f1b90 for 0000:00:1f.1
[   15.737352] PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
[   15.737364] PCI: Calling quirk c02adc20 for 0000:00:1f.1
[   15.737370] PCI: Calling quirk c02ade30 for 0000:00:1f.1
[   15.737376] PCI: Calling quirk c02ae030 for 0000:00:1f.1
[   15.737407] PCI: Found 0000:00:1f.2 [8086/2653] 000101 00
[   15.737418] Turning off bus mastering on 0000:00:1f.2
[   15.737469] PCI: Calling quirk c01f1b90 for 0000:00:1f.2
[   15.737476] PCI: Calling quirk c02adc20 for 0000:00:1f.2
[   15.737482] PCI: Calling quirk c02ade30 for 0000:00:1f.2
[   15.737488] PCI: Calling quirk c02ae030 for 0000:00:1f.2
[   15.737508] PCI: Found 0000:00:1f.3 [8086/266a] 000c05 00
[   15.737572] PCI: Calling quirk c01f1b90 for 0000:00:1f.3
[   15.737579] PCI: Calling quirk c02adc20 for 0000:00:1f.3
[   15.737586] PCI: Calling quirk c02ade30 for 0000:00:1f.3
[   15.737592] PCI: Calling quirk c02ae030 for 0000:00:1f.3
[   15.737605] PCI: Fixups for bus 0000:00
[   15.737614] PCI: Scanning behind PCI bridge 0000:00:1e.0, config 070600, pass 0
[   15.737684] PCI: Scanning bus 0000:06
[   15.737722] PCI: Found 0000:06:03.0 [1180/0476] 000607 02
[   15.737745] PCI: Calling quirk c01f1b90 for 0000:06:03.0
[   15.737752] PCI: Calling quirk c02adc20 for 0000:06:03.0
[   15.737758] PCI: Calling quirk c02ae030 for 0000:06:03.0
[   15.737789] PCI: Found 0000:06:03.1 [1180/0552] 000c00 00
[   15.737801] Turning off bus mastering on 0000:06:03.1
[   15.737866] PCI: Calling quirk c01f1b90 for 0000:06:03.1
[   15.737873] PCI: Calling quirk c02adc20 for 0000:06:03.1
[   15.737879] PCI: Calling quirk c02ae030 for 0000:06:03.1
[   15.737912] PCI: Found 0000:06:03.2 [1180/0822] 000805 00
[   15.737923] Turning off bus mastering on 0000:06:03.2
[   15.737989] PCI: Calling quirk c01f1b90 for 0000:06:03.2
[   15.737995] PCI: Calling quirk c02adc20 for 0000:06:03.2
[   15.738001] PCI: Calling quirk c02ae030 for 0000:06:03.2
[   15.738032] PCI: Found 0000:06:03.3 [1180/0592] 000880 00
[   15.738098] PCI: Calling quirk c01f1b90 for 0000:06:03.3
[   15.738104] PCI: Calling quirk c02adc20 for 0000:06:03.3
[   15.738128] PCI: Calling quirk c02ae030 for 0000:06:03.3
[   15.738159] PCI: Found 0000:06:03.4 [1180/0852] 000880 00
[   15.738224] PCI: Calling quirk c01f1b90 for 0000:06:03.4
[   15.738230] PCI: Calling quirk c02adc20 for 0000:06:03.4
[   15.738237] PCI: Calling quirk c02ae030 for 0000:06:03.4
[   15.738275] PCI: Found 0000:06:04.0 [10ec/8139] 000200 00
[   15.738287] Turning off bus mastering on 0000:06:04.0
[   15.738354] PCI: Calling quirk c01f1b90 for 0000:06:04.0
[   15.738360] PCI: Calling quirk c02adc20 for 0000:06:04.0
[   15.738366] PCI: Calling quirk c02ae030 for 0000:06:04.0
[   15.738400] PCI: Found 0000:06:05.0 [8086/4223] 000280 00
[   15.738411] Turning off bus mastering on 0000:06:05.0
[   15.738479] PCI: Calling quirk c01f1b90 for 0000:06:05.0
[   15.738486] PCI: Calling quirk c02adc20 for 0000:06:05.0
[   15.738492] PCI: Calling quirk c02ade30 for 0000:06:05.0
[   15.738498] PCI: Calling quirk c02ae030 for 0000:06:05.0
[   15.738566] PCI: Fixups for bus 0000:06
[   15.738571] PCI: Transparent bridge - 0000:00:1e.0
[   15.738596] PCI: Scanning behind PCI bridge 0000:06:03.0, config 070706, pass 0
[   15.738620] PCI: Scanning behind PCI bridge 0000:06:03.0, config 070706, pass 1
[   15.738695] PCI: Bus #07 (-#0a) is hidden behind transparent bridge #06 (-#07) (try 'pci=assign-busses')
[   15.738712] Please report the result to linux-kernel to fix this permanently
[   15.738726] PCI: Bus scan for 0000:06 returning with max=0a
[   15.738737] PCI: Scanning behind PCI bridge 0000:00:1e.0, config 070600, pass 1
[   15.738755] PCI: Bus scan for 0000:00 returning with max=0a
[   15.738780] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   15.740096] PM: Adding info for pci:0000:00:00.0
[   15.740547] PM: Adding info for pci:0000:00:02.0
[   15.740984] PM: Adding info for pci:0000:00:02.1
[   15.741424] PM: Adding info for pci:0000:00:1b.0
[   15.741851] PM: Adding info for pci:0000:00:1d.0
[   15.742292] PM: Adding info for pci:0000:00:1d.1
[   15.742724] PM: Adding info for pci:0000:00:1d.2
[   15.743160] PM: Adding info for pci:0000:00:1d.7
[   15.743588] PM: Adding info for pci:0000:00:1e.0
[   15.744026] PM: Adding info for pci:0000:00:1f.0
[   15.744479] PM: Adding info for pci:0000:00:1f.1
[   15.744907] PM: Adding info for pci:0000:00:1f.2
[   15.745345] PM: Adding info for pci:0000:00:1f.3
[   15.745775] PM: Adding info for pci:0000:06:03.0
[   15.745864] PM: Adding info for pci:0000:06:03.1
[   15.745959] PM: Adding info for pci:0000:06:03.2
[   15.746045] PM: Adding info for pci:0000:06:03.3
[   15.746148] PM: Adding info for pci:0000:06:03.4
[   15.746231] PM: Adding info for pci:0000:06:04.0
[   15.746317] PM: Adding info for pci:0000:06:05.0
[   15.747354] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
[   15.755608] ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[   15.756334] ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[   15.757052] ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[   15.757784] ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[   15.758503] ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
[   15.759225] ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 11 12 14 15) *0, disabled.
[   15.759940] ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
[   15.760668] ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 5 6 7 *11 12 14 15)
[   15.766011] SCSI subsystem initialized
[   15.766150] PCI: Using ACPI for IRQ routing
[   15.766162] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   15.767291] PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
[   15.767315]   got res [52000000:5207ffff] bus [52000000:5207ffff] flags 200 for BAR 0 of 0000:00:02.1
[   15.767327] PCI: moved device 0000:00:02.1 resource 0 (200) to 52000000
[   15.767344]   got res [b0103000:b0103fff] bus [b0103000:b0103fff] flags 200 for BAR 0 of 0000:06:03.0
[   15.767357] PCI: moved device 0000:06:03.0 resource 0 (200) to b0103000
[   15.767365] PCI: Bus 7, cardbus bridge: 0000:06:03.0
[   15.767376]   IO window: 00002400-000024ff
[   15.767389]   IO window: 00002800-000028ff
[   15.767402]   PREFETCH window: 50000000-51ffffff
[   15.767415]   MEM window: 54000000-55ffffff
[   15.767427] PCI: Bridge: 0000:00:1e.0
[   15.767438]   IO window: 2000-2fff
[   15.767451]   MEM window: b0100000-b01fffff
[   15.767463]   PREFETCH window: 50000000-51ffffff
[   15.767490] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   15.767516] ACPI: PCI Interrupt 0000:06:03.0[A] -> GSI 16 (level, low) -> IRQ 16
[   15.767564] NET: Registered protocol family 2
[   15.777168] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   15.777390] TCP established hash table entries: 131072 (order: 7, 524288 bytes)
[   15.778514] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[   15.779084] TCP: Hash tables configured (established 131072 bind 65536)
[   15.779103] TCP reno registered
[   15.779192] PM: Adding info for platform:pcspkr
[   15.779296] Simple Boot Flag at 0x7f set to 0x1
[   15.780852] Initializing Cryptographic API
[   15.780869] io scheduler noop registered
[   15.780884] io scheduler anticipatory registered (default)
[   15.780902] io scheduler deadline registered
[   15.780926] io scheduler cfq registered
[   15.780940] PCI: Calling quirk c01f1a50 for 0000:00:00.0
[   15.780947] PCI: Calling quirk c01f1d10 for 0000:00:00.0
[   15.780954] PCI: Calling quirk c02923f0 for 0000:00:00.0
[   15.780961] PCI: Calling quirk c01f1a50 for 0000:00:02.0
[   15.780968] PCI: Calling quirk c01f1d10 for 0000:00:02.0
[   15.780974] PCI: Calling quirk c02923f0 for 0000:00:02.0
[   15.780981] PCI: Calling quirk c01f1a50 for 0000:00:02.1
[   15.780987] PCI: Calling quirk c01f1d10 for 0000:00:02.1
[   15.780993] PCI: Calling quirk c02923f0 for 0000:00:02.1
[   15.781001] PCI: Calling quirk c01f1a50 for 0000:00:1b.0
[   15.781007] PCI: Calling quirk c01f1d10 for 0000:00:1b.0
[   15.781013] PCI: Calling quirk c02923f0 for 0000:00:1b.0
[   15.781020] PCI: Calling quirk c01f1a50 for 0000:00:1d.0
[   15.781026] PCI: Calling quirk c01f1d10 for 0000:00:1d.0
[   15.781032] PCI: Calling quirk c02923f0 for 0000:00:1d.0
[   15.781045] pci 0000:00:1d.0: uhci_check_and_reset_hc: legsup = 0x003b
[   15.781051] pci 0000:00:1d.0: Performing full reset
[   15.781069] PCI: Calling quirk c01f1a50 for 0000:00:1d.1
[   15.781075] PCI: Calling quirk c01f1d10 for 0000:00:1d.1
[   15.781081] PCI: Calling quirk c02923f0 for 0000:00:1d.1
[   15.781099] pci 0000:00:1d.1: uhci_check_and_reset_hc: legsup = 0x0010
[   15.781106] pci 0000:00:1d.1: Performing full reset
[   15.781124] PCI: Calling quirk c01f1a50 for 0000:00:1d.2
[   15.781130] PCI: Calling quirk c01f1d10 for 0000:00:1d.2
[   15.781136] PCI: Calling quirk c02923f0 for 0000:00:1d.2
[   15.781146] pci 0000:00:1d.2: uhci_check_and_reset_hc: legsup = 0x0010
[   15.781152] pci 0000:00:1d.2: Performing full reset
[   15.781170] PCI: Calling quirk c01f1a50 for 0000:00:1d.7
[   15.781176] PCI: Calling quirk c01f1d10 for 0000:00:1d.7
[   15.781183] PCI: Calling quirk c02923f0 for 0000:00:1d.7
[   15.781204] PCI: Calling quirk c01f1a50 for 0000:00:1e.0
[   15.781211] PCI: Calling quirk c01f1d10 for 0000:00:1e.0
[   15.781217] PCI: Calling quirk c02923f0 for 0000:00:1e.0
[   15.781224] PCI: Calling quirk c01f1a50 for 0000:00:1f.0
[   15.781230] PCI: Calling quirk c01f1d10 for 0000:00:1f.0
[   15.781236] PCI: Calling quirk c02923f0 for 0000:00:1f.0
[   15.781243] PCI: Calling quirk c01f1a50 for 0000:00:1f.1
[   15.781249] PCI: Calling quirk c01f1d10 for 0000:00:1f.1
[   15.781255] PCI: Calling quirk c02923f0 for 0000:00:1f.1
[   15.781262] PCI: Calling quirk c01f1a50 for 0000:00:1f.2
[   15.781268] PCI: Calling quirk c01f1d10 for 0000:00:1f.2
[   15.781276] PCI: Calling quirk c02923f0 for 0000:00:1f.2
[   15.781283] PCI: Calling quirk c01f1a50 for 0000:00:1f.3
[   15.781289] PCI: Calling quirk c01f1d10 for 0000:00:1f.3
[   15.781296] PCI: Calling quirk c02923f0 for 0000:00:1f.3
[   15.781302] PCI: Calling quirk c01f1a50 for 0000:06:03.0
[   15.781311] PCI: Calling quirk c02923f0 for 0000:06:03.0
[   15.781317] PCI: Calling quirk c01f1a50 for 0000:06:03.1
[   15.781323] PCI: Calling quirk c02923f0 for 0000:06:03.1
[   15.781330] PCI: Calling quirk c01f1a50 for 0000:06:03.2
[   15.781336] PCI: Calling quirk c02923f0 for 0000:06:03.2
[   15.781343] PCI: Calling quirk c01f1a50 for 0000:06:03.3
[   15.781349] PCI: Calling quirk c02923f0 for 0000:06:03.3
[   15.781356] PCI: Calling quirk c01f1a50 for 0000:06:03.4
[   15.781362] PCI: Calling quirk c02923f0 for 0000:06:03.4
[   15.781369] PCI: Calling quirk c01f1a50 for 0000:06:04.0
[   15.781375] PCI: Calling quirk c02923f0 for 0000:06:04.0
[   15.781382] PCI: Calling quirk c01f1a50 for 0000:06:05.0
[   15.781388] PCI: Calling quirk c01f1d10 for 0000:06:05.0
[   15.781394] PCI: Calling quirk c02923f0 for 0000:06:05.0
[   15.781742] PM: Adding info for platform:vesafb.0
[   15.781813] vesafb: framebuffer at 0xc0000000, mapped to 0xf8880000, using 1536k, total 7872k
[   15.781832] vesafb: mode is 1024x768x8, linelength=1024, pages=9
[   15.781844] vesafb: protected mode interface info at 00ff:44f0
[   15.781855] vesafb: scrolling: redraw
[   15.781865] vesafb: Pseudocolor: size=8:8:8:8, shift=0:0:0:0
[   15.795338] Console: switching to colour frame buffer device 128x48
[   15.809507] fb0: VESA VGA frame buffer device
[   15.809965] ACPI: AC Adapter [AC] (off-line)
[   15.811850] ACPI: Battery Slot [CMB1] (battery present)
[   15.812139] ACPI: Battery Slot [CMB2] (battery absent)
[   15.812296] ACPI: Power Button (FF) [PWRF]
[   15.812462] ACPI: Lid Switch [LID]
[   15.812559] ACPI: Power Button (CM) [PWRB]
[   15.813468] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   15.814362] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   15.818125] Real Time Clock Driver v1.12ac
[   15.818237] Linux agpgart interface v0.101 (c) Dave Jones
[   15.818434] agpgart: Detected an Intel 915GM Chipset.
[   15.820350] agpgart: Detected 7932K stolen memory.
[   15.841777] agpgart: AGP aperture is 256M @ 0xc0000000
[   15.842006] intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
[   15.842275] intelfb: Version 0.9.4
[   15.842467] ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
[   15.842673] intelfb: Cannot reserve FB region.
[   15.847539] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   15.852510] PM: Adding info for platform:serial8250
[   15.853052] PM: Adding info for No Bus:isa
[   15.853125] PM: Adding info for No Bus:lo
[   15.853268] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   15.858276] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   15.863402] ICH6: IDE controller at PCI slot 0000:00:1f.1
[   15.868432] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 17
[   15.873558] ICH6: chipset revision 4
[   15.878571] ICH6: not 100% native mode: will probe irqs later
[   15.883607] PCI: Enabling bus mastering for device 0000:00:1f.1
[   15.883617] PCI: Setting latency timer of device 0000:00:1f.1 to 64
[   15.883627]     ide0: BM-DMA at 0x1410-0x1417, BIOS settings: hda:DMA, hdb:pio
[   15.888714] Probing IDE interface ide0...
[    0.530000] hda: TOSHIBA MK6006GAH, ATA DISK drive
[    0.531000] PM: Adding info for No Bus:ide0
[    1.143000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    1.144000] PM: Adding info for ide:0.0
[    1.144000] Probing IDE interface ide1...
[    1.657000] hda: max request size: 512KiB
[    1.682000] hda: 117210240 sectors (60011 MB), CHS=16383/255/63, UDMA(100)
[    1.683000] hda: cache flushes supported
[    1.684000]  hda: hda1 hda2 hda3 hda4
[    1.691000] libata version 2.00 loaded.
[    1.691000] ata_piix 0000:00:1f.2: version 2.00
[    1.691000] ata_piix 0000:00:1f.2: MAP [ P0 P2 XX XX ]
[    1.692000] ata_piix 0000:00:1f.2: invalid MAP value 0
[    1.693000] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 18
[    1.695000] PCI: Enabling bus mastering for device 0000:00:1f.2
[    1.695000] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[    1.695000] ata1: SATA max UDMA/133 cmd 0x1498 ctl 0x140E bmdma 0x1480 irq 18
[    1.696000] ata2: SATA max UDMA/133 cmd 0x1490 ctl 0x140A bmdma 0x1488 irq 18
[    1.697000] scsi0 : ata_piix
[    1.698000] PM: Adding info for No Bus:host0
[   32.254000] ata1.01: qc timeout (cmd 0xa1)
[   32.255000] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
[   32.256000] ata1: failed to recover some devices, retrying in 5 secs
[   67.814000] ata1.01: qc timeout (cmd 0xa1)
[   67.815000] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
[   67.816000] ata1: failed to recover some devices, retrying in 5 secs
[  103.374000] ata1.01: qc timeout (cmd 0xa1)
[  103.375000] ata1.01: failed to IDENTIFY (I/O error, err_mask=0x4)
[  103.376000] ata1: failed to recover some devices, retrying in 5 secs
[  108.936000] ata1.00: configured for UDMA/33
[  108.937000] scsi1 : ata_piix
[  108.938000] PM: Adding info for No Bus:host1
[  109.039000] ata2: SATA port has no device.
[  109.040000] ATA: abnormal status 0x7F on port 0x1497
[  109.041000] PM: Adding info for No Bus:target0:0:0
[  109.043000]   Vendor: MATSHITA  Model: DVD-RAM UJ-832S   Rev: 1.60
[  109.044000]   Type:   CD-ROM                             ANSI SCSI revision: 05
[  109.046000] PM: Adding info for scsi:0:0:0:0
[  109.046000] PM: Adding info for platform:i8042

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.17-git15
# Thu Jun 29 17:50:11 2006
#
CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_RELAY=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_RT_MUTEXES=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0
# CONFIG_SLOB is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=y

#
# Block layer
#
# CONFIG_LBD is not set
CONFIG_BLK_DEV_IO_TRACE=y
# CONFIG_LSF is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_AS=y
# CONFIG_DEFAULT_DEADLINE is not set
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="anticipatory"

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUMM=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
# CONFIG_HPET_TIMER is not set
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_MCE is not set
CONFIG_VM86=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_X86_REBOOTFIXUPS is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_DELL_RBU is not set
# CONFIG_DCDBAS is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_RESOURCES_64BIT is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
# CONFIG_REGPARM is not set
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
# CONFIG_KEXEC is not set
CONFIG_PHYSICAL_START=0x100000
# CONFIG_COMPAT_VDSO is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_LEGACY is not set
CONFIG_PM_DEBUG=y
CONFIG_PM_TRACE=y
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_PM_STD_PARTITION="/dev/hda3"

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
# CONFIG_ACPI_SLEEP_PROC_SLEEP is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_HOTKEY=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_IBM is not set
# CONFIG_ACPI_TOSHIBA is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_CONTAINER=m

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_STAT_DETAILS=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPUFreq processor drivers
#
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_POWERNOW_K6 is not set
# CONFIG_X86_POWERNOW_K7 is not set
# CONFIG_X86_POWERNOW_K8 is not set
# CONFIG_X86_GX_SUSPMOD is not set
CONFIG_X86_SPEEDSTEP_CENTRINO=y
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=y
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=y
# CONFIG_X86_SPEEDSTEP_ICH is not set
# CONFIG_X86_SPEEDSTEP_SMI is not set
# CONFIG_X86_P4_CLOCKMOD is not set
# CONFIG_X86_CPUFREQ_NFORCE2 is not set
# CONFIG_X86_LONGRUN is not set

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
# CONFIG_X86_SPEEDSTEP_LIB is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=m
# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_DEBUG=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
CONFIG_PCMCIA_DEBUG=y
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
# CONFIG_TCIC is not set
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=m

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=m
CONFIG_HOTPLUG_PCI_FAKE=m
CONFIG_HOTPLUG_PCI_COMPAQ=m
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=m
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_HOTPLUG_PCI_CPCI=y
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=m
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=m
CONFIG_HOTPLUG_PCI_SHPC=m
# CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
# CONFIG_NETDEBUG is not set
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_UNIX=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y
CONFIG_NET_KEY=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# Core Netfilter Configuration
#
# CONFIG_NETFILTER_NETLINK is not set
# CONFIG_NF_CONNTRACK is not set
# CONFIG_NETFILTER_XTABLES is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set

#
# DCCP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_DCCP is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set

#
# TIPC Configuration (EXPERIMENTAL)
#
# CONFIG_TIPC is not set
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
CONFIG_BT=m
# CONFIG_BT_L2CAP is not set
CONFIG_BT_SCO=m

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
# CONFIG_BT_HCIUART is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
# CONFIG_BT_HCIBFUSB is not set
# CONFIG_BT_HCIDTL1 is not set
# CONFIG_BT_HCIBT3C is not set
# CONFIG_BT_HCIBLUECARD is not set
# CONFIG_BT_HCIBTUART is not set
# CONFIG_BT_HCIVHCI is not set
CONFIG_IEEE80211=m
# CONFIG_IEEE80211_DEBUG is not set
CONFIG_IEEE80211_CRYPT_WEP=m
CONFIG_IEEE80211_CRYPT_CCMP=m
CONFIG_IEEE80211_CRYPT_TKIP=m
CONFIG_IEEE80211_SOFTMAC=m
# CONFIG_IEEE80211_SOFTMAC_DEBUG is not set
CONFIG_WIRELESS_EXT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_SYS_HYPERVISOR is not set

#
# Connector - unified userspace <-> kernelspace linker
#
CONFIG_CONNECTOR=m

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
CONFIG_PARPORT_NOT_PC=y
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_UB=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_SHARE_IRQ is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=y
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m

#
# SCSI low-level drivers
#
# CONFIG_ISCSI_TCP is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_AHCI is not set
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_SATA_MV is not set
# CONFIG_SCSI_SATA_NV is not set
# CONFIG_SCSI_PDC_ADMA is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_SATA_QSTOR is not set
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIL24 is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_ULI is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
CONFIG_SCSI_SATA_INTEL_COMBINED=y
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
CONFIG_SCSI_DEBUG=m

#
# PCMCIA SCSI adapter support
#
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# CONFIG_PCMCIA_SYM53C500 is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_SPI is not set
# CONFIG_FUSION_FC is not set
# CONFIG_FUSION_SAS is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=m
# CONFIG_I2O_LCT_NOTIFY_ON_CHANGES is not set
CONFIG_I2O_EXT_ADAPTEC=y
CONFIG_I2O_CONFIG=m
CONFIG_I2O_CONFIG_OLD_IOCTL=y
CONFIG_I2O_BUS=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# ARCnet devices
#
CONFIG_ARCNET=m
# CONFIG_ARCNET_1201 is not set
# CONFIG_ARCNET_1051 is not set
# CONFIG_ARCNET_RAW is not set
# CONFIG_ARCNET_CAP is not set
# CONFIG_ARCNET_COM90xx is not set
# CONFIG_ARCNET_COM90xxIO is not set
# CONFIG_ARCNET_RIM_I is not set
# CONFIG_ARCNET_COM20020 is not set

#
# PHY device support
#
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
CONFIG_MARVELL_PHY=m
CONFIG_DAVICOM_PHY=m
CONFIG_QSEMI_PHY=m
CONFIG_LXT_PHY=m
CONFIG_CICADA_PHY=m
CONFIG_VITESSE_PHY=m
CONFIG_SMSC_PHY=m

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_ULI526X is not set
# CONFIG_PCMCIA_XIRCOM is not set
# CONFIG_PCMCIA_XIRTULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
CONFIG_8139CP=m
CONFIG_8139TOO=m
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_SK98LIN is not set
# CONFIG_VIA_VELOCITY is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_CHELSIO_T1 is not set
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set
# CONFIG_MYRI10GE is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=y
CONFIG_NET_WIRELESS_RTNETLINK=y

#
# Obsolete Wireless cards support (pre-802.11)
#
# CONFIG_STRIP is not set
# CONFIG_ARLAN is not set
# CONFIG_WAVELAN is not set
# CONFIG_PCMCIA_WAVELAN is not set
# CONFIG_PCMCIA_NETWAVE is not set

#
# Wireless 802.11 Frequency Hopping cards support
#
# CONFIG_PCMCIA_RAYCS is not set

#
# Wireless 802.11b ISA/PCI cards support
#
# CONFIG_IPW2100 is not set
CONFIG_IPW2200=m
CONFIG_IPW2200_MONITOR=y
CONFIG_IPW2200_RADIOTAP=y
CONFIG_IPW2200_PROMISCUOUS=y
CONFIG_IPW2200_QOS=y
CONFIG_IPW2200_DEBUG=y
# CONFIG_AIRO is not set
CONFIG_HERMES=m
# CONFIG_PLX_HERMES is not set
# CONFIG_TMD_HERMES is not set
# CONFIG_NORTEL_HERMES is not set
CONFIG_PCI_HERMES=m
# CONFIG_ATMEL is not set

#
# Wireless 802.11b Pcmcia/Cardbus cards support
#
CONFIG_PCMCIA_HERMES=m
# CONFIG_PCMCIA_SPECTRUM is not set
# CONFIG_AIRO_CS is not set
# CONFIG_PCMCIA_WL3501 is not set

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
# CONFIG_PRISM54 is not set
CONFIG_USB_ZD1201=m
# CONFIG_HOSTAP is not set
# CONFIG_BCM43XX is not set
CONFIG_NET_WIRELESS=y

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# ATM drivers
#
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E_MAYBE is not set
# CONFIG_ATM_HE is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_TSDEV=y
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
# CONFIG_JOYSTICK_A3D is not set
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
# CONFIG_JOYSTICK_GF2K is not set
# CONFIG_JOYSTICK_GRIP is not set
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
# CONFIG_JOYSTICK_TURBOGRAFX is not set
# CONFIG_JOYSTICK_JOYDUMP is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_WISTRON_BTNS is not set
CONFIG_INPUT_UINPUT=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=m
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_DRM=m
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_I810=m
CONFIG_DRM_I830=m
CONFIG_DRM_I915=m
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
# CONFIG_DRM_VIA is not set
# CONFIG_DRM_SAVAGE is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
# CONFIG_CARDMAN_4000 is not set
# CONFIG_CARDMAN_4040 is not set
# CONFIG_MWAVE is not set
# CONFIG_PC8736x_GPIO is not set
# CONFIG_NSC_GPIO is not set
# CONFIG_CS5535_GPIO is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# TPM devices
#
# CONFIG_TCG_TPM is not set
# CONFIG_TELCLOCK is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_I801=m
CONFIG_I2C_I810=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_ISA=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_OCORES=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
CONFIG_I2C_PROSAVAGE=m
CONFIG_I2C_SAVAGE4=m
CONFIG_SCx200_ACB=m
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
CONFIG_I2C_STUB=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
CONFIG_I2C_VOODOO3=m
CONFIG_I2C_PCA_ISA=m

#
# Miscellaneous I2C Chip support
#
CONFIG_SENSORS_DS1337=m
CONFIG_SENSORS_DS1374=m
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_PCF8574=m
CONFIG_SENSORS_PCA9539=m
CONFIG_SENSORS_PCF8591=m
CONFIG_SENSORS_MAX6875=m
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
CONFIG_I2C_DEBUG_CHIP=y

#
# SPI support
#
CONFIG_SPI=y
CONFIG_SPI_DEBUG=y
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_BITBANG=m
CONFIG_SPI_BUTTERFLY=m

#
# SPI Protocol Masters
#

#
# Dallas's 1-wire bus
#
CONFIG_W1=m
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=m
CONFIG_W1_MASTER_DS2490=m
CONFIG_W1_MASTER_DS2482=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=m
CONFIG_W1_SLAVE_DS2433=m
CONFIG_W1_SLAVE_DS2433_CRC=y

#
# Hardware Monitoring support
#
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_FSCHER=m
CONFIG_SENSORS_FSCPOS=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT8231=m
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
CONFIG_SENSORS_HDAPS=m
CONFIG_HWMON_DEBUG_CHIP=y

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set
CONFIG_VIDEO_V4L2=y

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set
CONFIG_USB_DABUSB=m

#
# Graphics support
#
CONFIG_FIRMWARE_EDID=y
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
# CONFIG_FB_IMAC is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
CONFIG_FB_I810=y
# CONFIG_FB_I810_GTF is not set
CONFIG_FB_INTEL=y
# CONFIG_FB_INTEL_DEBUG is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_CYBLA is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_GEODE is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_DEVICE=y
CONFIG_LCD_CLASS_DEVICE=m
CONFIG_LCD_DEVICE=y

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
# CONFIG_SND_PCM_OSS_PLUGINS is not set
# CONFIG_SND_SEQUENCER_OSS is not set
# CONFIG_SND_RTCTIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_ADLIB is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_MIRO is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set
# CONFIG_SND_WAVEFRONT is not set

#
# PCI devices
#
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS5535AUDIO is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDA_INTEL=m
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# USB devices
#
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_USX2Y=m

#
# PCMCIA devices
#
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_PDAUDIOCF is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_SUSPEND=y
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_ISP116X_HCD=m
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
#

#
# may also be needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_STORAGE_ALAUDA is not set
CONFIG_USB_LIBUSUAL=y

#
# USB Input Devices
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDINPUT_POWERBOOK=y
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_ACECAD=m
CONFIG_USB_KBTAB=m
CONFIG_USB_POWERMATE=m
CONFIG_USB_TOUCHSCREEN=m
CONFIG_USB_TOUCHSCREEN_EGALAX=y
CONFIG_USB_TOUCHSCREEN_PANJIT=y
CONFIG_USB_TOUCHSCREEN_3M=y
CONFIG_USB_TOUCHSCREEN_ITM=y
CONFIG_USB_YEALINK=m
CONFIG_USB_XPAD=m
CONFIG_USB_ATI_REMOTE=m
CONFIG_USB_ATI_REMOTE2=m
CONFIG_USB_KEYSPAN_REMOTE=m
CONFIG_USB_APPLETOUCH=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m

#
# USB Network Adapters
#
CONFIG_USB_CATC=m
CONFIG_USB_KAWETH=m
CONFIG_USB_PEGASUS=m
CONFIG_USB_RTL8150=m
CONFIG_USB_USBNET=m
CONFIG_USB_NET_AX8817X=m
CONFIG_USB_NET_CDCETHER=m
CONFIG_USB_NET_GL620A=m
CONFIG_USB_NET_NET1080=m
CONFIG_USB_NET_PLUSB=m
CONFIG_USB_NET_RNDIS_HOST=m
CONFIG_USB_NET_CDC_SUBSET=m
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_NET_ZAURUS=m
CONFIG_USB_MON=y

#
# USB port drivers
#
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_AIRPRIME=m
CONFIG_USB_SERIAL_ANYDATA=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP2101=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_FUNSOFT=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
CONFIG_USB_SERIAL_GARMIN=m
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
# CONFIG_USB_SERIAL_KEYSPAN_MPR is not set
CONFIG_USB_SERIAL_KEYSPAN_USA28=y
CONFIG_USB_SERIAL_KEYSPAN_USA28X=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=y
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=y
CONFIG_USB_SERIAL_KEYSPAN_USA19=y
CONFIG_USB_SERIAL_KEYSPAN_USA18X=y
CONFIG_USB_SERIAL_KEYSPAN_USA19W=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=y
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=y
CONFIG_USB_SERIAL_KEYSPAN_USA49W=y
# CONFIG_USB_SERIAL_KEYSPAN_USA49WLC is not set
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_HP4X=m
CONFIG_USB_SERIAL_SAFE=m
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_TI=m
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
# CONFIG_USB_SERIAL_OPTION is not set
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_EZUSB=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_AUERSWALD=m
CONFIG_USB_RIO500=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
CONFIG_USB_LED=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_GOTEMP=m
CONFIG_USB_PHIDGETKIT=m
CONFIG_USB_PHIDGETSERVO=m
CONFIG_USB_IDMOUSE=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
CONFIG_USB_TEST=m

#
# USB DSL modem support
#
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Gadget Support
#
CONFIG_USB_GADGET=m
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_SELECTED=y
CONFIG_USB_GADGET_NET2280=y
CONFIG_USB_NET2280=m
# CONFIG_USB_GADGET_PXA2XX is not set
# CONFIG_USB_GADGET_GOKU is not set
# CONFIG_USB_GADGET_LH7A40X is not set
# CONFIG_USB_GADGET_OMAP is not set
# CONFIG_USB_GADGET_AT91 is not set
# CONFIG_USB_GADGET_DUMMY_HCD is not set
CONFIG_USB_GADGET_DUALSPEED=y
CONFIG_USB_ZERO=m
CONFIG_USB_ETH=m
CONFIG_USB_ETH_RNDIS=y
CONFIG_USB_GADGETFS=m
# CONFIG_USB_FILE_STORAGE is not set
CONFIG_USB_G_SERIAL=m

#
# MMC/SD Card support
#
CONFIG_MMC=m
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_BLOCK=m
CONFIG_MMC_SDHCI=m
CONFIG_MMC_WBSD=m

#
# LED devices
#
# CONFIG_NEW_LEDS is not set

#
# LED drivers
#

#
# LED Triggers
#

#
# InfiniBand support
#
# CONFIG_INFINIBAND is not set

#
# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
#
# CONFIG_EDAC is not set

#
# Real Time Clock
#
CONFIG_RTC_LIB=m
CONFIG_RTC_CLASS=m

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=m
CONFIG_RTC_INTF_PROC=m
CONFIG_RTC_INTF_DEV=m
CONFIG_RTC_INTF_DEV_UIE_EMUL=y

#
# RTC drivers
#
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_DS1307=m
CONFIG_RTC_DRV_DS1553=m
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
# CONFIG_RTC_DRV_RS5C348 is not set
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_M48T86=m
CONFIG_RTC_DRV_TEST=m
CONFIG_RTC_DRV_MAX6902=m
CONFIG_RTC_DRV_V3020=m

#
# DMA Engine support
#
# CONFIG_DMA_ENGINE is not set

#
# DMA Clients
#

#
# DMA Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT2_FS_XIP is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_XATTR is not set
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_FS_POSIX_ACL is not set
# CONFIG_XFS_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
CONFIG_AUTOFS_FS=m
CONFIG_AUTOFS4_FS=m
CONFIG_FUSE_FS=m

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=m

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
CONFIG_HPFS_FS=m
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="cp437"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Instrumentation Support
#
CONFIG_PROFILING=y
CONFIG_OPROFILE=m
# CONFIG_KPROBES is not set

#
# Kernel hacking
#
CONFIG_PRINTK_TIME=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=16
# CONFIG_DETECT_SOFTLOCKUP is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_RT_MUTEX_TESTER is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_INFO is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_VM is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_UNWIND_INFO is not set
# CONFIG_FORCED_INLINING is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_EARLY_PRINTK=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_STACK_BACKTRACE_COLS=1

#
# Page alloc debug is incompatible with Software Suspend on i386
#
# CONFIG_DEBUG_RODATA is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_DEBUG_PROC_KEYS=y
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
# CONFIG_CRYPTO_TEST is not set

#
# Hardware crypto devices
#
# CONFIG_CRYPTO_DEV_PADLOCK is not set

#
# Library routines
#
CONFIG_CRC_CCITT=y
CONFIG_CRC16=m
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_PLIST=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y

--AqsLC8rIMeq19msA--
