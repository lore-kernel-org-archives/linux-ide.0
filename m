From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] When a disk needs to be waken up from sleep, ensure that the command is retried by SCSI EH.
Date: Fri,  7 Aug 2009 15:26:53 -0700
Message-ID: <1249684013-24307-1-git-send-email-gwendal@google.com>
References: <e7510f760908071519m3bb8f120s485f8a0dd0d2259f@mail.gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:27992 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbZHGW1v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Aug 2009 18:27:51 -0400
In-Reply-To: <e7510f760908071519m3bb8f120s485f8a0dd0d2259f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

---
 drivers/ata/libata-eh.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 79711b6..202da9c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1183,14 +1183,14 @@ void ata_eh_qc_complete(struct ata_queued_cmd *qc)
  *	should be retried.  To be used from EH.
  *
  *	SCSI midlayer limits the number of retries to scmd->allowed.
- *	scmd->retries is decremented for commands which get retried
+ *	scmd->allowed is incremented for commands which get retried
  *	due to unrelated failures (qc->err_mask is zero).
  */
 void ata_eh_qc_retry(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *scmd = qc->scsicmd;
-	if (!qc->err_mask && scmd->retries)
-		scmd->retries--;
+	if (!qc->err_mask)
+		scmd->allowed++;
 	__ata_eh_qc_complete(qc);
 }
 
-- 
1.5.4.3

