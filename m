From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix irq-pio merge
Date: Thu, 11 May 2006 22:33:24 +0900
Message-ID: <11473544043357-git-send-email-htejun@gmail.com>
References: <11473544041507-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:26990 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751775AbWEKNdb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:33:31 -0400
Received: by wr-out-0506.google.com with SMTP id i28so132512wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:33:30 -0700 (PDT)
In-Reply-To: <11473544041507-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

* kill ata_poll_qc_complete() and implement/use ata_hsm_qc_complete()
  which completes qcs in new EH compliant manner from HSM

* don't print error message from ata_hsm_move().  it's responsibility
  of EH.

* kill ATA_FLAG_NOINTR usage in bmdma EH

---

 drivers/scsi/libata-bmdma.c |    1 
 drivers/scsi/libata-core.c  |   98 +++++++++++++++++++++++--------------------
 2 files changed, 52 insertions(+), 47 deletions(-)

1bb4c2efb606a5b746997b0ceabbdadbda5d3f26
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 751ec18..741ddc4 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -726,7 +726,6 @@ void ata_bmdma_drive_eh(struct ata_port 
 	/* reset PIO HSM and stop DMA engine */
 	spin_lock_irqsave(&host_set->lock, flags);
 
-	ap->flags &= ~ATA_FLAG_NOINTR;
 	ap->hsm_task_state = HSM_ST_IDLE;
 
 	if (qc && (qc->tf.protocol == ATA_PROT_DMA ||
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b230856..6d28722 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3461,40 +3461,6 @@ skip_map:
 }
 
 /**
- *	ata_poll_qc_complete - turn irq back on and finish qc
- *	@qc: Command to complete
- *	@err_mask: ATA status register content
- *
- *	LOCKING:
- *	None.  (grabs host lock)
- */
-void ata_poll_qc_complete(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ap->host_set->lock, flags);
-
-	if (ap->ops->error_handler) {
-		/* EH might have kicked in while host_set lock is released */
-		qc = ata_qc_from_tag(ap, qc->tag);
-		if (qc) {
-			if (!(qc->err_mask & AC_ERR_HSM)) {
-				ata_irq_on(ap);
-				ata_qc_complete(qc);
-			} else
-				ata_port_freeze(ap);
-		}
-	} else {
-		/* old EH */
-		ata_irq_on(ap);
-		ata_qc_complete(qc);
-	}
-
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-}
-
-/**
  *	swap_buf_le16 - swap halves of 16-bit words in place
  *	@buf:  Buffer to swap
  *	@buf_words:  Number of 16-bit words in buffer.
@@ -3917,6 +3883,56 @@ static inline int ata_hsm_ok_in_wq(struc
 }
 
 /**
+ *	ata_hsm_qc_complete - finish a qc running on standard HSM
+ *	@qc: Command to complete
+ *	@in_wq: 1 if called from workqueue, 0 otherwise
+ *
+ *	Finish @qc which is running on standard HSM.
+ *
+ *	LOCKING:
+ *	If @in_wq is zero, spin_lock_irqsave(host_set lock).
+ *	Otherwise, none on entry and grabs host lock.
+ */
+static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned long flags;
+
+	if (ap->ops->error_handler) {
+		if (in_wq) {
+			spin_lock_irqsave(&ap->host_set->lock, flags);
+
+			/* EH might have kicked in while host_set lock
+			 * is released.
+			 */
+			qc = ata_qc_from_tag(ap, qc->tag);
+			if (qc) {
+				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
+					ata_irq_on(ap);
+					ata_qc_complete(qc);
+				} else
+					ata_port_freeze(ap);
+			}
+
+			spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		} else {
+			if (likely(!(qc->err_mask & AC_ERR_HSM)))
+				ata_qc_complete(qc);
+			else
+				ata_port_freeze(ap);
+		}
+	} else {
+		if (in_wq) {
+			spin_lock_irqsave(&ap->host_set->lock, flags);
+			ata_irq_on(ap);
+			ata_qc_complete(qc);
+			spin_unlock_irqrestore(&ap->host_set->lock, flags);
+		} else
+			ata_qc_complete(qc);
+	}
+}
+
+/**
  *	ata_hsm_move - move the HSM to the next state.
  *	@ap: the target ata_port
  *	@qc: qc on going
@@ -4107,19 +4123,12 @@ fsm_start:
 		ap->hsm_task_state = HSM_ST_IDLE;
 
 		/* complete taskfile transaction */
-		if (in_wq)
-			ata_poll_qc_complete(qc);
-		else
-			ata_qc_complete(qc);
+		ata_hsm_qc_complete(qc, in_wq);
 
 		poll_next = 0;
 		break;
 
 	case HSM_ST_ERR:
-		if (qc->tf.command != ATA_CMD_PACKET)
-			printk(KERN_ERR "ata%u: dev %u command error, drv_stat 0x%x\n",
-			       ap->id, qc->dev->devno, status);
-
 		/* make sure qc->err_mask is available to
 		 * know what's wrong and recover
 		 */
@@ -4128,10 +4137,7 @@ fsm_start:
 		ap->hsm_task_state = HSM_ST_IDLE;
 
 		/* complete taskfile transaction */
-		if (in_wq)
-			ata_poll_qc_complete(qc);
-		else
-			ata_qc_complete(qc);
+		ata_hsm_qc_complete(qc, in_wq);
 
 		poll_next = 0;
 		break;
-- 
1.2.4


