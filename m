From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/14] libata-eh: implement ata_eh_report()
Date: Tue, 11 Apr 2006 22:48:22 +0900
Message-ID: <11447633023434-git-send-email-htejun@gmail.com>
References: <11447633013561-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:52338 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750938AbWDKNs2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:48:28 -0400
Received: by pproxy.gmail.com with SMTP id i49so1386943pye
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:48:27 -0700 (PDT)
In-Reply-To: <11447633013561-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement EH helper function ata_eh_report().  This function reports
to user which command caused what kind of error on which device.
Detailed EH status is also printed to help tracking down the problem.
LLDDs may supply LLDD specific message to ata_eh_report().  It will
format them and print it together with other error information.

Using this function standardizes error messages over different drivers
helping both the users and developers.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |   50 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h     |    3 +++
 3 files changed, 54 insertions(+), 0 deletions(-)

90078477b8c496028712d0f55a955e4615d8e9d9
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6b7f30d..e724a76 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5344,3 +5344,4 @@ EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_eh_determine_qc);
 EXPORT_SYMBOL_GPL(ata_eh_autopsy);
+EXPORT_SYMBOL_GPL(ata_eh_report);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 103ef28..eebb165 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -868,3 +868,53 @@ unsigned int ata_eh_autopsy(struct ata_p
 	return action;
 }
 
+/**
+ *	ata_eh_report - report error handling to user
+ *	@ap: host port EH is going on
+ *	@qc: failed qc (could be NULL)
+ *	@tf: current taskfile register values
+ *	@serror: SError register value
+ *	@action: determined recovery action
+ *	@desc: extra description
+ *
+ *	Report EH to user.
+ *
+ *	LOCKING:
+ *	None.
+ */
+void ata_eh_report(struct ata_port *ap, struct ata_queued_cmd *qc,
+		   const struct ata_taskfile *tf, u32 serror,
+		   unsigned int action, const char *desc)
+{
+	const char *desc_head, *desc_tail;
+
+	if (desc && desc[0] != '\0') {
+		desc_head = "      (";
+		desc_tail = ")\n";
+	} else {
+		desc_head = "";
+		desc = "";
+		desc_tail = "";
+	}
+
+	if (!qc) {
+		printk(KERN_ERR
+		       "ata%u: stat 0x%x err 0x%x SError 0x%x action 0x%x\n"
+		       "%s%s%s",
+		       ap->id, tf->command, tf->feature, serror,
+		       action, desc_head, desc, desc_tail);
+		return;
+	}
+
+	if (!qc->err_mask)
+		return;
+
+	printk(KERN_ERR
+	       "ata%u: dev %u command 0x%x tag %u failed with %s\n"
+	       "      Emask 0x%x stat 0x%x err 0x%x SErr 0x%x action 0x%x\n"
+	       "%s%s%s",
+	       ap->id, qc->dev->devno, qc->tf.command, qc->tag,
+	       ata_err_string(qc->err_mask), qc->err_mask,
+	       tf->command, tf->feature, serror, action,
+	       desc_head, desc, desc_tail);
+}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d7a51f3..5efadab 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -693,6 +693,9 @@ extern struct ata_queued_cmd * ata_eh_de
 extern unsigned int ata_eh_autopsy(struct ata_port *ap,
 				   struct ata_queued_cmd *qc,
 				   const struct ata_taskfile *tf, u32 serror);
+extern void ata_eh_report(struct ata_port *ap, struct ata_queued_cmd *qc,
+			  const struct ata_taskfile *tf, u32 serror,
+			  unsigned int action, const char *desc);
 
 
 static inline int
-- 
1.2.4


