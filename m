From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/12] libata: ignore normal qc completion during EH
Date: Sun, 22 Jan 2006 16:58:31 +0900
Message-ID: <11379167111733-git-send-email-htejun@gmail.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.192]:53419 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751255AbWAVH6k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:58:40 -0500
Received: by xproxy.gmail.com with SMTP id i30so503821wxd
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:58:39 -0800 (PST)
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Don't let interrupt handler and pio task complete qc's while EH is in
progress.  This makes sure that qc's don't go away underneath EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   32 +++++++++++++++++++-------------
 drivers/scsi/libata-scsi.c |    2 +-
 drivers/scsi/libata.h      |    1 +
 3 files changed, 21 insertions(+), 14 deletions(-)

c72a043f83d46dd4b90a9f689beb5ed9b135fc3a
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b2f51bb..9556100 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3589,19 +3589,7 @@ void ata_qc_free(struct ata_queued_cmd *
 	}
 }
 
-/**
- *	ata_qc_complete - Complete an active ATA command
- *	@qc: Command to complete
- *	@err_mask: ATA Status register contents
- *
- *	Indicate to the mid and upper layers that an ATA
- *	command has completed, with either an ok or not-ok status.
- *
- *	LOCKING:
- *	spin_lock_irqsave(host_set lock)
- */
-
-void ata_qc_complete(struct ata_queued_cmd *qc)
+void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
@@ -3619,6 +3607,24 @@ void ata_qc_complete(struct ata_queued_c
 	qc->complete_fn(qc);
 }
 
+/**
+ *	ata_qc_complete - Complete an active ATA command
+ *	@qc: Command to complete
+ *	@err_mask: ATA Status register contents
+ *
+ *	Indicate to the mid and upper layers that an ATA
+ *	command has completed, with either an ok or not-ok status.
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host_set lock)
+ */
+
+void ata_qc_complete(struct ata_queued_cmd *qc)
+{
+	if (!(qc->ap->flags & ATA_FLAG_IN_EH))
+		__ata_qc_complete(qc);
+}
+
 static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index cf54536..9e4bc3c 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -801,7 +801,7 @@ static void __ata_eh_qc_complete(struct 
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 	qc->scsidone = ata_eh_scsidone;
-	ata_qc_complete(qc);
+	__ata_qc_complete(qc);
 	assert(!ata_tag_valid(qc->tag));
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 9d76923..1cd071a 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -46,6 +46,7 @@ extern struct ata_queued_cmd *ata_qc_new
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
 extern unsigned int ata_qc_issue(struct ata_queued_cmd *qc);
+extern void __ata_qc_complete(struct ata_queued_cmd *qc);
 extern int ata_check_atapi_dma(struct ata_queued_cmd *qc);
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
-- 
1.0.8


