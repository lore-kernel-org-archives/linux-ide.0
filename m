From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: implement ATA_QCFLAG_RETRY
Date: Thu, 27 Mar 2008 19:14:24 +0900
Message-ID: <12066128663552-git-send-email-htejun@gmail.com>
References: <12066128663306-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:65503 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYC0KOd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 06:14:33 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4737766wah.23
        for <linux-ide@vger.kernel.org>; Thu, 27 Mar 2008 03:14:31 -0700 (PDT)
In-Reply-To: <12066128663306-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca
Cc: Tejun Heo <htejun@gmail.com>

Currently whether a command should be retried after failure is
determined inside ata_eh_finish().  Add ATA_QCFLAG_RETRY and move the
logic into ata_eh_autopsy().  This makes things clearer and helps
extending retry determination logic.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   18 ++++++++----------
 include/linux/libata.h  |    1 +
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a583032..5f3d294 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1804,6 +1804,11 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		if (qc->flags & ATA_QCFLAG_SENSE_VALID)
 			qc->err_mask &= ~(AC_ERR_DEV | AC_ERR_OTHER);
 
+		/* determine whether the command is worth retrying */
+		if (!(qc->err_mask & AC_ERR_INVALID) &&
+		    ((qc->flags & ATA_QCFLAG_IO) || qc->err_mask != AC_ERR_DEV))
+			qc->flags |= ATA_QCFLAG_RETRY;
+
 		/* accumulate error info */
 		ehc->i.dev = qc->dev;
 		all_err_mask |= qc->err_mask;
@@ -2817,18 +2822,11 @@ void ata_eh_finish(struct ata_port *ap)
 			/* FIXME: Once EH migration is complete,
 			 * generate sense data in this function,
 			 * considering both err_mask and tf.
-			 *
-			 * There's no point in retrying invalid
-			 * (detected by libata) and non-IO device
-			 * errors (rejected by device).  Finish them
-			 * immediately.
 			 */
-			if ((qc->err_mask & AC_ERR_INVALID) ||
-			    (!(qc->flags & ATA_QCFLAG_IO) &&
-			     qc->err_mask == AC_ERR_DEV))
-				ata_eh_qc_complete(qc);
-			else
+			if (qc->flags & ATA_QCFLAG_RETRY)
 				ata_eh_qc_retry(qc);
+			else
+				ata_eh_qc_complete(qc);
 		} else {
 			if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
 				ata_eh_qc_complete(qc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b064bfe..d06dd12 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -225,6 +225,7 @@ enum {
 	ATA_QCFLAG_RESULT_TF	= (1 << 4), /* result TF requested */
 	ATA_QCFLAG_CLEAR_EXCL	= (1 << 5), /* clear excl_link on completion */
 	ATA_QCFLAG_QUIET	= (1 << 6), /* don't report device error */
+	ATA_QCFLAG_RETRY	= (1 << 7), /* retry after failure */
 
 	ATA_QCFLAG_FAILED	= (1 << 16), /* cmd failed and is owned by EH */
 	ATA_QCFLAG_SENSE_VALID	= (1 << 17), /* sense data valid */
-- 
1.5.2.4

