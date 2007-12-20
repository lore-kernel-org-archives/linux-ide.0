From: Andrew Ryder <tireman@shaw.ca>
Subject: Re: Sata 4726 Testing
Date: Thu, 20 Dec 2007 17:23:54 -0500
Message-ID: <476AEB7A.2000403@shaw.ca>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:47119 "EHLO
	pd4mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbXLUDbb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Dec 2007 22:31:31 -0500
Received: from pd2mr3so.prod.shaw.ca
 (pd2mr3so-qfe3.prod.shaw.ca [10.0.141.108]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JTD00GB6R3W10C0@l-daemon> for linux-ide@vger.kernel.org; Thu,
 20 Dec 2007 20:31:08 -0700 (MST)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
 by pd2mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JTD00K7AR31PA10@pd2mr3so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Thu, 20 Dec 2007 20:31:08 -0700 (MST)
Received: from [192.168.0.2] ([70.76.194.32])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JTD00M5UR2YTN00@l-daemon> for linux-ide@vger.kernel.org; Thu,
 20 Dec 2007 20:30:37 -0700 (MST)
In-reply-to: <4769F974.2020905@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

I've attached the boot log from the 2.6.24-rc5 kernel. The problem
repeats itself in the same manner as with the 2.6.23 kernel with the
libata patches.

Here is the info on the sata controller and HPM.

Addonics:

- 4 port Sata II Raid5 HBA with the SIL3124 (ADSA4R5)
- Mini-Storage tower with HPM (AD5SAHPM-E)
- 2 meter eSata cable
- One IDE-Sata converter for each IDE drive (ADIDESA)

I have 4 seagate 300GB IDE drives installed in the storage tower, each
drive has an ide-sata converter installed on it, and the HPM running in
JBOD mode.

I have upgraded the firmware on the HBA to  the latest available from SI
(6.4.09) and the HPM in the storage tower is running the latest version
also (1.2061)

Once the driver has finished attempting to initialize the hardware, the
first hard drive is accessible, the 2nd drive is partially detected, but
unusable. If I try and run fdisk on the 2nd drive, fdisk reports that
"You must set cylinders" before attempting partitioning. The 3rd and 4th
drives are not detected at all.

I have tried the sata controller and HPM under windows 2000, and
everything worked without issue.

I did try previously configuring the HPM in Raid 1 mode to treat the
storage tower as one large disk and this configuration worked without
issue in Linux or windows. Since I returned the unit to JBOD mode, there
have been some additional errors about trying to access beyond the end
of the first drive on the HPM.

If theres any other information you need, please let me know.

Thanks

Here is my system config, software environment and boot logs:


Hardware:
Asus SK8V
Opteron 144
2GB Memory
Adaptec 29160N
1 U160 18GB scsi drive
1 Ultra scsi cd-rom
2 ide drives
2 ide cdroms
Intel Pro/1000 network card
ATI Radeon 9600 AGP
Creative Audigy2 sound card


Here is the output from 'dmesg':

Linux version 2.6.24-rc5 (root@BigMouth) (gcc version 4.1.2 (Gentoo
4.1.2 p1.0.1)) #1 Thu Dec 20 16:29:57 EST 2007
Command line: root=/dev/sda3
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff30000 (usable)
 BIOS-e820: 000000007ff30000 - 000000007ff40000 (ACPI data)
 BIOS-e820: 000000007ff40000 - 000000007fff0000 (ACPI NVS)
 BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524080) 1 entries of 256 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP 000FA850, 0014 (r0 ACPIAM)
ACPI: RSDT 7FF30000, 0030 (r1 A M I  OEMRSDT   6000517 MSFT       97)
ACPI: FACP 7FF30200, 0081 (r1 A M I  OEMFACP   6000517 MSFT       97)
ACPI: DSDT 7FF303F0, 38EA (r1  SK8V_ SK8V_033       33 MSFT  100000D)
ACPI: FACS 7FF40000, 0040
ACPI: APIC 7FF30390, 0052 (r1 A M I  OEMAPIC   6000517 MSFT       97)
ACPI: OEMB 7FF40040, 003F (r1 A M I  OEMBIOS   6000517 MSFT       97)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524080) 1 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524080
On node 0 totalpages: 523983
  DMA zone: 56 pages used for memmap
  DMA zone: 964 pages reserved
  DMA zone: 2979 pages, LIFO batch:0
  DMA32 zone: 7109 pages used for memmap
  DMA32 zone: 512875 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7ff80000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 515854
Kernel command line: root=/dev/sda3
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
TSC calibrated against PM_TIMER
time.c: Detected 1802.294 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ f8000000 size 64 MB
Memory: 2059876k/2096320k available (2288k kernel code, 35684k reserved,
1037k data, 192k init)
Calibrating delay using timer specific routine.. 3608.83 BogoMIPS
(lpj=7217678)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Opteron(tm) Processor 144 stepping 0a
ACPI: Core revision 20070126
Using local APIC timer interrupts.
APIC timer calibration result 12515939
Detected 12.515 MHz APIC timer.
net_namespace: 120 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: enabled onboard AC97/MC97 devices
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 14 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 64M @ 0xf8000000
Time: tsc clocksource has been installed.
system 00:09: ioport range 0x295-0x296 has been reserved
system 00:09: ioport range 0x3e1-0x3e7 has been reserved
system 00:09: ioport range 0x4d0-0x4d1 has been reserved
system 00:09: ioport range 0x800-0x87f has been reserved
system 00:09: ioport range 0x400-0x41f has been reserved
system 00:0a: iomem range 0xfec00000-0xfec00fff has been reserved
system 00:0a: iomem range 0xfee00000-0xfee00fff could not be reserved
system 00:0a: iomem range 0xfff80000-0xffffffff could not be reserved
system 00:0d: iomem range 0x0-0x9ffff could not be reserved
system 00:0d: iomem range 0xc0000-0xdffff has been reserved
system 00:0d: iomem range 0xe0000-0xfffff could not be reserved
system 00:0d: iomem range 0x100000-0x7ffeffff could not be reserved
system 00:0d: iomem range 0x0-0x0 could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: a000-afff
  MEM window: fc500000-fcafffff
  PREFETCH window: b3e00000-f3dfffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1198186556.256:1): initialized
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: VIA PCI bridge detected. Disabling DAC.
Boot video device is 0000:01:00.0
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: module loaded
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VIA8237SATA: IDE controller (0x1106:0x3149 rev 0x80) at  PCI slot
0000:00:0f.0
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 20
VIA8237SATA: 100% native mode on irq 20
    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
VP_IDE: IDE controller (0x1106:0x0571 rev 0x06) at  PCI slot 0000:00:0f.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hdb: Maxtor 4G160J8, ATA DISK drive
hda: ST3200822A, ATA DISK drive
hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hda: UDMA 5 mode selected
hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdb: UDMA 6 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdd: ASUS DVD-E616P2, ATAPI CD/DVD-ROM drive
hdc: ASUS DRW-0402P/D, ATAPI CD/DVD-ROM drive
hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA 2 mode selected
hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdd: drive side 80-wire cable detection failed, limiting max speed to UDMA33
hdd: UDMA 2 mode selected
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
hda: max request size: 512KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63,
UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
hdb: max request size: 512KiB
hdb: 320173056 sectors (163928 MB) w/2048KiB Cache, CHS=19929/255/63,
UDMA(133)
hdb: cache flushes not supported
 hdb: hdb1
hdc: ATAPI 32X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 18
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 29160N Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi 0:0:0:0: Direct-Access     SEAGATE  ST318452LW       0004 PQ: 0 ANSI: 3
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
 target0:0:0: wide asynchronous
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
 target0:0:0: Ending Domain Validation
scsi 0:0:3:0: CD-ROM            YAMAHA   CRW8824S         1.00 PQ: 0 ANSI: 2
 target0:0:3: Beginning Domain Validation
 target0:0:3: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
 target0:0:3: Domain Validation skipping write tests
 target0:0:3: Ending Domain Validation
sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports
DPO and FUA
sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports
DPO and FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
sr0: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
sr 0:0:3:0: Attached scsi CD-ROM sr0
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 33
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ReiserFS: sda3: found reiserfs format "3.6" with standard journal
ReiserFS: sda3: using ordered data mode
ReiserFS: sda3: journal params: device sda3, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 192k freed
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 0:0:3:0: Attached scsi generic sg1 type 5
libata version 3.00 loaded.
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
input: Power Button (FF) as /class/input/input2
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input3
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input4
ACPI: Sleep Button (CM) [SLPB]
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16] 
MMIO=[fd400000-fd4007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
sata_sil24 0000:00:0c.0: version 1.1
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Disallowing DAC for device 0000:00:0c.0
scsi1 : sata_sil24
scsi2 : sata_sil24
scsi3 : sata_sil24
scsi4 : sata_sil24
ata1: SATA max UDMA/100 host m128@0xfd900000 port 0xfd800000 irq 17
ata2: SATA max UDMA/100 host m128@0xfd900000 port 0xfd802000 irq 17
ata3: SATA max UDMA/100 host m128@0xfd900000 port 0xfd804000 irq 17
ata4: SATA max UDMA/100 host m128@0xfd900000 port 0xfd806000 irq 17
input: PC Speaker as /class/input/input5
Floppy drive(s): fd0 is 1.44M
00:0b: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
FDC 0 is a post-1991 82077
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000059341e]
ata1: SATA link down (SStatus 0 SControl 0)
ata2: SATA link down (SStatus 0 SControl 0)
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link down (SStatus 0 SControl 0)
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: irq 21, io base 0x0000b800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: irq 21, io base 0x0000c000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000c400
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.3: irq 21, io base 0x0000c800
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 16 (level, low) -> IRQ 16
Audigy2 value: Special config.
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:10.4: irq 21, io mem 0xfdf00000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 1-1: device not accepting address 2, error -71
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Disallowing DAC for device 0000:00:0e.0
e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
ReiserFS: hdb1: using ordered data mode
ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hdb1: checking transaction log (hdb1)
ReiserFS: hdb1: Using r5 hash to sort names
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first
block 18, max trans len 1024, max batch 900, max commit age 30, max
trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
usb 1-1: new low speed USB device using uhci_hcd and address 4
usb 1-1: configuration #1 chosen from 1 choice
usbcore: registered new interface driver hiddev
input: Das Keyboard as /class/input/input6
input: USB HID v1.11 Keyboard [Das Keyboard] on usb-0000:00:10.0-1
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver





Relevant Syslog messages:

Dec 20 16:37:13 BigMouth kernel: ata1: exception Emask 0x10 SAct 0x0
SErr 0x10000 action 0xa frozen
Dec 20 16:37:13 BigMouth kernel: ata1: irq_stat 0x00a40080, device exchanged
Dec 20 16:37:13 BigMouth kernel: ata1: SError: { PHYRdyChg }
Dec 20 16:37:13 BigMouth kernel: ata1: hard resetting link
Dec 20 16:37:16 BigMouth kernel: ata1: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Dec 20 16:37:16 BigMouth kernel: ata1.15: Port Multiplier 1.1,
0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
Dec 20 16:37:16 BigMouth kernel: ata1.00: hard resetting link
Dec 20 16:37:16 BigMouth kernel: ata1.00: SATA link up 1.5 Gbps (SStatus
113 SControl 320)
Dec 20 16:37:16 BigMouth kernel: ata1.01: hard resetting link
Dec 20 16:37:16 BigMouth kernel: ata1.01: softreset failed (SRST command
error)
Dec 20 16:37:16 BigMouth kernel: ata1.01: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:37:26 BigMouth kernel: ata1.01: hard resetting link
Dec 20 16:37:26 BigMouth apcupsd[5306]: NIS server startup succeeded
Dec 20 16:37:26 BigMouth apcupsd[4755]: apcupsd 3.10.18 (21 July 2005)
gentoo startup succeeded
Dec 20 16:37:26 BigMouth kernel: ata1.01: softreset failed (SRST command
error)
Dec 20 16:37:26 BigMouth kernel: ata1.01: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:37:36 BigMouth kernel: ata1.01: hard resetting link
Dec 20 16:37:36 BigMouth kernel: ata1.01: softreset failed (SRST command
error)
Dec 20 16:37:36 BigMouth kernel: ata1.01: reset failed (errno=-5),
retrying in 35 secs
Dec 20 16:38:11 BigMouth kernel: ata1.01: limiting SATA link speed to
1.5 Gbps
Dec 20 16:38:11 BigMouth kernel: ata1.01: hard resetting link
Dec 20 16:38:11 BigMouth kernel: ata1.01: softreset failed (SRST command
error)
Dec 20 16:38:11 BigMouth kernel: ata1.01: reset failed, giving up
Dec 20 16:38:11 BigMouth kernel: ata1.15: hard resetting link
Dec 20 16:38:11 BigMouth kernel: ata1: controller in dubious state,
performing PORT_RST
Dec 20 16:38:12 BigMouth gconfd (tireman-5363): starting (version
2.18.0.1), pid 5363 user 'tireman'
Dec 20 16:38:12 BigMouth gconfd (tireman-5363): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only
configuration source at position 0
Dec 20 16:38:12 BigMouth gconfd (tireman-5363): Resolved address
"xml:readwrite:/home/tireman/.gconf" to a writable configuration source
at position 1
Dec 20 16:38:12 BigMouth gconfd (tireman-5363): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only
configuration source at position 2
Dec 20 16:38:14 BigMouth kernel: ata1.15: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Dec 20 16:38:14 BigMouth kernel: ata1.00: hard resetting link
Dec 20 16:38:14 BigMouth kernel: ata1.00: SATA link up 1.5 Gbps (SStatus
113 SControl 320)
Dec 20 16:38:14 BigMouth kernel: ata1.01: hard resetting link
Dec 20 16:38:14 BigMouth kernel: ata1.01: softreset failed (SRST command
error)
Dec 20 16:38:14 BigMouth kernel: ata1.01: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:38:24 BigMouth kernel: ata1.01: hard resetting link
Dec 20 16:38:24 BigMouth kernel: ata1.01: softreset failed (SRST command
error)
Dec 20 16:38:24 BigMouth kernel: ata1.01: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:38:34 BigMouth kernel: ata1.01: hard resetting link
Dec 20 16:38:34 BigMouth kernel: ata1.01: softreset failed (SRST command
error)
Dec 20 16:38:34 BigMouth kernel: ata1.01: reset failed (errno=-5),
retrying in 35 secs
Dec 20 16:39:09 BigMouth kernel: ata1.01: hard resetting link
Dec 20 16:39:09 BigMouth kernel: ata1.01: softreset failed (SRST command
error)
Dec 20 16:39:09 BigMouth kernel: ata1.01: reset failed, giving up
Dec 20 16:39:09 BigMouth kernel: ata1.15: hard resetting link
Dec 20 16:39:09 BigMouth kernel: ata1: controller in dubious state,
performing PORT_RST
Dec 20 16:39:12 BigMouth kernel: ata1.15: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Dec 20 16:39:12 BigMouth kernel: ata1.00: hard resetting link
Dec 20 16:39:12 BigMouth kernel: ata1.00: SATA link up 1.5 Gbps (SStatus
113 SControl 320)
Dec 20 16:39:12 BigMouth kernel: ata1.01: hard resetting link
Dec 20 16:39:12 BigMouth kernel: ata1.01: softreset failed (SRST command
error)
Dec 20 16:39:12 BigMouth kernel: ata1.01: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:39:22 BigMouth kernel: ata1.01: hard resetting link
Dec 20 16:39:22 BigMouth kernel: ata1.01: softreset failed (SRST command
error)
Dec 20 16:39:22 BigMouth kernel: ata1.01: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:39:32 BigMouth kernel: ata1.01: hard resetting link
Dec 20 16:39:32 BigMouth kernel: ata1.01: softreset failed (SRST command
error)
Dec 20 16:39:32 BigMouth kernel: ata1.01: reset failed (errno=-5),
retrying in 35 secs
Dec 20 16:40:01 BigMouth cron[5381]: (root) CMD (test -x
/usr/sbin/run-crons && /usr/sbin/run-crons )
Dec 20 16:40:07 BigMouth kernel: ata1.01: hard resetting link
Dec 20 16:40:07 BigMouth kernel: ata1.01: softreset failed (SRST command
error)
Dec 20 16:40:07 BigMouth kernel: ata1.01: reset failed, giving up
Dec 20 16:40:07 BigMouth kernel: ata1.01: failed to recover link after 3
tries, disabling
Dec 20 16:40:07 BigMouth kernel: ata1: failed to recover PMP, retrying
in 5 secs
Dec 20 16:40:12 BigMouth kernel: ata1.15: hard resetting link
Dec 20 16:40:14 BigMouth kernel: ata1.15: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Dec 20 16:40:15 BigMouth kernel: ata1.00: hard resetting link
Dec 20 16:40:15 BigMouth kernel: ata1.00: SATA link up 1.5 Gbps (SStatus
113 SControl 320)
Dec 20 16:40:15 BigMouth kernel: ata1.02: hard resetting link
Dec 20 16:40:15 BigMouth kernel: ata1.02: softreset failed (SRST command
error)
Dec 20 16:40:15 BigMouth kernel: ata1.02: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:40:25 BigMouth kernel: ata1.02: hard resetting link
Dec 20 16:40:25 BigMouth kernel: ata1.02: softreset failed (SRST command
error)
Dec 20 16:40:25 BigMouth kernel: ata1.02: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:40:35 BigMouth kernel: ata1.02: hard resetting link
Dec 20 16:40:35 BigMouth kernel: ata1.02: softreset failed (SRST command
error)
Dec 20 16:40:35 BigMouth kernel: ata1.02: reset failed (errno=-5),
retrying in 35 secs
Dec 20 16:41:10 BigMouth kernel: ata1.02: limiting SATA link speed to
1.5 Gbps
Dec 20 16:41:10 BigMouth kernel: ata1.02: hard resetting link
Dec 20 16:41:10 BigMouth kernel: ata1.02: softreset failed (SRST command
error)
Dec 20 16:41:10 BigMouth kernel: ata1.02: reset failed, giving up
Dec 20 16:41:10 BigMouth kernel: ata1.15: hard resetting link
Dec 20 16:41:13 BigMouth kernel: ata1.15: softreset failed (SRST command
error)
Dec 20 16:41:13 BigMouth kernel: ata1.15: reset failed (errno=-5),
retrying in 8 secs
Dec 20 16:41:20 BigMouth kernel: ata1.15: hard resetting link
Dec 20 16:41:23 BigMouth kernel: ata1.15: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Dec 20 16:41:23 BigMouth kernel: ata1.00: hard resetting link
Dec 20 16:41:23 BigMouth kernel: ata1.00: SATA link up 1.5 Gbps (SStatus
113 SControl 320)
Dec 20 16:41:23 BigMouth kernel: ata1.02: hard resetting link
Dec 20 16:41:24 BigMouth kernel: ata1.02: softreset failed (SRST command
error)
Dec 20 16:41:24 BigMouth kernel: ata1.02: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:41:33 BigMouth kernel: ata1.02: hard resetting link
Dec 20 16:41:34 BigMouth kernel: ata1.02: softreset failed (SRST command
error)
Dec 20 16:41:34 BigMouth kernel: ata1.02: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:41:43 BigMouth kernel: ata1.02: hard resetting link
Dec 20 16:41:44 BigMouth kernel: ata1.02: softreset failed (SRST command
error)
Dec 20 16:41:44 BigMouth kernel: ata1.02: reset failed (errno=-5),
retrying in 35 secs
Dec 20 16:42:18 BigMouth kernel: ata1.02: hard resetting link
Dec 20 16:42:19 BigMouth kernel: ata1.02: softreset failed (SRST command
error)
Dec 20 16:42:19 BigMouth kernel: ata1.02: reset failed, giving up
Dec 20 16:42:19 BigMouth kernel: ata1.15: hard resetting link
Dec 20 16:42:19 BigMouth kernel: ata1: controller in dubious state,
performing PORT_RST
Dec 20 16:42:21 BigMouth kernel: ata1.15: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Dec 20 16:42:21 BigMouth kernel: ata1.00: hard resetting link
Dec 20 16:42:22 BigMouth kernel: ata1.00: SATA link up 1.5 Gbps (SStatus
113 SControl 320)
Dec 20 16:42:22 BigMouth kernel: ata1.02: hard resetting link
Dec 20 16:42:22 BigMouth kernel: ata1.02: softreset failed (SRST command
error)
Dec 20 16:42:22 BigMouth kernel: ata1.02: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:42:32 BigMouth kernel: ata1.02: hard resetting link
Dec 20 16:42:32 BigMouth kernel: ata1.02: softreset failed (SRST command
error)
Dec 20 16:42:32 BigMouth kernel: ata1.02: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:42:42 BigMouth kernel: ata1.02: hard resetting link
Dec 20 16:42:42 BigMouth kernel: ata1.02: softreset failed (SRST command
error)
Dec 20 16:42:42 BigMouth kernel: ata1.02: reset failed (errno=-5),
retrying in 35 secs
Dec 20 16:43:17 BigMouth kernel: ata1.02: hard resetting link
Dec 20 16:43:17 BigMouth kernel: ata1.02: softreset failed (SRST command
error)
Dec 20 16:43:17 BigMouth kernel: ata1.02: reset failed, giving up
Dec 20 16:43:17 BigMouth kernel: ata1.02: failed to recover link after 3
tries, disabling
Dec 20 16:43:17 BigMouth kernel: ata1: failed to recover PMP, retrying
in 5 secs
Dec 20 16:43:22 BigMouth kernel: ata1.15: hard resetting link
Dec 20 16:43:24 BigMouth kernel: ata1.15: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Dec 20 16:43:25 BigMouth kernel: ata1.00: hard resetting link
Dec 20 16:43:25 BigMouth kernel: ata1.00: SATA link up 1.5 Gbps (SStatus
113 SControl 320)
Dec 20 16:43:25 BigMouth kernel: ata1.03: hard resetting link
Dec 20 16:43:26 BigMouth kernel: ata1.03: softreset failed (SRST command
error)
Dec 20 16:43:26 BigMouth kernel: ata1.03: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:43:35 BigMouth kernel: ata1.03: hard resetting link
Dec 20 16:43:35 BigMouth kernel: ata1.03: softreset failed (SRST command
error)
Dec 20 16:43:35 BigMouth kernel: ata1.03: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:43:45 BigMouth kernel: ata1.03: hard resetting link
Dec 20 16:43:46 BigMouth kernel: ata1.03: softreset failed (SRST command
error)
Dec 20 16:43:46 BigMouth kernel: ata1.03: reset failed (errno=-5),
retrying in 35 secs
Dec 20 16:44:20 BigMouth kernel: ata1.03: limiting SATA link speed to
1.5 Gbps
Dec 20 16:44:20 BigMouth kernel: ata1.03: hard resetting link
Dec 20 16:44:20 BigMouth kernel: ata1.03: softreset failed (SRST command
error)
Dec 20 16:44:20 BigMouth kernel: ata1.03: reset failed, giving up
Dec 20 16:44:20 BigMouth kernel: ata1.15: hard resetting link
Dec 20 16:44:20 BigMouth kernel: ata1: controller in dubious state,
performing PORT_RST
Dec 20 16:44:23 BigMouth kernel: ata1.15: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Dec 20 16:44:23 BigMouth kernel: ata1.00: hard resetting link
Dec 20 16:44:24 BigMouth kernel: ata1.00: SATA link up 1.5 Gbps (SStatus
113 SControl 320)
Dec 20 16:44:24 BigMouth kernel: ata1.03: hard resetting link
Dec 20 16:44:24 BigMouth kernel: ata1.03: softreset failed (SRST command
error)
Dec 20 16:44:24 BigMouth kernel: ata1.03: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:44:34 BigMouth kernel: ata1.03: hard resetting link
Dec 20 16:44:34 BigMouth kernel: ata1.03: softreset failed (SRST command
error)
Dec 20 16:44:34 BigMouth kernel: ata1.03: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:44:44 BigMouth kernel: ata1.03: hard resetting link
Dec 20 16:44:44 BigMouth kernel: ata1.03: softreset failed (SRST command
error)
Dec 20 16:44:44 BigMouth kernel: ata1.03: reset failed (errno=-5),
retrying in 35 secs
Dec 20 16:45:19 BigMouth kernel: ata1.03: hard resetting link
Dec 20 16:45:19 BigMouth kernel: ata1.03: softreset failed (SRST command
error)
Dec 20 16:45:19 BigMouth kernel: ata1.03: reset failed, giving up
Dec 20 16:45:19 BigMouth kernel: ata1.15: hard resetting link
Dec 20 16:45:19 BigMouth kernel: ata1: controller in dubious state,
performing PORT_RST
Dec 20 16:45:21 BigMouth kernel: ata1.15: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Dec 20 16:45:22 BigMouth kernel: ata1.00: hard resetting link
Dec 20 16:45:22 BigMouth kernel: ata1.00: SATA link up 1.5 Gbps (SStatus
113 SControl 320)
Dec 20 16:45:22 BigMouth kernel: ata1.03: hard resetting link
Dec 20 16:45:23 BigMouth kernel: ata1.03: softreset failed (SRST command
error)
Dec 20 16:45:23 BigMouth kernel: ata1.03: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:45:32 BigMouth kernel: ata1.03: hard resetting link
Dec 20 16:45:33 BigMouth kernel: ata1.03: softreset failed (SRST command
error)
Dec 20 16:45:33 BigMouth kernel: ata1.03: reset failed (errno=-5),
retrying in 10 secs
Dec 20 16:45:42 BigMouth kernel: ata1.03: hard resetting link
Dec 20 16:45:43 BigMouth kernel: ata1.03: softreset failed (SRST command
error)
Dec 20 16:45:43 BigMouth kernel: ata1.03: reset failed (errno=-5),
retrying in 35 secs
Dec 20 16:46:17 BigMouth kernel: ata1.03: hard resetting link
Dec 20 16:46:18 BigMouth kernel: ata1.03: softreset failed (SRST command
error)
Dec 20 16:46:18 BigMouth kernel: ata1.03: reset failed, giving up
Dec 20 16:46:18 BigMouth kernel: ata1.03: failed to recover link after 3
tries, disabling
Dec 20 16:46:18 BigMouth kernel: ata1: failed to recover PMP, retrying
in 5 secs
Dec 20 16:46:23 BigMouth kernel: ata1.15: hard resetting link
Dec 20 16:46:23 BigMouth kernel: ata1: controller in dubious state,
performing PORT_RST
Dec 20 16:46:25 BigMouth kernel: ata1.15: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Dec 20 16:46:26 BigMouth kernel: ata1.00: hard resetting link
Dec 20 16:46:26 BigMouth kernel: ata1.00: SATA link up 1.5 Gbps (SStatus
113 SControl 320)
Dec 20 16:46:26 BigMouth kernel: ata1.04: hard resetting link
Dec 20 16:46:26 BigMouth kernel: ata1.04: SATA link down (SStatus 0
SControl 320)
Dec 20 16:46:26 BigMouth kernel: ata1.05: hard resetting link
Dec 20 16:46:27 BigMouth kernel: ata1.05: SATA link up 3.0 Gbps (SStatus
123 SControl 0)
Dec 20 16:46:27 BigMouth kernel: ata1.06: hard resetting link
Dec 20 16:46:27 BigMouth kernel: ata1.06: SATA link up 1.5 Gbps (SStatus
113 SControl 320)
Dec 20 16:46:27 BigMouth kernel: ata1.00: ATA-7: ST3300831A, 3.03, max
UDMA/100
Dec 20 16:46:27 BigMouth kernel: ata1.00: 586072368 sectors, multi 0: LBA48
Dec 20 16:46:27 BigMouth kernel: ata1.00: applying bridge limits
Dec 20 16:46:27 BigMouth kernel: ata1.00: configured for UDMA/100
Dec 20 16:46:27 BigMouth kernel: ata1.05: ATA-6: Config  Disk, PLS12061,
max UDMA/133
Dec 20 16:46:27 BigMouth kernel: ata1.05: 640 sectors, multi 1: LBA
Dec 20 16:46:27 BigMouth kernel: ata1.05: device is on DMA blacklist,
disabling DMA
Dec 20 16:46:27 BigMouth kernel: ata1.05: configured for PIO4
Dec 20 16:46:27 BigMouth kernel: ata1.00: exception Emask 0x10 SAct 0x0
SErr 0x0 action 0x1 t4
Dec 20 16:46:27 BigMouth kernel: ata1.00: irq_stat 0x00020002, failed to
transmit command FIS
Dec 20 16:46:27 BigMouth kernel: ata1.00: configured for UDMA/100
Dec 20 16:46:27 BigMouth kernel: ata1: EH complete
Dec 20 16:46:27 BigMouth kernel: scsi 1:0:0:0: Direct-Access    
ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
Dec 20 16:46:27 BigMouth kernel: sd 1:0:0:0: [sdb] 586072368 512-byte
hardware sectors (300069 MB)
Dec 20 16:46:27 BigMouth kernel: sd 1:0:0:0: [sdb] Write Protect is off
Dec 20 16:46:27 BigMouth kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Dec 20 16:46:27 BigMouth kernel: sd 1:0:0:0: [sdb] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Dec 20 16:46:27 BigMouth kernel: sd 1:0:0:0: [sdb] 586072368 512-byte
hardware sectors (300069 MB)
Dec 20 16:46:27 BigMouth kernel: sd 1:0:0:0: [sdb] Write Protect is off
Dec 20 16:46:27 BigMouth kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Dec 20 16:46:27 BigMouth kernel: sd 1:0:0:0: [sdb] Write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Dec 20 16:46:27 BigMouth kernel:  sdb: sdb1
Dec 20 16:46:27 BigMouth kernel:  sdb: p1 exceeds device capacity
Dec 20 16:46:27 BigMouth kernel: sd 1:0:0:0: [sdb] Attached SCSI disk
Dec 20 16:46:27 BigMouth kernel: sd 1:0:0:0: Attached scsi generic sg2
type 0
Dec 20 16:46:27 BigMouth kernel: scsi 1:5:0:0: Direct-Access    
ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
Dec 20 16:46:27 BigMouth kernel: sd 1:5:0:0: [sdc] 640 512-byte hardware
sectors (0 MB)
Dec 20 16:46:27 BigMouth kernel: sd 1:5:0:0: [sdc] Write Protect is off
Dec 20 16:46:27 BigMouth kernel: sd 1:5:0:0: [sdc] Mode Sense: 00 3a 00 00
Dec 20 16:46:27 BigMouth kernel: sd 1:5:0:0: [sdc] Write cache:
disabled, read cache: enabled, doesn't support DPO or FUA
Dec 20 16:46:27 BigMouth kernel: sd 1:5:0:0: [sdc] 640 512-byte hardware
sectors (0 MB)
Dec 20 16:46:27 BigMouth kernel: sd 1:5:0:0: [sdc] Write Protect is off
Dec 20 16:46:27 BigMouth kernel: sd 1:5:0:0: [sdc] Mode Sense: 00 3a 00 00
Dec 20 16:46:27 BigMouth kernel: sd 1:5:0:0: [sdc] Write cache:
disabled, read cache: enabled, doesn't support DPO or FUA
Dec 20 16:46:27 BigMouth kernel:  sdc: unknown partition table
Dec 20 16:46:27 BigMouth kernel: sd 1:5:0:0: [sdc] Attached SCSI disk
Dec 20 16:46:27 BigMouth kernel: sd 1:5:0:0: Attached scsi generic sg3
type 0
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413248, limit=586072368
Dec 20 16:46:27 BigMouth kernel: Buffer I/O error on device sdb1,
logical block 2340413184
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413249, limit=586072368
Dec 20 16:46:27 BigMouth kernel: Buffer I/O error on device sdb1,
logical block 2340413185
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413250, limit=586072368
Dec 20 16:46:27 BigMouth kernel: Buffer I/O error on device sdb1,
logical block 2340413186
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413251, limit=586072368
Dec 20 16:46:27 BigMouth kernel: Buffer I/O error on device sdb1,
logical block 2340413187
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413252, limit=586072368
Dec 20 16:46:27 BigMouth kernel: Buffer I/O error on device sdb1,
logical block 2340413188
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413253, limit=586072368
Dec 20 16:46:27 BigMouth kernel: Buffer I/O error on device sdb1,
logical block 2340413189
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413254, limit=586072368
Dec 20 16:46:27 BigMouth kernel: Buffer I/O error on device sdb1,
logical block 2340413190
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413255, limit=586072368
Dec 20 16:46:27 BigMouth kernel: Buffer I/O error on device sdb1,
logical block 2340413191
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413248, limit=586072368
Dec 20 16:46:27 BigMouth kernel: Buffer I/O error on device sdb1,
logical block 2340413184
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413249, limit=586072368
Dec 20 16:46:27 BigMouth kernel: Buffer I/O error on device sdb1,
logical block 2340413185
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413250, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413251, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413252, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413253, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413254, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413255, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413440, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413441, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413442, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413443, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413444, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413445, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413446, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413447, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413440, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413441, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413442, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413443, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413444, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413445, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413446, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413447, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413456, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413457, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413458, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413459, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413460, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413456, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413457, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413458, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413459, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413460, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413456, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413457, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413458, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413459, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413460, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413456, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413457, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413458, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413459, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413460, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413456, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413457, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413458, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413459, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413460, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413456, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413457, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413458, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413459, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413460, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413456, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413457, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413458, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413459, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413460, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413392, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413393, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413394, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413395, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413396, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413397, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413398, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413399, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413448, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413449, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413450, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413451, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413452, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413453, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413454, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413455, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413456, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413457, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413458, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413459, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413460, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413456, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413457, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413458, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413459, limit=586072368
Dec 20 16:46:27 BigMouth kernel: attempt to access beyond end of device
Dec 20 16:46:27 BigMouth kernel: sdb: rw=0, want=2340413460, limit=586072368















BigMouth scripts # ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux BigMouth 2.6.24-rc5 #1 Thu Dec 20 16:29:57 EST 2007 x86_64 AMD
Opteron(tm)
 Processor 144 AuthenticAMD GNU/Linux
 
Gnu C                  4.1.2
Gnu make               3.81
binutils               2.18
util-linux             2.12r
mount                  2.12r
module-init-tools      3.4
e2fsprogs              1.40.3
reiserfsprogs          3.6.19
PPP                    2.4.4
Linux C Library        2.6.1
Dynamic linker (ldd)   2.6.1
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.13
Sh-utils               6.9
udev                   115
Modules Loaded         smbfs w83627hf hwmon_vid snd_seq_midi
snd_emu10k1_synth s
nd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_pcm_oss
snd_mixer_oss snd_se
q_oss snd_seq_midi_event snd_seq usbhid e1000 8250_pnp floppy pcspkr
i2c_viapro
i2c_core ehci_hcd thermal snd_emu10k1 snd_rawmidi firmware_class
snd_ac97_codec
ac97_bus snd_pcm uhci_hcd snd_seq_device snd_timer snd_page_alloc
snd_util_mem s
nd_hwdep processor sata_sil24 snd soundcore button ohci1394 usbcore
ieee1394 lib
ata sg




BigMouth scripts # cat /proc/version
Linux version 2.6.24-rc5 (root@BigMouth) (gcc version 4.1.2 (Gentoo
4.1.2 p1.0.1)) #1 Thu Dec 20 16:29:57 EST 2007


BigMouth scripts # cat /proc/modules
smbfs 63952 2 - Live 0xffffffff881ce000
w83627hf 26456 0 - Live 0xffffffff881c6000
hwmon_vid 3200 1 w83627hf, Live 0xffffffff88031000
snd_seq_midi 9344 0 - Live 0xffffffff881c2000
snd_emu10k1_synth 7488 0 - Live 0xffffffff881bf000
snd_emux_synth 34304 1 snd_emu10k1_synth, Live 0xffffffff881b5000
snd_seq_virmidi 7360 1 snd_emux_synth, Live 0xffffffff881b2000
snd_seq_midi_emul 6912 1 snd_emux_synth, Live 0xffffffff881af000
snd_pcm_oss 39712 0 - Live 0xffffffff881a4000
snd_mixer_oss 17280 1 snd_pcm_oss, Live 0xffffffff8819e000
snd_seq_oss 31168 0 - Live 0xffffffff88195000
snd_seq_midi_event 8000 3 snd_seq_midi,snd_seq_virmidi,snd_seq_oss, Live
0xffffffff88157000
snd_seq 50176 8
snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_oss,snd_seq_midi_event,
Live 0xffffffff88187000
usbhid 29408 0 - Live 0xffffffff8817e000
e1000 120704 0 - Live 0xffffffff8815f000
8250_pnp 12352 0 - Live 0xffffffff8815a000
floppy 60360 0 - Live 0xffffffff88147000
pcspkr 3200 0 - Live 0xffffffff88145000
i2c_viapro 9496 0 - Live 0xffffffff88141000
i2c_core 25688 1 i2c_viapro, Live 0xffffffff88139000
ehci_hcd 31692 0 - Live 0xffffffff88130000
thermal 18528 0 - Live 0xffffffff8812a000
snd_emu10k1 137120 1 snd_emu10k1_synth, Live 0xffffffff88105000
snd_rawmidi 25696 3 snd_seq_midi,snd_seq_virmidi,snd_emu10k1, Live
0xffffffff880fd000
firmware_class 10816 1 snd_emu10k1, Live 0xffffffff880f9000
snd_ac97_codec 112536 1 snd_emu10k1, Live 0xffffffff880dc000
ac97_bus 2816 1 snd_ac97_codec, Live 0xffffffff880be000
snd_pcm 75724 3 snd_pcm_oss,snd_emu10k1,snd_ac97_codec, Live
0xffffffff880c8000
uhci_hcd 24728 0 - Live 0xffffffff880c0000
snd_seq_device 8916 7
snd_seq_midi,snd_emu10k1_synth,snd_emux_synth,snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi,
Live 0xffffffff880ba000
snd_timer 23176 3 snd_seq,snd_emu10k1,snd_pcm, Live 0xffffffff880b3000
snd_page_alloc 11152 2 snd_emu10k1,snd_pcm, Live 0xffffffff880af000
snd_util_mem 5504 2 snd_emux_synth,snd_emu10k1, Live 0xffffffff880ac000
snd_hwdep 10696 2 snd_emux_synth,snd_emu10k1, Live 0xffffffff880a8000
processor 30848 1 thermal, Live 0xffffffff8809d000
sata_sil24 17860 0 - Live 0xffffffff88097000
snd 60392 13
snd_emux_synth,snd_seq_virmidi,snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi,snd_ac97_codec,snd_pcm,snd_seq_device,snd_timer,snd_hwdep,
Live 0xffffffff88087000
soundcore 8672 1 snd, Live 0xffffffff88083000
button 9760 0 - Live 0xffffffff8807d000
ohci1394 31860 0 - Live 0xffffffff88074000
usbcore 145296 4 usbhid,ehci_hcd,uhci_hcd, Live 0xffffffff8804d000
ieee1394 94168 1 ohci1394, Live 0xffffffff88033000
libata 154512 1 sata_sil24, Live 0xffffffff8800a000
sg 33080 0 - Live 0xffffffff88000000




BigMouth scripts # cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : 0000:00:0f.1
  0170-0177 : ide1
01f0-01f7 : 0000:00:0f.1
  01f0-01f7 : ide0
0295-0296 : w83627hf
  0295-0296 : pnp 00:09
    0295-0296 : w83627hf
02f8-02ff : serial
0376-0376 : 0000:00:0f.1
  0376-0376 : ide1
03c0-03df : vga+
03e1-03e7 : pnp 00:09
03f2-03f5 : floppy
03f6-03f6 : 0000:00:0f.1
  03f6-03f6 : ide0
03f7-03f7 : floppy DIR
03f8-03ff : serial
0400-041f : pnp 00:09
  0400-0407 : vt596_smbus
04d0-04d1 : pnp 00:09
0800-087f : pnp 00:09
  0800-0803 : ACPI PM1a_EVT_BLK
  0804-0805 : ACPI PM1a_CNT_BLK
  0808-080b : ACPI PM_TMR
  0820-0823 : ACPI GPE0_BLK
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:11.5
1400-14ff : 0000:00:11.6
5010-5015 : ACPI CPU throttle
a000-afff : PCI Bus #01
  a000-a0ff : 0000:01:00.0
b000-b0ff : 0000:00:0d.0
b400-b43f : 0000:00:0e.0
  b400-b43f : e1000
b800-b81f : 0000:00:10.0
  b800-b81f : uhci_hcd
c000-c01f : 0000:00:10.1
  c000-c01f : uhci_hcd
c400-c41f : 0000:00:10.2
  c400-c41f : uhci_hcd
c800-c81f : 0000:00:10.3
  c800-c81f : uhci_hcd
cc00-cc7f : 0000:00:07.0
d000-d0ff : 0000:00:0f.0
d400-d40f : 0000:00:0f.0
  d400-d407 : ide2
  d408-d40f : ide3
d800-d803 : 0000:00:0f.0
dc00-dc3f : 0000:00:09.0
  dc00-dc3f : EMU10K1
e000-e007 : 0000:00:0f.0
e400-e403 : 0000:00:0f.0
e800-e807 : 0000:00:0f.0
ec00-ec0f : 0000:00:0c.0
fc00-fc0f : 0000:00:0f.1
  fc00-fc07 : ide0
  fc08-fc0f : ide1



BigMouth scripts # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000c0000-000dffff : pnp 00:0d
000e4000-000fffff : reserved
00100000-7ff2ffff : System RAM
  00200000-0043c26b : Kernel code
  0043c26c-0053f94f : Kernel data
  00579000-005bc997 : Kernel bss
7ff30000-7ff3ffff : ACPI Tables
7ff40000-7ffeffff : ACPI Non-volatile Storage
7fff0000-7fffffff : reserved
b3e00000-f3dfffff : PCI Bus #01
  d0000000-dfffffff : 0000:01:00.1
  e0000000-efffffff : 0000:01:00.0
f8000000-fbffffff : GART
  f8000000-fbffffff : aperture
fc500000-fcafffff : PCI Bus #01
  fc800000-fc80ffff : 0000:01:00.1
  fc900000-fc91ffff : 0000:01:00.0
  fca00000-fca0ffff : 0000:01:00.0
fd400000-fd4007ff : 0000:00:07.0
  fd400000-fd4007ff : ohci1394
fd700000-fd77ffff : 0000:00:0c.0
fd800000-fd807fff : 0000:00:0c.0
  fd800000-fd807fff : sata_sil24
fd900000-fd90007f : 0000:00:0c.0
  fd900000-fd90007f : sata_sil24
fda00000-fda1ffff : 0000:00:0d.0
fdb00000-fdb00fff : 0000:00:0d.0
  fdb00000-fdb00fff : aic7xxx
fdc00000-fdc1ffff : 0000:00:0e.0
fdd00000-fdd1ffff : 0000:00:0e.0
  fdd00000-fdd1ffff : e1000
fde00000-fde1ffff : 0000:00:0e.0
  fde00000-fde1ffff : e1000
fdf00000-fdf000ff : 0000:00:10.4
  fdf00000-fdf000ff : ehci_hcd
fec00000-fec00fff : IOAPIC 0
  fec00000-fec00fff : pnp 00:0a
fee00000-fee00fff : Local APIC
fff80000-ffffffff : reserved




BigMouth scripts # lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host
Bridge (rev 01)
    Subsystem: ASUSTeK Computer Inc. K8V Deluxe/K8V-X motherboard
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 64
    Region 0: Memory at <ignored> (32-bit, prefetchable)
    Capabilities: [80] AGP version 3.5
        Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans-
64bit- FW+ AGP3+ Rate=x8
        Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
    Capabilities: [c0] HyperTransport: Slave or Primary Interface
        !!! Possibly incomplete decoding
        Command: BaseUnitID=0 UnitCnt=3 MastHost- DefDir-
        Link Control 0: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
        Link Config 0: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
        Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
        Link Config 1: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
        Revision ID: 1.02
    Capabilities: [68] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [58] HyperTransport: Interrupt Discovery and Configuration

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge
[K8T800/K8T890 South] (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000a000-0000afff
    Memory behind bridge: fc500000-fcafffff
    Prefetchable memory behind bridge: b3e00000-f3dfffff
    Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 80) (prog-if 10 [OHCI])
    Subsystem: ASUSTeK Computer Inc. A8V Deluxe
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (8000ns max), Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at fd400000 (32-bit, non-prefetchable) [size=2K]
    Region 1: I/O ports at cc00 [size=128]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Creative Labs SB0400 Audigy2 Value
    Subsystem: Creative Labs Unknown device 1001
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (500ns min, 5000ns max)
    Interrupt: pin A routed to IRQ 16
    Region 0: I/O ports at dc00 [size=64]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 RAID bus controller: Silicon Image, Inc. SiI 3124 PCI-X Serial
ATA Controller (rev 02)
    Subsystem: Silicon Image, Inc. Unknown device 7124
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
Stepping+ SERR+ FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 17
    Region 0: Memory at fd900000 (64-bit, non-prefetchable) [size=128]
    Region 2: Memory at fd800000 (64-bit, non-prefetchable) [size=32K]
    Region 4: I/O ports at ec00 [size=16]
    Expansion ROM at fd700000 [disabled] [size=512K]
    Capabilities: [64] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=1 PME-
    Capabilities: [40] PCI-X non-bridge device
        Command: DPERE- ERO+ RBC=512 OST=12
        Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple
DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 533MHz-
    Capabilities: [54] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Address: 0000000000000000  Data: 0000

00:0d.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
    Subsystem: Adaptec 29160N Ultra160 SCSI Controller
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (10000ns min, 6250ns max), Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 18
    BIST result: 00
    Region 0: I/O ports at b000 [disabled] [size=256]
    Region 1: Memory at fdb00000 (64-bit, non-prefetchable) [size=4K]
    Expansion ROM at fda00000 [disabled] [size=128K]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit
Ethernet Controller
    Subsystem: Intel Corporation PRO/1000 MT Desktop Adapter
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (63750ns min), Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 19
    Region 0: Memory at fde00000 (32-bit, non-prefetchable) [size=128K]
    Region 1: Memory at fdd00000 (32-bit, non-prefetchable) [size=128K]
    Region 2: I/O ports at b400 [size=64]
    Expansion ROM at fdc00000 [disabled] [size=128K]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=1 PME-
    Capabilities: [e4] PCI-X non-bridge device
        Command: DPERE- ERO+ RBC=512 OST=1
        Status: Dev=00:00.0 64bit- 133MHz- SCD- USC- DC=simple
DMMRBC=2048 DMOST=1 DMCRS=8 RSCEM- 266MHz- 533MHz-
    Capabilities: [f0] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Address: 0000000000000000  Data: 0000

00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID
Controller (rev 80)
    Subsystem: ASUSTeK Computer Inc. A7V600/K8V Deluxe/K8V-X/A8V Deluxe
motherboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64
    Interrupt: pin B routed to IRQ 20
    Region 0: I/O ports at e800 [size=8]
    Region 1: I/O ports at e400 [size=4]
    Region 2: I/O ports at e000 [size=8]
    Region 3: I/O ports at d800 [size=4]
    Region 4: I/O ports at d400 [size=16]
    Region 5: I/O ports at d000 [size=256]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
    Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Interrupt: pin A routed to IRQ 20
    Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable)
[size=8]
    Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable)
[size=1]
    Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable)
[size=8]
    Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable)
[size=1]
    Region 4: I/O ports at fc00 [size=16]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81) (prog-if 00 [UHCI])
    Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 21
    Region 4: I/O ports at b800 [size=32]
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81) (prog-if 00 [UHCI])
    Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 21
    Region 4: I/O ports at c000 [size=32]
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81) (prog-if 00 [UHCI])
    Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin B routed to IRQ 21
    Region 4: I/O ports at c400 [size=32]
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 81) (prog-if 00 [UHCI])
    Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin B routed to IRQ 21
    Region 4: I/O ports at c800 [size=32]
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if
20 [EHCI])
    Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin C routed to IRQ 21
    Region 0: Memory at fdf00000 (32-bit, non-prefetchable) [size=256]
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
[KT600/K8T800/K8T890 South]
    Subsystem: ASUSTeK Computer Inc. A7V600/K8V-X/A8V Deluxe motherboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
    Subsystem: ASUSTeK Computer Inc. Unknown device 80f3
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin C routed to IRQ 0
    Region 0: I/O ports at 1000 [disabled] [size=256]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem
Controller (rev 80)
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin C routed to IRQ 0
    Region 0: I/O ports at 1400 [disabled] [size=256]
    Capabilities: [d0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Capabilities: [80] HyperTransport: Host or Secondary Interface
        !!! Possibly incomplete decoding
        Command: WarmRst+ DblEnd-
        Link Control: CFlE- CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
        Link Config: MLWI=16bit MLWO=16bit LWI=16bit LWO=16bit
        Revision ID: 1.02
    Capabilities: [a0] HyperTransport: Host or Secondary Interface
        !!! Possibly incomplete decoding
        Command: WarmRst+ DblEnd-
        Link Control: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
        Link Config: MLWI=16bit MLWO=16bit LWI=N/C LWO=N/C
        Revision ID: 1.02
    Capabilities: [c0] HyperTransport: Host or Secondary Interface
        !!! Possibly incomplete decoding
        Command: WarmRst+ DblEnd-
        Link Control: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0
        Link Config: MLWI=16bit MLWO=16bit LWI=N/C LWO=N/C
        Revision ID: 1.02

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: ATI Technologies Inc RV350 AQ [Radeon
9600] (prog-if 00 [VGA])
    Subsystem: ASUSTeK Computer Inc. A9600SE
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (2000ns min), Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
    Region 1: I/O ports at a000 [size=256]
    Region 2: Memory at fca00000 (32-bit, non-prefetchable) [size=64K]
    Expansion ROM at fc900000 [disabled] [size=128K]
    Capabilities: [58] AGP version 3.0
        Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW+ AGP3+ Rate=x4,x8
        Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc RV350 AQ [Radeon 9600]
(Secondary)
    Subsystem: ASUSTeK Computer Inc. A9600SE (Secondary)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (2000ns min), Cache Line Size: 64 bytes
    Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
    Region 1: Memory at fc800000 (32-bit, non-prefetchable) [size=64K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-



BigMouth scripts # cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST318452LW       Rev: 0004
  Type:   Direct-Access                    ANSI  SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW8824S         Rev: 1.00
  Type:   CD-ROM                           ANSI  SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3300831A       Rev: 3.03
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 05 Id: 00 Lun: 00
  Vendor: ATA      Model: Config  Disk     Rev: PLS1
  Type:   Direct-Access                    ANSI  SCSI revision: 05








Tejun Heo wrote:
> Andrew Ryder wrote:
>   
>> Hello,
>>
>> Are you still looking an extra person to test your driver for the
>> SiliconImage 4726?
>>
>> I have a Sil3124 raid controller and a mini-storage tower with the
>> sil4726 hardware Port-Multiplier, both from Addonics.
>>
>> So far I havn't been able to get my hardware combination to work, I have
>> applied your latest patch to the 2.6.23 kernel and only the first drive
>> on the HPM (I have 4 300gb drives installed) is detected and usable. The
>> 2nd drive is partially detected, but does not work.
>>     
>
> I have reports of detection failure but yours sounds like PMP support is
> not there at all.  Please
>
> * cc linux-ide@vger.kernel.org
>
> * try 2.6.24-rc5 and post the kernel boot log
>
>   

