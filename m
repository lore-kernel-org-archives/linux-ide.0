From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 03/21] ide-floppy: remove unnecessary ->handler != NULL check
Date: Fri, 11 Jan 2008 12:58:01 +0100
Message-ID: <1200052699-28420-4-git-send-email-bbpetkov@yahoo.de>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-2-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-3-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp110.plus.mail.re1.yahoo.com ([69.147.102.73]:21100 "HELO
	smtp110.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758100AbYAKMD1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 07:03:27 -0500
In-Reply-To: <1200052699-28420-3-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej@gollum.tnic, Zolnierkiewicz@gollum.tnic, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

This BUG_ON is unneeded since the ->handler != NULL check is performed in
ide_set_handler().

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index e63758a..66dfd18 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -794,7 +794,7 @@ static ide_startstop_t idefloppy_pc_intr (ide_drive_t *drive)
 					"to send us more data than expected "
 					"- discarding data\n");
 				idefloppy_discard_data(drive, bcount);
-				BUG_ON(HWGROUP(drive)->handler != NULL);
+
 				ide_set_handler(drive,
 						&idefloppy_pc_intr,
 						IDEFLOPPY_WAIT_CMD,
@@ -825,7 +825,6 @@ static ide_startstop_t idefloppy_pc_intr (ide_drive_t *drive)
 	pc->actually_transferred += bcount;
 	pc->current_position += bcount;
 
-	BUG_ON(HWGROUP(drive)->handler != NULL);
 	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);		/* And set the interrupt handler again */
 	return ide_started;
 }
@@ -852,7 +851,7 @@ static ide_startstop_t idefloppy_transfer_pc (ide_drive_t *drive)
 				"issuing a packet command\n");
 		return ide_do_reset(drive);
 	}
-	BUG_ON(HWGROUP(drive)->handler != NULL);
+
 	/* Set the interrupt routine */
 	ide_set_handler(drive, &idefloppy_pc_intr, IDEFLOPPY_WAIT_CMD, NULL);
 	/* Send the actual packet */
@@ -908,7 +907,7 @@ static ide_startstop_t idefloppy_transfer_pc1 (ide_drive_t *drive)
 	 * 40 and 50msec work well. idefloppy_pc_intr will not be actually
 	 * used until after the packet is moved in about 50 msec.
 	 */
-	BUG_ON(HWGROUP(drive)->handler != NULL);
+
 	ide_set_handler(drive, 
 	  &idefloppy_pc_intr, 		/* service routine for packet command */
 	  floppy->ticks,		/* wait this long before "failing" */
-- 
1.5.3.7

