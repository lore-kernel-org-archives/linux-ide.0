From: Mark Lord <kernel@teksavvy.com>
Subject: Problem:  security locked disk and partition table read..
Date: Tue, 18 Jan 2011 23:52:01 -0500
Message-ID: <4D366DF1.3000303@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:54008 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752457Ab1ASEwE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jan 2011 23:52:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

I was sorting through drives here today, and found one that
was "security locked" (had a user passwd set on it),
and for which I did not know the password.

So I hotplugged it to my SiI-3132 card, with the intent
of simply erasing the drive (thereby clearing the passwd)
using hdparm.

Except.. the kernel (?) sat there for a very long time trying
(and failing) over and over and over and over and over and over
to read sector-0 (the partition table).  Of course the reads
each failed, and then got retried 5-times by SCSI, and then
retried again a zillion times at a higher level.

There's no hope of a read (or write) ever succeeding on a
security locked drive.  So why do we even bother allowing them?

To fix the problem at hand, I patched libata-scsi.c to simply
fail any command other that ATA_12 or ATA_16 (passthru).
This resulted in 56 occurences of this in syslog
when the drive was subsequently powered on:

[   11.050986] ata_scsi_translate: blocking SCSI op 0x28 ATA op 0x60
[   11.050991] sd 2:0:0:0: [sdb]  Result: hostbyte=0x00 driverbyte=0x08
[   11.050994] sd 2:0:0:0: [sdb]  Sense Key : 0x5 [current]
[   11.050998] sd 2:0:0:0: [sdb]  ASC=0x21 ASCQ=0x0
[   11.051001] sd 2:0:0:0: [sdb] CDB: cdb[0]=0x28: 28 00 00 00 00 00 00 00 08 00
[   11.051008] end_request: I/O error, dev sdb, sector 0

Why so many attempts to read the partition table???

Anyway, here's the hack I used:

--- a/drivers/ata/libata-scsi.c	2010-12-09 20:39:24.401410310 -0500
+++ b/drivers/ata/libata-scsi.c	2011-01-18 20:04:06.017446657 -0500
@@ -1819,7 +1819,15 @@

 	if (xlat_func(qc))
 		goto early_finish;
-
+	/* don't flog a dead horse, err.. drive, if it is security-locked */
+	if (cmd->cmnd[0] != ATA_12 && cmd->cmnd[0] != ATA_16) {
+		if (dev->id[128] & (1<<2)) { /* locked? */
+			printk(KERN_INFO "%s: blocking SCSI op 0x%02x ATA op 0x%02x\n", __func__,
cmd->cmnd[0], qc->tf.command);
+			ata_scsi_set_sense(cmd, ILLEGAL_REQUEST, 0x21, 0x0);
+			goto early_finish;
+		}
+	}
+
 	if (ap->ops->qc_defer) {
 		if ((rc = ap->ops->qc_defer(qc)))
 			goto defer;

Ideally, that should get re-coded to block only READ/WRITE accesses,
and allow all other commands through, but it worked well enough for
the situation at hand.  After the quick failure of the 56 attempts
to read the partition table, I was then able to use hdparm to issue
the security-erase command to clear out the drive.

Suggestions?
Anyone want to gain fame and fortune (well, fame anyway) by implementing
this more properly?

Cheers
