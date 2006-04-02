From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/13] libata: activate ->error_handler
Date: Mon, 3 Apr 2006 03:31:10 +0900
Message-ID: <11440026702443-git-send-email-htejun@gmail.com>
References: <1144002668278-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:52805 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750928AbWDBSbT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 14:31:19 -0400
Received: by zproxy.gmail.com with SMTP id o37so1550552nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 11:31:18 -0700 (PDT)
In-Reply-To: <1144002668278-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Update ata_scsi_error() such that ->error_handler is invoked if
implemented.  ata_scsi_error() also takes care of merging
ATA_QCFLAG_TIMEOUT into qc->err_mask and clearing SCSI EH conditions.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

3548a7477edb501d6680730c69f5a5913b81af8b
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 0a3d832..dfbb8c4 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -130,12 +130,29 @@ int ata_scsi_error(struct Scsi_Host *hos
 	spin_unlock_wait(&ap->host_set->lock);
 	ata_port_flush_task(ap);
 
-	WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
+	/* invoke error handler */
+	if (ap->ops->error_handler) {
+		int i;
+
+		/* for new EH, all the qc's are ours now */
+		for (i = 0; i < ATA_MAX_QUEUE; i++) {
+			struct ata_queued_cmd *qc;
+			qc = __ata_qc_from_tag(ap, i);
+			if (qc->flags & ATA_QCFLAG_TIMEOUT)
+				qc->err_mask |= AC_ERR_TIMEOUT;;
+		}
 
-	ap->ops->eng_timeout(ap);
+		ap->ops->error_handler(ap);
+	} else {
+		WARN_ON(ata_qc_from_tag(ap, ap->active_tag) == NULL);
+		ap->ops->eng_timeout(ap);
+	}
 
 	WARN_ON(host->host_failed || !list_empty(&host->eh_cmd_q));
 
+	/* finish or retry handled qc's and clean up */
+	host->host_eh_scheduled = 0;
+
 	scsi_eh_flush_done_q(&ap->eh_done_q);
 
 	DPRINTK("EXIT\n");
-- 
1.2.4


