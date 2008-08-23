From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 2/2] ide-cd: add a debug_mask module parameter
Date: Sat, 23 Aug 2008 15:08:43 +0200
Message-ID: <1219496923-20868-2-git-send-email-petkovbb@gmail.com>
References: <1219496923-20868-1-git-send-email-petkovbb@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:39831 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbYHWNIo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2008 09:08:44 -0400
Received: by fk-out-0910.google.com with SMTP id 18so533040fkq.5
        for <linux-ide@vger.kernel.org>; Sat, 23 Aug 2008 06:08:42 -0700 (PDT)
In-Reply-To: <1219496923-20868-1-git-send-email-petkovbb@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-cd.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index cca1011..5e0b9cd 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -53,6 +53,8 @@
 
 #include "ide-cd.h"
 
+static unsigned long debug_mask = 0x0;
+
 #define IDECD_DEBUG_LOG		1
 
 #if IDECD_DEBUG_LOG
@@ -2192,8 +2194,9 @@ static struct block_device_operations idecd_ops = {
 
 /* module options */
 static char *ignore;
-
 module_param(ignore, charp, 0400);
+module_param(debug_mask, ulong, 0644);
+
 MODULE_DESCRIPTION("ATAPI CD-ROM Driver");
 
 static int ide_cd_probe(ide_drive_t *drive)
@@ -2220,6 +2223,9 @@ static int ide_cd_probe(ide_drive_t *drive)
 			goto failed;
 		}
 	}
+
+	drive->debug_mask = debug_mask;
+
 	info = kzalloc(sizeof(struct cdrom_info), GFP_KERNEL);
 	if (info == NULL) {
 		printk(KERN_ERR PFX "%s: Can't allocate a cdrom structure\n",
-- 
1.5.5.4

