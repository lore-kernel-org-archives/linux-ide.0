From: "James  C. Bevier" <jbev@jbsys.com>
Subject: Re: Pata support on Promise controller under Fedora Core 3
Date: Wed, 27 Oct 2004 09:05:03 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <003201c4bc3e$b83df940$0a01a8c0@jbsys.com>
References: <20041027135800.77927.qmail@web88007.mail.re2.yahoo.com> <417FABF4.6050008@pobox.com>
Reply-To: "James  C. Bevier" <jbev@jbsys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002F_01C4BC04.0B7FC330"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 24-117-200-54.cpe.cableone.net ([24.117.200.54]:62871 "EHLO
	hipeak.jbsys.com") by vger.kernel.org with ESMTP id S262473AbUJ0QFG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Oct 2004 12:05:06 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Ericisko <linux2@rogers.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_002F_01C4BC04.0B7FC330
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit


----- Original Message ----- 
From: "Jeff Garzik" <jgarzik@pobox.com>
To: "Ericisko" <linux2@rogers.com>
Cc: "James C. Bevier" <jbev@jbsys.com>; <linux-ide@vger.kernel.org>
Sent: Wednesday, October 27, 2004 7:08 AM
Subject: Re: Pata support on Promise controller under Fedora Core 3


> Ericisko wrote:
>> James,
>> 
>> you have the same controller as me (PDC20378) which
>> has only 1 PATA port. PATA ports support up to 2
>> devices per port, as opposed to SATA ports which
>> support only 1 device per port.
>> There is source code for 2.4 linux driver on Promise
>> web site, you can have a look.
>> Could you send your dmesg output?
> 
> 
> Note that PDC2037x has a "dual master mode", where two PATA devices 
> (master/slave) on the same cable can be made to look like two 
> independent PATA masters, thus giving the illusion that there are two ports.
> 
> Jeff
>

Here is the dmesg output.  The Promise controller is built into the ASUS mb.
If the one port can have two drives, there must be some more status that
can be read to see if two drives are present.  The current code does not
seem to do anything like that.  Where can I go from here?

Jim
------=_NextPart_000_002F_01C4BC04.0B7FC330
Content-Type: text/plain;
	format=flowed;
	name="dmesg.txt";
	reply-type=response
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.txt"

Bootdata ok (command line is ro root=3D/dev/hdb7)=0A=
Linux version 2.6.9-1.643.pata (root@jbsys) (gcc version 3.4.2 20041017 =
(Red Hat 3.4.2-6)) #1 Tue Oct 26 13:54:53 MST 2004=0A=
BIOS-provided physical RAM map:=0A=
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)=0A=
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)=0A=
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)=0A=
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)=0A=
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)=0A=
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)=0A=
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)=0A=
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)=0A=
No mptable found.=0A=
On node 0 totalpages: 261936=0A=
  DMA zone: 4096 pages, LIFO batch:1=0A=
  Normal zone: 257840 pages, LIFO batch:16=0A=
  HighMem zone: 0 pages, LIFO batch:1=0A=
ACPI: RSDP (v000 ACPIAM                                ) @ =
0x00000000000fa8b0=0A=
ACPI: RSDT (v001 A M I  OEMRSDT  0x08000403 MSFT 0x00000097) @ =
0x000000003ff30000=0A=
ACPI: FADT (v001 A M I  OEMFACP  0x08000403 MSFT 0x00000097) @ =
0x000000003ff30200=0A=
ACPI: MADT (v001 A M I  OEMAPIC  0x08000403 MSFT 0x00000097) @ =
0x000000003ff30390=0A=
ACPI: OEMB (v001 A M I  OEMBIOS  0x08000403 MSFT 0x00000097) @ =
0x000000003ff40040=0A=
ACPI: DSDT (v001  A0058 A0058002 0x00000002 MSFT 0x0100000d) @ =
0x0000000000000000=0A=
ACPI: Local APIC address 0xfee00000=0A=
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)=0A=
Processor #0 15:4 APIC version 16=0A=
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])=0A=
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23=0A=
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)=0A=
ACPI: IRQ0 used by override.=0A=
ACPI: IRQ2 used by override.=0A=
ACPI: IRQ9 used by override.=0A=
Using ACPI (MADT) for SMP configuration information=0A=
Checking aperture...=0A=
CPU 0: aperture @ f8000000 size 64 MB=0A=
Built 1 zonelists=0A=
Kernel command line: ro root=3D/dev/hdb7 console=3Dtty0=0A=
Initializing CPU#0=0A=
PID hash table entries: 4096 (order: 12, 131072 bytes)=0A=
time.c: Using 1.193182 MHz PIT timer.=0A=
time.c: Detected 2100.101 MHz processor.=0A=
Console: colour VGA+ 80x25=0A=
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)=0A=
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)=0A=
Memory: 1024012k/1047744k available (2469k kernel code, 23012k reserved, =
1311k data, 164k init)=0A=
Calibrating delay loop... 4128.76 BogoMIPS (lpj=3D2064384)=0A=
Security Scaffold v1.0.0 initialized=0A=
SELinux:  Initializing.=0A=
SELinux:  Starting in permissive mode=0A=
There is already a security framework initialized, register_security =
failed.=0A=
selinux_register_security:  Registering secondary module capability=0A=
Capability LSM initialized as secondary=0A=
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)=0A=
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)=0A=
CPU: L2 Cache: 1024K (64 bytes/line)=0A=
CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08=0A=
Using local APIC NMI watchdog using perfctr0=0A=
Using local APIC timer interrupts.=0A=
Detected 13.125 MHz APIC timer.=0A=
checking if image is initramfs... it is=0A=
NET: Registered protocol family 16=0A=
PCI: Using configuration type 1=0A=
mtrr: v2.0 (20020519)=0A=
ACPI: Subsystem revision 20040816=0A=
ACPI: Interpreter enabled=0A=
ACPI: Using IOAPIC for interrupt routing=0A=
ACPI: PCI Root Bridge [PCI0] (00:00)=0A=
PCI: Probing PCI hardware (bus 00)=0A=
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]=0A=
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 14 15)=0A=
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 14 15)=0A=
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11 14 15)=0A=
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.=0A=
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 14 15) *0, disabled.=0A=
usbcore: registered new driver usbfs=0A=
usbcore: registered new driver hub=0A=
PCI: Using ACPI for IRQ routing=0A=
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 169=0A=
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 177=0A=
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 185=0A=
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 177=0A=
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 193=0A=
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 193=0A=
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 201=0A=
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 201=0A=
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 201=0A=
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 201=0A=
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 201=0A=
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 209=0A=
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169=0A=
agpgart: Detected AGP bridge 0=0A=
agpgart: Maximum main memory to use for agp memory: 941M=0A=
agpgart: AGP aperture is 64M @ 0xf8000000=0A=
PCI-DMA: Disabling IOMMU.=0A=
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $=0A=
audit: initializing netlink socket (disabled)=0A=
audit(1098802611.202:0): initialized=0A=
Total HugeTLB memory allocated, 0=0A=
VFS: Disk quotas dquot_6.5.1=0A=
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)=0A=
NTFS driver 2.1.20 [Flags: R/W].=0A=
SELinux:  Registering netfilter hooks=0A=
Initializing Cryptographic API=0A=
ksign: Installing public key data=0A=
Loading keyring=0A=
- Added public key E678DFAC3562A82=0A=
  - key was been created 21251 seconds in future=0A=
- User ID: Red Hat, Inc. (Kernel Module GPG key)=0A=
PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 9=0A=
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 9=0A=
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 9=0A=
PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 9=0A=
pci_hotplug: PCI Hot Plug PCI Core version: 0.5=0A=
vesafb: probe of vesafb0 failed with error -6=0A=
ACPI: Processor [CPU1] (supports C1)=0A=
Real Time Clock Driver v1.12=0A=
Linux agpgart interface v0.100 (c) Dave Jones=0A=
serio: i8042 AUX port at 0x60,0x64 irq 12=0A=
serio: i8042 KBD port at 0x60,0x64 irq 1=0A=
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled=0A=
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=0A=
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A=0A=
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize=0A=
divert: not allocating divert_blk for non-ethernet device lo=0A=
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
VP_IDE: IDE controller at PCI slot 0000:00:0f.1=0A=
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 193=0A=
VP_IDE: chipset revision 6=0A=
VP_IDE: not 100% native mode: will probe irqs later=0A=
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1=0A=
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:DMA=0A=
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA=0A=
Probing IDE interface ide0...=0A=
hda: Maxtor 6Y080P0, ATA DISK drive=0A=
hdb: WDC WD300BB-32AUA1, ATA DISK drive=0A=
Using cfq io scheduler=0A=
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0A=
Probing IDE interface ide1...=0A=
hdc: JLMS XJ-HD166S, ATAPI CD/DVD-ROM drive=0A=
hdd: _NEC DVD_RW ND-2500A, ATAPI CD/DVD-ROM drive=0A=
ide1 at 0x170-0x177,0x376 on irq 15=0A=
Probing IDE interface ide2...=0A=
ide2: Wait for ready failed before probe !=0A=
Probing IDE interface ide3...=0A=
ide3: Wait for ready failed before probe !=0A=
Probing IDE interface ide4...=0A=
ide4: Wait for ready failed before probe !=0A=
Probing IDE interface ide5...=0A=
ide5: Wait for ready failed before probe !=0A=
hda: max request size: 128KiB=0A=
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=3D65535/16/63, =
UDMA(133)=0A=
hda: cache flushes supported=0A=
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >=0A=
hdb: max request size: 128KiB=0A=
hdb: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=3D58168/16/63, =
UDMA(100)=0A=
hdb: cache flushes not supported=0A=
 hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 >=0A=
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)=0A=
Uniform CD-ROM driver Revision: 3.20=0A=
hdd: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)=0A=
ide-floppy driver 0.99.newide=0A=
usbcore: registered new driver hiddev=0A=
usbcore: registered new driver usbhid=0A=
drivers/usb/input/hid-core.c: v2.0:USB HID core driver=0A=
mice: PS/2 mouse device common for all mice=0A=
input: AT Translated Set 2 keyboard on isa0060/serio0=0A=
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1=0A=
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27=0A=
NET: Registered protocol family 2=0A=
IP: routing cache hash table of 1024 buckets, 56Kbytes=0A=
TCP: Hash tables configured (established 262144 bind 37449)=0A=
Initializing IPsec netlink socket=0A=
NET: Registered protocol family 1=0A=
NET: Registered protocol family 17=0A=
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version =
1.00.09b)=0A=
powernow-k8: BIOS error - no PSB=0A=
ACPI: (supports S0 S1 S3 S4 S5)=0A=
ACPI wakeup devices: =0A=
PCI0 PS2K PS2M UAR2 UAR1 AC97 USB1 USB2 USB3 USB4 EHCI PWRB SLPB =0A=
Freeing unused kernel memory: 164k freed=0A=
SCSI subsystem initialized=0A=
libata version 1.02 loaded.=0A=
sata_via version 0.20=0A=
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 193=0A=
sata_via(0000:00:0f.0): routed to hard irq line 10=0A=
ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD400 irq 193=0A=
ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma 0xD408 irq 193=0A=
ata1: no device found (phy stat 00000000)=0A=
scsi0 : sata_via=0A=
ata2: no device found (phy stat 00000000)=0A=
scsi1 : sata_via=0A=
sata_promise version 1.00=0A=
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 18 (level, low) -> IRQ 177=0A=
sata_promise PATA port found=0A=
ata3: PATA max UDMA/133 cmd 0xFFFFFF0000004200 ctl 0xFFFFFF0000004238 =
bmdma 0x0 irq 177=0A=
ata4: PATA max UDMA/133 cmd 0xFFFFFF0000004280 ctl 0xFFFFFF00000042B8 =
bmdma 0x0 irq 177=0A=
ata5: PATA max UDMA/133 cmd 0xFFFFFF0000004300 ctl 0xFFFFFF0000004338 =
bmdma 0x0 irq 177=0A=
ATA: abnormal status 0x7F on port 0xFFFFFF000000421C=0A=
scsi2 : sata_promise=0A=
ATA: abnormal status 0x7F on port 0xFFFFFF000000429C=0A=
scsi3 : sata_promise=0A=
ata5: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 =
88:203f=0A=
ata5: dev 0 ATA, max UDMA/100, 312581808 sectors: lba48=0A=
ata5: dev 0 configured for UDMA/100=0A=
scsi4 : sata_promise=0A=
  Vendor: ATA       Model: WDC WD1600JB-00E  Rev: 15.0=0A=
  Type:   Direct-Access                      ANSI SCSI revision: 05=0A=
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)=0A=
SCSI device sda: drive cache: write back=0A=
 sda: sda1 sda2=0A=
Attached scsi disk sda at scsi4, channel 0, id 0, lun 0=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
SELinux:  Disabled at runtime.=0A=
SELinux:  Unregistering netfilter hooks=0A=
inserting floppy driver for 2.6.9-1.643.pata=0A=
Floppy drive(s): fd0 is 1.44M=0A=
FDC 0 is a post-1991 82077=0A=
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 185=0A=
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17 (level, low) -> IRQ 185=0A=
divert: allocating divert_blk for eth0=0A=
sk98lin: Asus mainboard with buggy VPD? Correcting data.=0A=
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter=0A=
      PrefPort:A  RlmtMode:Check Link State=0A=
ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 209=0A=
PCI: Setting latency timer of device 0000:00:11.5 to 64=0A=
codec_read: codec 0 is not valid [0xfe0000]=0A=
codec_read: codec 0 is not valid [0xfe0000]=0A=
codec_read: codec 0 is not valid [0xfe0000]=0A=
codec_read: codec 0 is not valid [0xfe0000]=0A=
Linux video capture interface: v1.00=0A=
cx2388x v4l2 driver version 0.0.4 loaded=0A=
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 18 (level, low) -> IRQ 177=0A=
cx8800[0]: found at 0000:00:0d.0, rev: 5, irq: 177, latency: 64, mmio: =
0xf6000000=0A=
cx8800[0]: subsystem: 107d:6613, board: Leadtek Winfast 2000XP Expert =
[card=3D5,autodetected]=0A=
cx8800[0]: i2c register ok=0A=
cx8800[0]: Leadtek Winfast 2000 XP config: tuner=3D43, eeprom[0]=3D0x01=0A=
tuner: Ignoring new-style parameters in presence of obsolete ones=0A=
tuner: chip found at addr 0xc0 i2c-bus cx8800[0]=0A=
tuner: type set to 43 (Philips NTSC MK3 (FM1236MK3 or FM1236/F)) by =
cx8800[0]=0A=
cx8800[0]: i2c attach [client=3DPhilips NTSC MK3 (FM1236MK3 or FM1236/F)]=0A=
tda9887: Ignoring new-style parameters in presence of obsolete ones=0A=
tda9885/6/7: chip found @ 0x86=0A=
cx8800[0]: i2c attach [client=3Dtda9887]=0A=
cx8800[0]: registered device video0 [v4l2]=0A=
cx8800[0]: registered device vbi0=0A=
cx8800[0]: registered device radio0=0A=
cx8800[0]: set_audio_standard_BTSC (status: known-good)=0A=
cx8800[0]: cx88: tvaudio thread started=0A=
ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 201=0A=
ehci_hcd 0000:00:10.4: EHCI Host Controller=0A=
ehci_hcd 0000:00:10.4: irq 201, pci mem ffffff0000006000=0A=
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1=0A=
ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10=0A=
hub 1-0:1.0: USB hub found=0A=
hub 1-0:1.0: 8 ports detected=0A=
USB Universal Host Controller Interface driver v2.2=0A=
ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 201=0A=
uhci_hcd 0000:00:10.0: UHCI Host Controller=0A=
uhci_hcd 0000:00:10.0: irq 201, io base 000000000000b400=0A=
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2=0A=
hub 2-0:1.0: USB hub found=0A=
hub 2-0:1.0: 2 ports detected=0A=
ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 201=0A=
uhci_hcd 0000:00:10.1: UHCI Host Controller=0A=
uhci_hcd 0000:00:10.1: irq 201, io base 000000000000b800=0A=
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3=0A=
hub 3-0:1.0: USB hub found=0A=
hub 3-0:1.0: 2 ports detected=0A=
ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 201=0A=
uhci_hcd 0000:00:10.2: UHCI Host Controller=0A=
uhci_hcd 0000:00:10.2: irq 201, io base 000000000000c000=0A=
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4=0A=
hub 4-0:1.0: USB hub found=0A=
hub 4-0:1.0: 2 ports detected=0A=
ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 201=0A=
uhci_hcd 0000:00:10.3: UHCI Host Controller=0A=
uhci_hcd 0000:00:10.3: irq 201, io base 000000000000c400=0A=
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5=0A=
hub 5-0:1.0: USB hub found=0A=
hub 5-0:1.0: 2 ports detected=0A=
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>=0A=
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 169=0A=
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=3D[169]  =
MMIO=3D[f7a00000-f7a007ff]  Max Packet=3D[2048]=0A=
md: Autodetecting RAID arrays.=0A=
md: autorun ...=0A=
md: ... autorun DONE.=0A=
cx8800[0]: AUD_STATUS: 0xf632 [mono/no pilot] ctl=3DBTSC_AUTO_STEREO=0A=
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000055ac35]=0A=
ACPI: Power Button (FF) [PWRF]=0A=
ACPI: Sleep Button (CM) [SLPB]=0A=
EXT3 FS on hdb7, internal journal=0A=
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com=0A=
cdrom: open failed.=0A=
cdrom: open failed.=0A=
cx8800[0]: AUD_STATUS: 0xf3f2 [mono/no pilot] ctl=3DBTSC_AUTO_STEREO=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3 FS on hda6, internal journal=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3 FS on hda1, internal journal=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
Adding 1718912k swap on /dev/hdb6.  Priority:-1 extents:1=0A=
Adding 2008116k swap on /dev/hda3.  Priority:-2 extents:1=0A=

------=_NextPart_000_002F_01C4BC04.0B7FC330--

