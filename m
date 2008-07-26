From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/10] ide: fix EXABYTENEST handling in probe_for_drive()
Date: Sat, 26 Jul 2008 15:40:17 +0200
Message-ID: <20080726134017.10589.12439.sendpatchset@localhost.localdomain>
References: <20080726134010.10589.51679.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:59814 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbYGZNmV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 26 Jul 2008 09:42:21 -0400
Received: by mu-out-0910.google.com with SMTP id w8so3564304mue.1
        for <linux-ide@vger.kernel.org>; Sat, 26 Jul 2008 06:42:20 -0700 (PDT)
In-Reply-To: <20080726134010.10589.51679.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Fix EXABYTENEST handling in probe_for_drive() (so drive->present
is checked for "nested" device) and cleanup enable_nest().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -542,11 +542,6 @@ static void enable_nest (ide_drive_t *dr
 		printk(KERN_CONT "failed (status = 0x%02x)\n", stat);
 	else
 		printk(KERN_CONT "success\n");
-
-	/* if !(success||timed-out) */
-	if (do_probe(drive, ATA_CMD_ID_ATA) >= 2)
-		/* look for ATAPI device */
-		(void)do_probe(drive, ATA_CMD_ID_ATAPI);
 }
 
 /**
@@ -586,19 +581,22 @@ static inline u8 probe_for_drive (ide_dr
 	strcpy(m, "UNKNOWN");
 
 	/* skip probing? */
-	if (!drive->noprobe)
-	{
+	if (!drive->noprobe) {
+retry:
 		/* if !(success||timed-out) */
 		if (do_probe(drive, ATA_CMD_ID_ATA) >= 2)
 			/* look for ATAPI device */
 			(void)do_probe(drive, ATA_CMD_ID_ATAPI);
+
 		if (!drive->present)
 			/* drive not found */
 			return 0;
 
-		if (strstr(m, "E X A B Y T E N E S T"))
+		if (strstr(m, "E X A B Y T E N E S T")) {
 			enable_nest(drive);
-	
+			goto retry;
+		}
+
 		/* identification failed? */
 		if (!drive->id_read) {
 			if (drive->media == ide_disk) {
