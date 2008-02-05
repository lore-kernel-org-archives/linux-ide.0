From: Tejun Heo <htejun@gmail.com>
Subject: libata: kill now unused n_iter and fix sata_fsl
Date: Tue, 05 Feb 2008 14:06:27 +0900
Message-ID: <47A7EED3.2050801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:47667 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbYBEFGg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2008 00:06:36 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1622134rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 21:06:34 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Li Yang <leoli@freescale.com>

From: James Bottomley <James.Bottomley@HansenPartnership.com>

qc->n_iter was used for libata's own sg walking before sg chaining
replaced it.  During conversion, the field and its usage in sata_fsl
were left behind.  Kill the filed and update sata_fsl.

tj: This was part of James's libata-use-block-layer-padding patch.
    Separated out by me.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |    4 ++--
 include/linux/libata.h |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

Index: work/drivers/ata/sata_fsl.c
===================================================================
--- work.orig/drivers/ata/sata_fsl.c
+++ work/drivers/ata/sata_fsl.c
@@ -355,8 +355,8 @@ static unsigned int sata_fsl_fill_sg(str
 			ata_port_printk(qc->ap, KERN_ERR,
 					"s/g len unaligned : 0x%x\n", sg_len);
 
-		if ((num_prde == (SATA_FSL_MAX_PRD_DIRECT - 1)) &&
-		    (qc->n_iter + 1 != qc->n_elem)) {
+		if (num_prde == (SATA_FSL_MAX_PRD_DIRECT - 1) &&
+		    sg_next(sg) != NULL) {
 			VPRINTK("setting indirect prde\n");
 			prd_ptr_to_indirect_ext = prd;
 			prd->dba = cpu_to_le32(indirect_ext_segment_paddr);
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -457,7 +457,6 @@ struct ata_queued_cmd {
 	unsigned long		flags;		/* ATA_QCFLAG_xxx */
 	unsigned int		tag;
 	unsigned int		n_elem;
-	unsigned int		n_iter;
 	unsigned int		mapped_n_elem;
 
 	int			dma_dir;
@@ -1367,7 +1366,6 @@ static inline void ata_qc_reinit(struct 
 	qc->nbytes = qc->raw_nbytes = qc->curbytes = 0;
 	qc->n_elem = 0;
 	qc->mapped_n_elem = 0;
-	qc->n_iter = 0;
 	qc->err_mask = 0;
 	qc->pad_len = 0;
 	qc->last_sg = NULL;
