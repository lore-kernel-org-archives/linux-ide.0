From: Rusty Trivial Russell <rusty@rustcorp.com.au>
Subject: [TRIVIAL] Re: oneliners for ide-probe: Patch seems outdated, and has been ignored
Date: Fri, 06 Dec 2002 13:59:39 +1100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20021206035757.1C5862C29A@lists.samba.org>
Return-path: <linux-ide-owner@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

From:  "James McMechan" <james_mcmechan@hotmail.com>

  With this patch it boots and now behaves according to the comment above the
  if statement and tests the slave device if the master device is flash. Now
  it also tests the slave device if the slave device is flash but that is ok.
  It used to test and disable the master device if the slave was flash.

--- trivial-2.5-bk/drivers/ide/ide-probe.c.orig	2002-12-06 13:56:30.000000000 +1100
+++ trivial-2.5-bk/drivers/ide/ide-probe.c	2002-12-06 13:56:30.000000000 +1100
@@ -214,7 +214,7 @@
 	 */
 	drive->is_flash = 0;
 	if (drive_is_flashcard(drive)) {
-		ide_drive_t *mate = &hwif->drives[1^drive->select.b.unit];
+		ide_drive_t *mate = &hwif->drives[1];
 		if (!mate->ata_flash) {
 			mate->present = 0;
 			mate->noprobe = 1;
-- 
  Don't blame me: the Monkey is driving
  File: "James McMechan" <james_mcmechan@hotmail.com>: Re: oneliners for ide-probe: Patch seems outdated, and has been ignored
