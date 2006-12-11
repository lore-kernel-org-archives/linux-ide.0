From: Mauro Ziliani <mauro.ziliani@tin.it>
Subject: Seagate ST3808110AS and Sil3114 RAID1 trouble.
Date: Mon, 11 Dec 2006 10:04:15 +0100
Message-ID: <457D1F0F.20204@tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 81-174-11-230.f5.ngi.it ([81.174.11.230]:41451 "EHLO
	mercurio.cosmo.lan" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762674AbWLKJE2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Dec 2006 04:04:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


Goodmorning.

My name's Mauro Ziliani from Parma ITALY.
I use two disk Seagate ST3808110AS with an Sil3114 SATA controller.
The first disk is sdb and the second is sdc.
I configured a RAID1 software mirror onto this two disk where sdb1 is 
the master disk for RAID.
I often receive the following warning message from the kernel during 
synchronization of md0 device

...
RAID1 conf printout:
Dec 11 00:47:00 mercurio kernel:  --- wd:1 rd:2
Dec 11 00:47:00 mercurio kernel:  disk 0, wo:1, o:1, dev:sdc1
Dec 11 00:47:00 mercurio kernel:  disk 1, wo:0, o:1, dev:sdb1
Dec 11 00:47:00 mercurio kernel: md: syncing RAID array md0
Dec 11 00:47:00 mercurio kernel: md: minimum _guaranteed_ reconstruction 
speed: 1000 KB/sec/disc.
Dec 11 00:47:00 mercurio kernel: md: using maximum available idle IO 
bandwidth (but not more than 200000 KB/sec) for reconstruction.
Dec 11 00:47:00 mercurio kernel: md: using 128k window, over a total of 
78148096 blocks.
Dec 11 00:47:27 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x0
Dec 11 00:47:27 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:47:27 mercurio kernel: ata1.00: tag 0 cmd 0x25 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:47:27 mercurio kernel: ata1: EH complete
Dec 11 00:47:27 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:47:28 mercurio kernel: sdb: Write Protect is off
Dec 11 00:47:28 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:47:28 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:47:49 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x0
Dec 11 00:47:49 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:47:49 mercurio kernel: ata1.00: tag 0 cmd 0x25 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:47:49 mercurio kernel: ata1: EH complete
Dec 11 00:47:49 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:47:49 mercurio kernel: sdb: Write Protect is off
Dec 11 00:47:49 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:47:49 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:48:13 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x0
Dec 11 00:48:13 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:48:13 mercurio kernel: ata1.00: tag 0 cmd 0x25 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:48:13 mercurio kernel: ata1: EH complete
Dec 11 00:48:13 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:48:13 mercurio kernel: sdb: Write Protect is off
Dec 11 00:48:13 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:48:13 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:49:00 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x0
Dec 11 00:49:00 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:49:00 mercurio kernel: ata1.00: tag 0 cmd 0x25 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:49:00 mercurio kernel: ata1: EH complete
Dec 11 00:49:00 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:49:00 mercurio kernel: sdb: Write Protect is off
Dec 11 00:49:01 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:49:01 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:49:23 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x0
Dec 11 00:49:23 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:49:23 mercurio kernel: ata1.00: tag 0 cmd 0x25 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:49:23 mercurio kernel: ata1: EH complete
Dec 11 00:49:23 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:49:23 mercurio kernel: sdb: Write Protect is off
Dec 11 00:49:23 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:49:23 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:52:01 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x0
Dec 11 00:52:01 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:52:01 mercurio kernel: ata1.00: tag 0 cmd 0x25 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:52:01 mercurio kernel: ata1: EH complete
Dec 11 00:52:01 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:52:01 mercurio kernel: sdb: Write Protect is off
Dec 11 00:52:01 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:52:01 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:52:12 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x0
Dec 11 00:52:12 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:52:12 mercurio kernel: ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:52:12 mercurio kernel: ata1: EH complete
Dec 11 00:52:12 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:52:12 mercurio kernel: sdb: Write Protect is off
Dec 11 00:52:12 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:52:12 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:52:17 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x0
Dec 11 00:52:17 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:52:17 mercurio kernel: ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:52:17 mercurio kernel: ata1: EH complete
Dec 11 00:52:17 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:52:17 mercurio kernel: sdb: Write Protect is off
Dec 11 00:52:17 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:52:17 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:52:24 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x0
Dec 11 00:52:24 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:52:24 mercurio kernel: ata1.00: tag 0 cmd 0x25 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:52:24 mercurio kernel: ata1: EH complete
Dec 11 00:52:24 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:52:24 mercurio kernel: sdb: Write Protect is off
Dec 11 00:52:24 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:52:24 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:52:25 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x0
Dec 11 00:52:25 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:52:25 mercurio kernel: ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:52:25 mercurio kernel: ata1: EH complete
Dec 11 00:52:25 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:52:25 mercurio kernel: sdb: Write Protect is off
Dec 11 00:52:25 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:52:25 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:52:55 mercurio kernel: ata1.00: limiting speed to UDMA/66
Dec 11 00:52:55 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x2
Dec 11 00:52:55 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:52:56 mercurio kernel: ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:52:56 mercurio kernel: ata1: soft resetting port
Dec 11 00:52:56 mercurio kernel: ata1: SATA link up 1.5 Gbps (SStatus 
113 SControl 310)
Dec 11 00:52:56 mercurio kernel: ata1.00: configured for UDMA/66
Dec 11 00:52:56 mercurio kernel: ata1: EH complete
Dec 11 00:52:56 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:52:56 mercurio kernel: sdb: Write Protect is off
Dec 11 00:52:56 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:52:56 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:53:48 mercurio kernel: ata1.00: limiting speed to UDMA/44
Dec 11 00:53:48 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x2
Dec 11 00:53:48 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:53:48 mercurio kernel: ata1.00: tag 0 cmd 0x25 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:53:49 mercurio kernel: ata1: soft resetting port
Dec 11 00:53:49 mercurio kernel: ata1: SATA link up 1.5 Gbps (SStatus 
113 SControl 310)
Dec 11 00:53:49 mercurio kernel: ata1.00: configured for UDMA/44
Dec 11 00:53:49 mercurio kernel: ata1: EH complete
Dec 11 00:53:49 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:53:49 mercurio kernel: sdb: Write Protect is off
Dec 11 00:53:49 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:53:49 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:54:05 mercurio kernel: ata1.00: limiting speed to UDMA/33
Dec 11 00:54:05 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x2
Dec 11 00:54:05 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:54:05 mercurio kernel: ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:54:05 mercurio kernel: ata1: soft resetting port
Dec 11 00:54:06 mercurio kernel: ata1: SATA link up 1.5 Gbps (SStatus 
113 SControl 310)
Dec 11 00:54:06 mercurio kernel: ata1.00: configured for UDMA/33
Dec 11 00:54:06 mercurio kernel: ata1: EH complete
Dec 11 00:54:06 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:54:06 mercurio kernel: sdb: Write Protect is off
Dec 11 00:54:06 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:54:06 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:54:13 mercurio kernel: ata1.00: limiting speed to UDMA/25
Dec 11 00:54:13 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x200000 action 0x2
Dec 11 00:54:13 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:54:13 mercurio kernel: ata1.00: tag 0 cmd 0xc8 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:54:13 mercurio kernel: ata1: soft resetting port
Dec 11 00:54:13 mercurio kernel: ata1: SATA link up 1.5 Gbps (SStatus 
113 SControl 310)
Dec 11 00:54:13 mercurio kernel: ata1.00: configured for UDMA/25
Dec 11 00:54:13 mercurio kernel: ata1: EH complete
Dec 11 00:54:13 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:54:14 mercurio kernel: sdb: Write Protect is off
Dec 11 00:54:14 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:54:14 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:54:14 mercurio kernel: ata1.00: limiting speed to UDMA/16
Dec 11 00:54:14 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x2
Dec 11 00:54:14 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:54:14 mercurio kernel: ata1.00: tag 0 cmd 0x25 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:54:15 mercurio kernel: ata1: soft resetting port
Dec 11 00:54:15 mercurio kernel: ata1: SATA link up 1.5 Gbps (SStatus 
113 SControl 310)
Dec 11 00:54:15 mercurio kernel: ata1.00: configured for UDMA/16
Dec 11 00:54:15 mercurio kernel: ata1: EH complete
Dec 11 00:54:15 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:54:15 mercurio kernel: sdb: Write Protect is off
Dec 11 00:54:15 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:54:15 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:54:34 mercurio kernel: ata1.00: limiting speed to PIO4
Dec 11 00:54:34 mercurio kernel: ata1.00: exception Emask 0x0 SAct 0x0 
SErr 0x280000 action 0x2
Dec 11 00:54:34 mercurio kernel: ata1.00: (BMDMA stat 0x60)
Dec 11 00:54:34 mercurio kernel: ata1.00: tag 0 cmd 0x25 Emask 0x1 stat 
0x51 err 0x4 (device error)
Dec 11 00:54:34 mercurio kernel: ata1: soft resetting port
Dec 11 00:54:34 mercurio kernel: ata1: SATA link up 1.5 Gbps (SStatus 
113 SControl 310)
Dec 11 00:54:34 mercurio kernel: ata1.00: configured for PIO4
Dec 11 00:54:35 mercurio kernel: ata1: EH complete
Dec 11 00:54:35 mercurio kernel: SCSI device sdb: 156301488 512-byte 
hdwr sectors (80026 MB)
Dec 11 00:54:35 mercurio kernel: sdb: Write Protect is off
Dec 11 00:54:36 mercurio kernel: sdb: Mode Sense: 00 3a 00 00
Dec 11 00:54:36 mercurio kernel: SCSI device sdb: drive cache: write back
Dec 11 00:59:03 mercurio kernel: raid1: Disk failure on sdc1, disabling 
device.
Dec 11 00:59:03 mercurio kernel: ^IOperation continuing on 1 devices
Dec 11 00:59:04 mercurio kernel: md: md0: sync done.
Dec 11 00:59:04 mercurio kernel: RAID1 conf printout:
Dec 11 00:59:04 mercurio kernel:  --- wd:1 rd:2
Dec 11 00:59:04 mercurio kernel:  disk 0, wo:1, o:0, dev:sdc1
Dec 11 00:59:04 mercurio kernel:  disk 1, wo:0, o:1, dev:sdb1
Dec 11 00:59:04 mercurio kernel: RAID1 conf printout:
Dec 11 00:59:04 mercurio kernel:  --- wd:1 rd:2
Dec 11 00:59:04 mercurio kernel:  disk 1, wo:0, o:1, dev:sdb1
....


Why this happens?

I control the disk with PowerMax 4.23 and the disk works fine.
All test are ok.

Is it better to make the RAID1 throught Sill3114 BIOS or throught 
software md?

Thanks a lot in advance.

Best regard
  Mauro Ziliani

