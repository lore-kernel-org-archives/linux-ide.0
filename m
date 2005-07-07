From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:ncq 06/11] libata: implement generic NCQ helpers
Date: Thu,  7 Jul 2005 22:09:43 +0900 (KST)
Message-ID: <20050707130840.1C8B6E03@htj.dyndns.org>
References: <20050707130840.5046338C@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.201]:25638 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261484AbVGGNJv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2005 09:09:51 -0400
Received: by rproxy.gmail.com with SMTP id a36so160039rnf
        for <linux-ide@vger.kernel.org>; Thu, 07 Jul 2005 06:09:48 -0700 (PDT)
In-Reply-To: <20050707130840.5046338C@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, axboe@suse.de, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

06_libata_implement-ncq-helpers.patch

	This patch implements generic NCQ completion/error-handling
	helpers.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 drivers/scsi/libata-core.c |  237 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    3 
 2 files changed, 240 insertions(+)

Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h	2005-07-07 22:08:36.000000000 +0900
+++ work/include/linux/libata.h	2005-07-07 22:08:36.000000000 +0900
@@ -463,6 +463,9 @@ extern int ata_read_log_page(struct ata_
 			     unsigned int);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
+extern int ata_ncq_complete(struct ata_port *ap);
+extern int ata_ncq_error(struct ata_port *ap);
+extern void ata_ncq_recover(struct ata_port *ap, int did_reset);
 
 
 #ifdef CONFIG_PCI
Index: work/drivers/scsi/libata-core.c
===================================================================
--- work.orig/drivers/scsi/libata-core.c	2005-07-07 22:08:36.000000000 +0900
+++ work/drivers/scsi/libata-core.c	2005-07-07 22:08:36.000000000 +0900
@@ -49,6 +49,10 @@
 
 #include "libata.h"
 
+#define ata_for_each_tag(tag, mask) \
+	for (tag = find_first_bit(&mask, ATA_MAX_CMDS); tag < ATA_MAX_CMDS; \
+	     tag = find_next_bit(&mask, ATA_MAX_CMDS, tag + 1))
+
 static unsigned int ata_busy_sleep (struct ata_port *ap,
 				    unsigned long tmout_pat,
 			    	    unsigned long tmout);
@@ -3861,6 +3865,236 @@ irqreturn_t ata_interrupt (int irq, void
 	return IRQ_RETVAL(handled);
 }
 
+/*
+ * NCQ helpers
+ */
+
+/**
+ *     ata_ncq_complete - NCQ driver helper.  Complete requests normally.
+ *     @ap: port in question
+ *
+ *     Complete in-flight commands.  One device per port is assumed.
+ *     This functions is meant to be called from specific driver's
+ *     interrupt routine to complete requests normally.  On
+ *     invocation, if non-NCQ command was in-flight, it's completed
+ *     normally.  If NCQ commands were in-flight, Sactive register is
+ *     read and completed commands are processed.
+ *
+ *     LOCKING:
+ *     spin_lock_irqsave(host_set lock)
+ */
+int ata_ncq_complete(struct ata_port *ap)
+{
+	int nr_done = 0;
+	unsigned long done_mask = 0;
+	unsigned tag;
+
+	/*
+	 * ap->active_tag test should come before ap->sactive test to
+	 * complete EH requests.
+	 */
+	if (ap->active_tag != ATA_TAG_POISON)
+		done_mask = 1 << ap->active_tag;
+	else if (ap->sactive) {
+		unsigned long new_sactive = scr_read(ap, SCR_ACTIVE);
+		done_mask = new_sactive ^ ap->sactive;
+
+		if (unlikely(done_mask & new_sactive)) {
+			printk(KERN_ERR "ata%u: illegal sactive transition (%08lx->%08lx)\n",
+			       ap->id, ap->sactive, new_sactive);
+			done_mask &= ~new_sactive;
+		}
+	}
+
+	ata_for_each_tag(tag, done_mask) {
+		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
+		assert(qc);
+		ata_qc_complete(qc);
+		nr_done++;
+	}
+
+	return nr_done;
+}
+
+/**
+ *     ata_ncq_error - NCQ driver helper.  Abort commands and invoke EH.
+ *     @ap: port in question.
+ *
+ *     Abort in-flight commands and invoke EH.  This function is
+ *     meant to be called from specific driver's interrupt routine to
+ *     indicate error.
+ *
+ *     LOCKING:
+ *     spin_lock_irqsave(host_set lock)
+ */
+
+int ata_ncq_error(struct ata_port *ap)
+{
+	int nr_aborted = 0;
+	unsigned long sactive = 0;
+	unsigned tag;
+
+	printk(KERN_WARNING "ata%u: aborting commands due to error.  "
+	       "active_tag %d, sactive %08lx\n",
+	       ap->id,
+	       ap->active_tag != ATA_TAG_POISON ? ap->active_tag : -1,
+	       ap->sactive);
+
+	/*
+	 * ap->active_tag test should come before ap->sactive test to
+	 * complete EH requests.
+	 */
+	if (ap->active_tag != ATA_TAG_POISON)
+		sactive = 1 << ap->active_tag;
+	else if (ap->sactive) {
+		/* Complete successful requests before aborting. */
+		ata_ncq_complete(ap);
+		if (!ap->sactive)
+			printk(KERN_WARNING "ata%u: device reports successful "
+			       "completion of all NCQ commands after error\n",
+			       ap->id);
+		sactive = ap->sactive;
+	}
+
+	ata_for_each_tag(tag, sactive) {
+		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
+		assert(qc);
+		ata_qc_error(qc);
+		nr_aborted++;
+	}
+
+	return nr_aborted;
+}
+
+static inline int ata_read_log_10h(struct ata_port *ap, unsigned *tagp,
+				   u8 *drv_statp, u8 *drv_errp)
+{
+	char *buffer;
+	int rc;
+
+	buffer = kmalloc(512, GFP_KERNEL);
+	if (buffer == NULL) {
+		printk(KERN_ERR "ata%u: unable to allocate memory for error\n",
+		       ap->id);
+		return -ENOMEM;
+	}
+
+	rc = ata_read_log_page(ap, 0, READ_LOG_SATA_NCQ_PAGE, buffer, 1);
+	if (rc < 0) {
+		printk(KERN_ERR "ata%u: failed to read log page 10h (%d)\n",
+		       ap->id, rc);
+		goto out;
+	}
+
+	if (buffer[0] & 0x80) {
+		printk(KERN_WARNING "ata%u: NQ bit set on log page 10h\n",
+		       ap->id);
+		rc = -EIO;
+		goto out;
+	}
+
+	*tagp = buffer[0] & 0x1f;
+	*drv_statp = buffer[2] | ATA_ERR;
+	*drv_errp = buffer[3];
+	rc = 0;
+ out:
+	kfree(buffer);
+	return rc;
+}
+
+/**
+ *     ata_ncq_recover - NCQ driver helper.  Recover from error.
+ *     @ap: port in question
+ *     @did_reset: specific driver performed reset.  Log page 10h might
+ *                 be invalid.
+ *
+ *     This function is to be called from eng_timeout routine of
+ *     specific drivers.  Before calling this function, specific
+ *     drivers are required to
+ *
+ *     - Clear all in-flight requests.  Drivers only have to clear
+ *       low-level state (like stopping DMA engine and clearing
+ *       interrupts).  All generic command cancelling are dealt by
+ *       libata-core layer.
+ *
+ *     - Make the controller ready for new commands.
+ *
+ *     LOCKING:
+ *     Inherited from SCSI layer (in EH context, can sleep)
+ */
+void ata_ncq_recover(struct ata_port *ap, int did_reset)
+{
+	unsigned ncq_abort_tag = ATA_TAG_POISON;
+	u8 stat = 0, err = 0;
+	unsigned long sactive;
+	unsigned tag;
+
+	DPRINTK("ENTER\n");
+
+	stat = ata_chk_status(ap);
+	err = ata_chk_err(ap);
+
+	/*
+	 * if commands have timed out or DRQ/BSY is set, device needs
+	 * to be reset.
+	 */
+	if (!(ap->flags & ATA_FLAG_ERROR) || stat & (ATA_BUSY | ATA_DRQ)) {
+		printk(KERN_WARNING "ata%u: stat=%x, issuing COMRESET\n", ap->id, stat);
+		ap->ops->phy_reset(ap);
+		did_reset = 1;
+	}
+
+	if (ap->sactive) {
+		if (ap->flags & ATA_FLAG_ERROR) {
+			u8 tstat, terr;
+			/*
+			 * Regardless of did_reset, we read log page
+			 * 10h.  The drive might need it to restart
+			 * operation.  If did_reset, we ignore the
+			 * result.
+			 */
+			if (ata_read_log_10h(ap, &tag, &tstat, &terr) == 0) {
+				printk(KERN_INFO "ata%u: log_ext_10h, tag=%d "
+				       "stat=%02x err=%02x%s\n",
+				       ap->id, tag, tstat, terr,
+				       did_reset ? " (ignored due to reset)" : "");
+				if (!did_reset) {
+					ncq_abort_tag = tag;
+					stat = tstat;
+					err = terr;
+				}
+			} else {
+				printk(KERN_WARNING "ata%u: resetting...\n",
+				       ap->id);
+				ap->ops->phy_reset(ap);
+			}
+		}
+		sactive = ap->sactive;
+	} else
+		sactive = 1 << ap->active_tag;
+
+	ata_for_each_tag(tag, sactive) {
+		struct ata_queued_cmd *qc = ata_qc_from_tag(ap, tag);
+		assert(qc);
+		if (ncq_abort_tag != ATA_TAG_POISON && tag != ncq_abort_tag) {
+			ata_eh_qc_retry(qc);
+			continue;
+		}
+
+		if (qc->scsicmd) {
+			if (qc->dev->class == ATA_DEV_ATA ||
+			    !(qc->flags & ATA_QCFLAG_ERROR))
+				ata_to_sense_error(qc, stat | ATA_ERR, err);
+			else
+				atapi_request_sense(ap, qc->dev, qc->scsicmd);
+		}
+
+		ata_eh_qc_complete(qc);
+	}
+
+	DPRINTK("EXIT\n");
+}
+
 /**
  *	atapi_packet_task - Write CDB bytes to hardware
  *	@_data: Port to which ATAPI device is attached.
@@ -4719,6 +4953,9 @@ EXPORT_SYMBOL_GPL(ata_scsi_requeue);
 EXPORT_SYMBOL_GPL(ata_read_log_page);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
+EXPORT_SYMBOL_GPL(ata_ncq_complete);
+EXPORT_SYMBOL_GPL(ata_ncq_error);
+EXPORT_SYMBOL_GPL(ata_ncq_recover);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);

