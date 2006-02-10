From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: add ATA_QCFLAG_EH_SCHEDULED
Date: Fri, 10 Feb 2006 15:10:48 +0900
Message-ID: <11395518481365-git-send-email-htejun@gmail.com>
References: <11395518482722-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:51206 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751158AbWBJGKw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Feb 2006 01:10:52 -0500
Received: by zproxy.gmail.com with SMTP id 13so360260nzn
        for <linux-ide@vger.kernel.org>; Thu, 09 Feb 2006 22:10:52 -0800 (PST)
In-Reply-To: <11395518482722-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add ATA_QCFLAG_EH_SCHEDULED.  If this flag is set, the qc is owned by
EH and normal completion path is not allowed to finish it.  This patch
doesn't actually use this flag.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   33 ++++++++++++++++++++-------------
 drivers/scsi/libata-scsi.c |    2 +-
 drivers/scsi/libata.h      |    1 +
 include/linux/libata.h     |    1 +
 4 files changed, 23 insertions(+), 14 deletions(-)

8720412361bfa8a3eb54474c2ceb215ace0a3301
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 22db739..977a53d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3620,19 +3620,7 @@ void ata_qc_free(struct ata_queued_cmd *
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
+inline void __ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	assert(qc != NULL);	/* ata_qc_from_tag _might_ return NULL */
 	assert(qc->flags & ATA_QCFLAG_ACTIVE);
@@ -3650,6 +3638,25 @@ void ata_qc_complete(struct ata_queued_c
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
+void ata_qc_complete(struct ata_queued_cmd *qc)
+{
+	if (unlikely(qc->flags & ATA_QCFLAG_EH_SCHEDULED))
+		return;
+
+	__ata_qc_complete(qc);
+}
+
 static inline int ata_should_dma_map(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index b007bb4..1df468e 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -770,7 +770,7 @@ static void __ata_eh_qc_complete(struct 
 
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 68b3fe6..5c70a57 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -169,6 +169,7 @@ enum {
 	ATA_QCFLAG_SG		= (1 << 3), /* have s/g table? */
 	ATA_QCFLAG_SINGLE	= (1 << 4), /* no s/g, just a single buffer */
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
+	ATA_QCFLAG_EH_SCHEDULED = (1 << 5), /* EH scheduled */
 
 	/* various lengths of time */
 	ATA_TMOUT_EDD		= 5 * HZ,	/* heuristic */
-- 
1.1.5


