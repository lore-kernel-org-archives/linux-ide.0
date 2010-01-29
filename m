From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 20/68] ide: add hwif->udma_mask field
Date: Fri, 29 Jan 2010 17:05:19 +0100
Message-ID: <20100129160519.21495.68671.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753752Ab0A2QTP@vger.kernel.org>
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add hwif->udma_mask field

Add udma_mask field to ide_hwif_t to match udma_mask field used in
struct ata_port.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 include/linux/ide.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -693,7 +693,10 @@ typedef struct hwif_s {
 
 	u8 pio_mask;
 
-	u8 ultra_mask;
+	union {
+		u8 ultra_mask;
+		u8 udma_mask;
+	};
 	u8 mwdma_mask;
 	u8 swdma_mask;
 
