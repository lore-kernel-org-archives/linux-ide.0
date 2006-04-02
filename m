From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/13] libata: activate ->post_internal_cmd
Date: Mon, 3 Apr 2006 03:31:10 +0900
Message-ID: <11440026702984-git-send-email-htejun@gmail.com>
References: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.203]:25247 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750894AbWDBSbS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:18 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550555nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:18 -0700 (PDT)
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_exec_internal() such that it uses new EH framework.
->post_internal_cmd() is always invoked regardless of completion
status.  Also, when ata_exec_internal() detects a timeout condition
and new EH is in place, it freezes the port as timeout for normal
commands would do.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

4e9465fdf6b1bbd2eca5116144724500739239c3
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1069aa9..2e80930 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1043,13 +1043,17 @@ unsigned ata_exec_internal(struct ata_po
 
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
@@ -1057,6 +1061,9 @@ unsigned ata_exec_internal(struct ata_po
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	}
 
+	if (ap->ops->post_internal_cmd)
+		ap->ops->post_internal_cmd(qc);
+
 	*tf = qc->tf;
 	err_mask = qc->err_mask;
 
-- 
1.2.4


