From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 26/40] ide-{cd,floppy,tape}: remove checking for drive->scsi
Date: Sun, 18 May 2008 20:58:22 +0200
Message-ID: <20080518185822.5636.29856.sendpatchset@localhost.localdomain>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.187]:18768 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757198AbYERSk5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 14:40:57 -0400
Received: by gv-out-0910.google.com with SMTP id e6so243317gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 11:40:56 -0700 (PDT)
In-Reply-To: <20080518185428.5636.77234.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Remove checking for drive->scsi which is no longer set by IDE core code
(leave the flag since it will be re-used for generic ATAPI support).

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c     |    5 -----
 drivers/ide/ide-floppy.c |    5 -----
 drivers/ide/ide-tape.c   |    5 -----
 3 files changed, 15 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -2106,11 +2106,6 @@ static int ide_cd_probe(ide_drive_t *dri
 			goto failed;
 		}
 	}
-	if (drive->scsi) {
-		printk(KERN_INFO "ide-cd: passing drive %s to ide-scsi "
-				 "emulation.\n", drive->name);
-		goto failed;
-	}
 	info = kzalloc(sizeof(struct cdrom_info), GFP_KERNEL);
 	if (info == NULL) {
 		printk(KERN_ERR "%s: Can't allocate a cdrom structure\n",
Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -1579,11 +1579,6 @@ static int ide_floppy_probe(ide_drive_t 
 				" of ide-floppy\n", drive->name);
 		goto failed;
 	}
-	if (drive->scsi) {
-		printk(KERN_INFO "ide-floppy: passing drive %s to ide-scsi"
-				" emulation.\n", drive->name);
-		goto failed;
-	}
 	floppy = kzalloc(sizeof(idefloppy_floppy_t), GFP_KERNEL);
 	if (!floppy) {
 		printk(KERN_ERR "ide-floppy: %s: Can't allocate a floppy"
Index: b/drivers/ide/ide-tape.c
===================================================================
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -2850,11 +2850,6 @@ static int ide_tape_probe(ide_drive_t *d
 				" the driver\n", drive->name);
 		goto failed;
 	}
-	if (drive->scsi) {
-		printk(KERN_INFO "ide-tape: passing drive %s to ide-scsi"
-				 " emulation.\n", drive->name);
-		goto failed;
-	}
 	tape = kzalloc(sizeof(idetape_tape_t), GFP_KERNEL);
 	if (tape == NULL) {
 		printk(KERN_ERR "ide-tape: %s: Can't allocate a tape struct\n",
