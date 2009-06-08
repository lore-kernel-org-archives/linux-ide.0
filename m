From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: filter out invalid DMA xfer mode changes in HDIO_DRIVE_CMD ioctl handler
Date: Mon, 8 Jun 2009 22:23:13 +0200
Message-ID: <200906082223.14128.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:41229 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZFHUdL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jun 2009 16:33:11 -0400
Received: by ewy6 with SMTP id 6so4502448ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 08 Jun 2009 13:33:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
against ide-2.6.git/for-next

 drivers/ide/ide-ioctls.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

Index: b/drivers/ide/ide-ioctls.c
===================================================================
--- a/drivers/ide/ide-ioctls.c
+++ b/drivers/ide/ide-ioctls.c
@@ -118,7 +118,6 @@ static int ide_cmd_ioctl(ide_drive_t *dr
 	u8 args[4], xfer_rate = 0;
 	struct ide_cmd cmd;
 	struct ide_taskfile *tf = &cmd.tf;
-	u16 *id = drive->id;
 
 	if (NULL == (void *) arg) {
 		struct request *rq;
@@ -161,14 +160,10 @@ static int ide_cmd_ioctl(ide_drive_t *dr
 
 	if (tf->command == ATA_CMD_SET_FEATURES &&
 	    tf->feature == SETFEATURES_XFER &&
-	    tf->nsect >= XFER_SW_DMA_0 &&
-	    (id[ATA_ID_UDMA_MODES] ||
-	     id[ATA_ID_MWDMA_MODES] ||
-	     id[ATA_ID_SWDMA_MODES])) {
-		xfer_rate = args[1];
-		if (tf->nsect > XFER_UDMA_2 && !eighty_ninty_three(drive)) {
-			printk(KERN_WARNING "%s: UDMA speeds >UDMA33 cannot "
-					    "be set\n", drive->name);
+	    tf->nsect >= XFER_SW_DMA_0) {
+		xfer_rate = ide_find_dma_mode(drive, XFER_UDMA_6);
+		if (xfer_rate != tf->nsect) {
+			err = -EINVAL;
 			goto abort;
 		}
 	}
