From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] libata-sff: ata_sff_irq_clear() is BMDMA specific
Date: Wed, 19 May 2010 22:10:20 +0200
Message-ID: <1274299824-15691-3-git-send-email-tj@kernel.org>
References: <1274299824-15691-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43301 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752661Ab0ESUKt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2010 16:10:49 -0400
In-Reply-To: <1274299824-15691-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

ata_sff_irq_clear() is BMDMA specific.  Rename it to
ata_bmdma_irq_clear(), move it to ata_bmdma_port_ops and make
->sff_irq_clear() optional.

Note: ata_bmdma_irq_clear() is actually only needed by ata_piix and
      possibly by sata_sil.  This should be moved to respective low
      level drivers later.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-sff.c |   67 +++++++++++++++++++++++++--------------------
 drivers/ata/pata_bf54x.c |    2 +-
 drivers/ata/pata_scc.c   |    2 +-
 drivers/ata/sata_nv.c    |    2 +-
 drivers/ata/sata_sil.c   |    4 +-
 drivers/ata/sata_via.c   |    2 +-
 include/linux/libata.h   |    1 +
 7 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 19ddf92..55bc488 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -63,7 +63,6 @@ const struct ata_port_operations ata_sff_port_ops = {
 	.sff_tf_read		= ata_sff_tf_read,
 	.sff_exec_command	= ata_sff_exec_command,
 	.sff_data_xfer		= ata_sff_data_xfer,
-	.sff_irq_clear		= ata_sff_irq_clear,
 	.sff_drain_fifo		= ata_sff_drain_fifo,
 
 	.lost_interrupt		= ata_sff_lost_interrupt,
@@ -395,33 +394,12 @@ void ata_sff_irq_on(struct ata_port *ap)
 		ata_sff_set_devctl(ap, ap->ctl);
 	ata_wait_idle(ap);
 
-	ap->ops->sff_irq_clear(ap);
+	if (ap->ops->sff_irq_clear)
+		ap->ops->sff_irq_clear(ap);
 }
 EXPORT_SYMBOL_GPL(ata_sff_irq_on);
 
 /**
- *	ata_sff_irq_clear - Clear PCI IDE BMDMA interrupt.
- *	@ap: Port associated with this ATA transaction.
- *
- *	Clear interrupt and error flags in DMA status register.
- *
- *	May be used as the irq_clear() entry in ata_port_operations.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host lock)
- */
-void ata_sff_irq_clear(struct ata_port *ap)
-{
-	void __iomem *mmio = ap->ioaddr.bmdma_addr;
-
-	if (!mmio)
-		return;
-
-	iowrite8(ioread8(mmio + ATA_DMA_STATUS), mmio + ATA_DMA_STATUS);
-}
-EXPORT_SYMBOL_GPL(ata_sff_irq_clear);
-
-/**
  *	ata_sff_tf_load - send taskfile registers to host controller
  *	@ap: Port to which output is sent
  *	@tf: ATA taskfile register set
@@ -1572,7 +1550,8 @@ unsigned int ata_sff_host_intr(struct ata_port *ap,
 	}
 
 	/* clear irq events */
-	ap->ops->sff_irq_clear(ap);
+	if (ap->ops->sff_irq_clear)
+		ap->ops->sff_irq_clear(ap);
 
 	ata_sff_hsm_move(ap, qc, status, 0);
 
@@ -1588,7 +1567,8 @@ idle_irq:
 #ifdef ATA_IRQ_TRAP
 	if ((ap->stats.idle_irq % 1000) == 0) {
 		ap->ops->sff_check_status(ap);
-		ap->ops->sff_irq_clear(ap);
+		if (ap->ops->sff_irq_clear)
+			ap->ops->sff_irq_clear(ap);
 		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
 		return 1;
 	}
@@ -1658,7 +1638,8 @@ retry:
 
 			if (idle & (1 << i)) {
 				ap->ops->sff_check_status(ap);
-				ap->ops->sff_irq_clear(ap);
+				if (ap->ops->sff_irq_clear)
+					ap->ops->sff_irq_clear(ap);
 			} else {
 				/* clear INTRQ and check if BUSY cleared */
 				if (!(ap->ops->sff_check_status(ap) & ATA_BUSY))
@@ -1744,7 +1725,8 @@ void ata_sff_freeze(struct ata_port *ap)
 	 */
 	ap->ops->sff_check_status(ap);
 
-	ap->ops->sff_irq_clear(ap);
+	if (ap->ops->sff_irq_clear)
+		ap->ops->sff_irq_clear(ap);
 }
 EXPORT_SYMBOL_GPL(ata_sff_freeze);
 
@@ -1761,7 +1743,8 @@ void ata_sff_thaw(struct ata_port *ap)
 {
 	/* clear & re-enable interrupts */
 	ap->ops->sff_check_status(ap);
-	ap->ops->sff_irq_clear(ap);
+	if (ap->ops->sff_irq_clear)
+		ap->ops->sff_irq_clear(ap);
 	ata_sff_irq_on(ap);
 }
 EXPORT_SYMBOL_GPL(ata_sff_thaw);
@@ -2580,6 +2563,7 @@ const struct ata_port_operations ata_bmdma_port_ops = {
 	.qc_prep		= ata_bmdma_qc_prep,
 	.qc_issue		= ata_bmdma_qc_issue,
 
+	.sff_irq_clear		= ata_bmdma_irq_clear,
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -2848,7 +2832,8 @@ void ata_bmdma_error_handler(struct ata_port *ap)
 		/* if we're gonna thaw, make sure IRQ is clear */
 		if (thaw) {
 			ap->ops->sff_check_status(ap);
-			ap->ops->sff_irq_clear(ap);
+			if (ap->ops->sff_irq_clear)
+				ap->ops->sff_irq_clear(ap);
 		}
 	}
 
@@ -2882,6 +2867,28 @@ void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc)
 EXPORT_SYMBOL_GPL(ata_bmdma_post_internal_cmd);
 
 /**
+ *	ata_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Clear interrupt and error flags in DMA status register.
+ *
+ *	May be used as the irq_clear() entry in ata_port_operations.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ */
+void ata_bmdma_irq_clear(struct ata_port *ap)
+{
+	void __iomem *mmio = ap->ioaddr.bmdma_addr;
+
+	if (!mmio)
+		return;
+
+	iowrite8(ioread8(mmio + ATA_DMA_STATUS), mmio + ATA_DMA_STATUS);
+}
+EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
+
+/**
  *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
  *	@qc: Info associated with this ATA transaction.
  *
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 6422cfd..9cae65d 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1214,7 +1214,7 @@ static unsigned int bfin_data_xfer(struct ata_device *dev, unsigned char *buf,
  *	bfin_irq_clear - Clear ATAPI interrupt.
  *	@ap: Port associated with this ATA transaction.
  *
- *	Note: Original code is ata_sff_irq_clear().
+ *	Note: Original code is ata_bmdma_irq_clear().
  */
 
 static void bfin_irq_clear(struct ata_port *ap)
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 6f6193b..fb318cd 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -875,7 +875,7 @@ static void scc_postreset(struct ata_link *link, unsigned int *classes)
  *	scc_irq_clear - Clear PCI IDE BMDMA interrupt.
  *	@ap: Port associated with this ATA transaction.
  *
- *	Note: Original code is ata_sff_irq_clear().
+ *	Note: Original code is ata_bmdma_irq_clear().
  */
 
 static void scc_irq_clear (struct ata_port *ap)
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index baa8f0d..358dde0 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1100,7 +1100,7 @@ static void nv_adma_irq_clear(struct ata_port *ap)
 	u32 notifier_clears[2];
 
 	if (pp->flags & NV_ADMA_ATAPI_SETUP_COMPLETE) {
-		ata_sff_irq_clear(ap);
+		ata_bmdma_irq_clear(ap);
 		return;
 	}
 
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 2dda312..3a4f842 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -503,7 +503,7 @@ static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
 		goto err_hsm;
 
 	/* ack bmdma irq events */
-	ata_sff_irq_clear(ap);
+	ata_bmdma_irq_clear(ap);
 
 	/* kick HSM in the ass */
 	ata_sff_hsm_move(ap, qc, status, 0);
@@ -584,7 +584,7 @@ static void sil_thaw(struct ata_port *ap)
 
 	/* clear IRQ */
 	ap->ops->sff_check_status(ap);
-	ata_sff_irq_clear(ap);
+	ata_bmdma_irq_clear(ap);
 
 	/* turn on SATA IRQ if supported */
 	if (!(ap->flags & SIL_FLAG_NO_SATA_IRQ))
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 08f6549..7737dd5 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -308,7 +308,7 @@ static void svia_noop_freeze(struct ata_port *ap)
 	 * certain way.  Leave it alone and just clear pending IRQ.
 	 */
 	ap->ops->sff_check_status(ap);
-	ata_sff_irq_clear(ap);
+	ata_bmdma_irq_clear(ap);
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ee84e7e..8fd1ca8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1630,6 +1630,7 @@ extern unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc);
 extern void ata_bmdma_dumb_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_bmdma_error_handler(struct ata_port *ap);
 extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
+extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void ata_bmdma_setup(struct ata_queued_cmd *qc);
 extern void ata_bmdma_start(struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
-- 
1.6.4.2

