From: Robert Edmonds <edmonds42@bellsouth.net>
Subject: sata_svw: intermittent crashes with BCM5785 (HT1000) controller
Date: Mon, 17 Apr 2006 19:30:21 -0400
Message-ID: <20060417233021.GA32370@edmonds.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliverator7.gatech.edu ([130.207.165.169]:19602 "EHLO
	deliverator7.gatech.edu") by vger.kernel.org with ESMTP
	id S1751386AbWDQXap (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Apr 2006 19:30:45 -0400
Received: from hormel2.gatech.edu (hormel2.prism.gatech.edu [130.207.171.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "hormel2.prism.gatech.edu", Issuer "Georgia Tech Internal CA" (not verified))
	by deliverator7.gatech.edu (Postfix) with ESMTP id 0BA3E223B
	for <linux-ide@vger.kernel.org>; Mon, 17 Apr 2006 19:30:45 -0400 (EDT)
	(envelope-from edmonds42@bellsouth.net)
Received: from deliverator2.gatech.edu (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 59081A49F
	for <linux-ide@vger.kernel.org>; Mon, 17 Apr 2006 19:30:23 -0400 (EDT)
	(envelope-from edmonds42@bellsouth.net)
Received: from mailprx2.gatech.edu (mailprx2.prism.gatech.edu [130.207.171.21])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.mail.gatech.edu", Issuer "RSA Data Security? Inc." (verified OK))
	by deliverator2.gatech.edu (Postfix) with ESMTP id 412AEA49C
	for <linux-ide@vger.kernel.org>; Mon, 17 Apr 2006 19:30:23 -0400 (EDT)
	(envelope-from edmonds42@bellsouth.net)
Received: from localhost (r54h98.res.gatech.edu [128.61.54.98])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	(sasl: method=PLAIN, username=gtg698r@mailprx2.gatech.edu, sender=n/a)
	by mailprx2.gatech.edu (Postfix) with ESMTP id 03E342352
	for <linux-ide@vger.kernel.org>; Mon, 17 Apr 2006 19:30:23 -0400 (EDT)
	(envelope-from edmonds42@bellsouth.net)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, I've experienced some intermittent crashes with the sata_svw driver
in kernel 2.6.16.1 (Debian kernel revision 2.6.16-4).  Four Maxtor
6V300F0 SATA drives are attached to the onboard controller on a
Supermicro H8DSP-8 motherboard, and these drives have passed a few dozen
badblocks scans flawlessly (four badblocks processes running
simultaneously, one on each drive).

There are a few md software raid devices set up and the problem usually
manifests itself by kicking devices from the md arrays.

The machine will usually crash (well, the kernel doesn't go down, but
I'm unable to login remotely) when there's little or no load on the box,
and here's what I'll see in my logs:

Apr 14 17:16:34 pcap kernel: ata4: status=0xd0 { Busy }
Apr 14 17:16:34 pcap kernel: ATA: abnormal status 0xD0 on port 0xFFFFC2000003431C
Apr 14 17:16:34 pcap last message repeated 3 times
Apr 14 17:16:44 pcap kernel: ata4: status=0xd0 { Busy }
Apr 14 17:16:44 pcap kernel: ATA: abnormal status 0xD0 on port 0xFFFFC2000003431C
Apr 14 17:16:44 pcap last message repeated 2 times
Apr 14 17:16:54 pcap kernel: ata4: status=0xd0 { Busy }
Apr 14 17:16:54 pcap kernel: ATA: abnormal status 0xD0 on port 0xFFFFC2000003431C
Apr 14 17:16:54 pcap last message repeated 2 times
Apr 14 17:17:04 pcap kernel: ata4: status=0xd0 { Busy }
Apr 14 17:17:24 pcap kernel: PGD 7f7c3067 PUD 7f35b067 PMD 0 
Apr 14 17:17:24 pcap kernel: CPU 0 
Apr 14 17:17:24 pcap kernel: Modules linked in: ipv6 button ac battery iptable_filter ip_tables x_tables cpufreq_userspace powernow_k8 freq_table evdev psmouse serio_raw pcspkr shpchp pci_hotplug ext3 jbd mbcache raid5 xor raid1 md_mod ide_generic ide_cd cdrom sd_mod sata_svw libata scsi_mod e1000 tg3 ehci_hcd ohci_hcd serverworks generic ide_core thermal processor fan
Apr 14 17:17:24 pcap kernel: Pid: 1239, comm: ata/0 Not tainted 2.6.16-1-amd64-k8-smp #1
Apr 14 17:17:24 pcap kernel: RIP: 0010:[_end+130480710/2132488192] <ffffffff880bca46>{:libata:ata_pio_poll+186}
Apr 14 17:17:24 pcap kernel: RSP: 0018:ffff81007de71e18  EFLAGS: 00010287
Apr 14 17:17:24 pcap kernel: RAX: 0000000112dfe101 RBX: ffff81007e373480 RCX: ffffffff80347988
Apr 14 17:17:24 pcap kernel: RDX: ffffffff80347988 RSI: 0000000000000246 RDI: ffff81007e373480
Apr 14 17:17:24 pcap kernel: RBP: 0000000000000000 R08: ffffffff80347988 R09: 0000000000000009
Apr 14 17:17:24 pcap kernel: R10: 0000000100000000 R11: 0000000000000246 R12: 0000000000000004
Apr 14 17:17:24 pcap kernel: R13: 0000000000000002 R14: ffff81007e373480 R15: ffffffff880bd1f1
Apr 14 17:17:24 pcap kernel: FS:  00002b1da7f34640(0000) GS:ffffffff8040a000(0000) knlGS:0000000000000000
Apr 14 17:17:24 pcap kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
Apr 14 17:17:24 pcap kernel: CR2: 00000000000000d0 CR3: 000000007f08b000 CR4: 00000000000006e0
Apr 14 17:17:24 pcap kernel: Process ata/0 (pid: 1239, threadinfo ffff81007de70000, task ffff81007ffc47a0)
Apr 14 17:17:24 pcap kernel: Stack: ffff81007e373480 ffff81007e373480 0000000000000000 ffff81007e0bedc0 
Apr 14 17:17:24 pcap kernel:        0000000000000206 ffffffff880bd238 ffff81007e0bedd8 ffff81007e373b30 
Apr 14 17:17:24 pcap kernel:        ffff81007e373b38 ffffffff8013afe6 
Apr 14 17:17:24 pcap kernel: Call Trace: <ffffffff880bd238>{:libata:ata_pio_task+71}
Apr 14 17:17:24 pcap kernel:        <ffffffff8013afe6>{run_workqueue+155} <ffffffff8013b037>{worker_thread+0}
Apr 14 17:17:24 pcap kernel:        <ffffffff8013e167>{keventd_create_kthread+0} <ffffffff8013b13f>{worker_thread+264}
Apr 14 17:17:24 pcap kernel:        <ffffffff80125ea6>{default_wake_function+0} <ffffffff8013e167>{keventd_create_kthread+0}
Apr 14 17:17:24 pcap kernel:        <ffffffff80125ea6>{default_wake_function+0} <ffffffff8013e167>{keventd_create_kthread+0}
Apr 14 17:17:24 pcap kernel:        <ffffffff8013e13e>{kthread+129} <ffffffff8010b742>{child_rip+8}
Apr 14 17:17:24 pcap kernel:        <ffffffff8013e167>{keventd_create_kthread+0} <ffffffff8013e0bd>{kthread+0}
Apr 14 17:17:24 pcap kernel:        <ffffffff8010b73a>{child_rip+0}
Apr 14 17:17:24 pcap kernel: 
Apr 14 17:17:24 pcap kernel: Code: 83 8d d0 00 00 00 04 c7 83 10 07 00 00 03 00 00 00 eb 15 b8 
Apr 14 17:36:22 pcap -- MARK --
Apr 14 17:46:24 pcap kernel:  <4>ATA: abnormal status 0xD0 on port 0xFFFFC2000003431C
Apr 14 17:46:24 pcap kernel: ATA: abnormal status 0xD0 on port 0xFFFFC2000003431C
Apr 14 17:46:24 pcap last message repeated 2 times
Apr 14 17:46:34 pcap kernel: ata4: status=0xd0 { Busy }
Apr 14 17:46:34 pcap kernel: ATA: abnormal status 0xD0 on port 0xFFFFC2000003431C
Apr 14 17:46:34 pcap last message repeated 3 times
Apr 14 17:46:44 pcap kernel: ata4: status=0xd0 { Busy }
Apr 14 17:46:44 pcap kernel: ATA: abnormal status 0xD0 on port 0xFFFFC2000003431C
Apr 14 17:46:44 pcap last message repeated 2 times
Apr 14 17:46:54 pcap kernel: ata4: status=0xd0 { Busy }
Apr 14 17:46:54 pcap kernel: ATA: abnormal status 0xD0 on port 0xFFFFC2000003431C
Apr 14 17:46:54 pcap last message repeated 2 times
Apr 14 17:47:04 pcap kernel: ata4: status=0xd0 { Busy }
Apr 14 17:47:24 pcap kernel: PGD 7ec0e067 PUD 7e973067 PMD 0 
Apr 14 17:47:24 pcap kernel: CPU 1 
Apr 14 17:47:24 pcap kernel: Modules linked in: ipv6 button ac battery iptable_filter ip_tables x_tables cpufreq_userspace powernow_k8 freq_table evdev psmouse serio_raw pcspkr shpchp pci_hotplug ext3 jbd mbcache raid5 xor raid1 md_mod ide_generic ide_cd cdrom sd_mod sata_svw libata scsi_mod e1000 tg3 ehci_hcd ohci_hcd serverworks generic ide_core thermal processor fan
Apr 14 17:47:24 pcap kernel: Pid: 1240, comm: ata/1 Not tainted 2.6.16-1-amd64-k8-smp #1
Apr 14 17:47:24 pcap kernel: RIP: 0010:[_end+130480710/2132488192] <ffffffff880bca46>{:libata:ata_pio_poll+186}
Apr 14 17:47:24 pcap kernel: RSP: 0018:ffff81007de73e18  EFLAGS: 00010293
Apr 14 17:47:24 pcap kernel: RAX: 0000000112fb596c RBX: ffff81007e373480 RCX: ffffffff80347988
Apr 14 17:47:24 pcap kernel: RDX: ffffffff80347988 RSI: 0000000000000246 RDI: ffff81007e373480
Apr 14 17:47:24 pcap kernel: RBP: 0000000000000000 R08: ffffffff80347988 R09: 0000000000000009
Apr 14 17:47:24 pcap kernel: R10: 0000000100000000 R11: 0000000000000246 R12: 0000000000000004
Apr 14 17:47:24 pcap kernel: R13: 0000000000000002 R14: ffff81007e373480 R15: ffffffff880bd1f1
Apr 14 17:47:24 pcap kernel: FS:  00002afa939f9640(0000) GS:ffff81007fa42ac0(0000) knlGS:0000000000000000
Apr 14 17:47:24 pcap kernel: CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
Apr 14 17:47:24 pcap kernel: CR2: 00000000000000d0 CR3: 000000007f99e000 CR4: 00000000000006e0
Apr 14 17:47:24 pcap kernel: Process ata/1 (pid: 1240, threadinfo ffff81007de72000, task ffff81007f2f5180)
Apr 14 17:47:24 pcap kernel: Stack: ffff81007e373480 ffff81007e373480 0000000000000000 ffff81007e0be5c0 
Apr 14 17:47:24 pcap kernel:        0000000000000206 ffffffff880bd238 ffff81007e0be5d8 ffff81007e373b30 
Apr 14 17:47:24 pcap kernel:        ffff81007e373b38 ffffffff8013afe6 
Apr 14 17:47:24 pcap kernel: Call Trace: <ffffffff880bd238>{:libata:ata_pio_task+71}
Apr 14 17:47:24 pcap kernel:        <ffffffff8013afe6>{run_workqueue+155} <ffffffff8013b037>{worker_thread+0}
Apr 14 17:47:24 pcap kernel:        <ffffffff8013e167>{keventd_create_kthread+0} <ffffffff8013b13f>{worker_thread+264}
Apr 14 17:47:24 pcap kernel:        <ffffffff80125ea6>{default_wake_function+0} <ffffffff8013e167>{keventd_create_kthread+0}
Apr 14 17:47:24 pcap kernel:        <ffffffff80125ea6>{default_wake_function+0} <ffffffff8013e167>{keventd_create_kthread+0}
Apr 14 17:47:24 pcap kernel:        <ffffffff8013e13e>{kthread+129} <ffffffff8010b742>{child_rip+8}
Apr 14 17:47:24 pcap kernel:        <ffffffff8013e167>{keventd_create_kthread+0} <ffffffff8013e0bd>{kthread+0}
Apr 14 17:47:24 pcap kernel:        <ffffffff8010b73a>{child_rip+0}
Apr 14 17:47:24 pcap kernel: 
Apr 14 17:47:24 pcap kernel: Code: 83 8d d0 00 00 00 04 c7 83 10 07 00 00 03 00 00 00 eb 15 b8 
Apr 14 18:16:22 pcap -- MARK --
Apr 14 18:16:33 pcap kernel:  <3>ata1: command 0xb0 timeout, stat 0x58 host_stat 0x0
Apr 14 18:18:03 pcap kernel: ATA: abnormal status 0x58 on port 0xFFFFC2000003401C
Apr 14 18:18:03 pcap last message repeated 3 times
Apr 14 18:18:03 pcap kernel: ata1: status=0xd8 { Busy }
Apr 14 18:18:03 pcap kernel: ATA: abnormal status 0xD8 on port 0xFFFFC2000003401C
Apr 14 18:18:03 pcap last message repeated 2 times
Apr 14 18:18:03 pcap kernel: ata1: status=0xd8 { Busy }
Apr 14 18:18:03 pcap kernel: sd 0:0:0:0: SCSI error: return code = 0x8000002
Apr 14 18:18:03 pcap kernel: sda: Current: sense key: Aborted Command
Apr 14 18:18:03 pcap kernel:     Additional sense: Scsi parity error
Apr 14 18:18:03 pcap kernel: end_request: I/O error, dev sda, sector 16000575
Apr 14 18:18:03 pcap kernel: ATA: abnormal status 0xD8 on port 0xFFFFC2000003401C
Apr 14 18:18:03 pcap last message repeated 2 times
Apr 14 18:18:03 pcap kernel: ata1: status=0xd8 { Busy }
Apr 14 18:18:03 pcap kernel: ^IOperation continuing on 1 devices
Apr 14 18:18:03 pcap kernel: ATA: abnormal status 0xD8 on port 0xFFFFC2000003401C
Apr 14 18:18:03 pcap last message repeated 3 times
Apr 14 18:18:03 pcap kernel: RAID1 conf printout:
Apr 14 18:18:03 pcap kernel:  --- wd:1 rd:2
Apr 14 18:18:03 pcap kernel:  disk 0, wo:1, o:0, dev:sda1
Apr 14 18:18:03 pcap kernel:  disk 1, wo:0, o:1, dev:sdb1
Apr 14 18:18:03 pcap kernel: RAID1 conf printout:
Apr 14 18:18:03 pcap kernel:  --- wd:1 rd:2
Apr 14 18:18:03 pcap kernel:  disk 1, wo:0, o:1, dev:sdb1
Apr 14 18:18:13 pcap kernel: ata1: status=0xd8 { Busy }
Apr 14 18:18:13 pcap kernel: ATA: abnormal status 0xD8 on port 0xFFFFC2000003401C
Apr 14 18:18:13 pcap last message repeated 2 times
Apr 14 18:18:23 pcap kernel: ata1: status=0xd8 { Busy }


    Here are the relevant boot messages:


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks HT1000: IDE controller at PCI slot 0000:00:02.1
SvrWks HT1000: chipset revision 0
SvrWks HT1000: not 100%% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:DMA
Copyright (c) 1999-2005 Intel Corporation.
SCSI subsystem initialized
hdb: MATSHITADVD-ROM SR-8178, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

ata1: SATA max UDMA/133 cmd 0xFFFFC20000034000 ctl 0xFFFFC20000034020 bmdma 0xFFFFC20000034030 irq 11
ata2: SATA max UDMA/133 cmd 0xFFFFC20000034100 ctl 0xFFFFC20000034120 bmdma 0xFFFFC20000034130 irq 11
ata3: SATA max UDMA/133 cmd 0xFFFFC20000034200 ctl 0xFFFFC20000034220 bmdma 0xFFFFC20000034230 irq 11
ata4: SATA max UDMA/133 cmd 0xFFFFC20000034300 ctl 0xFFFFC20000034320 bmdma 0xFFFFC20000034330 irq 11
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_svw
ata2: SATA link up 1.5 Gbps (SStatus 113)
ata2: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_svw
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_svw
ata4: SATA link up 1.5 Gbps (SStatus 113)
ata4: dev 0 ATA-7, max UDMA/133, 586114704 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_svw
  Vendor: ATA       Model: Maxtor 6V300F0    Rev: VA11
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6V300F0    Rev: VA11
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6V300F0    Rev: VA11
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6V300F0    Rev: VA11
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
 sda:<6>hdb: ATAPI 24X DVD-ROM drive, 256kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
 sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
SCSI device sdc: 586114704 512-byte hdwr sectors (300091 MB)
sdc: Write Protect is off
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 586114704 512-byte hdwr sectors (300091 MB)
sdd: Write Protect is off
SCSI device sdd: drive cache: write back
SCSI device sdd: 586114704 512-byte hdwr sectors (300091 MB)
sdd: Write Protect is off
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2
sd 3:0:0:0: Attached scsi disk sdd
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
md: raid1 personality registered for level 1
raid5: automatically using best checksumming function: generic_sse
   generic_sse:  6084.000 MB/sec
raid5: using function: generic_sse (6084.000 MB/sec)
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
md: md0 stopped.
md: bind<sdb1>
md: bind<sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: md1 stopped.
md: bind<sdb2>
md: bind<sdc2>
md: bind<sdd2>
md: bind<sda2>
raid5: device sda2 operational as raid disk 0
raid5: device sdd2 operational as raid disk 3
raid5: device sdc2 operational as raid disk 2
raid5: device sdb2 operational as raid disk 1
raid5: allocated 4262kB for md1
raid5: raid level 5 set md1 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, o:1, dev:sda2
 disk 1, o:1, dev:sdb2
 disk 2, o:1, dev:sdc2
 disk 3, o:1, dev:sdd2
md: md2 stopped.
md: bind<sdd1>
md: bind<sdc1>
raid1: raid set md2 active with 2 out of 2 mirrors


    Here is the output of lspci -n:


0000:00:01.0 0604: 1166:0036
0000:00:02.0 0600: 1166:0205
0000:00:02.1 0101: 1166:0214
0000:00:02.2 0601: 1166:0234
0000:00:03.0 0c03: 1166:0223 (rev 01)
0000:00:03.1 0c03: 1166:0223 (rev 01)
0000:00:03.2 0c03: 1166:0223 (rev 01)
0000:00:05.0 0300: 1002:4752 (rev 27)
0000:00:08.0 0604: 1166:0130 (rev a3)
0000:00:09.0 0604: 1166:0130 (rev a3)
0000:00:0a.0 0604: 1166:0132 (rev a3)
0000:00:0b.0 0604: 1166:0132 (rev a3)
0000:00:0c.0 0604: 1166:0132 (rev a3)
0000:00:0d.0 0604: 1166:0132 (rev a3)
0000:00:18.0 0600: 1022:1100
0000:00:18.1 0600: 1022:1101
0000:00:18.2 0600: 1022:1102
0000:00:18.3 0600: 1022:1103
0000:00:19.0 0600: 1022:1100
0000:00:19.1 0600: 1022:1101
0000:00:19.2 0600: 1022:1102
0000:00:19.3 0600: 1022:1103
0000:01:0d.0 0604: 1166:0104 (rev b2)
0000:01:0e.0 0104: 1166:024a
0000:02:06.0 0200: 8086:1079 (rev 03)
0000:02:06.1 0200: 8086:1079 (rev 03)
0000:04:04.0 0200: 14e4:166a (rev 03)
0000:04:04.1 0200: 14e4:166a (rev 03)


    Here is the output of lspci -vvv for the controller:


0000:01:0e.0 RAID bus controller: Broadcom BCM5785 (HT1000) SATA Native SATA Mode
        Subsystem: Broadcom BCM5785 (HT1000) SATA Native SATA Mode
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at bc00 [size=8]
        Region 1: I/O ports at b880 [size=4]
        Region 2: I/O ports at b800 [size=8]
        Region 3: I/O ports at b480 [size=4]
        Region 4: I/O ports at b400 [size=32]
        Region 5: Memory at fc9fe000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at fc9c0000 [disabled] [size=128K]
        Capabilities: [60] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=4
                Status: Bus=1 Dev=14 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=0, DMOST=4, DMCRS=2, RSCEM-
        Capabilities: [90] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a0] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
                Address: 00000000  Data: 0000

-- 
Robert Edmonds
