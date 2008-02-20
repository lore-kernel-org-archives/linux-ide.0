From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove hwif->straight8 flag
Date: Thu, 21 Feb 2008 00:44:21 +0100
Message-ID: <200802210044.21205.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:17467 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbYBTXaf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 18:30:35 -0500
Received: by fk-out-0910.google.com with SMTP id z23so3166722fkz.5
        for <linux-ide@vger.kernel.org>; Wed, 20 Feb 2008 15:30:34 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

All host drivers now either set hwif->mmio or reserve continuous
I/O resources so remove no longer needed hwif->straight8 flag
and never reached code for 'hwif->straight8 == 0' case.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c   |   36 +++++++++++-------------------------
 include/linux/ide.h |    1 -
 2 files changed, 11 insertions(+), 26 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -253,29 +253,21 @@ static struct resource* hwif_request_reg
 int ide_hwif_request_regions(ide_hwif_t *hwif)
 {
 	unsigned long addr;
-	unsigned int i;
 
 	if (hwif->mmio)
 		return 0;
+
 	addr = hwif->io_ports[IDE_CONTROL_OFFSET];
+
 	if (addr && !hwif_request_region(hwif, addr, 1))
 		goto control_region_busy;
-	hwif->straight8 = 0;
+
 	addr = hwif->io_ports[IDE_DATA_OFFSET];
-	if ((addr | 7) == hwif->io_ports[IDE_STATUS_OFFSET]) {
-		if (!hwif_request_region(hwif, addr, 8))
-			goto data_region_busy;
-		hwif->straight8 = 1;
-		return 0;
-	}
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		addr = hwif->io_ports[i];
-		if (!hwif_request_region(hwif, addr, 1)) {
-			while (--i)
-				release_region(addr, 1);
-			goto data_region_busy;
-		}
-	}
+	BUG_ON((addr | 7) != hwif->io_ports[IDE_STATUS_OFFSET]);
+
+	if (!hwif_request_region(hwif, addr, 8))
+		goto data_region_busy;
+
 	return 0;
 
 data_region_busy:
@@ -301,19 +293,13 @@ control_region_busy:
 
 void ide_hwif_release_regions(ide_hwif_t *hwif)
 {
-	u32 i = 0;
-
 	if (hwif->mmio)
 		return;
+
 	if (hwif->io_ports[IDE_CONTROL_OFFSET])
 		release_region(hwif->io_ports[IDE_CONTROL_OFFSET], 1);
-	if (hwif->straight8) {
-		release_region(hwif->io_ports[IDE_DATA_OFFSET], 8);
-		return;
-	}
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
-		if (hwif->io_ports[i])
-			release_region(hwif->io_ports[i], 1);
+
+	release_region(hwif->io_ports[IDE_DATA_OFFSET], 8);
 }
 
 void ide_remove_port_from_hwgroup(ide_hwif_t *hwif)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -524,7 +524,6 @@ typedef struct hwif_s {
 	unsigned	reset      : 1;	/* reset after probe */
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
 	unsigned	mmio       : 1; /* host uses MMIO */
-	unsigned	straight8  : 1;	/* Alan's straight 8 check */
 
 	struct device		gendev;
 	struct class_device	classdev;
