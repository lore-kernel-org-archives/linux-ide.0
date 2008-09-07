From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 07/18] ide-floppy: drop 'floppy' argument from idefloppy_setup()
Date: Mon, 08 Sep 2008 00:15:12 +0200
Message-ID: <20080907221512.24285.56064.sendpatchset@localhost.localdomain>
References: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:25685 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848AbYIGWRU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 18:17:20 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1100873muf.1
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 15:17:20 -0700 (PDT)
In-Reply-To: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-floppy.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-floppy.c
===================================================================
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -560,8 +560,9 @@ sector_t ide_floppy_capacity(ide_drive_t
 	return capacity;
 }
 
-static void idefloppy_setup(ide_drive_t *drive, idefloppy_floppy_t *floppy)
+static void idefloppy_setup(ide_drive_t *drive)
 {
+	struct ide_floppy_obj *floppy = drive->driver_data;
 	u16 *id = drive->id;
 
 	drive->pc_callback	 = ide_floppy_callback;
@@ -808,7 +809,7 @@ static int ide_floppy_probe(ide_drive_t 
 
 	drive->debug_mask = debug_mask;
 
-	idefloppy_setup(drive, floppy);
+	idefloppy_setup(drive);
 
 	g->minors = 1 << PARTN_BITS;
 	g->driverfs_dev = &drive->gendev;
