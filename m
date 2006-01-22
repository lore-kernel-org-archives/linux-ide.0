From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/12] libata: implement and apply ata_eh_qc_complete/retry()
Date: Sun, 22 Jan 2006 16:58:31 +0900
Message-ID: <11379167111128-git-send-email-htejun@gmail.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.199]:60330 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932142AbWAVH7K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:59:10 -0500
Received: by wproxy.gmail.com with SMTP id 57so731388wri
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:59:09 -0800 (PST)
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_eh_qc_complete/retry() using scsi_eh_finish_cmd() and
scsi_eh_flush_done_q().  This removes all eh scsicmd finish hacks from
low level drivers.

This change was first suggested by Jeff Garzik.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |   12 ++-------
 drivers/scsi/libata-core.c  |   14 ++++------
 drivers/scsi/libata-scsi.c  |   59 +++++++++++++++++++++++++++++++++++++++----
 drivers/scsi/sata_mv.c      |   12 +--------
 drivers/scsi/sata_promise.c |   12 +--------
 drivers/scsi/sata_sil24.c   |   10 +------
 drivers/scsi/sata_sx4.c     |   12 +--------
 include/linux/libata.h      |    3 ++
 8 files changed, 70 insertions(+), 64 deletions(-)

fa3ba673fc07197ab8a882d68e9641f3e8dc041f
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 75b1fb5..89ba2bd 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -672,19 +672,13 @@ static void ahci_eng_timeout(struct ata_
 		       ap->id);
 	} else {
 		ahci_restart_port(ap, readl(port_mmio + PORT_IRQ_STAT));
-
-		/* hack alert!  We cannot use the supplied completion
-	 	 * function from inside the ->eh_strategy_handler() thread.
-	 	 * libata is the only user of ->eh_strategy_handler() in
-	 	 * any kernel, so the default scsi_done() assumes it is
-	 	 * not being called from the SCSI EH.
-	 	 */
-		qc->scsidone = scsi_finish_command;
 		qc->err_mask |= AC_ERR_TIMEOUT;
-		ata_qc_complete(qc);
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
+
+	if (qc)
+		ata_eh_qc_complete(qc);
 }
 
 static inline int ahci_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc)
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b29bf0d..93ae2dc 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3449,14 +3449,6 @@ static void ata_qc_timeout(struct ata_qu
 
 	spin_lock_irqsave(&host_set->lock, flags);
 
-	/* hack alert!  We cannot use the supplied completion
-	 * function from inside the ->eh_strategy_handler() thread.
-	 * libata is the only user of ->eh_strategy_handler() in
-	 * any kernel, so the default scsi_done() assumes it is
-	 * not being called from the SCSI EH.
-	 */
-	qc->scsidone = scsi_finish_command;
-
 	switch (qc->tf.protocol) {
 
 	case ATA_PROT_DMA:
@@ -3480,12 +3472,13 @@ static void ata_qc_timeout(struct ata_qu
 
 		/* complete taskfile transaction */
 		qc->err_mask |= ac_err_mask(drv_stat);
-		ata_qc_complete(qc);
 		break;
 	}
 
 	spin_unlock_irqrestore(&host_set->lock, flags);
 
+	ata_eh_qc_complete(qc);
+
 	DPRINTK("EXIT\n");
 }
 
@@ -4422,6 +4415,7 @@ static void ata_host_init(struct ata_por
 
 	INIT_WORK(&ap->packet_task, atapi_packet_task, ap);
 	INIT_WORK(&ap->pio_task, ata_pio_task, ap);
+	INIT_LIST_HEAD(&ap->eh_done_q);
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++)
 		ap->device[i].devno = i;
@@ -5165,6 +5159,8 @@ EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
 EXPORT_SYMBOL_GPL(ata_dev_config);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
+EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
+EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 
 EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
 EXPORT_SYMBOL_GPL(ata_timing_compute);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 95e3c27..ab6b533 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -738,17 +738,64 @@ int ata_scsi_error(struct Scsi_Host *hos
 	ap = (struct ata_port *) &host->hostdata[0];
 	ap->ops->eng_timeout(ap);
 
-	/* TODO: this is per-command; when queueing is supported
-	 * this code will either change or move to a more
-	 * appropriate place
-	 */
-	host->host_failed--;
-	INIT_LIST_HEAD(&host->eh_cmd_q);
+	assert(host->host_failed == 0 && list_empty(&host->eh_cmd_q));
+
+	scsi_eh_flush_done_q(&ap->eh_done_q);
 
 	DPRINTK("EXIT\n");
 	return 0;
 }
 
+static void ata_eh_scsidone(struct scsi_cmnd *scmd)
+{
+	/* nada */
+}
+
+static void __ata_eh_qc_complete(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct scsi_cmnd *scmd = qc->scsicmd;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	qc->scsidone = ata_eh_scsidone;
+	ata_qc_complete(qc);
+	assert(!ata_tag_valid(qc->tag));
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
+}
+
+/**
+ *	ata_eh_qc_complete - Complete an active ATA command from EH
+ *	@qc: Command to complete
+ *
+ *	Indicate to the mid and upper layers that an ATA command has
+ *	completed.  To be used from EH.
+ */
+void ata_eh_qc_complete(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *scmd = qc->scsicmd;
+	scmd->retries = scmd->allowed;
+	__ata_eh_qc_complete(qc);
+}
+
+/**
+ *	ata_eh_qc_retry - Tell midlayer to retry an ATA command after EH
+ *	@qc: Command to retry
+ *
+ *	Indicate to the mid and upper layers that an ATA command
+ *	should be retried.  To be used from EH.
+ *
+ *	SCSI midlayer limits the number of retries to scmd->allowed.
+ *	This function might need to adjust scmd->retries for commands
+ *	which get retried due to unrelated NCQ failures.
+ */
+void ata_eh_qc_retry(struct ata_queued_cmd *qc)
+{
+	__ata_eh_qc_complete(qc);
+}
+
 /**
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
  *	@qc: Storage for translated ATA taskfile
diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index 281223a..d9a554c 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -1839,7 +1839,6 @@ static void mv_phy_reset(struct ata_port
 static void mv_eng_timeout(struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
-	unsigned long flags;
 
 	printk(KERN_ERR "ata%u: Entering mv_eng_timeout\n",ap->id);
 	DPRINTK("All regs @ start of eng_timeout\n");
@@ -1858,17 +1857,8 @@ static void mv_eng_timeout(struct ata_po
 		printk(KERN_ERR "ata%u: BUG: timeout without command\n",
 		       ap->id);
 	} else {
-		/* hack alert!  We cannot use the supplied completion
-	 	 * function from inside the ->eh_strategy_handler() thread.
-	 	 * libata is the only user of ->eh_strategy_handler() in
-	 	 * any kernel, so the default scsi_done() assumes it is
-	 	 * not being called from the SCSI EH.
-	 	 */
-		spin_lock_irqsave(&ap->host_set->lock, flags);
-		qc->scsidone = scsi_finish_command;
 		qc->err_mask |= AC_ERR_TIMEOUT;
-		ata_qc_complete(qc);
-		spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		ata_eh_qc_complete(qc);
 	}
 }
 
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index bac36d5..77ef646 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -400,21 +400,12 @@ static void pdc_eng_timeout(struct ata_p
 		goto out;
 	}
 
-	/* hack alert!  We cannot use the supplied completion
-	 * function from inside the ->eh_strategy_handler() thread.
-	 * libata is the only user of ->eh_strategy_handler() in
-	 * any kernel, so the default scsi_done() assumes it is
-	 * not being called from the SCSI EH.
-	 */
-	qc->scsidone = scsi_finish_command;
-
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 		drv_stat = ata_wait_idle(ap);
 		qc->err_mask |= __ac_err_mask(drv_stat);
-		ata_qc_complete(qc);
 		break;
 
 	default:
@@ -424,12 +415,13 @@ static void pdc_eng_timeout(struct ata_p
 		       ap->id, qc->tf.command, drv_stat);
 
 		qc->err_mask |= ac_err_mask(drv_stat);
-		ata_qc_complete(qc);
 		break;
 	}
 
 out:
 	spin_unlock_irqrestore(&host_set->lock, flags);
+	if (qc)
+		ata_eh_qc_complete(qc);
 	DPRINTK("EXIT\n");
 }
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 5a7a7b1..7222fc7 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -644,17 +644,9 @@ static void sil24_eng_timeout(struct ata
 		return;
 	}
 
-	/*
-	 * hack alert!  We cannot use the supplied completion
-	 * function from inside the ->eh_strategy_handler() thread.
-	 * libata is the only user of ->eh_strategy_handler() in
-	 * any kernel, so the default scsi_done() assumes it is
-	 * not being called from the SCSI EH.
-	 */
 	printk(KERN_ERR "ata%u: command timeout\n", ap->id);
-	qc->scsidone = scsi_finish_command;
 	qc->err_mask |= AC_ERR_TIMEOUT;
-	ata_qc_complete(qc);
+	ata_eh_qc_complete(qc);
 
 	sil24_reset_controller(ap);
 }
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 3175c6b..9f992fb 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -872,20 +872,11 @@ static void pdc_eng_timeout(struct ata_p
 		goto out;
 	}
 
-	/* hack alert!  We cannot use the supplied completion
-	 * function from inside the ->eh_strategy_handler() thread.
-	 * libata is the only user of ->eh_strategy_handler() in
-	 * any kernel, so the default scsi_done() assumes it is
-	 * not being called from the SCSI EH.
-	 */
-	qc->scsidone = scsi_finish_command;
-
 	switch (qc->tf.protocol) {
 	case ATA_PROT_DMA:
 	case ATA_PROT_NODATA:
 		printk(KERN_ERR "ata%u: command timeout\n", ap->id);
 		qc->err_mask |= __ac_err_mask(ata_wait_idle(ap));
-		ata_qc_complete(qc);
 		break;
 
 	default:
@@ -895,12 +886,13 @@ static void pdc_eng_timeout(struct ata_p
 		       ap->id, qc->tf.command, drv_stat);
 
 		qc->err_mask |= ac_err_mask(drv_stat);
-		ata_qc_complete(qc);
 		break;
 	}
 
 out:
 	spin_unlock_irqrestore(&host_set->lock, flags);
+	if (qc)
+		ata_eh_qc_complete(qc);
 	DPRINTK("EXIT\n");
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b1ea2f9..576788d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -398,6 +398,7 @@ struct ata_port {
 	unsigned long		pio_task_timeout;
 
 	u32			msg_enable;
+	struct list_head	eh_done_q;
 
 	void			*private_data;
 };
@@ -490,6 +491,8 @@ extern int ata_scsi_detect(struct scsi_h
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
 extern int ata_scsi_error(struct Scsi_Host *host);
+extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
+extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 extern int ata_scsi_device_resume(struct scsi_device *);
-- 
1.0.8


