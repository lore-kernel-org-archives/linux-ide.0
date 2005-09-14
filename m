From: Amos Waterland <apw@us.ibm.com>
Subject: [PATCH] fix sata_svw.c warnings for eeh_writeb, eeh_writew, eeh_readw
Date: Wed, 14 Sep 2005 16:49:24 -0400
Message-ID: <20050914204924.GA31498@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.131]:41874 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932491AbVINUu5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Sep 2005 16:50:57 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j8EKorWP090152
	for <linux-ide@vger.kernel.org>; Wed, 14 Sep 2005 16:50:54 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j8EKo3QZ508464
	for <linux-ide@vger.kernel.org>; Wed, 14 Sep 2005 14:50:03 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j8EKnaOw013522
	for <linux-ide@vger.kernel.org>; Wed, 14 Sep 2005 14:49:36 -0600
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Right now drivers/scsi/sata_svw.c spews a lot of warnings like this:

 drivers/scsi/sata_svw.c: In function `k2_sata_tf_load':
 drivers/scsi/sata_svw.c:111: warning: passing arg 2 of `eeh_writeb'
                              makes pointer from integer without a cast

Looking at the definition for struct ata_ioports, the address fields are
defined seemingly quite deliberately as unsigned longs.  So here is a
patch that fixes the warnings by making the implicit cast explicit.

Signed-off-by: Amos Waterland <apw@us.ibm.com>

---

 drivers/scsi/sata_svw.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

7606cecd01f66383c5b85b1d7acdd597feb4b5a6
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -108,26 +108,26 @@ static void k2_sata_tf_load(struct ata_p
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
 
 	if (tf->ctl != ap->last_ctl) {
-		writeb(tf->ctl, ioaddr->ctl_addr);
+		writeb(tf->ctl, (void *)ioaddr->ctl_addr);
 		ap->last_ctl = tf->ctl;
 		ata_wait_idle(ap);
 	}
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
-		writew(tf->feature | (((u16)tf->hob_feature) << 8), ioaddr->feature_addr);
-		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), ioaddr->nsect_addr);
-		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), ioaddr->lbal_addr);
-		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), ioaddr->lbam_addr);
-		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), ioaddr->lbah_addr);
+		writew(tf->feature | (((u16)tf->hob_feature) << 8), (void *)ioaddr->feature_addr);
+		writew(tf->nsect | (((u16)tf->hob_nsect) << 8), (void *)ioaddr->nsect_addr);
+		writew(tf->lbal | (((u16)tf->hob_lbal) << 8), (void *)ioaddr->lbal_addr);
+		writew(tf->lbam | (((u16)tf->hob_lbam) << 8), (void *)ioaddr->lbam_addr);
+		writew(tf->lbah | (((u16)tf->hob_lbah) << 8), (void *)ioaddr->lbah_addr);
 	} else if (is_addr) {
-		writew(tf->feature, ioaddr->feature_addr);
-		writew(tf->nsect, ioaddr->nsect_addr);
-		writew(tf->lbal, ioaddr->lbal_addr);
-		writew(tf->lbam, ioaddr->lbam_addr);
-		writew(tf->lbah, ioaddr->lbah_addr);
+		writew(tf->feature, (void *)ioaddr->feature_addr);
+		writew(tf->nsect, (void *)ioaddr->nsect_addr);
+		writew(tf->lbal, (void *)ioaddr->lbal_addr);
+		writew(tf->lbam, (void *)ioaddr->lbam_addr);
+		writew(tf->lbah, (void *)ioaddr->lbah_addr);
 	}
 
 	if (tf->flags & ATA_TFLAG_DEVICE)
-		writeb(tf->device, ioaddr->device_addr);
+		writeb(tf->device, (void *)ioaddr->device_addr);
 
 	ata_wait_idle(ap);
 }
@@ -138,14 +138,14 @@ static void k2_sata_tf_read(struct ata_p
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 	u16 nsect, lbal, lbam, lbah;
 
-	nsect = tf->nsect = readw(ioaddr->nsect_addr);
-	lbal = tf->lbal = readw(ioaddr->lbal_addr);
-	lbam = tf->lbam = readw(ioaddr->lbam_addr);
-	lbah = tf->lbah = readw(ioaddr->lbah_addr);
-	tf->device = readw(ioaddr->device_addr);
+	nsect = tf->nsect = readw((void *)ioaddr->nsect_addr);
+	lbal = tf->lbal = readw((void *)ioaddr->lbal_addr);
+	lbam = tf->lbam = readw((void *)ioaddr->lbam_addr);
+	lbah = tf->lbah = readw((void *)ioaddr->lbah_addr);
+	tf->device = readw((void *)ioaddr->device_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		tf->hob_feature = readw(ioaddr->error_addr) >> 8;
+		tf->hob_feature = readw((void *)ioaddr->error_addr) >> 8;
 		tf->hob_nsect = nsect >> 8;
 		tf->hob_lbal = lbal >> 8;
 		tf->hob_lbam = lbam >> 8;
