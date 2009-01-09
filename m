From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Improve timeout handling
Date: Fri, 09 Jan 2009 18:41:52 +0000
Message-ID: <20090109184138.29364.81242.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58262 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753951AbZAISlp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Jan 2009 13:41:45 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org

From: Alan Cox <alan@redhat.com>

On a timeout call a device specific handler early in the recovery so that
we can complete and process successful commands which timed out due to IRQ
loss or the like rather more elegantly.

[Revised to exclude the timeout handling on a few devices that inherit from
 SFF but are not SFF enough to use the default timeout handler]

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/ata/libata-eh.c    |   19 ++++++++++++++++--
 drivers/ata/libata-sff.c   |   46 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/pata_isapnp.c  |   12 ++++++++++-
 drivers/ata/pdc_adma.c     |    2 ++
 drivers/ata/sata_mv.c      |    2 ++
 drivers/ata/sata_nv.c      |    1 +
 drivers/ata/sata_promise.c |    2 ++
 drivers/ata/sata_qstor.c   |    1 +
 drivers/ata/sata_vsc.c     |    3 +++
 include/linux/libata.h     |    2 ++
 10 files changed, 85 insertions(+), 5 deletions(-)


diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8147a83..5673623 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -543,7 +543,7 @@ void ata_scsi_error(struct Scsi_Host *host)
 
 	/* For new EH, all qcs are finished in one of three ways -
 	 * normal completion, error completion, and SCSI timeout.
-	 * Both cmpletions can race against SCSI timeout.  When normal
+	 * Both completions can race against SCSI timeout.  When normal
 	 * completion wins, the qc never reaches EH.  When error
 	 * completion wins, the qc has ATA_QCFLAG_FAILED set.
 	 *
@@ -558,7 +558,19 @@ void ata_scsi_error(struct Scsi_Host *host)
 		int nr_timedout = 0;
 
 		spin_lock_irqsave(ap->lock, flags);
-
+		
+		/* This must occur under the ap->lock as we don't want
+		   a polled recovery to race the real interrupt handler
+		   
+		   The lost_interrupt handler checks for any completed but
+		   non-notified command and completes much like an IRQ handler.
+		   
+		   We then fall into the error recovery code which will treat
+		   this as if normal completion won the race */
+
+		if (ap->ops->lost_interrupt)
+			ap->ops->lost_interrupt(ap);
+			
 		list_for_each_entry_safe(scmd, tmp, &host->eh_cmd_q, eh_entry) {
 			struct ata_queued_cmd *qc;
 
@@ -602,6 +614,9 @@ void ata_scsi_error(struct Scsi_Host *host)
 		ap->eh_tries = ATA_EH_MAX_TRIES;
 	} else
 		spin_unlock_wait(ap->lock);
+		
+	/* If we timed raced normal completion and there is nothing to
+	   recover nr_timedout == 0 why exactly are we doing error recovery ? */
 
  repeat:
 	/* invoke error handler */
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 92b5755..9682e1e 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -65,6 +65,8 @@ const struct ata_port_operations ata_sff_port_ops = {
 	.sff_irq_on		= ata_sff_irq_on,
 	.sff_irq_clear		= ata_sff_irq_clear,
 
+	.lost_interrupt		= ata_sff_lost_interrupt,
+
 	.port_start		= ata_sff_port_start,
 };
 
@@ -1543,7 +1545,7 @@ bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc)
  *	RETURNS:
  *	One if interrupt was handled, zero if not (shared irq).
  */
-inline unsigned int ata_sff_host_intr(struct ata_port *ap,
+unsigned int ata_sff_host_intr(struct ata_port *ap,
 				      struct ata_queued_cmd *qc)
 {
 	struct ata_eh_info *ehi = &ap->link.eh_info;
@@ -1670,6 +1672,47 @@ irqreturn_t ata_sff_interrupt(int irq, void *dev_instance)
 }
 
 /**
+ *	ata_sff_lost_interrupt	-	Check for an apparent lost interrupt
+ *	@ap: port that appears to have timed out
+ *
+ *	Called from the libata error handlers when the core code suspects
+ *	an interrupt has been lost. If it has complete anything we can and
+ *	then return. Interface must support altstatus for this faster
+ *	recovery to occur.
+ *
+ *	Locking:
+ *	Caller holds host lock
+ */
+
+void ata_sff_lost_interrupt(struct ata_port *ap)
+{
+	u8 status;
+	struct ata_queued_cmd *qc;
+
+	/* Only one outstanding command per SFF channel */
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
+	/* Check we have a live one.. */
+	if (qc == NULL ||  !(qc->flags & ATA_QCFLAG_ACTIVE))
+		return;
+	/* We cannot lose an interrupt on a polled command */
+	if (qc->tf.flags & ATA_TFLAG_POLLING)
+		return;
+	/* See if the controller thinks it is still busy - if so the command
+	   isn't a lost IRQ but is still in progress */
+	status = ata_sff_altstatus(ap);
+	if (status & ATA_BUSY)
+		return;
+
+	/* There was a command running, we are no longer busy and we have
+	   no interrupt. */
+	ata_port_printk(ap, KERN_WARNING, "lost interrupt (Status 0x%x)\n",
+								status);
+	/* Run the host interrupt logic as if the interrupt had not been
+	   lost */
+	ata_sff_host_intr(ap, qc);
+}
+
+/**
  *	ata_sff_freeze - Freeze SFF controller port
  *	@ap: port to freeze
  *
@@ -2889,6 +2932,7 @@ EXPORT_SYMBOL_GPL(ata_sff_qc_issue);
 EXPORT_SYMBOL_GPL(ata_sff_qc_fill_rtf);
 EXPORT_SYMBOL_GPL(ata_sff_host_intr);
 EXPORT_SYMBOL_GPL(ata_sff_interrupt);
+EXPORT_SYMBOL_GPL(ata_sff_lost_interrupt);
 EXPORT_SYMBOL_GPL(ata_sff_freeze);
 EXPORT_SYMBOL_GPL(ata_sff_thaw);
 EXPORT_SYMBOL_GPL(ata_sff_prereset);
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 15cdb91..eb50be8 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -17,7 +17,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_isapnp"
-#define DRV_VERSION "0.2.2"
+#define DRV_VERSION "0.2.5"
 
 static struct scsi_host_template isapnp_sht = {
 	ATA_PIO_SHT(DRV_NAME),
@@ -28,6 +28,13 @@ static struct ata_port_operations isapnp_port_ops = {
 	.cable_detect	= ata_cable_40wire,
 };
 
+static struct ata_port_operations isapnp_noalt_port_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.cable_detect	= ata_cable_40wire,
+	/* No altstatus so we don't want to use the lost interrupt poll */
+	.lost_interrupt = ATA_OP_NULL,
+};
+
 /**
  *	isapnp_init_one		-	attach an isapnp interface
  *	@idev: PnP device
@@ -65,7 +72,7 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
 
 	ap = host->ports[0];
 
-	ap->ops = &isapnp_port_ops;
+	ap->ops = &isapnp_noalt_port_ops;
 	ap->pio_mask = 1;
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 
@@ -76,6 +83,7 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
 					   pnp_port_start(idev, 1), 1);
 		ap->ioaddr.altstatus_addr = ctl_addr;
 		ap->ioaddr.ctl_addr = ctl_addr;
+		ap->ops = &isapnp_port_ops;
 	}
 
 	ata_sff_std_ports(&ap->ioaddr);
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index be53545..51b4081 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -148,6 +148,8 @@ static struct scsi_host_template adma_ata_sht = {
 static struct ata_port_operations adma_ata_ops = {
 	.inherits		= &ata_sff_port_ops,
 
+	.lost_interrupt		= ATA_OP_NULL,
+
 	.check_atapi_dma	= adma_check_atapi_dma,
 	.qc_prep		= adma_qc_prep,
 	.qc_issue		= adma_qc_issue,
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 8691863..da294ae 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -572,6 +572,8 @@ static struct scsi_host_template mv6_sht = {
 static struct ata_port_operations mv5_ops = {
 	.inherits		= &ata_sff_port_ops,
 
+	.lost_interrupt		= ATA_OP_NULL,
+
 	.qc_defer		= mv_qc_defer,
 	.qc_prep		= mv_qc_prep,
 	.qc_issue		= mv_qc_issue,
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 6f14606..d2820ca 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -407,6 +407,7 @@ static struct scsi_host_template nv_swncq_sht = {
 
 static struct ata_port_operations nv_common_ops = {
 	.inherits		= &ata_bmdma_port_ops,
+	.lost_interrupt		= ATA_OP_NULL,
 	.scr_read		= nv_scr_read,
 	.scr_write		= nv_scr_write,
 };
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index ba9a257..7fe3da2 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -176,7 +176,9 @@ static const struct ata_port_operations pdc_common_ops = {
 	.check_atapi_dma	= pdc_check_atapi_dma,
 	.qc_prep		= pdc_qc_prep,
 	.qc_issue		= pdc_qc_issue,
+
 	.sff_irq_clear		= pdc_irq_clear,
+	.lost_interrupt		= ATA_OP_NULL,
 
 	.post_internal_cmd	= pdc_post_internal_cmd,
 	.error_handler		= pdc_error_handler,
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index a000c86..7a9349a 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -147,6 +147,7 @@ static struct ata_port_operations qs_ata_ops = {
 	.softreset		= ATA_OP_NULL,
 	.error_handler		= qs_error_handler,
 	.post_internal_cmd	= ATA_OP_NULL,
+	.lost_interrupt		= ATA_OP_NULL,
 
 	.scr_read		= qs_scr_read,
 	.scr_write		= qs_scr_write,
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index c57cdff..07baeef 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -308,6 +308,9 @@ static struct scsi_host_template vsc_sata_sht = {
 
 static struct ata_port_operations vsc_sata_ops = {
 	.inherits		= &ata_bmdma_port_ops,
+	/* The IRQ handling is not quite standard SFF behaviour so we
+	   cannot use the default lost interrupt handler */
+	.lost_interrupt		= ATA_OP_NULL,
 	.sff_tf_load		= vsc_sata_tf_load,
 	.sff_tf_read		= vsc_sata_tf_read,
 	.freeze			= vsc_freeze,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8cfc8f4..bdc9696 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -785,6 +785,7 @@ struct ata_port_operations {
 	ata_reset_fn_t		pmp_hardreset;
 	ata_postreset_fn_t	pmp_postreset;
 	void (*error_handler)(struct ata_port *ap);
+	void (*lost_interrupt)(struct ata_port *ap);
 	void (*post_internal_cmd)(struct ata_queued_cmd *qc);
 
 	/*
@@ -1558,6 +1559,7 @@ extern bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc);
 extern unsigned int ata_sff_host_intr(struct ata_port *ap,
 				      struct ata_queued_cmd *qc);
 extern irqreturn_t ata_sff_interrupt(int irq, void *dev_instance);
+extern void ata_sff_lost_interrupt(struct ata_port *ap);
 extern void ata_sff_freeze(struct ata_port *ap);
 extern void ata_sff_thaw(struct ata_port *ap);
 extern int ata_sff_prereset(struct ata_link *link, unsigned long deadline);

