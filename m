From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 15/23] libata-sff: separate out BMDMA EH
Date: Mon, 10 May 2010 21:41:39 +0200
Message-ID: <1273520507-32459-16-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44967 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756035Ab0EJTml (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:41 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

Some of error handling logic in ata_sff_error_handler() and all of
ata_sff_post_internal_cmd() are for BMDMA.  Create
ata_bmdma_error_handler() and ata_bmdma_post_internal_cmd() and move
BMDMA part into those.

While at it, change DMA protocol check to ata_is_dma(), fix
post_internal_cmd to call ap->ops->bmdma_stop instead of directly
calling ata_bmdma_stop() and open code hardreset selection so that
ata_std_error_handler() doesn't have to know about sff hardreset.

As these two functions are BMDMA specific, there's no reason to check
for bmdma_addr before calling bmdma methods if the protocol of the
failed command is DMA.  sata_mv and pata_mpc52xx now don't need to set
.post_internal_cmd to ATA_OP_NULL and pata_icside and sata_qstor don't
need to set it to their bmdma_stop routines.

ata_sff_post_internal_cmd() becomes noop and is removed.

This fixes p3 described in clean-up-BMDMA-initialization patch.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-eh.c    |    2 +-
 drivers/ata/libata-sff.c   |  159 ++++++++++++++++++++++++++------------------
 drivers/ata/libata.h       |   11 ---
 drivers/ata/pata_icside.c  |    1 -
 drivers/ata/pata_scc.c     |    1 -
 drivers/ata/sata_mv.c      |    2 -
 drivers/ata/sata_nv.c      |    6 +-
 drivers/ata/sata_promise.c |    2 +-
 drivers/ata/sata_qstor.c   |    3 +-
 drivers/ata/sata_sx4.c     |    2 +-
 include/linux/libata.h     |    3 +-
 11 files changed, 102 insertions(+), 90 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d6e6748..f77a673 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3684,7 +3684,7 @@ void ata_std_error_handler(struct ata_port *ap)
 	ata_reset_fn_t hardreset = ops->hardreset;
 
 	/* ignore built-in hardreset if SCR access is not available */
-	if (ata_is_builtin_hardreset(hardreset) && !sata_scr_valid(&ap->link))
+	if (hardreset == sata_std_hardreset && !sata_scr_valid(&ap->link))
 		hardreset = NULL;
 
 	ata_do_eh(ap, ops->prereset, ops->softreset, hardreset, ops->postreset);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 9a40b6e..4f12b2f 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -56,7 +56,6 @@ const struct ata_port_operations ata_sff_port_ops = {
 	.hardreset		= sata_sff_hardreset,
 	.postreset		= ata_sff_postreset,
 	.error_handler		= ata_sff_error_handler,
-	.post_internal_cmd	= ata_sff_post_internal_cmd,
 
 	.sff_dev_select		= ata_sff_dev_select,
 	.sff_check_status	= ata_sff_check_status,
@@ -2341,7 +2340,7 @@ void ata_sff_drain_fifo(struct ata_queued_cmd *qc)
 EXPORT_SYMBOL_GPL(ata_sff_drain_fifo);
 
 /**
- *	ata_sff_error_handler - Stock error handler for BMDMA controller
+ *	ata_sff_error_handler - Stock error handler for SFF controller
  *	@ap: port to handle error for
  *
  *	Stock error handler for SFF controller.  It can handle both
@@ -2358,64 +2357,32 @@ void ata_sff_error_handler(struct ata_port *ap)
 	ata_reset_fn_t hardreset = ap->ops->hardreset;
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
-	bool thaw = false;
 
 	qc = __ata_qc_from_tag(ap, ap->link.active_tag);
 	if (qc && !(qc->flags & ATA_QCFLAG_FAILED))
 		qc = NULL;
 
-	/* reset PIO HSM and stop DMA engine */
 	spin_lock_irqsave(ap->lock, flags);
 
-	if (ap->ioaddr.bmdma_addr &&
-	    qc && (qc->tf.protocol == ATA_PROT_DMA ||
-		   qc->tf.protocol == ATAPI_PROT_DMA)) {
-		u8 host_stat;
-
-		host_stat = ap->ops->bmdma_status(ap);
-
-		/* BMDMA controllers indicate host bus error by
-		 * setting DMA_ERR bit and timing out.  As it wasn't
-		 * really a timeout event, adjust error mask and
-		 * cancel frozen state.
-		 */
-		if (qc->err_mask == AC_ERR_TIMEOUT
-						&& (host_stat & ATA_DMA_ERR)) {
-			qc->err_mask = AC_ERR_HOST_BUS;
-			thaw = true;
-		}
-
-		ap->ops->bmdma_stop(qc);
-
-		/* if we're gonna thaw, make sure IRQ is clear */
-		if (thaw) {
-			ap->ops->sff_check_status(ap);
-			ap->ops->sff_irq_clear(ap);
-
-			spin_unlock_irqrestore(ap->lock, flags);
-			ata_eh_thaw_port(ap);
-			spin_lock_irqsave(ap->lock, flags);
-		}
-	}
-
-	/* We *MUST* do FIFO draining before we issue a reset as several
-	 * devices helpfully clear their internal state and will lock solid
-	 * if we touch the data port post reset. Pass qc in case anyone wants
-	 *  to do different PIO/DMA recovery or has per command fixups
+	/*
+	 * We *MUST* do FIFO draining before we issue a reset as
+	 * several devices helpfully clear their internal state and
+	 * will lock solid if we touch the data port post reset. Pass
+	 * qc in case anyone wants to do different PIO/DMA recovery or
+	 * has per command fixups
 	 */
 	if (ap->ops->sff_drain_fifo)
 		ap->ops->sff_drain_fifo(qc);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	/* PIO and DMA engines have been stopped, perform recovery */
-
-	/* Ignore ata_sff_softreset if ctl isn't accessible and
-	 * built-in hardresets if SCR access isn't available.
-	 */
+	/* ignore ata_sff_softreset if ctl isn't accessible */
 	if (softreset == ata_sff_softreset && !ap->ioaddr.ctl_addr)
 		softreset = NULL;
-	if (ata_is_builtin_hardreset(hardreset) && !sata_scr_valid(&ap->link))
+
+	/* ignore built-in hardresets if SCR access is not available */
+	if ((hardreset == sata_std_hardreset ||
+	     hardreset == sata_sff_hardreset) && !sata_scr_valid(&ap->link))
 		hardreset = NULL;
 
 	ata_do_eh(ap, ap->ops->prereset, softreset, hardreset,
@@ -2424,27 +2391,6 @@ void ata_sff_error_handler(struct ata_port *ap)
 EXPORT_SYMBOL_GPL(ata_sff_error_handler);
 
 /**
- *	ata_sff_post_internal_cmd - Stock post_internal_cmd for SFF controller
- *	@qc: internal command to clean up
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- */
-void ata_sff_post_internal_cmd(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	unsigned long flags;
-
-	spin_lock_irqsave(ap->lock, flags);
-
-	if (ap->ioaddr.bmdma_addr)
-		ap->ops->bmdma_stop(qc);
-
-	spin_unlock_irqrestore(ap->lock, flags);
-}
-EXPORT_SYMBOL_GPL(ata_sff_post_internal_cmd);
-
-/**
  *	ata_sff_std_ports - initialize ioaddr with standard port offsets.
  *	@ioaddr: IO address structure to be initialized
  *
@@ -2791,6 +2737,9 @@ EXPORT_SYMBOL_GPL(ata_pci_sff_init_one);
 const struct ata_port_operations ata_bmdma_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
 	.bmdma_setup		= ata_bmdma_setup,
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
@@ -2809,6 +2758,84 @@ const struct ata_port_operations ata_bmdma32_port_ops = {
 EXPORT_SYMBOL_GPL(ata_bmdma32_port_ops);
 
 /**
+ *	ata_bmdma_error_handler - Stock error handler for BMDMA controller
+ *	@ap: port to handle error for
+ *
+ *	Stock error handler for BMDMA controller.  It can handle both
+ *	PATA and SATA controllers.  Most BMDMA controllers should be
+ *	able to use this EH as-is or with some added handling before
+ *	and after.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+void ata_bmdma_error_handler(struct ata_port *ap)
+{
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	bool thaw = false;
+
+	qc = __ata_qc_from_tag(ap, ap->link.active_tag);
+	if (qc && !(qc->flags & ATA_QCFLAG_FAILED))
+		qc = NULL;
+
+	/* reset PIO HSM and stop DMA engine */
+	spin_lock_irqsave(ap->lock, flags);
+
+	if (qc && ata_is_dma(qc->tf.protocol)) {
+		u8 host_stat;
+
+		host_stat = ap->ops->bmdma_status(ap);
+
+		/* BMDMA controllers indicate host bus error by
+		 * setting DMA_ERR bit and timing out.  As it wasn't
+		 * really a timeout event, adjust error mask and
+		 * cancel frozen state.
+		 */
+		if (qc->err_mask == AC_ERR_TIMEOUT && (host_stat & ATA_DMA_ERR)) {
+			qc->err_mask = AC_ERR_HOST_BUS;
+			thaw = true;
+		}
+
+		ap->ops->bmdma_stop(qc);
+
+		/* if we're gonna thaw, make sure IRQ is clear */
+		if (thaw) {
+			ap->ops->sff_check_status(ap);
+			ap->ops->sff_irq_clear(ap);
+		}
+	}
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	if (thaw)
+		ata_eh_thaw_port(ap);
+
+	ata_sff_error_handler(ap);
+}
+EXPORT_SYMBOL_GPL(ata_bmdma_error_handler);
+
+/**
+ *	ata_bmdma_post_internal_cmd - Stock post_internal_cmd for BMDMA
+ *	@qc: internal command to clean up
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned long flags;
+
+	if (ata_is_dma(qc->tf.protocol)) {
+		spin_lock_irqsave(ap->lock, flags);
+		ap->ops->bmdma_stop(qc);
+		spin_unlock_irqrestore(ap->lock, flags);
+	}
+}
+EXPORT_SYMBOL_GPL(ata_bmdma_post_internal_cmd);
+
+/**
  *	ata_bmdma_setup - Set up PCI IDE BMDMA transaction
  *	@qc: Info associated with this ATA transaction.
  *
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 002390c..4b84ed6 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -38,17 +38,6 @@ struct ata_scsi_args {
 	void			(*done)(struct scsi_cmnd *);
 };
 
-static inline int ata_is_builtin_hardreset(ata_reset_fn_t reset)
-{
-	if (reset == sata_std_hardreset)
-		return 1;
-#ifdef CONFIG_ATA_SFF
-	if (reset == sata_sff_hardreset)
-		return 1;
-#endif
-	return 0;
-}
-
 /* libata-core.c */
 enum {
 	/* flags for ata_dev_read_id() */
diff --git a/drivers/ata/pata_icside.c b/drivers/ata/pata_icside.c
index ee85a9c..b56e8f7 100644
--- a/drivers/ata/pata_icside.c
+++ b/drivers/ata/pata_icside.c
@@ -333,7 +333,6 @@ static struct ata_port_operations pata_icside_port_ops = {
 	.cable_detect		= ata_cable_40wire,
 	.set_dmamode		= pata_icside_set_dmamode,
 	.postreset		= pata_icside_postreset,
-	.post_internal_cmd	= pata_icside_bmdma_stop,
 
 	.port_start		= ATA_OP_NULL,	/* don't need PRD table */
 };
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 1f64806..abbe05a 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -989,7 +989,6 @@ static struct ata_port_operations scc_pata_ops = {
 	.prereset		= scc_pata_prereset,
 	.softreset		= scc_softreset,
 	.postreset		= scc_postreset,
-	.post_internal_cmd	= scc_bmdma_stop,
 
 	.sff_irq_clear		= scc_irq_clear,
 	.sff_irq_on		= scc_irq_on,
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index fb0d2c1..d0c8449 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -675,8 +675,6 @@ static struct ata_port_operations mv5_ops = {
 	.freeze			= mv_eh_freeze,
 	.thaw			= mv_eh_thaw,
 	.hardreset		= mv_hardreset,
-	.error_handler		= ata_std_error_handler, /* avoid SFF EH */
-	.post_internal_cmd	= ATA_OP_NULL,
 
 	.scr_read		= mv5_scr_read,
 	.scr_write		= mv5_scr_write,
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 0a45d89..e6fd73e 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1131,7 +1131,7 @@ static void nv_adma_post_internal_cmd(struct ata_queued_cmd *qc)
 	struct nv_adma_port_priv *pp = qc->ap->private_data;
 
 	if (pp->flags & NV_ADMA_PORT_REGISTER_MODE)
-		ata_sff_post_internal_cmd(qc);
+		ata_bmdma_post_internal_cmd(qc);
 }
 
 static int nv_adma_port_start(struct ata_port *ap)
@@ -1739,7 +1739,7 @@ static void nv_adma_error_handler(struct ata_port *ap)
 		readw(mmio + NV_ADMA_CTL);	/* flush posted write */
 	}
 
-	ata_sff_error_handler(ap);
+	ata_bmdma_error_handler(ap);
 }
 
 static void nv_swncq_qc_to_dq(struct ata_port *ap, struct ata_queued_cmd *qc)
@@ -1865,7 +1865,7 @@ static void nv_swncq_error_handler(struct ata_port *ap)
 		ehc->i.action |= ATA_EH_RESET;
 	}
 
-	ata_sff_error_handler(ap);
+	ata_bmdma_error_handler(ap);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index e80628a..09a6179 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -839,7 +839,7 @@ static void pdc_error_handler(struct ata_port *ap)
 	if (!(ap->pflags & ATA_PFLAG_FROZEN))
 		pdc_reset_port(ap);
 
-	ata_std_error_handler(ap);
+	ata_sff_error_handler(ap);
 }
 
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc)
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index da84ea9..d3a22f2 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -147,7 +147,6 @@ static struct ata_port_operations qs_ata_ops = {
 	.prereset		= qs_prereset,
 	.softreset		= ATA_OP_NULL,
 	.error_handler		= qs_error_handler,
-	.post_internal_cmd	= ATA_OP_NULL,
 	.lost_interrupt		= ATA_OP_NULL,
 
 	.scr_read		= qs_scr_read,
@@ -255,7 +254,7 @@ static int qs_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val)
 static void qs_error_handler(struct ata_port *ap)
 {
 	qs_enter_reg_mode(ap);
-	ata_std_error_handler(ap);
+	ata_sff_error_handler(ap);
 }
 
 static int qs_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index a4e552a..bedd518 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -921,7 +921,7 @@ static void pdc_error_handler(struct ata_port *ap)
 	if (!(ap->pflags & ATA_PFLAG_FROZEN))
 		pdc_reset_port(ap);
 
-	ata_std_error_handler(ap);
+	ata_sff_error_handler(ap);
 }
 
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1c12f6a..7b96c2d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1613,7 +1613,6 @@ extern int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 extern void ata_sff_postreset(struct ata_link *link, unsigned int *classes);
 extern void ata_sff_drain_fifo(struct ata_queued_cmd *qc);
 extern void ata_sff_error_handler(struct ata_port *ap);
-extern void ata_sff_post_internal_cmd(struct ata_queued_cmd *qc);
 extern void ata_sff_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
 extern int ata_pci_sff_init_host(struct ata_host *host);
@@ -1628,6 +1627,8 @@ extern int ata_pci_sff_init_one(struct pci_dev *pdev,
 		struct scsi_host_template *sht, void *host_priv, int hflags);
 #endif /* CONFIG_PCI */
 
+extern void ata_bmdma_error_handler(struct ata_port *ap);
+extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
 extern void ata_bmdma_setup(struct ata_queued_cmd *qc);
 extern void ata_bmdma_start(struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
-- 
1.6.4.2

