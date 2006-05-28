From: =?ISO-8859-15?Q?Martin_Ammerm=FCller?=
	<martin.ammermueller@bnro.de>
Subject: Re: [FYI] Update on sata_sil problem with timeouts
Date: Sun, 28 May 2006 14:41:24 +0200
Message-ID: <44799A74.9070005@bnro.de>
References: <443E6B81.5090004@bnro.de> <443E916F.1040203@gmail.com> <4469F8CB.7040706@bnro.de> <44779BDC.60900@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070900040805010800000408"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout02.sul.t-online.com ([194.25.134.17]:4780 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750751AbWE1Ml0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 May 2006 08:41:26 -0400
In-Reply-To: <44779BDC.60900@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070900040805010800000408
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeff Garzik wrote:
> Martin Ammermüller wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> I tested 2.6.17-rc4-mm1 and 2.6.17-rc4 in the last days and got similar
>> error messages (command timeout & translated ATA stat/err).
>>
>> I used 5 simultaneously started instances of bonnie++ for testing.
> 
> Can you retest with the current -mm?

The timeouts still occur, but according to dmesg output they are handled
well:
- ----
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x21)
ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/100
ata1: EH complete
- ---

I attached a complete dmesg output from 2.6.17-rc4-mm3 after testing.

As i wrote earlier[0], the timeouts do not occur when apic and acpi are
turned off. Does that mean that the timeouts are related to acpi/apic
not working properly?

Best Regards,
Martin Ammermüller
[0]http://www.spinics.net/lists/linux-ide/msg02485.html
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEeZp0FjFZ/qjkvZARAtWdAJ40isBKBrfD63OlMqP5RbE2lXFdEgCeLQmK
fHIVUwPKG7x08NkCSggr7mY=
=cTJo
-----END PGP SIGNATURE-----

--------------070900040805010800000408
Content-Type: text/plain;
 name="dmesg.mm3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.mm3"

[    0.000000] Linux version 2.6.17-rc4-mm3 (root@tenco) (gcc-Version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 PREEMPT Sat May 27 10:30:25 CEST 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size: 000000000009f800 end: 000000000009f800 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] add_memory_region(0000000000000000, 000000000009f800, 1)
[    0.000000] copy_e820_map() start: 000000000009f800 size: 0000000000000800 end: 00000000000a0000 type: 2
[    0.000000] add_memory_region(000000000009f800, 0000000000000800, 2)
[    0.000000] copy_e820_map() start: 00000000000dc000 size: 0000000000024000 end: 0000000000100000 type: 2
[    0.000000] add_memory_region(00000000000dc000, 0000000000024000, 2)
[    0.000000] copy_e820_map() start: 0000000000100000 size: 000000001dda0000 end: 000000001dea0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] add_memory_region(0000000000100000, 000000001dda0000, 1)
[    0.000000] copy_e820_map() start: 000000001dea0000 size: 0000000000010000 end: 000000001deb0000 type: 3
[    0.000000] add_memory_region(000000001dea0000, 0000000000010000, 3)
[    0.000000] copy_e820_map() start: 000000001deb0000 size: 0000000000050000 end: 000000001df00000 type: 4
[    0.000000] add_memory_region(000000001deb0000, 0000000000050000, 4)
[    0.000000] copy_e820_map() start: 000000001df00000 size: 0000000000100000 end: 000000001e000000 type: 2
[    0.000000] add_memory_region(000000001df00000, 0000000000100000, 2)
[    0.000000] copy_e820_map() start: 00000000e0000000 size: 0000000010000000 end: 00000000f0000000 type: 2
[    0.000000] add_memory_region(00000000e0000000, 0000000010000000, 2)
[    0.000000] copy_e820_map() start: 00000000fec00000 size: 0000000000010000 end: 00000000fec10000 type: 2
[    0.000000] add_memory_region(00000000fec00000, 0000000000010000, 2)
[    0.000000] copy_e820_map() start: 00000000fee00000 size: 0000000000001000 end: 00000000fee01000 type: 2
[    0.000000] add_memory_region(00000000fee00000, 0000000000001000, 2)
[    0.000000] copy_e820_map() start: 00000000fff80000 size: 0000000000080000 end: 0000000100000000 type: 2
[    0.000000] add_memory_region(00000000fff80000, 0000000000080000, 2)
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001dea0000 (usable)
[    0.000000]  BIOS-e820: 000000001dea0000 - 000000001deb0000 (ACPI data)
[    0.000000]  BIOS-e820: 000000001deb0000 - 000000001df00000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000001df00000 - 000000001e000000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 478MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f7710
[    0.000000] On node 0 totalpages: 122528
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   Normal zone: 118432 pages, LIFO batch:31
[    0.000000] DMI present.
[    0.000000] ATI board detected. Disabling timer routing over 8254.
[    0.000000] ACPI: RSDP (v000 TOSINV                                ) @ 0x000f76c0
[    0.000000] ACPI: RSDT (v001 TOSINV   RSDT   0x06040000  LTP 0x00000000) @ 0x1deabf9b
[    0.000000] ACPI: FADT (v001 TOSINV Goldfish 0x06040000 ATI  0x000f4240) @ 0x1deafef6
[    0.000000] ACPI: MADT (v001 TOSINV 	 APIC   0x06040000  LTP 0x00000000) @ 0x1deaff6a
[    0.000000] ACPI: MCFG (v001 TOSINV   MCFG   0x06040000  LTP 0x00000000) @ 0x1deaffc4
[    0.000000] ACPI: SSDT (v001 TOSINV  Cpu0Cst 0x00003001 INTL 0x20030224) @ 0x1deac1ce
[    0.000000] ACPI: SSDT (v001 TOSINV    CpuPm 0x00003000 INTL 0x20030224) @ 0x1deabfd3
[    0.000000] ACPI: DSDT (v001 TOSINV    SB450 0x06040000 MSFT 0x0100000e) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x8008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 6:13 APIC version 20
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 20000000 (gap: 1e000000:c2000000)
[    0.000000] Detected 1393.494 MHz processor.
[   26.543530] Built 1 zonelists
[   26.543533] Kernel command line: root=/dev/sda3 ro quiet splash
[   26.543759] mapped APIC to ffffe000 (fee00000)
[   26.543762] mapped IOAPIC to ffffd000 (fec00000)
[   26.543765] Enabling fast FPU save and restore... done.
[   26.543768] Enabling unmasked SIMD FPU exception support... done.
[   26.543771] Initializing CPU#0
[   26.543861] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   26.544952] Console: colour VGA+ 80x25
[   26.545358] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   26.545793] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   26.561644] Memory: 475972k/490112k available (1949k kernel code, 13512k reserved, 597k data, 312k init, 0k highmem)
[   26.561648] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   26.620760] Calibrating delay using timer specific routine.. 2788.65 BogoMIPS (lpj=1394326)
[   26.620791] Security Framework v1.0.0 initialized
[   26.620802] SELinux:  Disabled at boot.
[   26.620812] Mount-cache hash table entries: 512
[   26.620924] CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000000 00000000 00000000
[   26.620934] CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 00000000 00000000 00000000
[   26.620945] CPU: L1 I cache: 32K, L1 D cache: 32K
[   26.620948] CPU: L2 cache: 1024K
[   26.620950] CPU: After all inits, caps: afe9fbff 00100000 00000000 00000040 00000000 00000000 00000000
[   26.620967] CPU: Intel(R) Celeron(R) M processor         1.40GHz stepping 08
[   26.620973] Checking 'hlt' instruction... OK.
[   26.624816] SMP alternatives: switching to UP code
[   26.624819] Freeing SMP alternatives: 0k freed
[   26.643512] ENABLING IO-APIC IRQs
[   26.643703] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   26.653707] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[   26.653755] ...trying to set up timer (IRQ0) through the 8259A ...  failed.
[   26.653758] ...trying to set up timer as Virtual Wire IRQ... works.
[   26.767442] checking if image is initramfs... it is
[   27.469611] Freeing initrd memory: 6000k freed
[   27.470076] NET: Registered protocol family 16
[   27.470108] EISA bus registered
[   27.470113] ACPI: bus type pci registered
[   27.470120] PCI: Using MMCONFIG
[   27.471105] Setting up standard PCI resources
[   27.474288] ACPI: Subsystem revision 20060310
[   27.479935] ACPI: Interpreter enabled
[   27.479938] ACPI: Using IOAPIC for interrupt routing
[   27.480760] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   27.480765] PCI: Probing PCI hardware (bus 00)
[   27.482940] PCI: Ignoring BAR0-3 of IDE controller 0000:00:14.1
[   27.483233] Boot video device is 0000:01:05.0
[   27.483749] PCI: Transparent bridge - 0000:00:14.4
[   27.483849] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   27.487104] ACPI: PCI Interrupt Link [LNKA] (IRQs 10 11) *0, disabled.
[   27.487371] ACPI: PCI Interrupt Link [LNKB] (IRQs 10 11) *0, disabled.
[   27.487653] ACPI: PCI Interrupt Link [LNKC] (IRQs 10 11) *0, disabled.
[   27.487915] ACPI: PCI Interrupt Link [LNKD] (IRQs 10 11) *0, disabled.
[   27.488177] ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
[   27.488439] ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
[   27.488711] ACPI: PCI Interrupt Link [LNKG] (IRQs 10 11) *0, disabled.
[   27.488974] ACPI: PCI Interrupt Link [LNKH] (IRQs 10 11) *0, disabled.
[   27.489559] ACPI: Embedded Controller [EC0] (gpe 7) interrupt mode.
[   27.489782] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
[   27.490325] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[   27.490626] ACPI: Power Resource [PFA1] (off)
[   27.490718] Linux Plug and Play Support v0.97 (c) Adam Belay
[   27.490728] pnp: PnP ACPI init
[   27.503519] pnp: PnP ACPI: found 10 devices
[   27.503525] PnPBIOS: Disabled by ACPI PNP
[   27.503571] PCI: Using ACPI for IRQ routing
[   27.503574] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   27.503881] pnp: 00:08: ioport range 0x1080-0x1080 has been reserved
[   27.503886] pnp: 00:08: ioport range 0x220-0x22f has been reserved
[   27.503889] pnp: 00:08: ioport range 0x400-0x401 has been reserved
[   27.503892] pnp: 00:08: ioport range 0x40b-0x40b has been reserved
[   27.504120] PCI: Bridge: 0000:00:01.0
[   27.504123]   IO window: 9000-9fff
[   27.504127]   MEM window: c0100000-c01fffff
[   27.504131]   PREFETCH window: d0000000-dfffffff
[   27.504138] PCI: Bus 3, cardbus bridge: 0000:02:06.0
[   27.504140]   IO window: 0000a400-0000a4ff
[   27.504147]   IO window: 0000a800-0000a8ff
[   27.504153]   PREFETCH window: 20000000-21ffffff
[   27.504160]   MEM window: 24000000-25ffffff
[   27.504166] PCI: Bridge: 0000:00:14.4
[   27.504170]   IO window: a000-afff
[   27.504177]   MEM window: c0200000-c02fffff
[   27.504182]   PREFETCH window: 20000000-21ffffff
[   27.504218] PCI: Enabling device 0000:02:06.0 (0004 -> 0007)
[   27.504226] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 23 (level, low) -> IRQ 177
[   27.504255] NET: Registered protocol family 2
[   27.512550] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   27.512649] TCP established hash table entries: 16384 (order: 4, 65536 bytes)
[   27.512722] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[   27.512758] TCP: Hash tables configured (established 16384 bind 8192)
[   27.512761] TCP reno registered
[   27.513360] audit: initializing netlink socket (disabled)
[   27.513369] audit(1148734788.136:1): initialized
[   27.513501] VFS: Disk quotas dquot_6.5.1
[   27.513526] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   27.513573] Initializing Cryptographic API
[   27.513578] io scheduler noop registered
[   27.513586] io scheduler anticipatory registered (default)
[   27.513591] io scheduler deadline registered
[   27.513598] io scheduler cfq registered
[   28.182799] isapnp: Scanning for PnP cards...
[   28.539949] isapnp: No Plug & Play device found
[   28.565938] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[   28.567147] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[   28.567313] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   28.567317] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   28.567612] PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:MSE0] at 0x60,0x64 irq 1,12
[   28.569227] serio: i8042 AUX port at 0x60,0x64 irq 12
[   28.569490] serio: i8042 KBD port at 0x60,0x64 irq 1
[   28.569569] mice: PS/2 mouse device common for all mice
[   28.570062] EISA: Probing bus 0 at eisa.0
[   28.570073] Cannot allocate resource for EISA slot 1
[   28.570107] Cannot allocate resource for EISA slot 8
[   28.570109] EISA: Detected 0 cards.
[   28.570215] TCP bic registered
[   28.570226] NET: Registered protocol family 1
[   28.570235] NET: Registered protocol family 8
[   28.570237] NET: Registered protocol family 20
[   28.570265] Using IPI Shortcut mode
[   28.570323] ACPI: (supports S0 S3 S4 S5)
[   28.571018] Time: tsc clocksource has been installed.
[   28.571366] Freeing unused kernel memory: 312k freed
[   28.607104] input: AT Translated Set 2 keyboard as /class/input/input0
[   28.622668] vga16fb: initializing
[   28.622673] vga16fb: mapped to 0xc00a0000
[   28.622716] fb0: VGA16 VGA frame buffer device
[   29.732481] ACPI Warning (acpi_power-0427): Transitioning device [FAN1] to D3 [20060310]
[   29.732488] ACPI Warning (acpi_bus-0260): Transitioning device [FAN1] to D3 [20060310]
[   29.732494] ACPI: Fan [FAN1] (off)
[   29.735921] ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
[   29.735927] ACPI: Processor [CPU0] (supports 8 throttling states)
[   29.735933] ACPI Error (acpi_processor-0474): Getting cpuindex for acpiid 0x1 [20060310]
[    2.435000] Time: acpi_pm clocksource has been installed.
[    2.583000] ACPI: Thermal Zone [TZCR] (50 C)
[    2.959000] SCSI subsystem initialized
[    2.963000] libata version 1.30 loaded.
[    2.964000] sata_sil 0000:00:12.0: version 1.0
[    2.964000] ACPI (acpi_bus-0192): Device `SATA]is not power manageable [20060310]
[    2.964000] PCI: Enabling device 0000:00:12.0 (0005 -> 0007)
[    2.964000] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 185
[    2.964000] ata1: SATA max UDMA/100 cmd 0xDE85E080 ctl 0xDE85E08A bmdma 0xDE85E000 irq 185
[    2.964000] ata2: SATA max UDMA/100 cmd 0xDE85E0C0 ctl 0xDE85E0CA bmdma 0xDE85E008 irq 185
[    3.316000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    3.317000] ata1.00: cfg 49:2f00 82:746b 83:7d09 84:6023 85:7469 86:3d09 87:6023 88:203f
[    3.317000] ata1.00: ATA-6, max UDMA/100, 156301488 sectors: LBA48 NCQ (depth 0/32)
[    3.319000] ata1.00: configured for UDMA/100
[    3.319000] scsi0 : sata_sil
[    3.520000] ata2: SATA link down (SStatus 0 SControl 300)
[    3.520000] scsi1 : sata_sil
[    3.520000]   Vendor: ATA       Model: TOSHIBA MK8032GS  Rev: AS11
[    3.520000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[    3.528000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[    3.528000] sda: Write Protect is off
[    3.528000] sda: Mode Sense: 00 3a 00 00
[    3.528000] SCSI device sda: drive cache: write back
[    3.528000] SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
[    3.528000] sda: Write Protect is off
[    3.528000] sda: Mode Sense: 00 3a 00 00
[    3.528000] SCSI device sda: drive cache: write back
[    3.528000]  sda: sda1 sda2 sda3
[    3.586000] sd 0:0:0:0: Attached scsi disk sda
[    3.896000] ATIIXP: IDE controller at PCI slot 0000:00:14.1
[    3.896000] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 193
[    3.896000] ATIIXP: chipset revision 128
[    3.896000] ATIIXP: not 100% native mode: will probe irqs later
[    3.896000]     ide0: BM-DMA at 0x8460-0x8467, BIOS settings: hda:pio, hdb:pio
[    3.896000]     ide1: BM-DMA at 0x8468-0x846f, BIOS settings: hdc:DMA, hdd:pio
[    3.896000] Probing IDE interface ide0...
[    4.415000] Probing IDE interface ide1...
[    5.088000] hdc: HL-DT-ST DVDRAM GMA-4082N, ATAPI CD/DVD-ROM drive
[    5.395000] ide1 at 0x170-0x177,0x376 on irq 15
[    5.405000] hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
[    5.405000] Uniform CD-ROM driver Revision: 3.20
[    5.535000] ieee1394: Initialized config rom entry `ip1394'
[    5.536000] ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 22 (level, low) -> IRQ 185
[    5.591000] usbcore: registered new driver usbfs
[    5.591000] usbcore: registered new driver hub
[    5.593000] ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[    5.593000] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 201
[    5.593000] ohci_hcd 0000:00:13.0: OHCI Host Controller
[    5.594000] ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
[    5.594000] ohci_hcd 0000:00:13.0: irq 201, io mem 0xc0005000
[    5.617000] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[185]  MMIO=[c0215800-c0215fff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[    5.646000] usb usb1: new device found, idVendor=0000, idProduct=0000
[    5.646000] usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
[    5.646000] usb usb1: Product: OHCI Host Controller
[    5.646000] usb usb1: Manufacturer: Linux 2.6.17-rc4-mm3 ohci_hcd
[    5.646000] usb usb1: SerialNumber: 0000:00:13.0
[    5.646000] usb usb1: configuration #1 chosen from 1 choice
[    5.646000] hub 1-0:1.0: USB hub found
[    5.646000] hub 1-0:1.0: 4 ports detected
[    5.747000] ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, low) -> IRQ 201
[    5.747000] ohci_hcd 0000:00:13.1: OHCI Host Controller
[    5.747000] ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
[    5.747000] ohci_hcd 0000:00:13.1: irq 201, io mem 0xc0006000
[    5.802000] usb usb2: new device found, idVendor=0000, idProduct=0000
[    5.802000] usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
[    5.802000] usb usb2: Product: OHCI Host Controller
[    5.802000] usb usb2: Manufacturer: Linux 2.6.17-rc4-mm3 ohci_hcd
[    5.802000] usb usb2: SerialNumber: 0000:00:13.1
[    5.802000] usb usb2: configuration #1 chosen from 1 choice
[    5.802000] hub 2-0:1.0: USB hub found
[    5.802000] hub 2-0:1.0: 4 ports detected
[    5.917000] ACPI (acpi_bus-0192): Device `EHCI]is not power manageable [20060310]
[    5.917000] ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, low) -> IRQ 201
[    5.917000] ehci_hcd 0000:00:13.2: EHCI Host Controller
[    5.917000] ehci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
[    5.917000] ehci_hcd 0000:00:13.2: irq 201, io mem 0xc0007000
[    5.917000] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    5.917000] usb usb3: new device found, idVendor=0000, idProduct=0000
[    5.917000] usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
[    5.917000] usb usb3: Product: EHCI Host Controller
[    5.917000] usb usb3: Manufacturer: Linux 2.6.17-rc4-mm3 ehci_hcd
[    5.917000] usb usb3: SerialNumber: 0000:00:13.2
[    5.917000] usb usb3: configuration #1 chosen from 1 choice
[    5.917000] hub 3-0:1.0: USB hub found
[    5.917000] hub 3-0:1.0: 8 ports detected
[    5.964000] usb 1-1: new low speed USB device using ohci_hcd and address 2
[    6.045000] Probing IDE interface ide0...
[    6.496000] usb 1-1: new low speed USB device using ohci_hcd and address 3
[    6.590000] Attempting manual resume
[    6.598000] JFS: nTxBlock = 3769, nTxLock = 30158
[    6.643000] usb 1-1: new device found, idVendor=045e, idProduct=007d
[    6.643000] usb 1-1: new device strings: Mfr=1, Product=3, SerialNumber=0
[    6.643000] usb 1-1: Product: Microsoft 3-Button Mouse with IntelliEye?
[    6.643000] usb 1-1: Manufacturer: Microsoft
[    6.643000] usb 1-1: configuration #1 chosen from 1 choice
[    6.659000] usbcore: registered new driver hiddev
[    6.662000] input: Microsoft Microsoft 3-Button Mouse with IntelliEye? as /class/input/input1
[    6.662000] input: USB HID v1.00 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye?] on usb-0000:00:13.0-1
[    6.662000] usbcore: registered new driver usbhid
[    6.662000] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[    6.873000] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00080da0233934d1]
[   14.754000] ts: Compaq touchscreen protocol output
[   14.997000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   16.448000] Linux agpgart interface v0.101 (c) Dave Jones
[   16.514000] input: PC Speaker as /class/input/input2
[   16.570000] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   16.574000] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   16.734000] Real Time Clock Driver v1.12ac
[   17.124000] piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
[   17.168000] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 23 (level, low) -> IRQ 177
[   17.168000] Yenta: CardBus bridge found at 0000:02:06.0 [1179:ff10]
[   17.168000] Yenta: Enabling burst memory read transactions
[   17.168000] Yenta: Using CSCINT to route CSC interrupts to PCI
[   17.168000] Yenta: Routing CardBus interrupts to PCI
[   17.168000] Yenta TI: socket 0000:02:06.0, mfunc 0x01111122, devctl 0x44
[   17.235000] 8139too Fast Ethernet driver 0.9.27
[   17.391000] Yenta: ISA IRQ mask 0x0ef8, PCI irq 177
[   17.391000] Socket status: 30000006
[   17.391000] pcmcia: parent PCI bridge I/O window: 0xa000 - 0xafff
[   17.391000] cs: IO port probe 0xa000-0xafff: clean.
[   17.392000] pcmcia: parent PCI bridge Memory window: 0xc0200000 - 0xc02fffff
[   17.392000] pcmcia: parent PCI bridge Memory window: 0x20000000 - 0x21ffffff
[   17.543000] Synaptics Touchpad, model: 1, fw: 6.2, id: 0x25a0b1, caps: 0xa04713/0x0
[   17.543000] synaptics: Toshiba Satellite A100 detected, limiting rate to 40pps.
[   17.578000] input: SynPS/2 Synaptics TouchPad as /class/input/input3
[   17.669000] ACPI (acpi_bus-0192): Device `LANC]is not power manageable [20060310]
[   17.669000] ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 20 (level, low) -> IRQ 209
[   17.669000] eth0: RealTek RTL8139 at 0xdec94000, 00:a0:d1:34:39:23, IRQ 209
[   17.669000] eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
[   17.676000] ACPI (acpi_bus-0192): Device `MODM]is not power manageable [20060310]
[   17.676000] ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 193
[   17.683000] 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
[   17.847000] ACPI Error (evxfevnt-0386): Could not disable RealTimeClock events [20060310]
[   17.857000] hda_codec: Unknown model for ALC861, trying auto-probe from BIOS...
[   18.376000] cs: IO port probe 0x100-0x3af: excluding 0x1f0-0x1f7
[   18.378000] cs: IO port probe 0x3e0-0x4ff: excluding 0x3f0-0x3f7 0x4d0-0x4d7
[   18.379000] cs: IO port probe 0x820-0x8ff: excluding 0x878-0x87f
[   18.380000] cs: IO port probe 0xc00-0xcf7: excluding 0xc00-0xc07 0xc10-0xc17 0xc50-0xc57 0xc68-0xc6f 0xcd0-0xcdf
[   18.381000] cs: IO port probe 0xa00-0xaff: clean.
[   19.078000] lp: driver loaded but no devices found
[   19.198000] ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
[   19.198000] ieee1394: sbp2: Try serialize_io=0 for better performance
[   19.398000] Adding 971924k swap on /dev/sda2.  Priority:-1 extents:1 across:971924k
[   22.171000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[   22.171000] md: bitmap version 4.39
[   25.471000] device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
[   29.075000] device-mapper: dm-linear: Device lookup failed
[   29.075000] device-mapper: error adding target to table
[   29.075000] device-mapper: dm-linear: Device lookup failed
[   29.075000] device-mapper: error adding target to table
[   29.076000] device-mapper: dm-linear: Device lookup failed
[   29.076000] device-mapper: error adding target to table
[   29.076000] device-mapper: dm-linear: Device lookup failed
[   29.076000] device-mapper: error adding target to table
[   29.076000] device-mapper: dm-linear: Device lookup failed
[   29.076000] device-mapper: error adding target to table
[   29.077000] device-mapper: dm-linear: Device lookup failed
[   29.077000] device-mapper: error adding target to table
[   29.077000] device-mapper: dm-linear: Device lookup failed
[   29.077000] device-mapper: error adding target to table
[   29.077000] device-mapper: dm-linear: Device lookup failed
[   29.077000] device-mapper: error adding target to table
[   29.078000] device-mapper: dm-linear: Device lookup failed
[   29.078000] device-mapper: error adding target to table
[   29.078000] device-mapper: dm-linear: Device lookup failed
[   29.078000] device-mapper: error adding target to table
[   29.079000] device-mapper: dm-linear: Device lookup failed
[   29.079000] device-mapper: error adding target to table
[   29.079000] device-mapper: dm-linear: Device lookup failed
[   29.079000] device-mapper: error adding target to table
[   29.441000] NTFS driver 2.1.27 [Flags: R/O MODULE].
[   29.593000] NTFS volume version 3.1.
[   31.616000] ACPI: AC Adapter [ADP0] (on-line)
[   31.745000] ACPI: Battery Slot [BAT0] (battery present)
[   31.765000] ACPI Exception (utmutex-0257): AE_TIME, Thread 0 could not acquire Mutex [8] [20060310]
[   31.765000] ACPI Exception (utmutex-0257): AE_TIME, Thread 0 could not acquire Mutex [8] [20060310]
[   31.766000] ACPI: Power Button (FF) [PWRF]
[   31.766000] ACPI: Power Button (CM) [PWRB]
[   31.766000] ACPI: Lid Switch [LID]
[   31.820000] Using specific hotkey driver
[   31.844000] ibm_acpi: ec object not found
[   31.845000] ACPI Error (evxfevnt-0386): Could not disable RealTimeClock events [20060310]
[   31.902000] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[   37.044000] [drm] Initialized drm 1.0.1 20051102
[   37.180000] ppdev: user-space parallel port driver
[   37.612000] apm: BIOS not found.
[   41.123000] Bluetooth: Core ver 2.8
[   41.123000] NET: Registered protocol family 31
[   41.123000] Bluetooth: HCI device and connection manager initialized
[   41.123000] Bluetooth: HCI socket layer initialized
[   41.187000] Bluetooth: L2CAP ver 2.8
[   41.187000] Bluetooth: L2CAP socket layer initialized
[   41.203000] Bluetooth: RFCOMM socket layer initialized
[   41.203000] Bluetooth: RFCOMM TTY layer initialized
[   41.203000] Bluetooth: RFCOMM ver 1.7
[   45.459000] hda-intel: Invalid position buffer, using LPIB read method instead.
[  321.333000] ACPI Error (evevent-0314): No installed handler for fixed event [00000000] [20060310]
[ 3001.392000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 3001.392000] ata1.00: (BMDMA stat 0x21)
[ 3001.392000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
[ 3001.392000] ata1: soft resetting port
[ 3001.543000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3001.546000] ata1.00: configured for UDMA/100
[ 3001.546000] ata1: EH complete
[ 3034.178000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 3034.178000] ata1.00: (BMDMA stat 0x21)
[ 3034.178000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
[ 3034.178000] ata1: soft resetting port
[ 3034.329000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 3034.333000] ata1.00: configured for UDMA/100
[ 3034.333000] ata1: EH complete
[ 4288.145000] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[ 4288.145000] ata1.00: (BMDMA stat 0x21)
[ 4288.145000] ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
[ 4288.145000] ata1: soft resetting port
[ 4288.296000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[ 4288.299000] ata1.00: configured for UDMA/100
[ 4288.300000] ata1: EH complete

--------------070900040805010800000408--
