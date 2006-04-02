From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/13] libata: implement new EH scheduling from PIO
Date: Mon, 3 Apr 2006 03:31:10 +0900
Message-ID: <11440026701290-git-send-email-htejun@gmail.com>
References: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:27419 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751133AbWDBSbT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:19 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550553nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:19 -0700 (PDT)
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
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

07c8a16be2d6b811c2c33ac31b89c98cea4512bd
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 735f328..1069aa9 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -3472,16 +3472,31 @@ skip_map:
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


