From: Brett Russ <russb@emc.com>
Subject: [PATCH] bug fix to restore access to low order LBA
Date: Thu, 22 Jul 2004 19:30:12 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41004E04.6050407@emc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070307000100030109030901"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailhub.emc.com ([168.159.2.31]:58439 "EHLO mailhub.lss.emc.com")
	by vger.kernel.org with ESMTP id S267300AbUGVXdX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jul 2004 19:33:23 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: B.Zolnierkiewicz@elka.pw.edu.pl

This is a multi-part message in MIME format.
--------------070307000100030109030901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I discovered this after running a custom kernel with support for ATA 
read verify command, when I encountered sector errors and saw them 
reported in syslog and on an ATA analyzer but when I tried to read the 
LBA registers I got zero... problem was this one liner, which applies to 
2.6.8-rc2 as well as 2.6.7, and I've also included a 2.4.26 version.

Thanks,
BR

--------------070307000100030109030901
Content-Type: text/plain;
 name="2.4.26-ide-restore-low.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.26-ide-restore-low.diff"

--- linux-2.4.26/drivers/ide/ide.c	2004-02-18 08:36:31.000000000 -0500
+++ linux-2.4.26-ide-restore-low/drivers/ide/ide.c	2004-07-22 19:17:23.000000000 -0400
@@ -409,6 +409,9 @@
 					u32 low = read_24(drive);
 					hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
 					high = read_24(drive);
+					/* Restore access to low order LBA */
+					OUT_BYTE(drive->ctl&0x7F,
+						 IDE_CONTROL_REG);
 
 					sectors = ((u64)high << 24) | low;
 					printk(", LBAsect=%llu, high=%d, low=%d",

--------------070307000100030109030901
Content-Type: text/plain;
 name="2.6.7-ide-restore-low.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.7-ide-restore-low.diff"

--- linux-2.6.7/drivers/ide/ide.c	2004-06-16 01:19:03.000000000 -0400
+++ linux-2.6.7-ide-restore-low/drivers/ide/ide.c	2004-07-22 19:20:59.000000000 -0400
@@ -409,6 +409,9 @@
 					u32 low = ide_read_24(drive);
 					hwif->OUTB(drive->ctl|0x80, IDE_CONTROL_REG);
 					high = ide_read_24(drive);
+					/* Restore access to low order LBA */
+					hwif->OUTB(drive->ctl&0x7F, 
+						   IDE_CONTROL_REG);
 
 					sectors = ((u64)high << 24) | low;
 					printk(", LBAsect=%llu, high=%d, low=%d",

--------------070307000100030109030901--
