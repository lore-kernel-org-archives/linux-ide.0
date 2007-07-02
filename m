From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] amd74xx: resume fix
Date: Tue, 3 Jul 2007 01:45:29 +0200
Message-ID: <200707030145.29428.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:18178 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214AbXGBX3v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 19:29:51 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1358826ugf
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 16:29:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Driver can't skip programming transfer mode on the device in amd_set_drive()
  (similar fix has been applied to via82cxxx driver ages ago).

* While at it remove redundant warning (ide_config_drive_speed() already
  produces more valuable one).

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
for 2.6.22-final

 drivers/ide/pci/amd74xx.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -1,5 +1,5 @@
 /*
- * Version 2.15
+ * Version 2.16
  *
  * AMD 755/756/766/8111 and nVidia nForce/2/2s/3/3s/CK804/MCP04
  * IDE driver for Linux.
@@ -244,10 +244,8 @@ static int amd_set_drive(ide_drive_t *dr
 	struct ide_timing t, p;
 	int T, UT;
 
-	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
-		if (ide_config_drive_speed(drive, speed))
-			printk(KERN_WARNING "ide%d: Drive %d didn't accept speed setting. Oh, well.\n",
-				drive->dn >> 1, drive->dn & 1);
+	if (speed != XFER_PIO_SLOW)
+		ide_config_drive_speed(drive, speed);
 
 	T = 1000000000 / amd_clock;
 	UT = T / min_t(int, max_t(int, amd_config->flags & AMD_UDMA, 1), 2);
