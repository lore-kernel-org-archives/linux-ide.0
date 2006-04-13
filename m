From: Elmar Weber <lists@elmarweber.org>
Subject: sata_sil: I/O error accessing drive with Sil3114 chipset
Date: Thu, 13 Apr 2006 02:56:36 +0200
Message-ID: <443DA1C4.3060201@elmarweber.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wp060.webpack.hosteurope.de ([80.237.132.67]:40426 "EHLO
	wp060.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S932391AbWDMA5I (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Apr 2006 20:57:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello,

I've a problem with the sata_sil module.

Heres some technical data:
- Motherboard K8N4-E deluxe, booting with pci=nommconf
- Sil 3314 SATA Chipset
- 160 GB Samsung SP1614N harddisks
- Kernel 2.6.16.2

Here the scenario when the problem occurs:
I execute badblocks on the secondary hdd (2nd channel) and it says there 
are defect blocks. It does not happen on the 1st channel, in fact it 
only happens to the hdd connected to the last channel (had the same 
problem with 4 320 GB Maxtor drives connected to the controller and 
there were errors in the syslog for the drive at the last channel).

The hdd itself is OK, I can run badblocks without errors if I connect it 
to another computer or the NVidia serial ata controller on the board.

Here is the output in the syslog, which repeats itself multiple times 
with different sectors:

--
01:59:16 server ata2: no sense translation for status: 0x51
01:59:16 server ata2: translated ATA stat/err 0x51/00 to SCSI 
SK/ASC/ASCQ 0x3/11/04
01:59:16 server ata2: status=0x51 { DriveReady SeekComplete Error }
01:59:17 server ata2: no sense translation for status: 0x51
01:59:17 server ata2: translated ATA stat/err 0x51/00 to SCSI 
SK/ASC/ASCQ 0x3/11/04
01:59:17 server ata2: status=0x51 { DriveReady SeekComplete Error }
01:59:19 server ata2: no sense translation for status: 0x51
01:59:19 server ata2: translated ATA stat/err 0x51/00 to SCSI 
SK/ASC/ASCQ 0x3/11/04
01:59:19 server ata2: status=0x51 { DriveReady SeekComplete Error }
01:59:49 server ata2: command 0x25 timeout, stat 0x51 host_stat 0x61
01:59:49 server ata2: no sense translation for status: 0x51
01:59:49 server ata2: translated ATA stat/err 0x51/00 to SCSI 
SK/ASC/ASCQ 0x3/11/04
01:59:49 server ata2: status=0x51 { DriveReady SeekComplete Error }
01:59:49 server sd 1:0:0:0: SCSI error: return code = 0x8000002
01:59:49 server sdb: Current: sense key=0x3
01:59:49 server ASC=0x11 ASCQ=0x4
01:59:49 server end_request: I/O error, dev sdb, sector 246131248
--

The problem is reproduceable with blocks between 123065600 - 123065630 
of 156290904 total.

Are there any new patches available for the sata_sil module (since 
kernel 2.6.16.2) I haven't found or anything I can try to work around 
this problem?

bye,
Elmar


