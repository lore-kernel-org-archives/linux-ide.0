From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] When a disk wakes up from sleep, ensure that the command is retried by SCSI EH.
Date: Fri,  7 Aug 2009 16:17:49 -0700
Message-ID: <1249687069-31011-1-git-send-email-gwendal@google.com>
References: <4A7CB4D6.7020902@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:8431 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbZHGXSt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Aug 2009 19:18:49 -0400
In-Reply-To: <4A7CB4D6.7020902@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

Without this fix, ATA passthrough commands are not resend to the drive, and no
error is signalled to the caller because:
- allowed retry count is 1
- ata_eh_qc_complete fill the sense data, so result is valid
- sense data is filled with untouched ATA registers.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
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

