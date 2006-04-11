From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/14] libata-eh: implement EH methods for BMDMA controllers
Date: Tue, 11 Apr 2006 22:48:22 +0900
Message-ID: <11447633021604-git-send-email-htejun@gmail.com>
References: <11447633013561-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.236]:12958 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750945AbWDKNs3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:48:29 -0400
Received: by wproxy.gmail.com with SMTP id i11so926523wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:48:28 -0700 (PDT)
In-Reply-To: <11447633013561-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement EH methods for BMDMA controllers.  The followings are
defined.

* ata_bmdma_freeze: freeze BMDMA controller by turning on ATA_NIEN
* ata_bmdma_bmdma_drive_eh: drive BMDMA EH using given soft, hard and
			    post reset methods.
* ata_bmdma_error_handler: the stock BMDMA EH with stock reset
			   routines.
* ata_bmdma_post_internal_cmd: the stock BMDMA post_internal_cmd.
			       Makes sure BMDMA engine is stopped
			       after an internal command.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-bmdma.c |  112 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c  |    4 ++
 include/linux/libata.h      |    7 +++
 3 files changed, 123 insertions(+), 0 deletions(-)

e397d0ae739666692a9ca0d6ccbf083bfdf6b5ed
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 835dff0..6e48ce5 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -652,6 +652,118 @@ void ata_bmdma_stop(struct ata_queued_cm
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
+ *	ata_bmdma_drive_eh - Perform EH with given methods for BMDMA controller
+ *	@ap: port to handle error for
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
+void ata_bmdma_drive_eh(struct ata_port *ap,
+			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
+			ata_postreset_fn_t postreset)
+{
+	struct ata_host_set *host_set = ap->host_set;
+	unsigned int action = 0;
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	struct ata_taskfile tf;
+	u32 serror;
+
+	qc = ata_eh_determine_qc(ap, &tf);
+
+	/* reset PIO HSM and stop DMA engine */
+	spin_lock_irqsave(&host_set->lock, flags);
+
+	ap->flags &= ~ATA_FLAG_NOINTR;
+	ap->hsm_task_state = HSM_ST_IDLE;
+
+	if (qc && (qc->tf.protocol == ATA_PROT_DMA ||
+		   qc->tf.protocol == ATA_PROT_ATAPI_DMA))
+		ap->ops->bmdma_stop(qc);
+
+	ata_altstatus(ap);
+	ata_chk_status(ap);
+	ap->ops->irq_clear(ap);
+
+	spin_unlock_irqrestore(&host_set->lock, flags);
+
+	/* PIO and DMA engines have been stopped, perform recovery */
+	serror = 0;
+	if (ap->cbl == ATA_CBL_SATA && ap->ops->scr_read) {
+		serror = scr_read(ap, SCR_ERROR);
+		scr_write(ap, SCR_ERROR, serror);
+	}
+
+	action |= ata_eh_autopsy(ap, qc, &tf, serror);
+	ata_eh_report(ap, qc, &tf, serror, action, NULL);
+	ata_eh_revive(ap, action, softreset, hardreset, postreset);
+	ata_eh_finish_qcs(ap, qc, &tf);
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
+	if (ap->flags & ATA_FLAG_SATA && ap->ops->scr_read)
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
index 7605313..ac79c5c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5288,6 +5288,10 @@ EXPORT_SYMBOL_GPL(ata_bmdma_start);
 EXPORT_SYMBOL_GPL(ata_bmdma_irq_clear);
 EXPORT_SYMBOL_GPL(ata_bmdma_status);
 EXPORT_SYMBOL_GPL(ata_bmdma_stop);
+EXPORT_SYMBOL_GPL(ata_bmdma_freeze);
+EXPORT_SYMBOL_GPL(ata_bmdma_drive_eh);
+EXPORT_SYMBOL_GPL(ata_bmdma_error_handler);
+EXPORT_SYMBOL_GPL(ata_bmdma_post_internal_cmd);
 EXPORT_SYMBOL_GPL(ata_port_probe);
 EXPORT_SYMBOL_GPL(ata_set_sata_spd);
 EXPORT_SYMBOL_GPL(sata_phy_reset);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7f626d2..603d800 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -626,6 +626,13 @@ extern void ata_bmdma_start (struct ata_
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
+extern void ata_bmdma_freeze(struct ata_port *ap);
+extern void ata_bmdma_drive_eh(struct ata_port *ap,
+			       ata_reset_fn_t softreset,
+			       ata_reset_fn_t hardreset,
+			       ata_postreset_fn_t postreset);
+extern void ata_bmdma_error_handler(struct ata_port *ap);
+extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
 			      struct scsi_cmnd *cmd,
-- 
1.2.4


