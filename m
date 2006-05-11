From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/7] libata-pm-prep: implement qc_defer helpers
Date: Fri, 12 May 2006 01:37:51 +0900
Message-ID: <114736547188-git-send-email-htejun@gmail.com>
References: <11473654703440-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:50067 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030332AbWEKQiD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:38:03 -0400
Received: by wr-out-0506.google.com with SMTP id i12so407147wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:38:02 -0700 (PDT)
In-Reply-To: <11473654703440-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ap->nr_active_links (the number of links with active qcs),
ap->excl_link (pointer to link which can be used by ->qc_defer and is
cleared when a qc with ATA_QCFLAG_CLEAR_EXCL completes), and
ata_link_active().

These can be used by ->qc_defer() to implement proper command
exclusion.  This set of helpers seem enough for both sil24 (ATAPI
exclusion needed) and cmd-switching PM.

---

 drivers/scsi/libata-core.c |   22 +++++++++++++++++++---
 drivers/scsi/libata-eh.c   |    5 +++++
 include/linux/libata.h     |    8 ++++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

7deb1fc49ea4e26d9f1bc4258094086e0bcb27f2
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 5dd5a28..fb64a0f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -994,7 +994,6 @@ void ata_qc_complete_internal(struct ata
  *	LOCKING:
  *	None.  Should be called with kernel context, might sleep.
  */
-
 unsigned ata_exec_internal(struct ata_device *dev,
 			   struct ata_taskfile *tf, const u8 *cdb,
 			   int dma_dir, void *buf, unsigned int buflen)
@@ -1005,6 +1004,7 @@ unsigned ata_exec_internal(struct ata_de
 	struct ata_queued_cmd *qc;
 	unsigned int tag, preempted_tag;
 	u32 preempted_sactive, preempted_qc_active;
+	int preempted_nr_active_links;
 	DECLARE_COMPLETION(wait);
 	unsigned long flags;
 	unsigned int err_mask;
@@ -1043,9 +1043,11 @@ unsigned ata_exec_internal(struct ata_de
 	preempted_tag = link->active_tag;
 	preempted_sactive = link->sactive;
 	preempted_qc_active = ap->qc_active;
+	preempted_nr_active_links = ap->nr_active_links;
 	link->active_tag = ATA_TAG_POISON;
 	link->sactive = 0;
 	ap->qc_active = 0;
+	ap->nr_active_links = 0;
 
 	/* prepare & issue qc */
 	qc->tf = *tf;
@@ -1112,6 +1114,7 @@ unsigned ata_exec_internal(struct ata_de
 	link->active_tag = preempted_tag;
 	link->sactive = preempted_sactive;
 	ap->qc_active = preempted_qc_active;
+	ap->nr_active_links = preempted_nr_active_links;
 
 	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
 	 * Until those drivers are fixed, we detect the condition
@@ -4327,10 +4330,18 @@ void __ata_qc_complete(struct ata_queued
 		ata_sg_clean(qc);
 
 	/* command should be marked inactive atomically with qc completion */
-	if (qc->tf.protocol == ATA_PROT_NCQ)
+	if (qc->tf.protocol == ATA_PROT_NCQ) {
 		link->sactive &= ~(1 << qc->tag);
-	else
+		if (!link->sactive)
+			ap->nr_active_links--;
+	} else {
 		link->active_tag = ATA_TAG_POISON;
+		ap->nr_active_links--;
+	}
+
+	/* clear exclusive status */
+	if (unlikely(qc->flags & ATA_QCFLAG_CLEAR_EXCL))
+		ap->excl_link = NULL;
 
 	/* atapi: mark qc as inactive to prevent the interrupt handler
 	 * from completing the command twice later, before the error handler
@@ -4503,9 +4514,14 @@ void ata_qc_issue(struct ata_queued_cmd 
 
 	if (qc->tf.protocol == ATA_PROT_NCQ) {
 		WARN_ON(link->sactive & (1 << qc->tag));
+
+		if (!link->sactive)
+			ap->nr_active_links++;
 		link->sactive |= 1 << qc->tag;
 	} else {
 		WARN_ON(link->sactive);
+
+		ap->nr_active_links++;
 		link->active_tag = qc->tag;
 	}
 
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 3764e21..ffbd028 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -248,6 +248,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 		}
 
 		ap->flags &= ~ATA_FLAG_EH_PENDING;
+		ap->excl_link = NULL;	/* don't maintain exclusion over EH */
 
 		spin_unlock_irqrestore(hs_lock, flags);
 
@@ -1873,6 +1874,10 @@ void ata_eh_finish(struct ata_port *ap)
 			}
 		}
 	}
+
+	/* make sure nr_active_links is zero after EH */
+	WARN_ON(ap->nr_active_links);
+	ap->nr_active_links = 0;
 }
 
 static void ata_eh_scsi_handle_link_detach(struct ata_link *link)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a26b6a6..df78f3e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -181,6 +181,7 @@ enum {
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
 	ATA_QCFLAG_IO		= (1 << 3), /* standard IO command */
 	ATA_QCFLAG_RESULT_TF	= (1 << 4), /* result TF requested */
+	ATA_QCFLAG_CLEAR_EXCL	= (1 << 5), /* clear excl_link on completion */
 
 	ATA_QCFLAG_FAILED	= (1 << 16), /* cmd failed and is owned by EH */
 	ATA_QCFLAG_SENSE_VALID	= (1 << 17), /* sense data valid */
@@ -520,12 +521,14 @@ struct ata_port {
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
 	unsigned long		qc_allocated;
 	unsigned int		qc_active;
+	int			nr_active_links; /* #links with active qcs */
 
 	struct ata_link		link;	/* host default link */
 	struct ata_device	__dev1;	/* storage for link.device[1] */
 
 	int			nr_pm_links;	/* nr of available PM links */
 	struct ata_link		*pm_link;	/* array of PM links */
+	struct ata_link		*excl_link;	/* for PM qc exclusion */
 
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
@@ -931,6 +934,11 @@ static inline int ata_link_max_devices(c
 	return 1;
 }
 
+static inline int ata_link_active(struct ata_link *link)
+{
+	return ata_tag_valid(link->active_tag) || link->sactive;
+}
+
 static inline struct ata_link *ata_port_first_link(struct ata_port *ap)
 {
 	if (ap->nr_pm_links)
-- 
1.2.4


