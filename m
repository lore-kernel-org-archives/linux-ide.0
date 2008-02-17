From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/4] ide-disk: add missing printk() KERN_* levels
Date: Sun, 17 Feb 2008 20:52:48 +0100
Message-ID: <200802172052.48836.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:51272 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbYBQTj4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 14:39:56 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1462677fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 17 Feb 2008 11:39:54 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -867,7 +867,7 @@ static void idedisk_setup (ide_drive_t *
 
 	/* Only print cache size when it was specified */
 	if (id->buf_size)
-		printk (" w/%dKiB Cache", id->buf_size/2);
+		printk(KERN_CONT " w/%dKiB Cache", id->buf_size / 2);
 
 	printk(KERN_CONT ", CHS=%d/%d/%d\n",
 			 drive->bios_cyl, drive->bios_head, drive->bios_sect);
@@ -949,7 +949,8 @@ static void ide_device_shutdown(ide_driv
 		return;
 	}
 
-	printk("Shutdown: %s\n", drive->name);
+	printk(KERN_INFO "Shutdown: %s\n", drive->name);
+
 	drive->gendev.bus->suspend(&drive->gendev, PMSG_SUSPEND);
 }
 
