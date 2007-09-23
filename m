From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/12] libata-pmp-prep: implement qc_defer helpers
Date: Sun, 23 Sep 2007 13:14:12 +0900
Message-ID: <11905208523980-git-send-email-htejun@gmail.com>
References: <11905208513747-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:55689 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbXIWETZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Sep 2007 00:19:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1141375rvb
        for <linux-ide@vger.kernel.org>; Sat, 22 Sep 2007 21:19:24 -0700 (PDT)
In-Reply-To: <11905208513747-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
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
 drivers/ata/libata-core.c |   22 ++++++++++++++++++++--
 drivers/ata/libata-eh.c   |    5 +++++
 include/linux/libata.h    |    8 ++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 7dd666e..86ef06e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1392,6 +1392,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	struct ata_queued_cmd *qc;
 	unsigned int tag, preempted_tag;
 	u32 preempted_sactive, preempted_qc_active;
+	int preempted_nr_active_links;
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long flags;
 	unsigned int err_mask;
@@ -1430,9 +1431,11 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
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
@@ -1511,6 +1514,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	link->active_tag = preempted_tag;
 	link->sactive = preempted_sactive;
 	ap->qc_active = preempted_qc_active;
+	ap->nr_active_links = preempted_nr_active_links;
 
 	/* XXX - Some LLDDs (sata_mv) disable port on command failure.
 	 * Until those drivers are fixed, we detect the condition
@@ -5410,10 +5414,19 @@ void __ata_qc_complete(struct ata_queued_cmd *qc)
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
+	if (unlikely(qc->flags & ATA_QCFLAG_CLEAR_EXCL &&
+		     ap->excl_link == link))
+		ap->excl_link = NULL;
 
 	/* atapi: mark qc as inactive to prevent the interrupt handler
 	 * from completing the command twice later, before the error handler
@@ -5592,9 +5605,14 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 
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
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1d3b0dc..5244723 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -451,6 +451,7 @@ void ata_scsi_error(struct Scsi_Host *host)
 
 		ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
 		ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+		ap->excl_link = NULL;	/* don't maintain exclusion over EH */
 
 		spin_unlock_irqrestore(ap->lock, flags);
 
@@ -2474,6 +2475,10 @@ void ata_eh_finish(struct ata_port *ap)
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
index b0d4ca0..f9f81fd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -216,6 +216,7 @@ enum {
 	ATA_QCFLAG_DMAMAP	= ATA_QCFLAG_SG | ATA_QCFLAG_SINGLE,
 	ATA_QCFLAG_IO		= (1 << 3), /* standard IO command */
 	ATA_QCFLAG_RESULT_TF	= (1 << 4), /* result TF requested */
+	ATA_QCFLAG_CLEAR_EXCL	= (1 << 5), /* clear excl_link on completion */
 
 	ATA_QCFLAG_FAILED	= (1 << 16), /* cmd failed and is owned by EH */
 	ATA_QCFLAG_SENSE_VALID	= (1 << 17), /* sense data valid */
@@ -579,11 +580,13 @@ struct ata_port {
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
 	unsigned long		qc_allocated;
 	unsigned int		qc_active;
+	int			nr_active_links; /* #links with active qcs */
 
 	struct ata_link		link;	/* host default link */
 
 	int			nr_pmp_links;	/* nr of available PMP links */
 	struct ata_link		*pmp_link;	/* array of PMP links */
+	struct ata_link		*excl_link;	/* for PMP qc exclusion */
 
 	struct ata_port_stats	stats;
 	struct ata_host		*host;
@@ -1104,6 +1107,11 @@ static inline int ata_link_max_devices(const struct ata_link *link)
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
1.5.0.3


