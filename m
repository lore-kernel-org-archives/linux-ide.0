From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/13] sata_sil: convert to new probing mechanism and add hotplug support
Date: Sat, 20 May 2006 00:48:27 +0900
Message-ID: <11480537073457-git-send-email-htejun@gmail.com>
References: <11480537063293-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:62374 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932396AbWESPsk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 11:48:40 -0400
Received: by wr-out-0506.google.com with SMTP id 68so959492wra
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 08:48:39 -0700 (PDT)
In-Reply-To: <11480537063293-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Convert to new probing mechanism and add hotplug support by enabling
SATA IRQ for SError.N, marking ehi for hotplug and scheduling EH on
SATA IRQs.

Sil3112/3512/3114 family of controllers use COMRESET as TF clearing
point and can reliably wait for FIS34 after COMRESET whether the FIS
is the first FIS34 after POR or in response to the COMRESET.  Thus,
setting ATA_FLAG_HRST_TO_RESUME is enough for device detection after
hotplug.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

a5ad0f182f2fb6b60a6ac93a25da973759812594
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 96fbeb6..3a9a949 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -56,7 +56,7 @@ enum {
 	SIL_FLAG_MOD15WRITE	= (1 << 30),
 
 	SIL_DFL_HOST_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_MMIO,
+				  ATA_FLAG_MMIO | ATA_FLAG_HRST_TO_RESUME,
 
 	/*
 	 * Controller IDs
@@ -186,7 +186,6 @@ static const struct ata_port_operations 
 	.check_status		= ata_check_status,
 	.exec_command		= ata_exec_command,
 	.dev_select		= ata_std_dev_select,
-	.probe_reset		= ata_std_probe_reset,
 	.post_set_mode		= sil_post_set_mode,
 	.bmdma_setup            = ata_bmdma_setup,
 	.bmdma_start            = ata_bmdma_start,
@@ -343,6 +342,11 @@ static void sil_host_intr(struct ata_por
 	struct ata_queued_cmd *qc = ata_qc_from_tag(ap, ap->active_tag);
 	u8 status;
 
+	if (unlikely(bmdma2 & SIL_DMA_SATA_IRQ)) {
+		ata_ehi_hotplugged(&ap->eh_info);
+		goto freeze;
+	}
+
 	if (unlikely(!qc || qc->tf.ctl & ATA_NIEN))
 		goto freeze;
 
@@ -416,7 +420,7 @@ static irqreturn_t sil_interrupt(int irq
 		if (unlikely(!ap || ap->flags & ATA_FLAG_DISABLED))
 			continue;
 
-		if (!(bmdma2 & SIL_DMA_COMPLETE))
+		if (!(bmdma2 & (SIL_DMA_COMPLETE | SIL_DMA_SATA_IRQ)))
 			continue;
 
 		sil_host_intr(ap, bmdma2);
@@ -433,6 +437,9 @@ static void sil_freeze(struct ata_port *
 	void __iomem *mmio_base = ap->host_set->mmio_base;
 	u32 tmp;
 
+	/* global IRQ mask doesn't block SATA IRQ, turn off explicitly */
+	writel(0, mmio_base + sil_port[ap->port_no].sien);
+
 	/* plug IRQ */
 	tmp = readl(mmio_base + SIL_SYSCFG);
 	tmp |= SIL_MASK_IDE0_INT << ap->port_no;
@@ -449,6 +456,9 @@ static void sil_thaw(struct ata_port *ap
 	ata_chk_status(ap);
 	ata_bmdma_irq_clear(ap);
 
+	/* turn on SATA IRQ */
+	writel(SIL_SIEN_N, mmio_base + sil_port[ap->port_no].sien);
+
 	/* turn on IRQ */
 	tmp = readl(mmio_base + SIL_SYSCFG);
 	tmp &= ~(SIL_MASK_IDE0_INT << ap->port_no);
@@ -622,11 +632,6 @@ static int sil_init_one (struct pci_dev 
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
1.3.2


