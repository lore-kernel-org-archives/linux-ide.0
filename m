From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/13] sata_sil: convert to new probing mechanism and add hotplug support
Date: Fri, 12 May 2006 00:32:07 +0900
Message-ID: <11473615273465-git-send-email-htejun@gmail.com>
References: <11473615261297-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:38197 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030274AbWEKPcW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:32:22 -0400
Received: by py-out-1112.google.com with SMTP id f28so286417pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:32:19 -0700 (PDT)
In-Reply-To: <11473615261297-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert to new probing mechanism and add hotplug support by enabling
SATA IRQ for SError.N and scheduling EH if the interrupt occurs.
Standard EH will do the right thing and schedule probe after analyzing
SError.

---

 drivers/scsi/sata_sil.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

be041aa12b2f059e3d1f87b7d2932282e4c63f13
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 5f7867c..59c49d3 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -186,7 +186,6 @@ static const struct ata_port_operations 
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.probe_reset		= ata_std_probe_reset,
 	.post_set_mode		= sil_post_set_mode,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
@@ -343,7 +342,7 @@ static void sil_host_intr(struct ata_por
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	u8 status;
 
-	if (unlikely(!qc || qc->tf.ctl & ATA_NIEN))
+	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ || !qc || qc->tf.ctl & ATA_NIEN))
 		goto freeze;
 
 	/* Check whether we are expecting interrupt in this state */
@@ -416,7 +415,7 @@ static irqreturn_t sil_interrupt(int irq
 		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
 			continue;
 
-		if (!(bmdma2 & SIL_DMA_COMPLETE))
+		if (!(bmdma2 & (SIL_DMA_COMPLETE | SIL_DMA_SATA_IRQ)))
 			continue;
 
 		sil_host_intr(ap, bmdma2);
@@ -433,6 +432,9 @@ static void sil_freeze(struct ata_port *
 	void __iomem *mmio_base = ap->host_set->mmio_base;
 	u32 tmp;
 
+	/* global IRQ mask doesn't block SATA IRQ, turn off explicitly */
+	writel(0, mmio_base + sil_port[ap->port_no].sien);
+
 	/* plug IRQ */
 	tmp = readl(mmio_base + SIL_SYSCFG);
 	tmp |= SIL_MASK_IDE0_INT << ap->port_no;
@@ -449,6 +451,9 @@ static void sil_thaw(struct ata_port *ap
 	ata_chk_status(ap);
 	ap->ops->irq_clear(ap);
 
+	/* turn on SATA IRQ */
+	writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
+
 	/* turn on IRQ */
 	tmp = readl(mmio_base + SIL_SYSCFG);
 	tmp &= ~(SIL_MASK_IDE0_INT << ap->port_no);
@@ -622,11 +627,6 @@ static int sil_init_one (struct pci_dev 
 			       mmio_base + sil_port[2].bmdma);
 	}
 
-	/* mask all SATA phy-related interrupts */
-	/* TODO: unmask bit 6 (SError N bit) for hotplug */
-	for (i = 0; i < probe_ent->n_ports; i++)
-		writel(0, mmio_base + sil_port[i].sien);
-
 	pci_set_master(pdev);
 
 	/* FIXME: check ata_device_add return value */
-- 
1.2.4


