From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 10/15] ide-floppy/ide_floppy_get_format_progress: use local sense buffer
Date: Fri, 15 May 2009 07:11:28 +0200
Message-ID: <1242364293-29223-11-git-send-email-petkovbb@gmail.com>
References: <1242364293-29223-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:48879 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405AbZEOFLl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 May 2009 01:11:41 -0400
In-Reply-To: <1242364293-29223-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

There should be no functional change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-floppy_ioctl.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-floppy_ioctl.c b/drivers/ide/ide-floppy_ioctl.c
index 7a03d34..3a1f9b5 100644
--- a/drivers/ide/ide-floppy_ioctl.c
+++ b/drivers/ide/ide-floppy_ioctl.c
@@ -198,11 +198,12 @@ static int ide_floppy_get_format_progress(ide_drive_t *drive,
 					  int __user *arg)
 {
 	struct ide_disk_obj *floppy = drive->driver_data;
+	u8 sense_buf[18];
 	int progress_indication = 0x10000;
 
 	if (drive->atapi_flags & IDE_AFLAG_SRFP) {
 		ide_create_request_sense_cmd(drive, pc);
-		if (ide_queue_pc_tail(drive, floppy->disk, pc, pc->buf,
+		if (ide_queue_pc_tail(drive, floppy->disk, pc, sense_buf,
 				      pc->req_xfer))
 			return -EIO;
 
-- 
1.6.3

