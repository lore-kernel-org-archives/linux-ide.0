From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: enforce default EH actions
Date: Tue, 16 May 2006 12:58:24 +0900
Message-ID: <20060516035824.GB23124@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:13133 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751249AbWEPD63 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 23:58:29 -0400
Received: by nz-out-0102.google.com with SMTP id v1so6531nzb
        for <linux-ide@vger.kernel.org>; Mon, 15 May 2006 20:58:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

LLDDs rely on libata that certain EH actions are automatically taken
on some errors.  If the port is frozen or one or more qc's have failed
with HSM violation or timeout, softreset is enforced (LLDD can ask for
storonger EH action at will).  If any other error condition exists,
libata EH always revalidates.

This behavior existed in earlier revisions of new EH but lost during
development process.  This patch restores it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

caec4356c4f88f476e6b5ee26dba07be70c3fd17
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 7244caf..750e734 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1169,9 +1169,6 @@ static void ata_eh_autopsy(struct ata_po
 		/* inherit upper level err_mask */
 		qc->err_mask |= ehc->i.err_mask;
 
-		if (qc->err_mask & AC_ERR_TIMEOUT)
-			action |= ATA_EH_SOFTRESET;
-
 		/* analyze TF */
 		action |= ata_eh_analyze_tf(qc, &qc->result_tf);
 
@@ -1201,9 +1198,14 @@ static void ata_eh_autopsy(struct ata_po
 	if (failed_dev)
 		action |= ata_eh_speed_down(failed_dev, is_io, all_err_mask);
 
-	if (all_err_mask)
+	/* enforce default EH actions */
+	if (ap->flags & ATA_FLAG_FROZEN ||
+	    all_err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT))
+		action |= ATA_EH_SOFTRESET;
+	else if (all_err_mask)
 		action |= ATA_EH_REVALIDATE;
 
+	/* record autopsy result */
 	ehc->i.dev = failed_dev;
 	ehc->i.action = action;
 
-- 
1.3.2

