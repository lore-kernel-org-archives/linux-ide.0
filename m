From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/21] rapide: set hwif->chipset
Date: Sun, 18 Nov 2007 23:22:59 +0100
Message-ID: <200711182322.59947.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48323 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbXKRWgm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873016ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:41 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>


hwif->chipset should be set if the hwif is claimed by host driver.

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/rapide.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -55,6 +55,7 @@ rapide_probe(struct expansion_card *ec, 
 
 	hwif = rapide_locate_hwif(base, base + 0x818, 1 << 6, ec->irq);
 	if (hwif) {
+		hwif->chipset = ide_generic;
 		hwif->hwif_data = base;
 		hwif->gendev.parent = &ec->dev;
 		hwif->noprobe = 0;
