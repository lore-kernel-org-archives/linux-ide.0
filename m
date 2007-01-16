From: Jan Gutter <jangutter@gmail.com>
Subject: Re: ICH7m problem using libata
Date: Tue, 16 Jan 2007 13:31:45 +0200
Message-ID: <1168947105.14636.11.camel@laundromat.jangutter.com>
References: <1165253799.16504.37.camel@laundromat.jangutter.com>
	 <200701100817.28738.matthew4196@gmail.com> <45AB0F07.5020705@gmail.com>
	 <200701160958.33561.matthew4196@gmail.com>  <45AC933B.1000201@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-qf2oXkogm+dftBTG5SeV"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:42173 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbXAPLcB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jan 2007 06:32:01 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1643276uga
        for <linux-ide@vger.kernel.org>; Tue, 16 Jan 2007 03:31:59 -0800 (PST)
In-Reply-To: <45AC933B.1000201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matthew Stapleton <matthew4196@gmail.com>, linux-ide@vger.kernel.org


--=-qf2oXkogm+dftBTG5SeV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-01-16 at 17:56 +0900, Tejun Heo wrote:
> Matthew Stapleton wrote:
> > Tejun Heo wrote:
> >> Does the problem still persist?

Sorry for the delayed reply: Holidays attacked before I could apply the
patch. 

> I got confused between your report and Jan's.  Yours (not so sure about
> Jan's) seems to be drive firmware bug which hald was successful to
> undiscover.  Does hald clear CDO_USE_FFLAGS using ioctl
> CDROM_CLEAR_OPTIONS?  The failed commands seem to be from cdrom
> open_for_data().  Considering general quality of ATAPI devices, I
> wouldn't be too surprised if some device fails after hours of repeated
> poll sequence containing READ_TOC and ALLOW_MEDIUM_REMOVAL.

Hmmm. I think I might have slightly different symptoms: Heavy disk use
definitely causes the bug to appear more frequently. Compiling often
causes it to kick in after about 15 minutes. I also get slightly
different error messages.

With the latest patch set (2.6.19-gentoo-r4 + cocktail) the resets still
occur, but at least the drive doesn't go down to PIO so soon anymore.
I'll keep watching it for the rest of the day. Attached dmesg of the
first hour or so. (If Evolution borks this mail, I'll resort to telnet and 
SMTP ;-)

Thanks for the feedback, and hope the sucker gets nailed.

Jan

--=-qf2oXkogm+dftBTG5SeV
Content-Disposition: attachment; filename=cocktail-2.6.19-dmesg.txt
Content-Type: text/plain; name=cocktail-2.6.19-dmesg.txt; charset=utf-8
Content-Transfer-Encoding: 7bit

Linux version 2.6.19-gentoo-r4 (root@wookie) (gcc version 4.1.1 (Gentoo 4.1.1-r3)) #1 SMP PREEMPT Tue Jan 16 12:05:48 SAST 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fe90000 (usable)
 BIOS-e820: 000000003fe90000 - 000000003ff00000 (ACPI NVS)
 BIOS-e820: 000000003ff00000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
126MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5c80
Entering add_active_range(0, 0, 261776) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   261776
early_node_map[1] active PFN ranges
    0:        0 ->   261776
On node 0 totalpages: 261776
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 253 pages used for memmap
  HighMem zone: 32147 pages, LIFO batch:7
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f5ae0
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x3fe9515a
ACPI: FADT (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x3fe9ddee
ACPI: MADT (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x3fe9de62
ACPI: HPET (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x3fe9deca
ACPI: MCFG (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x3fe9df02
ACPI: TCPA (v001 PTLTD  CALISTGA 0x06040000  PTL 0x00000001) @ 0x3fe9df3e
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x3fe9df70
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x3fe9dfd8
ACPI: SSDT (v001 SataRe  SataPri 0x00001000 INTL 0x20050624) @ 0x3fe96862
ACPI: SSDT (v001 SataRe  SataSec 0x00001000 INTL 0x20050624) @ 0x3fe961d0
ACPI: SSDT (v001  PmRef  Cpu0Tst 0x00003000 INTL 0x20050624) @ 0x3fe9573a
ACPI: SSDT (v001  PmRef  Cpu1Tst 0x00003000 INTL 0x20050624) @ 0x3fe95694
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624) @ 0x3fe951ae
ACPI: DSDT (v001 INTEL  CALISTGA 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: 2 duplicate APIC table ignored.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfec28000] gsi_base[24])
IOAPIC[1]: apic_id 2, version 255, address 0xfec28000, GSI 24-279
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Detected 1662.718 MHz processor.
Built 1 zonelists.  Total pages: 259731
Kernel command line: root=/dev/ram0 init=/linuxrc ramdisk=8192 real_root=/dev/sda7 udev video=vesafb:ywrap,1440x900-24@65 combined_mode=libata
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec28000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1024416k/1047104k available (2910k kernel code, 21964k reserved, 1419k data, 256k init, 129600k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc05a0000 - 0xc05e0000   ( 256 kB)
      .data : 0xc03d7bb1 - 0xc053aaf4   (1419 kB)
      .text : 0xc0100000 - 0xc03d7bb1   (2910 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Using HPET for base-timer
Calibrating delay using timer specific routine.. 3328.76 BogoMIPS (lpj=1664383)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e39d 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000940 0000e39d 00000000 00000001
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 16k freed
ACPI: Core revision 20060707
CPU0: Intel(R) Core(TM)2 CPU         T5500  @ 1.66GHz stepping 06
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3325.37 BogoMIPS (lpj=1662688)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e39d 00000000 00000001
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000940 0000e39d 00000000 00000001
CPU1: Intel(R) Core(TM)2 CPU         T5500  @ 1.66GHz stepping 06
Total of 2 processors activated (6654.14 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=44
checking if image is initramfs... it is
Freeing initrd memory: 7411k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #0b (-#0e) is hidden behind transparent bridge #0a (-#0a) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 *11)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
libata version 2.00 loaded.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:07: ioport range 0x6a0-0x6af has been reserved
pnp: 00:07: ioport range 0x6b0-0x6ff has been reserved
PCI: Failed to allocate mem resource #6:20000@c0000000 for 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: d0000000-d1ffffff
  PREFETCH window: b0000000-bfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: 2000-2fff
  MEM window: c8000000-c9ffffff
  PREFETCH window: c0000000-c1ffffff
PCI: Bridge: 0000:00:1c.1
  IO window: 3000-3fff
  MEM window: ca000000-cbffffff
  PREFETCH window: c2000000-c3ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 4000-4fff
  MEM window: cc000000-cdffffff
  PREFETCH window: c4000000-c5ffffff
PCI: Bridge: 0000:00:1c.3
  IO window: 5000-5fff
  MEM window: ce000000-cfffffff
  PREFETCH window: c6000000-c7ffffff
PCI: Bus 11, cardbus bridge: 0000:0a:06.0
  IO window: 00006000-000060ff
  IO window: 00006400-000064ff
  PREFETCH window: 50000000-51ffffff
  MEM window: 52000000-53ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 6000-6fff
  MEM window: d2000000-d20fffff
  PREFETCH window: 50000000-51ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
PCI: Enabling device 0000:00:1e.0 (0104 -> 0107)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:0a:06.0[A] -> GSI 22 (level, low) -> IRQ 20
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
cpufreq: No nForce2 chipset.
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
audit: initializing netlink socket (disabled)
audit(1168951397.737:1): initialized
highmem bounce pool size: 64 pages
SGI XFS with ACLs, security attributes, realtime, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
Allocate Port Service[0000:00:1c.3:pcie03]
toshiba: not a supported Toshiba laptop
vesafb: NVIDIA Corporation, G72 Board - e463h0v , Chip Rev    (OEM: NVIDIA)
vesafb: VBE version: 3.0
vesafb: protected mode interface info at c000:d4f0
vesafb: pmi: set display start = c00cd526, set palette = c00cd590
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
vesafb: VBIOS/hardware doesn't support DDC transfers
vesafb: no monitor limits have been set
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
Console: switching to colour frame buffer device 128x48
vesafb: framebuffer at 0xb0000000, mapped to 0xf8880000, using 6144k, total 131072k
fb0: VESA VGA frame buffer device
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Thermal Zone [TZS0] (48 C)
ACPI: Thermal Zone [TZS1] (49 C)
ibm_acpi: ec object not found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
ata_piix 0000:00:1f.2: version 2.00ac6
ata_piix 0000:00:1f.2: MAP [ IDE IDE P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: PATA max UDMA/100:PIO4 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
ata2: SATA max UDMA/133:PIO4 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
scsi0 : ata_piix
ata1.00: ATA-6, max UDMA/100:PIO4, 234441648 sectors: LBA48 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATAPI, max UDMA/33:PIO4
ata1.00: configured for UDMA/100:PIO0
ata1.01: configured for UDMA/33:PIO0
scsi1 : ata_piix
ATA: abnormal status 0x7F on port 0x177
scsi 0:0:0:0: Direct-Access     ATA      TOSHIBA MK1234GA AC00 PQ: 0 ANSI: 5
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
scsi 0:0:1:0: CD-ROM            TSSTcorp CD/DVDW TS-L632D ac00 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
PNP: PS/2 Controller [PNP0303:KBD0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.2)
padlock: No VIA PadLock drivers have been loaded.
padlock: VIA PadLock not detected.
padlock: VIA PadLock Hash Engine not detected.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
Time: tsc clocksource has been installed.
Freeing unused kernel memory: 256k freed
Time: hpet clocksource has been installed.
ata1: soft resetting port
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xd2304000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
Initializing USB Mass Storage driver...
ata1.00: configured for UDMA/100:PIO0
usb 1-7: new high speed USB device using ehci_hcd and address 2
ata1.01: configured for UDMA/33:PIO0
ata1: EH complete
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
usb 1-7: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 21, io base 0x00001800
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001820
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x12a0b1, caps: 0xa04713/0x204000
input: SynPS/2 Synaptics TouchPad as /class/input/input1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
sl811: driver sl811-hcd, 19 May 2005
ieee1394: Initialized config rom entry `ip1394'
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
JFS: nTxBlock = 8065, nTxLock = 64527
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x12a0b1, caps: 0xa04713/0x204000
input: SynPS/2 Synaptics TouchPad as /class/input/input2
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
input: PC Speaker as /class/input/input3
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, 1.2.16
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ACPI: PCI Interrupt 0000:0a:06.2[A] -> GSI 22 (level, low) -> IRQ 20
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Identified chip type is 'RTL8168B/8111B'.
eth0: r10001.04, the Linux device driver for Realtek Ethernet Controllers at 0x2000, 00:16:d3:47:66:2e, IRQ 16
ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux, 1.2.0d
ipw3945: Copyright(c) 2003-2006 Intel Corporation
sdhci: Secure Digital Host Controller Interface driver, 0.12
sdhci: Copyright(c) Pierre Ossman
nvidia: module license 'NVIDIA' taints kernel.
Realtek RTL8168/8111 Family PCI-E Gigabit Ethernet Network Adapter
Driver version:1.04
Released date:2006/07/07
Link Status:Linked
Link Speed:100Mbps
Duplex mode:Full-Duplex
I/O Base:0x2000(I/O port)
IRQ:16
Yenta: CardBus bridge found at 0000:0a:06.0 [1025:0107]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:0a:06.0, mfunc 0x01aa1b22, devctl 0x64
Yenta: ISA IRQ mask 0x0cf8, PCI irq 20
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#0a) from #0a to #0e
pcmcia: parent PCI bridge I/O window: 0x6000 - 0x6fff
pcmcia: parent PCI bridge Memory window: 0xd2000000 - 0xd20fffff
pcmcia: parent PCI bridge Memory window: 0x50000000 - 0x51ffffff
sdhci: SDHCI controller found at 0000:0a:06.3 [104c:803c] (rev 0)
ACPI: PCI Interrupt 0000:0a:06.3[A] -> GSI 22 (level, low) -> IRQ 20
mmc0: SDHCI at 0xd2005800 irq 20 PIO
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:05:00.0 to 64
ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:01:00.0 to 64
NVRM: loading NVIDIA UNIX x86 Kernel Module  1.0-9746  Fri Dec 15 09:54:45 PST 2006
EXT3 FS on sda7, internal journal
fuse init (API version 7.8)
fuse distribution version: 2.6.1
Adding 2104472k swap on /dev/sda6.  Priority:-1 extents:1 across:2104472k
Real Time Clock Driver v1.12ac
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ipw3945: Error sending SCAN_ABORT_CMD: time out after 500ms.
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.01: (BMDMA stat 0x60)
ata1.01: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1: soft resetting port
ata1.00: configured for UDMA/100:PIO0
ata1.01: configured for UDMA/33:PIO0
ata1: EH complete
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.01: (BMDMA stat 0x60)
ata1.01: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1: soft resetting port
ata1.00: configured for UDMA/100:PIO0
ata1.01: configured for UDMA/33:PIO0
ata1: EH complete
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.01: (BMDMA stat 0x60)
ata1.01: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: port failed to respond (30 secs, Status 0xd0)
ata1: soft resetting port
ata1.00: configured for UDMA/100:PIO0
ata1.01: configured for UDMA/33:PIO0
ata1: EH complete
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back

--=-qf2oXkogm+dftBTG5SeV--

