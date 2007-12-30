From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] au1xxx-ide/rapide: use hwif->index for ide_unregister()
Date: Sun, 30 Dec 2007 18:25:30 +0100
Message-ID: <200712301825.30370.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:7104 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038AbXL3Rbm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Dec 2007 12:31:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2175210ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 30 Dec 2007 09:31:40 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>


Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/rapide.c      |    4 ++--
 drivers/ide/mips/au1xxx-ide.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -78,8 +78,8 @@ static void __devexit rapide_remove(stru
 
 	ecard_set_drvdata(ec, NULL);
 
-	/* there must be a better way */
-	ide_unregister(hwif - ide_hwifs);
+	ide_unregister(hwif->index);
+
 	ecard_release_resources(ec);
 }
 
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -691,7 +691,7 @@ static int au_ide_remove(struct device *
 	ide_hwif_t *hwif = dev_get_drvdata(dev);
 	_auide_hwif *ahwif = &auide_hwif;
 
-	ide_unregister(hwif - ide_hwifs);
+	ide_unregister(hwif->index);
 
 	iounmap((void *)ahwif->regbase);
 
