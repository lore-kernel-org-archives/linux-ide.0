From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 14/16] libata-eh-fw: activate ->post_internal_cmd
Date: Tue, 11 Apr 2006 22:42:55 +0900
Message-ID: <1144762975540-git-send-email-htejun@gmail.com>
References: <11447629733305-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.227]:17559 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750912AbWDKNnC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:43:02 -0400
Received: by wproxy.gmail.com with SMTP id i11so925425wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:43:02 -0700 (PDT)
In-Reply-To: <11447629733305-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_exec_internal() such that it uses new EH framework.
->post_internal_cmd() is always invoked regardless of completion
status.  Also, when ata_exec_internal() detects a timeout condition
and new EH is in place, it freezes the port as timeout for normal
commands would do.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

6115e687a94c7d5a05cab2646f30ec5d4dca3f91
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 43e47f3..c7b7de9 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1046,13 +1046,17 @@ unsigned ata_exec_internal(struct ata_po
 
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
+				ata_eh_schedule_port(ap, ATA_EH_FREEZE);
+			else
+				ata_qc_complete(qc);
+
 			printk(KERN_WARNING "ata%u: qc timeout (cmd 0x%x)\n",
 			       ap->id, command);
 		}
@@ -1060,6 +1064,17 @@ unsigned ata_exec_internal(struct ata_po
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 
+	/* do post_internal_cmd */
+	if (ap->ops->post_internal_cmd)
+		ap->ops->post_internal_cmd(qc);
+
+	if (qc->flags & ATA_QCFLAG_FAILED && !qc->err_mask) {
+		printk(KERN_WARNING "ata%u: zero err_mask for failed "
+		       "internal command, assuming AC_ERR_OTHER\n", ap->id);
+		qc->err_mask |= AC_ERR_OTHER;
+	}
+
+	/* finish up */
 	spin_lock_irqsave(&ap->host_set->lock, flags);
 
 	*tf = qc->tf;
-- 
1.2.4


