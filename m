From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes 2/2] libata-sff: handle controllers w/o ctl
 register
Date: Thu, 06 Mar 2008 13:12:54 +0900
Message-ID: <47CF6F46.9020908@gmail.com>
References: <47CF6E7E.6090201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.189]:3644 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbYCFENE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 23:13:04 -0500
Received: by rn-out-0910.google.com with SMTP id v46so703981rnb.15
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 20:13:03 -0800 (PST)
In-Reply-To: <47CF6E7E.6090201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>

SFF incorrectly assumed that ctl register is available for all
controllers while some old SFF controllers don't have ctl register.
Make SFF handle controllers w/o ctl register by conditionalizing ctl
register access and softreset method.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/ata/libata-sff.c |   36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

Index: work/drivers/ata/libata-sff.c
===================================================================
--- work.orig/drivers/ata/libata-sff.c
+++ work/drivers/ata/libata-sff.c
@@ -56,7 +56,8 @@ u8 ata_irq_on(struct ata_port *ap)
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
-	iowrite8(ap->ctl, ioaddr->ctl_addr);
+	if (ioaddr->ctl_addr)
+		iowrite8(ap->ctl, ioaddr->ctl_addr);
 	tmp = ata_wait_idle(ap);
 
 	ap->ops->irq_clear(ap);
@@ -81,12 +82,14 @@ void ata_tf_load(struct ata_port *ap, co
 	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
 
 	if (tf->ctl != ap->last_ctl) {
-		iowrite8(tf->ctl, ioaddr->ctl_addr);
+		if (ioaddr->ctl_addr)
+			iowrite8(tf->ctl, ioaddr->ctl_addr);
 		ap->last_ctl = tf->ctl;
 		ata_wait_idle(ap);
 	}
 
 	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+		WARN_ON(!ioaddr->ctl_addr);
 		iowrite8(tf->hob_feature, ioaddr->feature_addr);
 		iowrite8(tf->hob_nsect, ioaddr->nsect_addr);
 		iowrite8(tf->hob_lbal, ioaddr->lbal_addr);
@@ -167,14 +170,17 @@ void ata_tf_read(struct ata_port *ap, st
 	tf->device = ioread8(ioaddr->device_addr);
 
 	if (tf->flags & ATA_TFLAG_LBA48) {
-		iowrite8(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
-		tf->hob_feature = ioread8(ioaddr->error_addr);
-		tf->hob_nsect = ioread8(ioaddr->nsect_addr);
-		tf->hob_lbal = ioread8(ioaddr->lbal_addr);
-		tf->hob_lbam = ioread8(ioaddr->lbam_addr);
-		tf->hob_lbah = ioread8(ioaddr->lbah_addr);
-		iowrite8(tf->ctl, ioaddr->ctl_addr);
-		ap->last_ctl = tf->ctl;
+		if (likely(ioaddr->ctl_addr)) {
+			iowrite8(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
+			tf->hob_feature = ioread8(ioaddr->error_addr);
+			tf->hob_nsect = ioread8(ioaddr->nsect_addr);
+			tf->hob_lbal = ioread8(ioaddr->lbal_addr);
+			tf->hob_lbam = ioread8(ioaddr->lbam_addr);
+			tf->hob_lbah = ioread8(ioaddr->lbah_addr);
+			iowrite8(tf->ctl, ioaddr->ctl_addr);
+			ap->last_ctl = tf->ctl;
+		} else
+			WARN_ON(1);
 	}
 }
 
@@ -352,7 +358,8 @@ void ata_bmdma_freeze(struct ata_port *a
 	ap->ctl |= ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
-	iowrite8(ap->ctl, ioaddr->ctl_addr);
+	if (ioaddr->ctl_addr)
+		iowrite8(ap->ctl, ioaddr->ctl_addr);
 
 	/* Under certain circumstances, some controllers raise IRQ on
 	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
@@ -459,13 +466,14 @@ void ata_bmdma_drive_eh(struct ata_port 
  */
 void ata_bmdma_error_handler(struct ata_port *ap)
 {
-	ata_reset_fn_t hardreset;
+	ata_reset_fn_t softreset = NULL, hardreset = NULL;
 
-	hardreset = NULL;
+	if (ap->ioaddr.ctl_addr)
+		softreset = ata_std_softreset;
 	if (sata_scr_valid(&ap->link))
 		hardreset = sata_std_hardreset;
 
-	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, hardreset,
+	ata_bmdma_drive_eh(ap, ata_std_prereset, softreset, hardreset,
 			   ata_std_postreset);
 }
 
