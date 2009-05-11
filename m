From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ide: remove driver_data direct access of struct device
Date: Mon, 11 May 2009 22:05:54 +0200
Message-ID: <4A088522.40202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f224.google.com ([209.85.219.224]:43692 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755492AbZEKUFx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 May 2009 16:05:53 -0400
Received: by ewy24 with SMTP id 24so3713758ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 11 May 2009 13:05:53 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

To avoid direct access to the driver_data pointer in struct device, the
functions dev_get_drvdata() and dev_set_drvdata() should be used.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 7f264ed..fad5272 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -550,7 +550,7 @@ static int ide_register_port(ide_hwif_t *hwif)
 
 	/* register with global device tree */
 	dev_set_name(&hwif->gendev, hwif->name);
-	hwif->gendev.driver_data = hwif;
+	dev_set_drvdata(&hwif->gendev, hwif);
 	if (hwif->gendev.parent == NULL)
 		hwif->gendev.parent = hwif->dev;
 	hwif->gendev.release = hwif_release_dev;
diff --git a/drivers/ide/ide_platform.c b/drivers/ide/ide_platform.c
index 051b4ab..028eda4 100644
--- a/drivers/ide/ide_platform.c
+++ b/drivers/ide/ide_platform.c
@@ -113,7 +113,7 @@ out:
 
 static int __devexit plat_ide_remove(struct platform_device *pdev)
 {
-	struct ide_host *host = pdev->dev.driver_data;
+	struct ide_host *host = dev_get_drvdata(&pdev->dev);
 
 	ide_host_remove(host);
 
