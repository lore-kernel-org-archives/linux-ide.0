From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] libata-sff: Reenable Port Multiplier after libata-sff remodeling.
Date: Mon, 30 Aug 2010 10:17:58 -0700
Message-ID: <1283188678-1696-1-git-send-email-gwendal@google.com>
References: <4C7A22CF.3090403@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:56978 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101Ab0H3RSt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Aug 2010 13:18:49 -0400
In-Reply-To: <4C7A22CF.3090403@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, nicolas@jungers.net
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

Keep track of the link on the which the current request is in progress.
It allows support of links behind port multiplier.

Not all libata-sff is PMP compliant. Code for native BMDMA controller
does not take in accound PMP.

Tested on Marvell 7042 and Sil7526.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/libata-sff.c |   25 ++++++++++++++++---------
 drivers/ata/sata_mv.c    |    2 +-
 include/linux/libata.h   |    3 ++-
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 3b82d8e..23d69a4 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1042,7 +1042,8 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
 int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 		     u8 status, int in_wq)
 {
-	struct ata_eh_info *ehi = &ap->link.eh_info;
+	struct ata_link *link = qc->dev->link;
+	struct ata_eh_info *ehi = &link->eh_info;
 	unsigned long flags = 0;
 	int poll_next;
 
@@ -1298,8 +1299,11 @@ fsm_start:
 }
 EXPORT_SYMBOL_GPL(ata_sff_hsm_move);
 
-void ata_sff_queue_pio_task(struct ata_port *ap, unsigned long delay)
+void ata_sff_queue_pio_task(struct ata_link *link, unsigned long delay)
 {
+	struct ata_port *ap = link->ap;
+	ap->sff_pio_task_link = link;
+
 	/* may fail if ata_sff_flush_pio_task() in progress */
 	queue_delayed_work(ata_sff_wq, &ap->sff_pio_task,
 			   msecs_to_jiffies(delay));
@@ -1321,12 +1325,13 @@ static void ata_sff_pio_task(struct work_struct *work)
 {
 	struct ata_port *ap =
 		container_of(work, struct ata_port, sff_pio_task.work);
+	struct ata_link *link = ap->sff_pio_task_link;
 	struct ata_queued_cmd *qc;
 	u8 status;
 	int poll_next;
 
 	/* qc can be NULL if timeout occurred */
-	qc = ata_qc_from_tag(ap, ap->link.active_tag);
+	qc = ata_qc_from_tag(ap, link->active_tag);
 	if (!qc)
 		return;
 
@@ -1345,7 +1350,7 @@ fsm_start:
 		msleep(2);
 		status = ata_sff_busy_wait(ap, ATA_BUSY, 10);
 		if (status & ATA_BUSY) {
-			ata_sff_queue_pio_task(ap, ATA_SHORT_PAUSE);
+			ata_sff_queue_pio_task(link, ATA_SHORT_PAUSE);
 			return;
 		}
 	}
@@ -1376,6 +1381,7 @@ fsm_start:
 unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_link *link = qc->dev->link;
 
 	/* Use polling pio if the LLD doesn't handle
 	 * interrupt driven pio and atapi CDB interrupt.
@@ -1396,7 +1402,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		ap->hsm_task_state = HSM_ST_LAST;
 
 		if (qc->tf.flags & ATA_TFLAG_POLLING)
-			ata_sff_queue_pio_task(ap, 0);
+			ata_sff_queue_pio_task(link, 0);
 
 		break;
 
@@ -1409,7 +1415,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		if (qc->tf.flags & ATA_TFLAG_WRITE) {
 			/* PIO data out protocol */
 			ap->hsm_task_state = HSM_ST_FIRST;
-			ata_sff_queue_pio_task(ap, 0);
+			ata_sff_queue_pio_task(link, 0);
 
 			/* always send first data block using the
 			 * ata_sff_pio_task() codepath.
@@ -1419,7 +1425,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 			ap->hsm_task_state = HSM_ST;
 
 			if (qc->tf.flags & ATA_TFLAG_POLLING)
-				ata_sff_queue_pio_task(ap, 0);
+				ata_sff_queue_pio_task(link, 0);
 
 			/* if polling, ata_sff_pio_task() handles the
 			 * rest.  otherwise, interrupt handler takes
@@ -1441,7 +1447,7 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 		/* send cdb by polling if no cdb interrupt */
 		if ((!(qc->dev->flags & ATA_DFLAG_CDB_INTR)) ||
 		    (qc->tf.flags & ATA_TFLAG_POLLING))
-			ata_sff_queue_pio_task(ap, 0);
+			ata_sff_queue_pio_task(link, 0);
 		break;
 
 	default:
@@ -2734,6 +2740,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_dumb_qc_prep);
 unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_link *link = qc->dev->link;
 
 	/* defer PIO handling to sff_qc_issue */
 	if (!ata_is_dma(qc->tf.protocol))
@@ -2762,7 +2769,7 @@ unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc)
 
 		/* send cdb by polling if no cdb interrupt */
 		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
-			ata_sff_queue_pio_task(ap, 0);
+			ata_sff_queue_pio_task(link, 0);
 		break;
 
 	default:
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 8198259..a9fd970 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2284,7 +2284,7 @@ static unsigned int mv_qc_issue_fis(struct ata_queued_cmd *qc)
 	}
 
 	if (qc->tf.flags & ATA_TFLAG_POLLING)
-		ata_sff_queue_pio_task(ap, 0);
+		ata_sff_queue_pio_task(link, 0);
 	return 0;
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f010f18..74596a3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -723,6 +723,7 @@ struct ata_port {
 	struct ata_ioports	ioaddr;	/* ATA cmd/ctl/dma register blocks */
 	u8			ctl;	/* cache of ATA control register */
 	u8			last_ctl;	/* Cache last written value */
+	struct ata_link*	sff_pio_task_link; /* link currently used */
 	struct delayed_work	sff_pio_task;
 #ifdef CONFIG_ATA_BMDMA
 	struct ata_bmdma_prd	*bmdma_prd;	/* BMDMA SG list */
@@ -1594,7 +1595,7 @@ extern void ata_sff_irq_on(struct ata_port *ap);
 extern void ata_sff_irq_clear(struct ata_port *ap);
 extern int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 			    u8 status, int in_wq);
-extern void ata_sff_queue_pio_task(struct ata_port *ap, unsigned long delay);
+extern void ata_sff_queue_pio_task(struct ata_link *link, unsigned long delay);
 extern unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc);
 extern bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc);
 extern unsigned int ata_sff_port_intr(struct ata_port *ap,
-- 
1.7.1

