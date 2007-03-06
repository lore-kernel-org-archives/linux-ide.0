From: Aalderd Bouwman <aalderd.boac@wanadoo.nl>
Subject: Hotswap problem on vt8251 with ahci driver
Date: Tue, 06 Mar 2007 13:57:19 +0100
Message-ID: <1173185839.3778.14.camel@anja>
Reply-To: aalderd.boac@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-1.orange.nl ([193.252.22.241]:60309 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030502AbXCFNTO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 08:19:14 -0500
Received: from smtp-1.orange.nl (mwinf6001 [172.22.155.23])
	by mwinf6005.orange.nl (SMTP Server) with ESMTP id D5E61580034C
	for <linux-ide@vger.kernel.org>; Tue,  6 Mar 2007 13:55:57 +0100 (CET)
Received: from [192.168.2.10] (s5593cc1b.adsl.wanadoo.nl [85.147.204.27])
	by mwinf6001.orange.nl (SMTP Server) with ESMTP id ADFCE1C00089
	for <linux-ide@vger.kernel.org>; Tue,  6 Mar 2007 13:55:35 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

Running kernel 2.6.20.1
Controller vt8251
Harddisks: 
sda Seagate Barracuda ES (ST3400620NS) SATA2
hdc Seagate ST3160021A IDE
hdd ATAPI-CD ROM-DRIVE-56MAX

That configuration runs correctly.

Now I turns a Seagate Barracuda 7200.9 (ST3808110AS) on:

Dmesg: 

Mar  6 13:17:55 server ata3: exception Emask 0x10 SAct 0x0 SErr
0x4060000 action 0x2 frozen
Mar  6 13:17:55 server ata3: (irq_stat 0x00000040, connection status
changed)
Mar  6 13:17:55 server ata3: waiting for device to spin up (8 secs)
Mar  6 13:18:03 server ata3: hard resetting port
Mar  6 13:18:03 server ata3: SATA link up 1.5 Gbps (SStatus 113 SControl
300)
Mar  6 13:18:03 server ata3.00: ATA-7, max UDMA/133, 156301488 sectors:
LBA48 NCQ (depth 0/32)
Mar  6 13:18:03 server ata3.00: configured for UDMA/133
Mar  6 13:18:03 server ata3: EH complete
Mar  6 13:18:03 server scsi 2:0:0:0: Direct-Access     ATA
ST3808110AS      3.AA PQ: 0 ANSI: 5
Mar  6 13:18:03 server SCSI device sdb: 156301488 512-byte hdwr sectors
(80026 MB)
Mar  6 13:18:03 server sdb: Write Protect is off
Mar  6 13:18:03 server sdb: Mode Sense: 00 3a 00 00
Mar  6 13:18:03 server SCSI device sdb: write cache: enabled, read
cache: enabled, doesn't support DPO or FUA
Mar  6 13:18:03 server SCSI device sdb: 156301488 512-byte hdwr sectors
(80026 MB)
Mar  6 13:18:03 server sdb: Write Protect is off
Mar  6 13:18:03 server sdb: Mode Sense: 00 3a 00 00
Mar  6 13:18:03 server SCSI device sdb: write cache: enabled, read
cache: enabled, doesn't support DPO or FUA
Mar  6 13:18:04 server sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 sdb7 >
Mar  6 13:18:04 server sd 2:0:0:0: Attached scsi disk sdb
Mar  6 13:18:04 server sd 2:0:0:0: Attached scsi generic sg1 type 0
Mar  6 13:18:29 server ata3: exception Emask 0x10 SAct 0x0 SErr 0x30000
action 0x2 frozen
Mar  6 13:18:29 server ata3: (irq_stat 0x04400000, PHY RDY changed)
Mar  6 13:18:30 server hdc: dma_timer_expiry: dma status == 0x61
Mar  6 13:18:31 server ata3: hard resetting port
Mar  6 13:18:31 server ata3: SATA link down (SStatus 0 SControl 300)
Mar  6 13:18:31 server ata3: failed to recover some devices, retrying in
5 secs
Mar  6 13:18:37 server ata3: hard resetting port
Mar  6 13:18:38 server ata3: SATA link down (SStatus 0 SControl 300)
Mar  6 13:18:38 server ata3: failed to recover some devices, retrying in
5 secs
Mar  6 13:18:40 server hdc: DMA timeout error
Mar  6 13:18:40 server hdc: dma timeout error: status=0x58 { DriveReady
SeekComplete DataRequest }
Mar  6 13:18:40 server ide: failed opcode was: unknown
Mar  6 13:18:40 server hdc: status error: status=0x50 { DriveReady
SeekComplete }
Mar  6 13:18:40 server ide: failed opcode was: unknown
Mar  6 13:18:40 server hdc: no DRQ after issuing MULTWRITE_EXT
Mar  6 13:18:40 server hdc: status timeout: status=0xd0 { Busy }
Mar  6 13:18:40 server ide: failed opcode was: unknown
Mar  6 13:18:40 server hdd: DMA disabled
Mar  6 13:18:40 server hdc: no DRQ after issuing MULTWRITE_EXT
Mar  6 13:18:41 server ide1: reset: success
Mar  6 13:18:43 server ata3: hard resetting port
Mar  6 13:18:44 server ata3: SATA link down (SStatus 0 SControl 300)
Mar  6 13:18:44 server ata3.00: disabled
Mar  6 13:18:44 server ata3: EH complete
Mar  6 13:18:44 server ata3.00: detaching (SCSI 2:0:0:0)
Mar  6 13:18:44 server Synchronizing SCSI cache for disk sdb:
Mar  6 13:18:44 server FAILED
Mar  6 13:18:44 server status = 0, message = 00, host = 4, driver = 00
Mar  6 13:18:47 server login(pam_unix)[6667]: session opened for user
root by (uid=0)
Mar  6 13:18:47 server login[6789]: ROOT LOGIN  on 'tty2'
Mar  6 13:18:52 server shutdown[6792]: shutting down for system reboot
Mar  6 13:19:01 server <4>hdc: dma_timer_expiry: dma status == 0x21
Mar  6 13:19:11 server hdc: DMA timeout error
Mar  6 13:19:11 server hdc: dma timeout error: status=0x58 { DriveReady
SeekComplete DataRequest }
Mar  6 13:19:11 server ide: failed opcode was: unknown
Mar  6 13:19:11 server hdc: status error: status=0x50 { DriveReady
SeekComplete }
Mar  6 13:19:11 server ide: failed opcode was: unknown
Mar  6 13:19:11 server hdc: no DRQ after issuing MULTWRITE_EXT
Mar  6 13:19:11 server hdc: status timeout: status=0xd0 { Busy }
Mar  6 13:19:11 server ide: failed opcode was: unknown
Mar  6 13:19:11 server hdc: no DRQ after issuing MULTWRITE_EXT
Mar  6 13:19:11 server ide1: reset: success
Mar  6 13:19:31 server hdc: dma_timer_expiry: dma status == 0x21
Mar  6 13:19:41 server hdc: DMA timeout error
Mar  6 13:19:41 server hdc: dma timeout error: status=0x58 { DriveReady
SeekComplete DataRequest }
Mar  6 13:19:41 server ide: failed opcode was: unknown
Mar  6 13:19:41 server hdc: status error: status=0x50 { DriveReady
SeekComplete }
Mar  6 13:19:41 server ide: failed opcode was: unknown
Mar  6 13:19:41 server hdc: no DRQ after issuing MULTWRITE_EXT
Mar  6 13:19:41 server hdc: status timeout: status=0xd0 { Busy }
Mar  6 13:19:41 server ide: failed opcode was: unknown
Mar  6 13:19:41 server hdc: no DRQ after issuing MULTWRITE_EXT
Mar  6 13:19:41 server ide1: reset: success
<snip deamon log>
Mar  6 13:20:01 server hdc: dma_timer_expiry: dma status == 0x21
<snip deamon log>
Mar  6 13:20:12 server hdc: DMA timeout error
Mar  6 13:20:12 server hdc: dma timeout error: status=0x58 { DriveReady
SeekComplete DataRequest }
Mar  6 13:20:12 server ide: failed opcode was: unknown
Mar  6 13:20:12 server hdc: status error: status=0x50 { DriveReady
SeekComplete }
Mar  6 13:20:12 server ide: failed opcode was: unknown
Mar  6 13:20:12 server hdc: no DRQ after issuing MULTWRITE_EXT
Mar  6 13:20:12 server hdc: status timeout: status=0xd0 { Busy }
Mar  6 13:20:12 server ide: failed opcode was: unknown
Mar  6 13:20:12 server ide: failed opcode was: unknown
Mar  6 13:20:12 server hdc: no DRQ after issuing MULTWRITE_EXT
Mar  6 13:20:12 server ide1: reset: success

As you see, when I turned on the Barracuda 7200.9 drive the ide channel
will not work correctly. This also happens when I turned on the
Barracuda ES drive.

It doesn't sense setting the jumper on the drive on 1,5 Gb/s operation.

This happens not with the Maxtor drive and a Barracuda 7200.10 drive I
have.

Aalderd.

