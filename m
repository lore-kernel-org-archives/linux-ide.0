From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 02/04] sata_mv fis irq register fixes
Date: Wed, 14 May 2008 09:19:30 -0400
Message-ID: <482AE6E2.4080900@rtr.ca>
References: <482AE694.5080604@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1687 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756857AbYENNTb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 09:19:31 -0400
In-Reply-To: <482AE694.5080604@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Fix handling of the FIS_IRQ_CAUSE register in sata_mv.

This register exists *only* on GenIIe devices, so don't bother
writing to it on older chips.  Also, it has to be read/cleared
in mv_err_intr() before clearing the main ERR_IRQ_CAUSE register.

This keeps sata_mv from getting stuck forever on certain error types.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

For 2.6.26.

--- old/drivers/ata/sata_mv.c	2008-05-14 08:48:19.000000000 -0400
+++ linux/drivers/ata/sata_mv.c	2008-05-14 08:51:49.000000000 -0400
@@ -886,7 +886,8 @@
 		mv_edma_cfg(ap, want_ncq);
 
 		/* clear FIS IRQ Cause */
-		writelfl(0, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
+		if (IS_GEN_IIE(hpriv))
+			writelfl(0, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
 
 		mv_set_edma_ptrs(port_mmio, hpriv, pp);
 
@@ -1812,6 +1813,7 @@
 {
 	void __iomem *port_mmio = mv_ap_base(ap);
 	u32 edma_err_cause, eh_freeze_mask, serr = 0;
+	u32 fis_cause = 0;
 	struct mv_port_priv *pp = ap->private_data;
 	struct mv_host_priv *hpriv = ap->host->private_data;
 	unsigned int action = 0, err_mask = 0;
@@ -1821,16 +1823,19 @@
 
 	/*
 	 * Read and clear the SError and err_cause bits.
+	 * For GenIIe, if EDMA_ERR_TRANS_IRQ_7 is set, we also must read/clear
+	 * the FIS_IRQ_CAUSE register before clearing edma_err_cause.
 	 */
 	sata_scr_read(&ap->link, SCR_ERROR, &serr);
 	sata_scr_write_flush(&ap->link, SCR_ERROR, serr);
 
 	edma_err_cause = readl(port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
+	if (IS_GEN_IIE(hpriv) && (edma_err_cause & EDMA_ERR_TRANS_IRQ_7)) {
+		fis_cause = readl(port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
+		writelfl(~fis_cause, port_mmio + SATA_FIS_IRQ_CAUSE_OFS);
+	}
 	writelfl(~edma_err_cause, port_mmio + EDMA_ERR_IRQ_CAUSE_OFS);
 
-	ata_port_printk(ap, KERN_INFO, "%s: err_cause=%08x pp_flags=0x%x\n",
-			__func__, edma_err_cause, pp->pp_flags);
-
 	if (edma_err_cause & EDMA_ERR_DEV) {
 		/*
 		 * Device errors during FIS-based switching operation
@@ -1844,6 +1849,9 @@
 	ata_ehi_clear_desc(ehi);
 	ata_ehi_push_desc(ehi, "edma_err_cause=%08x pp_flags=%08x",
 			  edma_err_cause, pp->pp_flags);
+
+	if (IS_GEN_IIE(hpriv) && (edma_err_cause & EDMA_ERR_TRANS_IRQ_7))
+		ata_ehi_push_desc(ehi, "fis_cause=%08x", fis_cause);
 	/*
 	 * All generations share these EDMA error cause bits:
 	 */
