From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/13] libata: implement ata_eh_report()
Date: Mon, 3 Apr 2006 12:44:39 +0900
Message-ID: <11440358791370-git-send-email-htejun@gmail.com>
References: <11440358783861-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:44129 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932271AbWDCDor (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 23:44:47 -0400
Received: by zproxy.gmail.com with SMTP id o37so1665768nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 20:44:47 -0700 (PDT)
In-Reply-To: <11440358783861-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
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

2480239bcc13b4fa02bdfc5b70140cf4d46a50ff
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ea5335b..dbf6815 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5281,3 +5281,4 @@ EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 EXPORT_SYMBOL_GPL(ata_eh_determine_qc);
 EXPORT_SYMBOL_GPL(ata_eh_autopsy);
+EXPORT_SYMBOL_GPL(ata_eh_report);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 5224fe4..7b8b2d8 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -830,3 +830,53 @@ unsigned int ata_eh_autopsy(struct ata_p
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
index f65bde5..437c5ad 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -689,6 +689,9 @@ extern struct ata_queued_cmd * ata_eh_de
 extern unsigned int ata_eh_autopsy(struct ata_port *ap,
 				   struct ata_queued_cmd *qc,
 				   const struct ata_taskfile *tf, u32 serror);
+extern void ata_eh_report(struct ata_port *ap, struct ata_queued_cmd *qc,
+			  const struct ata_taskfile *tf, u32 serror,
+			  unsigned int action, const char *desc);
 
 
 static inline int
-- 
1.2.4


