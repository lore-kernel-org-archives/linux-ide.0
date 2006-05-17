From: Ric Wheeler <ric@emc.com>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 22:09:09 -0400
Message-ID: <446A85C5.5030001@emc.com>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A4721.3030506@emc.com> <446A4BF5.7080006@garzik.org> <446A5EED.7020902@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080505060902010608040300"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([168.159.213.200]:7099 "EHLO
	mexforward.lss.emc.com") by vger.kernel.org with ESMTP
	id S1751048AbWEQBL5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 May 2006 21:11:57 -0400
In-Reply-To: <446A5EED.7020902@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

This is a multi-part message in MIME format.
--------------080505060902010608040300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Tejun Heo wrote:

> Jeff Garzik wrote:
>
>> Ric Wheeler wrote:
>>
>>>
>>> One other note, it seems like this patch set has broken the write 
>>> barrier support - is that a side effect of enabling NCQ still?
>>>
>>> I see messages that claim flush barriers are enabled:
>>>
>>> [root@c001n01 root]# mount -o 
>>> barrier=flush,rw,noatime,nodiratime,data=ordered,notail /dev/sda10 
>>> /mnt/1
>>> May 16 22:21:56 centera kernel: ReiserFS: sda10: found reiserfs 
>>> format "3.6" with standard journal
>>> [root@c001n01 root]# May 16 22:21:58 centera kernel: ReiserFS: 
>>> sda10: using ordered data mode
>>> May 16 22:21:58 centera kernel: reiserfs: using flush barriers
>>> May 16 22:21:58 centera kernel: ReiserFS: sda10: journal params: 
>>> device sda10, size 8192, journal first block 18, max trans len 1024, 
>>> max batch 900, max commit age 30, max trans age 30
>>> May 16 22:21:58 centera kernel: ReiserFS: sda10: checking 
>>> transaction log (sda10)
>>> May 16 22:21:58 centera kernel: ReiserFS: sda10: Using r5 hash to 
>>> sort names
>>>
>>> But when I test with my synchronous write load, I am going at 6 
>>> times the normal rate (i.e., the rate I see with barriers disabled) ;-)
>>
>>
>> Well, NCQ read/write commands have a 'FUA' bit...  though maybe the 
>> NCQ code forgot to check the global libata_fua.
>>
>
> Hmmm.. The only place FUA is checked is ata_dev_supports_fua() 
> regardless of NCQ, but I've seen FUA enabled with NCQ in another bug 
> report, so I might have screwed up.  Ric, can you post the boot dmesg 
> such that we know whether FUA is enabled or not?
>
> I'm attaching a patch to print the progress of ordered sequence.  I've 
> just tested with a NCQ drive loaded with 20 IO requests and it works. 
> All requests are drained, preflush, barrier, then postflush.  Running 
> the same test with the attached patch will tell us how barrier is 
> working.
>
> @ I can't believe this.  Last night two disks failed - one testing, 
> one production.  Man, my harddrives are falling like flies.  Four test 
> drives and one production drive failed during last two months.  Maybe 
> they are striking back at me.  :-(
>
Attached is the boot.msg file - one important note is that we (EMC) have 
the unusual habit of using drives with write cache off & turning them on 
during boot up.  Could be that the answer is a simple enabling write 
cache does not properly toggle the barrier support (although I thought 
that we had patches from Jens ? that fixed this).

ric


--------------080505060902010608040300
Content-Type: text/plain;
 name="boot.msg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="boot.msg"

Cannot find map file.
No module symbols loaded - kernel modules not enabled.

Cannot build symbol table - disabling symbol lookups
klogd 1.4.1, log source =3D ksyslog started.
00000, GSI 0-23
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
<7>ACPI: IRQ0 used by override.
<7>ACPI: IRQ2 used by override.
<7>ACPI: IRQ9 used by override.
<4>Enabling APIC mode:  Flat.  Using 1 I/O APICs
<6>Using ACPI (MADT) for SMP configuration information
<4>Allocating PCI resources starting at 40000000 (gap: 3f700000:a0900000)=

<4>Built 1 zonelists
<5>Kernel command line: root=3D/dev/md3 elevator=3Das console=3DttyS0,960=
0,8n1 console=3Dtty0 apic BOOT_IMAGE=3Dproduction-m
<7>mapped APIC to ffffd000 (fee00000)
<7>mapped IOAPIC to ffffc000 (fec00000)
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Initializing CPU#0
<4>PID hash table entries: 4096 (order: 12, 16384 bytes)
<4>Detected 2800.792 MHz processor.
<6>Using pmtmr for high-res timesource
<4>Console: colour VGA+ 80x25
<4>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
<6>Memory: 898240k/917504k available (2014k kernel code, 18720k reserved,=
 632k data, 184k init, 0k highmem)
<4>Checking if this processor honours the WP bit even in supervisor mode.=
=2E. Ok.
<4>Calibrating delay using timer specific routine.. 5607.13 BogoMIPS (lpj=
=3D11214265)
<4>Mount-cache hash table entries: 512
<7>CPU: After generic identify, caps: bfebfbff 00100000 00000000 00000000=
 0000441d 00000000 00000000
<7>CPU: After vendor identify, caps: bfebfbff 00100000 00000000 00000000 =
0000441d 00000000 00000000
<4>monitor/mwait feature present.
<4>using mwait in idle threads.
<6>CPU: Trace cache: 12K uops, L1 D cache: 16K
<6>CPU: L2 cache: 1024K
<7>CPU: After all inits, caps: bfebfbff 00100000 00000000 00000180 000044=
1d 00000000 00000000
<4>CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 01
<6>Checking 'hlt' instruction... OK.
<6>SMP alternatives: switching to UP code
<6>Freeing SMP alternatives: 0k freed
<4>ENABLING IO-APIC IRQs
<6>..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
<6>checking if image is initramfs...it isn't (no cpio magic); looks like =
an initrd
<6>Freeing initrd memory: 7738k freed
<6>NET: Registered protocol family 16
<6>ACPI: bus type pci registered
<6>PCI: Using MMCONFIG
<4>Setting up standard PCI resources
<6>ACPI: Subsystem revision 20060127
<6>ACPI: Interpreter enabled
<6>ACPI: Using IOAPIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (0000:00)
<7>PCI: Probing PCI hardware (bus 00)
<7>Boot video device is 0000:00:02.0
<4>PCI: PXH quirk detected, disabling MSI for SHPC device
<4>PCI: PXH quirk detected, disabling MSI for SHPC device
<6>PCI: Transparent bridge - 0000:00:1e.0
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P1AB.PXHA._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P1AB.PXHB._PRT]
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *12 14 15)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 *7 9 10 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 *10 12 14 15)
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 12 14 15) *0, disab=
led.
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 12 14 15) *0, disab=
led.
<4>ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 7 9 10 12 14 15) *0, disab=
led.
<4>ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 12 14 15)
<5>SCSI subsystem initialized
<6>PCI: Using ACPI for IRQ routing
<6>PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, pos=
t a report
<4>PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
<6>PCI: Bridge: 0000:01:00.0
<6>  IO window: c000-cfff
<6>  MEM window: d0000000-d00fffff
<6>  PREFETCH window: disabled.
<6>PCI: Bridge: 0000:01:00.2
<6>  IO window: d000-dfff
<6>  MEM window: d0100000-d01fffff
<6>  PREFETCH window: disabled.
<6>PCI: Bridge: 0000:00:01.0
<6>  IO window: c000-dfff
<6>  MEM window: d0000000-d02fffff
<6>  PREFETCH window: disabled.
<6>PCI: Bridge: 0000:00:1e.0
<6>  IO window: disabled.
<6>  MEM window: disabled.
<6>  PREFETCH window: disabled.
<6>ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
<7>PCI: Setting latency timer of device 0000:00:01.0 to 64
<7>PCI: Setting latency timer of device 0000:01:00.0 to 64
<7>PCI: Setting latency timer of device 0000:01:00.2 to 64
<7>PCI: Setting latency timer of device 0000:00:1e.0 to 64
<6>NET: Registered protocol family 2
<4>IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>TCP established hash table entries: 131072 (order: 7, 524288 bytes)
<4>TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
<6>TCP: Hash tables configured (established 131072 bind 65536)
<6>TCP reno registered
<6>IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
<6>io scheduler noop registered
<6>io scheduler anticipatory registered (default)
<6>io scheduler deadline registered
<6>io scheduler cfq registered
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disab=
led
<6>serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
<4>RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize=

<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with ideb=
us=3Dxx
<7>Probing IDE interface ide0...
<7>Probing IDE interface ide1...
<7>libata version 1.30 loaded.
<7>ahci 0000:00:1f.2: version 1.3
<6>ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 17
<7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
<6>ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl I=
DE mode
<6>ahci 0000:00:1f.2: flags: 64bit ncq pm led=20
<6>ata1: SATA max UDMA/133 cmd 0xF8802100 ctl 0x0 bmdma 0x0 irq 17
<6>ata2: SATA max UDMA/133 cmd 0xF8802180 ctl 0x0 bmdma 0x0 irq 17
<6>ata3: SATA max UDMA/133 cmd 0xF8802200 ctl 0x0 bmdma 0x0 irq 17
<6>ata4: SATA max UDMA/133 cmd 0xF8802280 ctl 0x0 bmdma 0x0 irq 17
<6>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
<7>ata1.00: cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c49 86:3e01 87:4063 8=
8:007f
<6>ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/3=
2)
<6>ata1.00: configured for UDMA/133
<6>scsi0 : ahci
<6>ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
<7>ata2.00: cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c49 86:3e01 87:4063 8=
8:007f
<6>ata2.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/3=
2)
<6>ata2.00: configured for UDMA/133
<6>scsi1 : ahci
<6>ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
<7>ata3.00: cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c49 86:3e01 87:4063 8=
8:007f
<6>ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/3=
2)
<6>ata3.00: configured for UDMA/133
<6>scsi2 : ahci
<6>ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
<7>ata4.00: cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c49 86:3e01 87:4063 8=
8:007f
<6>ata4.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/3=
2)
<6>ata4.00: configured for UDMA/133
<6>scsi3 : ahci
<5>  Vendor: ATA       Model: Maxtor 7B320S0    Rev: BANC
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: Maxtor 7B320S0    Rev: BANC
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: Maxtor 7B320S0    Rev: BANC
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>  Vendor: ATA       Model: Maxtor 7B320S0    Rev: BANC
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
<5>sda: Write Protect is off
<7>sda: Mode Sense: 00 3a 00 00
<5>SCSI device sda: drive cache: write through
<5>SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
<5>sda: Write Protect is off
<7>sda: Mode Sense: 00 3a 00 00
<5>SCSI device sda: drive cache: write through
<6> sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12=
 sda13 sda14 >
<5>sd 0:0:0:0: Attached scsi disk sda
<5>SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
<5>sdb: Write Protect is off
<7>sdb: Mode Sense: 00 3a 00 00
<5>SCSI device sdb: drive cache: write through
<5>SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
<5>sdb: Write Protect is off
<7>sdb: Mode Sense: 00 3a 00 00
<5>SCSI device sdb: drive cache: write through
<6> sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 sdb12=
 sdb13 sdb14 >
<5>sd 1:0:0:0: Attached scsi disk sdb
<5>SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
<5>sdc: Write Protect is off
<7>sdc: Mode Sense: 00 3a 00 00
<5>SCSI device sdc: drive cache: write through
<5>SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
<5>sdc: Write Protect is off
<7>sdc: Mode Sense: 00 3a 00 00
<5>SCSI device sdc: drive cache: write through
<6> sdc: sdc1 sdc2 sdc3 sdc4 < sdc5 sdc6 sdc7 sdc8 sdc9 sdc10 sdc11 sdc12=
 sdc13 sdc14 >
<5>sd 2:0:0:0: Attached scsi disk sdc
<5>SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
<5>sdd: Write Protect is off
<7>sdd: Mode Sense: 00 3a 00 00
<5>SCSI device sdd: drive cache: write through
<5>SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
<5>sdd: Write Protect is off
<7>sdd: Mode Sense: 00 3a 00 00
<5>SCSI device sdd: drive cache: write through
<6> sdd: sdd1 sdd2 sdd3 sdd4 < sdd5 sdd6 sdd7 sdd8 sdd9 sdd10 sdd11 sdd12=
 sdd13 sdd14 >
<5>sd 3:0:0:0: Attached scsi disk sdd
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>mice: PS/2 mouse device common for all mice
<6>i2c /dev entries driver
<6>md: raid1 personality registered for level 1
<6>md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
<6>md: bitmap version 4.39
<6>TCP bic registered
<6>NET: Registered protocol family 1
<4>Using IPI Shortcut mode
<4>ACPI wakeup devices:=20
<4>PCI0 PEX0 PEX1 PEX2 PEX3 HUB0 PXHA PXHB UAR1 USB0 USB1 USB2 USB3 USBE =
AC97 AZAL=20
<6>ACPI: (supports S0 S1 S4 S5)
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: considering sdd8 ...
<6>md:  adding sdd8 ...
<4>md: sdd7 has different UUID to sdd8
<4>md: sdd6 has different UUID to sdd8
<4>md: sdd5 has different UUID to sdd8
<4>md: sdd3 has different UUID to sdd8
<6>md:  adding sdc8 ...
<4>md: sdc7 has different UUID to sdd8
<4>md: sdc6 has different UUID to sdd8
<4>md: sdc5 has different UUID to sdd8
<4>md: sdc3 has different UUID to sdd8
<6>md:  adding sdb8 ...
<4>md: sdb7 has different UUID to sdd8
<4>md: sdb6 has different UUID to sdd8
<4>md: sdb5 has different UUID to sdd8
<4>md: sdb3 has different UUID to sdd8
<6>md:  adding sda8 ...
<4>md: sda7 has different UUID to sdd8
<4>md: sda6 has different UUID to sdd8
<4>md: sda5 has different UUID to sdd8
<4>md: sda3 has different UUID to sdd8
<6>md: created md8
<6>md: bind<sda8>
<6>md: bind<sdb8>
<6>md: bind<sdc8>
<6>md: bind<sdd8>
<6>md: running: <sdd8><sdc8><sdb8><sda8>
<6>raid1: raid set md8 active with 4 out of 4 mirrors
<6>md: considering sdd7 ...
<6>md:  adding sdd7 ...
<4>md: sdd6 has different UUID to sdd7
<4>md: sdd5 has different UUID to sdd7
<4>md: sdd3 has different UUID to sdd7
<6>md:  adding sdc7 ...
<4>md: sdc6 has different UUID to sdd7
<4>md: sdc5 has different UUID to sdd7
<4>md: sdc3 has different UUID to sdd7
<6>md:  adding sdb7 ...
<4>md: sdb6 has different UUID to sdd7
<4>md: sdb5 has different UUID to sdd7
<4>md: sdb3 has different UUID to sdd7
<6>md:  adding sda7 ...
<4>md: sda6 has different UUID to sdd7
<4>md: sda5 has different UUID to sdd7
<4>md: sda3 has different UUID to sdd7
<6>md: created md7
<6>md: bind<sda7>
<6>md: bind<sdb7>
<6>md: bind<sdc7>
<6>md: bind<sdd7>
<6>md: running: <sdd7><sdc7><sdb7><sda7>
<6>raid1: raid set md7 active with 4 out of 4 mirrors
<6>md: considering sdd6 ...
<6>md:  adding sdd6 ...
<4>md: sdd5 has different UUID to sdd6
<4>md: sdd3 has different UUID to sdd6
<6>md:  adding sdc6 ...
<4>md: sdc5 has different UUID to sdd6
<4>md: sdc3 has different UUID to sdd6
<6>md:  adding sdb6 ...
<4>md: sdb5 has different UUID to sdd6
<4>md: sdb3 has different UUID to sdd6
<6>md:  adding sda6 ...
<4>md: sda5 has different UUID to sdd6
<4>md: sda3 has different UUID to sdd6
<6>md: created md6
<6>md: bind<sda6>
<6>md: bind<sdb6>
<6>md: bind<sdc6>
<6>md: bind<sdd6>
<6>md: running: <sdd6><sdc6><sdb6><sda6>
<6>raid1: raid set md6 active with 4 out of 4 mirrors
<6>md: considering sdd5 ...
<6>md:  adding sdd5 ...
<4>md: sdd3 has different UUID to sdd5
<6>md:  adding sdc5 ...
<4>md: sdc3 has different UUID to sdd5
<6>md:  adding sdb5 ...
<4>md: sdb3 has different UUID to sdd5
<6>md:  adding sda5 ...
<4>md: sda3 has different UUID to sdd5
<6>md: created md5
<6>md: bind<sda5>
<6>md: bind<sdb5>
<6>md: bind<sdc5>
<6>md: bind<sdd5>
<6>md: running: <sdd5><sdc5><sdb5><sda5>
<6>raid1: raid set md5 active with 4 out of 4 mirrors
<6>md: considering sdd3 ...
<6>md:  adding sdd3 ...
<6>md:  adding sdc3 ...
<6>md:  adding sdb3 ...
<6>md:  adding sda3 ...
<6>md: created md3
<6>md: bind<sda3>
<6>md: bind<sdb3>
<6>md: bind<sdc3>
<6>md: bind<sdd3>
<6>md: running: <sdd3><sdc3><sdb3><sda3>
<6>raid1: raid set md3 active with 4 out of 4 mirrors
<6>md: ... autorun DONE.
<5>RAMDISK: Compressed image found at block 0
<4>VFS: Mounted root (ext2 filesystem).
<6>ipmi message handler version 39.0
<6>IPMI System Interface driver.
<6>ipmi: Found new BMC (man_id: 0x0019fd,  prod_id: 0x1426, dev_id: 0x00)=

<4> IPMI KCS interface initialized
<6>ipmi_si: Found default KCS state machine at I/O address 0xca2
<6>ipmi device interface
<6>e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
<6>e100: Copyright(c) 1999-2005 Intel Corporation
<6>Intel(R) PRO/1000 Network Driver - version 7.0.33-k2
<6>Copyright (c) 1999-2005 Intel Corporation.
<6>ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 19 (level, low) -> IRQ 17
<6>e1000: 0000:02:06.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:e0:81:64:5f=
:de
<6>e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
<6>ACPI: PCI Interrupt 0000:02:06.1[B] -> GSI 18 (level, low) -> IRQ 18
<6>e1000: 0000:02:06.1: e1000_probe: (PCI-X:133MHz:64-bit) 00:e0:81:64:5f=
:df
<6>e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
<6>ACPI: PCI Interrupt 0000:03:07.0[A] -> GSI 17 (level, low) -> IRQ 19
<6>e1000: 0000:03:07.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:e0:81:64:5f=
:e0
<6>e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
<6>ACPI: PCI Interrupt 0000:03:07.1[B] -> GSI 16 (level, low) -> IRQ 16
<6>e1000: 0000:03:07.1: e1000_probe: (PCI-X:133MHz:64-bit) 00:e0:81:64:5f=
:e1
<6>e1000: eth3: e1000_probe: Intel(R) PRO/1000 Network Connection
<5>ReiserFS: md8: found reiserfs format "3.6" with standard journal
<5>ReiserFS: md8: using ordered data mode
<5>ReiserFS: md8: journal params: device md8, size 8192, journal first bl=
ock 18, max trans len 1024, max batch 900, max commit age 30, max trans a=
ge 30
<5>ReiserFS: md8: checking transaction log (md8)
<5>ReiserFS: md8: Using r5 hash to sort names
<5>ReiserFS: md3: found reiserfs format "3.6" with standard journal
<5>ReiserFS: md3: using ordered data mode
<5>ReiserFS: md3: journal params: device md3, size 8192, journal first bl=
ock 18, max trans len 1024, max batch 900, max commit age 30, max trans a=
ge 30
<5>ReiserFS: md3: checking transaction log (md3)
<5>ReiserFS: md3: Using r5 hash to sort names
<4>VFS: Mounted root (reiserfs filesystem) readonly.
<5>Trying to move old root to /initrd ... /initrd does not exist. Ignored=
=2E
<5>Unmounting old root
<5>Trying to free ramdisk memory ... okay
<6>Freeing unused kernel memory: 184k freed
<6>md: Autodetecting RAID arrays.
<6>md: autorun ...
<6>md: ... autorun DONE.
<5>ReiserFS: md7: found reiserfs format "3.6" with standard journal
<5>ReiserFS: md7: using ordered data mode
<5>ReiserFS: md7: journal params: device md7, size 8192, journal first bl=
ock 18, max trans len 1024, max batch 900, max commit age 30, max trans a=
ge 30
<5>ReiserFS: md7: checking transaction log (md7)
<5>ReiserFS: md7: Using r5 hash to sort names
<5>ReiserFS: md8: found reiserfs format "3.6" with standard journal
<5>ReiserFS: md8: using ordered data mode
<5>ReiserFS: md8: journal params: device md8, size 8192, journal first bl=
ock 18, max trans len 1024, max batch 900, max commit age 30, max trans a=
ge 30
<5>ReiserFS: md8: checking transaction log (md8)
<5>ReiserFS: md8: Using r5 hash to sort names
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

Boot logging started on /dev/tty1(/dev/console) at Tue May 16 16:28:51 20=
06

Master Resource Control: previous runlevel: N, switching to runlevel: 3
<notice>start services (starting_services random iterator firewall)
Logging the start of the bootdone
Initializing random number generatordone
<notice>startproc: execve (/usr/bin/IterServ) [ /usr/bin/IterServ ], [ CO=
NSOLE=3D/dev/console TERM=3Dlinux SHELL=3D/bin/sh progress=3D20 INIT_VERS=
ION=3Dsysvinit-2.85 REDIRECT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/usr/local/s=
bin:/sbin:/bin:/usr/sbin:/usr/bin RUNLEVEL=3D3 PWD=3D/ PREVLEVEL=3DN LINE=
S=3D25 HOME=3D/ SHLVL=3D2 BOOT_IMAGE=3Dproduction-m sscripts=3D38 _=3D/sb=
in/startproc DAEMON=3D/usr/bin/IterServ ]
Starting iterator daemondone
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
=46ATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
<notice>exit status of (starting_services random iterator firewall) is (0=
 0 0 0)
<notice>start services (network)
Setting up network interfaces:
    lo      =20
    lo        IP address: 127.0.0.1/8  =20
done    eth0      device: Intel Corporation 82546GB Gigabit Ethernet Cont=
roller (rev 03)
    eth0      Startmode is 'manual'
skipped    eth1      device: Intel Corporation 82546GB Gigabit Ethernet C=
ontroller (rev 03)
    eth1      Startmode is 'manual'
skipped    eth2      device: Intel Corporation 82546GB Gigabit Ethernet C=
ontroller (rev 03)
    eth2      IP address: 10.241.28.82/29  =20
Shutting down external SSH daemondone
Starting external SSH daemon<notice>startproc: execve (/usr/sbin/sshd_ext=
ernal) [ /usr/sbin/sshd_external -f /etc/ssh/sshd_config_external -o PidF=
ile=3D/var/run/sshd_external.init.pid ], [ HWD_INTERFACE_0=3Deth2 CONSOLE=
=3D/dev/console HWD_HWDESC=3Deth2 TERM=3Dlinux SHELL=3D/bin/sh HWD_BUSID_=
0=3D0000:00:01.0 HWD_BUSNAME_2=3Dpci HWD_BUSID_1=3D0000:01:00.0 HWD_BUSNA=
ME_0=3Dpci HWD_BUSID_2=3D0000:02:06.0 HWD_BUSNAME_1=3Dpci HWD_VENDORID=3D=
0x8086 HWD_BUSID=3D0000:02:06.0 HWD_PRODUCTSUBID=3D0x1179 progress=3D24 H=
WD_CONFIG_N=3D1 INIT_VERSION=3Dsysvinit-2.85 RUN_FROM_RC=3Dyes REDIRECT=3D=
/dev/tty1 HWD_INTERFACEPATH=3D/sys/class/net/eth2 COLUMNS=3D80 HWD_DEVTYP=
E=3Deth HWD_ID=3D00:e0:81:64:5f:de HWD_BUSNAME=3Dpci PATH=3D/sbin:/usr/sb=
in:/bin:/usr/bin:/etc/sysconfig/network/scripts RUNLEVEL=3D3 PWD=3D/etc/s=
ysconfig/network PREVLEVEL=3DN LINES=3D25 HWD_HWDESCTYPE=3Dinterface HOME=
=3D/ SHLVL=3D6 BOOT_IMAGE=3Dproduction-m HWD_CONFIG_0=3Deth2 HWD_BUS_N=3D=
3 sscripts=3D38 HWD_VENDORSUBID=3D0x8086 HWD_PRODUCTID=3D0x1079 HWD_INTER=
FACE_N=3D1 HWD_DEVICEPATH=3D/sys/devices/pci0000:00/0000:00:01.0/0000:01:=
00.0/0000:02:06.0 _=3D/sbin/startproc DAEMON=3D/usr/sbin/sshd_external ]
done
Shutting down external SSH daemon<notice>killproc: kill(5452,15)
done
Starting external SSH daemon<notice>startproc: execve (/usr/sbin/sshd_ext=
ernal) [ /usr/sbin/sshd_external -f /etc/ssh/sshd_config_external -o PidF=
ile=3D/var/run/sshd_external.init.pid ], [ HWD_INTERFACE_0=3Deth2 CONSOLE=
=3D/dev/console HWD_HWDESC=3Deth2 TERM=3Dlinux SHELL=3D/bin/sh HWD_BUSID_=
0=3D0000:00:01.0 HWD_BUSNAME_2=3Dpci HWD_BUSID_1=3D0000:01:00.0 HWD_BUSNA=
ME_0=3Dpci HWD_BUSID_2=3D0000:02:06.0 HWD_BUSNAME_1=3Dpci HWD_VENDORID=3D=
0x8086 HWD_BUSID=3D0000:02:06.0 HWD_PRODUCTSUBID=3D0x1179 progress=3D24 H=
WD_CONFIG_N=3D1 INIT_VERSION=3Dsysvinit-2.85 RUN_FROM_RC=3Dyes REDIRECT=3D=
/dev/tty1 HWD_INTERFACEPATH=3D/sys/class/net/eth2 COLUMNS=3D80 HWD_DEVTYP=
E=3Deth HWD_ID=3D00:e0:81:64:5f:de HWD_BUSNAME=3Dpci PATH=3D/sbin:/usr/sb=
in:/bin:/usr/bin:/etc/sysconfig/network/scripts RUNLEVEL=3D3 PWD=3D/etc/s=
ysconfig/network PREVLEVEL=3DN LINES=3D25 HWD_HWDESCTYPE=3Dinterface HOME=
=3D/ SHLVL=3D6 BOOT_IMAGE=3Dproduction-m HWD_CONFIG_0=3Deth2 HWD_BUS_N=3D=
3 sscripts=3D38 HWD_VENDORSUBID=3D0x8086 HWD_PRODUCTID=3D0x1079 HWD_INTER=
FACE_N=3D1 HWD_DEVICEPATH=3D/sys/devices/pci0000:00/0000:00:01.0/0000:01:=
00.0/0000:02:06.0 _=3D/sbin/startproc DAEMON=3D/usr/sbin/sshd_external ]
done
WARNING: pinging broadcast address
PING 10.241.28.87 (10.241.28.87) from 10.241.28.82 eth2: 56(84) bytes of =
data.

--- 10.241.28.87 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms

grep: /etc/resolv.conf: No such file or directory
unix dgram connect: No such file or directory at /usr/lib/perl5/site_perl=
/5.8.3/Log/Agent/Channel/Syslog.pm line 119
no connection to syslog available at /usr/lib/perl5/site_perl/5.8.3/Log/A=
gent/Channel/Syslog.pm line 119
done    eth3      device: Intel Corporation 82546GB Gigabit Ethernet Cont=
roller (rev 03)
    eth3      No configuration found for eth3
unusedSetting up service network  .  .  .  .  .  .  .  .  .  .  .  .  .  =
=2E  .  .done
<notice>exit status of (network) is (0)
<notice>start services (syslog)
Starting syslog services<notice>startproc: execve (/sbin/syslogd) [ /sbin=
/syslogd -a /var/lib/dhcp/dev/log ], [ CONSOLE=3D/dev/console TERM=3Dlinu=
x SHELL=3D/bin/sh progress=3D25 INIT_VERSION=3Dsysvinit-2.85 REDIRECT=3D/=
dev/tty1 COLUMNS=3D80 PATH=3D/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bi=
n RUNLEVEL=3D3 PWD=3D/ PREVLEVEL=3DN LINES=3D25 HOME=3D/ SHLVL=3D2 BOOT_I=
MAGE=3Dproduction-m sscripts=3D38 _=3D/sbin/startproc DAEMON=3D/sbin/sysl=
ogd ]
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@  syslogd: Can't bind unix unix socket to n=
ame: Address already in use

<notice>startproc: execve (/sbin/klogd) [ /sbin/klogd -c 1 -2 -x ], [ CON=
SOLE=3D/dev/console TERM=3Dlinux SHELL=3D/bin/sh progress=3D25 INIT_VERSI=
ON=3Dsysvinit-2.85 REDIRECT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/usr/local/sb=
in:/sbin:/bin:/usr/sbin:/usr/bin RUNLEVEL=3D3 PWD=3D/ PREVLEVEL=3DN LINES=
=3D25 HOME=3D/ SHLVL=3D2 BOOT_IMAGE=3Dproduction-m sscripts=3D38 _=3D/sbi=
n/startproc DAEMON=3D/sbin/klogd ]
done
<notice>exit status of (syslog) is (0)
<notice>start services (smartd)
Generating /etc/smartd.conf: Disabling SMART on this node.
done<notice>exit status of (smartd) is (0)
<notice>start services (xinetd microcode_ctl microcode)
<notice>startproc: execve (/usr/sbin/xinetd) [ /usr/sbin/xinetd ], [ CONS=
OLE=3D/dev/console TERM=3Dlinux SHELL=3D/bin/sh progress=3D27 INIT_VERSIO=
N=3Dsysvinit-2.85 REDIRECT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/usr/local/sbi=
n:/sbin:/bin:/usr/sbin:/usr/bin RUNLEVEL=3D3 PWD=3D/ PREVLEVEL=3DN LINES=3D=
25 HOME=3D/ SHLVL=3D2 BOOT_IMAGE=3Dproduction-m sscripts=3D38 _=3D/sbin/s=
tartproc DAEMON=3D/usr/sbin/xinetd ]
Checking/updating CPU microcodedone
Applying Intel IA32 Microcode update...=20
done

Starting INET services. (xinetd)done
<notice>exit status of (xinetd microcode_ctl microcode) is (0 0 0)
<notice>start services (clusternet)
Starting cluster networking backgrounding
<notice>exit status of (clusternet) is (0)
<notice>start services (clusternetwait)
Waiting for clusternet IP detection to finish: waiting 1swaiting 2swaitin=
g 3swaiting 4swaiting 5swaiting 6swaiting 7swaiting 8swaiting 9swaiting 1=
0swaiting 11swaiting 12swaiting 13swaiting 14swaiting 15swaiting 16swaiti=
ng 17swaiting 18swaiting 19swaiting 20swaiting 21swaiting 22swaiting 23sw=
aiting 24swaiting 25swaiting 26swaiting 27swaiting 28swaiting 29swaiting =
30swaiting 31swaiting 32swaiting 33s<notice>startproc: execve (/usr/sbin/=
sshd) [ /usr/sbin/sshd -o PidFile=3D/var/run/sshd.init.pid ], [ CONSOLE=3D=
/dev/console TERM=3Dlinux SHELL=3D/bin/sh progress=3D30 INIT_VERSION=3Dsy=
svinit-2.85 REDIRECT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/usr/local/sbin:/sbi=
n:/bin:/usr/sbin:/usr/bin RUNLEVEL=3D3 PWD=3D/ PREVLEVEL=3DN LINES=3D25 H=
OME=3D/ SHLVL=3D4 BOOT_IMAGE=3Dproduction-m sscripts=3D38 _=3D/sbin/start=
proc DAEMON=3D/usr/sbin/sshd ]
<notice>startproc: execve (/usr/sbin/ntpd) [ /usr/sbin/ntpd -p /var/lib/n=
tp/var/run/ntp/ntpd.pid -U ntp ], [ CONSOLE=3D/dev/console TERM=3Dlinux S=
HELL=3D/bin/sh progress=3D30 INIT_VERSION=3Dsysvinit-2.85 REDIRECT=3D/dev=
/tty1 COLUMNS=3D80 PATH=3D/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin R=
UNLEVEL=3D3 PWD=3D/ PREVLEVEL=3DN LINES=3D25 HOME=3D/ SHLVL=3D4 BOOT_IMAG=
E=3Dproduction-m sscripts=3D38 OLDPWD=3D/var/local/bootstat _=3D/sbin/sta=
rtproc DAEMON=3D/usr/sbin/ntpd ]
<notice>checkproc: /usr/sbin/ntpd 5859
waiting 34swaiting 35swaiting 36swaiting 37swaiting 38swaiting 39swaiting=
 40swaiting 41swaiting 42swaiting 43swaiting 44swaiting 45swaiting 46swai=
ting 47swaiting 48swaiting 49swaiting 50swaiting 51swaiting 52swaiting 53=
swaiting 54swaiting 55swaiting 56swaiting 57swaiting 58swaiting 59swaitin=
g 60swaiting 61swaiting 62s<notice>killproc: kill(5813,15)
waiting 63s<notice>startproc: execve (/usr/sbin/sshd) [ /usr/sbin/sshd -o=
 PidFile=3D/var/run/sshd.init.pid ], [ CONSOLE=3D/dev/console TERM=3Dlinu=
x SHELL=3D/bin/sh progress=3D30 INIT_VERSION=3Dsysvinit-2.85 REDIRECT=3D/=
dev/tty1 COLUMNS=3D80 PATH=3D/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bi=
n RUNLEVEL=3D3 PWD=3D/ PREVLEVEL=3DN LINES=3D25 HOME=3D/ SHLVL=3D4 BOOT_I=
MAGE=3Dproduction-m sscripts=3D38 _=3D/sbin/startproc DAEMON=3D/usr/sbin/=
sshd ]
Started cluster networking done
waiting 64s                               done
Change hostname to c001n01 done
<notice>exit status of (clusternetwait) is (0)
<notice>start services (connectemc)
Starting ConnectEMC <notice>startproc: execve (/opt/connectemc/connectemc=
) [ /opt/connectemc/connectemc ], [ CONSOLE=3D/dev/console TERM=3Dlinux S=
HELL=3D/bin/sh progress=3D32 INIT_VERSION=3Dsysvinit-2.85 REDIRECT=3D/dev=
/tty1 COLUMNS=3D80 PATH=3D/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin R=
UNLEVEL=3D3 PWD=3D/ PREVLEVEL=3DN LINES=3D25 HOME=3D/ SHLVL=3D2 BOOT_IMAG=
E=3Dproduction-m sscripts=3D38 _=3D/sbin/startproc DAEMON=3D/opt/connecte=
mc/connectemc ]
done
<notice>exit status of (connectemc) is (0)
<notice>start services (cron blobpartitions)
<notice>startproc: execve (/usr/sbin/cron) [ /usr/sbin/cron ], [ CONSOLE=3D=
/dev/console TERM=3Dlinux SHELL=3D/bin/sh progress=3D33 INIT_VERSION=3Dsy=
svinit-2.85 REDIRECT=3D/dev/tty1 COLUMNS=3D80 PATH=3D/usr/local/sbin:/sbi=
n:/bin:/usr/sbin:/usr/bin RUNLEVEL=3D3 PWD=3D/ PREVLEVEL=3DN LINES=3D25 H=
OME=3D/ SHLVL=3D2 BOOT_IMAGE=3Dproduction-m sscripts=3D38 _=3D/sbin/start=
proc DAEMON=3D/usr/sbin/cron ]
Starting CRON daemondone
Start activating blob partition /dev/cstardn10
Start activating blob partition /dev/cstardo10
Start activating blob partition /dev/cstardp10
Start activating blob partition /dev/cstardm10
Finish mounting blob partition /dev/cstardp10:done
Finish mounting blob partition /dev/cstardm10:done
Start activating blob partition /dev/cstardm11
Finish mounting blob partition /dev/cstardn10:done
Start activating blob partition /dev/cstardn11
Finish mounting blob partition /dev/cstardo10:done
Start activating blob partition /dev/cstardo11
Start activating blob partition /dev/cstardp11
Finish mounting blob partition /dev/cstardm11:done
Start activating blob partition /dev/cstardm12
Finish mounting blob partition /dev/cstardo11:done
Start activating blob partition /dev/cstardo12
Finish mounting blob partition /dev/cstardn11:done
Start activating blob partition /dev/cstardn12
Finish mounting blob partition /dev/cstardp11:done
Finish mounting blob partition /dev/cstardm12:done
Finish mounting blob partition /dev/cstardo12:done
Start activating blob partition /dev/cstardo13
Finish mounting blob partition /dev/cstardn12:done
Start activating blob partition /dev/cstardn13
Start activating blob partition /dev/cstardp12
Start activating blob partition /dev/cstardm13
Finish mounting blob partition /dev/cstardn13:done
Start activating blob partition /dev/cstardn14
Finish mounting blob partition /dev/cstardp12:done
Start activating blob partition /dev/cstardp13
Finish mounting blob partition /dev/cstardm13:done
Start activating blob partition /dev/cstardm14
Finish mounting blob partition /dev/cstardo13:done
Start activating blob partition /dev/cstardo14
Finish mounting blob partition /dev/cstardp13:done
Start activating blob partition /dev/cstardp14
Finish mounting blob partition /dev/cstardm14:done
Finish mounting blob partition /dev/cstardn14:done
Finish mounting blob partition /dev/cstardo14:done
Finish mounting blob partition /dev/cstardp14:done
<notice>exit status of (cron blobpartitions) is (0 0)
<notice>start services (inventory fragmentcounter)
Removing old imagesStarting fragment counter: done
<notice>exit status of (inventory fragmentcounter) is (0 0)
<notice>start services (filepool)
Starting FilePool software FATAL: Module ip_tables not found.
iptables v1.2.9: can't initialize iptables table `filter': iptables who? =
(do you need to insmod?)
Perhaps iptables or your kernel needs to be upgraded.
done
<notice>exit status of (filepool) is (0)
<notice>start services (successful_boot)
Setting GRUB for a production boot on disks:
    /dev/cstardm;/dev/cstardn;/dev/cstardo;/dev/cstardpdone
<notice>exit status of (successful_boot) is (0)
Master Resource Control: runlevel 3 has been reached
<notice>killproc: kill(4858,3)

--------------080505060902010608040300--
