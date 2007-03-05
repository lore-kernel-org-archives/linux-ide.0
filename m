From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: nonzero mismatch_cnt with no earlier error
Date: Tue, 06 Mar 2007 09:01:32 +1100
Message-ID: <45EC933C.8010004@eyal.emu.id.au>
References: <45DF859B.2050108@eyal.emu.id.au>	<Pine.LNX.4.64.0702231929380.31611@p34.internal.lan>	<45DF8DE3.2050903@eyal.emu.id.au> <17890.25524.465403.130119@notabene.brown> <45E297E5.50303@eyal.emu.id.au> <45EB95EF.9030702@suse.de> <45EBCC43.9010709@eyal.emu.id.au> <45EC3EB3.10407@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070001020601020700030202"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from customer-domains.icp-qv1-irony15.iinet.net.au ([203.59.1.175]:26130
	"EHLO customer-domains.icp-qv1-irony15.iinet.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948AbXCEWBl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Mar 2007 17:01:41 -0500
In-Reply-To: <45EC3EB3.10407@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <teheo@suse.de>
Cc: list linux-ide <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070001020601020700030202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Eyal Lebedinsky wrote:
> 
>>It is in the original thread on linux-raid, but here it is for this list.
>>This is the full dmesg. There were only MARKs in between.
>>
>>I run a raid 'check' every Friday (cron). The last one reported some parity errors.
>>
>>*** last week check start:
>>[927080.617744] md: data-check of RAID array md0
>>[927080.630783] md: minimum _guaranteed_  speed: 24000 KB/sec/disk.
>>[927080.648734] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
>>[927080.678103] md: using 128k window, over a total of 312568576 blocks.
>>	*** last week error:
>>[937567.332751] ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x4190002 action 0x2
>>[937567.354094] ata3.00: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 512 in
>>[937567.354096]          res 51/04:83:45:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)
> 
> 
> I need full kernel log including the boot messages so that I can tell
> which controller/driver is involved here and also the result of 'hdparm
> -I /dev/sdX' of your drives would be nice.
> 
> BTW, this is SMART read log for page 09 which is SMART self-test log.
> The device aborted it.  Dunno who issued it or why it got aborted.  As I
> wrote in the previous mail, EH discovered that SError has accumulated
> link level errors and thus treated it as ATA bus error.  All
> transmissions over SATA are checksummed and link errors supposedly don't
> cause data corruption, so, in theory, the above error message should be
> irrelevant to your problem.
> 
> Ah.. please also post the result of 'smartctl -d ata -a /dev/sdX' for
> your drives.  That might reveal something.

sd[ab] are on the motherboard, sd[cdef] are on a Promise SATA-II-150-TX4.

In smartd.conf all the disks run a full selftest once a week which may have
coincided with the time of the reported error.

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat

--------------070001020601020700030202
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

[    0.000000] Linux version 2.6.20 (eyal@e7) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #1 Mon Feb 5 22:08:32 EST 2007
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 000000000009fc00 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 00000000000a0000 type: 2
[    0.000000] copy_e820_map() start: 00000000000f0000 size: 0000000000010000 end: 0000000000100000 type: 2
[    0.000000] copy_e820_map() start: 0000000000100000 size: 000000003fef0000 end: 000000003fff0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] copy_e820_map() start: 000000003fff0000 size: 0000000000003000 end: 000000003fff3000 type: 4
[    0.000000] copy_e820_map() start: 000000003fff3000 size: 000000000000d000 end: 0000000040000000 type: 3
[    0.000000] copy_e820_map() start: 00000000fec00000 size: 0000000001400000 end: 0000000100000000 type: 2
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
[    0.000000]  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] 127MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f5200
[    0.000000] Entering add_active_range(0, 0, 262128) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   262128
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   262128
[    0.000000] On node 0 totalpages: 262128
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 255 pages used for memmap
[    0.000000]   HighMem zone: 32497 pages, LIFO batch:7
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 GBT                                   ) @ 0x000f6ca0
[    0.000000] ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3000
[    0.000000] ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3040
[    0.000000] ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff7080
[    0.000000] ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:2 APIC version 20
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
[    0.000000] Detected 3014.582 MHz processor.
[   34.023123] Built 1 zonelists.  Total pages: 260081
[   34.023125] Kernel command line: BOOT_IMAGE=2.6.20 ro root=303 console=ttyS0,38400 console=tty0 single
[   34.023286] mapped APIC to ffffd000 (fee00000)
[   34.023288] mapped IOAPIC to ffffc000 (fec00000)
[   34.023290] Enabling fast FPU save and restore... done.
[   34.023293] Enabling unmasked SIMD FPU exception support... done.
[   34.023300] Initializing CPU#0
[   34.023354] CPU 0 irqstacks, hard=c03b9000 soft=c03b8000
[   34.023356] PID hash table entries: 4096 (order: 12, 16384 bytes)
[   34.025791] Console: colour VGA+ 80x50
[   34.937135] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   34.958712] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   34.996037] Memory: 1035532k/1048512k available (1609k kernel code, 12344k reserved, 879k data, 268k init, 131008k highmem)
[   35.029409] virtual kernel memory layout:
[   35.029410]     fixmap  : 0xfffaa000 - 0xfffff000   ( 340 kB)
[   35.029411]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   35.029412]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   35.029413]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   35.029414]       .init : 0xc0370000 - 0xc03b3000   ( 268 kB)
[   35.029415]       .data : 0xc0292708 - 0xc036e490   ( 879 kB)
[   35.029416]       .text : 0xc0100000 - 0xc0292708   (1609 kB)
[   35.162043] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[   35.245674] Calibrating delay using timer specific routine.. 6030.90 BogoMIPS (lpj=3015453)
[   35.270840] Security Framework v1.0.0 initialized
[   35.284972] Mount-cache hash table entries: 512
[   35.298669] CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 00004400 00000000 00000000
[   35.298678] CPU: Trace cache: 12K uops, L1 D cache: 8K
[   35.314171] CPU: L2 cache: 512K
[   35.323615] CPU: After all inits, caps: bfebfbff 00000000 00000000 00003080 00004400 00000000 00000000
[   35.323620] Intel machine check architecture supported.
[   35.339314] Intel machine check reporting enabled on CPU#0.
[   35.356045] CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
[   35.374076] CPU0: Thermal monitoring enabled
[   35.386921] Compat vDSO mapped to ffffe000.
[   35.399506] CPU: Intel(R) Pentium(R) 4 CPU 3.00GHz stepping 09
[   35.417142] Checking 'hlt' instruction... OK.
[   35.433730] ACPI: Core revision 20060707
[   35.678402] ENABLING IO-APIC IRQs
[   35.688536] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   35.817614] NET: Registered protocol family 16
[   35.831038] EISA bus registered
[   35.840499] ACPI: bus type pci registered
[   35.876470] PCI: PCI BIOS revision 2.10 entry at 0xfb500, last bus=3
[   35.895519] PCI: Using configuration type 1
[   35.908102] Setting up standard PCI resources
[   35.937233] ACPI: Interpreter enabled
[   35.948261] ACPI: Using IOAPIC for interrupt routing
[   35.963695] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   35.978100] PCI: Probing PCI hardware (bus 00)
[   35.978624] PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
[   35.997958] PCI quirk: region 1080-10bf claimed by ICH4 GPIO
[   36.015143] Boot video device is 0000:01:00.0
[   36.015722] PCI: Transparent bridge - 0000:00:1e.0
[   36.030134] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   36.037010] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
[   36.040728] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[   36.063634] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[   36.086517] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
[   36.109389] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   36.132268] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
[   36.158679] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   36.181556] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
[   36.204439] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
[   36.228698] Linux Plug and Play Support v0.97 (c) Adam Belay
[   36.245676] pnp: PnP ACPI init
[   36.258805] pnp: PnP ACPI: found 16 devices
[   36.271380] PnPBIOS: Disabled by ACPI PNP
[   36.283478] PCI: Using ACPI for IRQ routing
[   36.296048] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   36.349537] PCI: Bridge: 0000:00:01.0
[   36.360543]   IO window: disabled.
[   36.370791]   MEM window: d8000000-d9ffffff
[   36.383372]   PREFETCH window: c0000000-cfffffff
[   36.397253] PCI: Bridge: 0000:00:03.0
[   36.408276]   IO window: a000-afff
[   36.418500]   MEM window: da000000-dbffffff
[   36.431081]   PREFETCH window: 50000000-500fffff
[   36.444962] PCI: Bridge: 0000:00:1e.0
[   36.455986]   IO window: 8000-9fff
[   36.466209]   MEM window: dc000000-ddffffff
[   36.478791]   PREFETCH window: de000000-de0fffff
[   36.492682] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[   36.492703] NET: Registered protocol family 2
[   36.514926] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   36.536458] TCP established hash table entries: 131072 (order: 7, 524288 bytes)
[   36.558646] TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
[   36.578662] TCP: Hash tables configured (established 131072 bind 65536)
[   36.598487] TCP reno registered
[   36.610925] Machine check exception polling timer started.
[   36.627525] highmem bounce pool size: 64 pages
[   36.640879] Total HugeTLB memory allocated, 0
[   36.654019] VFS: Disk quotas dquot_6.5.1
[   36.665826] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   36.685644] io scheduler noop registered
[   36.697510] io scheduler anticipatory registered (default)
[   36.714110] io scheduler deadline registered
[   36.727011] io scheduler cfq registered
[   36.738970] isapnp: Scanning for PnP cards...
[   37.107853] isapnp: No Plug & Play device found
[   37.139266] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   37.162877] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   37.181059] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   37.199621] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   37.216568] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[   37.233598] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   37.252667] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   37.276702] ICH5: IDE controller at PCI slot 0000:00:1f.1
[   37.292904] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 16
[   37.315212] ICH5: chipset revision 2
[   37.325971] ICH5: not 100% native mode: will probe irqs later
[   37.343230]     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
[   37.365071]     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
[   37.386911] Probing IDE interface ide0...
[   37.649527] hda: WDC WD2500JB-00REA0, ATA DISK drive
[   38.275129] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   38.288839] Probing IDE interface ide1...
[   38.958653] hdc: ATAPI DVD RW 8XMax, ATAPI CD/DVD-ROM drive
[   39.280987] ide1 at 0x170-0x177,0x376 on irq 15
[   39.294770] hda: max request size: 512KiB
[   39.322149] hda: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, UDMA(100)
[   39.347572] hda: cache flushes supported
[   39.359377]  hda: hda1 hda2 hda3 hda4
[   39.389031] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   39.414497] serio: i8042 KBD port at 0x60,0x64 irq 1
[   39.429402] serio: i8042 AUX port at 0x60,0x64 irq 12
[   39.444658] mice: PS/2 mouse device common for all mice
[   39.460436] EISA: Probing bus 0 at eisa.0
[   39.472500] Cannot allocate resource for EISA slot 1
[   39.487433] Cannot allocate resource for EISA slot 8
[   39.502354] EISA: Detected 0 cards.
[   39.542862] TCP cubic registered
[   39.552606] Using IPI Shortcut mode
[   39.563191] Time: tsc clocksource has been installed.
[   39.587707] input: AT Translated Set 2 keyboard as /class/input/input0
[   39.711228] EXT2-fs warning (device hda3): ext2_fill_super: mounting ext3 filesystem as ext2
[   39.736713] VFS: Mounted root (ext2 filesystem) readonly.
[   39.753089] Freeing unused kernel memory: 268k freed
[   40.329868] NET: Registered protocol family 1
[   41.347430] Adding 2104504k swap on /dev/hda2.  Priority:1 extents:1 across:2104504k
[   45.753592] device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
[   46.284862] kjournald starting.  Commit interval 5 seconds
[   46.301511] EXT3 FS on hda4, internal journal
[   46.314655] EXT3-fs: mounted filesystem with ordered data mode.
[   47.530305] Linux agpgart interface v0.101 (c) Dave Jones
[   47.575186] agpgart: Detected an Intel 865 Chipset.
[   47.605367] agpgart: AGP aperture is 128M @ 0xd0000000
[   48.224088] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   48.273692] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   49.434533] usbcore: registered new interface driver usbfs
[   49.459572] usbcore: registered new interface driver hub
[   49.484100] usbcore: registered new device driver usb
[   49.522676] USB Universal Host Controller Interface driver v3.0
[   49.549120] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 17
[   49.571423] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   49.571427] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   49.596116] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
[   49.618354] uhci_hcd 0000:00:1d.0: irq 17, io base 0x0000bc00
[   49.642587] usb usb1: configuration #1 chosen from 1 choice
[   49.659859] hub 1-0:1.0: USB hub found
[   49.671154] hub 1-0:1.0: 2 ports detected
[   50.171917] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 18
[   50.194228] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   50.194231] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   50.212840] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
[   50.235081] uhci_hcd 0000:00:1d.1: irq 18, io base 0x0000b000
[   50.254029] usb usb2: configuration #1 chosen from 1 choice
[   50.271128] hub 2-0:1.0: USB hub found
[   50.283895] hub 2-0:1.0: 2 ports detected
[   50.462323] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 16
[   50.484634] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   50.484637] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   50.534170] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
[   50.556413] uhci_hcd 0000:00:1d.2: irq 16, io base 0x0000b400
[   50.792160] usb usb3: configuration #1 chosen from 1 choice
[   50.809942] hub 3-0:1.0: USB hub found
[   50.821251] hub 3-0:1.0: 2 ports detected
[   51.735367] ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 17
[   51.757664] PCI: Setting latency timer of device 0000:00:1d.3 to 64
[   51.757668] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[   51.781907] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
[   51.804145] uhci_hcd 0000:00:1d.3: irq 17, io base 0x0000b800
[   51.832859] usb usb4: configuration #1 chosen from 1 choice
[   51.850102] hub 4-0:1.0: USB hub found
[   51.861391] hub 4-0:1.0: 2 ports detected
[   52.886898] ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 18 (level, low) -> IRQ 16
[   52.909203] uhci_hcd 0000:03:04.0: UHCI Host Controller
[   52.933575] uhci_hcd 0000:03:04.0: new USB bus registered, assigned bus number 5
[   52.955817] uhci_hcd 0000:03:04.0: irq 16, io base 0x00008c00
[   52.984545] usb usb5: configuration #1 chosen from 1 choice
[   53.001788] hub 5-0:1.0: USB hub found
[   53.013090] hub 5-0:1.0: 2 ports detected
[   53.734460] ACPI: PCI Interrupt 0000:03:04.1[B] -> GSI 21 (level, low) -> IRQ 19
[   53.756750] uhci_hcd 0000:03:04.1: UHCI Host Controller
[   53.776027] uhci_hcd 0000:03:04.1: new USB bus registered, assigned bus number 6
[   53.798276] uhci_hcd 0000:03:04.1: irq 19, io base 0x00009000
[   53.818005] usb usb6: configuration #1 chosen from 1 choice
[   53.835960] hub 6-0:1.0: USB hub found
[   53.847240] hub 6-0:1.0: 2 ports detected
[   54.050380] usb 5-1: new full speed USB device using uhci_hcd and address 2
[   54.224345] usb 5-1: configuration #1 chosen from 1 choice
[   60.832283] dib0700: loaded with support for 2 different device-types
[   60.868572] dvb-usb: found a 'Hauppauge Nova-T 500 Dual DVB-T' in cold state, will try to load a firmware
[   60.954450] dvb-usb: downloading firmware from file 'dvb-usb-dib0700-01.fw'
[   62.411983] dib0700: firmware started successfully.
[   62.664544] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 20
[   62.686862] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   62.686866] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   62.702928] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
[   62.725171] PCI: cache line size of 128 is not supported by device 0000:00:1d.7
[   62.725180] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xde100000
[   62.746049] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   62.769313] usb usb7: configuration #1 chosen from 1 choice
[   62.786438] hub 7-0:1.0: USB hub found
[   62.797742] hub 7-0:1.0: 8 ports detected
[   62.910706] ACPI: PCI Interrupt 0000:03:04.2[C] -> GSI 22 (level, low) -> IRQ 21
[   62.933002] ehci_hcd 0000:03:04.2: EHCI Host Controller
[   62.949106] ehci_hcd 0000:03:04.2: new USB bus registered, assigned bus number 8
[   62.971350] ehci_hcd 0000:03:04.2: irq 21, io mem 0xdd025000
[   62.988333] ehci_hcd 0000:03:04.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[   63.011576] usb usb8: configuration #1 chosen from 1 choice
[   63.028690] hub 8-0:1.0: USB hub found
[   63.039988] hub 8-0:1.0: 4 ports detected
[   63.186321] dvb-usb: found a 'Hauppauge Nova-T 500 Dual DVB-T' in warm state.
[   63.207732] **WARNING** I2C adapter driver [Hauppauge Nova-T 500 Dual DVB-T] forgot to specify physical device; fix it!
[   63.240174] dvb-usb: This USB2.0 device cannot be run on a USB1.1 port. (it lacks a hardware PID filter)
[   63.269349] dvb-usb: Hauppauge Nova-T 500 Dual DVB-T error while loading driver (-19)
[   63.458715] usb 8-1: new high speed USB device using ehci_hcd and address 2
[   63.595168] usb 8-1: configuration #1 chosen from 1 choice
[   63.614016] usb 5-1: USB disconnect, address 2
[   63.627508] dvb-usb: found a 'Hauppauge Nova-T 500 Dual DVB-T' in warm state.
[   63.648918] **WARNING** I2C adapter driver [Hauppauge Nova-T 500 Dual DVB-T] forgot to specify physical device; fix it!
[   63.681950] dvb-usb: will pass the complete MPEG2 transport stream to the software demuxer.
[   63.707223] DVB: registering new adapter (Hauppauge Nova-T 500 Dual DVB-T).
[   63.793318] **WARNING** I2C adapter driver [DiBX000 tuner I2C bus] forgot to specify physical device; fix it!
[   63.824633] DVB: registering frontend 0 (DiBcom 3000MC/P)...
[   63.861561] MT2060: successfully identified (IF1 = 1220)
[   64.302857] dvb-usb: will pass the complete MPEG2 transport stream to the software demuxer.
[   64.328158] DVB: registering new adapter (Hauppauge Nova-T 500 Dual DVB-T).
[   64.351637] **WARNING** I2C adapter driver [DiBX000 tuner I2C bus] forgot to specify physical device; fix it!
[   64.382579] DVB: registering frontend 1 (DiBcom 3000MC/P)...
[   64.401666] MT2060: successfully identified (IF1 = 1220)
[   64.733196] intel_rng: FWH not detected
[   64.807042] iTCO_vendor_support: vendor-support=0
[   64.824848] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (11-Nov-2006)
[   64.846039] iTCO_wdt: Found a ICH5 or ICH5R TCO device (Version=1, TCOBASE=0x1060)
[   64.869166] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=1)
[   64.931292] dvb-usb: Hauppauge Nova-T 500 Dual DVB-T successfully initialized and connected.
[   64.956680] usbcore: registered new interface driver dvb_usb_dib0700
[   65.668661] SCSI subsystem initialized
[   65.695351] libata version 2.00 loaded.
[   65.752396] ata_piix 0000:00:1f.2: version 2.00ac7
[   65.752402] ata_piix 0000:00:1f.2: MAP [ P0 -- P1 -- ]
[   65.768301] ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 16
[   65.790610] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   65.790658] ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
[   65.812095] ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
[   65.833522] scsi0 : ata_piix
[   65.996356] ata1.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48 
[   66.015162] ata1.00: ata1: dev 0 multi count 16
[   66.031277] ata1.00: configured for UDMA/100
[   66.044115] scsi1 : ata_piix
[   66.222858] ata2.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48 
[   66.241666] ata2.00: ata2: dev 0 multi count 16
[   66.257780] ata2.00: configured for UDMA/100
[   66.270694] scsi 0:0:0:0: Direct-Access     ATA      WDC WD3200SD-01K 08.0 PQ: 0 ANSI: 5
[   66.295863] scsi 1:0:0:0: Direct-Access     ATA      WDC WD3200JD-00K 08.0 PQ: 0 ANSI: 5
[   67.457380] ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 22
[   68.057582] Intel 810 + AC97 Audio, version 1.01, 23:31:07 Feb  5 2007
[   68.077602] ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 22
[   68.099940] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   68.099945] i810: Intel ICH5 found at IO 0xdc00 and 0xd800, MEM 0xde101000 and 0xde102000, IRQ 22
[   68.126593] i810: Intel ICH5 mmio at 0xf89d2000 and 0xf89fe000
[   68.642354] i810_audio: Primary codec has ID 2
[   68.655743] i810_audio: Audio Controller supports 6 channels.
[   68.672984] i810_audio: Defaulting to base 2 channel mode.
[   68.689457] i810_audio: Resetting connection 0
[   68.702854] i810_audio: Connection 0 with codec id 2
[   68.718051] ac97_codec: AC97 Audio codec, id: ALG128 (Unknown)
[   68.736201] i810_audio: AC'97 codec 2 Unable to map surround DAC's (or DAC's not present), total channels = 2
[   69.487042] Intel(R) PRO/1000 Network Driver - version 7.3.15-k2
[   69.505098] Copyright (c) 1999-2006 Intel Corporation.
[   69.520930] ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 18 (level, low) -> IRQ 16
[   69.543269] PCI: Setting latency timer of device 0000:02:01.0 to 64
[   69.874439] e1000: 0000:02:01.0: e1000_probe: (PCI:33MHz:32-bit) 00:0d:61:69:86:83
[   70.119427] e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
[   70.705027] 8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
[   70.724017] 8139cp 0000:03:00.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
[   70.749357] 8139cp 0000:03:00.0: Try the "8139too" driver instead.
[   70.812131] 8139too Fast Ethernet driver 0.9.28
[   70.826204] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level, low) -> IRQ 16
[   70.849433] eth1: RealTek RTL8139 at 0x8000, 00:40:f4:7c:01:da, IRQ 16
[   70.869032] eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
[   74.091716] sata_promise 0000:03:01.0: version 1.05
[   74.091736] ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 21 (level, low) -> IRQ 19
[   74.114126] ata3: SATA max UDMA/133 cmd 0xF8CB2200 ctl 0xF8CB2238 bmdma 0x0 irq 19
[   74.136918] ata4: SATA max UDMA/133 cmd 0xF8CB2280 ctl 0xF8CB22B8 bmdma 0x0 irq 19
[   74.159695] ata5: SATA max UDMA/133 cmd 0xF8CB2300 ctl 0xF8CB2338 bmdma 0x0 irq 19
[   74.182469] ata6: SATA max UDMA/133 cmd 0xF8CB2380 ctl 0xF8CB23B8 bmdma 0x0 irq 19
[   74.205210] scsi2 : sata_promise
[   74.499107] SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
[   74.519243] sda: Write Protect is off
[   74.530264] sda: Mode Sense: 00 3a 00 00
[   74.530309] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   74.557268] SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
[   74.577380] sda: Write Protect is off
[   74.588400] sda: Mode Sense: 00 3a 00 00
[   74.588425] SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   74.615330]  sda:<6>ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   74.801151] ata3.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48 
[   74.819964] ata3.00: ata3: dev 0 multi count 0
[   74.836071] ata3.00: configured for UDMA/100
[   74.848944] scsi3 : sata_promise
[   75.312714] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   75.333978] ata4.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48 
[   75.352800] ata4.00: ata4: dev 0 multi count 0
[   75.368900] ata4.00: configured for UDMA/100
[   75.381762] scsi4 : sata_promise
[   75.673652]  sda1
[   75.685917] sd 0:0:0:0: Attached scsi disk sda
[   75.700714] SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
[   75.720845] sdb: Write Protect is off
[   75.731873] sdb: Mode Sense: 00 3a 00 00
[   75.731917] SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   75.758853] SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
[   75.778963] sdb: Write Protect is off
[   75.789984] sdb: Mode Sense: 00 3a 00 00
[   75.790009] SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   75.816915]  sdb:<6>ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   75.996538] ata5.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48 
[   76.015350] ata5.00: ata5: dev 0 multi count 0
[   76.031445] ata5.00: configured for UDMA/100
[   76.044330] scsi5 : sata_promise
[   76.339534]  sdb1
[   76.348296] sd 1:0:0:0: Attached scsi disk sdb
[   76.525053] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   76.546319] ata6.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 0/1)
[   76.569069] ata6.00: ata6: dev 0 multi count 0
[   76.585229] ata6.00: configured for UDMA/133
[   76.598869] scsi 2:0:0:0: Direct-Access     ATA      WDC WD3200JD-00K 08.0 PQ: 0 ANSI: 5
[   76.624810] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[   76.645279] sdc: Write Protect is off
[   76.656316] sdc: Mode Sense: 00 3a 00 00
[   76.657249] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   76.685185] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[   76.705621] sdc: Write Protect is off
[   76.716655] sdc: Mode Sense: 00 3a 00 00
[   76.717594] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   76.744494]  sdc: sdc1
[   76.759221] sd 2:0:0:0: Attached scsi disk sdc
[   76.773499] scsi 3:0:0:0: Direct-Access     ATA      WDC WD3200JD-00K 08.0 PQ: 0 ANSI: 5
[   76.799458] SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
[   76.819883] sdd: Write Protect is off
[   76.830916] sdd: Mode Sense: 00 3a 00 00
[   76.831860] SCSI device sdd: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   76.859802] SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
[   76.880239] sdd: Write Protect is off
[   76.891285] sdd: Mode Sense: 00 3a 00 00
[   76.892211] SCSI device sdd: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   76.919120]  sdd: sdd1
[   76.930419] sd 3:0:0:0: Attached scsi disk sdd
[   76.945129] scsi 4:0:0:0: Direct-Access     ATA      WDC WD3200SD-01K 08.0 PQ: 0 ANSI: 5
[   76.971059] SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
[   76.991500] sde: Write Protect is off
[   77.002530] sde: Mode Sense: 00 3a 00 00
[   77.003475] SCSI device sde: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.031417] SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
[   77.051861] sde: Write Protect is off
[   77.062902] sde: Mode Sense: 00 3a 00 00
[   77.063835] SCSI device sde: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.090723]  sde: sde1
[   77.107807] sd 4:0:0:0: Attached scsi disk sde
[   77.122727] scsi 5:0:0:0: Direct-Access     ATA      WDC WD3200YS-01P 21.0 PQ: 0 ANSI: 5
[   77.149653] SCSI device sdf: 625142448 512-byte hdwr sectors (320073 MB)
[   77.170101] sdf: Write Protect is off
[   77.181135] sdf: Mode Sense: 00 3a 00 00
[   77.182074] SCSI device sdf: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.209514] SCSI device sdf: 625142448 512-byte hdwr sectors (320073 MB)
[   77.229966] sdf: Write Protect is off
[   77.240983] sdf: Mode Sense: 00 3a 00 00
[   77.241939] SCSI device sdf: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   77.268846]  sdf: sdf1
[   77.281040] sd 5:0:0:0: Attached scsi disk sdf
[   80.297720] Linux video capture interface: v2.00
[   80.552483] bttv: driver version 0.9.16 loaded
[   80.565851] bttv: using 8 buffers with 2080k (520 pages) each for capture
[   80.594975] bttv: Bt8xx card found (0).
[   80.606548] ACPI: PCI Interrupt 0000:03:02.0[A] -> GSI 22 (level, low) -> IRQ 21
[   80.628890] bttv0: Bt878 (rev 17) at 0000:03:02.0, irq: 21, latency: 32, mmio: 0xde000000
[   80.653631] bttv0: detected: AVermedia AverTV DVB-T 771 [card=123], PCI subsystem ID is 1461:0771
[   80.680278] bttv0: using: AVerMedia AVerTV DVB-T 771 [card=123,autodetected]
[   80.701453] bttv0: gpio: en=00000000, out=00000000 in=00f0ff0f [init]
[   80.710307] bttv0: using tuner=4
[   80.738000] bttv0: registered device video0
[   80.761531] bttv0: registered device vbi0
[   80.773620] bttv0: PLL: 28636363 => 35468950 .. ok
[   80.817822] bttv0: add subdevice "dvb0"
[   80.830446] input: bttv IR (card=123) as /class/input/input1
[   80.847471] bttv: Bt8xx card found (1).
[   80.859051] ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 16 (level, low) -> IRQ 17
[   80.881365] bttv1: Bt878 (rev 17) at 0000:03:03.0, irq: 17, latency: 32, mmio: 0xde002000
[   80.906086] bttv1: detected: AverMedia AverTV DVB-T 761 [card=124], PCI subsystem ID is 1461:0761
[   80.932724] bttv1: using: AverMedia AverTV DVB-T 761 [card=124,autodetected]
[   80.953898] bttv1: gpio: en=00000000, out=00000000 in=0098001d [init]
[   80.981234] bttv1: using tuner=-1
[   80.991709] bttv1: registered device video1
[   81.004726] bttv1: registered device vbi1
[   81.016845] bttv1: PLL: 28636363 => 35468950 .. ok
[   81.062114] bttv1: add subdevice "dvb1"
[   81.074211] input: bttv IR (card=124) as /class/input/input2
[   81.668041] bt878: AUDIO driver version 0.0.0 loaded
[   81.686728] bt878: Bt878 AUDIO function found (0).
[   81.701164] ACPI: PCI Interrupt 0000:03:02.1[A] -> GSI 22 (level, low) -> IRQ 21
[   81.725015] bt878_probe: card id=[0x7711461],[ AVermedia AverTV DVB-T 771 ] has DVB functions.
[   81.750882] bt878(0): Bt878 (rev 17) at 03:02.1, irq: 21, latency: 32, memory: 0xde001000
[   81.775688] bt878: Bt878 AUDIO function found (1).
[   81.790116] ACPI: PCI Interrupt 0000:03:03.1[A] -> GSI 16 (level, low) -> IRQ 17
[   81.812414] bt878_probe: card id=[0x7611461],[ AverMedia AverTV DVB-T 761 ] has DVB functions.
[   81.838280] bt878(1): Bt878 (rev 17) at 03:03.1, irq: 17, latency: 32, memory: 0xde003000
[   81.900780] btaudio: driver version 0.7 loaded [digital+analog]
[   85.217444] ieee1394: Initialized config rom entry `ip1394'
[   85.263009] ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 21 (level, low) -> IRQ 19
[   85.337040] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[dd026000-dd0267ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   85.463229] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
[   85.965499] parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
[   86.499177] gameport: NS558 PnP Gameport is pnp00:0f/gameport0, io 0x201, speed 701kHz
[   86.606247] hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
[   86.628635] Uniform CD-ROM driver Revision: 3.20
[   86.690574] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000d61000069d6eb]
[   86.816147] eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
[   87.015794] e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
[   89.674197] md: md0 stopped.
[   89.819759] md: bind<sdb1>
[   89.828088] md: bind<sdc1>
[   89.836415] md: bind<sdd1>
[   89.844766] md: bind<sde1>
[   89.853098] md: bind<sdf1>
[   89.861456] md: bind<sda1>
[   89.914296] raid5: automatically using best checksumming function: pIII_sse
[   89.939552]    pIII_sse  :  3920.000 MB/sec
[   89.952153] raid5: using function: pIII_sse (3920.000 MB/sec)
[   89.993445] raid6: int32x1    988 MB/s
[   90.021416] raid6: int32x2   1132 MB/s
[   90.049369] raid6: int32x4    796 MB/s
[   90.077326] raid6: int32x8    589 MB/s
[   90.105191] raid6: mmxx1     2480 MB/s
[   90.133135] raid6: mmxx2     3117 MB/s
[   90.161079] raid6: sse1x1    1628 MB/s
[   90.189003] raid6: sse1x2    2226 MB/s
[   90.216958] raid6: sse2x1    2707 MB/s
[   90.244899] raid6: sse2x2    3285 MB/s
[   90.256198] raid6: using algorithm sse2x2 (3285 MB/s)
[   90.271373] md: raid6 personality registered for level 6
[   90.287328] md: raid5 personality registered for level 5
[   90.303284] md: raid4 personality registered for level 4
[   90.347889] raid5: device sda1 operational as raid disk 0
[   90.364121] raid5: device sdf1 operational as raid disk 5
[   90.380336] raid5: device sde1 operational as raid disk 4
[   90.396548] raid5: device sdd1 operational as raid disk 3
[   90.412761] raid5: device sdc1 operational as raid disk 2
[   90.428974] raid5: device sdb1 operational as raid disk 1
[   90.445627] raid5: allocated 6285kB for md0
[   90.458220] raid5: raid level 5 set md0 active with 6 out of 6 devices, algorithm 2
[   90.481224] RAID5 conf printout:
[   90.490952]  --- rd:6 wd:6
[   90.499126]  disk 0, o:1, dev:sda1
[   90.509372]  disk 1, o:1, dev:sdb1
[   90.519619]  disk 2, o:1, dev:sdc1
[   90.529865]  disk 3, o:1, dev:sdd1
[   90.540112]  disk 4, o:1, dev:sde1
[   90.550361]  disk 5, o:1, dev:sdf1
[   90.649441] kjournald starting.  Commit interval 5 seconds
[   90.690035] EXT3 FS on md0, internal journal
[   90.702982] EXT3-fs: mounted filesystem with ordered data mode.
[   91.107326] i2c_adapter i2c-0: SMBus Quick command not supported, can't probe for chips
[   91.131381] i2c_adapter i2c-1: SMBus Quick command not supported, can't probe for chips
[   91.155422] i2c_adapter i2c-2: SMBus Quick command not supported, can't probe for chips
[   91.283721] it87: Found IT8712F chip at 0x290, revision 5
[   96.057580] Real Time Clock Driver v1.12ac
[   96.205426] Intel 810 + AC97 Audio, version 1.01, 23:31:07 Feb  5 2007
[   96.242132] PCI: Setting latency timer of device 0000:00:1f.5 to 64
[   96.242137] i810: Intel ICH5 found at IO 0xdc00 and 0xd800, MEM 0xde101000 and 0xde102000, IRQ 22
[   96.268801] i810: Intel ICH5 mmio at 0xf89fe000 and 0xf8dbc000
[   96.784549] i810_audio: Primary codec has ID 2
[   96.797957] i810_audio: Audio Controller supports 6 channels.
[   96.815223] i810_audio: Defaulting to base 2 channel mode.
[   96.831697] i810_audio: Resetting connection 0
[   96.845089] i810_audio: Connection 0 with codec id 2
[   96.860307] ac97_codec: AC97 Audio codec, id: ALG128 (Unknown)
[   96.878457] i810_audio: AC'97 codec 2 Unable to map surround DAC's (or DAC's not present), total channels = 2
[   97.008529] DVB: registering new adapter (bttv0).
[   97.050811] DVB: registering frontend 2 (Zarlink MT352 DVB-T)...
[   97.069515] DVB: registering new adapter (bttv1).
[   97.108013] DVB: registering frontend 3 (Spase SP887x DVB-T)...
[   97.393021] loop: loaded (max 8 devices)
[   97.544417] lp0: using parport0 (interrupt-driven).
[   97.559088] lp0: console ready
[   97.905756] input: ImPS/2 Generic Wheel Mouse as /class/input/input3
[ 1047.952036] nvidia: module license 'NVIDIA' taints kernel.
[ 1048.231688] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 17
[ 1048.231877] NVRM: loading NVIDIA UNIX x86 Kernel Module  1.0-9746  Fri Dec 15 09:54:45 PST 2006
[ 1112.407498] NET: Registered protocol family 17
[ 1119.475697] sp887x: waiting for firmware upload (dvb-fe-sp887x.fw)...
[ 1119.534157] i2c_adapter i2c-5: sendbytes: error - bailout.
[ 1119.553329] sp887x_initial_setup: firmware upload... sp887x: firmware upload complete
[ 1130.779962] NVRM: loading NVIDIA UNIX x86 Kernel Module  1.0-9746  Fri Dec 15 09:54:45 PST 2006
[ 1130.945451] NVRM: not using NVAGP, an AGPGART backend is loaded!
[ 1131.268568] **WARNING** I2C adapter driver [NVIDIA i2c adapter 0 at 1:00.0] forgot to specify physical device; fix it!
[ 1131.301054] **WARNING** I2C adapter driver [NVIDIA i2c adapter 1 at 1:00.0] forgot to specify physical device; fix it!
[ 1131.333422] **WARNING** I2C adapter driver [NVIDIA i2c adapter 2 at 1:00.0] forgot to specify physical device; fix it!
[49609.535770] eth1: link down
[50409.031625] eth1: link down
[50458.173775] ACPI: PCI interrupt for device 0000:03:00.0 disabled
[50462.568588] 8139too Fast Ethernet driver 0.9.28
[50462.582909] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level, low) -> IRQ 16
[50462.606650] eth1: RealTek RTL8139 at 0x8000, 00:40:f4:7c:01:da, IRQ 16
[50462.626254] eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
[50472.425379] eth1: link down
[50838.942315] ISO 9660 Extensions: Microsoft Joliet Level 3
[50838.995065] ISOFS: changing to secondary root
[51198.435469] Floppy drive(s): fd0 is 1.44M
[51198.462259] FDC 0 is a post-1991 82077
[51652.134564] ACPI: PCI interrupt for device 0000:03:00.0 disabled
[51654.752441] 8139too Fast Ethernet driver 0.9.28
[51654.766798] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level, low) -> IRQ 16
[51654.790615] eth1: RealTek RTL8139 at 0x8000, 00:40:f4:7c:01:da, IRQ 16
[51654.810238] eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
[51732.573984] eth1: link down
[51869.230362] ACPI: PCI interrupt for device 0000:03:00.0 disabled
[51882.055418] 8139too Fast Ethernet driver 0.9.28
[51882.069632] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level, low) -> IRQ 16
[51882.093148] eth1: RealTek RTL8139 at 0x8000, 00:40:f4:7c:01:da, IRQ 16
[51882.112753] eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
[51895.092156] eth1: link down
[52712.676450] ACPI: PCI interrupt for device 0000:03:00.0 disabled
[52746.611231] 8139too Fast Ethernet driver 0.9.28
[52746.625819] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 18 (level, low) -> IRQ 16
[52746.649500] eth1: RealTek RTL8139 at 0x8000, 00:40:f4:7c:01:da, IRQ 16
[52746.669126] eth1:  Identified 8139 chip type 'RTL-8100B/8139D'
[52777.548838] eth1: link up, 10Mbps, half-duplex, lpa 0x0000
[55943.661256] eth1: link down
[55952.778841] eth1: link up, 10Mbps, half-duplex, lpa 0x0000
[59314.398192] eth1: link down
[296878.789042] ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[296878.809072] ata6.00: cmd 25/00:b8:3f:c4:b6/00:00:20:00:00/e0 tag 0 cdb 0x0 data 94208 in
[296878.809074]          res 50/00:00:f6:c4:b6/00:00:00:00:00/e0 Emask 0x1 (device error)
[296878.863463] ata6.00: configured for UDMA/133
[296878.876719] ata6: EH complete
[296878.887916] SCSI device sdf: 625142448 512-byte hdwr sectors (320073 MB)
[296878.908701] sdf: Write Protect is off
[296878.920049] sdf: Mode Sense: 00 3a 00 00
[296878.920677] SCSI device sdf: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[372228.827897] md: data-check of RAID array md0
[372228.841009] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[372228.858753] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[372228.888177] md: using 128k window, over a total of 312568576 blocks.
[373421.090148] md: md_do_sync() got signal ... exiting
[373900.027346] md: data-check of RAID array md0
[373900.040476] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[373900.058225] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[373900.087655] md: using 128k window, over a total of 312568576 blocks.
[373929.661179] md: md_do_sync() got signal ... exiting
[373969.047667] md: data-check of RAID array md0
[373969.060784] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[373969.078514] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[373969.107934] md: using 128k window, over a total of 312568576 blocks.
[373997.679790] md: md_do_sync() got signal ... exiting
[374111.455742] md: data-check of RAID array md0
[374111.468859] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[374111.486591] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[374111.516027] md: using 128k window, over a total of 312568576 blocks.
[374145.613884] md: md_do_sync() got signal ... exiting
[375467.714751] md: data-check of RAID array md0
[375467.727800] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[375467.745564] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[375467.774975] md: using 128k window, over a total of 312568576 blocks.
[375498.851782] md: md_do_sync() got signal ... exiting
[389928.941718] md: data-check of RAID array md0
[389928.954836] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[389928.972583] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[389929.001997] md: using 128k window, over a total of 312568576 blocks.
[390130.004529] md: md_do_sync() got signal ... exiting
[391181.917633] md: data-check of RAID array md0
[391181.930751] md: minimum _guaranteed_  speed: 10000 KB/sec/disk.
[391181.948746] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[391181.978165] md: using 128k window, over a total of 312568576 blocks.
[391205.275923] md: md_do_sync() got signal ... exiting
[391213.664075] md: data-check of RAID array md0
[391213.677230] md: minimum _guaranteed_  speed: 20000 KB/sec/disk.
[391213.695230] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[391213.724652] md: using 128k window, over a total of 312568576 blocks.
[391340.799459] md: md0: data-check done.
[391348.542935] md: data-check of RAID array md0
[391348.556051] md: minimum _guaranteed_  speed: 30000 KB/sec/disk.
[391348.574045] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[391348.603463] md: using 128k window, over a total of 312568576 blocks.
[391439.310203] md: md0: data-check done.
[391562.862444] md: data-check of RAID array md0
[391562.875572] md: minimum _guaranteed_  speed: 24000 KB/sec/disk.
[391562.893564] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[391562.922991] md: using 128k window, over a total of 312568576 blocks.
[391603.742930] md: md0: data-check done.
[411544.708182] md: data-check of RAID array md0
[411544.721215] md: minimum _guaranteed_  speed: 24000 KB/sec/disk.
[411544.739160] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[411544.768533] md: using 128k window, over a total of 312568576 blocks.
[426348.923156] md: md0: data-check done.
[426349.453805] RAID5 conf printout:
[426349.463741]  --- rd:6 wd:6
[426349.472101]  disk 0, o:1, dev:sda1
[426349.482528]  disk 1, o:1, dev:sdb1
[426349.492958]  disk 2, o:1, dev:sdc1
[426349.503386]  disk 3, o:1, dev:sdd1
[426349.513819]  disk 4, o:1, dev:sde1
[426349.524257]  disk 5, o:1, dev:sdf1
[927080.617744] md: data-check of RAID array md0
[927080.630783] md: minimum _guaranteed_  speed: 24000 KB/sec/disk.
[927080.648734] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[927080.678103] md: using 128k window, over a total of 312568576 blocks.
[937567.332751] ata3.00: exception Emask 0x10 SAct 0x0 SErr 0x4190002 action 0x2
[937567.354094] ata3.00: cmd b0/d5:01:09:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data 512 in
[937567.354096]          res 51/04:83:45:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)
[937568.120783] ata3: soft resetting port
[937568.282450] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[937568.306693] ata3.00: configured for UDMA/100
[937568.319733] ata3: EH complete
[937568.361223] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[937568.397207] sdc: Write Protect is off
[937568.408620] sdc: Mode Sense: 00 3a 00 00
[937568.453522] SCSI device sdc: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[941696.843935] md: md0: data-check done.
[941697.246454] RAID5 conf printout:
[941697.256366]  --- rd:6 wd:6
[941697.264718]  disk 0, o:1, dev:sda1
[941697.275146]  disk 1, o:1, dev:sdb1
[941697.285575]  disk 2, o:1, dev:sdc1
[941697.296003]  disk 3, o:1, dev:sdd1
[941697.306432]  disk 4, o:1, dev:sde1
[941697.316862]  disk 5, o:1, dev:sdf1
[1530647.746383] md: data-check of RAID array md0
[1530647.759677] md: minimum _guaranteed_  speed: 24000 KB/sec/disk.
[1530647.778041] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[1530647.807663] md: using 128k window, over a total of 312568576 blocks.
[1545248.680745] md: md0: data-check done.
[1545249.266727] RAID5 conf printout:
[1545249.276930]  --- rd:6 wd:6
[1545249.285542]  disk 0, o:1, dev:sda1
[1545249.296228]  disk 1, o:1, dev:sdb1
[1545249.306923]  disk 2, o:1, dev:sdc1
[1545249.317613]  disk 3, o:1, dev:sdd1
[1545249.328292]  disk 4, o:1, dev:sde1
[1545249.338981]  disk 5, o:1, dev:sdf1
[1561452.735032] EXT3 FS on md0, internal journal
[1565135.454597] md: requested-resync of RAID array md0
[1565135.469550] md: minimum _guaranteed_  speed: 24000 KB/sec/disk.
[1565135.487809] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for requested-resync.
[1565135.519058] md: using 128k window, over a total of 312568576 blocks.
[1571049.926138]  CIFS VFS: server not responding
[1571049.939827]  CIFS VFS: No response for cmd 114 mid 2686
[1579922.620488] md: md0: requested-resync done.
[1579923.081359] RAID5 conf printout:
[1579923.091529]  --- rd:6 wd:6
[1579923.100144]  disk 0, o:1, dev:sda1
[1579923.110833]  disk 1, o:1, dev:sdb1
[1579923.121517]  disk 2, o:1, dev:sdc1
[1579923.132206]  disk 3, o:1, dev:sdd1
[1579923.142894]  disk 4, o:1, dev:sde1
[1579923.153582]  disk 5, o:1, dev:sdf1
[1587189.769116] EXT3 FS on md0, internal journal
[1601734.884903] md: data-check of RAID array md0
[1601734.898203] md: minimum _guaranteed_  speed: 24000 KB/sec/disk.
[1601734.916490] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[1601734.946174] md: using 128k window, over a total of 312568576 blocks.
[1616496.836088] md: md0: data-check done.
[1616497.290429] RAID5 conf printout:
[1616497.300607]  --- rd:6 wd:6
[1616497.309218]  disk 0, o:1, dev:sda1
[1616497.319909]  disk 1, o:1, dev:sdb1
[1616497.330595]  disk 2, o:1, dev:sdc1
[1616497.341281]  disk 3, o:1, dev:sdd1
[1616497.351971]  disk 4, o:1, dev:sde1
[1616497.362658]  disk 5, o:1, dev:sdf1
[2134215.520301] md: data-check of RAID array md0
[2134215.533598] md: minimum _guaranteed_  speed: 24000 KB/sec/disk.
[2134215.551817] md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for data-check.
[2134215.581438] md: using 128k window, over a total of 312568576 blocks.
[2148832.606937] md: md0: data-check done.
[2148833.104971] RAID5 conf printout:
[2148833.115150]  --- rd:6 wd:6
[2148833.123777]  disk 0, o:1, dev:sda1
[2148833.134474]  disk 1, o:1, dev:sdb1
[2148833.145157]  disk 2, o:1, dev:sdc1
[2148833.155845]  disk 3, o:1, dev:sdd1
[2148833.166537]  disk 4, o:1, dev:sde1
[2148833.177220]  disk 5, o:1, dev:sdf1
[2277927.597019]  CIFS VFS: No response for cmd 114 mid 2688

--------------070001020601020700030202
Content-Type: text/plain;
 name="hdparm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hdparm"


/dev/sda:

ATA device, with non-removable media
	Model Number:       WDC WD3200SD-01KNB0                     
	Serial Number:      WD-WCAMR1466102
	Firmware Revision:  08.05J08
Standards:
	Supported: 6 5 4 3 
	Likely used: 6
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  625142448
	device size with M = 1024*1024:      305245 MBytes
	device size with M = 1000*1000:      320072 MBytes (320 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
		Automatic Acoustic Management feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

/dev/sdb:

ATA device, with non-removable media
	Model Number:       WDC WD3200JD-00KLB0                     
	Serial Number:      WD-WMAMR1305763
	Firmware Revision:  08.05J08
Standards:
	Supported: 6 5 4 3 
	Likely used: 6
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  625142448
	device size with M = 1024*1024:      305245 MBytes
	device size with M = 1000*1000:      320072 MBytes (320 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
		Automatic Acoustic Management feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

/dev/sdc:

ATA device, with non-removable media
	Model Number:       WDC WD3200JD-00KLB0                     
	Serial Number:      WD-WCAMR1427570
	Firmware Revision:  08.05J08
Standards:
	Supported: 6 5 4 3 
	Likely used: 6
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  625142448
	device size with M = 1024*1024:      305245 MBytes
	device size with M = 1000*1000:      320072 MBytes (320 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 0
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
		Automatic Acoustic Management feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

/dev/sdd:

ATA device, with non-removable media
	Model Number:       WDC WD3200JD-00KLB0                     
	Serial Number:      WD-WMAMR1628424
	Firmware Revision:  08.05J08
Standards:
	Supported: 6 5 4 3 
	Likely used: 6
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  625142448
	device size with M = 1024*1024:      305245 MBytes
	device size with M = 1000*1000:      320072 MBytes (320 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 0
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
		Automatic Acoustic Management feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

/dev/sde:

ATA device, with non-removable media
	Model Number:       WDC WD3200SD-01KNB0                     
	Serial Number:      WD-WCAMR1470395
	Firmware Revision:  08.05J08
Standards:
	Supported: 6 5 4 3 
	Likely used: 6
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  625142448
	device size with M = 1024*1024:      305245 MBytes
	device size with M = 1000*1000:      320072 MBytes (320 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 0
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
		Automatic Acoustic Management feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

/dev/sdf:

ATA device, with non-removable media
	Model Number:       WDC WD3200YS-01PGB0                     
	Serial Number:      WD-WCAPD3621822
	Firmware Revision:  21.00M21
Standards:
	Supported: 7 6 5 4 
	Likely used: 7
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  625142448
	device size with M = 1024*1024:      305245 MBytes
	device size with M = 1000*1000:      320072 MBytes (320 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 1
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 0
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
		Automatic Acoustic Management feature set 
		SET MAX security extension
	   *	SET FEATURES subcommand required to spinup after power up
		Power-Up In Standby feature set
	   *	DOWNLOAD MICROCODE cmd
	   *	General Purpose Logging feature set
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

--------------070001020601020700030202
Content-Type: text/plain;
 name="smartctl"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smartctl"

/dev/sda:
smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD3200SD-01KNB0
Serial Number:    WD-WCAMR1466102
Firmware Version: 08.05J08
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   6
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Mar  6 08:37:46 2007 EST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x84)	Offline data collection activity
					was suspended by an interrupting command from host.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 (9600) seconds.
Offline data collection
capabilities: 			 (0x7b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					No General Purpose Logging support.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 ( 116) minutes.
Conveyance self-test routine
recommended polling time: 	 (   6) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0003   185   185   021    Pre-fail  Always       -       5725
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       31
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   200   200   051    Pre-fail  Always       -       0
  9 Power_On_Hours          0x0032   085   085   000    Old_age   Always       -       10957
 10 Spin_Retry_Count        0x0013   100   253   051    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x0012   100   253   051    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       31
194 Temperature_Celsius     0x0022   112   096   000    Old_age   Always       -       38
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   200   200   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0009   200   200   051    Pre-fail  Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%     10884         -
# 2  Extended offline    Completed without error       00%     10717         -
# 3  Extended offline    Completed without error       00%     10548         -
# 4  Extended offline    Completed without error       00%     10377         -
# 5  Extended offline    Completed without error       00%     10209         -
# 6  Extended offline    Completed without error       00%     10041         -
# 7  Extended offline    Completed without error       00%      9874         -
# 8  Extended offline    Completed without error       00%      9706         -
# 9  Extended offline    Completed without error       00%      9538         -
#10  Extended offline    Completed without error       00%      9370         -
#11  Extended offline    Completed without error       00%      9202         -
#12  Extended offline    Completed without error       00%      9035         -
#13  Extended offline    Completed without error       00%      8867         -
#14  Extended offline    Completed without error       00%      8700         -
#15  Extended offline    Completed without error       00%      8532         -
#16  Extended offline    Completed without error       00%      8364         -
#17  Extended offline    Completed without error       00%      8196         -
#18  Extended offline    Completed without error       00%      8028         -
#19  Extended offline    Completed without error       00%      7861         -
#20  Extended offline    Completed without error       00%       241         -
#21  Short offline       Completed without error       00%       239         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

/dev/sdb:
smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD3200JD-00KLB0
Serial Number:    WD-WMAMR1305763
Firmware Version: 08.05J08
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   6
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Mar  6 08:37:46 2007 EST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x84)	Offline data collection activity
					was suspended by an interrupting command from host.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 (9600) seconds.
Offline data collection
capabilities: 			 (0x7b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					No General Purpose Logging support.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 ( 116) minutes.
Conveyance self-test routine
recommended polling time: 	 (   5) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0003   186   185   021    Pre-fail  Always       -       5700
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       100
  5 Reallocated_Sector_Ct   0x0033   195   195   140    Pre-fail  Always       -       35
  7 Seek_Error_Rate         0x000f   200   200   051    Pre-fail  Always       -       0
  9 Power_On_Hours          0x0032   084   084   000    Old_age   Always       -       12292
 10 Spin_Retry_Count        0x0013   100   253   051    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x0012   100   253   051    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       100
194 Temperature_Celsius     0x0022   110   089   000    Old_age   Always       -       40
196 Reallocated_Event_Count 0x0032   198   198   000    Old_age   Always       -       2
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   200   200   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0009   200   200   051    Pre-fail  Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%     12220         -
# 2  Extended offline    Completed without error       00%     12052         -
# 3  Extended offline    Completed without error       00%     11884         -
# 4  Extended offline    Completed without error       00%     11712         -
# 5  Extended offline    Completed without error       00%     11545         -
# 6  Extended offline    Completed without error       00%     11377         -
# 7  Extended offline    Completed without error       00%     11209         -
# 8  Extended offline    Completed without error       00%     11041         -
# 9  Extended offline    Completed without error       00%     10874         -
#10  Extended offline    Completed without error       00%     10706         -
#11  Extended offline    Completed without error       00%     10538         -
#12  Extended offline    Completed without error       00%     10371         -
#13  Extended offline    Completed without error       00%     10203         -
#14  Extended offline    Completed without error       00%     10035         -
#15  Extended offline    Completed without error       00%      9867         -
#16  Extended offline    Completed without error       00%      9699         -
#17  Extended offline    Completed without error       00%      9531         -
#18  Extended offline    Completed without error       00%      9364         -
#19  Extended offline    Completed without error       00%      9196         -
#20  Extended offline    Completed without error       00%      1576         -
#21  Conveyance offline  Interrupted (host reset)      40%      1014         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

/dev/sdc:
smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD3200JD-00KLB0
Serial Number:    WD-WCAMR1427570
Firmware Version: 08.05J08
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   6
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Mar  6 08:37:47 2007 EST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x84)	Offline data collection activity
					was suspended by an interrupting command from host.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 (9600) seconds.
Offline data collection
capabilities: 			 (0x7b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					No General Purpose Logging support.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 ( 116) minutes.
Conveyance self-test routine
recommended polling time: 	 (   6) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0003   195   186   021    Pre-fail  Always       -       5225
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       52
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   200   200   051    Pre-fail  Always       -       0
  9 Power_On_Hours          0x0032   085   085   000    Old_age   Always       -       11180
 10 Spin_Retry_Count        0x0013   100   253   051    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x0012   100   253   051    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       52
194 Temperature_Celsius     0x0022   110   095   000    Old_age   Always       -       40
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   200   200   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       665
200 Multi_Zone_Error_Rate   0x0009   200   200   051    Pre-fail  Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%     11107         -
# 2  Extended offline    Completed without error       00%     10939         -
# 3  Extended offline    Completed without error       00%     10600         -
# 4  Extended offline    Completed without error       00%     10432         -
# 5  Extended offline    Completed without error       00%     10264         -
# 6  Extended offline    Completed without error       00%     10096         -
# 7  Extended offline    Completed without error       00%      9929         -
# 8  Extended offline    Completed without error       00%      9761         -
# 9  Extended offline    Completed without error       00%      9593         -
#10  Extended offline    Completed without error       00%      9425         -
#11  Extended offline    Completed without error       00%      9258         -
#12  Extended offline    Completed without error       00%      9090         -
#13  Extended offline    Completed without error       00%      8922         -
#14  Extended offline    Completed without error       00%      8755         -
#15  Extended offline    Completed without error       00%      8587         -
#16  Extended offline    Completed without error       00%      8419         -
#17  Extended offline    Completed without error       00%      8251         -
#18  Conveyance offline  Completed without error       00%      8098         -
#19  Extended offline    Completed without error       00%      8084         -
#20  Extended offline    Completed without error       00%       463         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

/dev/sdd:
smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD3200JD-00KLB0
Serial Number:    WD-WMAMR1628424
Firmware Version: 08.05J08
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   6
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Mar  6 08:37:47 2007 EST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x84)	Offline data collection activity
					was suspended by an interrupting command from host.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 (9600) seconds.
Offline data collection
capabilities: 			 (0x7b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					No General Purpose Logging support.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 ( 116) minutes.
Conveyance self-test routine
recommended polling time: 	 (   6) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0003   191   190   021    Pre-fail  Always       -       5450
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       85
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   200   200   051    Pre-fail  Always       -       0
  9 Power_On_Hours          0x0032   084   084   000    Old_age   Always       -       11915
 10 Spin_Retry_Count        0x0013   100   253   051    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x0012   100   253   051    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       85
194 Temperature_Celsius     0x0022   109   095   000    Old_age   Always       -       41
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   200   200   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       283
200 Multi_Zone_Error_Rate   0x0009   200   200   051    Pre-fail  Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%     11842         -
# 2  Extended offline    Completed without error       00%     11674         -
# 3  Extended offline    Completed without error       00%     11506         -
# 4  Extended offline    Completed without error       00%     11335         -
# 5  Extended offline    Completed without error       00%     11167         -
# 6  Extended offline    Completed without error       00%     10999         -
# 7  Extended offline    Completed without error       00%     10831         -
# 8  Extended offline    Completed without error       00%     10664         -
# 9  Extended offline    Completed without error       00%     10495         -
#10  Extended offline    Completed without error       00%     10328         -
#11  Extended offline    Completed without error       00%     10160         -
#12  Extended offline    Completed without error       00%      9993         -
#13  Extended offline    Completed without error       00%      9825         -
#14  Extended offline    Completed without error       00%      9657         -
#15  Extended offline    Completed without error       00%      9490         -
#16  Extended offline    Completed without error       00%      9322         -
#17  Extended offline    Completed without error       00%      9154         -
#18  Extended offline    Completed without error       00%      8986         -
#19  Conveyance offline  Completed without error       00%      8833         -
#20  Extended offline    Completed without error       00%      8819         -
#21  Extended offline    Completed without error       00%      1198         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

/dev/sde:
smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD3200SD-01KNB0
Serial Number:    WD-WCAMR1470395
Firmware Version: 08.05J08
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   6
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Mar  6 08:37:47 2007 EST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x84)	Offline data collection activity
					was suspended by an interrupting command from host.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 (9600) seconds.
Offline data collection
capabilities: 			 (0x7b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					No General Purpose Logging support.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 ( 116) minutes.
Conveyance self-test routine
recommended polling time: 	 (   6) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0003   188   188   021    Pre-fail  Always       -       5558
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       38
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   200   200   051    Pre-fail  Always       -       0
  9 Power_On_Hours          0x0032   086   086   000    Old_age   Always       -       10269
 10 Spin_Retry_Count        0x0013   100   253   051    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x0012   100   253   051    Old_age   Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       38
194 Temperature_Celsius     0x0022   111   090   000    Old_age   Always       -       39
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   200   200   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0009   200   200   051    Pre-fail  Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%     10196         -
# 2  Extended offline    Completed without error       00%     10028         -
# 3  Extended offline    Completed without error       00%      9861         -
# 4  Extended offline    Completed without error       00%      9689         -
# 5  Extended offline    Completed without error       00%      9521         -
# 6  Extended offline    Completed without error       00%      9353         -
# 7  Extended offline    Completed without error       00%      9186         -
# 8  Extended offline    Completed without error       00%      9018         -
# 9  Extended offline    Completed without error       00%      8850         -
#10  Extended offline    Completed without error       00%      8682         -
#11  Extended offline    Completed without error       00%      8514         -
#12  Extended offline    Completed without error       00%      8347         -
#13  Extended offline    Completed without error       00%      8179         -
#14  Extended offline    Completed without error       00%      8011         -
#15  Extended offline    Completed without error       00%      7844         -
#16  Extended offline    Completed without error       00%      7676         -
#17  Extended offline    Completed without error       00%      7508         -
#18  Extended offline    Completed without error       00%      7340         -
#19  Extended offline    Completed without error       00%      7173         -
#20  Extended offline    Completed without error       00%       241         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

/dev/sdf:
smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Device Model:     WDC WD3200YS-01PGB0
Serial Number:    WD-WCAPD3621822
Firmware Version: 21.00M21
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   7
ATA Standard is:  Exact ATA specification draft version not indicated
Local Time is:    Tue Mar  6 08:37:47 2007 EST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x84)	Offline data collection activity
					was suspended by an interrupting command from host.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)	The previous self-test routine completed
					without error or no self-test has ever 
					been run.
Total time to complete Offline 
data collection: 		 (9600) seconds.
Offline data collection
capabilities: 			 (0x7b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					General Purpose Logging supported.
Short self-test routine 
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 ( 111) minutes.
Conveyance self-test routine
recommended polling time: 	 (   6) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   200   200   051    Pre-fail  Always       -       0
  3 Spin_Up_Time            0x0003   100   253   021    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   100   100   000    Old_age   Always       -       4
  5 Reallocated_Sector_Ct   0x0033   200   200   140    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x000f   200   200   051    Pre-fail  Always       -       0
  9 Power_On_Hours          0x0032   100   100   000    Old_age   Always       -       712
 10 Spin_Retry_Count        0x0013   100   253   051    Pre-fail  Always       -       0
 11 Calibration_Retry_Count 0x0013   100   253   051    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       3
190 Unknown_Attribute       0x0022   062   044   000    Old_age   Always       -       38
194 Temperature_Celsius     0x0022   112   095   000    Old_age   Always       -       38
196 Reallocated_Event_Count 0x0032   200   200   000    Old_age   Always       -       0
197 Current_Pending_Sector  0x0012   200   200   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   200   200   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x0009   200   200   051    Pre-fail  Offline      -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Extended offline    Completed without error       00%       640         -
# 2  Extended offline    Completed without error       00%       472         -
# 3  Extended offline    Completed without error       00%       304         -
# 4  Extended offline    Completed without error       00%       133         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.


--------------070001020601020700030202--
