From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2.6.22-rc7 2/3] libata: implement HORKAGE_SETXFER
Date: Thu, 5 Jul 2007 13:35:01 +0900
Message-ID: <20070705043501.GY29122@htj.dyndns.org>
References: <20070705043127.GX29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:15426 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbXGEEfG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jul 2007 00:35:06 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3472567wah
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 21:35:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20070705043127.GX29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Make CFA SETXFER failure handling into HORKAGE.  This will be used to
allow other cases to ignore SETXFER failure.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   15 ++++++++++-----
 include/linux/libata.h    |    1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -1898,7 +1898,7 @@ int ata_dev_configure(struct ata_device 
 	 * common ATA, ATAPI feature tests
 	 */
 
-	/* find max transfer mode; for printk only */
+	/* determine xfermask */
 	xfer_mask = ata_id_xfermask(id);
 
 	if (ata_msg_probe(ap))
@@ -1919,8 +1919,13 @@ int ata_dev_configure(struct ata_device 
 					       "supports DRM functions and may "
 					       "not be fully accessable.\n");
 			snprintf(revbuf, 7, "CFA");
-		}
-		else
+
+			/* Old CFA may refuse SETFEATURES_XFER, which
+			 * is just fine
+			 */
+			if (!(xfer_mask & ~ATA_MASK_PIO))
+				dev->horkage |= ATA_HORKAGE_SETXFER;
+		} else
 			snprintf(revbuf, 7, "ATA-%d",  ata_id_major_version(id));
 
 		dev->n_sectors = ata_id_n_sectors(id);
@@ -2775,8 +2780,8 @@ static int ata_dev_set_mode(struct ata_d
 		dev->flags |= ATA_DFLAG_PIO;
 
 	err_mask = ata_dev_set_xfermode(dev);
-	/* Old CFA may refuse this command, which is just fine */
-	if (dev->xfer_shift == ATA_SHIFT_PIO && ata_id_is_cfa(dev->id))
+
+	if (dev->horkage & ATA_HORKAGE_SETXFER)
         	err_mask &= ~AC_ERR_DEV;
 
 	if (err_mask) {
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -298,6 +298,7 @@ enum {
 	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
+	ATA_HORKAGE_SETXFER	= (1 << 4), /* SETFEATURES_XFER may fail */
 };
 
 enum hsm_task_states {
