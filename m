From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Badness in sata_mv
Date: Wed, 21 Dec 2005 14:46:56 -0700
Message-ID: <E1EpBnU-0001F8-HZ@highlab.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ecae158-153-dhcp.colorado.edu ([128.138.158.153]:43468 "EHLO
	highlab.com") by vger.kernel.org with ESMTP id S1751164AbVLUVq3
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Dec 2005 16:46:29 -0500
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1EpBnU-0001F8-HZ
	for linux-ide@vger.kernel.org; Wed, 21 Dec 2005 14:46:56 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm getting an error message from sata_mv (2.6.15-rc5-mm3), but the
system keeps running.  Accessing the disks after this works fine and
things are nice and fast.

I'm also seeing some hard system hangs in certain situations, maybe
related?

Here's the relevant part of the kernel messages:

Linux version 2.6.15-rc5-mm3-dell-poweredge-700 (seb@snappy) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #1 SMP Wed Dec 21 12:01:20 MST 2005

sata_mv 0000:02:01.0: version 0.5
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 24 (level, low) -> IRQ 21
sata_mv 0000:02:01.0: 32 slots 8 ports RAID mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8EA2120 bmdma 0x0 irq 21
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xF8EA4120 bmdma 0x0 irq 21
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xF8EA6120 bmdma 0x0 irq 21
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xF8EA8120 bmdma 0x0 irq 21
ata5: SATA max UDMA/133 cmd 0x0 ctl 0xF8EB2120 bmdma 0x0 irq 21
ata6: SATA max UDMA/133 cmd 0x0 ctl 0xF8EB4120 bmdma 0x0 irq 21
ata7: SATA max UDMA/133 cmd 0x0 ctl 0xF8EB6120 bmdma 0x0 irq 21
ata8: SATA max UDMA/133 cmd 0x0 ctl 0xF8EB8120 bmdma 0x0 irq 21
Badness in __msleep at drivers/scsi/sata_mv.c:1723
 [<f8d736cc>] __mv_phy_reset+0x263/0x429 [sata_mv]
 [<f8d733b3>] mv_channel_reset+0x89/0xf7 [sata_mv]
 [<f8d73462>] mv_stop_and_reset+0x41/0x48 [sata_mv]
 [<f8d72ba2>] mv_host_intr+0x158/0x182 [sata_mv]
 [<f8d72c54>] mv_interrupt+0x88/0xfb [sata_mv]
 [<c013b7a8>] handle_IRQ_event+0x39/0x69
 [<c013b859>] __do_IRQ+0x81/0xe8
 [<c0105199>] do_IRQ+0x19/0x24
 [<c0103662>] common_interrupt+0x1a/0x20
 [<c010f704>] get_offset_pmtmr+0x17/0x73
 [<c0107404>] do_gettimeofday+0x19/0xc7
 [<c0122bb9>] getnstimeofday+0x14/0x37
 [<c01344ec>] ktime_get_real+0x15/0x37
 [<c0134a61>] hrtimer_run_queues+0x2f/0x116
 [<c012748a>] run_timer_softirq+0x22/0x1b0
 [<c013b7a8>] handle_IRQ_event+0x39/0x69
 [<c0122ea2>] __do_softirq+0x72/0xdd
 [<c0122f40>] do_softirq+0x33/0x35
 [<c010519e>] do_IRQ+0x1e/0x24
 [<c0103662>] common_interrupt+0x1a/0x20
 [<c014c334>] unlink_file_vma+0x17/0x3a
 [<c014fb29>] anon_vma_unlink+0x17/0x7a
 [<c0148ef7>] free_pgtables+0x92/0xa5
 [<c014e3e9>] exit_mmap+0xb9/0x11d
 [<c011b3c6>] mmput+0x34/0xef
 [<c0166889>] exec_mmap+0x106/0x271
 [<c013b7a8>] handle_IRQ_event+0x39/0x69
 [<c0166ae3>] flush_old_exec+0x7b/0x8f4
 [<c010519e>] do_IRQ+0x1e/0x24
 [<c0103662>] common_interrupt+0x1a/0x20
 [<c01860f4>] load_elf_binary+0x246/0xda2
 [<c013b882>] __do_IRQ+0xaa/0xe8
 [<c010519e>] do_IRQ+0x1e/0x24
 [<c0103662>] common_interrupt+0x1a/0x20
 [<c0147e3e>] kunmap_high+0x18/0x91
 [<c01662f3>] copy_strings+0x198/0x22f
 [<c01675d1>] search_binary_handler+0x7b/0x20c
 [<c01678ed>] do_execve+0x18b/0x225
 [<c01019b9>] sys_execve+0x3d/0x87
 [<c0102c95>] syscall_call+0x7/0xb
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_mv
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata2: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_mv
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata3: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata3: dev 0 configured for UDMA/133
scsi2 : sata_mv
ata4: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata4: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
ata4: dev 0 configured for UDMA/133
scsi3 : sata_mv
ata5: no device found (phy stat 00000000)
scsi4 : sata_mv
ata6: no device found (phy stat 00000000)
scsi5 : sata_mv
ata7: no device found (phy stat 00000000)
scsi6 : sata_mv
ata8: no device found (phy stat 00000000)
scsi7 : sata_mv
  Vendor: ATA       Model: ST3500641AS       Rev: 2.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3500641AS       Rev: 2.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3500641AS       Rev: 2.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3500641AS       Rev: 2.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 1:0:0:0: Attached scsi disk sdb
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sdc: drive cache: write back
 sdc: unknown partition table
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 976773168 512-byte hdwr sectors (500108 MB)
SCSI device sdd: drive cache: write back
 sdd: unknown partition table
sd 3:0:0:0: Attached scsi disk sdd


-- 
Sebastian Kuzminsky
