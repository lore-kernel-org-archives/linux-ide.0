From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-cd: fix debug printk
Date: Fri, 19 Sep 2008 19:38:03 +0200
Message-ID: <20080919173803.GA21355@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:62371 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbYISRiM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Sep 2008 13:38:12 -0400
Received: by mu-out-0910.google.com with SMTP id g7so428303muf.1
        for <linux-ide@vger.kernel.org>; Fri, 19 Sep 2008 10:38:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Bart,

please apply.
---
From: Borislav Petkov <petkovbb@gmail.com>
Date: Fri, 19 Sep 2008 19:30:46 +0200
Subject: [PATCH] ide-cd: fix debug printk

failed_command can be NULL so check it before accessing it.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 3fdf660..5ed925d 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -221,6 +221,8 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
 	struct cdrom_info *info		= drive->driver_data;
 	struct request *rq		= &info->request_sense_request;
 
+	ide_debug_log(IDE_DBG_SENSE, "Call %s\n", __func__);
+
 	if (sense == NULL)
 		sense = &info->sense_data;
 
@@ -240,8 +242,9 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
 	/* NOTE! Save the failed command in "rq->buffer" */
 	rq->buffer = (void *) failed_command;
 
-	ide_debug_log(IDE_DBG_SENSE, "Call %s, failed_cmd: 0x%x\n", __func__,
-		      failed_command->cmd[0]);
+	if (failed_command)
+		ide_debug_log(IDE_DBG_SENSE, "failed_cmd: 0x%x\n",
+			      failed_command->cmd[0]);
 
 	ide_do_drive_cmd(drive, rq);
 }
-- 
1.5.5.1

-- 
Regards/Gruss,
    Boris.
