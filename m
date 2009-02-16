From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 07/20] ide-cd: remove no longer needed 'ignore' module parameter
Date: Mon, 16 Feb 2009 01:13:55 +0100
Message-ID: <20090216001355.27491.56986.sendpatchset@localhost.localdomain>
References: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:34049 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111AbZBPAMc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 19:12:32 -0500
In-Reply-To: <20090216001309.27491.59759.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide-cd: remove no longer needed 'ignore' module parameter

ide-scsi is gone...

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |   12 ------------
 1 file changed, 12 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1932,9 +1932,6 @@ static struct block_device_operations id
 };
 
 /* module options */
-static char *ignore;
-module_param(ignore, charp, 0400);
-
 static unsigned long debug_mask;
 module_param(debug_mask, ulong, 0644);
 
@@ -1955,15 +1952,6 @@ static int ide_cd_probe(ide_drive_t *dri
 	if (drive->media != ide_cdrom && drive->media != ide_optical)
 		goto failed;
 
-	/* skip drives that we were told to ignore */
-	if (ignore != NULL) {
-		if (strstr(ignore, drive->name)) {
-			printk(KERN_INFO PFX "ignoring drive %s\n",
-					 drive->name);
-			goto failed;
-		}
-	}
-
 	drive->debug_mask = debug_mask;
 	drive->irq_handler = cdrom_newpc_intr;
 
