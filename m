From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/2] ide-cd: reverse NOT_READY sense key logic
Date: Sun,  5 Apr 2009 11:16:01 +0200
Message-ID: <1238922962-19727-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:42307 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222AbZDEJQK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Apr 2009 05:16:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Make the case of flushing the drive's cache explicit.

There should be no functional change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 2989aa8..2aa13d8 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -341,15 +341,15 @@ static int cdrom_decode_status(ide_drive_t *drive, u8 stat)
 
 	switch (sense_key) {
 	case NOT_READY:
-		if (blk_fs_request(rq) == 0 || rq_data_dir(rq) == READ) {
+		if (blk_fs_request(rq) && rq_data_dir(rq) == WRITE) {
+			if (ide_cd_breathe(drive, rq))
+				return 1;
+		} else {
 			cdrom_saw_media_change(drive);
 
 			if (blk_fs_request(rq) && !quiet)
 				printk(KERN_ERR PFX "%s: tray open\n",
 					drive->name);
-		} else {
-			if (ide_cd_breathe(drive, rq))
-				return 1;
 		}
 		do_end_request = 1;
 		break;
-- 
1.6.2.1

