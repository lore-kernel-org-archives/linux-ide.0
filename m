From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/6] ide: small ide_register_port() cleanup
Date: Wed, 12 Nov 2008 22:16:06 +0100
Message-ID: <200811122216.06257.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:8933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708AbYKLVc7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Nov 2008 16:32:59 -0500
Received: by ti-out-0910.google.com with SMTP id b6so351770tic.23
        for <linux-ide@vger.kernel.org>; Wed, 12 Nov 2008 13:32:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -640,14 +640,9 @@ static int ide_register_port(ide_hwif_t 
 	/* register with global device tree */
 	dev_set_name(&hwif->gendev, hwif->name);
 	hwif->gendev.driver_data = hwif;
-	if (hwif->gendev.parent == NULL) {
-		if (hwif->dev)
-			hwif->gendev.parent = hwif->dev;
-		else
-			/* Would like to do = &device_legacy */
-			hwif->gendev.parent = NULL;
-	}
+	hwif->gendev.parent = hwif->dev;
 	hwif->gendev.release = hwif_release_dev;
+
 	ret = device_register(&hwif->gendev);
 	if (ret < 0) {
 		printk(KERN_WARNING "IDE: %s: device_register error: %d\n",
