From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/7] hd: WIN_* -> ATA_CMD_*
Date: Wed, 23 Jul 2008 20:43:38 +0200
Message-ID: <200807232043.38746.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:29899 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbYGWSuV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 14:50:21 -0400
Received: by ug-out-1314.google.com with SMTP id h2so532787ugf.16
        for <linux-ide@vger.kernel.org>; Wed, 23 Jul 2008 11:50:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

* Use ATA_CMD_* defines instead of WIN_* ones.

* Include <linux/ata.h> directly instead of through <linux/hdreg.h>.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/block/hd.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: b/drivers/block/hd.c
===================================================================
--- a/drivers/block/hd.c
+++ b/drivers/block/hd.c
@@ -39,6 +39,7 @@
 #include <linux/ioport.h>
 #include <linux/init.h>
 #include <linux/blkpg.h>
+#include <linux/ata.h>
 #include <linux/hdreg.h>
 
 #define REALLY_SLOW_IO
@@ -370,7 +371,7 @@ repeat:
 		struct hd_i_struct *disk = &hd_info[i];
 		disk->special_op = disk->recalibrate = 1;
 		hd_out(disk, disk->sect, disk->sect, disk->head-1,
-			disk->cyl, WIN_SPECIFY, &reset_hd);
+			disk->cyl, ATA_CMD_INIT_DEV_PARAMS, &reset_hd);
 		if (reset)
 			goto repeat;
 	} else
@@ -558,7 +559,7 @@ static int do_special_op(struct hd_i_str
 {
 	if (disk->recalibrate) {
 		disk->recalibrate = 0;
-		hd_out(disk, disk->sect, 0, 0, 0, WIN_RESTORE, &recal_intr);
+		hd_out(disk, disk->sect, 0, 0, 0, ATA_CMD_RESTORE, &recal_intr);
 		return reset;
 	}
 	if (disk->head > 16) {
@@ -631,13 +632,13 @@ repeat:
 	if (blk_fs_request(req)) {
 		switch (rq_data_dir(req)) {
 		case READ:
-			hd_out(disk, nsect, sec, head, cyl, WIN_READ,
+			hd_out(disk, nsect, sec, head, cyl, ATA_CMD_PIO_READ,
 				&read_intr);
 			if (reset)
 				goto repeat;
 			break;
 		case WRITE:
-			hd_out(disk, nsect, sec, head, cyl, WIN_WRITE,
+			hd_out(disk, nsect, sec, head, cyl, ATA_CMD_PIO_WRITE,
 				&write_intr);
 			if (reset)
 				goto repeat;
