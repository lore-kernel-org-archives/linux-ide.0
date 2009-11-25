From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 82/86] pata_via: clear UDMA transfer mode bit for PIO and MWDMA
Date: Wed, 25 Nov 2009 18:12:18 +0100
Message-ID: <20091125171218.5446.41962.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52976 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934810AbZKYRM4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:12:56 -0500
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_via: clear UDMA transfer mode bit for PIO and MWDMA

Fix register naming while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_via.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

Index: b/drivers/ata/pata_via.c
===================================================================
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -296,14 +296,21 @@ static void via_do_set_mode(struct ata_p
 	}
 
 	/* Set UDMA unless device is not UDMA capable */
-	if (udma_type && t.udma) {
-		u8 cable80_status;
+	if (udma_type) {
+		u8 udma_etc;
 
-		/* Get 80-wire cable detection bit */
-		pci_read_config_byte(pdev, 0x50 + offset, &cable80_status);
-		cable80_status &= 0x10;
+		pci_read_config_byte(pdev, 0x50 + offset, &udma_etc);
 
-		pci_write_config_byte(pdev, 0x50 + offset, ut | cable80_status);
+		/* clear transfer mode bit */
+		udma_etc &= ~0x20;
+
+		if (t.udma) {
+			/* preserve 80-wire cable detection bit */
+			udma_etc &= 0x10;
+			udma_etc |= ut;
+		}
+
+		pci_write_config_byte(pdev, 0x50 + offset, udma_etc);
 	}
 }
 
