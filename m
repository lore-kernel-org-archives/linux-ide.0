From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/5] icside: always try to probe first interface
Date: Wed, 11 Jun 2008 21:20:39 +0200
Message-ID: <200806112120.39616.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:60994 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbYFKU0A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 16:26:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2234734fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 13:26:00 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

Try to probe first interface even if ide_hwifs[]'s slot for the second
interface cannot be obtained.

While at it:

- Add DRV_NAME define and use it for request_dma() instead of hwif->name.

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -21,6 +21,8 @@
 #include <asm/dma.h>
 #include <asm/ecard.h>
 
+#define DRV_NAME "icside"
+
 #define ICS_IDENT_OFFSET		0x2280
 
 #define ICS_ARCIN_V5_INTRSTAT		0x0000
@@ -546,27 +548,27 @@ icside_register_v6(struct icside_state *
 	ide_init_port_hw(hwif, &hw[0]);
 	default_hwif_mmiops(hwif);
 
+	idx[0] = hwif->index;
+
 	mate = ide_find_port();
-	if (mate == NULL)
-		return -ENODEV;
+	if (mate) {
+		ide_init_port_hw(mate, &hw[1]);
+		default_hwif_mmiops(mate);
 
-	ide_init_port_hw(mate, &hw[1]);
-	default_hwif_mmiops(mate);
+		idx[1] = mate->index;
+	}
 
 	state->hwif[0]    = hwif;
 	state->hwif[1]    = mate;
 
 	ecard_set_drvdata(ec, state);
 
-	if (ec->dma != NO_DMA && !request_dma(ec->dma, hwif->name)) {
+	if (ec->dma != NO_DMA && !request_dma(ec->dma, DRV_NAME)) {
 		d.init_dma = icside_dma_init;
 		d.port_ops = &icside_v6_port_ops;
 		d.dma_ops = NULL;
 	}
 
-	idx[0] = hwif->index;
-	idx[1] = mate->index;
-
 	ide_device_add(idx, &d);
 
 	return 0;
