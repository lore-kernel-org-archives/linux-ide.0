From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/5] rapide: fix rapide_probe() return value
Date: Wed, 11 Jun 2008 21:19:46 +0200
Message-ID: <200806112119.46243.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:61057 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbYFKUZ6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 16:25:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2234746fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 13:25:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

Return -ENOENT on ide_find_port() failure.

While at it:

- Cleanup rapide_probe() a bit.

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/rapide.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

Index: b/drivers/ide/arm/rapide.c
===================================================================
--- a/drivers/ide/arm/rapide.c
+++ b/drivers/ide/arm/rapide.c
@@ -48,24 +48,26 @@ rapide_probe(struct expansion_card *ec, 
 		goto release;
 	}
 
-	hwif = ide_find_port();
-	if (hwif) {
-		memset(&hw, 0, sizeof(hw));
-		rapide_setup_ports(&hw, base, base + 0x818, 1 << 6, ec->irq);
-		hw.chipset = ide_generic;
-		hw.dev = &ec->dev;
+	memset(&hw, 0, sizeof(hw));
+	rapide_setup_ports(&hw, base, base + 0x818, 1 << 6, ec->irq);
+	hw.chipset = ide_generic;
+	hw.dev = &ec->dev;
 
-		ide_init_port_hw(hwif, &hw);
+	hwif = ide_find_port();
+	if (hwif == NULL) {
+		ret = -ENOENT;
+		goto release;
+	}
 
-		default_hwif_mmiops(hwif);
+	ide_init_port_hw(hwif, &hw);
+	default_hwif_mmiops(hwif);
 
-		idx[0] = hwif->index;
+	idx[0] = hwif->index;
 
-		ide_device_add(idx, &rapide_port_info);
+	ide_device_add(idx, &rapide_port_info);
 
-		ecard_set_drvdata(ec, hwif);
-		goto out;
-	}
+	ecard_set_drvdata(ec, hwif);
+	goto out;
 
  release:
 	ecard_release_resources(ec);
