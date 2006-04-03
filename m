From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/13] libata: implement ata_eh_determine_qc()
Date: Mon, 3 Apr 2006 12:44:38 +0900
Message-ID: <11440358784190-git-send-email-htejun@gmail.com>
References: <11440358783861-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:36294 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932183AbWDCDor (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 23:44:47 -0400
Received: by zproxy.gmail.com with SMTP id o37so1665767nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 20:44:47 -0700 (PDT)
In-Reply-To: <11440358783861-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement EH helper ata_eh_determine_qc().  This function determines
which is the offending qc and loads TF registers for the qc.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |   24 ++++++++++++++++++++++++
 include/linux/libata.h     |    2 ++
 3 files changed, 27 insertions(+), 0 deletions(-)

3864377b3160cd8523dd6d752b6dd79cc3464967
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e6dec59..06bf7f4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5279,3 +5279,4 @@ EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_eh_schedule_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
+EXPORT_SYMBOL_GPL(ata_eh_determine_qc);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index c4ef2dd..7781f67 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -526,3 +526,27 @@ static unsigned int atapi_eh_request_sen
 	return ata_exec_internal(ap, dev, &tf, cdb, DMA_FROM_DEVICE,
 				 sense_buf, SCSI_SENSE_BUFFERSIZE);
 }
+
+/**
+ *	ata_eh_determine_qc - Determine which qc caused error
+ *	@ap: port which failed
+ *	@tf: resulting taskfile registers of the failed command
+ *
+ *	Determine which qc caused failure and read associated tf
+ *	registers.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	Pointer to the failed qc.
+ */
+struct ata_queued_cmd * ata_eh_determine_qc(struct ata_port *ap,
+					    struct ata_taskfile *tf)
+{
+	memset(tf, 0, sizeof(*tf));
+	ap->ops->tf_read(ap, tf);
+
+	return __ata_qc_from_tag(ap, ap->active_tag);
+}
+
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7eeb023..789dd75 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -684,6 +684,8 @@ extern void ata_eng_timeout(struct ata_p
 extern void ata_eh_schedule_port(struct ata_port *ap, unsigned int flags);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
+extern struct ata_queued_cmd * ata_eh_determine_qc(struct ata_port *ap,
+						   struct ata_taskfile *tf);
 
 
 static inline int
-- 
1.2.4


