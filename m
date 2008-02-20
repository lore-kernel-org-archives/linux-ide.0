From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide_platform: fix resources handling
Date: Wed, 20 Feb 2008 01:45:36 +0100
Message-ID: <200802200145.36275.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:37168 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbYBTAg1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 19:36:27 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2708594fkz.5
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2008 16:36:25 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Vitaly Bordug <vitb@kernel.crashing.org>

Tell IDE layer to not manage resources by always setting hwif->mmio flag
(resources are handled by a platform device).

Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ide_platform.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: b/drivers/ide/legacy/ide_platform.c
===================================================================
--- a/drivers/ide/legacy/ide_platform.c
+++ b/drivers/ide/legacy/ide_platform.c
@@ -100,11 +100,10 @@ static int __devinit plat_ide_probe(stru
 	hw.dev = &pdev->dev;
 
 	ide_init_port_hw(hwif, &hw);
+	hwif->mmio = 1;
 
-	if (mmio) {
-		hwif->mmio = 1;
+	if (mmio)
 		default_hwif_mmiops(hwif);
-	}
 
 	idx[0] = hwif->index;
 
