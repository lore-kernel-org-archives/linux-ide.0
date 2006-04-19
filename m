From: =?ISO-8859-1?Q?Markus_M=FCller?= <mm@priv.de>
Subject: sata_sil: write corruption on parallel access of two or more drives
 on same controller
Date: Thu, 20 Apr 2006 00:48:28 +0200
Message-ID: <4446BE3C.7050902@priv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.priv.de ([80.237.225.190]:28322 "EHLO mail.priv.de")
	by vger.kernel.org with ESMTP id S1751304AbWDSWsc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Apr 2006 18:48:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Hi sil_sata.c-Developers,

I've a problem accessing discs on my SIL 3114 controller: If I write
to it and if during this any other access (= read or write) to a disc
on same controller occures, there are write errors.

The kernel doesn't realise this at all, there is no message about
that in dmesg or syslog.

I can give you a demo about this problem with badblocks:

stacker:~# date; badblocks -n /dev/sdb &
Wed Apr 19 12:11:02 CEST 2006
[1] 1703
stacker:~# date; badblocks /dev/sda & sleep 2; date; kill %2
Wed Apr 19 12:11:30 CEST 2006
[2] 1705
240078
242958
243324
243826
243830
243867
245760
245986
246102
246455
246952
246957
247684
247822
247823
248192
248320
249810
251235
251410
252435
Wed Apr 19 12:11:32 CEST 2006
stacker:~#
[2]+  Terminated              badblocks /dev/sda
stacker:~# date; badblocks /dev/sda & sleep 1; date; kill %2
Wed Apr 19 12:11:51 CEST 2006
[2] 1709
416994
417217
417357
417600
417792
417984
418770
418803
419091
419404
419797
419919
419922
420243
420609
420610
420662
421158
421297
421905
421918
422094
Wed Apr 19 12:11:52 CEST 2006
stacker:~#
[2]+  Terminated              badblocks /dev/sda
stacker:~# jobs
[1]-  Running                 badblocks -n /dev/sdb &
stacker:~#

The bad blocks numbers comes from the badblocks %1, which is
testing in read-write mode. %2 is simply a second (read) access
to one of the discs of the same SIL Controller, which results
in  the problem on the other writing process. I already tried
with two shells, you can believe me that his does NOT come from
the %2 process. :-)

Following is my hardware config, dmesg, lspci and uname -a.

Please realise, that I tested my hardware with mprime, cpuburn
and also memtest86. There is no hardwareproblem.

This problem doesn't occure with this sil controllers and sata
hdds on a Neo2 Board with AMD64 from MSI so...

-> Maybe the SIL-Driver isn't useable with the NForce2 Chipset?!

Please inculde me in answers as CC, cause I am currently
not on the kernel mailing list.

gReeTings,
Markus Mueller

Dmesg:

Linux version 2.6.16.1 (root@stacker.websrv.de) (gcc version 4.0.3
(Debian 4.0.3-1)) #5 SMP PREEMPT Wed Jan 16
13:56:34 CET 2002
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009b800 (usable)
  BIOS-e820: 000000000009b800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
   DMA zone: 4096 pages, LIFO batch:0
   DMA32 zone: 0 pages, LIFO batch:0
   Normal zone: 126960 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:0
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x000f75c0
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=LinuxConsole ro ramdisk_size=21500
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1921.142 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514220k/524224k available (2774k kernel code, 9464k reserved,
1003k data, 216k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3849.73 BogoMIPS
(lpj=7699461)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 1c28)
CPU0: AMD Athlon(tm) XP 2600+ stepping 00
SMP motherboard not detected.
Brought up 1 CPUs
migration_cost=0
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 10k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb4a0, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
Boot video device is 0000:02:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs *17), disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs *18), disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs *19), disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
spurious 8259A interrupt: IRQ7.
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
pnp: 00:00: ioport range 0x4000-0x407f could not be reserved
pnp: 00:00: ioport range 0x4080-0x40ff has been reserved
pnp: 00:00: ioport range 0x4400-0x447f has been reserved
pnp: 00:00: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:00: ioport range 0x4200-0x427f has been reserved
pnp: 00:00: ioport range 0x4280-0x42ff has been reserved
pnp: 00:01: ioport range 0x5000-0x503f has been reserved
pnp: 00:01: ioport range 0x5500-0x553f has been reserved
PCI: Bridge: 0000:00:08.0
   IO window: 9000-bfff
   MEM window: de000000-dfffffff
   PREFETCH window: 30000000-300fffff
PCI: Bridge: 0000:00:1e.0
   IO window: disabled.
   MEM window: dc000000-ddffffff
   PREFETCH window: d0000000-d7ffffff
PCI: Setting latency timer of device 0000:00:08.0 to 64
Machine check exception polling timer started.
cpufreq: Detected nForce2 chipset revision C1
cpufreq: FSB changing is maybe unstable and can lead to crashes and data
loss.
cpufreq: FSB currently at 167 MHz, FID 11.5
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1011602589.976:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.26 [Flags: R/W].
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
lp: driver loaded but no devices found
Real Time Clock Driver v1.12ac
ppdev: user-space parallel port driver
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
lp0: using parport0 (interrupt-driven).
RAMDISK driver initialized: 16 RAM disks of 21500K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
Intel(R) PRO/1000 Network Driver - version 6.3.9-k4
Copyright (c) 1999-2005 Intel Corporation.
pcnet32.c:v1.31c 01.Nov.2005 tsbogend@alpha.franken.de
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.49.
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LMAC] -> GSI 12 (level,
low) -> IRQ 12
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
PPP generic driver version 2.4.2
NET: Registered protocol family 24
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD80EB-28CGH2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Pioneer DVD-ROM ATAPIModel DVD-104S 011, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 15633072 sectors (8004 MB) w/768KiB Cache, CHS=15509/16/63, UDMA(100)
hda: cache flushes not supported
  hda: hda1 hda2
hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
libata version 1.20 loaded.
sata_sil 0000:01:07.0: version 0.9
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:07.0[A] -> Link [LNK4] -> GSI 11 (level,
low) -> IRQ 11
sata_sil 0000:01:07.0: Applying R_ERR on DMA activate FIS errata fix
ata1: SATA max UDMA/100 cmd 0xE0804080 ctl 0xE080408A bmdma 0xE0804000
irq 11
ata2: SATA max UDMA/100 cmd 0xE08040C0 ctl 0xE08040CA bmdma 0xE0804008
irq 11
ata3: SATA max UDMA/100 cmd 0xE0804280 ctl 0xE080428A bmdma 0xE0804200
irq 11
ata4: SATA max UDMA/100 cmd 0xE08042C0 ctl 0xE08042CA bmdma 0xE0804208
irq 11
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 cfg 49:2f00 82:746b 83:7f61 84:4023 85:7469 86:3c41 87:4023
88:407f
ata1: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 cfg 49:2f00 82:746b 83:7f61 84:4023 85:7469 86:3c41 87:4023
88:407f
ata2: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
ata2: dev 0 configured for UDMA/100
scsi1 : sata_sil
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:746b 83:7f61 84:4023 85:7469 86:3c41 87:4023
88:407f
ata3: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
ata3: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 cfg 49:2f00 82:746b 83:7f61 84:4023 85:7469 86:3c41 87:4023
88:407f
ata4: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
ata4: dev 0 configured for UDMA/100
scsi3 : sata_sil
   Vendor: ATA       Model: WDC WD3200JS-00P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD3200JS-00P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD3200JS-00P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD3200JS-00P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [LNK3] -> GSI 10 (level,
low) -> IRQ 10
sata_sil 0000:01:08.0: Applying R_ERR on DMA activate FIS errata fix
ata5: SATA max UDMA/100 cmd 0xE0806080 ctl 0xE080608A bmdma 0xE0806000
irq 10
ata6: SATA max UDMA/100 cmd 0xE08060C0 ctl 0xE08060CA bmdma 0xE0806008
irq 10
ata7: SATA max UDMA/100 cmd 0xE0806280 ctl 0xE080628A bmdma 0xE0806200
irq 10
ata8: SATA max UDMA/100 cmd 0xE08062C0 ctl 0xE08062CA bmdma 0xE0806208
irq 10
ata5: SATA link up 1.5 Gbps (SStatus 113)
ata5: dev 0 cfg 49:2f00 82:746b 83:7f61 84:4023 85:7469 86:3c41 87:4023
88:407f
ata5: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
ata5: dev 0 configured for UDMA/100
scsi4 : sata_sil
ata6: SATA link up 1.5 Gbps (SStatus 113)
ata6: dev 0 cfg 49:2f00 82:746b 83:7f61 84:4023 85:7469 86:3c41 87:4023
88:407f
ata6: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
ata6: dev 0 configured for UDMA/100
scsi5 : sata_sil
ata7: SATA link up 1.5 Gbps (SStatus 113)
ata7: dev 0 cfg 49:2f00 82:746b 83:7f61 84:4023 85:7468 86:3c41 87:4023
88:407f
ata7: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
ata7: dev 0 configured for UDMA/100
scsi6 : sata_sil
ata8: SATA link up 1.5 Gbps (SStatus 113)
ata8: dev 0 cfg 49:2f00 82:746b 83:7f61 84:4023 85:7469 86:3c41 87:4023
88:407f
ata8: dev 0 ATA-7, max UDMA/133, 625142448 sectors: LBA48
ata8: dev 0 configured for UDMA/100
scsi7 : sata_sil
   Vendor: ATA       Model: WDC WD3200JS-00P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD3200JS-00P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD3200JS-00P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
   Vendor: ATA       Model: WDC WD3200JS-00P  Rev: 21.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
  sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
  sdc: sdc1
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
  sdd: sdd1
sd 3:0:0:0: Attached scsi disk sdd
SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
  sde: sde1
sd 4:0:0:0: Attached scsi disk sde
SCSI device sdf: 625142448 512-byte hdwr sectors (320073 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
SCSI device sdf: 625142448 512-byte hdwr sectors (320073 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
  sdf: sdf1
sd 5:0:0:0: Attached scsi disk sdf
SCSI device sdg: 625142448 512-byte hdwr sectors (320073 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
SCSI device sdg: 625142448 512-byte hdwr sectors (320073 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
  sdg: sdg1
sd 6:0:0:0: Attached scsi disk sdg
SCSI device sdh: 625142448 512-byte hdwr sectors (320073 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
SCSI device sdh: 625142448 512-byte hdwr sectors (320073 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
  sdh: sdh1
sd 7:0:0:0: Attached scsi disk sdh
usbmon: debugfs is not available
USB Universal Host Controller Interface driver v2.3
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: automatically using best checksumming function: pIII_sse
    pIII_sse  :  4411.000 MB/sec
raid5: using function: pIII_sse (4411.000 MB/sec)
raid6: int32x1    755 MB/s
raid6: int32x2    804 MB/s
raid6: int32x4    712 MB/s
raid6: int32x8    560 MB/s
raid6: mmxx1     1572 MB/s
raid6: mmxx2     2753 MB/s
raid6: sse1x1    1515 MB/s
raid6: sse1x2    2303 MB/s
raid6: using algorithm sse1x2 (2303 MB/s)
md: raid6 personality registered for level 6
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
Mirror/redirect action on
netem: version 1.2
u32 classifier
     Actions configured
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 6, 393216 bytes)
TCP bind hash table entries: 32768 (order: 6, 393216 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
ip_conntrack version 2.4 (4095 buckets, 32760 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2006 Netfilter Core Team
arp_tables: (C) 2002 David S. Miller
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Bridge firewalling registered
Ebtables v2.0 registered
ebt_ulog: not logging via ulog since somebody else already registered
for PF_BRIDGE
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Unable to identify CD-ROM format.
ISO 9660 Extensions: RRIP_1991A
input: AT Translated Set 2 keyboard as /class/input/input0

lspci:

stacker:~# lspci
0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
version?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 0
(rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4
(rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3
(rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2
(rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5
(rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge
(rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:07.0 Mass storage controller: Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller (rev 02)
0000:01:08.0 Mass storage controller: Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller (rev 02)
0000:02:00.0 VGA compatible controller: nVidia Corporation NV15
[GeForce2 GTS/Pro] (rev a4)
stacker:~#

uname -a:

stacker:~# uname -a
Linux stacker.websrv.de 2.6.16.1 #5 SMP PREEMPT Wed Jan 16 13:56:34 CET
2002 i686 GNU/Linux
stacker:~#

