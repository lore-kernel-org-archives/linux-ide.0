From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/12] libata: fix ata_qc_issue() error handling
Date: Sun, 22 Jan 2006 16:58:30 +0900
Message-ID: <11379167102315-git-send-email-htejun@gmail.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.198]:33198 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751239AbWAVH6f (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:58:35 -0500
Received: by xproxy.gmail.com with SMTP id s14so513088wxc
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:58:35 -0800 (PST)
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

When ata_qc_issue() fails, the qc might have been dma mapped or not.
So, performing only ata_qc_free() results in dma map leak.  This patch
makes ata_qc_issue() mark dma map flags correctly on failure and calls
ata_qc_complete() after ata_qc_issue() fails.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   18 ++++++++----------
 drivers/scsi/libata-scsi.c |    6 ++++--
 2 files changed, 12 insertions(+), 12 deletions(-)

1a74b7390a28190a7031e7fc444be5792c82d256
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 15df633..43a2328 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1125,8 +1125,10 @@ ata_exec_internal(struct ata_port *ap, s
 	qc->private_data = &wait;
 	qc->complete_fn = ata_qc_complete_internal;
 
-	if (ata_qc_issue(qc))
-		goto issue_fail;
+	if (ata_qc_issue(qc)) {
+		qc->err_mask = AC_ERR_OTHER;
+		ata_qc_complete(qc);
+	}
 
 	spin_unlock_irqrestore(&ap->host_set->lock, flags);
 
@@ -1155,11 +1157,6 @@ ata_exec_internal(struct ata_port *ap, s
 	ata_qc_free(qc);
 
 	return err_mask;
-
- issue_fail:
-	ata_qc_free(qc);
-	spin_unlock_irqrestore(&ap->host_set->lock, flags);
-	return AC_ERR_OTHER;
 }
 
 /**
@@ -3687,10 +3684,10 @@ int ata_qc_issue(struct ata_queued_cmd *
 	if (ata_should_dma_map(qc)) {
 		if (qc->flags & ATA_QCFLAG_SG) {
 			if (ata_sg_setup(qc))
-				goto err_out;
+				goto sg_err;
 		} else if (qc->flags & ATA_QCFLAG_SINGLE) {
 			if (ata_sg_setup_one(qc))
-				goto err_out;
+				goto sg_err;
 		}
 	} else {
 		qc->flags &= ~ATA_QCFLAG_DMAMAP;
@@ -3703,7 +3700,8 @@ int ata_qc_issue(struct ata_queued_cmd *
 
 	return ap->ops->qc_issue(qc);
 
-err_out:
+sg_err:
+	qc->flags &= ~ATA_QCFLAG_DMAMAP;
 	return -1;
 }
 
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index ce3fe92..c496309 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1322,8 +1322,10 @@ static void ata_scsi_translate(struct at
 		goto early_finish;
 
 	/* select device, send command to hardware */
-	if (ata_qc_issue(qc))
-		goto err_did;
+	if (ata_qc_issue(qc)) {
+		qc->err_mask |= AC_ERR_OTHER;
+		ata_qc_complete(qc);
+	}
 
 	VPRINTK("EXIT\n");
 	return;
-- 
1.0.8


