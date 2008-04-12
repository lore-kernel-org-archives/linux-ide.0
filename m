From: "Marko Koivusalo" <marko.koivusalo@gmail.com>
Subject: Re: Promise TX4 performance problems
Date: Sat, 12 Apr 2008 23:50:35 +0300
Message-ID: <cdcaea5a0804121350n167b3715y4a0e52d543253423@mail.gmail.com>
References: <cdcaea5a0804120556w6ef4479fi86c05a4613b12a97@mail.gmail.com>
	 <20080412162628.334d66f1@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:62475 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbYDLUuh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 16:50:37 -0400
Received: by an-out-0708.google.com with SMTP id d31so249135and.103
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 13:50:35 -0700 (PDT)
In-Reply-To: <20080412162628.334d66f1@core>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, mikpe@it.uu.se
Cc: linux-ide@vger.kernel.org

On Sat, Apr 12, 2008 at 6:26 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>  Isn't the 174x just a marvell with different PCI identifiers ?

Yes it's some marvell chip, apparently you've updated sata_mv some
time ago to include identifiers for rr174x. Last time I checked for
Open Source alternative there were nothing available. Currently
Marvell SATA support is labeled HIGHLY EXPERIMENTAL. How stable they
actually are, or am I better off with binary drivers for now?

Anyway here's my identifiers for that device, if any use ..

02:00.0 SCSI storage controller: HighPoint Technologies, Inc.
RocketRAID 1740 (rev 02)
        Subsystem: Marvell Technology Group Ltd. Unknown device 11ab
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e5000000 (64-bit, non-prefetchable) [size=1M]
        Region 2: I/O ports at 8000 [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [60] PCI-X non-bridge device
                Command: DPERE- ERO- RBC=512 OST=4
                Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple
DMMRBC=512 DMOST=4 DMCRS=8 RSCEM- 266MHz- 533MHz-

>  The dmesg output and hdparm -t values for that controller/device would be
>  useful just as a guide to low level behaviour

I compiled 2.6.25-rc9 and ran some more tests.

hdparm -t /dev/sdd

/dev/sdd:
 Timing buffered disk reads:  228 MB in  3.01 seconds =  75.66 MB/sec

So aparantly read speeds are just fine. However write speeds are still
very slow.

dd if=/dev/zero of=1gb bs=1M count=1024
1073741824 bytes (1.1 GB) copied, 107.068 s, 10.0 MB/s

All ideas how to proceed are appreciated, power supply is high quality
and adequate for sure (4 different power rails, over 20A in reserve).
Only thing I can think of is to yank all other controllers off and try
if it helps ...

lspci and dmesg outputs below.

lspci:

00:00.0 Host bridge: Intel Corporation 82845 845 [Brookdale] Chipset
Host Bridge (rev 11)
00:01.0 PCI bridge: Intel Corporation 82845 845 [Brookdale] Chipset
AGP Bridge (rev 11)
00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M)
USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC
Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA
TNT2 Model 64/Model 64 Pro] (rev 15)
02:00.0 SCSI storage controller: HighPoint Technologies, Inc.
RocketRAID 1740 (rev 02)
02:01.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX
[Cyclone] (rev 24)
02:02.0 RAID bus controller: Promise Technology, Inc. PDC20371
(FastTrak S150 TX2plus) (rev 02)
02:03.0 Mass storage controller: Promise Technology, Inc. PDC40718
(SATA 300 TX4) (rev 02)
02:04.0 RAID bus controller: HighPoint Technologies, Inc. HPT374 (rev 07)
02:04.1 RAID bus controller: HighPoint Technologies, Inc. HPT374 (rev 07)
02:05.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 50)
02:05.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 50)
02:05.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)

full dmesg:

Linux version 2.6.25-rc9-120408 (root@xxx) (gcc version 4.2.3 20071123
(prerelease) (Debian 4.2.2-4)) #1 Sat Apr 12 21:29:30 EEST 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
Entering add_active_range(0, 0, 229376) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   229376
On node 0 totalpages: 229376
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  Movable zone: 0 pages used for memmap
DMI 2.2 present.
ACPI: RSDP 000F7330, 0014 (r0 IntelR)
ACPI: RSDT 3FFF3000, 002C (r1 IntelR AWRDACPI 42302E31 AWRD        0)
ACPI: FACP 3FFF3040, 0074 (r1 IntelR AWRDACPI 42302E31 AWRD        0)
ACPI: DSDT 3FFF30C0, 4346 (r1 INTELR AWRDACPI     1000 MSFT  100000C)
ACPI: FACS 3FFF0000, 0040
ACPI: APIC 3FFF7440, 005A (r1 IntelR AWRDACPI 42302E31 AWRD        0)
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 227584
Kernel command line: root=/dev/hda2 ro
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2403.126 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 902796k/917504k available (2428k kernel code, 14076k reserved,
1051k data, 204k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xffff6000 - 0xfffff000   (  36 kB)
    vmalloc : 0xf8800000 - 0xffff4000   ( 119 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc046a000 - 0xc049d000   ( 204 kB)
      .data : 0xc035f2f8 - 0xc0466260   (1051 kB)
      .text : 0xc0100000 - 0xc035f2f8   (2428 kB)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
CPA: page pool initialized 1 of 1 pages preallocated
Calibrating delay using timer specific routine.. 4809.64 BogoMIPS (lpj=9619296)
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 0k freed
ACPI: Core revision 20070126
ACPI: setting ELCR to 0200 (from 1eb8)
net_namespace: 440 bytes
xor: automatically using best checksumming function: pIII_sse
   pIII_sse  :  3165.000 MB/sec
xor: using function: pIII_sse (3165.000 MB/sec)
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb230, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S5)
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
* The chipset may have PM-Timer Bug. Due to workarounds for a bug,
* this clock source is slow. If you are sure your timer does not have
* this bug, please use "acpi_pm_good" to disable the workaround
pci 0000:00:1f.0: quirk: region 0400-047f claimed by ICH4 ACPI/GPIO/TCO
pci 0000:00:1f.0: quirk: region 0480-04bf claimed by ICH4 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 9 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
system 00:02: ioport range 0x400-0x4bf could not be reserved
system 00:03: ioport range 0xb78-0xb7b has been reserved
system 00:03: ioport range 0xf78-0xf7b has been reserved
system 00:03: ioport range 0xa78-0xa7b has been reserved
system 00:03: ioport range 0xe78-0xe7b has been reserved
system 00:03: ioport range 0xbbc-0xbbf has been reserved
system 00:03: ioport range 0xfbc-0xfbf has been reserved
system 00:03: ioport range 0x4d0-0x4d1 has been reserved
system 00:03: ioport range 0x290-0x29f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: 0xe2000000-0xe3ffffff
  PREFETCH window: 0x00000000e0000000-0x00000000e1ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 8000-cfff
  MEM window: 0xe4000000-0xe5ffffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Unpacking initramfs... done
Freeing initrd memory: 2152k freed
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
fuse init (API version 7.9)
async_tx: api initialized (sync-only)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci 0000:01:00.0: Boot video device
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
ACPI: PNP0C0B:00 is registered as cooling_device0
ACPI: Fan [FAN] (on)
ACPI: ACPI0007:00 is registered as cooling_device1
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI: LNXTHERM:01 is registered as thermal_zone0
ACPI: Thermal Zone [THRM] (46 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux agpgart interface v0.103
agpgart: Detected an Intel 845G Chipset.
agpgart: AGP aperture is 4M @ 0xe6000000
floppy0: no floppy controllers found
8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
8139cp 0000:02:06.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
8139cp 0000:02:06.0: Try the "8139too" driver instead.
8139too Fast Ethernet driver 0.9.28
ACPI: PCI Interrupt Link [LNK0] enabled at IRQ 7
PCI: setting IRQ 7 as level-triggered
ACPI: PCI Interrupt 0000:02:06.0[A] -> Link [LNK0] -> GSI 7 (level,
low) -> IRQ 7
eth0: RealTek RTL8139 at 0xcc00, 00:50:8d:fd:04:01, IRQ 7
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Uniform Multi-Platform E-IDE driver
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller (0x8086:0x24cb rev 0x01) at  PCI slot 0000:00:1f.1
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 12 (level,
low) -> IRQ 12
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:PIO
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:PIO, hdd:PIO
Probing IDE interface ide0...
hda: HDS728080PLAT20, ATA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
Probing IDE interface ide1...
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
HPT374: IDE controller (0x1103:0x0008 rev 0x07) at  PCI slot 0000:02:04.0
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [LNKE] -> GSI 10 (level,
low) -> IRQ 10
HPT374: DPLL base: 48 MHz, f_CNT: 150, assuming 33 MHz PCI
HPT374: using 50 MHz DPLL clock
HPT374: 100% native mode on irq 10
ACPI: PCI Interrupt 0000:02:04.1[A] -> Link [LNKE] -> GSI 10 (level,
low) -> IRQ 10
HPT374: DPLL base: 48 MHz, f_CNT: 150, assuming 33 MHz PCI
HPT374: using 50 MHz DPLL clock
    ide2: BM-DMA at 0xac00-0xac07, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xac08-0xac0f, BIOS settings: hdg:DMA, hdh:DMA
    ide4: BM-DMA at 0xc000-0xc007, BIOS settings: hdi:PIO, hdj:PIO
    ide5: BM-DMA at 0xc008-0xc00f, BIOS settings: hdk:PIO, hdl:PIO
Probing IDE interface ide2...
hde: Maxtor 6B200P0, ATA DISK drive
hdf: IC35L180AVV207-1, ATA DISK drive
hde: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hde: UDMA/100 mode selected
hdf: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdf: UDMA/100 mode selected
Probing IDE interface ide3...
hdg: ST3160021A, ATA DISK drive
hdh: ST3200822A, ATA DISK drive
hdg: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdg: UDMA/100 mode selected
hdh: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdh: UDMA/100 mode selected
Probing IDE interface ide4...
Probing IDE interface ide5...
ide2 at 0x9c00-0x9c07,0xa002 on irq 10
ide3 at 0xa400-0xa407,0xa802 on irq 10
Probing IDE interface ide1...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 512KiB
hda: 160836480 sectors (82348 MB) w/1719KiB Cache, CHS=16383/255/63
hda: cache flushes supported
 hda: hda1 < hda5 > hda2 hda3
hde: max request size: 512KiB
hde: 398297088 sectors (203928 MB) w/8192KiB Cache, CHS=24792/255/63
hde: cache flushes supported
 hde: unknown partition table
hdf: max request size: 512KiB
hdf: 361882080 sectors (185283 MB) w/7965KiB Cache, CHS=22526/255/63
hdf: cache flushes supported
 hdf: unknown partition table
hdg: max request size: 512KiB
hdg: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63
hdg: cache flushes supported
 hdg: unknown partition table
hdh: max request size: 512KiB
hdh: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
hdh: cache flushes supported
 hdh: unknown partition table
Driver 'sd' needs updating - please use bus_type methods
sata_promise 0000:02:02.0: version 2.12
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKC] -> GSI 12 (level,
low) -> IRQ 12
scsi0 : sata_promise
scsi1 : sata_promise
scsi2 : sata_promise
ata1: SATA max UDMA/133 mmio m4096@0xe51c5000 port 0xe51c5200 irq 12
ata2: SATA max UDMA/133 mmio m4096@0xe51c5000 port 0xe51c5280 irq 12
ata3: PATA max UDMA/133 mmio m4096@0xe51c5000 port 0xe51c5300 irq 12
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
ata1.00: 390721968 sectors, multi 0: LBA48
ata1.00: configured for UDMA/133
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: ST3300831AS, 3.01, max UDMA/133
ata2.00: 586072368 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/133
ata3.00: ATA-7: SAMSUNG SP1604N, TM100-24, max UDMA/100
ata3.00: 312581808 sectors, multi 0: LBA48
ata3.00: limited to UDMA/33 due to 40-wire cable
ata3.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      ST3300831AS      3.01 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG SP1604N  TM10 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 2:0:0:0: [sdc] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdc: sdc1
sd 2:0:0:0: [sdc] Attached SCSI disk
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:03.0[A] -> Link [LNKD] -> GSI 5 (level,
low) -> IRQ 5
scsi3 : sata_promise
scsi4 : sata_promise
scsi5 : sata_promise
scsi6 : sata_promise
ata4: SATA max UDMA/133 mmio m4096@0xe51c4000 port 0xe51c4380 irq 5
ata5: SATA max UDMA/133 mmio m4096@0xe51c4000 port 0xe51c4280 irq 5
ata6: SATA max UDMA/133 mmio m4096@0xe51c4000 port 0xe51c4200 irq 5
ata7: SATA max UDMA/133 mmio m4096@0xe51c4000 port 0xe51c4300 irq 5
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-8: WDC WD1000FYPS-01ZKB0, 02.01B01, max UDMA/133
ata4.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/133
ata5: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)
ata7: SATA link down (SStatus 0 SControl 300)
scsi 3:0:0:0: Direct-Access     ATA      WDC WD1000FYPS-0 02.0 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 3:0:0:0: [sdd] 1953525168 512-byte hardware sectors (1000205 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdd: sdd1
sd 3:0:0:0: [sdd] Attached SCSI disk
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [LNK1] -> GSI 9 (level,
low) -> IRQ 9
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 9, io mem 0xe6400000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:02:05.2[C] -> Link [LNKF] -> GSI 4 (level,
low) -> IRQ 4
ehci_hcd 0000:02:05.2: EHCI Host Controller
ehci_hcd 0000:02:05.2: new USB bus registered, assigned bus number 2
ehci_hcd 0000:02:05.2: irq 4, io mem 0xe51c6000
ehci_hcd 0000:02:05.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 appears to have AUX port disabled, if this is incorrect
please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input2
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
raid6: int32x1    622 MB/s
raid6: int32x2    577 MB/s
raid6: int32x4    710 MB/s
raid6: int32x8    516 MB/s
raid6: mmxx1     1997 MB/s
raid6: mmxx2     2071 MB/s
raid6: sse1x1    1013 MB/s
raid6: sse1x2    1900 MB/s
raid6: sse2x1    2070 MB/s
raid6: sse2x2    2496 MB/s
raid6: using algorithm sse2x2 (2496 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised: dm-devel@redhat.com
cpuidle: using governor ladder
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (14336 buckets, 57344 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
arp_tables: (C) 2002 David S. Miller
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Using IPI Shortcut mode
Freeing unused kernel memory: 204k freed
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [LNKB] -> GSI 3 (level,
low) -> IRQ 3
3c59x: Donald Becker and others.
0000:02:01.0: 3Com PCI 3c905B Cyclone 100baseTx at f881a000.
md: md0 stopped.
md: bind<sdb1>
raid5: device sdb1 operational as raid disk 2
raid5: not enough operational devices for md0 (3/4 failed)
RAID5 conf printout:
 --- rd:4 wd:1
 disk 2, o:1, dev:sdb1
raid5: failed to run raid set md0
md: pers->run() failed ...
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1951824k swap on /dev/hda5.  Priority:-1 extents:1 across:1951824k
EXT3 FS on hda2, internal journal
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: sda1: found reiserfs format "3.6" with standard journal
ReiserFS: sda1: using ordered data mode
ReiserFS: sda1: journal params: device sda1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda1: checking transaction log (sda1)
ReiserFS: sda1: Using r5 hash to sort names
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth1:  setting full-duplex.
warning: `dnsmasq' uses 32-bit capabilities (legacy support in use)
svc: 127.0.0.1, port=54195: unknown version (3 for prog 100003, nfsd)
