From: Andrew Ryder <tireman@shaw.ca>
Subject: Re: Sata 4726 Testing
Date: Wed, 09 Jan 2008 18:00:43 -0500
Message-ID: <4785521B.6070205@shaw.ca>
References: <4769A17A.8070806@shaw.ca> <4769F974.2020905@gmail.com>
 <476D16E2.1050909@shaw.ca> <47824F69.6080007@gmail.com>
 <4782A79E.5000607@shaw.ca> <4782F3DB.6000906@gmail.com>
 <47832D82.2020106@shaw.ca> <47845F91.9000705@gmail.com>
 <47859132.1000700@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------030101070300060204040101
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:47135 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbYAJEIE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 23:08:04 -0500
Received: from pd2mr2so.prod.shaw.ca
 (pd2mr2so-qfe3.prod.shaw.ca [10.0.141.109]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUE00E7CU5DWED0@l-daemon> for linux-ide@vger.kernel.org; Wed,
 09 Jan 2008 21:08:01 -0700 (MST)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
 by pd2mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUE00MTHU51AD60@pd2mr2so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Wed, 09 Jan 2008 21:08:02 -0700 (MST)
Received: from [192.168.0.2] ([70.76.194.32])
 by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JUE006ERU4NJ140@l-daemon> for linux-ide@vger.kernel.org; Wed,
 09 Jan 2008 21:07:48 -0700 (MST)
In-reply-to: <47859132.1000700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------030101070300060204040101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun,

I rebooted with the 4726 online during bootup, verified everything was
there by re-formatting the fs on each drive. I powered off the 4726 for
approx 15 seconds, turned it back on, and repeated the power on/off
again about 1 minute later.

The first 3 drives are accessible, but the 4th drive on ata1.03 failed
to be recognized.



Tejun Heo wrote:
> Tejun Heo wrote:
>   
>> Please apply the attached patch on top of 2.6.24-rc7 and report the
>> result.  Thanks.
>>     
>
> Andrew, with the patch applied, please try to turn off and on the PMP
> array while the system is running and verify that each time the array
> gets detected correctly and disks are accessible.
>
> Thanks.
>
>   


--------------030101070300060204040101
Content-Type: text/plain;
 name="Bootlog10.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Bootlog10.txt"

 PFN ranges
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
time.c: Detected 1802.297 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ f8000000 size 64 MB
Memory: 2059876k/2096320k available (2288k kernel code, 35684k reserved, 1034k data, 192k init)
Calibrating delay using timer specific routine.. 3608.84 BogoMIPS (lpj=7217681)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Opteron(tm) Processor 144 stepping 0a
ACPI: Core revision 20070126
Using local APIC timer interrupts.
APIC timer calibration result 12515956
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
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
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
audit(1199918569.256:1): initialized
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
VIA8237SATA: IDE controller (0x1106:0x3149 rev 0x80) at  PCI slot 0000:00:0f.0
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
hda: UDMA/100 mode selected
hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdb: UDMA/133 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdd: ASUS DVD-E616P2, ATAPI CD/DVD-ROM drive
hdc: ASUS DRW-0402P/D, ATAPI CD/DVD-ROM drive
hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdc: UDMA/33 mode selected
hdd: host max PIO5 wanted PIO255(auto-tune) selected PIO4
hdd: drive side 80-wire cable detection failed, limiting max speed to UDMA33
hdd: UDMA/33 mode selected
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
Probing IDE interface ide3...
hda: max request size: 512KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
hda: cache flushes supported
 hda: hda1 hda2
hdb: max request size: 512KiB
hdb: 320173056 sectors (163928 MB) w/2048KiB Cache, CHS=19929/255/63
hdb: cache flushes not supported
 hdb: hdb1
hdc: ATAPI 47X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache
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
Driver 'sd' needs updating - please use bus_type methods
sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
sd 0:0:0:0: [sda] 35843670 512-byte hardware sectors (18352 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: a3 00 10 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
Driver 'sr' needs updating - please use bus_type methods
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
ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda3: checking transaction log (sda3)
ReiserFS: sda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 192k freed
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 0:0:3:0: Attached scsi generic sg1 type 5
ACPI: PCI Interrupt 0000:00:07.0[A] -> GSI 16 (level, low) -> IRQ 16
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
input: Power Button (FF) as /class/input/input2
USB Universal Host Controller Interface driver v3.0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input3
ACPI: Power Button (CM) [PWRB]
input: Sleep Button (CM) as /class/input/input4
ACPI: Sleep Button (CM) [SLPB]
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[16]  MMIO=[fd400000-fd4007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
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
FDC 0 is a post-1991 82077
00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000059341e]
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 320)
ata1.05: hard resetting link
ata1.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
ata1.00: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.00: 586072368 sectors, multi 16: LBA48 
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
ata1.01: ATA-7: ST3300831A, 3.03, max UDMA/100
ata1.01: 586072368 sectors, multi 0: LBA48 
ata1.01: applying bridge limits
ata1.01: configured for UDMA/100
ata1.02: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata1.02: 586072368 sectors, multi 0: LBA48 
ata1.02: applying bridge limits
ata1.02: configured for UDMA/100
ata1.03: ATA-7: ST3300622A, 3.AND, max UDMA/100
ata1.03: 586072368 sectors, multi 0: LBA48 
ata1.03: applying bridge limits
ata1.03: configured for UDMA/100
ata1.05: ATA-6: Config  Disk, PLS12061, max UDMA/133
ata1.05: 640 sectors, multi 1: LBA 
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: EH complete
ata2: SATA link down (SStatus 0 SControl 0)
ata3: SATA link down (SStatus 0 SControl 0)
ata4: SATA link down (SStatus 0 SControl 0)
scsi 1:0:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1
sd 1:0:0:0: [sdb] Attached SCSI disk
sd 1:0:0:0: Attached scsi generic sg2 type 0
scsi 1:1:0:0: Direct-Access     ATA      ST3300831A       3.03 PQ: 0 ANSI: 5
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdc: sdc1
sd 1:1:0:0: [sdc] Attached SCSI disk
sd 1:1:0:0: Attached scsi generic sg3 type 0
scsi 1:2:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdd: sdd1
sd 1:2:0:0: [sdd] Attached SCSI disk
sd 1:2:0:0: Attached scsi generic sg4 type 0
scsi 1:3:0:0: Direct-Access     ATA      ST3300622A       3.AN PQ: 0 ANSI: 5
sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
sd 1:3:0:0: [sde] Write Protect is off
sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:3:0:0: [sde] 586072368 512-byte hardware sectors (300069 MB)
sd 1:3:0:0: [sde] Write Protect is off
sd 1:3:0:0: [sde] Mode Sense: 00 3a 00 00
sd 1:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sde: sde1
sd 1:3:0:0: [sde] Attached SCSI disk
sd 1:3:0:0: Attached scsi generic sg5 type 0
scsi 1:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdf] Write Protect is off
sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdf] Write Protect is off
sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdf: unknown partition table
sd 1:5:0:0: [sdf] Attached SCSI disk
sd 1:5:0:0: Attached scsi generic sg6 type 0
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
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Disallowing DAC for device 0000:00:0e.0
e1000: 0000:00:0e.0: e1000_probe: (PCI:33MHz:32-bit) 00:0e:0c:62:c5:46
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ReiserFS: hdb1: found reiserfs format "3.6" with standard journal
ReiserFS: hdb1: using ordered data mode
ReiserFS: hdb1: journal params: device hdb1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb1: checking transaction log (hdb1)
ReiserFS: hdb1: Using r5 hash to sort names
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
hda: UDMA/100 mode selected
hdb: UDMA/133 mode selected
hdc: UDMA/33 mode selected
hdd: UDMA/33 mode selected
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex, Flow Control: RX/TX
w83627hf: Found W83697HF chip at 0x290
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x90000 action 0xa frozen
ata1.15: irq_stat 0x01b40090, PHY RDY changed
ata1: SError: { PHYRdyChg 10B8B }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 0)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: limiting SATA link speed to 1.5 Gbps
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 310)
ata1.05: hard resetting link
ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.00: revalidation failed (errno=-5)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.01: revalidation failed (errno=-5)
ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.02: revalidation failed (errno=-5)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: revalidation failed (errno=-5)
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.03: revalidation failed (errno=-5)
ata1.03: disabled
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: EH complete
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdf] Write Protect is off
sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdf] Write Protect is off
sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
ata1.03: detaching (SCSI 1:3:0:0)
sd 1:3:0:0: [sde] Synchronizing SCSI cache
sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
sd 1:3:0:0: [sde] Stopping disk
sd 1:3:0:0: [sde] START_STOP FAILED
sd 1:3:0:0: [sde] Result: hostbyte=0x04 driverbyte=0x00
ata1.00: failed to read SCR 1 (Emask=0x40)
ata1.01: failed to read SCR 1 (Emask=0x40)
ata1.02: failed to read SCR 1 (Emask=0x40)
ata1.03: failed to read SCR 1 (Emask=0x40)
ata1.04: failed to read SCR 1 (Emask=0x40)
ata1.05: failed to read SCR 1 (Emask=0x40)
ata1.06: failed to read SCR 1 (Emask=0x40)
ata1.15: exception Emask 0x10 SAct 0x0 SErr 0x80000 action 0xa frozen
ata1.15: irq_stat 0x01940090, PHY RDY changed
ata1: SError: { 10B8B }
ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.06: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link down (SStatus 1 SControl 10)
ata1.15: qc timeout (cmd 0xe4)
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: PMP revalidation failed (errno=-5)
ata1.15: retrying hardreset in 5 secs
ata1.15: hard resetting link
ata1.15: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 310)
ata1.05: hard resetting link
ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
ata1.06: hard resetting link
ata1.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.00: revalidation failed (errno=-5)
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.01: revalidation failed (errno=-5)
ata1.02: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.02: revalidation failed (errno=-5)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1.05: device is on DMA blacklist, disabling DMA
ata1.05: configured for PIO4
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.02: hard resetting link
ata1.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
ata1: failed to recover some devices, retrying in 5 secs
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1: EH complete
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdf] Write Protect is off
sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 586072368 512-byte hardware sectors (300069 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:1:0:0: [sdc] 586072368 512-byte hardware sectors (300069 MB)
sd 1:1:0:0: [sdc] Write Protect is off
sd 1:1:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 1:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:2:0:0: [sdd] 586072368 512-byte hardware sectors (300069 MB)
sd 1:2:0:0: [sdd] Write Protect is off
sd 1:2:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 1:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:5:0:0: [sdf] 640 512-byte hardware sectors (0 MB)
sd 1:5:0:0: [sdf] Write Protect is off
sd 1:5:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 1:5:0:0: [sdf] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA


--------------030101070300060204040101--
