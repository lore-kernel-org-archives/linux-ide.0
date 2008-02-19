From: Denys Dmytriyenko <denis@denix.org>
Subject: sata_sil24 stability and performance
Date: Mon, 18 Feb 2008 21:09:16 -0500
Message-ID: <20080219020916.GA29902@denix.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=zhXaljGHf11kAtnf
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vms048pub.verizon.net ([206.46.252.48]:49913 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbYBSCJW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 21:09:22 -0500
Received: from gandalf.denix.org ([71.255.238.68])
 by vms048.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JWG00JFBRBHDI84@vms048.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Mon, 18 Feb 2008 20:09:19 -0600 (CST)
Content-disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gurus!

Preamble:

I've been following this list for several months now trying to spot a similar
issue or to gain knowledge to resolve mine. I'm pretty sure the problem is
with my setup/configuration, but I've been unable to fix it so far. I would be
eternally grateful if someone can help me in resolving the issue. Thanks in
advance.

Setup:

I'm running a fileserver with array of 10 disks (8 Seagate 500GB 7200.9 and
7200.10 plus 2 Maxtors) on 3 Addonics ADSA4R5 (4-port SATA2 PCI on Sil 3124)
cards in JBOD configuration. The host is a little bit outdated and is dual AMD
Athlon MP 1900+ on Tyan Tiger MPX (S2466N-4M) with 1GB of RAM. SATA cards are
in PCI slots, not PCI-X. Most of the time drives are in standby mode (30min
timeout), but it does not make any difference with issues I'm seeing.
Filesystem used is XFS and all the disks are shared over NFS. Power supply was
originally 550 watt Enermax (should be enough power, according to a wattmeter),
but to be sure was replaced to 750 watt Coolermaster. The kernel is currently
2.6.23.9, but I tried many other versions from 2.6.21 to 2.6.24. The system is
Gentoo, but the kernel is vanilla.

Issue #1:

I'm seeing lots of resets in the logs for different drives and different
exceptions. Sometimes on idle drives, but mostly on those being accessed.
Sometimes I can see couple exceptions in a row, but sometimes I don't see any
for hours. These are just example exceptions, but I believe I've seen others
as well:

ata1: failed to read log page 10h (errno=-2)
ata1.00: exception Emask 0x1 SAct 0x3 SErr 0x0 action 0x0
ata1.00: irq_stat 0x00060002, device error via SDB FIS
ata1.00: cmd 60/80:00:bf:00:00/00:00:00:00:00/40 tag 0 cdb 0x0 data 65536 in
         res 40/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x1 (device error)
ata1.00: cmd 60/80:08:3f:00:00/00:00:00:00:00/40 tag 1 cdb 0x0 data 65536 in
         res 40/00:00:2f:60:38/00:00:3a:00:00/e0 Emask 0x1 (device error)
ata1.00: configured for UDMA/100
ata1: EH complete
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support
 DPO or FUA

ata12: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0x2 frozen
ata12: irq_stat 0x01100010, PHY RDY changed
ata12: soft resetting port
ata12: softreset failed (timeout)
ata12: hard resetting port
ata12: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata12.00: configured for UDMA/100
ata12: EH complete
sd 11:0:0:0: [sdj] 976773168 512-byte hardware sectors (500108 MB)
sd 11:0:0:0: [sdj] Write Protect is off
sd 11:0:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 11:0:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support
 DPO or FUA

I'm not sure how critical are those. The side effect of those resets is
loosing my standby timeout settings. But I'm rather worried about drives
operating optimally and the integrity of my data. Therefore any failure or
exception message in the logs is considered bad and means something is wrong
and needs attention. Please help me understand/resolve those exceptions.

Issue #2:

I am also having a performance issue with sata_sil24. I can read data at
speeds up to 30 MB/s but write only at speeds around 15 MB/s. When I used
Supermicro 8-port sata_mv card, I was able to get speeds at around 40-50 MB/s.
Unfortunatelly, sata_mv was not stable at that time and I had to replace it
with what was claimed to be the most supported SATA2 chipset under Linux -
sata_sil24... I bet the problem is with my setup, but I cannot figure out
where or how to fix it.

"hdparm -t" reports speeds in the area of 60-80 MB/s though.

What I find strange is that the host controller is only recognized as UDMA/100
and all the drives even though they are UDMA/133 configured for UDMA/100.

Another strange thing is that all the disks are configured for 16-bit
IO_support and cannot be changed to 32-bit:

/dev/sda:
 IO_support    =  0 (default 16-bit)
 readonly      =  0 (off)
 readahead     = 256 (on)
 geometry      = 60801/255/63, sectors = 976773168, start = 0

And one more thing - both Maxtor drives have their write cache disabled by
default, unlike Seagate drives. Should I be worried about it?

The bootup sequence and lspci dump are attached. Please note there is HPT374
2-channel IDE RAID device in the logs, which runs a small RAID5 array, but I
tried w/o it before and had same issues.

I'd really appreciate if anybody can help me resolve my problems.
Thanks in advance!

Regards,
Denys

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bootup.txt"

Linux version 2.6.23.9 (root@gandalf) (gcc version 3.4.6 (Gentoo 3.4.6-r2, ssp-3.4.6-1.0, pie-8.7.10)) #1 SMP Wed Dec 5 13:18:48 EST 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000096c00 (usable)
 BIOS-e820: 0000000000096c00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fef0000 (usable)
 BIOS-e820: 000000003fef0000 - 000000003feff000 (ACPI data)
 BIOS-e820: 000000003feff000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec04000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f7170
Entering add_active_range(0, 0, 262016) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   262016
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   262016
On node 0 totalpages: 262016
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 255 pages used for memmap
  HighMem zone: 32385 pages, LIFO batch:7
  Movable zone: 0 pages used for memmap
DMI 2.3 present.
ACPI: RSDP 000F7100, 0014 (r0 PTLTD )
ACPI: RSDT 3FEFCF28, 002C (r1 PTLTD    RSDT    6040000  LTP        0)
ACPI: FACP 3FEFEF2E, 0074 (r1 AMD    TECATE    6040000 PTL     F4240)
ACPI: DSDT 3FEFCF54, 1FDA (r1    AMD  AMDACPI  6040000 MSFT  100000D)
ACPI: FACS 3FEFFFC0, 0040
ACPI: APIC 3FEFEFA2, 005E (r1 PTLTD  	 APIC    6040000  LTP        0)
ACPI: PM-Timer IO Port: 0x8008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x01] enabled)
Processor #1 6:6 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:6 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists in Zone order.  Total pages: 259969
Kernel command line: root=/dev/hda4
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1600.106 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1031468k/1048064k available (4703k kernel code, 15928k reserved, 1492k data, 228k init, 130496k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9b000 - 0xfffff000   ( 400 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0716000 - 0xc074f000   ( 228 kB)
      .data : 0xc0597fe0 - 0xc070d138   (1492 kB)
      .text : 0xc0100000 - 0xc0597fe0   (4703 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
SLUB: Genslabs=22, HWalign=32, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Calibrating delay using timer specific routine.. 3203.64 BogoMIPS (lpj=6407286)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000420 00000000 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
CPU0: AMD Athlon(tm) MP 1900+ stepping 02
SMP alternatives: switching to SMP code
Booting processor 1/0 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3200.61 BogoMIPS (lpj=6401239)
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000420 00000000 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) Processor stepping 02
Total of 2 processors activated (6404.26 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
Brought up 2 CPUs
xor: automatically using best checksumming function: pIII_sse
   pIII_sse  :  4311.000 MB/sec
xor: using function: pIII_sse (4311.000 MB/sec)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd7d0, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.OP2P._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 *5 10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 5 10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 *10 11)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 9 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 2.21 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:00: iomem range 0xfffc0000-0xffffffff could not be reserved
pnp: 00:00: iomem range 0xffc00000-0xfff7ffff has been reserved
pnp: 00:00: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:00: iomem range 0x100000-0x3fffffff could not be reserved
pnp: 00:06: ioport range 0x4d0-0x4d1 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f8000000-fbffffff
  PREFETCH window: 50000000-500fffff
PCI: Bridge: 0000:00:10.0
  IO window: 2000-2fff
  MEM window: fc000000-fc0fffff
  PREFETCH window: 50100000-502fffff
NET: Registered protocol family 2
Time: acpi_pm clocksource has been installed.
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1203293519.376:1): initialized
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.28 [Flags: R/W].
SGI XFS with large block numbers, no debug enabled
async_tx: api initialized (sync-only)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
BIOS failed to enable PCI standards compliance, fixing this error.
Boot video device is 0000:01:05.0
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Sleep Button (FF) as /class/input/input1
ACPI: Sleep Button (FF) [SLPF]
input: Power Button (CM) as /class/input/input2
ACPI: Power Button (CM) [PWRB]
lp: driver loaded but no devices found
Linux agpgart interface v0.102
agpgart: Detected AMD 760MP chipset
agpgart: AGP aperture is 32M @ 0x0
[drm] Initialized drm 1.1.0 20060810
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 16 (level, low) -> IRQ 16
e1000: 0000:02:04.0: e1000_probe: (PCI:33MHz:32-bit) 00:07:e9:0f:54:22
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 19 (level, low) -> IRQ 17
3c59x: Donald Becker and others.
0000:02:08.0: 3Com PCI 3c905C Tornado at f8826c00.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 0000:00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
AMD7441: 0000:00:07.1 (rev 04) UDMA100 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: WDC WD300BB-00AUA1, ATA DISK drive
hdb: PIONEER DVD-RW DVR-112D, ATAPI CD/DVD-ROM drive
hda: selected mode 0x45
hdb: selected mode 0x44
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: WDC WD800JB-00CRA1, ATA DISK drive
hdc: selected mode 0x45
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4
hdc: max request size: 128KiB
hdc: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
hdc: cache flushes not supported
 hdc: hdc1
hdb: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
sata_sil24 0000:02:05.0: version 1.0
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 17 (level, low) -> IRQ 18
scsi0 : sata_sil24
scsi1 : sata_sil24
scsi2 : sata_sil24
scsi3 : sata_sil24
ata1: SATA max UDMA/100 cmd 0xf8830000 ctl 0x00000000 bmdma 0x00000000 irq 18
ata2: SATA max UDMA/100 cmd 0xf8832000 ctl 0x00000000 bmdma 0x00000000 irq 18
ata3: SATA max UDMA/100 cmd 0xf8834000 ctl 0x00000000 bmdma 0x00000000 irq 18
ata4: SATA max UDMA/100 cmd 0xf8836000 ctl 0x00000000 bmdma 0x00000000 irq 18
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7: Maxtor 7H500F0, HA431DN0, max UDMA/133
ata1.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/100
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7: ST3500630AS, 3.AAE, max UDMA/133
ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/100
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 7H500F0   HA43 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg1 type 0
ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 18 (level, low) -> IRQ 19
scsi4 : sata_sil24
scsi5 : sata_sil24
scsi6 : sata_sil24
scsi7 : sata_sil24
ata5: SATA max UDMA/100 cmd 0xf8870000 ctl 0x00000000 bmdma 0x00000000 irq 19
ata6: SATA max UDMA/100 cmd 0xf8872000 ctl 0x00000000 bmdma 0x00000000 irq 19
ata7: SATA max UDMA/100 cmd 0xf8874000 ctl 0x00000000 bmdma 0x00000000 irq 19
ata8: SATA max UDMA/100 cmd 0xf8876000 ctl 0x00000000 bmdma 0x00000000 irq 19
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: ATA-7: ST3500630AS, 3.AAE, max UDMA/133
ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata5.00: configured for UDMA/100
ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata6.00: ATA-7: Maxtor 7H500F0, HA431DN0, max UDMA/133
ata6.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata6.00: configured for UDMA/100
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata7.00: ATA-7: ST3500641AS, 3.AAH, max UDMA/133
ata7.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata7.00: configured for UDMA/100
ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata8.00: ATA-7: ST3500641AS, 3.AAJ, max UDMA/133
ata8.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata8.00: configured for UDMA/100
scsi 4:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
sd 4:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 4:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 4:0:0:0: [sdc] Attached SCSI disk
sd 4:0:0:0: Attached scsi generic sg2 type 0
scsi 5:0:0:0: Direct-Access     ATA      Maxtor 7H500F0   HA43 PQ: 0 ANSI: 5
sd 5:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 5:0:0:0: [sdd] Write Protect is off
sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdd] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 5:0:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 5:0:0:0: [sdd] Write Protect is off
sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdd] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 5:0:0:0: [sdd] Attached SCSI disk
sd 5:0:0:0: Attached scsi generic sg3 type 0
scsi 6:0:0:0: Direct-Access     ATA      ST3500641AS      3.AA PQ: 0 ANSI: 5
sd 6:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
sd 6:0:0:0: [sde] Write Protect is off
sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 6:0:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
sd 6:0:0:0: [sde] Write Protect is off
sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: sde1
sd 6:0:0:0: [sde] Attached SCSI disk
sd 6:0:0:0: Attached scsi generic sg4 type 0
scsi 7:0:0:0: Direct-Access     ATA      ST3500641AS      3.AA PQ: 0 ANSI: 5
sd 7:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 7:0:0:0: [sdf] Write Protect is off
sd 7:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 7:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 7:0:0:0: [sdf] Write Protect is off
sd 7:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 7:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdf: sdf1
sd 7:0:0:0: [sdf] Attached SCSI disk
sd 7:0:0:0: Attached scsi generic sg5 type 0
ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 19 (level, low) -> IRQ 17
scsi8 : sata_sil24
scsi9 : sata_sil24
scsi10 : sata_sil24
scsi11 : sata_sil24
ata9: SATA max UDMA/100 cmd 0xf8880000 ctl 0x00000000 bmdma 0x00000000 irq 17
ata10: SATA max UDMA/100 cmd 0xf8882000 ctl 0x00000000 bmdma 0x00000000 irq 17
ata11: SATA max UDMA/100 cmd 0xf8884000 ctl 0x00000000 bmdma 0x00000000 irq 17
ata12: SATA max UDMA/100 cmd 0xf8886000 ctl 0x00000000 bmdma 0x00000000 irq 17
ata9: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata9.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
ata9.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata9.00: configured for UDMA/100
ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata10.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
ata10.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata10.00: configured for UDMA/100
ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata11.00: ATA-7: ST3500641AS, 3.AAJ, max UDMA/133
ata11.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata11.00: configured for UDMA/100
ata12: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata12.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
ata12.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata12.00: configured for UDMA/100
scsi 8:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
sd 8:0:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 8:0:0:0: [sdg] Write Protect is off
sd 8:0:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 8:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 8:0:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 8:0:0:0: [sdg] Write Protect is off
sd 8:0:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 8:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdg: sdg1
sd 8:0:0:0: [sdg] Attached SCSI disk
sd 8:0:0:0: Attached scsi generic sg6 type 0
scsi 9:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
sd 9:0:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 9:0:0:0: [sdh] Write Protect is off
sd 9:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 9:0:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 9:0:0:0: [sdh] Write Protect is off
sd 9:0:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 9:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdh: sdh1
sd 9:0:0:0: [sdh] Attached SCSI disk
sd 9:0:0:0: Attached scsi generic sg7 type 0
scsi 10:0:0:0: Direct-Access     ATA      ST3500641AS      3.AA PQ: 0 ANSI: 5
sd 10:0:0:0: [sdi] 976773168 512-byte hardware sectors (500108 MB)
sd 10:0:0:0: [sdi] Write Protect is off
sd 10:0:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 10:0:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 10:0:0:0: [sdi] 976773168 512-byte hardware sectors (500108 MB)
sd 10:0:0:0: [sdi] Write Protect is off
sd 10:0:0:0: [sdi] Mode Sense: 00 3a 00 00
sd 10:0:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdi: sdi1
sd 10:0:0:0: [sdi] Attached SCSI disk
sd 10:0:0:0: Attached scsi generic sg8 type 0
scsi 11:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
sd 11:0:0:0: [sdj] 976773168 512-byte hardware sectors (500108 MB)
sd 11:0:0:0: [sdj] Write Protect is off
sd 11:0:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 11:0:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 11:0:0:0: [sdj] 976773168 512-byte hardware sectors (500108 MB)
sd 11:0:0:0: [sdj] Write Protect is off
sd 11:0:0:0: [sdj] Mode Sense: 00 3a 00 00
sd 11:0:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdj: sdj1
sd 11:0:0:0: [sdj] Attached SCSI disk
sd 11:0:0:0: Attached scsi generic sg9 type 0
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugfs is not available
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:02:00.0[D] -> GSI 19 (level, low) -> IRQ 17
ohci_hcd 0000:02:00.0: OHCI Host Controller
ohci_hcd 0000:02:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:02:00.0: irq 17, io mem 0xfc018000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
usb 1-4: new low speed USB device using ohci_hcd and address 2
usb 1-4: device descriptor read/64, error -62
usb 1-4: device descriptor read/64, error -62
usb 1-4: new low speed USB device using ohci_hcd and address 3
usb 1-4: device descriptor read/64, error -62
usb 1-4: device descriptor read/64, error -62
usb 1-4: new low speed USB device using ohci_hcd and address 4
usb 1-4: device not accepting address 4, error -62
usb 1-4: new low speed USB device using ohci_hcd and address 5
usb 1-4: device not accepting address 5, error -62
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input3
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
raid6: int32x1    658 MB/s
raid6: int32x2    853 MB/s
raid6: int32x4    549 MB/s
raid6: int32x8    508 MB/s
raid6: mmxx1     1311 MB/s
raid6: mmxx2     2258 MB/s
raid6: sse1x1     468 MB/s
raid6: sse1x2     936 MB/s
raid6: using algorithm sse1x2 (936 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.14 (Fri Jul 20 09:12:58 2007 UTC).
ALSA device list:
  No soundcards found.
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
ctnetlink v0.93: registering with nfnetlink.
ip_tables: (C) 2000-2006 Netfilter Core Team
ClusterIP Version 0.8 loaded successfully
arp_tables: (C) 2002 David S. Miller
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI No-Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ReiserFS: hda4: found reiserfs format "3.6" with standard journal
ReiserFS: hda4: using ordered data mode
ReiserFS: hda4: journal params: device hda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda4: checking transaction log (hda4)
ReiserFS: hda4: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 228k freed
AMD768 RNG detected
Real Time Clock Driver v1.12ac
floppy0: no floppy controllers found
hpt374: module license 'Proprietary' taints kernel.
HPT374 UDMA/ATA133 RAID Controller driver
Version 2.17, Compiled Dec  9 2007 18:19:24
RAID5 write-back enabled
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 21 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:00:09.1[A] -> GSI 21 (level, low) -> IRQ 20
scsi12 : hpt374
scsi 12:0:0:0: Direct-Access     HPT3xx   RAID 5 Array     3.00 PQ: 0 ANSI: 0
sd 12:0:0:0: [sdk] 976793600 512-byte hardware sectors (500118 MB)
sd 12:0:0:0: [sdk] Write Protect is off
sd 12:0:0:0: [sdk] Mode Sense: 2f 00 00 00
sd 12:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 12:0:0:0: [sdk] 976793600 512-byte hardware sectors (500118 MB)
sd 12:0:0:0: [sdk] Write Protect is off
sd 12:0:0:0: [sdk] Mode Sense: 2f 00 00 00
sd 12:0:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdk: sdk1
sd 12:0:0:0: [sdk] Attached SCSI disk
sd 12:0:0:0: Attached scsi generic sg10 type 0
w83781d 0-002c: The W83627HF chip is better supported by the w83627hf driver, support will be dropped from the w83781d driver soon
aufs 20071203
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
XFS mounting filesystem sdk1
Ending clean XFS mount for filesystem: sdk1
XFS mounting filesystem sdj1
Ending clean XFS mount for filesystem: sdj1
XFS mounting filesystem sdc1
Ending clean XFS mount for filesystem: sdc1
XFS mounting filesystem sdi1
Ending clean XFS mount for filesystem: sdi1
XFS mounting filesystem sdh1
Ending clean XFS mount for filesystem: sdh1
XFS mounting filesystem sdg1
Ending clean XFS mount for filesystem: sdg1
XFS mounting filesystem sdf1
Ending clean XFS mount for filesystem: sdf1
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
XFS mounting filesystem sdb1
Ending clean XFS mount for filesystem: sdb1
XFS mounting filesystem sde1
Ending clean XFS mount for filesystem: sde1
XFS mounting filesystem sdd1
Ending clean XFS mount for filesystem: sdd1
Adding 530136k swap on /dev/hda2.  Priority:-1 extents:1 across:530136k
hda: selected mode 0x45
hdb: selected mode 0x44
hdc: selected mode 0x45
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
eth1:  setting half-duplex.
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
w83627hf: Found W83627HF chip at 0xc00
PPP generic driver version 2.4.2
PPP BSD Compression module registered

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.txt"

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 32
	Region 0: Memory at <unassigned> (32-bit, prefetchable)
	Region 1: Memory at fc300000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 1810 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=<none>
	Kernel driver in use: agpgart-amdk7

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f8000000-fbffffff
	Prefetchable memory behind bridge: 50000000-500fffff
	Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [disabled] [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at f000 [size=16]
	Kernel driver in use: AMD_IDE

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: amd756_smbus
	Kernel modules: i2c-amd756, amd-rng

00:09.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc. Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at 1828 [size=8]
	Region 1: I/O ports at 1820 [size=4]
	Region 2: I/O ports at 1818 [size=8]
	Region 3: I/O ports at 1814 [size=4]
	Region 4: I/O ports at 1000 [size=256]
	[virtual] Expansion ROM at 50300000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc. Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at 1840 [size=8]
	Region 1: I/O ports at 1838 [size=4]
	Region 2: I/O ports at 1830 [size=8]
	Region 3: I/O ports at 1824 [size=4]
	Region 4: I/O ports at 1400 [size=256]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=168
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: fc000000-fc0fffff
	Prefetchable memory behind bridge: 50100000-502fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-

01:05.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev 02) (prog-if 00 [VGA controller])
	Subsystem: S3 Inc. Trio3D/2X
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
	[virtual] Expansion ROM at 50000000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [80] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x2

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 17
	Region 0: Memory at fc018000 (32-bit, non-prefetchable) [size=4K]
	Kernel driver in use: ohci_hcd

02:04.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 02)
	Subsystem: Intel Corporation PRO/1000 MT Desktop Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (63750ns min), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at fc040000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at fc020000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at 2080 [size=64]
	[virtual] Expansion ROM at 50280000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=1
		Status: Dev=00:00.0 64bit- 133MHz- SCD- USC- DC=simple DMMRBC=2048 DMOST=1 DMCRS=16 RSCEM- 266MHz- 533MHz-
	Capabilities: [f0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: e1000

02:05.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. Unknown device 7124
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fc019000 (64-bit, non-prefetchable) [size=128]
	Region 2: Memory at fc000000 (64-bit, non-prefetchable) [size=32K]
	Region 4: I/O ports at 20c0 [size=16]
	[virtual] Expansion ROM at 50100000 [disabled] [size=512K]
	Capabilities: [64] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=12
		Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 533MHz-
	Capabilities: [54] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: sata_sil24

02:06.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. Unknown device 7124
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fc019400 (64-bit, non-prefetchable) [size=128]
	Region 2: Memory at fc008000 (64-bit, non-prefetchable) [size=32K]
	Region 4: I/O ports at 20d0 [size=16]
	[virtual] Expansion ROM at 50180000 [disabled] [size=512K]
	Capabilities: [64] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=12
		Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 533MHz-
	Capabilities: [54] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: sata_sil24

02:07.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. Unknown device 7124
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at fc019800 (64-bit, non-prefetchable) [size=128]
	Region 2: Memory at fc010000 (64-bit, non-prefetchable) [size=32K]
	Region 4: I/O ports at 20e0 [size=16]
	[virtual] Expansion ROM at 50200000 [disabled] [size=512K]
	Capabilities: [64] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=12
		Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 533MHz-
	Capabilities: [54] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Kernel driver in use: sata_sil24

02:08.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
	Subsystem: Tyan Computer Tiger MPX S2466 (3C920 Integrated Fast Ethernet Controller)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 80 (2500ns min, 2500ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 2000 [size=128]
	Region 1: Memory at fc019c00 (32-bit, non-prefetchable) [size=128]
	[virtual] Expansion ROM at 502a0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
	Kernel driver in use: 3c59x


--zhXaljGHf11kAtnf--
