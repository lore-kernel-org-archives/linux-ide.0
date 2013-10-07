From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] When a disk wakes up from sleep, ensure that the command
 ?is retried by SCSI EH.
Date: Mon, 7 Oct 2013 15:24:20 -0400
Message-ID: <20131007192420.GG27396@htj.dyndns.org>
References: <4A7CB4D6.7020902@kernel.org>
 <1249687069-31011-1-git-send-email-gwendal@google.com>
 <4A7CB769.4040309@kernel.org>
 <v2ne7510f761004221043y4b92ab7csa96b5b45fb07ea6b@mail.gmail.com>
 <4BD08BFF.7070702@kernel.org>
 <loom.20131002T202103-937@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:58495 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756428Ab3JGTYZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Oct 2013 15:24:25 -0400
Received: by mail-qe0-f54.google.com with SMTP id 1so1799177qec.27
        for <linux-ide@vger.kernel.org>; Mon, 07 Oct 2013 12:24:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20131002T202103-937@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: linux-ide@vger.kernel.org

Hello, Gwendal.

Applied to libata/for-3.12-fixes w/ commit message updated and stable
cc'd.

Thanks.

>From f13e220161e738c2710b9904dcb3cf8bb0bcce61 Mon Sep 17 00:00:00 2001
From: Gwendal Grignou <gwendal@google.com>
Date: Fri, 7 Aug 2009 16:17:49 -0700
Subject: [PATCH] libata: make ata_eh_qc_retry() bump scmd->allowed on bogus
 failures

libata EH decrements scmd->retries when the command failed for reasons
unrelated to the command itself so that, for example, commands aborted
due to suspend / resume cycle don't get penalized; however,
decrementing scmd->retries isn't enough for ATA passthrough commands.

Without this fix, ATA passthrough commands are not resend to the
drive, and no error is signalled to the caller because:

- allowed retry count is 1
- ata_eh_qc_complete fill the sense data, so result is valid
- sense data is filled with untouched ATA registers.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-eh.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c69fcce..370462f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1322,14 +1322,14 @@ void ata_eh_qc_complete(struct ata_queued_cmd *qc)
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
1.8.3.1

