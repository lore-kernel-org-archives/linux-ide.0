From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [RESEND PATCH 07/10] ide-floppy: remove unnecessary ->handler != NULL check
Date: Thu,  3 Jan 2008 14:20:06 +0100
Message-ID: <1199366409-26016-8-git-send-email-bbpetkov@yahoo.de>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de>
 <1199366409-26016-2-git-send-email-bbpetkov@yahoo.de>
 <1199366409-26016-3-git-send-email-bbpetkov@yahoo.de>
 <1199366409-26016-4-git-send-email-bbpetkov@yahoo.de>
 <1199366409-26016-5-git-send-email-bbpetkov@yahoo.de>
 <1199366409-26016-6-git-send-email-bbpetkov@yahoo.de>
 <1199366409-26016-7-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp110.plus.mail.re1.yahoo.com ([69.147.102.73]:24652 "HELO
	smtp110.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752866AbYACNXN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jan 2008 08:23:13 -0500
In-Reply-To: <1199366409-26016-7-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bzolnier@gmail.com, Borislav Petkov <bbpetkov@yahoo.de>

This BUG_ON is unneeded since the ->handler != NULL check is performed in
ide_set_handler().

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 5d0fd1f..2c139e7 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -421,7 +421,7 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive_t *drive)
 					"to send us more data than expected "
 					"- discarding data\n");
 				idefloppy_discard_data(drive,bcount.all);
-				BUG_ON(HWGROUP(drive)->handler != NULL);
+
 				ide_set_handler(drive,
 						&idefloppy_pc_intr,
 						IDEFLOPPY_WAIT_CMD,
@@ -453,8 +453,6 @@ static ide_startstop_t idefloppy_pc_intr(ide_drive_t *drive)
 	pc->actually_transferred += bcount.all;
 	pc->current_position += bcount.all;
 
-	BUG_ON(HWGROUP(drive)->handler != NULL);
-
 	/* And set the interrupt handler again */
 	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);
 	return ide_started;
@@ -482,7 +480,7 @@ static ide_startstop_t idefloppy_transfer_pc(ide_drive_t *drive)
 				"issuing a packet command\n");
 		return ide_do_reset(drive);
 	}
-	BUG_ON(HWGROUP(drive)->handler != NULL);
+
 	/* Set the interrupt routine */
 	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);
 	/* Send the actual packet */
@@ -537,7 +535,7 @@ static ide_startstop_t idefloppy_transfer_pc1(ide_drive_t *drive)
 	 * 40 and 50msec work well. idefloppy_pc_intr will not be actually
 	 * used until after the packet is moved in about 50 msec.
 	 */
-	BUG_ON(HWGROUP(drive)->handler != NULL);
+
 	ide_set_handler(drive,
 	  &idefloppy_pc_intr,		/* service routine for packet command */
 	  floppy->ticks,		/* wait this long before "failing" */
-- 
1.5.3.7

