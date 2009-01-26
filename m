From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/3] ide-cd: use ide_drive_t's rq in cdrom_queue_request_sense
Date: Mon, 26 Jan 2009 21:40:38 +0100
Message-ID: <1233002440-4325-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:48568 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbZAZUkr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2009 15:40:47 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

There should be no functionality change resulting from this patch.

Suggested-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index d3d5fb6..3907466 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -207,7 +207,7 @@ static void cdrom_queue_request_sense(ide_drive_t *drive, void *sense,
 				      struct request *failed_command)
 {
 	struct cdrom_info *info		= drive->driver_data;
-	struct request *rq		= &info->request_sense_request;
+	struct request *rq		= &drive->request_sense_rq;
 
 	ide_debug_log(IDE_DBG_SENSE, "Call %s\n", __func__);
 
-- 
1.6.0.4

