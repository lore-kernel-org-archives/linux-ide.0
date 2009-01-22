From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/8] ide: classify device type in do_probe()
Date: Thu, 22 Jan 2009 15:18:35 +0100
Message-ID: <20090122141835.25516.67428.sendpatchset@localhost.localdomain>
References: <20090122141801.25516.5620.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:14318 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758486AbZAVOSG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 09:18:06 -0500
In-Reply-To: <20090122141801.25516.5620.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: classify device type in do_probe()

Defer classifying device type from do_identify() to do_probe().

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -233,16 +233,6 @@ static void do_identify(ide_drive_t *dri
 	drive->dev_flags |= IDE_DFLAG_PRESENT;
 	drive->dev_flags &= ~IDE_DFLAG_DEAD;
 
-	/*
-	 * Check for an ATAPI device
-	 */
-	if (cmd == ATA_CMD_ID_ATAPI)
-		ide_classify_atapi_dev(drive);
-	else
-	/*
-	 * Not an ATAPI device: looks like a "regular" hard disk
-	 */
-		ide_classify_ata_dev(drive);
 	return;
 err_misc:
 	kfree(id);
@@ -480,6 +470,8 @@ static int do_probe (ide_drive_t *drive,
 static u8 probe_for_drive(ide_drive_t *drive)
 {
 	char *m;
+	int rc;
+	u8 cmd;
 
 	/*
 	 *	In order to keep things simple we have an id
@@ -504,9 +496,13 @@ static u8 probe_for_drive(ide_drive_t *d
 	/* skip probing? */
 	if ((drive->dev_flags & IDE_DFLAG_NOPROBE) == 0) {
 		/* if !(success||timed-out) */
-		if (do_probe(drive, ATA_CMD_ID_ATA) >= 2)
+		cmd = ATA_CMD_ID_ATA;
+		rc = do_probe(drive, cmd);
+		if (rc >= 2) {
 			/* look for ATAPI device */
-			(void)do_probe(drive, ATA_CMD_ID_ATAPI);
+			cmd = ATA_CMD_ID_ATAPI;
+			rc = do_probe(drive, cmd);
+		}
 
 		if ((drive->dev_flags & IDE_DFLAG_PRESENT) == 0)
 			/* drive not found */
@@ -525,8 +521,12 @@ static u8 probe_for_drive(ide_drive_t *d
 				printk(KERN_WARNING "%s: Unknown device on bus refused identification. Ignoring.\n", drive->name);
 				drive->dev_flags &= ~IDE_DFLAG_PRESENT;
 			}
+		} else {
+			if (cmd == ATA_CMD_ID_ATAPI)
+				ide_classify_atapi_dev(drive);
+			else
+				ide_classify_ata_dev(drive);
 		}
-		/* drive was found */
 	}
 
 	if ((drive->dev_flags & IDE_DFLAG_PRESENT) == 0)
