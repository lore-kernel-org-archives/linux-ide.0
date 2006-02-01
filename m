From: Michal Sojka <sojkam1@fel.cvut.cz>
Subject: sata_mv and MV88SX6041 don't work
Date: Wed, 1 Feb 2006 15:43:00 +0100
Message-ID: <200602011543.00647.sojkam1@fel.cvut.cz>
Reply-To: sojkam1@fel.cvut.cz
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0jM4DDlWfsMhC+T"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay.felk.cvut.cz ([147.32.80.7]:15298 "EHLO
	relay.felk.cvut.cz") by vger.kernel.org with ESMTP id S1161072AbWBAO5D
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Feb 2006 09:57:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, kelbelj@fel.cvut.cz

--Boundary-00=_0jM4DDlWfsMhC+T
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

we have problems with this SATA controller:

0000:03:03.0 RAID bus controller: Marvell Technology Group Ltd. MV88SX6041 
4-port SATA II PCI-X Controller (rev 03)

Is there any chance that this hardware will be supported by sata_mv in near 
future? Can we help somehow with debugging? Here is the excerpt from 
2.6.16-rc1 boot messages (the full boot log is attached):

sata_mv 0000:03:03.0: version 0.5
...
sata_mv 0000:03:03.0: Applying B2 workarounds to unknown rev
sata_mv 0000:03:03.0: 32 slots 4 ports unknown mode IRQ via MSI
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A2120 bmdma 0x0 irq 185
...
ata1: dev 0 ATA-6, max UDMA/133, 72303840 sectors: LBA48
ata1: qc timeout (cmd 0xef)
ata1: failed to set xfermode, disabled
ata1: dev 0 configured for UDMA/133


We are currently using GPL driver from Marvell 
(http://www.keffective.com/mvsata/FC3/mvSata_Linux_3.6.1.tgz) but we are able 
to compile it only under 2.6.11. This driver had to be patched to support our 
revision 3. The original driver supports only revisions greater than 9. Does 
anybody know whether this is a bug of the driver or there is some reason why 
lower revisions are not supported?

We tried it also under 2.6.14 but we did not succeed. It would be nice if we 
can have this hardware working under newer kernels since we have another 
problems which are hopefully solved there.

Please CC me when replying to this e-mail.

Thanks
-- 
Michal Sojka, PhD student
Department of Control Engineering, Faculty of Electrical Engineering
Czech Technical University in Prague
http://rtlab.felk.cvut.cz/

--Boundary-00=_0jM4DDlWfsMhC+T
Content-Type: text/x-log;
  charset="us-ascii";
  name="sata_mv-boot.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sata_mv-boot.log"

Bootdata ok (command line is root=3D/dev/sda2 ro vga=3D1 console=3DttyS0)
Linux version 2.6.16-rc1 (root@rtower) (gcc version 4.0.3 20051201 (prerele=
ase) (Debian 4.0.2-5)) #1 SMP Mon Jan 30 10:39:13 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
 BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: Node 0 PXM 0 100000-40000000
SRAT: Node 1 PXM 1 40000000-80000000
SRAT: Node 0 PXM 0 0-40000000
Bootmem setup node 0 0000000000000000-0000000040000000
Bootmem setup node 1 0000000040000000-000000007fff0000
ACPI: PM-Timer IO Port: 0x5008
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x07] address[0xfebfe000] gsi_base[40])
IOAPIC[1]: apic_id 7, version 17, address 0xfebfe000, GSI 40-46
ACPI: IOAPIC (id[0x08] address[0xfebff000] gsi_base[47])
IOAPIC[2]: apic_id 8, version 17, address 0xfebff000, GSI 47-53
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7f780000)
Checking aperture...
CPU 0: aperture @ 9980000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 2 zonelists
Kernel command line: root=3D/dev/sda2 ro vga=3D1 console=3DttyS0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2205.016 MHz processor.
Console: colour VGA+ 80x50
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
PCI-DMA: Disabling IOMMU.
Memory: 2059036k/2097088k available (3301k kernel code, 37664k reserved, 14=
02k data, 260k init)
Calibrating delay using timer specific routine.. 4419.03 BogoMIPS (lpj=3D88=
38071)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
mtrr: v2.0 (20020519)
Using local APIC timer interrupts.
Detected 12.528 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4410.33 BogoMIPS (lpj=3D88=
20663)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 248 stepping 0a
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 1198 cycles)
Brought up 2 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... OK.
migration_cost=3D510
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
PCI: Bridge: 0000:00:01.0
  IO window: b000-bfff
  MEM window: fe900000-feafffff
  PREFETCH window: ff500000-ff5fffff
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: fe800000-fe8fffff
  PREFETCH window: ff400000-ff4fffff
PCI: Bridge: 0000:00:06.0
  IO window: a000-afff
  MEM window: fc700000-fe7fffff
  PREFETCH window: disabled.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1138803447.028:1): initialized
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12ac
hpet_acpi_add: no address or irqs in _CRS
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Software Watchdog Timer: 0.07 initialized. soft_noboot=3D0 soft_margin=3D60=
 sec (nowayout=3D 0)
Linux agpgart interface v0.101 (c) Dave Jones
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
Copyright (c) 1999-2005 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
tg3.c:v3.47 (Dec 28, 2005)
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 49 (level, low) -> IRQ 169
eth0: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:133MHz:64-bit) 1=
0/100/1000BaseT Ethernet 00:30:48:57:03:2e
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap=
[0]
eth0: dma_rwctrl[769f4000]
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:02:03.1[B] -> GSI 50 (level, low) -> IRQ 177
eth1: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:133MHz:64-bit) 1=
0/100/1000BaseT Ethernet 00:30:48:57:03:2f
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap=
[1]
eth1: dma_rwctrl[769f4000]
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.49.
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: CD-224E, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
sata_mv 0000:03:03.0: version 0.5
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 42 (level, low) -> IRQ 185
sata_mv 0000:03:03.0: Applying B2 workarounds to unknown rev
sata_mv 0000:03:03.0: 32 slots 4 ports unknown mode IRQ via MSI
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A2120 bmdma 0x0 irq 185
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A4120 bmdma 0x0 irq 185
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A6120 bmdma 0x0 irq 185
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A8120 bmdma 0x0 irq 185
ata1: dev 0 ATA-6, max UDMA/133, 72303840 sectors: LBA48
ata1: qc timeout (cmd 0xef)
ata1: failed to set xfermode, disabled
ata1: dev 0 configured for UDMA/133
scsi0 : sata_mv
ata2: no device found (phy stat 00000000)
scsi1 : sata_mv
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
usbmon: debugfs is not available
GSI 19 sharing vector 0xD1 and IRQ 19
ACPI: PCI Interrupt 0000:01:00.0[D] -> GSI 19 (level, low) -> IRQ 209
ohci_hcd 0000:01:00.0: OHCI Host Controller
ohci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:01:00.0: irq 209, io mem 0xfe7fe000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:01:00.1[D] -> GSI 19 (level, low) -> IRQ 209
ohci_hcd 0000:01:00.1: OHCI Host Controller
ohci_hcd 0000:01:00.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:01:00.1: irq 209, io mem 0xfe7fd000
usb 1-1: new low speed USB device using ohci_hcd and address 2
usb usb2: configuration #1 chosen from 1 choice
usb 1-1: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
USB Universal Host Controller Interface driver v2.3
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: Logitech USB-PS/2 Optical Mouse as /class/input/input0
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:01=
:00.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
oprofile: using NMI interrupt.
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input1
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.60.0)
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Insert root floppy and press ENTER
=B8=B9Y=AE.=A4U%=D5=A4=D4=A4^D=FFend_request: I/O error, dev fd0, sector 0
VFS: Cannot open root device "sda2" or unknown-block(2,0)
Please append a correct "root=3D" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2=
,0)

--Boundary-00=_0jM4DDlWfsMhC+T--
