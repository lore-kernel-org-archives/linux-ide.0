From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Sat, 14 Apr 2007 10:13:12 +0300 (EEST)
Message-ID: <33087.192.168.9.10.1176534792.squirrel@ncircle.nullnet.fi>
References: <200704132121.l3DLLRDb020449@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:43262 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161126AbXDNHNU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Apr 2007 03:13:20 -0400
In-Reply-To: <200704132121.l3DLLRDb020449@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org


Hi,

> Thanks. This tells us that it's not a power or cabling issue, but some
> kind of interface or programming incompatibility with the 7200.10 disks.
>
> My theory is that either TBG clocking (which drives the SATA interfaces)
> or SET FEATURE snooping (which adjusts internal parameters for different
> PIO/(U)DMA modes) is borked for SATAII/3Gbps. I hope to have time to
> investigate that soon. If you can limit transfer speeds to 1.5Gpbs then
> that may provide a workaround for now.

Somehow I think you are on the righ track based on my own test results ie.
the 1.5Gbps limiter doesn't seem to change anything.

I've used your following patch and still get the errors:

--- drivers/ata/sata_promise.c  2007-03-12 16:25:09.000000000 +0200
+++ drivers/ata/sata_promise.c.mod      2007-03-12 16:28:26.000000000 +0200
@@ -349,6 +349,18 @@
                writel(tmp, mmio + 0x014);
        }

+       /* hack SControl to limit speed to 1.5Gbps */
+       if ((hp->flags & PDC_FLAG_GEN_II) && sata_scr_valid(ap)) {
+               void __iomem *mmio = (void __iomem *) ap->ioaddr.scr_addr;
+               unsigned int tmp1, tmp2;
+
+               tmp1 = readl(mmio + 0x008);
+               tmp2 = (tmp1 & 0xffffff00) | 0x00000011;
+               writel(tmp2, mmio + 0x008);
+               readl(mmio + 0x008); /* flush */
+               printk("%s(port %u): adjusted SControl from 0x%08x to
0x%08x\n", __FUNCTION__, ap->port_no, tmp1, tmp2);
+       }
+
        return 0;
 }

and it did not change anything in my case. In the beginning I had the
1,5Gbps jumpers connected but I've now been running without the jumpers
(but with the 1,5Gbps sw limit patch) and still get the same errors

I've been wondering if I should boot with the Promise's own driver in
order to see if I can get some configuration to run properly with FC6
system & my current hardware.

I'm currently running with FC6 2990 kernel, which is based on
2.6.21-rc3-git10 and contains also your 1.5Gbps limit patch and Promise
Sata300TX4 port enumeration patch (does anybody know what might be the
reason that port enumeration patch has not been accepted in to main line
?). The reason why I'm not running with 2.6.21-rc6-git1 is that the
EH-subsystem seems to drop the speed o the problematic 7200.10 disks to
the UDMA-33 as a result of the above errors ---> not acceptable for the
moment.

The dmesg shows the following with the FC6 2990 patched kernel:

Linux version 2.6.20-1.2990.alderan (root@alderan.ncircle.nullnet.fi) (gcc
version 4.1.1 20070105 (Red Hat 4.1.1-51)) #1 Fri Apr 13 16:57:48 EEST
2007
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end:
000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end:
00000000000a0000 type: 2
copy_e820_map() start: 00000000000e4000 size: 000000000001c000 end:
0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000007fe40000 end:
000000007ff40000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000007ff40000 size: 0000000000010000 end:
000000007ff50000 type: 3
copy_e820_map() start: 000000007ff50000 size: 00000000000b0000 end:
0000000080000000 type: 4
copy_e820_map() start: 00000000ff7c0000 size: 0000000000840000 end:
0000000100000000 type: 2
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff40000 (usable)
 BIOS-e820: 000000007ff40000 - 000000007ff50000 (ACPI data)
 BIOS-e820: 000000007ff50000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
Using x86 segment limits to approximate NX protection
Entering add_active_range(0, 0, 524096) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   524096
early_node_map[1] active PFN ranges
    0:        0 ->   524096
On node 0 totalpages: 524096
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 2302 pages used for memmap
  HighMem zone: 292418 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP 000F9190, 0014 (r0 ACPIAM)
ACPI: RSDT 7FF40000, 0030 (r1 A M I  OEMRSDT   1000602 MSFT       97)
ACPI: FACP 7FF40200, 0081 (r2 A M I  OEMFACP   1000602 MSFT       97)
ACPI: DSDT 7FF40350, 373D (r1  A0008 A0008705      705 INTL  2002026)
ACPI: FACS 7FF50000, 0040
ACPI: APIC 7FF40300, 004A (r1 A M I  OEMAPIC   1000602 MSFT       97)
ACPI: OEMB 7FF50040, 003F (r1 A M I  OEMBIOS   1000602 MSFT       97)
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7f7c0000)
Built 1 zonelists.  Total pages: 520002
Kernel command line: ro root=/dev/md0 selinux=1 single
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c04d4000 soft=c04d3000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2083.234 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2071100k/2096384k available (2675k kernel code, 24076k reserved,
987k data, 228k init, 1178880k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffaa000 - 0xfffff000   ( 340 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0495000 - 0xc04ce000   ( 228 kB)
      .data : 0xc039cd31 - 0xc0493bd4   ( 987 kB)
      .text : 0xc0100000 - 0xc039cd31   (2675 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4169.09 BogoMIPS
(lpj=2084548)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Failure registering Root Plug module with the kernel
selinux_register_security:  There is already a secondary security module
registered.
Failure registering Root Plug  module with primary security module.
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383f3ff c1c3fbff 00000000 00000420 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm)  2800+ stepping 00
Checking 'hlt' instruction... OK.
ACPI: Core revision 20070126
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
0000:00:0f.1: cannot adjust BAR0 (not I/O)
0000:00:0f.1: cannot adjust BAR1 (not I/O)
0000:00:0f.1: cannot adjust BAR2 (not I/O)
0000:00:0f.1: cannot adjust BAR3 (not I/O)
PCI: enabled onboard AC97/MC97 devices
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs *3 4 5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
libata version 2.20 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
pnp: 00:08: iomem range 0xfec80000-0xfec800ff has been reserved
pnp: 00:08: iomem range 0xfec00000-0xfec00fff has been reserved
pnp: 00:08: iomem range 0xfee00000-0xfee00fff has been reserved
Time: tsc clocksource has been installed.
pnp: 00:08: iomem range 0xfff80000-0xffffffff has been reserved
pnp: 00:09: ioport range 0x480-0x487 has been reserved
pnp: 00:09: ioport range 0xc00-0xc7f has been reserved
pnp: 00:0b: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:0b: iomem range 0xc0000-0xdffff could not be reserved
pnp: 00:0b: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:0b: iomem range 0x100000-0x7fffffff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fb700000-fd8fffff
  PREFETCH window: 8ff00000-afefffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 2504k freed
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1176490841.453:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
- Added public key 8EAA7157971B15B5
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Bypassing VIA 8237 APIC De-Assert Message
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input2
ACPI: Sleep Button (CM) [SLPB]
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60
sec (nowayout= 1)
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is
60 seconds).
Hangcheck: Using get_cycles().
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI Media Changer driver v0.25
sata_promise 0000:00:0e.0: version 2.00
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 16
pdc_port_start(port 0): adjusted SControl from 0x00000000 to 0x00000011
ata1: SATA max UDMA/133 cmd 0xf880a380 ctl 0xf880a3b8 bmdma 0x00000000 irq 16
pdc_port_start(port 1): adjusted SControl from 0x00000000 to 0x00000011
ata2: SATA max UDMA/133 cmd 0xf880a280 ctl 0xf880a2b8 bmdma 0x00000000 irq 16
pdc_port_start(port 2): adjusted SControl from 0x00000000 to 0x00000011
ata3: SATA max UDMA/133 cmd 0xf880a200 ctl 0xf880a238 bmdma 0x00000000 irq 16
pdc_port_start(port 3): adjusted SControl from 0x00000000 to 0x00000011
ata4: SATA max UDMA/133 cmd 0xf880a300 ctl 0xf880a338 bmdma 0x00000000 irq 16
scsi0 : sata_promise
Switched to high resolution mode on CPU 0
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
ata1.00: 390721968 sectors, multi 0: LBA48
ata1.00: configured for UDMA/133
scsi1 : sata_promise
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-6: ST3200822AS, 3.01, max UDMA/133
ata2.00: 390721968 sectors, multi 0: LBA48
ata2.00: configured for UDMA/133
scsi2 : sata_promise
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata3.00: configured for UDMA/133
scsi3 : sata_promise
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata4.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata4.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: Direct-Access     ATA      ST3200822AS      3.01 PQ: 0 ANSI: 5
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
scsi 2:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdc: sdc1 sdc2
sd 2:0:0:0: Attached scsi disk sdc
sd 2:0:0:0: Attached scsi generic sg2 type 0
scsi 3:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdd: sdd1 sdd2
sd 3:0:0:0: Attached scsi disk sdd
sd 3:0:0:0: Attached scsi generic sg3 type 0
sata_via 0000:00:0f.0: version 2.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 17
sata_via 0000:00:0f.0: routed to hard irq line 10
ata5: SATA max UDMA/133 cmd 0x0001efa0 ctl 0x0001ef7e bmdma 0x0001ee90 irq 17
ata6: SATA max UDMA/133 cmd 0x0001ef68 ctl 0x0001ef66 bmdma 0x0001ee98 irq 17
scsi4 : sata_via
ata5: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x0001efa7
scsi5 : sata_via
ata6: SATA link down 1.5 Gbps (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x0001ef6f
pata_via 0000:00:0f.1: version 0.2.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 17
ata7: PATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001fc00 irq 14
ata8: PATA max UDMA/133 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001fc08 irq 15
scsi6 : pata_via
ata7.00: ATAPI, max UDMA/66
ata7.00: configured for UDMA/66
scsi7 : pata_via
ATA: abnormal status 0x8 on port 0x00010177
scsi 6:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-4160B A306 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 6:0:0:0: Attached scsi CD-ROM sr0
sr 6:0:0:0: Attached scsi generic sg4 type 5
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 18
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.4: irq 18, io mem 0xfe700000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 18
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 18, io base 0x0000eea0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 18
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 18, io base 0x0000eec0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 18
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 18, io base 0x0000ef80
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 18
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.3: irq 18, io base 0x0000ef40
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 2-1: new full speed USB device using uhci_hcd and address 2
usb 2-1: configuration #1 chosen from 1 choice
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
usb 2-1.4: new low speed USB device using uhci_hcd and address 3
usb 2-1.4: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input3
input: AT Translated Set 2 keyboard as /class/input/input4
I2O subsystem v1.325
i2o: max drivers = 8
I2O Configuration OSM v1.323
I2O Bus Adapter OSM v1.317
I2O Block Device OSM v1.325
I2O SCSI Peripheral OSM v1.316
I2O ProcFS OSM v1.316
i2c /dev entries driver
md: raid1 personality registered for level 1
raid6: int32x1    726 MB/s
raid6: int32x2    890 MB/s
raid6: int32x4    703 MB/s
raid6: int32x8    757 MB/s
raid6: mmxx1     1699 MB/s
raid6: mmxx2     2589 MB/s
raid6: sse1x1    1585 MB/s
raid6: sse1x2    2691 MB/s
raid6: using algorithm sse1x2 (2691 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  5928.000 MB/sec
raid5: using function: pIII_sse (5928.000 MB/sec)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised:
dm-devel@redhat.com
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
Bluetooth: HCI UART driver ver 2.2
Bluetooth: HCI H4 protocol initialized
Bluetooth: HCI BCSP protocol initialized


Regards,
Tomi Orava


