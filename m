From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/16] libata-eh-fw: implement new EH scheduling from PIO
Date: Tue, 11 Apr 2006 22:42:54 +0900
Message-ID: <11447629741866-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.239]:13463 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750901AbWDKNnB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:43:01 -0400
Received: by wproxy.gmail.com with SMTP id i11so925405wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:43:01 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
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

f4a9faac776713cb0983f4fd551e56e6f0845d27
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b6f6815..43e47f3 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3479,16 +3479,31 @@ skip_map:
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
+				ata_eh_schedule_port(ap, ATA_EH_FREEZE);
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


