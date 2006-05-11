From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/11] libata-eh: implement BMDMA EH
Date: Thu, 11 May 2006 22:21:27 +0900
Message-ID: <1147353687173-git-send-email-htejun@gmail.com>
References: <11473536873966-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.206]:45348 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751729AbWEKNVi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:21:38 -0400
Received: by wx-out-0102.google.com with SMTP id t5so1388wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:21:38 -0700 (PDT)
In-Reply-To: <11473536873966-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement stock BMDMA error handling methods.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-bmdma.c |  144 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c  |    5 +
 include/linux/libata.h      |    8 ++
 3 files changed, 157 insertions(+), 0 deletions(-)

33c8c944f97629b555fc6a14ca49803c47f9d50b
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 835dff0..751ec18 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -652,6 +652,150 @@ void ata_bmdma_stop(struct ata_queued_cm
 	ata_altstatus(ap);        /* dummy read */
 }
 
+/**
+ *	ata_bmdma_freeze - Freeze BMDMA controller port
+ *	@ap: port to freeze
+ *
+ *	Freeze BMDMA controller port.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+void ata_bmdma_freeze(struct ata_port *ap)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	ap->ctl |= ATA_NIEN;
+	ap->last_ctl = ap->ctl;
+
+	if (ap->flags & ATA_FLAG_MMIO)
+		writeb(ap->ctl, (void __iomem *)ioaddr->ctl_addr);
+	else
+		outb(ap->ctl, ioaddr->ctl_addr);
+}
+
+/**
+ *	ata_bmdma_thaw - Thaw BMDMA controller port
+ *	@ap: port to thaw
+ *
+ *	Thaw BMDMA controller port.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+void ata_bmdma_thaw(struct ata_port *ap)
+{
+	/* clear & re-enable interrupts */
+	ata_chk_status(ap);
+	ap->ops->irq_clear(ap);
+	if (ap->ioaddr.ctl_addr)	/* FIXME: hack. create a hook instead */
+		ata_irq_on(ap);
+}
+
+/**
+ *	ata_bmdma_drive_eh - Perform EH with given methods for BMDMA controller
+ *	@ap: port to handle error for
+ *	@softreset: softreset method (can be NULL)
+ *	@hardreset: hardreset method (can be NULL)
+ *	@postreset: postreset method (can be NULL)
+ *
+ *	Handle error for ATA BMDMA controller.  It can handle both
+ *	PATA and SATA controllers.  Many controllers should be able to
+ *	use this EH as-is or with some added handling before and
+ *	after.
+ *
+ *	This function is intended to be used for constructing
+ *	->error_handler callback by low level drivers.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+void ata_bmdma_drive_eh(struct ata_port *ap, ata_reset_fn_t softreset,
+			ata_reset_fn_t hardreset, ata_postreset_fn_t postreset)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	struct ata_eh_context *ehc = &ap->eh_context;
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	int thaw = 0;
+
+	qc = __ata_qc_from_tag(ap, ap->active_tag);
+	if (qc && !(qc->flags & ATA_QCFLAG_FAILED))
+		qc = NULL;
+
+	/* reset PIO HSM and stop DMA engine */
+	spin_lock_irqsave(&host_set->lock, flags);
+
+	ap->flags &= ~ATA_FLAG_NOINTR;
+	ap->hsm_task_state = HSM_ST_IDLE;
+
+	if (qc && (qc->tf.protocol == ATA_PROT_DMA ||
+		   qc->tf.protocol == ATA_PROT_ATAPI_DMA)) {
+		u8 host_stat;
+
+		host_stat = ata_bmdma_status(ap);
+
+		ata_ehi_push_desc(&ehc->i, "BMDMA stat 0x%x", host_stat);
+
+		/* BMDMA controllers indicate host bus error by
+		 * setting DMA_ERR bit and timing out.  As it wasn't
+		 * really a timeout event, adjust error mask and
+		 * cancel frozen state.
+		 */
+		if (qc->err_mask == AC_ERR_TIMEOUT && host_stat & ATA_DMA_ERR) {
+			qc->err_mask = AC_ERR_HOST_BUS;
+			thaw = 1;
+		}
+
+		ap->ops->bmdma_stop(qc);
+	}
+
+	ata_altstatus(ap);
+	ata_chk_status(ap);
+	ap->ops->irq_clear(ap);
+
+	spin_unlock_irqrestore(&host_set->lock, flags);
+
+	if (thaw)
+		ata_eh_thaw_port(ap);
+
+	/* PIO and DMA engines have been stopped, perform recovery */
+	ata_do_eh(ap, softreset, hardreset, postreset);
+}
+
+/**
+ *	ata_bmdma_error_handler - Stock error handler for BMDMA controller
+ *	@ap: port to handle error for
+ *
+ *	Stock error handler for BMDMA controller.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+void ata_bmdma_error_handler(struct ata_port *ap)
+{
+	ata_reset_fn_t hardreset;
+
+	hardreset = NULL;
+	if (ata_scr_valid(ap))
+		hardreset = sata_std_hardreset;
+
+	ata_bmdma_drive_eh(ap, ata_std_softreset, hardreset, ata_std_postreset);
+}
+
+/**
+ *	ata_bmdma_post_internal_cmd - Stock post_internal_cmd for
+ *				      BMDMA controller
+ *	@qc: internal command to clean up
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ */
+void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc)
+{
+	ata_bmdma_stop(qc);
+}
+
 #ifdef CONFIG_PCI
 static struct ata_probe_ent *
 ata_probe_ent_alloc(struct device *dev, const struct ata_port_info *port)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 35faf66..f50fea6 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5377,6 +5377,11 @@ EXPORT_SYMBOL_GPL(ata_bmdma_start);
 EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
 EXPORT_SYMBOL_GPL(ata_bmdma_status);
 EXPORT_SYMBOL_GPL(ata_bmdma_stop);
+EXPORT_SYMBOL_GPL(ata_bmdma_freeze);
+EXPORT_SYMBOL_GPL(ata_bmdma_thaw);
+EXPORT_SYMBOL_GPL(ata_bmdma_drive_eh);
+EXPORT_SYMBOL_GPL(ata_bmdma_error_handler);
+EXPORT_SYMBOL_GPL(ata_bmdma_post_internal_cmd);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(ata_set_sata_spd);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 867f1d5..6ac840f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -664,6 +664,14 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
+extern void ata_bmdma_freeze(struct ata_port *ap);
+extern void ata_bmdma_thaw(struct ata_port *ap);
+extern void ata_bmdma_drive_eh(struct ata_port *ap,
+			       ata_reset_fn_t softreset,
+			       ata_reset_fn_t hardreset,
+			       ata_postreset_fn_t postreset);
+extern void ata_bmdma_error_handler(struct ata_port *ap);
+extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
-- 
1.2.4


