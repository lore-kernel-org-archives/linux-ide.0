From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 43/64] via82cxxx: add support for vt8261 and future chips
Date: Mon, 18 Jan 2010 18:20:07 +0100
Message-ID: <20100118172007.14623.89634.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:34657 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab0ARRVR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:21:17 -0500
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] via82cxxx: add support for vt8261 and future chips

Based on commit e4d866c for pata_via host driver.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/via82cxxx.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: b/drivers/ide/via82cxxx.c
===================================================================
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -75,6 +75,7 @@ static struct via_isa_bridge {
 	{ "vx855",	PCI_DEVICE_ID_VIA_VX855,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST | VIA_SATA_PATA },
 	{ "vx800",	PCI_DEVICE_ID_VIA_VX800,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST | VIA_SATA_PATA },
 	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST | VIA_SATA_PATA },
+	{ "vt8261",	PCI_DEVICE_ID_VIA_8261,     0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
 	{ "vt8237s",	PCI_DEVICE_ID_VIA_8237S,    0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
@@ -97,6 +98,7 @@ static struct via_isa_bridge {
 	{ "vt82c586",	PCI_DEVICE_ID_VIA_82C586_0, 0x00, 0x0f,      0x00, VIA_SET_FIFO },
 	{ "vt82c576",	PCI_DEVICE_ID_VIA_82C576,   0x00, 0x2f,      0x00, VIA_SET_FIFO | VIA_NO_UNMASK },
 	{ "vt82c576",	PCI_DEVICE_ID_VIA_82C576,   0x00, 0x2f,      0x00, VIA_SET_FIFO | VIA_NO_UNMASK | VIA_BAD_ID },
+	{ "vtxxxx",	PCI_DEVICE_ID_VIA_ANON,     0x00, 0x2f, ATA_UDMA6, VIA_BAD_AST },
 	{ NULL }
 };
 
@@ -205,7 +207,8 @@ static struct via_isa_bridge *via_config
 {
 	struct via_isa_bridge *via_config;
 
-	for (via_config = via_isa_bridges; via_config->id; via_config++)
+	for (via_config = via_isa_bridges;
+	     via_config->id != PCI_DEVICE_ID_VIA_ANON; via_config++)
 		if ((*isa = pci_get_device(PCI_VENDOR_ID_VIA +
 			!!(via_config->flags & VIA_BAD_ID),
 			via_config->id, NULL))) {
@@ -467,11 +470,6 @@ static int __devinit via_init_one(struct
 	 * Find the ISA bridge and check we know what it is.
 	 */
 	via_config = via_config_find(&isa);
-	if (!via_config->id) {
-		printk(KERN_WARNING DRV_NAME " %s: unknown chipset, skipping\n",
-			pci_name(dev));
-		return -ENODEV;
-	}
 
 	/*
 	 * Print the boot message.
