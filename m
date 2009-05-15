From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 07/15] ide-floppy/ide_floppy_get_sfrp_bit: use local buffer
Date: Fri, 15 May 2009 07:11:25 +0200
Message-ID: <1242364293-29223-8-git-send-email-petkovbb@gmail.com>
References: <1242364293-29223-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:39763 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbZEOFLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 May 2009 01:11:40 -0400
In-Reply-To: <1242364293-29223-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

There should be no functional change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-floppy_ioctl.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/ide-floppy_ioctl.c b/drivers/ide/ide-floppy_ioctl.c
index 9c2518d..0d2c9f0 100644
--- a/drivers/ide/ide-floppy_ioctl.c
+++ b/drivers/ide/ide-floppy_ioctl.c
@@ -117,16 +117,17 @@ static void ide_floppy_create_format_unit_cmd(struct ide_atapi_pc *pc, int b,
 static int ide_floppy_get_sfrp_bit(ide_drive_t *drive, struct ide_atapi_pc *pc)
 {
 	struct ide_disk_obj *floppy = drive->driver_data;
+	u8 buf[20];
 
 	drive->atapi_flags &= ~IDE_AFLAG_SRFP;
 
 	ide_floppy_create_mode_sense_cmd(pc, IDEFLOPPY_CAPABILITIES_PAGE);
 	pc->flags |= PC_FLAG_SUPPRESS_ERROR;
 
-	if (ide_queue_pc_tail(drive, floppy->disk, pc, pc->buf, pc->req_xfer))
+	if (ide_queue_pc_tail(drive, floppy->disk, pc, buf, pc->req_xfer))
 		return 1;
 
-	if (pc->buf[8 + 2] & 0x40)
+	if (buf[8 + 2] & 0x40)
 		drive->atapi_flags |= IDE_AFLAG_SRFP;
 
 	return 0;
-- 
1.6.3

