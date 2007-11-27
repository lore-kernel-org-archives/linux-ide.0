From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/6] rapide: remove write-only hwif->hwif_data
Date: Tue, 27 Nov 2007 23:59:30 +0100
Message-ID: <200711272359.30653.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:44202 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbXK0WxG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 17:53:06 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1367703ugc
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 14:53:06 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>


Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/rapide.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -58,8 +58,6 @@ rapide_probe(struct expansion_card *ec, 
 		hwif->mmio = 1;
 		default_hwif_mmiops(hwif);
 
-		hwif->hwif_data = base;
-
 		idx[0] = hwif->index;
 
 		ide_device_add(idx);
