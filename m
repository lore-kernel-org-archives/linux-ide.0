From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/6] libata-pmp-prep: implement qc_defer helpers
Date: Sat, 8 Jul 2006 14:51:18 +0900
Message-ID: <1152337878547-git-send-email-htejun@gmail.com>
References: <11523378773934-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:10098 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964781AbWGHFua (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:50:30 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484429wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:50:30 -0700 (PDT)
In-Reply-To: <11523378773934-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ap->nr_active_links (the number of links with active qcs),
ap->excl_link (pointer to link which can be used by ->qc_defer and is
cleared when a qc with ATA_QCFLAG_CLEAR_EXCL completes), and
ata_link_active().

These can be used by ->qc_defer() to implement proper command
exclusion.  This set of helpers seem enough for both sil24 (ATAPI
exclusion needed) and cmd-switching PMP.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   21 +++++++++++++++++++--
 drivers/scsi/libata-eh.c   |    5 +++++
 include/linux/libata.h     |    8 ++++++++
 3 files changed, 32 insertions(+), 2 deletions(-)

e8c076ff470980da565d0c41bd95c9a1538ab561
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f9644db..346130c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1004,6 +1004,7 @@ unsigned ata_exec_internal(struct ata_de
 	struct ata_queued_cmd *qc;
 	unsigned int tag, preempted_tag;
 	u32 preempted_sactive, preempted_qc_active;
+	int preempted_nr_active_links;
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long flags;
 	unsigned int err_mask;
@@ -1042,9 +1043,11 @@ unsigned ata_exec_internal(struct ata_de
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
@@ -1114,6 +1117,7 @@ unsigned ata_exec_internal(struct ata_de
 	link->active_tag = preempted_tag;
 	link->sactive = preempted_sactive;
 	ap->qc_active = preempted_qc_active;
+	ap->nr_active_links = preempted_nr_active_links;
 
 	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
 	 * Until those drivers are fixed, we detect the condition
@@ -4520,10 +4524,18 @@ void __ata_qc_complete(struct ata_queued
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
@@ -4694,9 +4706,14 @@ void ata_qc_issue(struct ata_queued_cmd 
 
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
index e6fd54a..122226b 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -293,6 +293,7 @@ void ata_scsi_error(struct Scsi_Host *ho
 
 		ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
 		ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+		ap->excl_link = NULL;	/* don't maintain exclusion over EH */
 
 		spin_unlock_irqrestore(ap->lock, flags);
 
@@ -2225,6 +2226,10 @@ void ata_eh_finish(struct ata_port *ap)
 			}
 		}
 	}
+
+	/* make sure nr_active_links is zero after EH */
+	WARN_ON(ap->nr_active_links);
+	ap->nr_active_links = 0;
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8a4adce..dea1e5f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -192,6 +192,7 @@ enum {
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
 	ATA_QCFLAG_IO		= (1 << 3), /* standard IO command */
 	ATA_QCFLAG_RESULT_TF	= (1 << 4), /* result TF requested */
+	ATA_QCFLAG_CLEAR_EXCL	= (1 << 5), /* clear excl_link on completion */
 
 	ATA_QCFLAG_FAILED	= (1 << 16), /* cmd failed and is owned by EH */
 	ATA_QCFLAG_SENSE_VALID	= (1 << 17), /* sense data valid */
@@ -549,12 +550,14 @@ struct ata_port {
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
 	unsigned long		qc_allocated;
 	unsigned int		qc_active;
+	int			nr_active_links; /* #links with active qcs */
 
 	struct ata_link		link;	/* host default link */
 	struct ata_device	__dev1;	/* storage for link.device[1] */
 
 	int			nr_pmp_links;	/* nr of available PMP links */
 	struct ata_link		*pmp_link;	/* array of PMP links */
+	struct ata_link		*excl_link;	/* for PMP qc exclusion */
 
 	struct ata_host_stats	stats;
 	struct ata_host_set	*host_set;
@@ -1022,6 +1025,11 @@ static inline int ata_link_max_devices(c
 	return 1;
 }
 
+static inline int ata_link_active(struct ata_link *link)
+{
+	return ata_tag_valid(link->active_tag) || link->sactive;
+}
+
 static inline struct ata_link *ata_port_first_link(struct ata_port *ap)
 {
 	if (ap->nr_pmp_links)
-- 
1.3.2


