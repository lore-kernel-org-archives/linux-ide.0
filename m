From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream 1/2] libata: kill dead code paths in reset path
Date: Tue, 08 Apr 2008 01:25:35 +0900
Message-ID: <47FA4AFF.2010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.187]:38352 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbYDGQZo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Apr 2008 12:25:44 -0400
Received: by rn-out-0910.google.com with SMTP id e24so1582743rng.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Apr 2008 09:25:42 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Some code paths which had been made obsolete by recent reset
simplification were still around.  Kill them.

* ata_eh_reset() checked for ATA_DEV_UNKNOWN to determine
  classification failure.  This is no longer applicable.

* ata_do_reset() should convert ATA_DEV_UNKNOWN to ATA_DEV_NONE
  regardless of reset result (e.g. -EAGAIN).

* LLDs don't need to convert ATA_DEV_UNKNOWN to ATA_DEV_NONE.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c     |   19 +------------------
 drivers/ata/sata_inic162x.c |    2 --
 drivers/ata/sata_sil24.c    |    3 ---
 3 files changed, 1 insertion(+), 23 deletions(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -2052,15 +2052,13 @@ static int ata_do_reset(struct ata_link 
 		classes[dev->devno] = ATA_DEV_UNKNOWN;
 
 	rc = reset(link, classes, deadline);
-	if (rc)
-		return rc;
 
 	/* convert all ATA_DEV_UNKNOWN to ATA_DEV_NONE */
 	ata_link_for_each_dev(dev, link)
 		if (classes[dev->devno] == ATA_DEV_UNKNOWN)
 			classes[dev->devno] = ATA_DEV_NONE;
 
-	return 0;
+	return rc;
 }
 
 static int ata_eh_followup_srst_needed(struct ata_link *link,
@@ -2209,21 +2207,6 @@ int ata_eh_reset(struct ata_link *link, 
 	if (rc && rc != -EAGAIN)
 		goto fail;
 
-	/* was classification successful? */
-	if (classify && classes[0] == ATA_DEV_UNKNOWN &&
-	    !(lflags & ATA_LFLAG_ASSUME_CLASS)) {
-		if (try < max_tries) {
-			ata_link_printk(link, KERN_WARNING,
-					"classification failed\n");
-			rc = -EINVAL;
-			goto fail;
-		}
-
-		ata_link_printk(link, KERN_WARNING,
-				"classfication failed, assuming ATA\n");
-		lflags |= ATA_LFLAG_ASSUME_ATA;
-	}
-
  done:
 	ata_link_for_each_dev(dev, link) {
 		/* After the reset, the device state is PIO 0 and the
Index: work/drivers/ata/sata_inic162x.c
===================================================================
--- work.orig/drivers/ata/sata_inic162x.c
+++ work/drivers/ata/sata_inic162x.c
@@ -428,8 +428,6 @@ static int inic_hardreset(struct ata_lin
 
 		ata_sff_tf_read(ap, &tf);
 		*class = ata_dev_classify(&tf);
-		if (*class == ATA_DEV_UNKNOWN)
-			*class = ATA_DEV_NONE;
 	}
 
 	return 0;
Index: work/drivers/ata/sata_sil24.c
===================================================================
--- work.orig/drivers/ata/sata_sil24.c
+++ work/drivers/ata/sata_sil24.c
@@ -693,9 +693,6 @@ static int sil24_softreset(struct ata_li
 	sil24_read_tf(ap, 0, &tf);
 	*class = ata_dev_classify(&tf);
 
-	if (*class == ATA_DEV_UNKNOWN)
-		*class = ATA_DEV_NONE;
-
  out:
 	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
