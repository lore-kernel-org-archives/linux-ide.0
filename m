From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] libata: move BMDMA host status recording from EH to interrupt handler
Date: Fri, 17 Nov 2006 12:06:21 +0900
Message-ID: <20061117030621.GD2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:64555 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1424752AbWKQDGa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Nov 2006 22:06:30 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1202739nfa
        for <linux-ide@vger.kernel.org>; Thu, 16 Nov 2006 19:06:29 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

For certain errors, interrupt handler alter BMDMA host status before
entering EH (clears active and intr).  Thus altered BMDMA host status
value is recorded by BMDMA EH and reported to user.  Move BMDMA host
status recording from EH to interrupt handler.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |    6 ++++++
 drivers/ata/libata-sff.c  |    3 ---
 drivers/ata/sata_sil.c    |    5 +++++
 3 files changed, 11 insertions(+), 3 deletions(-)

Index: work/drivers/ata/sata_sil.c
===================================================================
--- work.orig/drivers/ata/sata_sil.c
+++ work/drivers/ata/sata_sil.c
@@ -356,6 +356,7 @@ static void sil_scr_write (struct ata_po
 
 static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 {
+	struct ata_eh_info *ehi = &ap->eh_info;
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	u8 status;
 
@@ -428,6 +429,10 @@ static void sil_host_intr(struct ata_por
 	/* kick HSM in the ass */
 	ata_hsm_move(ap, qc, status, 0);
 
+	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
+				       qc->tf.protocol == ATA_PROT_ATAPI_DMA))
+		ata_ehi_push_desc(ehi, "BMDMA2 stat 0x%x", bmdma2);
+
 	return;
 
  err_hsm:
Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -4862,6 +4862,7 @@ unsigned int ata_qc_issue_prot(struct at
 inline unsigned int ata_host_intr (struct ata_port *ap,
 				   struct ata_queued_cmd *qc)
 {
+	struct ata_eh_info *ehi = &ap->eh_info;
 	u8 status, host_stat = 0;
 
 	VPRINTK("ata%u: protocol %d task_state %d\n",
@@ -4922,6 +4923,11 @@ inline unsigned int ata_host_intr (struc
 	ap->ops->irq_clear(ap);
 
 	ata_hsm_move(ap, qc, status, 0);
+
+	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
+				       qc->tf.protocol == ATA_PROT_ATAPI_DMA))
+		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
+
 	return 1;	/* irq handled */
 
 idle_irq:
Index: work/drivers/ata/libata-sff.c
===================================================================
--- work.orig/drivers/ata/libata-sff.c
+++ work/drivers/ata/libata-sff.c
@@ -743,7 +743,6 @@ void ata_bmdma_drive_eh(struct ata_port 
 			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			ata_postreset_fn_t postreset)
 {
-	struct ata_eh_context *ehc = &ap->eh_context;
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
 	int thaw = 0;
@@ -763,8 +762,6 @@ void ata_bmdma_drive_eh(struct ata_port 
 
 		host_stat = ap->ops->bmdma_status(ap);
 
-		ata_ehi_push_desc(&ehc->i, "BMDMA stat 0x%x", host_stat);
-
 		/* BMDMA controllers indicate host bus error by
 		 * setting DMA_ERR bit and timing out.  As it wasn't
 		 * really a timeout event, adjust error mask and
