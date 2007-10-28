From: Carsten Otto <c-otto@gmx.de>
Subject: Re: [2.6.23-rc3] Regression: "spurious completions during NCQ"
Date: Sun, 28 Oct 2007 21:53:28 +0100
Message-ID: <20071028205328.GD32184@server.c-otto.de>
References: <20070922131104.GG32509@server.c-otto.de> <471F1BEC.2060701@gmail.com>
Reply-To: Carsten Otto <c-otto@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:59897 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751109AbXJ1Uxd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Oct 2007 16:53:33 -0400
Content-Disposition: inline
In-Reply-To: <471F1BEC.2060701@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: multipart/mixed; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2007 at 06:18:20AM -0400, Tejun Heo wrote:
> Please post dmesg including full boot log and error messages and the resu=
lt=20
> of 'hdparm -I /dev/sdX' where sdX are drives which cause such errors.

Attached. The other disks (sda, sdb, sdd) have the same information, but
different serial numbers of course.

Thanks for your time,
--=20
Carsten Otto
c-otto@gmx.de
www.c-otto.de

--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.23.1 (root@server.c-otto.de) (gcc version 4.2.1 (Debian 4=
=2E2.1-3)) #1 SMP Sun Oct 28 14:21:11 CET 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000e7f80000 (usable)
 BIOS-e820: 00000000e7f80000 - 00000000e7f8e000 (ACPI data)
 BIOS-e820: 00000000e7f8e000 - 00000000e7fe0000 (ACPI NVS)
 BIOS-e820: 00000000e7fe0000 - 00000000e8000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
2815MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
NX (Execute Disable) protection: active
Entering add_active_range(0, 0, 950144) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   950144
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   950144
On node 0 totalpages: 950144
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 5631 pages used for memmap
  HighMem zone: 715137 pages, LIFO batch:31
  Movable zone: 0 pages used for memmap
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP 000FA960, 0024 (r2 ACPIAM)
ACPI: XSDT E7F80100, 0044 (r1 A M I  OEMXSDT   3000620 MSFT       97)
ACPI: FACP E7F80290, 00F4 (r3 A M I  OEMFACP   3000620 MSFT       97)
ACPI: DSDT E7F80400, 81D2 (r1  A0228 A0228000        0 INTL  2002026)
ACPI: FACS E7F8E000, 0040
ACPI: APIC E7F80390, 0070 (r1 A M I  OEMAPIC   3000620 MSFT       97)
ACPI: OEMB E7F8E040, 0066 (r1 A M I  AMI_OEM   3000620 MSFT       97)
ACPI: MCFG E7F885E0, 003C (r1 A M I  OEMMCFG   3000620 MSFT       97)
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at ea000000 (gap: e8000000:17b00000)
Built 1 zonelists in Zone order.  Total pages: 942721
Kernel command line: root=3D/dev/md2
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2676.295 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3762432k/3800576k available (3695k kernel code, 36968k reserved, 17=
23k data, 240k init, 2883072k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff9a000 - 0xfffff000   ( 404 kB)
    pkmap   : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0xf8800000 - 0xffbfe000   ( 115 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0654000 - 0xc0690000   ( 240 kB)
      .data : 0xc049bd04 - 0xc064aa54   (1723 kB)
      .text : 0xc0100000 - 0xc049bd04   (3695 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5357.76 BogoMIPS (lpj=3D10=
715521)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000=
651d 00000000 00000001 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 0000b180 0000651d 00=
000000 00000001 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Parsing all Control Methods:
Table [DSDT](id 0001) - 794 Objects with 55 Devices 212 Methods 26 Regions
 tbxface-0598 [00] tb_load_namespace     : ACPI Tables successfully acquired
evxfevnt-0091 [00] enable                : Transition to ACPI mode successf=
ul
CPU0: Intel(R) Pentium(R) D  CPU 2.66GHz stepping 07
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5352.78 BogoMIPS (lpj=3D10=
705569)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000=
651d 00000000 00000001 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20100000 00000000 0000b180 0000651d 00=
000000 00000001 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) D  CPU 2.66GHz stepping 07
Total of 2 processors activated (10710.54 BogoMIPS).
ENABLING IO-APIC IRQs
=2E.TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
xor: automatically using best checksumming function: pIII_sse
   pIII_sse  :  4285.000 MB/sec
xor: using function: pIII_sse (4285.000 MB/sec)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Found Intel Corporation 945G/GZ/P/PL Express Memory Controller Hub wit=
hout MMCONFIG support.
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3D2
PCI: Using configuration type 1
Setting up standard PCI resources
evgpeblk-0956 [00] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on in=
t 0x9
evgpeblk-1052 [00] ev_initialize_gpe_bloc: Found 11 Wake, Enabled 0 Runtime=
 GPEs in this block
ACPI: EC: Look up EC in DSDT
Completing Region/Field/Buffer/Package initialization:.....................=
=2E........................................................................=
=2E........................................................................=
=2E........
Initialized 20/26 Regions 23/23 Fields 40/40 Buffers 93/95 Packages (803 no=
des)
Initializing Device/Processor/Thermal objects by executing _INI methods:.
Executed 1 _INI methods requiring 0 _STA executions (examined 59 objects)
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] -  08, shou=
ld be 07 [20070126]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 2.21 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
Time: tsc clocksource has been installed.
pnp: 00:01: iomem range 0xfed13000-0xfed19fff has been reserved
pnp: 00:06: ioport range 0x290-0x297 has been reserved
pnp: 00:07: iomem range 0xfed1c000-0xfed1ffff has been reserved
pnp: 00:07: iomem range 0xfed20000-0xfed8ffff has been reserved
pnp: 00:07: iomem range 0xffb00000-0xffbfffff could not be reserved
pnp: 00:07: iomem range 0xfff00000-0xffffffff could not be reserved
pnp: 00:0a: iomem range 0xfec00000-0xfec00fff has been reserved
pnp: 00:0a: iomem range 0xfee00000-0xfee00fff has been reserved
pnp: 00:0b: iomem range 0xf0000000-0xf3ffffff has been reserved
pnp: 00:0c: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:0c: iomem range 0xc0000-0xdffff could not be reserved
pnp: 00:0c: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:0c: iomem range 0x100000-0xe7ffffff could not be reserved
PCI: Bridge: 0000:00:1c.0
  IO window: e000-efff
  MEM window: eff00000-efffffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: d000-dfff
  MEM window: ef000000-efefffff
  PREFETCH window: ea000000-ea0fffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SGI XFS with large block numbers, no debug enabled
async_tx: api initialized (sync-only)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Boot video device is 0000:01:00.0
input: Power Button (FF) as /devices/virtual/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /devices/virtual/input/input1
ACPI: Power Button (CM) [PWRB]
ACPI Warning (tbutils-0217): Incorrect checksum in table [  =C3=B9=C5=A0] -=
  00, should be 55 [20070126]
ACPI Error (tbinstal-0134): Table has invalid signature [  =C3=B9=C5=A0], m=
ust be SSDT, PSDT or OEMx [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU1._PDC] =
(Node c2e312d4), AE_BAD_SIGNATURE
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI Warning (tbutils-0217): Incorrect checksum in table [  =C3=B9=C5=A0] -=
  00, should be 55 [20070126]
ACPI Error (tbinstal-0134): Table has invalid signature [  =C3=B9=C5=A0], m=
ust be SSDT, PSDT or OEMx [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU2._PDC] =
(Node c2e3184c), AE_BAD_SIGNATURE
Real Time Clock Driver v1.12ac
intel_rng: FWH not detected
Linux agpgart interface v0.102
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 6=
0 seconds).
Hangcheck: Using get_cycles().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 0
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:15:17:0=
b:8b:2d
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 17
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP2014N, ATA DISK drive
hda: selected mode 0x45
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 512KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=3D24321/255/63, UDM=
A(100)
hda: cache flushes supported
 hda: hda1
ahci 0000:00:1f.2: version 2.3
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 18
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part=20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xf881ad00 ctl 0x00000000 bmdma 0x00000000 irq =
223
ata2: SATA max UDMA/133 cmd 0xf881ad80 ctl 0x00000000 bmdma 0x00000000 irq =
223
ata3: SATA max UDMA/133 cmd 0xf881ae00 ctl 0x00000000 bmdma 0x00000000 irq =
223
ata4: SATA max UDMA/133 cmd 0xf881ae80 ctl 0x00000000 bmdma 0x00000000 irq =
223
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7: Maxtor 7V300F0, VA111900, max UDMA/133
ata1.00: 586114704 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7: Maxtor 7V300F0, VA111900, max UDMA/133
ata2.00: 586114704 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/133
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7: Maxtor 7V300F0, VA111900, max UDMA/133
ata3.00: 586114704 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata3.00: configured for UDMA/133
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-7: Maxtor 7V300F0, VA111900, max UDMA/133
ata4.00: 586114704 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata4.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 7V300F0   VA11 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 586114704 512-byte hardware sectors (300091 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't suppo=
rt DPO or FUA
sd 0:0:0:0: [sda] 586114704 512-byte hardware sectors (300091 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't suppo=
rt DPO or FUA
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 7V300F0   VA11 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 586114704 512-byte hardware sectors (300091 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 1:0:0:0: [sdb] 586114704 512-byte hardware sectors (300091 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 >
sd 1:0:0:0: [sdb] Attached SCSI disk
scsi 2:0:0:0: Direct-Access     ATA      Maxtor 7V300F0   VA11 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 586114704 512-byte hardware sectors (300091 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 2:0:0:0: [sdc] 586114704 512-byte hardware sectors (300091 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sdc: sdc1 sdc2 sdc3 < sdc5 sdc6 sdc7 >
sd 2:0:0:0: [sdc] Attached SCSI disk
scsi 3:0:0:0: Direct-Access     ATA      Maxtor 7V300F0   VA11 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdd] 586114704 512-byte hardware sectors (300091 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 3:0:0:0: [sdd] 586114704 512-byte hardware sectors (300091 MB)
sd 3:0:0:0: [sdd] Write Protect is off
sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sdd: sdd1 sdd2 sdd3 < sdd5 sdd6 sdd7 >
sd 3:0:0:0: [sdd] Attached SCSI disk
Fusion MPT base driver 3.04.05
Copyright (c) 1999-2007 LSI Logic Corporation
Fusion MPT SPI Host driver 3.04.05
ieee1394: raw1394: /dev/raw1394 device initialized
usbmon: debugfs is not available
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input=
/input2
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 23 (level, low) -> IRQ 18
input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/in=
put/input3
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
raid6: int32x1    643 MB/s
raid6: int32x2    625 MB/s
raid6: int32x4    653 MB/s
raid6: int32x8    537 MB/s
raid6: mmxx1     1353 MB/s
raid6: mmxx2     1854 MB/s
raid6: sse1x1     959 MB/s
raid6: sse1x2    1574 MB/s
raid6: sse2x1    1928 MB/s
raid6: sse2x2    2853 MB/s
raid6: using algorithm sse2x2 (2853 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
oprofile: using NMI interrupt.
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
ctnetlink v0.93: registering with nfnetlink.
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
ip_tables: (C) 2000-2006 Netfilter Core Team
ClusterIP Version 0.8 loaded successfully
arp_tables: (C) 2002 David S. Miller
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
p4-clockmod: P4/Xeon(TM) CPU On-Demand Clock Modulation available
Using IPI No-Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd7 ...
md:  adding sdd7 ...
md: sdd6 has different UUID to sdd7
md: sdd5 has different UUID to sdd7
md: sdd2 has different UUID to sdd7
md: sdd1 has different UUID to sdd7
md:  adding sdc7 ...
md: sdc6 has different UUID to sdd7
md: sdc5 has different UUID to sdd7
md: sdc2 has different UUID to sdd7
md: sdc1 has different UUID to sdd7
md:  adding sdb7 ...
md: sdb6 has different UUID to sdd7
md: sdb5 has different UUID to sdd7
md: sdb2 has different UUID to sdd7
md: sdb1 has different UUID to sdd7
md:  adding sda7 ...
md: sda6 has different UUID to sdd7
md: sda5 has different UUID to sdd7
md: sda2 has different UUID to sdd7
md: sda1 has different UUID to sdd7
md: created md4
md: bind<sda7>
md: bind<sdb7>
md: bind<sdc7>
md: bind<sdd7>
md: running: <sdd7><sdc7><sdb7><sda7>
raid5: device sdd7 operational as raid disk 1
raid5: device sdc7 operational as raid disk 2
raid5: device sdb7 operational as raid disk 3
raid5: device sda7 operational as raid disk 0
raid5: allocated 4211kB for md4
raid5: raid level 5 set md4 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4
 disk 0, o:1, dev:sda7
 disk 1, o:1, dev:sdd7
 disk 2, o:1, dev:sdc7
 disk 3, o:1, dev:sdb7
md: considering sdd6 ...
md:  adding sdd6 ...
md: sdd5 has different UUID to sdd6
md: sdd2 has different UUID to sdd6
md: sdd1 has different UUID to sdd6
md:  adding sdc6 ...
md: sdc5 has different UUID to sdd6
md: sdc2 has different UUID to sdd6
md: sdc1 has different UUID to sdd6
md:  adding sdb6 ...
md: sdb5 has different UUID to sdd6
md: sdb2 has different UUID to sdd6
md: sdb1 has different UUID to sdd6
md:  adding sda6 ...
md: sda5 has different UUID to sdd6
md: sda2 has different UUID to sdd6
md: sda1 has different UUID to sdd6
md: created md3
md: bind<sda6>
md: bind<sdb6>
md: bind<sdc6>
md: bind<sdd6>
md: running: <sdd6><sdc6><sdb6><sda6>
raid1: raid set md3 active with 4 out of 4 mirrors
md: considering sdd5 ...
md:  adding sdd5 ...
md: sdd2 has different UUID to sdd5
md: sdd1 has different UUID to sdd5
md:  adding sdc5 ...
md: sdc2 has different UUID to sdd5
md: sdc1 has different UUID to sdd5
md:  adding sdb5 ...
md: sdb2 has different UUID to sdd5
md: sdb1 has different UUID to sdd5
md:  adding sda5 ...
md: sda2 has different UUID to sdd5
md: sda1 has different UUID to sdd5
md: created md2
md: bind<sda5>
md: bind<sdb5>
md: bind<sdc5>
md: bind<sdd5>
md: running: <sdd5><sdc5><sdb5><sda5>
raid5: device sdd5 operational as raid disk 1
raid5: device sdc5 operational as raid disk 2
raid5: device sdb5 operational as raid disk 3
raid5: device sda5 operational as raid disk 0
raid5: allocated 4211kB for md2
raid5: raid level 5 set md2 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4
 disk 0, o:1, dev:sda5
 disk 1, o:1, dev:sdd5
 disk 2, o:1, dev:sdc5
 disk 3, o:1, dev:sdb5
md: considering sdd2 ...
md:  adding sdd2 ...
md: sdd1 has different UUID to sdd2
md:  adding sdc2 ...
md: sdc1 has different UUID to sdd2
md:  adding sdb2 ...
md: sdb1 has different UUID to sdd2
md:  adding sda2 ...
md: sda1 has different UUID to sdd2
md: created md1
md: bind<sda2>
md: bind<sdb2>
md: bind<sdc2>
md: bind<sdd2>
md: running: <sdd2><sdc2><sdb2><sda2>
raid5: device sdd2 operational as raid disk 1
raid5: device sdc2 operational as raid disk 0
raid5: device sdb2 operational as raid disk 3
raid5: device sda2 operational as raid disk 2
raid5: allocated 4211kB for md1
raid5: raid level 5 set md1 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4
 disk 0, o:1, dev:sdc2
 disk 1, o:1, dev:sdd2
 disk 2, o:1, dev:sda2
 disk 3, o:1, dev:sdb2
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1><sdb1><sda1>
raid1: raid set md0 active with 4 out of 4 mirrors
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 240k freed
Adding 5855416k swap on /dev/md1.  Priority:-1 extents:1 across:5855416k
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md2, internal journal
Filesystem "md3": Disabling barriers, not supported by the underlying device
XFS mounting filesystem md3
Ending clean XFS mount for filesystem: md3
Filesystem "md4": Disabling barriers, not supported by the underlying device
XFS mounting filesystem md4
Ending clean XFS mount for filesystem: md4
XFS mounting filesystem hda1
Ending clean XFS mount for filesystem: hda1
ADDRCONF(NETDEV_UP): eth0: link is not ready
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex, Flow Con=
trol: RX
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
vlan_check_real_dev: ALREADY had VLAN registered
eth0: no IPv6 routers present
eth0.2: no IPv6 routers present
tap0: no IPv6 routers present
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
ata3.00: exception Emask 0x2 SAct 0x1ff80 SErr 0x0 action 0x2 frozen
ata3.00: spurious completions during NCQ issue=3D0x0 SAct=3D0x1ff80 FIS=3D0=
04040a1:00000040
ata3.00: cmd 61/08:38:16:c6:3f/00:00:00:00:00/40 tag 7 cdb 0x0 data 4096 out
         res 40/00:80:76:c6:3f/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/10:40:1e:c6:3f/00:00:00:00:00/40 tag 8 cdb 0x0 data 8192 out
         res 40/00:80:76:c6:3f/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:48:2e:c6:3f/00:00:00:00:00/40 tag 9 cdb 0x0 data 4096 out
         res 40/00:80:76:c6:3f/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:50:36:c6:3f/00:00:00:00:00/40 tag 10 cdb 0x0 data 4096 o=
ut
         res 40/00:80:76:c6:3f/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/10:58:3e:c6:3f/00:00:00:00:00/40 tag 11 cdb 0x0 data 8192 o=
ut
         res 40/00:80:76:c6:3f/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:60:4e:c6:3f/00:00:00:00:00/40 tag 12 cdb 0x0 data 4096 o=
ut
         res 40/00:80:76:c6:3f/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:68:56:c6:3f/00:00:00:00:00/40 tag 13 cdb 0x0 data 4096 o=
ut
         res 40/00:80:76:c6:3f/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/10:70:5e:c6:3f/00:00:00:00:00/40 tag 14 cdb 0x0 data 8192 o=
ut
         res 40/00:80:76:c6:3f/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:78:6e:c6:3f/00:00:00:00:00/40 tag 15 cdb 0x0 data 4096 o=
ut
         res 40/00:80:76:c6:3f/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata3.00: cmd 61/08:80:76:c6:3f/00:00:00:00:00/40 tag 16 cdb 0x0 data 4096 o=
ut
         res 40/00:80:76:c6:3f/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata3: soft resetting port
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: configured for UDMA/133
ata3: EH complete
sd 2:0:0:0: [sdc] 586114704 512-byte hardware sectors (300091 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
 CIFS VFS: Send error in SETFSUnixInfo =3D -5
 CIFS VFS: Send error in SETFSUnixInfo =3D -5

--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sdc.txt"
Content-Transfer-Encoding: quoted-printable


/dev/sdc:

ATA device, with non-removable media
	Model Number:       Maxtor 7V300F0                         =20
	Serial Number:      V605PR7G           =20
	Firmware Revision:  VA111900
Standards:
	Used: ATA/ATAPI-7 T13 1532D revision 0=20
	Supported: 7 6 5 4=20
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  586114704
	device size with M =3D 1024*1024:      286188 MBytes
	device size with M =3D 1000*1000:      300090 MBytes (300 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max =3D 16	Current =3D 16
	Advanced power management level: unknown setting (0x0000)
	Recommended acoustic management value: 192, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6=20
	     Cycle time: min=3D120ns recommended=3D120ns
	PIO: pio0 pio1 pio2 pio3 pio4=20
	     Cycle time: no flow control=3D120ns  IORDY flow control=3D120ns
Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_VERIFY command
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	NOP cmd
	   *	DOWNLOAD_MICROCODE
	    	Advanced Power Management feature set
	    	Power-Up In Standby feature set
	    	SET_FEATURES required to spinup after power up
	    	SET_MAX security extension
	    	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	    	Media Card Pass-Through
	   *	General Purpose Logging feature set
	   *	WRITE_{DMA|MULTIPLE}_FUA_EXT
	   *	64-bit World wide name
	   *	URG for READ_STREAM[_DMA]_EXT
	   *	URG for WRITE_STREAM[_DMA]_EXT
	   *	SATA-I signaling speed (1.5Gb/s)
	   *	SATA-II signaling speed (3.0Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Data Tables (AC5)
Security:=20
	Master password revision code =3D 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
Checksum: correct

--47eKBCiAZYFK5l32--

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHJPbHjUF4jpCSQBQRAtPnAJ9Gc63S/pG7yEbz3Ec/5qL57oCeagCgs/ru
csDzEWdHr+Iwup0S08811Fk=
=C9fb
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
