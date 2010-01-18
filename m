From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 41/64] via82cxxx: fix SATA cable detection
Date: Mon, 18 Jan 2010 18:19:53 +0100
Message-ID: <20100118171953.14623.7914.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:5715 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab0ARRVF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:21:05 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] via82cxxx: fix SATA cable detection

Add VIA_SATA_PATA flag for cx700, vx800 and vx855 chipsets
(the first port is SATA).

Based on commits 7585eb1, bfce5e0 and e4d866c for pata_via
host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/via82cxxx.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: b/drivers/ide/via82cxxx.c
===================================================================
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -54,6 +54,7 @@
 #define VIA_NO_UNMASK		0x08 /* Doesn't work with IRQ unmasking on */
 #define VIA_BAD_ID		0x10 /* Has wrong vendor ID (0x1107) */
 #define VIA_BAD_AST		0x20 /* Don't touch Address Setup Timing */
+#define VIA_SATA_PATA		0x80 /* SATA/PATA combined configuration */
 
 enum {
 	VIA_IDFLAG_SINGLE = (1 << 1), /* single channel controller */
@@ -71,9 +72,9 @@ static struct via_isa_bridge {
 	u8 udma_mask;
 	u8 flags;
 } via_isa_bridges[] = {
-	{ "vx855",	PCI_DEVICE_ID_VIA_VX855,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
-	{ "vx800",	PCI_DEVICE_ID_VIA_VX800,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
-	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
+	{ "vx855",	PCI_DEVICE_ID_VIA_VX855,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST | VIA_SATA_PATA },
+	{ "vx800",	PCI_DEVICE_ID_VIA_VX800,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST | VIA_SATA_PATA },
+	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST | VIA_SATA_PATA },
 	{ "vt8237s",	PCI_DEVICE_ID_VIA_8237S,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
@@ -366,6 +367,9 @@ static u8 via82cxxx_cable_detect(ide_hwi
 	if (via_cable_override(pdev))
 		return ATA_CBL_PATA40_SHORT;
 
+	if ((vdev->via_config->flags & VIA_SATA_PATA) && hwif->channel == 0)
+		return ATA_CBL_SATA;
+
 	if ((vdev->via_80w >> hwif->channel) & 1)
 		return ATA_CBL_PATA80;
 	else
