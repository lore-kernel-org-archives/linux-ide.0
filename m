From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/14] libata: separate out libata-eh.c
Date: Sat, 1 Apr 2006 19:48:37 +0900
Message-ID: <11438885173694-git-send-email-htejun@gmail.com>
References: <11438885151530-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:39690 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751504AbWDAKst (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:48:49 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210249nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:48:49 -0800 (PST)
In-Reply-To: <11438885151530-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

A lot of EH codes are about to be added to libata.  Separate out
libata-eh.c.  ata_scsi_timed_out(), ata_scsi_error(),
ata_qc_timeout(), ata_eng_timeout(), ata_eh_qc_complete() and
ata_eh_qc_retry() are moved.  No code is changed by this patch.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/Makefile      |    2 
 drivers/scsi/libata-core.c |  102 +----------------
 drivers/scsi/libata-eh.c   |  264 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-scsi.c |  130 ----------------------
 drivers/scsi/libata.h      |    4 +
 include/linux/libata.h     |   12 +-
 6 files changed, 281 insertions(+), 233 deletions(-)
 create mode 100644 drivers/scsi/libata-eh.c

b573806bbddcc9467450b7b91ce0b31236fc871c
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index e513c31..503f189 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -165,7 +165,7 @@ ncr53c8xx-flags-$(CONFIG_SCSI_ZALON) \
 CFLAGS_ncr53c8xx.o	:= $(ncr53c8xx-flags-y) $(ncr53c8xx-flags-m)
 zalon7xx-objs	:= zalon.o ncr53c8xx.o
 NCR_Q720_mod-objs	:= NCR_Q720.o ncr53c8xx.o
-libata-objs	:= libata-core.o libata-scsi.o libata-bmdma.o
+libata-objs	:= libata-core.o libata-scsi.o libata-bmdma.o libata-eh.o
 oktagon_esp_mod-objs	:= oktagon_esp.o oktagon_io.o
 
 # Files generated that shall be removed upon make clean
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 4c9aa75..c893129 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4005,99 +4005,6 @@ err_out:
 }
 
 /**
- *	ata_qc_timeout - Handle timeout of queued command
- *	@qc: Command that timed out
- *
- *	Some part of the kernel (currently, only the SCSI layer)
- *	has noticed that the active command on port @ap has not
- *	completed after a specified length of time.  Handle this
- *	condition by disabling DMA (if necessary) and completing
- *	transactions, with error if necessary.
- *
- *	This also handles the case of the "lost interrupt", where
- *	for some reason (possibly hardware bug, possibly driver bug)
- *	an interrupt was not delivered to the driver, even though the
- *	transaction completed successfully.
- *
- *	LOCKING:
- *	Inherited from SCSI layer (none, can sleep)
- */
-
-static void ata_qc_timeout(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct ata_host_set *host_set = ap->host_set;
-	u8 host_stat = 0, drv_stat;
-	unsigned long flags;
-
-	DPRINTK("ENTER\n");
-
-	ap->hsm_task_state = HSM_ST_IDLE;
-
-	spin_lock_irqsave(&host_set->lock, flags);
-
-	switch (qc->tf.protocol) {
-
-	case ATA_PROT_DMA:
-	case ATA_PROT_ATAPI_DMA:
-		host_stat = ap->ops->bmdma_status(ap);
-
-		/* before we do anything else, clear DMA-Start bit */
-		ap->ops->bmdma_stop(qc);
-
-		/* fall through */
-
-	default:
-		ata_altstatus(ap);
-		drv_stat = ata_chk_status(ap);
-
-		/* ack bmdma irq events */
-		ap->ops->irq_clear(ap);
-
-		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
-		       ap->id, qc->tf.command, drv_stat, host_stat);
-
-		/* complete taskfile transaction */
-		qc->err_mask |= ac_err_mask(drv_stat);
-		break;
-	}
-
-	spin_unlock_irqrestore(&host_set->lock, flags);
-
-	ata_eh_qc_complete(qc);
-
-	DPRINTK("EXIT\n");
-}
-
-/**
- *	ata_eng_timeout - Handle timeout of queued command
- *	@ap: Port on which timed-out command is active
- *
- *	Some part of the kernel (currently, only the SCSI layer)
- *	has noticed that the active command on port @ap has not
- *	completed after a specified length of time.  Handle this
- *	condition by disabling DMA (if necessary) and completing
- *	transactions, with error if necessary.
- *
- *	This also handles the case of the "lost interrupt", where
- *	for some reason (possibly hardware bug, possibly driver bug)
- *	an interrupt was not delivered to the driver, even though the
- *	transaction completed successfully.
- *
- *	LOCKING:
- *	Inherited from SCSI layer (none, can sleep)
- */
-
-void ata_eng_timeout(struct ata_port *ap)
-{
-	DPRINTK("ENTER\n");
-
-	ata_qc_timeout(ata_qc_from_tag(ap, ap->active_tag));
-
-	DPRINTK("EXIT\n");
-}
-
-/**
  *	ata_qc_new - Request an available ATA command, for queueing
  *	@ap: Port associated with device @dev
  *	@dev: Device from whom we request an available command structure
@@ -5134,7 +5041,6 @@ EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
 EXPORT_SYMBOL_GPL(__ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
-EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_tf_load);
 EXPORT_SYMBOL_GPL(ata_tf_read);
 EXPORT_SYMBOL_GPL(ata_noop_dev_select);
@@ -5174,15 +5080,12 @@ EXPORT_SYMBOL_GPL(ata_busy_sleep);
 EXPORT_SYMBOL_GPL(ata_port_queue_task);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
-EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_scsi_slave_config);
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
-EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
-EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 
 EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
 EXPORT_SYMBOL_GPL(ata_timing_compute);
@@ -5204,3 +5107,8 @@ EXPORT_SYMBOL_GPL(ata_device_suspend);
 EXPORT_SYMBOL_GPL(ata_device_resume);
 EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
 EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
+
+EXPORT_SYMBOL_GPL(ata_scsi_error);
+EXPORT_SYMBOL_GPL(ata_eng_timeout);
+EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
+EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
new file mode 100644
index 0000000..e73f561
--- /dev/null
+++ b/drivers/scsi/libata-eh.c
@@ -0,0 +1,264 @@
+/*
+ *  libata-eh.c - libata error handling
+ *
+ *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>
+ *    		    Please ALWAYS copy linux-ide@vger.kernel.org
+ *		    on emails.
+ *
+ *  Copyright 2006 Tejun Heo <htejun@gmail.com>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License as
+ *  published by the Free Software Foundation; either version 2, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
+ *  USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware documentation available from http://www.t13.org/ and
+ *  http://www.sata-io.org/
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <scsi/scsi.h>
+#include <scsi/scsi_host.h>
+#include <scsi/scsi_eh.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_cmnd.h>
+
+#include <linux/libata.h>
+
+#include "libata.h"
+
+/**
+ *	ata_scsi_timed_out - SCSI layer time out callback
+ *	@cmd: timed out SCSI command
+ *
+ *	Handles SCSI layer timeout.  We race with normal completion of
+ *	the qc for @cmd.  If the qc is already gone, we lose and let
+ *	the scsi command finish (EH_HANDLED).  Otherwise, the qc has
+ *	timed out and EH should be invoked.  Prevent ata_qc_complete()
+ *	from finishing it by setting EH_SCHEDULED and return
+ *	EH_NOT_HANDLED.
+ *
+ *	LOCKING:
+ *	Called from timer context
+ *
+ *	RETURNS:
+ *	EH_HANDLED or EH_NOT_HANDLED
+ */
+enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd)
+{
+	struct Scsi_Host *host = cmd->device->host;
+	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
+	unsigned long flags;
+	struct ata_queued_cmd *qc;
+	enum scsi_eh_timer_return ret = EH_HANDLED;
+
+	DPRINTK("ENTER\n");
+
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	if (qc) {
+		WARN_ON(qc->scsicmd != cmd);
+		qc->flags |= ATA_QCFLAG_EH_SCHEDULED;
+		qc->err_mask |= AC_ERR_TIMEOUT;
+		ret = EH_NOT_HANDLED;
+	}
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	DPRINTK("EXIT, ret=%d\n", ret);
+	return ret;
+}
+
+/**
+ *	ata_scsi_error - SCSI layer error handler callback
+ *	@host: SCSI host on which error occurred
+ *
+ *	Handles SCSI-layer-thrown error events.
+ *
+ *	LOCKING:
+ *	Inherited from SCSI layer (none, can sleep)
+ *
+ *	RETURNS:
+ *	Zero.
+ */
+int ata_scsi_error(struct Scsi_Host *host)
+{
+	struct ata_port *ap = (struct ata_port *)&host->hostdata[0];
+
+	DPRINTK("ENTER\n");
+
+	/* synchronize with IRQ handler and port task */
+	spin_unlock_wait(&ap->host_set->lock);
+	ata_port_flush_task(ap);
+
+	WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
+
+	ap->ops->eng_timeout(ap);
+
+	WARN_ON(host->host_failed || !list_empty(&host->eh_cmd_q));
+
+	scsi_eh_flush_done_q(&ap->eh_done_q);
+
+	DPRINTK("EXIT\n");
+	return 0;
+}
+
+/**
+ *	ata_qc_timeout - Handle timeout of queued command
+ *	@qc: Command that timed out
+ *
+ *	Some part of the kernel (currently, only the SCSI layer)
+ *	has noticed that the active command on port @ap has not
+ *	completed after a specified length of time.  Handle this
+ *	condition by disabling DMA (if necessary) and completing
+ *	transactions, with error if necessary.
+ *
+ *	This also handles the case of the "lost interrupt", where
+ *	for some reason (possibly hardware bug, possibly driver bug)
+ *	an interrupt was not delivered to the driver, even though the
+ *	transaction completed successfully.
+ *
+ *	LOCKING:
+ *	Inherited from SCSI layer (none, can sleep)
+ */
+static void ata_qc_timeout(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct ata_host_set *host_set = ap->host_set;
+	u8 host_stat = 0, drv_stat;
+	unsigned long flags;
+
+	DPRINTK("ENTER\n");
+
+	ap->hsm_task_state = HSM_ST_IDLE;
+
+	spin_lock_irqsave(&host_set->lock, flags);
+
+	switch (qc->tf.protocol) {
+
+	case ATA_PROT_DMA:
+	case ATA_PROT_ATAPI_DMA:
+		host_stat = ap->ops->bmdma_status(ap);
+
+		/* before we do anything else, clear DMA-Start bit */
+		ap->ops->bmdma_stop(qc);
+
+		/* fall through */
+
+	default:
+		ata_altstatus(ap);
+		drv_stat = ata_chk_status(ap);
+
+		/* ack bmdma irq events */
+		ap->ops->irq_clear(ap);
+
+		printk(KERN_ERR "ata%u: command 0x%x timeout, stat 0x%x host_stat 0x%x\n",
+		       ap->id, qc->tf.command, drv_stat, host_stat);
+
+		/* complete taskfile transaction */
+		qc->err_mask |= ac_err_mask(drv_stat);
+		break;
+	}
+
+	spin_unlock_irqrestore(&host_set->lock, flags);
+
+	ata_eh_qc_complete(qc);
+
+	DPRINTK("EXIT\n");
+}
+
+/**
+ *	ata_eng_timeout - Handle timeout of queued command
+ *	@ap: Port on which timed-out command is active
+ *
+ *	Some part of the kernel (currently, only the SCSI layer)
+ *	has noticed that the active command on port @ap has not
+ *	completed after a specified length of time.  Handle this
+ *	condition by disabling DMA (if necessary) and completing
+ *	transactions, with error if necessary.
+ *
+ *	This also handles the case of the "lost interrupt", where
+ *	for some reason (possibly hardware bug, possibly driver bug)
+ *	an interrupt was not delivered to the driver, even though the
+ *	transaction completed successfully.
+ *
+ *	LOCKING:
+ *	Inherited from SCSI layer (none, can sleep)
+ */
+void ata_eng_timeout(struct ata_port *ap)
+{
+	DPRINTK("ENTER\n");
+
+	ata_qc_timeout(ata_qc_from_tag(ap, ap->active_tag));
+
+	DPRINTK("EXIT\n");
+}
+
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
+	__ata_qc_complete(qc);
+	WARN_ON(ata_tag_valid(qc->tag));
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
+ *	scmd->retries is decremented for commands which get retried
+ *	due to unrelated failures (qc->err_mask is zero).
+ */
+void ata_eh_qc_retry(struct ata_queued_cmd *qc)
+{
+	struct scsi_cmnd *scmd = qc->scsicmd;
+	if (!qc->err_mask && scmd->retries)
+		scmd->retries--;
+	__ata_eh_qc_complete(qc);
+}
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 4400815..745fc26 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -53,7 +53,6 @@
 typedef unsigned int (*ata_xlat_func_t)(struct ata_queued_cmd *qc, const u8 *scsicmd);
 static struct ata_device *
 ata_scsi_find_dev(struct ata_port *ap, const struct scsi_device *scsidev);
-enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 
 #define RW_RECOVERY_MPAGE 0x1
 #define RW_RECOVERY_MPAGE_LEN 12
@@ -714,135 +713,6 @@ int ata_scsi_slave_config(struct scsi_de
 }
 
 /**
- *	ata_scsi_timed_out - SCSI layer time out callback
- *	@cmd: timed out SCSI command
- *
- *	Handles SCSI layer timeout.  We race with normal completion of
- *	the qc for @cmd.  If the qc is already gone, we lose and let
- *	the scsi command finish (EH_HANDLED).  Otherwise, the qc has
- *	timed out and EH should be invoked.  Prevent ata_qc_complete()
- *	from finishing it by setting EH_SCHEDULED and return
- *	EH_NOT_HANDLED.
- *
- *	LOCKING:
- *	Called from timer context
- *
- *	RETURNS:
- *	EH_HANDLED or EH_NOT_HANDLED
- */
-enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd)
-{
-	struct Scsi_Host *host = cmd->device->host;
-	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
-	unsigned long flags;
-	struct ata_queued_cmd *qc;
-	enum scsi_eh_timer_return ret = EH_HANDLED;
-
-	DPRINTK("ENTER\n");
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (qc) {
-		WARN_ON(qc->scsicmd != cmd);
-		qc->flags |= ATA_QCFLAG_EH_SCHEDULED;
-		qc->err_mask |= AC_ERR_TIMEOUT;
-		ret = EH_NOT_HANDLED;
-	}
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	DPRINTK("EXIT, ret=%d\n", ret);
-	return ret;
-}
-
-/**
- *	ata_scsi_error - SCSI layer error handler callback
- *	@host: SCSI host on which error occurred
- *
- *	Handles SCSI-layer-thrown error events.
- *
- *	LOCKING:
- *	Inherited from SCSI layer (none, can sleep)
- *
- *	RETURNS:
- *	Zero.
- */
-
-int ata_scsi_error(struct Scsi_Host *host)
-{
-	struct ata_port *ap = (struct ata_port *)&host->hostdata[0];
-
-	DPRINTK("ENTER\n");
-
-	/* synchronize with IRQ handler and port task */
-	spin_unlock_wait(&ap->host_set->lock);
-	ata_port_flush_task(ap);
-
-	WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
-
-	ap->ops->eng_timeout(ap);
-
-	WARN_ON(host->host_failed || !list_empty(&host->eh_cmd_q));
-
-	scsi_eh_flush_done_q(&ap->eh_done_q);
-
-	DPRINTK("EXIT\n");
-	return 0;
-}
-
-static void ata_eh_scsidone(struct scsi_cmnd *scmd)
-{
-	/* nada */
-}
-
-static void __ata_eh_qc_complete(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct scsi_cmnd *scmd = qc->scsicmd;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-	qc->scsidone = ata_eh_scsidone;
-	__ata_qc_complete(qc);
-	WARN_ON(ata_tag_valid(qc->tag));
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-
-	scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
-}
-
-/**
- *	ata_eh_qc_complete - Complete an active ATA command from EH
- *	@qc: Command to complete
- *
- *	Indicate to the mid and upper layers that an ATA command has
- *	completed.  To be used from EH.
- */
-void ata_eh_qc_complete(struct ata_queued_cmd *qc)
-{
-	struct scsi_cmnd *scmd = qc->scsicmd;
-	scmd->retries = scmd->allowed;
-	__ata_eh_qc_complete(qc);
-}
-
-/**
- *	ata_eh_qc_retry - Tell midlayer to retry an ATA command after EH
- *	@qc: Command to retry
- *
- *	Indicate to the mid and upper layers that an ATA command
- *	should be retried.  To be used from EH.
- *
- *	SCSI midlayer limits the number of retries to scmd->allowed.
- *	scmd->retries is decremented for commands which get retried
- *	due to unrelated failures (qc->err_mask is zero).
- */
-void ata_eh_qc_retry(struct ata_queued_cmd *qc)
-{
-	struct scsi_cmnd *scmd = qc->scsicmd;
-	if (!qc->err_mask && scmd->retries)
-		scmd->retries--;
-	__ata_eh_qc_complete(qc);
-}
-
-/**
  *	ata_scsi_start_stop_xlat - Translate SCSI START STOP UNIT command
  *	@qc: Storage for translated ATA taskfile
  *	@scsicmd: SCSI command to translate
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 1c755b1..75e9bd5 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -60,7 +60,6 @@ extern int ata_cmd_ioctl(struct scsi_dev
 extern struct scsi_transport_template ata_scsi_transport_template;
 
 extern void ata_scsi_scan_host(struct ata_port *ap);
-extern int ata_scsi_error(struct Scsi_Host *host);
 extern unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf,
 			       unsigned int buflen);
 
@@ -90,4 +89,7 @@ extern void ata_scsi_rbuf_fill(struct at
                         unsigned int (*actor) (struct ata_scsi_args *args,
                                            u8 *rbuf, unsigned int buflen));
 
+/* libata-eh.c */
+extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
+
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1f9e6ea..7162f05 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -533,9 +533,6 @@ extern void ata_host_set_remove(struct a
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
-extern int ata_scsi_error(struct Scsi_Host *host);
-extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
-extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 extern int ata_scsi_device_resume(struct scsi_device *);
@@ -584,7 +581,6 @@ extern void ata_bmdma_stop(struct ata_qu
 extern u8   ata_bmdma_status(struct ata_port *ap);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void __ata_qc_complete(struct ata_queued_cmd *qc);
-extern void ata_eng_timeout(struct ata_port *ap);
 extern void ata_scsi_simulate(struct ata_port *ap, struct ata_device *dev,
 			      struct scsi_cmnd *cmd,
 			      void (*done)(struct scsi_cmnd *));
@@ -639,6 +635,14 @@ extern int pci_test_config_bits(struct p
 extern unsigned long ata_pci_default_filter(const struct ata_port *, struct ata_device *, unsigned long);
 #endif /* CONFIG_PCI */
 
+/*
+ * EH
+ */
+extern int ata_scsi_error(struct Scsi_Host *host);
+extern void ata_eng_timeout(struct ata_port *ap);
+extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
+extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
+
 
 static inline int
 ata_sg_is_last(struct scatterlist *sg, struct ata_queued_cmd *qc)
-- 
1.2.4


