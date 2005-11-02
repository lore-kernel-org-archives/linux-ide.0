From: Don Carroll <ibedonc@star-c.com>
Subject: Re: Asus A8V , via vt8251 AHCI
Date: Tue, 1 Nov 2005 22:36:43 -0600
Message-ID: <20051102043643.GA5577@vcr.star-c.com>
References: <20051101064058.GA4902@vcr.star-c.com> <Pine.LNX.4.58.0511010736550.11761@shark.he.net> <20051101192449.GA9719@vcr.star-c.com> <Pine.LNX.4.58.0511011237080.11761@shark.he.net> <20051102034151.GA7583@vcr.star-c.com> <20051101195715.212ea264.rdunlap@xenotime.net>
Reply-To: ibedonc@star-c.com, ibedonc@star-c.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dpc6935171158.direcpc.com ([69.35.171.158]:3233 "EHLO
	vcr.star-c.com") by vger.kernel.org with ESMTP id S1751492AbVKBEhL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Nov 2005 23:37:11 -0500
Content-Disposition: inline
In-Reply-To: <20051101195715.212ea264.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-ide@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I think it was , I can try again

the next one is without MSI

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-no-msi.txt"

Bootdata ok (command line is root=/dev/sda1 resume=/dev/sda5)
Linux version 2.6.14 (root@vcr.star-c.com) (gcc version 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0)) #2 SMP Tue Nov 1 21:56:43 CST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
 BIOS-e820: 000000007ffb0000 - 000000007ffbe000 (ACPI data)
 BIOS-e820: 000000007ffbe000 - 000000007ffe0000 (ACPI NVS)
 BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fac60
ACPI: XSDT (v001 A M I  OEMXSDT  0x09000505 MSFT 0x00000097) @ 0x000000007ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x09000505 MSFT 0x00000097) @ 0x000000007ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x09000505 MSFT 0x00000097) @ 0x000000007ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x09000505 MSFT 0x00000097) @ 0x000000007ffbe040
ACPI: DSDT (v001  A0347 A0347001 0x00000001 INTL 0x02002026) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000007ffb0000
Using 20 for the hash shift. Max adder is 7ffb0000 
Using node hash shift of 20
Bootmem setup node 0 0000000000000000-000000007ffb0000
On node 0 totalpages: 524111
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 520112 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Checking aperture...
CPU 0: aperture @ d8000000 size 128 MB
Built 1 zonelists
Kernel command line: root=/dev/sda1 resume=/dev/sda5
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2000.184 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 2057440k/2096832k available (2142k kernel code, 39004k reserved, 755k data, 232k init)
Calibrating delay using timer specific routine.. 4007.36 BogoMIPS (lpj=8014724)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0(2) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.501 MHz APIC timer.
softlockup thread 0 started up.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4000.47 BogoMIPS (lpj=8000946)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 1(2) -> Node 0 -> Core 1
AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -77 cycles, maxerr 545 cycles)
Brought up 2 CPUs
softlockup thread 1 started up.
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7.P7P9._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7.P7P8._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 128M @ 0xd8000000
PCI-DMA: Disabling IOMMU.
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fa900000-fe9fffff
  PREFETCH window: aff00000-cfefffff
PCI: Bridge: 0000:02:00.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:02:00.1
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:13.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:00:13.0 to 64
PCI: Setting latency timer of device 0000:02:00.0 to 64
PCI: Setting latency timer of device 0000:02:00.1 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1130905345.620:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Initializing Cryptographic API
PCI: Setting latency timer of device 0000:02:00.0 to 64
pcie_portdrv_probe->Dev[287c:1106] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Setting latency timer of device 0000:02:00.1 to 64
pcie_portdrv_probe->Dev[287d:1106] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 0
VP_IDE: chipset revision 7
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: Unknown VIA SouthBridge, disabling DMA.
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 7
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: Unknown VIA SouthBridge, disabling DMA.
mice: PS/2 mouse device common for all mice
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
libata version 1.12 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 16
ata1: SATA max UDMA/100 cmd 0xFFFFC20000004C80 ctl 0xFFFFC20000004C8A bmdma 0xFFFFC20000004C00 irq 16
ata2: SATA max UDMA/100 cmd 0xFFFFC20000004CC0 ctl 0xFFFFC20000004CCA bmdma 0xFFFFC20000004C08 irq 16
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
ata1: no device found (phy stat 00000000)
scsi0 : sata_sil
ata2: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3c02 87:4023 88:203f
ata2: dev 0 ATA, max UDMA/100, 488397168 sectors: lba48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
  Vendor: ATA       Model: HDS722525VLSA80   Rev: V36O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 >
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 232k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 20 (level, low) -> IRQ 17
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 1
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 17, io base 0x0000d480
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[C] -> GSI 22 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.1, from 5 to 2
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 18, io base 0x0000d400
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 3
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 19, io base 0x0000d080
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 23 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:10.3, from 3 to 4
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.3: irq 20, io base 0x0000d000
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 22 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:10.4, from 5 to 2
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: debug port 1
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: irq 18, io mem 0xfebdf400
ehci_hcd 0000:00:10.4: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ts: Compaq touchscreen protocol output
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 16 throttling states)
ACPI: CPU1 (power states: C1[C1])
EXT3 FS on sda1, internal journal
Adding 2939852k swap on /dev/sda5.  Priority:-1 extents:1 across:2939852k
Linux video capture interface: v1.00
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: TDK DVDRW0404N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
ahci version 1.01
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 21 (level, low) -> IRQ 19
PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 3
ahci(0000:00:0f.0) AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci(0000:00:0f.0) flags: 64bit ncq pm led clo pmp pio slum part 
ata3: SATA max UDMA/133 cmd 0xFFFFC20000020D00 ctl 0x0 bmdma 0x0 irq 19
ata4: SATA max UDMA/133 cmd 0xFFFFC20000020D80 ctl 0x0 bmdma 0x0 irq 19
ata5: SATA max UDMA/133 cmd 0xFFFFC20000020E00 ctl 0x0 bmdma 0x0 irq 19
ata6: SATA max UDMA/133 cmd 0xFFFFC20000020E80 ctl 0x0 bmdma 0x0 irq 19
ata3: no device found (phy stat 00000000)
scsi2 : ahci
ata4: no device found (phy stat 00000000)
scsi3 : ahci
ata5: no device found (phy stat 00000000)
scsi4 : ahci
ata6 is slow to respond, please be patient
ata6 failed to respond (30 secs)
scsi5 : ahci
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
loop: loaded (max 8 devices)
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
floppy0: no floppy controllers found
floppy0: no floppy controllers found
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
NET: Registered protocol family 17
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 20
PCI: Via IRQ fixup for 0000:00:12.0, from 11 to 4
eth0: VIA Rhine II at 0x1c400, 00:13:d4:a7:d6:43, IRQ 20.
eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link 40a1.
eth0: link up, 100Mbps, half-duplex, lpa 0x40A1
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: Printer, Hewlett-Packard HP LaserJet 6L
lp0: using parport0 (polling).
lp0: console ready
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
via82xx: Assuming DXS channels with 48k fixed sample rate.
         Please try dxs_support=5 option
         and report if it works on your machine.
         For more details, read ALSA-Configuration.txt.
ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 18
PCI: Via IRQ fixup for 0000:00:11.5, from 5 to 2
PCI: Setting latency timer of device 0000:00:11.5 to 64
cdrom: This disc doesn't have any tracks I recognize!
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff80393380(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: recovery directory /var/lib/nfs/v4recovery doesn't exist
NFSD: starting 90-second grace period
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x8 (1350 mV)
powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xa (1300 mV)
powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
cpu_init done, current fid 0xc, vid 0x8
floppy0: no floppy controllers found
floppy0: no floppy controllers found
kdm[3134]: segfault at 0000000000000000 rip 000000000040a90b rsp 00007fffffa9c800 error 4
floppy0: no floppy controllers found
floppy0: no floppy controllers found
floppy0: no floppy controllers found
floppy0: no floppy controllers found
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
kdm[4438]: segfault at 0000000000000000 rip 000000000040a90b rsp 00007fffff8671a0 error 4

--n8g4imXOkfNTN/H1--
