From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/14] libata-eh: implement ata_eh_determine_qc()
Date: Tue, 11 Apr 2006 22:48:22 +0900
Message-ID: <11447633023845-git-send-email-htejun@gmail.com>
References: <11447633013561-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.229]:11678 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750956AbWDKNsa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:48:30 -0400
Received: by wproxy.gmail.com with SMTP id i11so926519wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:48:30 -0700 (PDT)
In-Reply-To: <11447633013561-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement EH helper ata_eh_determine_qc().  This function determines
which is the offending qc and loads TF registers for the qc.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-eh.c   |   24 ++++++++++++++++++++++++
 include/linux/libata.h     |    2 ++
 3 files changed, 27 insertions(+), 0 deletions(-)

96065c0f71d63ac4bb80855a432b2c435db73765
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 13954f6..a4456bd 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5342,3 +5342,4 @@ EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_eh_schedule_port);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
+EXPORT_SYMBOL_GPL(ata_eh_determine_qc);
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 7ef2b78..8a1a4c7 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -558,3 +558,27 @@ static unsigned int atapi_eh_request_sen
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
index 9447bd2..6376379 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -688,6 +688,8 @@ extern void ata_eng_timeout(struct ata_p
 extern void ata_eh_schedule_port(struct ata_port *ap, unsigned int flags);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
+extern struct ata_queued_cmd * ata_eh_determine_qc(struct ata_port *ap,
+						   struct ata_taskfile *tf);
 
 
 static inline int
-- 
1.2.4


