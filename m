From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/16] libata-eh-fw: implement new EH scheduling via timeout
Date: Tue, 11 Apr 2006 22:42:54 +0900
Message-ID: <1144762974340-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.237]:25239 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750911AbWDKNnC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:43:02 -0400
Received: by wproxy.gmail.com with SMTP id i12so1030488wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:43:01 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement new EH scheduling from timeout.  ata_scsi_timedout() also
takes care of the race condition in which scsi_eh_schedule_qc() sets
ATA_QCFLAG_EH_SCHEDULED but fails to acutally schedule EH for the qc
because it loses to timeout.

A timeout is HSM violation condition.  New EH assumes that on a
timeout the state of the controller and devices are unknown and
dangerous.  So, all active commands are aborted and the port is
frozen.  Note that commands which get aborted this way don't have its
qc->err_mask set and its retries count will be compensated.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   33 ++++++++++++++++++++++++++++-----
 1 files changed, 28 insertions(+), 5 deletions(-)

0f79b4bddad85f3b2a55a46f316721b5492fd8ba
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index e731c04..97ec527 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -66,19 +66,42 @@ enum scsi_eh_timer_return ata_scsi_timed
 	struct Scsi_Host *host = cmd->device->host;
 	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
 	unsigned long flags;
+	int i;
 	struct ata_queued_cmd *qc;
 	enum scsi_eh_timer_return ret = EH_HANDLED;
 
 	DPRINTK("ENTER\n");
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
-	qc = ata_qc_from_tag(ap, ap->active_tag);
-	if (qc) {
-		WARN_ON(qc->scsicmd != cmd);
-		qc->flags |= ATA_QCFLAG_EH_SCHEDULED;
-		qc->err_mask |= AC_ERR_TIMEOUT;
+
+	for (i = 0; i < ATA_MAX_QUEUE; i++) {
+		/* If ata_eh_scheduled_qc() raced with us and lost,
+		 * EH_SCHEDULED flag would already be set, so we
+		 * cannot use ata_qc_from_tag() here.
+		 */
+		qc = __ata_qc_from_tag(ap, i);
+		if (qc && qc->flags & ATA_QCFLAG_ACTIVE && qc->scsicmd == cmd)
+			break;
+	}
+
+	if (i < ATA_MAX_QUEUE) {
+		/* qc->err_mask belongs to the command owner, so it
+		 * cannot be altered here.  Use ATA_QCFLAG_TIMEOUT
+		 * instead.  EH is responsible for merging this flag
+		 * into err_mask after claiming qc ownership.
+		 */
+		qc->flags |= ATA_QCFLAG_TIMEOUT | ATA_QCFLAG_EH_SCHEDULED;
+		qc->dev->flags |= ATA_DFLAG_FAILED;
+
+		if (ap->ops->error_handler)
+			ata_eh_schedule_port(ap, ATA_EH_FREEZE);
+		else
+			/* old EH, do what it used to do */
+			qc->err_mask |= AC_ERR_TIMEOUT;
+
 		ret = EH_NOT_HANDLED;
 	}
+
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
 	DPRINTK("EXIT, ret=%d\n", ret);
-- 
1.2.4


