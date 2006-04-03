From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/13] libata: implement ata_eh_finish_qcs()
Date: Mon, 3 Apr 2006 12:44:39 +0900
Message-ID: <11440358792537-git-send-email-htejun@gmail.com>
References: <11440358783861-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:43706 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932219AbWDCDos (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 23:44:48 -0400
Received: by zproxy.gmail.com with SMTP id o37so1665771nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 20:44:47 -0700 (PDT)
In-Reply-To: <11440358783861-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement EH helper function ata_eh_finish_qcs().  This function is
called after all EH actions are complete and finishes all the failed
qcs.  Depending on error status, a qc may be retried or completed.
This function is also responsible for loading qc->tf with resulting TF
values.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |   45 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    2 ++
 3 files changed, 48 insertions(+), 0 deletions(-)

82204946494cd4749cd83431dd141560f33969c6
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 62dabb1..f3ab396 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5283,3 +5283,4 @@ EXPORT_SYMBOL_GPL(ata_eh_determine_qc);
 EXPORT_SYMBOL_GPL(ata_eh_autopsy);
 EXPORT_SYMBOL_GPL(ata_eh_report);
 EXPORT_SYMBOL_GPL(ata_eh_revive);
+EXPORT_SYMBOL_GPL(ata_eh_finish_qcs);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 3fc3f0f..80d1282 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1029,3 +1029,48 @@ int ata_eh_revive(struct ata_port *ap, u
 
 	return rc;
 }
+
+/**
+ *	ata_eh_finish_qcs - complete or retry commands
+ *	@ap: host port to finish qc's for
+ *	@qc: the failed qc (can be NULL)
+ *	@tf: taskfile register of the failed qc
+ *
+ *	Retry or complete failed qc's.
+ *
+ *	LOCKING:
+ *	None.
+ */
+void ata_eh_finish_qcs(struct ata_port *ap, struct ata_queued_cmd *qc,
+		       struct ata_taskfile *tf)
+{
+	struct ata_taskfile tmp_tf;
+
+	if (qc) {
+		/* prevent infinite retry loop */
+		if (!qc->err_mask && !(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
+			printk(KERN_WARNING "ata%u: dev %u qc has no error "
+			       "flag set after EH, forcing AC_ERR_OTHER\n",
+			       ap->id, qc->dev->devno);
+			qc->err_mask |= AC_ERR_OTHER;
+		}
+
+		/* FIXME: qc->tf will be used by completion callbacks
+		 * to generate SCSI sense data.  This is to share
+		 * sense generation code with old-EH drivers.  Once EH
+		 * migration is complete, generate sense data in this
+		 * function, considering both err_mask and tf.
+		 */
+		tmp_tf = *tf;
+		tmp_tf.flags = qc->tf.flags;
+		tmp_tf.protocol = qc->tf.protocol;
+		tmp_tf.ctl = qc->tf.ctl;
+		qc->tf = tmp_tf;
+
+		if (qc->err_mask & AC_ERR_INVALID ||
+		    qc->flags & ATA_QCFLAG_SENSE_VALID)
+			ata_eh_qc_complete(qc);
+		else
+			ata_eh_qc_retry(qc);
+	}
+}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ed28a1d..f3f53ad 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -696,6 +696,8 @@ extern void ata_eh_report(struct ata_por
 extern int ata_eh_revive(struct ata_port *ap, unsigned int action,
 			 ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			 ata_postreset_fn_t postreset);
+extern void ata_eh_finish_qcs(struct ata_port *ap, struct ata_queued_cmd *qc,
+			      struct ata_taskfile *tf);
 
 
 static inline int
-- 
1.2.4


