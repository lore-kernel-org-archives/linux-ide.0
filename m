From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 03/04] sata_mv: remove bogus nsect restriction
Date: Mon, 19 Jan 2009 18:06:28 -0500
Message-ID: <49750774.1070005@rtr.ca>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:43423 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbZASXG3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2009 18:06:29 -0500
In-Reply-To: <49750746.3010709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Remove unneeded nsect restriction from GenII NCQ path,
and improve comments to explain why this is not a problem.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-19 17:15:48.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-19 17:18:31.000000000 -0500
@@ -349,8 +349,6 @@
 
 	EDMA_HALTCOND_OFS	= 0x60,		/* GenIIe halt conditions */
 
-	GEN_II_NCQ_MAX_SECTORS	= 256,		/* max sects/io on Gen2 w/NCQ */
-
 	/* Host private flags (hp_flags) */
 	MV_HP_FLAG_MSI		= (1 << 0),
 	MV_HP_ERRATA_50XXB0	= (1 << 1),
@@ -1093,20 +1091,12 @@
 	 *
 	 * Gen-II does not support NCQ over a port multiplier
 	 *  (no FIS-based switching).
-	 *
-	 * We don't have hob_nsect when doing NCQ commands on Gen-II.
-	 * See mv_qc_prep() for more info.
 	 */
 	if (adev->flags & ATA_DFLAG_NCQ) {
 		if (sata_pmp_attached(adev->link->ap)) {
 			adev->flags &= ~ATA_DFLAG_NCQ;
 			ata_dev_printk(adev, KERN_INFO,
 				"NCQ disabled for command-based switching\n");
-		} else if (adev->max_sectors > GEN_II_NCQ_MAX_SECTORS) {
-			adev->max_sectors = GEN_II_NCQ_MAX_SECTORS;
-			ata_dev_printk(adev, KERN_INFO,
-				"max_sectors limited to %u for NCQ\n",
-				adev->max_sectors);
 		}
 	}
 }
@@ -1444,7 +1434,8 @@
 	 * only 11 bytes...so we must pick and choose required
 	 * registers based on the command.  So, we drop feature and
 	 * hob_feature for [RW] DMA commands, but they are needed for
-	 * NCQ.  NCQ will drop hob_nsect.
+	 * NCQ.  NCQ will drop hob_nsect, which is not needed there
+	 * (nsect is used only for the tag; feat/hob_feat hold true nsect).
 	 */
 	switch (tf->command) {
 	case ATA_CMD_READ:
