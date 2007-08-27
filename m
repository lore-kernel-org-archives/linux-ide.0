From: Izik Weksler <iweksler@bezeqint.net>
Subject: Re: Fwd: Re: libata pmp support
Date: Mon, 27 Aug 2007 20:19:27 +0300
Message-ID: <200708272019.27962.iweksler@bezeqint.net>
References: <200708241951.45684.iweksler@bezeqint.net> <200708261836.56416.iweksler@bezeqint.net> <46D229B1.4070409@gmail.com>
Reply-To: iweksler@bezeqint.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_few0GeWyDIkbcQA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sa7.bezeqint.net ([192.115.104.21]:40685 "EHLO sa7.bezeqint.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756889AbXH0RTo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Aug 2007 13:19:44 -0400
In-Reply-To: <46D229B1.4070409@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

--Boundary-00=_few0GeWyDIkbcQA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



 >>>On Monday 27 August 2007, Tejun Heo wrote:
> Izik Weksler wrote:
> >  >>>On Saturday 25 August 2007, Tejun Heo wrote:
> >>
> >> Izik Weksler wrote:
> >>> ----------  Forwarded Message  ----------
> >>>
> >>> Subject: Re: libata pmp support
> >>> Date: Thursday 23 August 2007
> >>> From: Izik Weksler <iweksler@bezeqint.net>
> >>> To: Tejun Heo <htejun@gmail.com>
> >>>
> >>>  >>>On Thursday 23 August 2007, you wrote:
> >>>>
> >>>> Izik Weksler wrote:
> >>>>> Tejun,
> >>>>>
> >>>>> If you're sending the patch please send it to this address.
> >>>>
> >>>> Okay, please test the attached patch and please cc
> >>>> linux-ide@vger.kernel.org when replying.  Thanks.
> >>>
> >>> Tejun,
> >>>
> >>> The patch failed. It sais:
> >>
> >> Against which version?  The patch will apply to 2.6.22.5 & 2.6.23-rcX
> >> w/o the PMP patches.
> >
> > Yeah. I realized that it applies to a version that doesn't contain pmp
> > support. I tried to apply it to the 2.6.22.2-3 that goes with the SUSE
> > 10.3 and of course it failed because it is pmp patched.
> > So you suggest that I use the 2.6.22.5 vanilla from the www.kernel.org?
> > If not please send me a link to the applicable version.
>
> Yeap, please apply against vanilla kernels.  Thanks.

OK. Here is the dmesg output (dmesg.txt).
Concerning things being faster, I'll investigate it a bit further and give you  
specific indications later.

Isaac

--Boundary-00=_few0GeWyDIkbcQA
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg.txt"

Linux version 2.6.22.5-default (root@dosa02) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #1 SMP Sun Aug 26 19:56:50 IDT 2007
Command line: root=/dev/sda2 vga=0x317 resume=/dev/sda5 splash=silent elevator=
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 000000003ff8e000 (ACPI data)
 BIOS-e820: 000000003ff8e000 - 000000003ffe0000 (ACPI NVS)
 BIOS-e820: 000000003ffe0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 262016) 1 entries of 3200 used
end_pfn_map = 1048576
DMI 2.4 present.
ACPI: RSDP 000FAF20, 0024 (r2 ACPIAM)
ACPI: XSDT 3FF80100, 004C (r1 A_M_I_ OEMXSDT   7000724 MSFT       97)
ACPI: FACP 3FF80290, 00F4 (r3 A_M_I_ OEMFACP   7000724 MSFT       97)
ACPI: DSDT 3FF80590, 9560 (r1  A0543 A0543000        0 INTL 20060113)
ACPI: FACS 3FF8E000, 0040
ACPI: APIC 3FF80390, 0080 (r1 A_M_I_ OEMAPIC   7000724 MSFT       97)
ACPI: OEMB 3FF8E040, 0066 (r1 A_M_I_ AMI_OEM   7000724 MSFT       97)
ACPI: HPET 3FF89AF0, 0038 (r1 A_M_I_ OEMHPET   7000724 MSFT       97)
ACPI: MCFG 3FF89B30, 003C (r1 A_M_I_ OEMMCFG   7000724 MSFT       97)
No NUMA configuration found
Faking a node at 0000000000000000-000000003ff80000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 262016) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000003ff80000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   262016
On node 0 totalpages: 261919
  DMA zone: 56 pages used for memmap
  DMA zone: 1295 pages reserved
  DMA zone: 2648 pages, LIFO batch:0
  DMA32 zone: 3526 pages used for memmap
  DMA32 zone: 254394 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000e4000
swsusp: Registered nosave memory region: 00000000000e4000 - 0000000000100000
Allocating PCI resources starting at 50000000 (gap: 40000000:bfb00000)
SMP: Allowing 4 CPUs, 2 hotplug CPUs
PERCPU: Allocating 50568 bytes of per cpu data
Built 1 zonelists.  Total pages: 257042
Kernel command line: root=/dev/sda2 vga=0x317 resume=/dev/sda5 splash=silent elevator=
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Detected 2403.067 MHz processor.
Console: colour dummy device 80x25
Checking aperture...
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Memory: 1024420k/1048064k available (2223k kernel code, 23256k reserved, 967k data, 324k init)
Calibrating delay using timer specific routine.. 4809.46 BogoMIPS (lpj=9618925)
Security Framework v1.0.0 initialized
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM2)
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 18773948
Detected 18.773 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4806.32 BogoMIPS (lpj=9612659)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
Intel(R) Core(TM)2 CPU          6400  @ 2.13GHz stepping 06
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
migration_cost=19
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 16 devices
ACPI: ACPI bus type pnp unregistered
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-GART: No AMD northbridge found.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
ACPI: RTC can wake from S4
pnp: 00:01: iomem range 0xfed13000-0xfed19fff has been reserved
pnp: 00:07: ioport range 0x290-0x297 has been reserved
pnp: 00:08: iomem range 0xfed1c000-0xfed1ffff has been reserved
pnp: 00:08: iomem range 0xfed20000-0xfed3ffff has been reserved
pnp: 00:08: iomem range 0xfed50000-0xfed8ffff has been reserved
pnp: 00:08: iomem range 0xffb00000-0xffbfffff could not be reserved
pnp: 00:0c: iomem range 0xfec00000-0xfec00fff has been reserved
pnp: 00:0c: iomem range 0xfee00000-0xfee00fff could not be reserved
pnp: 00:0e: iomem range 0xf0000000-0xf3ffffff has been reserved
pnp: 00:0f: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:0f: iomem range 0xc0000-0xdffff has been reserved
pnp: 00:0f: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:0f: iomem range 0x100000-0x3fffffff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: ff900000-ff9fffff
  PREFETCH window: cff00000-efefffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: cfe00000-cfefffff
PCI: Bridge: 0000:00:1c.3
  IO window: b000-bfff
  MEM window: ff800000-ff8fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: a000-afff
  MEM window: ff700000-ff7fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
  IO window: 9000-9fff
  MEM window: ff600000-ff6fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: ff500000-ff5fffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.4 to 64
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
Time: tsc clocksource has been installed.
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Unpacking initramfs... done
Freeing initrd memory: 3434k freed
audit: initializing netlink socket (disabled)
audit(1188161718.488:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler cfq registered (default)
Boot video device is 0000:06:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie00]
vesafb: framebuffer at 0xd0000000, mapped to 0xffffc20000600000, using 3072k, total 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
hpet_resources: 0xfed00000 is busy
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0d: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
netconsole: not configured, aborting
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
NET: Registered protocol family 1
Freeing unused kernel memory: 324k freed
Write protecting the kernel read-only data: 632k
SCSI subsystem initialized
libata version 2.21 loaded.
ahci 0000:00:1f.2: version 2.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 23
input: ImExPS/2 Logitech MX Mouse as /class/input/input1
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: enabling ASUS on-board PMP workaround
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xffffc2000018a900 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 4346
ata2: SATA max UDMA/133 cmd 0xffffc2000018a980 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 4346
ata3: SATA max UDMA/133 cmd 0xffffc2000018aa00 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 4346
ata4: SATA max UDMA/133 cmd 0xffffc2000018aa80 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 4346
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7: WDC WD2500YD-01NVB1, 10.02E01, max UDMA/133
ata1.00: 490234752 sectors, multi 16: LBA48 NCQ (depth 1)
ata1.00: configured for UDMA/133
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-6: Config  Disk, RGL10364, max UDMA/133
ata2.00: 640 sectors, multi 1: LBA 
ata2.00: configured for UDMA/133
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-6: ST3160827AS, 3.42, max UDMA/133
ata3.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata3.00: configured for UDMA/133
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500YD-01N 10.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 490234752 512-byte hardware sectors (251000 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      Config  Disk     RGL1 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 640 512-byte hardware sectors (0 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 640 512-byte hardware sectors (0 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdb: unknown partition table
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:0:0: Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
sd 2:0:0:0: [sdc] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sdc] 312581808 512-byte hardware sectors (160042 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1 sdc2
sd 2:0:0:0: [sdc] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg2 type 0
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
PCI: Setting latency timer of device 0000:02:00.0 to 64
scsi4 : ahci
scsi5 : ahci
ata5: SATA max UDMA/133 cmd 0xffffc200005e4100 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 17
ata6: SATA max UDMA/133 cmd 0xffffc200005e4180 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 17
ata5: SATA link down (SStatus 0 SControl 300)
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATAPI: Optiarc DVD RW AD-7173S, 1-02, max UDMA/66
ata6.00: configured for UDMA/66
scsi 5:0:0:0: CD-ROM            Optiarc  DVD RW AD-7173S  1-02 PQ: 0 ANSI: 5
scsi 5:0:0:0: Attached scsi generic sg3 type 5
ata_piix 0000:00:1f.1: version 2.11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi6 : ata_piix
scsi7 : ata_piix
sr0: scsi3-mmc drive: 125x/125x writer dvd-ram cd/rw xa/form2 cdda tray
ata7: PATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 bmdma 0x000000000001ffa0 irq 14
ata8: PATA max UDMA/133 cmd 0x0000000000010170 ctl 0x0000000000010376 bmdma 0x000000000001ffa8 irq 15
Uniform CD-ROM driver Revision: 3.20
sr 5:0:0:0: Attached scsi CD-ROM sr0
ACPI: PCI Interrupt 0000:02:00.1[B] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:02:00.1 to 64
scsi8 : pata_jmicron
scsi9 : pata_jmicron
ata9: PATA max UDMA/100 cmd 0x0000000000019c00 ctl 0x0000000000019882 bmdma 0x0000000000019400 irq 18
ata10: PATA max UDMA/100 cmd 0x0000000000019800 ctl 0x0000000000019482 bmdma 0x0000000000019408 irq 18
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Processor [CPU2] (supports 8 throttling states)
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is not present [20070126]
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
swsusp: Marking nosave pages: 000000000009f000 - 0000000000100000
swsusp: Basic memory bitmaps created
swsusp: Basic memory bitmaps freed
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:04:00.0 to 64
sky2 0000:04:00.0: v1.14 addr 0xff8fc000 irq 19 Yukon-EC (0xb6) rev 2
sky2 eth0: addr 00:17:31:af:aa:ad
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:03:00.0 to 64
sky2 0000:03:00.0: v1.14 addr 0xff7fc000 irq 16 Yukon-EC (0xb6) rev 2
sky2 eth1: addr 00:17:31:af:a1:76
intel_rng: FWH not detected
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 23 (level, low) -> IRQ 23
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000e480
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
iTCO_vendor_support: vendor-support=0
hub 1-0:1.0: 2 ports detected
rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2, TCOBASE=0x0860)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
[fglrx] Maximum main memory to use for locked dma buffers: 922 MBytes.
[fglrx] USWC is disabled in module parameters
[fglrx] PAT is disabled!
[fglrx] module loaded - fglrx 8.40.4 [Jul 31 2007] on minor 0
ACPI: PCI Interrupt 0000:00:1d.7[A] -> <6>ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 21
GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xffafbc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[ff5ff800-ff5fffff]  Max Packet=[2048]  IR/IT contexts=[4/8]
hub 2-0:1.0: 8 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000e800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e880
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000ec00
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1b.0 to 64
usb 5-1: new full speed USB device using uhci_hcd and address 2
usb 5-1: device descriptor read/64, error -71
usb 5-1: device descriptor read/64, error -71
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d80000b2ccb4]
usb 5-1: new full speed USB device using uhci_hcd and address 3
Adding 4088500k swap on /dev/sda5.  Priority:-1 extents:1 across:4088500k
usb 5-1: device descriptor read/64, error -71
usb 5-1: device descriptor read/64, error -71
usb 5-1: new full speed USB device using uhci_hcd and address 4
usb 5-1: device not accepting address 4, error -71
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
usb 5-1: new full speed USB device using uhci_hcd and address 5
usb 5-1: device not accepting address 5, error -71
loop: module loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver 2.1.28 [Flags: R/W MODULE].
NTFS volume version 3.1.
NTFS volume version 3.1.
fuse init (API version 7.8)
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
nf_conntrack version 0.5.0 (4094 buckets, 32752 max)
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
input: Power Button (FF) as /class/input/input2
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input3
ACPI: Power Button (CM) [PWRB]
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[fglrx] Maximum main memory to use for locked dma buffers: 922 MBytes.
[fglrx] total      GART = 130023424
[fglrx] free       GART = 114032640
[fglrx] max single GART = 114032640
[fglrx] total      LFB  = 134086656
[fglrx] free       LFB  = 108843008
[fglrx] max single LFB  = 108843008
[fglrx] total      Inv  = 134217728
[fglrx] free       Inv  = 134217728
[fglrx] max single Inv  = 134217728
[fglrx] total      TIM  = 0
sky2 eth1: enabling interface
sky2 eth1: ram buffer 48K
ADDRCONF(NETDEV_UP): eth1: link is not ready
sky2 eth0: enabling interface
sky2 eth0: ram buffer 48K
ADDRCONF(NETDEV_UP): eth0: link is not ready
NET: Registered protocol family 17
sky2 eth0: Link is up at 10 Mbps, half duplex, flow control none
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
SFW2-OUT-ERROR IN= OUT=eth0 SRC=0000:0000:0000:0000:0000:0000:0000:0000 DST=ff02:0000:0000:0000:0000:0000:0000:0016 LEN=76 TC=0 HOPLIMIT=1 FLOWLBL=0 OPT ( ) PROTO=ICMPv6 TYPE=143 CODE=0 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=0000:0000:0000:0000:0000:0000:0000:0000 DST=ff02:0000:0000:0000:0000:0001:ffaf:aaad LEN=64 TC=0 HOPLIMIT=255 FLOWLBL=0 PROTO=ICMPv6 TYPE=135 CODE=0 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=fe80:0000:0000:0000:0217:31ff:feaf:aaad DST=ff02:0000:0000:0000:0000:0000:0000:0002 LEN=56 TC=0 HOPLIMIT=255 FLOWLBL=0 PROTO=ICMPv6 TYPE=133 CODE=0 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=0000:0000:0000:0000:0000:0000:0000:0000 DST=ff02:0000:0000:0000:0000:0000:0000:0016 LEN=76 TC=0 HOPLIMIT=1 FLOWLBL=0 OPT ( ) PROTO=ICMPv6 TYPE=143 CODE=0 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=0000:0000:0000:0000:0000:0000:0000:0000 DST=ff02:0000:0000:0000:0000:0001:ffaf:aaad LEN=64 TC=0 HOPLIMIT=255 FLOWLBL=0 PROTO=ICMPv6 TYPE=135 CODE=0 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=fe80:0000:0000:0000:0217:31ff:feaf:aaad DST=ff02:0000:0000:0000:0000:0000:0000:0002 LEN=56 TC=0 HOPLIMIT=255 FLOWLBL=0 PROTO=ICMPv6 TYPE=133 CODE=0 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=fe80:0000:0000:0000:0217:31ff:feaf:aaad DST=ff02:0000:0000:0000:0000:0000:0000:0002 LEN=56 TC=0 HOPLIMIT=255 FLOWLBL=0 PROTO=ICMPv6 TYPE=133 CODE=0 
eth0: no IPv6 routers present
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=207.242.93.22 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=31658 DF PROTO=TCP SPT=21283 DPT=80 WINDOW=125 RES=0x00 ACK FIN URGP=0 OPT (0101080AFFFF62A40006CC29) 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=207.242.93.22 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=49649 DF PROTO=TCP SPT=21285 DPT=80 WINDOW=125 RES=0x00 ACK FIN URGP=0 OPT (0101080AFFFF67DE0006C01D) 
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
st: Version 20070203, fixed bufsize 32768, s/g segs 256
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=207.242.93.22 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=31659 DF PROTO=TCP SPT=21283 DPT=80 WINDOW=125 RES=0x00 ACK FIN URGP=0 OPT (0101080AFFFFA1A40006CC29) 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=207.242.93.22 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=49650 DF PROTO=TCP SPT=21285 DPT=80 WINDOW=125 RES=0x00 ACK FIN URGP=0 OPT (0101080AFFFFA6DE0006C01D) 
usb 4-1: new full speed USB device using uhci_hcd and address 2
usb 4-1: device descriptor read/64, error -71
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
lp: driver loaded but no devices found
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=207.242.93.22 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=59735 DF PROTO=TCP SPT=17143 DPT=80 WINDOW=125 RES=0x00 ACK FIN URGP=0 OPT (0101080A000D42C600075FA4) 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=207.242.93.22 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=49706 DF PROTO=TCP SPT=17145 DPT=80 WINDOW=125 RES=0x00 ACK FIN URGP=0 OPT (0101080A000D42C6000751B7) 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=207.242.93.22 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=59736 DF PROTO=TCP SPT=17143 DPT=80 WINDOW=125 RES=0x00 ACK FIN URGP=0 OPT (0101080A000D834600075FA4) 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=207.242.93.22 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=49707 DF PROTO=TCP SPT=17145 DPT=80 WINDOW=125 RES=0x00 ACK FIN URGP=0 OPT (0101080A000D8346000751B7) 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=70.42.134.12 LEN=40 TOS=0x00 PREC=0x00 TTL=64 ID=60614 DF PROTO=TCP SPT=16360 DPT=80 WINDOW=9999 RES=0x00 ACK FIN URGP=0 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=70.42.134.12 LEN=40 TOS=0x00 PREC=0x00 TTL=64 ID=60615 DF PROTO=TCP SPT=16360 DPT=80 WINDOW=9999 RES=0x00 ACK FIN URGP=0 
usb 4-1: new full speed USB device using uhci_hcd and address 3
usb 4-1: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for PocketPC PDA
drivers/usb/serial/ipaq.c: USB PocketPC PDA driver v0.5
ipaq 4-1:1.0: PocketPC PDA converter detected
usb 4-1: PocketPC PDA converter now attached to ttyUSB0
usbcore: registered new interface driver ipaq
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=62.0.48.10 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=22905 DF PROTO=TCP SPT=13429 DPT=80 WINDOW=182 RES=0x00 ACK FIN URGP=0 OPT (0101080A00190D1E003EB67B) 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=62.0.48.10 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=22906 DF PROTO=TCP SPT=13429 DPT=80 WINDOW=182 RES=0x00 ACK FIN URGP=0 OPT (0101080A00190D55003EB67B) 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=62.0.48.10 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=22907 DF PROTO=TCP SPT=13429 DPT=80 WINDOW=182 RES=0x00 ACK FIN URGP=0 OPT (0101080A00190DC4003EB67B) 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=62.0.48.10 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=22908 DF PROTO=TCP SPT=13429 DPT=80 WINDOW=182 RES=0x00 ACK FIN URGP=0 OPT (0101080A00190EA0003EB67B) 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=62.0.48.10 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=22909 DF PROTO=TCP SPT=13429 DPT=80 WINDOW=182 RES=0x00 ACK FIN URGP=0 OPT (0101080A00191058003EB67B) 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=62.0.48.10 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=22912 DF PROTO=TCP SPT=13429 DPT=80 WINDOW=182 RES=0x00 ACK FIN URGP=0 OPT (0101080A00192868003EB67B) 
SFW2-OUT-ERROR IN= OUT=eth0 SRC=10.0.0.1 DST=62.0.48.10 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=22913 DF PROTO=TCP SPT=13429 DPT=80 WINDOW=182 RES=0x00 ACK FIN URGP=0 OPT (0101080A001943E8003EB67B) 

--Boundary-00=_few0GeWyDIkbcQA--
