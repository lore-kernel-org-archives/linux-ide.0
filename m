From: Daniel Brahneborg <daniel.com@wtnord.net>
Subject: 2.6.3: sata_via "abnormal status 0xD0 on port 0xC007"
Date: Thu, 19 Feb 2004 21:11:25 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040219211125.A9526@nettis.grimsta>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 212-214-140-145.v-by.wtnord.net ([212.214.140.145]:53911 "EHLO
	ricercar.mine.nu") by vger.kernel.org with ESMTP id S267541AbUBSULf
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2004 15:11:35 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, akpm@osdl.org, linux-ide@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I decided to make a new try with the 2.6.3 and 2.6.3-mm1 kernels
with two SATA disks, on the SATA connectors on the motherboard
(Abit KV7). The sata_via module loads fine and gives me two disks:
sda and sdb. However, while small files work fine, I still get
random data corruption on large (500MB files).

With 2.6.3, the checksum of each copy is different, but same for
each file. The corruption probably happens during write.

With 2.6.3-mm1, the log file ends like this:

Feb 19 21:11:17 fw kernel: ata1: DMA timeout, stat 0x0
Feb 19 21:11:17 fw kernel: ATA: abnormal status 0xD0 on port 0xC007

After that, the md5sum process is dead, can't be killed, and a
hard reset was required.

I've attached /var/log/messages, /var/log/dmesg, and the output
from /proc/interrupts and "lspci -vv".

I hope you can help me with this.

/Basic


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=messages

Feb 19 21:08:25 fw syslogd 1.4.1: restart.
Feb 19 21:08:25 fw syslog: syslogd startup succeeded
Feb 19 21:08:25 fw kernel: klogd 1.4.1, log source = /proc/kmsg started.
Feb 19 21:08:25 fw kernel: Linux version 2.6.3-mm1 (root@fw.grimsta) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #16 Thu Feb 19 21:05:22 CET 2004
Feb 19 21:08:25 fw kernel: BIOS-provided physical RAM map:
Feb 19 21:08:25 fw kernel:  BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
Feb 19 21:08:25 fw kernel:  BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
Feb 19 21:08:25 fw kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Feb 19 21:08:25 fw kernel:  BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
Feb 19 21:08:25 fw kernel:  BIOS-e820: 000000000fef0000 - 000000000fef3000 (ACPI NVS)
Feb 19 21:08:25 fw kernel:  BIOS-e820: 000000000fef3000 - 000000000ff00000 (ACPI data)
Feb 19 21:08:25 fw kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Feb 19 21:08:25 fw kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Feb 19 21:08:25 fw kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Feb 19 21:08:25 fw syslog: klogd startup succeeded
Feb 19 21:08:25 fw kernel: 254MB LOWMEM available.
Feb 19 21:08:25 fw keytable: Loading keymap: 
Feb 19 21:08:25 fw kernel: found SMP MP-table at 000f5e70
Feb 19 21:08:25 fw kernel: zapping low mappings.
Feb 19 21:08:25 fw kernel: On node 0 totalpages: 65264
Feb 19 21:08:25 fw kernel:   DMA zone: 4096 pages, LIFO batch:1
Feb 19 21:08:25 fw keytable: ^[[60G
Feb 19 21:08:25 fw kernel:   Normal zone: 61168 pages, LIFO batch:14
Feb 19 21:08:25 fw keytable: 
Feb 19 21:08:25 fw kernel:   HighMem zone: 0 pages, LIFO batch:1
Feb 19 21:08:26 fw keytable: Loading system font: 
Feb 19 21:08:26 fw kernel: DMI 2.2 present.
Feb 19 21:08:26 fw keytable: 
Feb 19 21:08:26 fw kernel: ACPI: RSDP (v000 KT600                                     ) @ 0x000f7860
Feb 19 21:08:26 fw rc: Starting keytable:  succeeded
Feb 19 21:08:26 fw kernel: ACPI: RSDT (v001 KT600  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fef3000
Feb 19 21:08:26 fw kernel: ACPI: FADT (v001 KT600  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fef3040
Feb 19 21:08:26 fw kernel: ACPI: MADT (v001 KT600  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fef7a00
Feb 19 21:08:26 fw kernel: ACPI: DSDT (v001 KT600  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
Feb 19 21:08:26 fw random: Initializing random number generator:  succeeded
Feb 19 21:08:26 fw kernel: ACPI: Local APIC address 0xfee00000
Feb 19 21:08:26 fw kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Feb 19 21:08:26 fw kernel: Processor #0 6:3 APIC version 16
Feb 19 21:08:26 fw kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Feb 19 21:08:26 fw kernel: Using ACPI for processor (LAPIC) configuration information
Feb 19 21:08:26 fw kernel: Intel MultiProcessor Specification v1.4
Feb 19 21:08:26 fw kernel:     Virtual Wire compatibility mode.
Feb 19 21:08:26 fw kernel: OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Feb 19 21:08:26 fw kernel: I/O APIC #2 Version 17 at 0xFEC00000.
Feb 19 21:08:27 fw mount: mount: wrong fs type, bad option, bad superblock on none,
Feb 19 21:08:27 fw kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Feb 19 21:08:27 fw mount:        or too many mounted file systems
Feb 19 21:08:27 fw kernel: Processors: 1
Feb 19 21:08:27 fw kernel: Built 1 zonelists
Feb 19 21:08:27 fw kernel: Initializing CPU#0
Feb 19 21:08:27 fw netfs: Mounting other filesystems:  failed
Feb 19 21:08:27 fw kernel: Kernel command line: ro root=/dev/hda3
Feb 19 21:08:27 fw kernel: PID hash table entries: 1024 (order 10: 8192 bytes)
Feb 19 21:08:25 fw ifup:  done. 
Feb 19 21:08:27 fw kernel: Detected 819.189 MHz processor.
Feb 19 21:08:25 fw network: Bringing up interface eth0:  succeeded 
Feb 19 21:08:27 fw kernel: Using tsc for high-res timesource
Feb 19 21:08:28 fw kernel: Console: colour VGA+ 80x25
Feb 19 21:08:28 fw autofs: automount startup succeeded
Feb 19 21:08:28 fw kernel: Memory: 254680k/261056k available (2038k kernel code, 5640k reserved, 722k data, 132k init, 0k highmem)
Feb 19 21:08:28 fw kernel: Calibrating delay loop... 1609.72 BogoMIPS
Feb 19 21:08:28 fw smartd[532]: smartd version 5.26 Copyright (C) 2002-3 Bruce Allen 
Feb 19 21:08:28 fw kernel: Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Feb 19 21:08:28 fw smartd[532]: Home page is http://smartmontools.sourceforge.net/  
Feb 19 21:08:28 fw kernel: Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Feb 19 21:08:28 fw smartd[532]: Opened configuration file /etc/smartd.conf 
Feb 19 21:08:28 fw kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Feb 19 21:08:28 fw smartd[532]: Configuration file /etc/smartd.conf parsed. 
Feb 19 21:08:28 fw smartd[532]: Device: /dev/hda, opened 
Feb 19 21:08:28 fw smartd[532]: Device: /dev/hda, not found in smartd database. 
Feb 19 21:08:28 fw kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Feb 19 21:08:29 fw kernel: CPU: L2 Cache: 64K (64 bytes/line)
Feb 19 21:08:29 fw smartd[532]: Device: /dev/hda, is SMART capable. Adding to "monitor" list. 
Feb 19 21:08:29 fw kernel: Intel machine check architecture supported.
Feb 19 21:08:29 fw smartd[532]: Device: /dev/hdi, No such device or address, open() failed 
Feb 19 21:08:29 fw kernel: Intel machine check reporting enabled on CPU#0.
Feb 19 21:08:29 fw smartd[532]: Unable to register ATA device /dev/hdi at line 31 of file /etc/smartd.conf 
Feb 19 21:08:29 fw kernel: CPU: AMD Duron(tm) processor stepping 01
Feb 19 21:08:29 fw smartd[532]: Unable to register device /dev/hdi (no Directive -d removable). Exiting. 
Feb 19 21:08:29 fw kernel: Enabling fast FPU save and restore... done.
Feb 19 21:08:29 fw kernel: Checking 'hlt' instruction... OK.
Feb 19 21:08:29 fw smartd: smartd startup failed
Feb 19 21:08:29 fw kernel: POSIX conformance testing by UNIFIX
Feb 19 21:08:29 fw kernel: enabled ExtINT on CPU#0
Feb 19 21:08:29 fw kernel: ESR value before enabling vector: 00000000
Feb 19 21:08:29 fw kernel: ESR value after enabling vector: 00000000
Feb 19 21:08:30 fw named[543]: starting BIND 9.2.1 -u named
Feb 19 21:08:30 fw kernel: ENABLING IO-APIC IRQs
Feb 19 21:08:30 fw named[543]: using 1 CPU
Feb 19 21:08:30 fw kernel: Setting 2 in the phys_id_present_map
Feb 19 21:08:30 fw kernel: ...changing IO-APIC physical APIC ID to 2 ... ok.
Feb 19 21:08:30 fw named: named startup succeeded
Feb 19 21:08:30 fw named[546]: loading configuration from '/etc/named.conf'
Feb 19 21:08:31 fw named[546]: no IPv6 interfaces found
Feb 19 21:08:31 fw sshd: Starting sshd:
Feb 19 21:08:31 fw named[546]: listening on IPv4 interface lo, 127.0.0.1#53
Feb 19 21:08:31 fw sshd:  succeeded
Feb 19 21:08:31 fw kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Feb 19 21:08:31 fw named[546]: listening on IPv4 interface eth0, 192.168.50.59#53
Feb 19 21:08:31 fw sshd: ^[[60G
Feb 19 21:08:32 fw named[546]: command channel listening on 127.0.0.1#953
Feb 19 21:08:32 fw sshd: 
Feb 19 21:08:32 fw rc: Starting sshd:  succeeded
Feb 19 21:08:32 fw named[546]: zone 0.0.127.in-addr.arpa/IN: loaded serial 1997022700
Feb 19 21:08:32 fw kernel: testing the IO APIC.......................
Feb 19 21:08:32 fw named[546]: zone localhost/IN: loaded serial 42
Feb 19 21:08:32 fw named[546]: running
Feb 19 21:08:33 fw kernel: .................................... done.
Feb 19 21:08:33 fw kernel: Using local APIC timer interrupts.
Feb 19 21:08:33 fw kernel: calibrating APIC timer ...
Feb 19 21:08:33 fw kernel: ..... CPU clock speed is 819.0133 MHz.
Feb 19 21:08:33 fw kernel: ..... host bus clock speed is 204.0783 MHz.
Feb 19 21:08:33 fw kernel: NET: Registered protocol family 16
Feb 19 21:08:33 fw kernel: PCI: PCI BIOS revision 2.10 entry at 0xfaf40, last bus=1
Feb 19 21:08:33 fw kernel: PCI: Using configuration type 1
Feb 19 21:08:33 fw kernel: PCI: Probing PCI hardware
Feb 19 21:08:33 fw kernel: PCI: Probing PCI hardware (bus 00)
Feb 19 21:08:33 fw kernel: PCI: Using IRQ router VIA [1106/3227] at 0000:00:11.0
Feb 19 21:08:33 fw kernel: PCI->APIC IRQ transform: (B0,I12,P0) -> 19
Feb 19 21:08:33 fw kernel: PCI->APIC IRQ transform: (B0,I15,P1) -> 20
Feb 19 21:08:33 fw kernel: PCI->APIC IRQ transform: (B0,I15,P0) -> 20
Feb 19 21:08:33 fw kernel: PCI->APIC IRQ transform: (B0,I18,P0) -> 23
Feb 19 21:08:33 fw kernel: Machine check exception polling timer started.
Feb 19 21:08:33 fw kernel: SGI XFS with ACLs, no debug enabled
Feb 19 21:08:33 fw kernel: Real Time Clock Driver v1.12
Feb 19 21:08:33 fw kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb 19 21:08:33 fw kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 19 21:08:33 fw kernel: VP_IDE: IDE controller at PCI slot 0000:00:0f.1
Feb 19 21:08:33 fw kernel: VP_IDE: chipset revision 6
Feb 19 21:08:33 fw kernel: VP_IDE: not 100%% native mode: will probe irqs later
Feb 19 21:08:33 fw kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 19 21:08:34 fw kernel: VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
Feb 19 21:08:34 fw kernel:     ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
Feb 19 21:08:34 fw kernel:     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:DMA
Feb 19 21:08:34 fw kernel: hda: FUJITSU MHM2060AT, ATA DISK drive
Feb 19 21:08:34 fw kernel: Using anticipatory io scheduler
Feb 19 21:08:34 fw xinetd[576]: pmap_set failed. service=sgi_fam program=391002 version=2
Feb 19 21:08:34 fw kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 19 21:08:34 fw kernel: hdd: MATSHITA CD-RW CW-7586, ATAPI CD/DVD-ROM drive
Feb 19 21:08:34 fw kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 19 21:08:34 fw kernel: hda: max request size: 128KiB
Feb 19 21:08:34 fw kernel: hda: 11733120 sectors (6007 MB) w/2048KiB Cache, CHS=12416/15/63, UDMA(66)
Feb 19 21:08:34 fw kernel:  hda: hda1 hda2 hda3
Feb 19 21:08:34 fw kernel: hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Feb 19 21:08:34 fw kernel: Uniform CD-ROM driver Revision: 3.20
Feb 19 21:08:34 fw kernel: mice: PS/2 mouse device common for all mice
Feb 19 21:08:34 fw kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb 19 21:08:34 fw kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 19 21:08:34 fw kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Feb 19 21:08:34 fw kernel: md: raid1 personality registered as nr 3
Feb 19 21:08:34 fw kernel: md: raid5 personality registered as nr 4
Feb 19 21:08:34 fw kernel: raid5: measuring checksumming speed
Feb 19 21:08:34 fw kernel:    8regs     :  1100.000 MB/sec
Feb 19 21:08:34 fw kernel:    8regs_prefetch:  1036.000 MB/sec
Feb 19 21:08:34 fw kernel:    32regs    :   860.000 MB/sec
Feb 19 21:08:34 fw kernel:    32regs_prefetch:   824.000 MB/sec
Feb 19 21:08:34 fw kernel:    pII_mmx   :  2188.000 MB/sec
Feb 19 21:08:34 fw kernel:    p5_mmx    :  2924.000 MB/sec
Feb 19 21:08:34 fw kernel: raid5: using function: p5_mmx (2924.000 MB/sec)
Feb 19 21:08:34 fw kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Feb 19 21:08:34 fw kernel: device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
Feb 19 21:08:34 fw kernel: NET: Registered protocol family 2
Feb 19 21:08:34 fw kernel: IP: routing cache hash table of 2048 buckets, 16Kbytes
Feb 19 21:08:34 fw kernel: TCP: Hash tables configured (established 8192 bind 16384)
Feb 19 21:08:34 fw kernel: NET: Registered protocol family 1
Feb 19 21:08:34 fw kernel: NET: Registered protocol family 17
Feb 19 21:08:34 fw kernel: md: Autodetecting RAID arrays.
Feb 19 21:08:34 fw kernel: md: autorun ...
Feb 19 21:08:34 fw kernel: md: ... autorun DONE.
Feb 19 21:08:34 fw kernel: kjournald starting.  Commit interval 5 seconds
Feb 19 21:08:34 fw kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 19 21:08:34 fw kernel: VFS: Mounted root (ext3 filesystem) readonly.
Feb 19 21:08:34 fw kernel: Freeing unused kernel memory: 132k freed
Feb 19 21:08:34 fw kernel: drivers/usb/core/usb.c: registered new driver hub
Feb 19 21:08:34 fw kernel: EXT3 FS on hda3, internal journal
Feb 19 21:08:34 fw kernel: Adding 522104k swap on /dev/hda2.  Priority:-1 extents:1
Feb 19 21:08:34 fw kernel: kjournald starting.  Commit interval 5 seconds
Feb 19 21:08:34 fw kernel: EXT3 FS on hda1, internal journal
Feb 19 21:08:34 fw kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 19 21:08:34 fw kernel: blk: queue c1313400, I/O limit 4095Mb (mask 0xffffffff)
Feb 19 21:08:34 fw kernel: via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
Feb 19 21:08:34 fw kernel:   http://www.scyld.com/network/via-rhine.html
Feb 19 21:08:34 fw kernel: eth0: VIA VT6102 Rhine-II at 0xec00, 00:50:8d:4f:f5:f7, IRQ 23.
Feb 19 21:08:34 fw kernel: eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Feb 19 21:08:35 fw kernel: eth0: Setting full-duplex based on MII #1 link partner capability of 45e1.
Feb 19 21:08:35 fw kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Feb 19 21:08:35 fw xinetd[576]: xinetd Version 2.3.7 started with libwrap options compiled in.
Feb 19 21:08:35 fw xinetd[576]: Started working: 0 available services
Feb 19 21:08:35 fw xinetd: xinetd startup succeeded
Feb 19 21:08:36 fw crond: crond startup succeeded
Feb 19 21:08:37 fw smb: smbd startup succeeded
Feb 19 21:08:37 fw smb: nmbd startup succeeded
Feb 19 21:08:38 fw anacron: anacron startup succeeded
Feb 19 21:08:38 fw atd: atd startup succeeded
Feb 19 21:08:38 fw rc: Starting mdmonitor:  succeeded
Feb 19 21:08:38 fw kernel: warning: process `update' used the obsolete bdflush system call
Feb 19 21:08:38 fw kernel: Fix your initscripts?
Feb 19 21:08:43 fw kernel: warning: process `update' used the obsolete bdflush system call
Feb 19 21:08:43 fw kernel: Fix your initscripts?
Feb 19 21:09:02 fw sshd(pam_unix)[646]: session opened for user basic by (uid=500)
Feb 19 21:09:17 fw su(pam_unix)[663]: session opened for user root by basic(uid=500)
Feb 19 21:09:20 fw kernel: SCSI subsystem initialized
Feb 19 21:09:35 fw kernel: ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 20
Feb 19 21:09:35 fw kernel: ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 20
Feb 19 21:09:36 fw kernel: ata1: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
Feb 19 21:09:36 fw kernel: ata1: dev 0 configured for UDMA/133
Feb 19 21:09:36 fw kernel: scsi0 : sata_via
Feb 19 21:09:36 fw kernel: ata2: dev 0 ATA, max UDMA7, 312581808 sectors (lba48)
Feb 19 21:09:36 fw kernel: ata2: dev 0 configured for UDMA/133
Feb 19 21:09:36 fw kernel: scsi1 : sata_via
Feb 19 21:09:36 fw kernel:   Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 1.00
Feb 19 21:09:36 fw kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Feb 19 21:09:36 fw kernel: SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
Feb 19 21:09:36 fw kernel: SCSI device sda: drive cache: write through
Feb 19 21:09:36 fw kernel:  sda: sda1 sda2 sda3 sda4
Feb 19 21:09:36 fw kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Feb 19 21:09:36 fw kernel:   Vendor: ATA       Model: SAMSUNG SP1614C   Rev: 1.00
Feb 19 21:09:36 fw kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Feb 19 21:09:36 fw kernel: SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
Feb 19 21:09:36 fw kernel: SCSI device sdb: drive cache: write through
Feb 19 21:09:36 fw kernel:  sdb: sdb1 sdb2
Feb 19 21:09:36 fw kernel: Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Feb 19 21:09:59 fw kernel: XFS mounting filesystem sda1
Feb 19 21:11:17 fw kernel: ata1: DMA timeout, stat 0x0
Feb 19 21:11:17 fw kernel: ATA: abnormal status 0xD0 on port 0xC007

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.3-mm1 (root@fw.grimsta) (gcc version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #16 Thu Feb 19 21:05:22 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fef0000 (usable)
 BIOS-e820: 000000000fef0000 - 000000000fef3000 (ACPI NVS)
 BIOS-e820: 000000000fef3000 - 000000000ff00000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
254MB LOWMEM available.
found SMP MP-table at 000f5e70
zapping low mappings.
On node 0 totalpages: 65264
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61168 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 KT600                                     ) @ 0x000f7860
ACPI: RSDT (v001 KT600  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fef3000
ACPI: FADT (v001 KT600  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fef3040
ACPI: MADT (v001 KT600  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fef7a00
ACPI: DSDT (v001 KT600  AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:3 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
I/O APIC #2 Version 17 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Initializing CPU#0
Kernel command line: ro root=/dev/hda3
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 819.689 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 254680k/261056k available (2038k kernel code, 5640k reserved, 722k data, 132k init, 0k highmem)
Calibrating delay loop... 1609.72 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-12, 2-16, 2-17, 2-18, 2-21, 2-22 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 16.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00178003
.......     : max redirection entries: 0017
.......     : PRQ implemented: 1
.......     : IO APIC version: 0003
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 001 01  0    0    0   0   0    1    1    79
 0e 001 01  0    0    0   0   0    1    1    81
 0f 001 01  0    0    0   0   0    1    1    89
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 001 01  1    1    0   1   0    1    1    91
 14 001 01  1    1    0   1   0    1    1    99
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 001 01  1    1    0   1   0    1    1    A1
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ23 -> 0:23
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 819.0133 MHz.
..... host bus clock speed is 204.0783 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfaf40, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3227] at 0000:00:11.0
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I15,P1) -> 20
PCI->APIC IRQ transform: (B0,I15,P0) -> 20
PCI->APIC IRQ transform: (B0,I18,P0) -> 23
Machine check exception polling timer started.
SGI XFS with ACLs, no debug enabled
Real Time Clock Driver v1.12
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:DMA
hda: FUJITSU MHM2060AT, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: MATSHITA CD-RW CW-7586, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 11733120 sectors (6007 MB) w/2048KiB Cache, CHS=12416/15/63, UDMA(66)
 hda: hda1 hda2 hda3
hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1100.000 MB/sec
   8regs_prefetch:  1036.000 MB/sec
   32regs    :   856.000 MB/sec
   32regs_prefetch:   824.000 MB/sec
   pII_mmx   :  2184.000 MB/sec
   p5_mmx    :  2924.000 MB/sec
raid5: using function: p5_mmx (2924.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
device-mapper: 4.0.0-ioctl (2003-06-04) initialised: dm@uk.sistina.com
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 8192 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 132k freed
drivers/usb/core/usb.c: registered new driver hub
EXT3 FS on hda3, internal journal
Adding 522104k swap on /dev/hda2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
blk: queue c1313400, I/O limit 4095Mb (mask 0xffffffff)

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci-vv

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189 (rev 80)
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [80] AGP version 3.5
		Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 VGA compatible controller: S3 Inc. 86c968 [Vision 968 VRAM] rev 0 (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=64M]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149 (rev 80)
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin B routed to IRQ 20
	Region 0: I/O ports at c000 [size=8]
	Region 1: I/O ports at c400 [size=4]
	Region 2: I/O ports at c800 [size=8]
	Region 3: I/O ports at cc00 [size=4]
	Region 4: I/O ports at d000 [size=16]
	Region 5: I/O ports at d400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at d800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 78)
	Subsystem: ABIT Computer Corp.: Unknown device 1408
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 23
	Region 0: I/O ports at ec00 [size=256]
	Region 1: Memory at e0001000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=interrupts

           CPU0       
  0:     977495    IO-APIC-edge  timer
  1:          9    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
 14:       2337    IO-APIC-edge  ide0
 15:         17    IO-APIC-edge  ide1
 20:          2   IO-APIC-level  libata
 23:        952   IO-APIC-level  eth0
NMI:          0 
LOC:     977501 
ERR:          0
MIS:          0

--oyUTqETQ0mS9luUI--
