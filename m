From: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] re-fix sata_sil quirk (w/ description)
Date: Tue, 22 Jun 2004 20:49:19 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40D8D38F.8010308@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010504040902000205040905"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28592 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265117AbUFWAtd
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jun 2004 20:49:33 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Ricky Beam <jfbeam@bluetronic.net>

This is a multi-part message in MIME format.
--------------010504040902000205040905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


The patch itself is unchanged, but I have checked it in with a detailed 
technical description, including my rationale.

Bart, I'm not going to bother with a 'better fix'.  Since this only 
affects 3112 controllers, I will be adding code to make sure that the 
mod15write quirk does not activate for the other controllers (3512, 3114).

See the changeset description accompanying the patch for more info.

Pushing to Andrew and Linus right now...





--------------010504040902000205040905
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

#   2004/06/22 20:42:16-04:00 jgarzik@pobox.com 
#   [libata sata_sil] Re-fix mod15write bug
#   
#   Certain early SATA drives have problems with write requests whose
#   length satisfy the equation "sectors % 15 == 1", on the SiI 3112.
#   Other drives, and other SiI controllers, are not affected.
#   
#   The fix for this problem is to avoid such requests, in one of three
#   ways, for the affect drive+controller combos:
#   1) Limit all writes to 15 sectors
#   2) Use block layer features to avoid creating requests whose
#      length satisfies the above equation.
#   3) When a request satisfies the above equation, split the request
#      into two writes, neither of which satisfies the equation.
#   
#   I chose fix #1, the most simple to implement.  After discussion with
#   Silicon Image and others regarding the impact of this fix, I have
#   decided to remain with fix #1, and will not be implementing a
#   "better fix".  This means that the affected SATA drives will see
#   decreased performance, but set of affected drives is small and will
#   never grow larger.
#   
#   Further, the complexity of implementing solution #2 or
#   solution #3 is rather large.
#   
#   When implementing lba48 'large request' support, I unintentionally
#   broke the fix for these affected drives.  Kudos to Ricky Beam for
#   noticing this.
#   
#   This change restores the fix, by adding a flag ATA_DFLAG_LOCK_SECTORS
#   to indicate that the max_sectors value set by the low-level driver
#   should never be changed.
# 
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-06-22 20:44:51 -04:00
+++ b/drivers/scsi/libata-scsi.c	2004-06-22 20:44:51 -04:00
@@ -182,7 +182,8 @@
 		 * 65534 when Jens Axboe's patch for dynamically
 		 * determining max_sectors is merged.
 		 */
-		if (dev->flags & ATA_DFLAG_LBA48) {
+		if ((dev->flags & ATA_DFLAG_LBA48) &&
+		    ((dev->flags & ATA_DFLAG_LOCK_SECTORS) == 0)) {
 			sdev->host->max_sectors = 2048;
 			blk_queue_max_sectors(sdev->request_queue, 2048);
 		}
diff -Nru a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c	2004-06-22 20:44:51 -04:00
+++ b/drivers/scsi/sata_sil.c	2004-06-22 20:44:51 -04:00
@@ -302,6 +302,7 @@
 		       ap->id, dev->devno);
 		ap->host->max_sectors = 15;
 		ap->host->hostt->max_sectors = 15;
+		dev->flags |= ATA_DFLAG_LOCK_SECTORS;
 		return;
 	}
 
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2004-06-22 20:44:51 -04:00
+++ b/include/linux/libata.h	2004-06-22 20:44:51 -04:00
@@ -91,6 +91,7 @@
 	ATA_DFLAG_MASTER	= (1 << 2), /* is device 0? */
 	ATA_DFLAG_WCACHE	= (1 << 3), /* has write cache we can
 					     * (hopefully) flush? */
+	ATA_DFLAG_LOCK_SECTORS	= (1 << 4), /* don't adjust max_sectors */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */

--------------010504040902000205040905--
