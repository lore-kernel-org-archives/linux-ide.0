From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 08/15] ide-floppy/ide_floppy_format_unit: use local buffer
Date: Fri, 15 May 2009 07:11:26 +0200
Message-ID: <1242364293-29223-9-git-send-email-petkovbb@gmail.com>
References: <1242364293-29223-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f174.google.com ([209.85.218.174]:59083 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbZEOFLk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 May 2009 01:11:40 -0400
In-Reply-To: <1242364293-29223-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Pass the buffer into ide_floppy_create_format_unit_cmd instead of using
pc->buf.

There should be no functional change resulting from this patch.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-floppy_ioctl.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/ide/ide-floppy_ioctl.c b/drivers/ide/ide-floppy_ioctl.c
index 0d2c9f0..7a03d34 100644
--- a/drivers/ide/ide-floppy_ioctl.c
+++ b/drivers/ide/ide-floppy_ioctl.c
@@ -93,24 +93,25 @@ static int ide_floppy_get_format_capacities(ide_drive_t *drive,
 	return 0;
 }
 
-static void ide_floppy_create_format_unit_cmd(struct ide_atapi_pc *pc, int b,
-		int l, int flags)
+static void ide_floppy_create_format_unit_cmd(struct ide_atapi_pc *pc,
+					      u8 *buf, int b, int l,
+					      int flags)
 {
 	ide_init_pc(pc);
 	pc->c[0] = GPCMD_FORMAT_UNIT;
 	pc->c[1] = 0x17;
 
-	memset(pc->buf, 0, 12);
-	pc->buf[1] = 0xA2;
+	memset(buf, 0, 12);
+	buf[1] = 0xA2;
 	/* Default format list header, u8 1: FOV/DCRT/IMM bits set */
 
 	if (flags & 1)				/* Verify bit on... */
-		pc->buf[1] ^= 0x20;		/* ... turn off DCRT bit */
-	pc->buf[3] = 8;
+		buf[1] ^= 0x20;			/* ... turn off DCRT bit */
+	buf[3] = 8;
 
-	put_unaligned(cpu_to_be32(b), (unsigned int *)(&pc->buf[4]));
-	put_unaligned(cpu_to_be32(l), (unsigned int *)(&pc->buf[8]));
-	pc->buf_size = 12;
+	put_unaligned(cpu_to_be32(b), (unsigned int *)(&buf[4]));
+	put_unaligned(cpu_to_be32(l), (unsigned int *)(&buf[8]));
+	pc->req_xfer = 12;
 	pc->flags |= PC_FLAG_WRITING;
 }
 
@@ -137,6 +138,7 @@ static int ide_floppy_format_unit(ide_drive_t *drive, struct ide_atapi_pc *pc,
 				  int __user *arg)
 {
 	struct ide_disk_obj *floppy = drive->driver_data;
+	u8 buf[12];
 	int blocks, length, flags, err = 0;
 
 	if (floppy->openers > 1) {
@@ -170,9 +172,9 @@ static int ide_floppy_format_unit(ide_drive_t *drive, struct ide_atapi_pc *pc,
 	}
 
 	ide_floppy_get_sfrp_bit(drive, pc);
-	ide_floppy_create_format_unit_cmd(pc, blocks, length, flags);
+	ide_floppy_create_format_unit_cmd(pc, buf, blocks, length, flags);
 
-	if (ide_queue_pc_tail(drive, floppy->disk, pc, pc->buf, pc->req_xfer))
+	if (ide_queue_pc_tail(drive, floppy->disk, pc, buf, pc->req_xfer))
 		err = -EIO;
 
 out:
-- 
1.6.3

