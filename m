From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 5/5] ide-floppy: add a debug_mask module parameter
Date: Sun, 17 Aug 2008 19:23:46 +0200
Message-ID: <1218993826-4571-6-git-send-email-petkovbb@gmail.com>
References: <1218993826-4571-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:33166 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbYHQRXt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 13:23:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1456292fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 10:23:48 -0700 (PDT)
In-Reply-To: <1218993826-4571-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej@gollum.tnic, Zolnierkiewicz@gollum.tnic, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

... with which to control to verbosity of debug messages on module load time.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-floppy.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index 3de9478..85022b8 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -49,6 +49,9 @@
 
 #include "ide-floppy.h"
 
+/* module parameters */
+static unsigned long debug_mask = 0x0;
+
 /* define to see debug info */
 #define IDEFLOPPY_DEBUG_LOG	0
 
@@ -679,6 +682,8 @@ static ide_driver_t idefloppy_driver = {
 #endif
 };
 
+module_param(debug_mask, ulong, 0644);
+
 static int idefloppy_open(struct inode *inode, struct file *filp)
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
@@ -692,6 +697,8 @@ static int idefloppy_open(struct inode *inode, struct file *filp)
 
 	drive = floppy->drive;
 
+	drive->debug_mask = debug_mask;
+
 	ide_debug_log(IDE_DBG_FUNC, "Call %s\n", __func__);
 
 	floppy->openers++;
-- 
1.5.5.4

