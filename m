From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] sc1200: remove redundant warning message from sc1200_tune_chipset()
Date: Fri, 13 Jul 2007 23:10:50 +0200
Message-ID: <200707132310.50310.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:44974 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbXGMVbI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 17:31:08 -0400
Received: by ug-out-1314.google.com with SMTP id j3so647448ugf
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 14:31:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


ide_config_drive_speed() called by sc1200_set_xfer_mode() already gives
a meaningful warning message in case of failure.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sc1200.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -149,10 +149,8 @@ static int sc1200_tune_chipset(ide_drive
 	/*
 	 * Tell the drive to switch to the new mode; abort on failure.
 	 */
-	if (sc1200_set_xfer_mode(drive, mode)) {
-		printk("SC1200: set xfer mode failure\n");
+	if (sc1200_set_xfer_mode(drive, mode))
 		return 1;	/* failure */
-	}
 
 	switch (mode) {
 	case XFER_PIO_4:
