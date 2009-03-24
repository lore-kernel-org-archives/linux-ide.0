From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/14] ide-cd: clear sense buffer before issuing request sense
Date: Wed, 25 Mar 2009 01:06:09 +0900
Message-ID: <1237910776-10983-8-git-send-email-tj@kernel.org>
References: <1237910776-10983-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41831 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759273AbZCXQGi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 12:06:38 -0400
In-Reply-To: <1237910776-10983-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-kernel@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

Impact: code simplification

ide_cd_request_sense_fixup() clears the tail of the sense buffer if
the device didn't completely fill it.  This patch makes
cdrom_queue_request_sense() clear the sense buffer before issuing the
command instead of clearing it afterwards.  This simplifies code and
eases future changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ide/ide-cd.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 35729a4..b3736b4 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -217,6 +217,8 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
 	if (sense == NULL)
 		sense = &info->sense_data;
 
+	memset(sense, 0, 18);
+
 	/* stuff the sense request in front of our current request */
 	blk_rq_init(NULL, rq);
 	rq->cmd_type = REQ_TYPE_ATA_PC;
@@ -520,14 +522,8 @@ static void ide_cd_request_sense_fixup(ide_drive_t *drive, struct ide_cmd *cmd)
 	 * and some drives don't send them.  Sigh.
 	 */
 	if (rq->cmd[0] == GPCMD_REQUEST_SENSE &&
-	    cmd->nleft > 0 && cmd->nleft <= 5) {
-		unsigned int ofs = cmd->nbytes - cmd->nleft;
-
-		while (cmd->nleft > 0) {
-			*((u8 *)rq->data + ofs++) = 0;
-			cmd->nleft--;
-		}
-	}
+	    cmd->nleft > 0 && cmd->nleft <= 5)
+		cmd->nleft = 0;
 }
 
 int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
-- 
1.6.0.2

