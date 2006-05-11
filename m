From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/11] libata-eh-fw: update ata_exec_internal() for new EH
Date: Thu, 11 May 2006 21:27:24 +0900
Message-ID: <11473504443277-git-send-email-htejun@gmail.com>
References: <11473504433328-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:62041 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751652AbWEKM1e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:27:34 -0400
Received: by nz-out-0102.google.com with SMTP id 13so175444nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:27:34 -0700 (PDT)
In-Reply-To: <11473504433328-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_exec_internal() such that it uses new EH framework.
->post_internal_cmd() is always invoked regardless of completion
status.  Also, when ata_exec_internal() detects a timeout condition
and new EH is in place, it freezes the port as timeout for normal
commands would do.

Note that ata_port_flush_task() is called regardless of
wait_for_completion status.  This is necessary as exceptions unrelated
to the qc can abort the qc, in which case PIO task could still be
running after the wait for completion returns.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   30 +++++++++++++++++++++++-------
 1 files changed, 23 insertions(+), 7 deletions(-)

a20105e1c3c1639dd1677d2d9f600ccd0669882c
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 86d6a7d..a05be86 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -984,6 +984,7 @@ unsigned ata_exec_internal(struct ata_de
 	DECLARE_COMPLETION(wait);
 	unsigned long flags;
 	unsigned int err_mask;
+	int rc;
 
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
@@ -1036,20 +1037,25 @@ unsigned ata_exec_internal(struct ata_de
 
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
-	if (!wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL)) {
-		ata_port_flush_task(ap);
+	rc = wait_for_completion_timeout(&wait, ATA_TMOUT_INTERNAL);
+
+	ata_port_flush_task(ap);
 
+	if (!rc) {
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 
 		/* We're racing with irq here.  If we lose, the
 		 * following test prevents us from completing the qc
-		 * again.  If completion irq occurs after here but
-		 * before the caller cleans up, it will result in a
-		 * spurious interrupt.  We can live with that.
+		 * twice.  If we win, the port is frozen and will be
+		 * cleaned up by ->post_internal_cmd().
 		 */
 		if (qc->flags & ATA_QCFLAG_ACTIVE) {
-			qc->err_mask = AC_ERR_TIMEOUT;
-			ata_qc_complete(qc);
+			qc->err_mask |= AC_ERR_TIMEOUT;
+
+			if (ap->ops->error_handler)
+				ata_port_freeze(ap);
+			else
+				ata_qc_complete(qc);
 
 			ata_dev_printk(dev, KERN_WARNING,
 				       "qc timeout (cmd 0x%x)\n", command);
@@ -1058,6 +1064,16 @@ unsigned ata_exec_internal(struct ata_de
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 
+	/* do post_internal_cmd */
+	if (ap->ops->post_internal_cmd)
+		ap->ops->post_internal_cmd(qc);
+
+	if (qc->flags & ATA_QCFLAG_FAILED && !qc->err_mask) {
+		ata_dev_printk(dev, KERN_WARNING, "zero err_mask for failed "
+			       "internal command, assuming AC_ERR_OTHER\n");
+		qc->err_mask |= AC_ERR_OTHER;
+	}
+
 	/* finish up */
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
-- 
1.2.4


