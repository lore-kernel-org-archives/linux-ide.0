From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/13] libata: implement new EH scheduling via timeout
Date: Mon, 3 Apr 2006 03:31:09 +0900
Message-ID: <11440026692499-git-send-email-htejun@gmail.com>
References: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:52805 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751037AbWDBSbU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:20 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550552nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:20 -0700 (PDT)
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
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

d2492ad340d9c93e4042e5fb9be625412dbc926f
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index d443ef2..0a3d832 100644
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


