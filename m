From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/11] libata-eh-fw: implement new EH scheduling from PIO
Date: Thu, 11 May 2006 21:27:24 +0900
Message-ID: <1147350444826-git-send-email-htejun@gmail.com>
References: <11473504433328-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.199]:29322 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751650AbWEKM1e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:27:34 -0400
Received: by nz-out-0102.google.com with SMTP id 13so175443nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:27:33 -0700 (PDT)
In-Reply-To: <11473504433328-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

PIO executes without holding host_set lock, so it cannot be
synchronized using the same mechanism as interrupt driven execution.
port_task framework makes sure that EH is not entered until PIO task
is flushed, so PIO task can be sure the qc in progress won't go away
underneath it.  One thing it cannot be sure of is whether the qc has
already been scheduled for EH by another exception condition while
host_set lock was released.

This patch makes ata_poll_qc-complete() handle such conditions
properly and make it freeze the port if HSM violation is detected
during PIO execution.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

52240d1d208615e461c41a5c297f521a8a892f0d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 436ff5b..86d6a7d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3429,16 +3429,31 @@ skip_map:
  *	LOCKING:
  *	None.  (grabs host lock)
  */
-
 void ata_poll_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
-	ap->flags &= ~ATA_FLAG_NOINTR;
-	ata_irq_on(ap);
-	ata_qc_complete(qc);
+
+	if (ap->ops->error_handler) {
+		/* EH might have kicked in while host_set lock is released */
+		qc = ata_qc_from_tag(ap, qc->tag);
+		if (qc) {
+			if (!(qc->err_mask & AC_ERR_HSM)) {
+				ap->flags &= ~ATA_FLAG_NOINTR;
+				ata_irq_on(ap);
+				ata_qc_complete(qc);
+			} else
+				ata_port_freeze(ap);
+		}
+	} else {
+		/* old EH */
+		ap->flags &= ~ATA_FLAG_NOINTR;
+		ata_irq_on(ap);
+		ata_qc_complete(qc);
+	}
+
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 }
 
-- 
1.2.4


