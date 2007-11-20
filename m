From: Mark Paulus <mark.paulus@verizonbusiness.com>
Subject: sata_sil issue on 2.6.22
Date: Tue, 20 Nov 2007 13:35:50 -0700
Message-ID: <47434526.7010304@verizonbusiness.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omzesmtp04.mci.com ([199.249.17.14]:50474 "EHLO
	omzesmtp04.mci.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976AbXKTUk5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Nov 2007 15:40:57 -0500
Received: from pmismtp03.mcilink.com ([166.37.158.163])
 by firewall.verizonbusiness.com (Iplanet MTA 5.2)
 with ESMTP id <0JRT00JKONVWY9@firewall.verizonbusiness.com> for
 linux-ide@vger.kernel.org; Tue, 20 Nov 2007 20:35:56 +0000 (GMT)
Received: from pmismtp03.mcilink.com ([127.0.0.1])
 by pmismtp03.mcilink.com (iPlanet Messaging Server 5.2 HotFix 2.08 (built Sep
 22 2005)) with SMTP id <0JRT005O9NVW1Q@pmismtp03.mcilink.com> for
 linux-ide@vger.kernel.org; Tue, 20 Nov 2007 20:35:56 +0000 (GMT)
Received: from [127.0.0.1] ([166.34.133.85])
 by pmismtp03.mcilink.com (iPlanet Messaging Server 5.2 HotFix 2.08 (built Sep
 22 2005)) with ESMTP id <0JRT0044DNVTZZ@pmismtp03.mcilink.com> for
 linux-ide@vger.kernel.org; Tue, 20 Nov 2007 20:35:55 +0000 (GMT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have a Compaq Deskpro EN P3 Celeron 850, running
Debian etch with a 2.6.18 kernel, which runs/boots
fine.  It has an add-in generic SIL3112 SATA card,
which also works fine with the 2.6.18 kernel.

I just tried to install a 2.6.22 kernel from 
www.backports.org, and that kernel will not boot correctly
because of the SATA card.

Here is the dmesg output:

Linux version 2.6.22-3-686 (Debian 2.6.22-5~bpo.1) (norbert@tretkowski.de) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Wed Oct 31 16:15:58 UTC 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffd0000 (usable)
 BIOS-e820: 000000001ffd0000 - 000000001fff0000 (ACPI NVS)
 BIOS-e820: 000000001fff0000 - 0000000020000000 (usable)
 BIOS-e820: 00000000feea0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
512MB LOWMEM available.
found SMP MP-table at 000f9bf0
Entering add_active_range(0, 0, 131072) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   131072
  HighMem    131072 ->   131072
early_node_map[1] active PFN ranges
    0:        0 ->   131072
On node 0 totalpages: 131072
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 992 pages used for memmap
  Normal zone: 125984 pages, LIFO batch:31
  HighMem zone: 0 pages used for memmap
DMI 2.3 present.
ACPI: RSDP 000E0010, 0014 (r0 COMPAQ)
ACPI: RSDT 000E0080, 005C (r1 COMPAQ CPQ0005  20020913             0)
ACPI: FACP 000E0130, 0074 (r1 COMPAQ SOLANO          1             0)
ACPI: DSDT 000E0204, 12F5 (r1 COMPAQ     DSDT        1 MSFT  100000D)
ACPI: FACS 000E0040, 0040
ACPI: SSDT 000E14F9, 0174 (r1 COMPAQ CORE_UTL        1 MSFT  100000D)
ACPI: SSDT 000E166D, 0D1C (r1 COMPAQ VILLTBL1        1 MSFT  100000D)
ACPI: SSDT 000E33B3, 005D (r1 COMPAQ     FHUB        1 MSFT  100000D)
ACPI: APIC 000E01A4, 0060 (r1 COMPAQ SOLANO          1             0)
ACPI: SSDT 000E333D, 0076 (r1 COMPAQ     APIC        1 MSFT  100000D)
ACPI: SSDT 000E2389, 06AD (r1 COMPAQ PNP_PRSS        1 MSFT  100000D)
ACPI: SSDT 000E2A94, 01A4 (r1 COMPAQ       S3        1 MSFT  100000D)
ACPI: SSDT 000E2C38, 0158 (r1 COMPAQ   PIDETM        1 MSFT  100000D)
ACPI: SSDT 000E2EED, 010B (r1 COMPAQ     GTF0        1 MSFT  100000D)
ACPI: SSDT 000E2FF8, 0117 (r1 COMPAQ     GTF1        1 MSFT  100000D)
ACPI: SSDT 000E2D90, 015D (r1 COMPAQ   SIDETM        1 MSFT  100000D)
ACPI: SSDT 000E310F, 0117 (r1 COMPAQ     GTF2        1 MSFT  100000D)
ACPI: SSDT 000E349B, 004E (r1 COMPAQ    FINIS        1 MSFT  100000D)
ACPI: PM-Timer IO Port: 0xf808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:deea0000)
Built 1 zonelists.  Total pages: 130048
Kernel command line: root=/dev/hda1 ro single
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 847.431 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 510088k/524288k available (1689k kernel code, 13380k reserved, 648k data, 244k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4e000 - 0xfffff000   ( 708 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
    lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
      .init : 0xc034f000 - 0xc038c000   ( 244 kB)
      .data : 0xc02a65d7 - 0xc03487e4   ( 648 kB)
      .text : 0xc0100000 - 0xc02a65d7   (1689 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1696.43 BogoMIPS (lpj=3392864)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 11k freed
ACPI: Core revision 20070126
CPU0: Intel Celeron (Coppermine) stepping 0a
Total of 1 processors activated (1696.43 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
Booting paravirtualized kernel on bare hardware
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xe838d, last bus=2
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region f800-f87f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region fa00-fa3f claimed by ICH4 GPIO
PCI: Firmware left 0000:02:08.0 e100 interrupts enabled, disabling
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB_._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 16 devices
ACPI: ACPI bus type pnp unregistered
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: RTC can wake from S4
pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0e: ioport range 0x400-0x41f has been reserved
pnp: 00:0e: ioport range 0x420-0x43f has been reserved
pnp: 00:0e: ioport range 0x440-0x45f has been reserved
pnp: 00:0e: ioport range 0x460-0x47f has been reserved
Time: tsc clocksource has been installed.
pnp: 00:0e: ioport range 0xf800-0xf81f has been reserved
pnp: 00:0e: ioport range 0xf820-0xf83f has been reserved
pnp: 00:0e: ioport range 0xf840-0xf85f has been reserved
pnp: 00:0e: ioport range 0xf860-0xf87f has been reserved
pnp: 00:0f: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:0f: iomem range 0xe0000-0xfffff could not be reserved
pnp: 00:0f: iomem range 0x100000-0x1fffffff could not be reserved
pnp: 00:0f: iomem range 0xfff80000-0xffffffff could not be reserved
PCI: Bridge: 0000:00:1e.0
  IO window: 1000-1fff
  MEM window: 40000000-413fffff
  PREFETCH window: 41500000-4fffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
TCP established hash table entries: 65536 (order: 7, 786432 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
checking if image is initramfs...<6>Switched to high resolution mode on CPU 0
 it is
Freeing initrd memory: 5901k freed
audit: initializing netlink socket (disabled)
audit(1195547209.852:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:02:04.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:KBD,PNP0f0e:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
Freeing unused kernel memory: 244k freed
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: Processor [CPU0] (supports 8 throttling states)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH2: IDE controller at PCI slot 0000:00:1f.1
ICH2: chipset revision 1
ICH2: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2460-0x2467, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x2468-0x246f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
e100: Intel(R) PRO/100 Network Driver, 3.5.17-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
SCSI subsystem initialized
libata version 2.21 loaded.
hda: Maxtor 34098H4, ATA DISK drive
hdb: WDC WD200BB-00DEA0, ATA DISK drive
hda: selected mode 0x45
hdb: selected mode 0x45
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: COMPAQ SC-148F, ATAPI CD/DVD-ROM drive
hdc: selected mode 0x22
ide1 at 0x170-0x177,0x376 on irq 15
ACPI: PCI Interrupt 0000:00:1f.4[C] -> GSI 23 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1f.4 to 64
uhci_hcd 0000:00:1f.4: UHCI Host Controller
uhci_hcd 0000:00:1f.4: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1f.4: irq 16, io base 0x00002440
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 17
e100: eth0: e100_probe: addr 0x41000000, irq 17, MAC addr 00:02:A5:10:5A:37
sata_sil 0000:02:0b.0: version 2.2
ACPI: PCI Interrupt 0000:02:0b.0[A] -> GSI 22 (level, low) -> IRQ 18
scsi0 : sata_sil
scsi1 : sata_sil
ata1: SATA max UDMA/100 cmd 0xe0812080 ctl 0xe081208a bmdma 0xe0812000 irq 18
ata2: SATA max UDMA/100 cmd 0xe08120c0 ctl 0xe08120ca bmdma 0xe0812008 irq 18
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=4)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=3)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=2)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after completion, repeating EH (cnt=1)
ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: ATA-5: ST310216A, 3.01, max UDMA/100
ata1.00: 19541088 sectors, multi 16: LBA 
ata1.00: applying bridge limits
ata1.00: failed to set xfermode (err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: limiting speed to UDMA/100:PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1: hard resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to set xfermode (err_mask=0x40)
ata1.00: disabled
ata1: EH pending after 5 tries, giving up
ata1: EH complete
ata2: SATA link down (SStatus 0 SControl 310)
hda: max request size: 128KiB
hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 < hda5 >
hdb: max request size: 128KiB
hdb: 39102336 sectors (20020 MB) w/8192KiB Cache, CHS=38792/16/63, UDMA(100)
hdb: cache flushes not supported
 hdb: hdb1
hdc: ATAPI 48X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
iTCO_wdt: Found a ICH2 TCO device (Version=1, TCOBASE=0xf860)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
Linux agpgart interface v0.102 (c) Dave Jones
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Intel 82802 RNG detected
agpgart: Detected an Intel i815 Chipset.
agpgart: AGP aperture is 64M @ 0x0
Real Time Clock Driver v1.12ac
input: PC Speaker as /class/input/input1
parport_pc 00:07: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
input: PS2++ Logitech MX Mouse as /class/input/input2
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 55824 usecs
intel8x0: clocking to 41145
Adding 1642496k swap on /dev/hda5.  Priority:-1 extents:1 across:1642496k
EXT3 FS on hda1, internal journal


Here is the output from 'hwinfo --all':
01: None 00.0: 0102 Floppy disk controller
  [Created at floppy.112]
  Unique ID: rdCR.3wRL2_g4d2B
  Hardware Class: storage
  Model: "Floppy disk controller"
  I/O Ports: 0x3f2-0x3f5 (rw)
  DMA: 2
  IRQ: 6 (10 events)
  I/O Port: 0x3f7 (rw)
  Config Status: cfg=new, avail=yes, need=no, active=unknown

02: Floppy 00.0: 10603 Floppy Disk
  [Created at floppy.120]
  Unique ID: sPPV.oZ89vuho4Y3
  Parent ID: rdCR.3wRL2_g4d2B
  Hardware Class: floppy
  Model: "Floppy Disk"
  Device File: /dev/fd0
  Size: 2880 sectors a 512 bytes
  Drive status: no medium
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #1 (Floppy disk controller)

03: None 00.0: 10105 BIOS
  [Created at bios.173]
  Unique ID: rdCR.lZF+r4EgHp4
  Hardware Class: bios
  BIOS Keyboard LED Status:
    Scroll Lock: off
    Num Lock: off
    Caps Lock: off
  Serial Port 0: 0x3f8
  Serial Port 1: 0x2f8
  Parallel Port 0: 0x378
  Base Memory: 638 kB
  PnP BIOS: CPQ0000
  BIOS: extended read supported
  MP spec rev 1.4 info:
    OEM id: "COMPAQ"
    Product id: "Deskpro"
    1 CPUs (0 disabled)
  BIOS32 Service Directory Entry: 0xe7300
  SMBIOS Version: 2.3
  BIOS Info: #1
    Vendor: "Compaq"
    Version: "686P2 v3.14"
    Date: "09/13/2002"
    Start Address: 0xe0000
    ROM Size: 512 kB
    Features: 0x0337000000003df9de80
      PCI supported
      PnP supported
      APM supported
      BIOS flashable
      BIOS shadowing allowed
      ESCD supported
      CD boot supported
      Selectable boot supported
      EDD spec supported
      1.2MB NEC 9800 Japanese Floppy supported
      1.2MB Toshiba Japanese Floppy supported
      360kB Floppy supported
      1.2MB Floppy supported
      720kB Floppy supported
      Print Screen supported
      8042 Keyboard Services supported
      Serial Services supported
      Printer Services supported
      ACPI supported
      USB Legacy supported
      AGP supported
      LS-120 boot supported
      ATAPI ZIP boot supported
      BIOS Boot Spec supported
      F12 Network boot supported
  System Info: #2
    Manufacturer: "Compaq"
    Product: "Deskpro"
    Serial: "6048DYSZ0129"
    UUID: undefined, but settable
    Wake-up: 0x06 (Power Switch)
  Board Info: #3
    Manufacturer: "Compaq"
    Product: "0684h"
    Serial: "6048DYSZ0129"
  Chassis Info: #4
    Manufacturer: "Compaq"
    Serial: "6048DYSZ0129"
    Asset Tag: "6048DYSZ0129"
    Type: 0x03 (Desktop)
    Lock: present
    Bootup State: 0x03 (Safe)
    Power Supply State: 0x03 (Safe)
    Thermal State: 0x03 (Safe)
    Security Status: 0x02 (Unknown)
  Processor Info: #5
    Socket: "XU1"
    Socket Type: 0x04 (ZIF Socket)
    Socket Status: Populated
    Type: 0x03 (CPU)
    Family: 0x0f (Celeron)
    Manufacturer: "Intel"
    Version: "Intel(R) Celeron(tm) processor 850 MHz"
    Processor ID: 0x0383fbff0000068a
    Status: 0x01 (Enabled)
    Voltage: 2.0 V
    External Clock: 100 MHz
    Max. Speed: 2300 MHz
    Current Speed: 850 MHz
    L1 Cache: #6
    L2 Cache: #7
  Cache Info: #6
    Designation: "Internal L1 Cache"
    Level: L1
    State: Enabled
    Mode: 0x01 (Write Back)
    Location: 0x00 (Internal, Not Socketed)
    ECC: 0x02 (Unknown)
    Type: 0x02 (Unknown)
    Associativity: 0x05 (4-way Set-Associative)
    Max. Size: 32 kB
    Current Size: 32 kB
    Supported SRAM Types: 0x0008 (Burst)
    Current SRAM Type: 0x0008 (Burst)
  Cache Info: #7
    Designation: "Cache L2"
    Level: L2
    State: Enabled
    Mode: 0x01 (Write Back)
    Location: 0x00 (Internal, Not Socketed)
    ECC: 0x05 (Single-bit)
    Type: 0x02 (Unknown)
    Associativity: 0x05 (4-way Set-Associative)
    Max. Size: 4096 kB
    Current Size: 128 kB
    Supported SRAM Types: 0x0008 (Burst)
    Current SRAM Type: 0x0008 (Burst)
  Port Connector: #8
    Type: 0x09 (Serial Port 16550A Compatible)
    Internal Designator: "COM A"
    Internal Connector: 0x18 (9 Pin Dual Inline [pin 10 cut])
    External Designator: "COM A"
    External Connector: 0x08 (DB-9 pin male)
  Port Connector: #9
    Type: 0x09 (Serial Port 16550A Compatible)
    Internal Designator: "COM B"
    Internal Connector: 0x18 (9 Pin Dual Inline [pin 10 cut])
    External Designator: "COM B"
    External Connector: 0x08 (DB-9 pin male)
  Port Connector: #10
    Type: 0x05 (Parallel Port ECP/EPP)
    Internal Designator: "PAR"
    Internal Connector: 0x19 (25 Pin Dual Inline [pin 26 cut])
    External Designator: "PAR"
    External Connector: 0x05 (DB-25 pin female)
  Port Connector: #11
    Type: 0x10 (USB)
    Internal Designator: "USB 1"
    Internal Connector: 0x12 (Access Bus [USB])
    External Designator: "USB 1"
    External Connector: 0x12 (Access Bus [USB])
  Port Connector: #12
    Type: 0x10 (USB)
    Internal Designator: "USB 2"
    Internal Connector: 0x12 (Access Bus [USB])
    External Designator: "USB 2"
    External Connector: 0x12 (Access Bus [USB])
  Port Connector: #15
    Type: 0x0d (Keyboard Port)
    Internal Designator: "KBD"
    Internal Connector: 0x0f (PS/2)
    External Designator: "KBD"
    External Connector: 0x0f (PS/2)
  Port Connector: #16
    Type: 0x0e (Mouse Port)
    Internal Designator: "MOUSE"
    Internal Connector: 0x0f (PS/2)
    External Designator: "MOUSE"
    External Connector: 0x0f (PS/2)
  Port Connector: #17
    Type: 0x1d (Audio Port)
    Internal Designator: "CD-AUDIO IN 1"
    Internal Connector: 0x1c (On Board Sound Input from CD-ROM)
  Port Connector: #18
    Type: 0x1d (Audio Port)
    Internal Designator: "CD-AUDIO IN 2"
    Internal Connector: 0x1c (On Board Sound Input from CD-ROM)
  Port Connector: #19
    Type: 0x1d (Audio Port)
    Internal Designator: "TV & DVD Audio In"
    Internal Connector: 0x1c (On Board Sound Input from CD-ROM)
  Port Connector: #20
    Internal Designator: "P20:Primary IDE"
    Internal Connector: 0x16 (On Board IDE)
  Port Connector: #21
    Internal Designator: "P21:Secondary IDE"
    Internal Connector: 0x16 (On Board IDE)
  Port Connector: #22
    Internal Designator: "P10:Floppy"
    Internal Connector: 0x17 (On Board Floppy)
  Port Connector: #23
    Type: 0x0b (MIDI Port)
    Internal Designator: "J13"
    Internal Connector: 0xff (Other)
    External Designator: "Line I/O: MIC"
    External Connector: 0x0d (Mini-DIN)
  Port Connector: #24
    Type: 0x0b (MIDI Port)
    Internal Designator: "J15"
    Internal Connector: 0xff (Other)
    External Designator: "Line I/O: Line In"
    External Connector: 0x0d (Mini-DIN)
  Port Connector: #27
    Type: 0x0b (MIDI Port)
    Internal Designator: "J13"
    Internal Connector: 0xff (Other)
    External Designator: "HeadPhone & Line Out"
    External Connector: 0x0d (Mini-DIN)
  Port Connector: #28
    Type: 0xff (Other)
    Internal Designator: "P9: NIC"
    Internal Connector: 0xff (Other)
  Port Connector: #29
    Type: 0xff (Other)
    Internal Designator: "Chassis Fan"
    Internal Connector: 0xff (Other)
  Port Connector: #30
    Type: 0xff (Other)
    Internal Designator: "P6: Speaker"
    Internal Connector: 0xff (Other)
  Language Info: #31
    Languages: en|US|iso8859-1
    Current: en|US|iso8859-1
  Type 15 Record: #32
    Data 00: 0f 19 20 00 3d 00 00 00 00 00 03 01 00 00 00 00
    Data 10: ac 10 0f 00 00 01 02 08 04
  Physical Memory Array: #33
    Use: 0x03 (System memory)
    Location: 0x03 (Motherboard)
    Slots: 3
    Max. Size: 512 MB
    ECC: 0x03 (None)
  Physical Memory Array: #34
    Use: 0x05 (Flash memory)
    Location: 0x03 (Motherboard)
    Slots: 1
    Max. Size: 512 kB
    ECC: 0x03 (None)
  Memory Device: #35
    Location: "XMM1"
    Manufacturer: "JEDEC ID:7F 98 00 00 00 00 00 00"
    Serial: "00581800"
    Part Number: "32MX64PC100CL2168"
    Memory Array: #33
    Form Factor: 0x09 (DIMM)
    Type: 0x0f (SDRAM)
    Type Detail: 0x0080 (Synchronous)
    Data Width: 64 bits
    Size: 256 MB
    Speed: 100 MHz
  Memory Device: #36
    Location: "XMM2"
    Manufacturer: "JEDEC ID:7F 98 00 00 00 00 00 00"
    Serial: "00211800"
    Part Number: "32MX64PC100CL2168"
    Memory Array: #33
    Form Factor: 0x09 (DIMM)
    Type: 0x0f (SDRAM)
    Type Detail: 0x0080 (Synchronous)
    Data Width: 64 bits
    Size: 256 MB
    Speed: 100 MHz
  Memory Device: #37
    Location: "XMM3"
    Manufacturer: "JEDEC ID:"
    Memory Array: #33
    Form Factor: 0x09 (DIMM)
    Type: 0x0f (SDRAM)
    Type Detail: 0x0080 (Synchronous)
    Data Width: 0 bits
    Size: No Memory Installed
  Memory Device: #40
    Location: "XU15"
    Memory Array: #34
    Form Factor: 0x05 (Chip)
    Type: 0x09 (FLASH)
    Type Detail: 0x1000 (Non-volatile)
    Data Width: 4 bits
    Size: 512 kB
  Memory Array Mapping: #41
    Memory Array: #33
    Partition Width: 3
    Start Address: 0x00000000
    End Address: 0x20000000
  Memory Array Mapping: #42
    Memory Array: #34
    Partition Width: 1
    Start Address: 0x00000000fff80000
    End Address: 0x0000000100000000
  Memory Device Mapping: #43
    Memory Device: #35
    Array Mapping: #41
    Row: 1
    Interleave Pos: 0
    Interleaved Depth: 0
    Start Address: 0x00000000
    End Address: 0x10000000
  Memory Device Mapping: #44
    Memory Device: #36
    Array Mapping: #41
    Row: 2
    Interleave Pos: 0
    Interleaved Depth: 0
    Start Address: 0x10000000
    End Address: 0x20000000
  Memory Device Mapping: #45
    Memory Device: #37
    Array Mapping: #41
    Row: 3
    Interleave Pos: 0
    Interleaved Depth: 0
    Start Address: 0x00000000
    End Address: 0x00000400
  Memory Device Mapping: #47
    Memory Device: #40
    Array Mapping: #42
    Row: 1
    Interleave Pos: 0
    Interleaved Depth: 0
    Start Address: 0x00000000fff80000
    End Address: 0x0000000100000000
  System Slot: #48
    Designation: "AGP Slot J40"
    Type: 0x11 (AGP 4X)
    Bus Width: 0x05 (32 bit)
    Status: 0x03 (Available)
    Length: 0x03 (Short)
    Slot ID: 0
    Characteristics: 0x0004 (3.3 V)
  System Slot: #50
    Designation: "PCI Slot 1: J20"
    Type: 0x06 (PCI)
    Bus Width: 0x05 (32 bit)
    Status: 0x04 (In Use)
    Length: 0x03 (Short)
    Slot ID: 1
    Characteristics: 0x0506 (5.0 V, 3.3 V, PME#)
  System Slot: #51
    Designation: "PCI Slot 2: J21"
    Type: 0x06 (PCI)
    Bus Width: 0x05 (32 bit)
    Status: 0x03 (Available)
    Length: 0x03 (Short)
    Slot ID: 2
    Characteristics: 0x0506 (5.0 V, 3.3 V, PME#)
  System Slot: #52
    Designation: "PCI Slot 3: J22"
    Type: 0x06 (PCI)
    Bus Width: 0x05 (32 bit)
    Status: 0x03 (Available)
    Length: 0x03 (Short)
    Slot ID: 3
    Characteristics: 0x0506 (5.0 V, 3.3 V, PME#)
  System Slot: #53
    Designation: "PCI Slot 4: J23"
    Type: 0x06 (PCI)
    Bus Width: 0x05 (32 bit)
    Status: 0x04 (In Use)
    Length: 0x03 (Short)
    Slot ID: 4
    Characteristics: 0x0506 (5.0 V, 3.3 V, PME#)
  System Slot: #54
    Designation: "PCI Slot 5: J24"
    Type: 0x06 (PCI)
    Bus Width: 0x05 (32 bit)
    Status: 0x03 (Available)
    Length: 0x03 (Short)
    Slot ID: 5
    Characteristics: 0x0506 (5.0 V, 3.3 V, PME#)
  Type 31 Record: #55
    Data 00: 1f 1c 37 00 4b 00 00 00 54 78 00 f0 e4 95 0e 00
    Data 10: 00 00 00 00 00 00 00 00 00 00 00 00
  Type 32 Record: #56
    Data 00: 20 0b 38 00 00 00 00 00 00 00 00
  Type 128 Record: #57
    Data 00: 80 1c 39 00 01 01 02 01 01 02 20 02 02 02 48 02
    Data 10: 03 02 50 02 04 02 58 02 05 02 68 02
    String 1: "Alert on LAN"
    String 2: "CPQ-CD00-SA-1"
  Config Status: cfg=new, avail=yes, need=no, active=unknown

04: None 00.0: 10107 System
  [Created at sys.59]
  Unique ID: rdCR.n_7QNeEnh23
  Hardware Class: system
  Model: "System"
  Driver Info #0:
    Driver Status: thermal,fan are active
    Driver Activation Cmd: "modprobe thermal; modprobe fan"
  Config Status: cfg=new, avail=yes, need=no, active=unknown

05: None 00.0: 10104 FPU
  [Created at misc.192]
  Unique ID: rdCR.EMpH5pjcahD
  Hardware Class: unknown
  Model: "FPU"
  I/O Ports: 0xf0-0xff (rw)
  Config Status: cfg=new, avail=yes, need=no, active=unknown

06: None 00.0: 0801 DMA controller (8237)
  [Created at misc.206]
  Unique ID: rdCR.f5u1ucRm+H9
  Hardware Class: unknown
  Model: "DMA controller"
  I/O Ports: 0x00-0x1f (rw)
  I/O Ports: 0xc0-0xdf (rw)
  I/O Ports: 0x80-0x8f (rw)
  DMA: 4
  Config Status: cfg=new, avail=yes, need=no, active=unknown

07: None 00.0: 0800 PIC (8259)
  [Created at misc.219]
  Unique ID: rdCR.8uRK7LxiIA2
  Hardware Class: unknown
  Model: "PIC"
  I/O Ports: 0x20-0x21 (rw)
  I/O Ports: 0xa0-0xa1 (rw)
  Config Status: cfg=new, avail=yes, need=no, active=unknown

08: None 00.0: 0802 Timer (8254)
  [Created at misc.230]
  Unique ID: rdCR.AJKleuxpiP0
  Hardware Class: unknown
  Model: "Timer"
  IRQ: 0 (63 events)
  Config Status: cfg=new, avail=yes, need=no, active=unknown

09: None 00.0: 0803 RTC (Generic)
  [Created at misc.241]
  Unique ID: rdCR.hWmSPAStPX7
  Hardware Class: unknown
  Model: "RTC"
  I/O Ports: 0x70-0x77 (rw)
  IRQ: 8 (1 event)
  Config Status: cfg=new, avail=yes, need=no, active=unknown

10: None 00.0: 0900 Keyboard controller
  [Created at misc.251]
  Unique ID: rdCR.9N+EecqykME
  Hardware Class: unknown
  Model: "Keyboard controller"
  I/O Ports: 0x60-0x6f (rw)
  Config Status: cfg=new, avail=yes, need=no, active=unknown

11: None 00.0: 0701 Parallel controller (SPP)
  [Created at misc.262]
  Unique ID: YMnp.ecK7NLYWZ5D
  Hardware Class: unknown
  Model: "Parallel controller"
  Device File: /dev/lp0
  I/O Ports: 0x378-0x37a (rw)
  Config Status: cfg=new, avail=yes, need=no, active=unknown

12: None 00.0: 10400 PS/2 Controller
  [Created at misc.304]
  Unique ID: rdCR.DziBbWO85o5
  Hardware Class: unknown
  Model: "PS/2 Controller"
  Config Status: cfg=new, avail=yes, need=no, active=unknown

14: None 00.0: 10102 Main Memory
  [Created at memory.61]
  Unique ID: rdCR.CxwsZFjVASF
  Hardware Class: memory
  Model: "Main Memory"
  Memory Range: 0x00000000-0x1fffffff (rw)
  Memory Size: 512 MB
  Config Status: cfg=new, avail=yes, need=no, active=unknown

15: PCI 00.0: 0600 Host bridge
  [Created at pci.281]
  Unique ID: qLht.v_Y7QGTsQ_D
  SysFS ID: /devices/pci0000:00/0000:00:00.0
  SysFS BusID: 0000:00:00.0
  Hardware Class: bridge
  Model: "Intel 82815 815 Chipset Host Bridge and Memory Controller Hub"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x1130 "82815 815 Chipset Host Bridge and Memory Controller Hub"
  Revision: 0x02
  Driver: "agpgart-intel"
  Driver Modules: "intel_agp"
  Module Alias: "pci:v00008086d00001130sv00000000sd00000000bc06sc00i00"
  Driver Info #0:
    Driver Status: intel_agp is active
    Driver Activation Cmd: "modprobe intel_agp"
  Config Status: cfg=new, avail=yes, need=no, active=unknown

16: PCI 1e.0: 0604 PCI bridge (Normal decode)
  [Created at pci.281]
  Unique ID: 6NW+.5mTGXo377UF
  SysFS ID: /devices/pci0000:00/0000:00:1e.0
  SysFS BusID: 0000:00:1e.0
  Hardware Class: bridge
  Model: "Intel 82801 PCI Bridge"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x244e "82801 PCI Bridge"
  Revision: 0x01
  Module Alias: "pci:v00008086d0000244Esv00000000sd00000000bc06sc04i00"
  Driver Info #0:
    Driver Status: shpchp is active
    Driver Activation Cmd: "modprobe shpchp"
  Config Status: cfg=new, avail=yes, need=no, active=unknown

17: PCI 1f.0: 0601 ISA bridge
  [Created at pci.281]
  Unique ID: BUZT.KKxeW_u4el4
  SysFS ID: /devices/pci0000:00/0000:00:1f.0
  SysFS BusID: 0000:00:1f.0
  Hardware Class: bridge
  Model: "Intel 82801BA ISA Bridge (LPC)"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x2440 "82801BA ISA Bridge (LPC)"
  Revision: 0x01
  Module Alias: "pci:v00008086d00002440sv00000000sd00000000bc06sc01i00"
  Driver Info #0:
    Driver Status: iTCO_wdt is active
    Driver Activation Cmd: "modprobe iTCO_wdt"
  Driver Info #1:
    Driver Status: intel_rng is active
    Driver Activation Cmd: "modprobe intel_rng"
  Config Status: cfg=new, avail=yes, need=no, active=unknown

18: PCI 1f.1: 0101 IDE interface
  [Created at pci.281]
  Unique ID: 3p2J.tH5+ziGnAT8
  SysFS ID: /devices/pci0000:00/0000:00:1f.1
  SysFS BusID: 0000:00:1f.1
  Hardware Class: storage
  Model: "Intel 82801BA IDE U100"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x244b "82801BA IDE U100"
  SubVendor: pci 0x8086 "Intel Corporation"
  SubDevice: pci 0x2411 
  Revision: 0x01
  Driver: "PIIX_IDE"
  Driver Modules: "piix"
  I/O Ports: 0x1f0-0x1f7 (rw)
  I/O Port: 0x3f6 (rw)
  I/O Ports: 0x170-0x177 (rw)
  I/O Port: 0x376 (rw)
  I/O Ports: 0x2460-0x246f (rw)
  IRQ: 14 (8314 events)
  IRQ: 15 (91 events)
  Module Alias: "pci:v00008086d0000244Bsv00008086sd00002411bc01sc01i80"
  Driver Info #0:
    Driver Status: piix is active
    Driver Activation Cmd: "modprobe piix"
  Driver Info #1:
    Driver Status: ata_generic is active
    Driver Activation Cmd: "modprobe ata_generic"
  Driver Info #2:
    Driver Status: generic is active
    Driver Activation Cmd: "modprobe generic"
  Config Status: cfg=new, avail=yes, need=no, active=unknown

19: PCI 1f.4: 0c03 USB Controller (UHCI)
  [Created at pci.281]
  Unique ID: fnWp.T65Wf0Mfep6
  SysFS ID: /devices/pci0000:00/0000:00:1f.4
  SysFS BusID: 0000:00:1f.4
  Hardware Class: usb controller
  Model: "Intel 82801BA/BAM USB (Hub #2)"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x2444 "82801BA/BAM USB (Hub #2)"
  SubVendor: pci 0x8086 "Intel Corporation"
  SubDevice: pci 0x2411 
  Revision: 0x01
  Driver: "uhci_hcd"
  Driver Modules: "uhci_hcd"
  I/O Ports: 0x2440-0x245f (rw)
  IRQ: 17 (no events)
  Module Alias: "pci:v00008086d00002444sv00008086sd00002411bc0Csc03i00"
  Driver Info #0:
    Driver Status: uhci-hcd is active
    Driver Activation Cmd: "modprobe uhci-hcd"
  Config Status: cfg=new, avail=yes, need=no, active=unknown

20: PCI 1f.5: 0401 Multimedia audio controller
  [Created at pci.281]
  Unique ID: W60f.p5TvhClMSjB
  SysFS ID: /devices/pci0000:00/0000:00:1f.5
  SysFS BusID: 0000:00:1f.5
  Hardware Class: sound
  Model: "Compaq 82801BA/BAM AC'97 Audio"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x2445 "82801BA/BAM AC'97 Audio"
  SubVendor: pci 0x0e11 "Compaq Computer Corporation"
  SubDevice: pci 0x000b 
  Revision: 0x01
  Driver: "Intel ICH"
  Driver Modules: "snd_intel8x0"
  I/O Ports: 0x2000-0x20ff (rw)
  I/O Ports: 0x2400-0x243f (rw)
  IRQ: 19 (no events)
  Module Alias: "pci:v00008086d00002445sv00000E11sd0000000Bbc04sc01i00"
  Driver Info #0:
    Driver Status: snd_intel8x0 is active
    Driver Activation Cmd: "modprobe snd_intel8x0"
  Config Status: cfg=new, avail=yes, need=no, active=unknown

21: PCI 204.0: 0300 VGA compatible controller (VGA)
  [Created at pci.281]
  Unique ID: UVH2.HkBKmes3CN2
  Parent ID: 6NW+.5mTGXo377UF
  SysFS ID: /devices/pci0000:00/0000:00:1e.0/0000:02:04.0
  SysFS BusID: 0000:02:04.0
  Hardware Class: graphics card
  Model: "nVidia GeForce4 MX 420"
  Vendor: pci 0x10de "nVidia Corporation"
  Device: pci 0x0172 "GeForce4 MX 420"
  Revision: 0xa3
  Memory Range: 0x40000000-0x40ffffff (rw,non-prefetchable)
  Memory Range: 0x48000000-0x4fffffff (rw,prefetchable)
  Memory Range: 0x41500000-0x4157ffff (rw,prefetchable)
  Memory Range: 0x41600000-0x4161ffff (ro,prefetchable,disabled)
  IRQ: 5 (no events)
  I/O Ports: 0x3c0-0x3df (rw)
  Module Alias: "pci:v000010DEd00000172sv00000000sd00000000bc03sc00i00"
  Driver Info #0:
    XFree86 v4 Server Module: nv
  Driver Info #1:
    XFree86 v4 Server Module: nvidia
    3D Support: yes
    Color Depths: 16
    Extensions: 
    Options: 
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #16 (PCI bridge)

22: PCI 208.0: 0200 Ethernet controller
  [Created at pci.281]
  Unique ID: rBUF.xuoNXTox6+6
  Parent ID: 6NW+.5mTGXo377UF
  SysFS ID: /devices/pci0000:00/0000:00:1e.0/0000:02:08.0
  SysFS BusID: 0000:02:08.0
  Hardware Class: network
  Model: "Compaq EtherExpress PRO/100 VM"
  Vendor: pci 0x8086 "Intel Corporation"
  Device: pci 0x2449 "82801BA/BAM/CA/CAM Ethernet Controller"
  SubVendor: pci 0x0e11 "Compaq Computer Corporation"
  SubDevice: pci 0x0012 "EtherExpress PRO/100 VM"
  Revision: 0x01
  Driver: "e100"
  Driver Modules: "e100"
  Device File: eth0
  Memory Range: 0x41000000-0x41000fff (rw,non-prefetchable)
  I/O Ports: 0x1000-0x1fff (rw)
  IRQ: 16 (1457 events)
  HW Address: 00:02:a5:10:5a:37
  Link detected: yes
  Module Alias: "pci:v00008086d00002449sv00000E11sd00000012bc02sc00i00"
  Driver Info #0:
    Driver Status: e100 is active
    Driver Activation Cmd: "modprobe e100"
  Driver Info #1:
    Driver Status: eepro100 is not active
    Driver Activation Cmd: "modprobe eepro100"
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #16 (PCI bridge)

23: PCI 20b.0: 0180 Unknown mass storage controller
  [Created at pci.281]
  Unique ID: 1HdK.dC1pu2GvTC6
  Parent ID: 6NW+.5mTGXo377UF
  SysFS ID: /devices/pci0000:00/0000:00:1e.0/0000:02:0b.0
  SysFS BusID: 0000:02:0b.0
  Hardware Class: storage
  Model: "Silicon Image SiI 3112 SATALink Controller"
  Vendor: pci 0x1095 "Silicon Image, Inc."
  Device: pci 0x3112 "SiI 3112 [SATALink/SATARaid] Serial ATA Controller"
  SubVendor: pci 0x1095 "Silicon Image, Inc."
  SubDevice: pci 0x3112 "SiI 3112 SATALink Controller"
  Revision: 0x02
  Driver: "sata_sil"
  Driver Modules: "sata_sil"
  I/O Ports: 0x1050-0x1057 (rw)
  I/O Ports: 0x1060-0x1063 (rw)
  I/O Ports: 0x1058-0x105f (rw)
  I/O Ports: 0x1064-0x1067 (rw)
  I/O Ports: 0x1040-0x104f (rw)
  Memory Range: 0x41100000-0x411001ff (rw,non-prefetchable)
  Memory Range: 0x41580000-0x415fffff (ro,prefetchable,disabled)
  IRQ: 18 (17 events)
  Module Alias: "pci:v00001095d00003112sv00001095sd00003112bc01sc80i00"
  Driver Info #0:
    Driver Status: sata_sil is active
    Driver Activation Cmd: "modprobe sata_sil"
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #16 (PCI bridge)

24: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: z9pp.QBqTp8zQt87
  SysFS ID: /devices/pnp0/00:00
  SysFS BusID: 00:00
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0a03 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

25: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: QL3u.DE8RM9cWQQ8
  SysFS ID: /devices/pnp0/00:01
  SysFS BusID: 00:01
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0c04 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

26: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: tWJy.ld94kxNGZf5
  SysFS ID: /devices/pnp0/00:02
  SysFS BusID: 00:02
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0200 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

27: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: KiZ0.WYwRElrJa93
  SysFS ID: /devices/pnp0/00:03
  SysFS BusID: 00:03
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0b00 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

28: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: ntp4.bvKf3UMzZfE
  SysFS ID: /devices/pnp0/00:04
  SysFS BusID: 00:04
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0800 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

29: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: E349.t7Yh1tpgb13
  SysFS ID: /devices/pnp0/00:05
  SysFS BusID: 00:05
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0f13 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

30: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: hEKD.xhndlW9HXJ7
  SysFS ID: /devices/pnp0/00:06
  SysFS BusID: 00:06
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0303 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

31: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: NhVi.YgT1Hy0M6x6
  SysFS ID: /devices/pnp0/00:07
  SysFS BusID: 00:07
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0401 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

32: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: qslm.BuKI+1soRmD
  SysFS ID: /devices/pnp0/00:08
  SysFS BusID: 00:08
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0501 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

33: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: H20r.BuKI+1soRmD
  SysFS ID: /devices/pnp0/00:09
  SysFS BusID: 00:09
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0501 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

34: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: iT2w.yhTOLOXWEq7
  SysFS ID: /devices/pnp0/00:0a
  SysFS BusID: 00:0a
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0700 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

35: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: 9fI_.jDhFyyFrbg5
  SysFS ID: /devices/pnp0/00:0b
  SysFS BusID: 00:0b
  Hardware Class: unknown
  Model: "Unclassified device"
  SubVendor: INT 
  SubDevice: eisa 0x0800 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

36: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: cqY2.03CraFgwWp2
  SysFS ID: /devices/pnp0/00:0c
  SysFS BusID: 00:0c
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0003 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

37: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: 30p6.B+yZ9Ve8gC1
  SysFS ID: /devices/pnp0/00:0d
  SysFS BusID: 00:0d
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0c02 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

38: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: XB3B.B+yZ9Ve8gC1
  SysFS ID: /devices/pnp0/00:0e
  SysFS BusID: 00:0e
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0c02 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

39: ISA(PnP) 00.0: 0000 Unclassified device
  [Created at isapnp.142]
  Unique ID: _MJF.gNN83gfynbD
  SysFS ID: /devices/pnp0/00:0f
  SysFS BusID: 00:0f
  Hardware Class: unknown
  Model: "PnP Unclassified device"
  SubVendor: PNP "PnP"
  SubDevice: eisa 0x0c01 
  Config Status: cfg=new, avail=yes, need=no, active=unknown

40: None 00.0: 0700 Serial controller (16550)
  [Created at serial.74]
  Unique ID: S_Uw.3fyvFV+mbWD
  Hardware Class: unknown
  Model: "16550A"
  Device: "16550A"
  Device File: /dev/ttyS0
  I/O Ports: 0x3f8-0x3ff (rw)
  IRQ: 4 (46 events)
  Config Status: cfg=new, avail=yes, need=no, active=unknown

41: None 00.1: 0700 Serial controller (16550)
  [Created at serial.74]
  Unique ID: v9l_.3fyvFV+mbWD
  Hardware Class: unknown
  Model: "16550A"
  Device: "16550A"
  Device File: /dev/ttyS1
  I/O Ports: 0x2f8-0x2ff (rw)
  IRQ: 3 (53 events)
  Config Status: cfg=new, avail=yes, need=no, active=unknown

42: IDE 00.0: 10600 Disk
  [Created at block.218]
  Unique ID: l_yX.4e5ZNlI9j28
  Parent ID: 3p2J.tH5+ziGnAT8
  SysFS ID: /block/hda
  SysFS BusID: 0.0
  SysFS Device Link: /devices/pci0000:00/0000:00:1f.1/ide0/0.0
  Hardware Class: disk
  Model: "Maxtor 34098H4"
  Vendor: "Maxtor"
  Device: "34098H4"
  Revision: "YAH814Y0"
  Serial ID: "L41GNGNC"
  Driver: "PIIX_IDE", "ide-disk"
  Driver Modules: "piix", "ide_disk"
  Device File: /dev/hda
  Device Files: /dev/hda, /dev/disk/by-id/ata-Maxtor_34098H4_L41GNGNC, /dev/disk/by-path/pci-0000:00:1f.1-ide-0:0
  Device Number: block 3:0-3:63
  BIOS id: 0x80
  Size: 80043264 sectors a 512 bytes
  Geometry (Physical): CHS 79408/16/63
  Geometry (Logical): CHS 79408/16/63
  Cache: 2048 kb
  Geometry (BIOS EDD): CHS 79408/16/63
  Size (BIOS EDD): 80043264 sectors
  Geometry (BIOS Legacy): CHS 1023/240/63
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #18 (IDE interface)

43: None 00.0: 11300 Partition
  [Created at block.387]
  Unique ID: 0fbI.SE1wIdpsiiC
  Parent ID: l_yX.4e5ZNlI9j28
  SysFS ID: /block/hda/hda1
  Hardware Class: partition
  Model: "Partition"
  Device File: /dev/hda1
  Device Files: /dev/hda1, /dev/disk/by-id/ata-Maxtor_34098H4_L41GNGNC-part1, /dev/disk/by-path/pci-0000:00:1f.1-ide-0:0-part1, /dev/disk/by-uuid/7f301809-f0ed-4369-947b-73ce0aa2ba7d
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #42 (Disk)

44: None 00.0: 11300 Partition
  [Created at block.387]
  Unique ID: TqrM.SE1wIdpsiiC
  Parent ID: l_yX.4e5ZNlI9j28
  SysFS ID: /block/hda/hda2
  Hardware Class: partition
  Model: "Partition"
  Device File: /dev/hda2
  Device Files: /dev/hda2, /dev/disk/by-id/ata-Maxtor_34098H4_L41GNGNC-part2, /dev/disk/by-path/pci-0000:00:1f.1-ide-0:0-part2
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #42 (Disk)

45: None 00.0: 11300 Partition
  [Created at block.387]
  Unique ID: rMcZ.SE1wIdpsiiC
  Parent ID: l_yX.4e5ZNlI9j28
  SysFS ID: /block/hda/hda5
  Hardware Class: partition
  Model: "Partition"
  Device File: /dev/hda5
  Device Files: /dev/hda5, /dev/disk/by-id/ata-Maxtor_34098H4_L41GNGNC-part5, /dev/disk/by-path/pci-0000:00:1f.1-ide-0:0-part5, /dev/disk/by-uuid/ccb7f3d8-934f-4ba5-82d7-11de1f8db96c
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #42 (Disk)

46: IDE 01.0: 10600 Disk
  [Created at block.218]
  Unique ID: u0Ql.A1vk7ViRbo2
  Parent ID: 3p2J.tH5+ziGnAT8
  SysFS ID: /block/hdb
  SysFS BusID: 0.1
  SysFS Device Link: /devices/pci0000:00/0000:00:1f.1/ide0/0.1
  Hardware Class: disk
  Model: "WDC WD200BB-00DEA0"
  Vendor: "WDC"
  Device: "WD200BB-00DEA0"
  Revision: "05.03E05"
  Serial ID: "WD-WMAD1J586248"
  Driver: "PIIX_IDE", "ide-disk"
  Driver Modules: "piix", "ide_disk"
  Device File: /dev/hdb
  Device Files: /dev/hdb, /dev/disk/by-id/ata-WDC_WD200BB-00DEA0_WD-WMAD1J586248, /dev/disk/by-path/pci-0000:00:1f.1-ide-0:1
  Device Number: block 3:64-3:127
  BIOS id: 0x81
  Size: 39102336 sectors a 512 bytes
  Geometry (Physical): CHS 38792/16/63
  Geometry (Logical): CHS 38792/16/63
  Cache: 8192 kb
  Geometry (BIOS EDD): CHS 38792/16/63
  Size (BIOS EDD): 39102336 sectors
  Geometry (BIOS Legacy): CHS 1023/240/63
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #18 (IDE interface)

47: None 00.0: 11300 Partition
  [Created at block.387]
  Unique ID: 66wj.SE1wIdpsiiC
  Parent ID: u0Ql.A1vk7ViRbo2
  SysFS ID: /block/hdb/hdb1
  Hardware Class: partition
  Model: "Partition"
  Device File: /dev/hdb1
  Device Files: /dev/hdb1, /dev/disk/by-id/ata-WDC_WD200BB-00DEA0_WD-WMAD1J586248-part1, /dev/disk/by-path/pci-0000:00:1f.1-ide-0:1-part1
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #46 (Disk)

48: IDE 02.0: 10602 CD-ROM
  [Created at block.222]
  Unique ID: 90A1.e9o95b7dqsE
  Parent ID: 3p2J.tH5+ziGnAT8
  SysFS ID: /block/hdc
  SysFS BusID: 1.0
  SysFS Device Link: /devices/pci0000:00/0000:00:1f.1/ide1/1.0
  Hardware Class: cdrom
  Model: "COMPAQ SC-148F"
  Vendor: "COMPAQ"
  Device: "SC-148F"
  Revision: "FA07"
  Serial ID: ""
  Driver: "PIIX_IDE", "ide-cdrom"
  Driver Modules: "piix", "ide_cd"
  Device File: /dev/hdc
  Device Files: /dev/hdc, /dev/disk/by-path/pci-0000:00:1f.1-ide-1:0, /dev/cdrom1
  Device Number: block 22:0
  Size: 0 sectors a 512 bytes
  Drive status: no medium
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #18 (IDE interface)
  Drive Speed: 1

49: USB 00.0: 10a00 Hub
  [Created at usb.122]
  Unique ID: k4bc.x4osGG1+6q8
  Parent ID: fnWp.T65Wf0Mfep6
  SysFS ID: /devices/pci0000:00/0000:00:1f.4/usb1/1-0:1.0
  SysFS BusID: 1-0:1.0
  Hardware Class: hub
  Model: "Linux 2.6.22-3-686 uhci_hcd UHCI Host Controller"
  Hotplug: USB
  Vendor: "Linux 2.6.22-3-686 uhci_hcd"
  Device: "UHCI Host Controller"
  Revision: "2.06"
  Serial ID: "0000:00:1f.4"
  Driver: "hub"
  Driver Modules: "usbcore"
  Speed: 12 Mbps
  Module Alias: "usb:v0000p0000d0206dc09dsc00dp00ic09isc00ip00"
  Driver Info #0:
    Driver Status: usbcore is active
    Driver Activation Cmd: "modprobe usbcore"
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #19 (USB Controller)

50: PS/2 00.0: 10800 Keyboard
  [Created at input.139]
  Unique ID: nLyy.TBWTwSuMeW2
  Hardware Class: keyboard
  Model: "AT Translated Set 2 keyboard"
  Vendor: int 0x0211 
  Device: int 0x0001 "AT Translated Set 2 keyboard"
  Device File: /dev/input/event0
  Device Files: /dev/input/event0, /dev/input/by-path/platform-i8042-serio-0-event-kbd
  Device Number: char 13:64
  Driver Info #0:
    XkbRules: xfree86
    XkbModel: pc104
  Config Status: cfg=new, avail=yes, need=no, active=unknown

51: PS/2 00.0: 10500 PS/2 Mouse
  [Created at input.159]
  Unique ID: AH6Q.GNlNOiDK6yC
  Hardware Class: mouse
  Model: "PS2++ Logitech MX Mouse"
  Vendor: int 0x0210 
  Device: int 0x0018 "PS2++ Logitech MX Mouse"
  Device File: /dev/input/mice (/dev/input/mouse0)
  Device Files: /dev/input/mice, /dev/input/mouse0, /dev/input/event1, /dev/input/by-path/platform-i8042-serio-1-event-mouse, /dev/input/by-path/platform-i8042-serio-1-mouse
  Device Number: char 13:63 (char 13:32)
  Driver Info #0:
    Buttons: 8
    Wheels: 1
    XFree86 Protocol: explorerps/2
    GPM Protocol: exps2
  Config Status: cfg=new, avail=yes, need=no, active=unknown

52: None 00.0: 10103 CPU
  [Created at cpu.305]
  Unique ID: rdCR.j8NaKXDZtZ6
  Hardware Class: cpu
  Arch: Intel
  Vendor: "GenuineIntel"
  Model: 6.8.10 "Celeron (Coppermine)"
  Features: fpu,vme,de,pse,tsc,msr,pae,mce,cx8,apic,sep,mtrr,pge,mca,cmov,pat,pse36,mmx,fxsr,sse,up
  Clock: 847 MHz
  BogoMips: 1696.43
  Cache: 128 kb
  Config Status: cfg=new, avail=yes, need=no, active=unknown

53: None 00.0: 10700 Loopback
  [Created at net.119]
  Unique ID: ZsBS.GQNx7L4uPNA
  SysFS ID: /class/net/lo
  Hardware Class: network interface
  Model: "Loopback network interface"
  Device File: lo
  Link detected: yes
  Config Status: cfg=new, avail=yes, need=no, active=unknown

54: None 00.0: 10701 Ethernet
  [Created at net.119]
  Unique ID: usDW.ndpeucax6V1
  Parent ID: rBUF.xuoNXTox6+6
  SysFS ID: /class/net/eth0
  SysFS Device Link: /devices/pci0000:00/0000:00:1e.0/0000:02:08.0
  Hardware Class: network interface
  Model: "Ethernet network interface"
  Driver: "e100"
  Driver Modules: "e100"
  Device File: eth0
  HW Address: 00:02:a5:10:5a:37
  Link detected: yes
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: #22 (Ethernet controller)

