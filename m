From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/5] it8213: remove DECLARE_ITE_DEV() macro
Date: Mon, 14 Jul 2008 17:11:02 +0200
Message-ID: <20080714151102.3106.28856.sendpatchset@localhost.localdomain>
References: <20080714151055.3106.78013.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:13401 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbYGMPM6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jul 2008 11:12:58 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1522141mue.1
        for <linux-ide@vger.kernel.org>; Sun, 13 Jul 2008 08:12:56 -0700 (PDT)
In-Reply-To: <20080714151055.3106.78013.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

While at it:

* it8213_chipsets[] -> it8213_chipset.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/it8213.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -155,23 +155,17 @@ static const struct ide_port_ops it8213_
 	.cable_detect		= it8213_cable_detect,
 };
 
-#define DECLARE_ITE_DEV(name_str)			\
-	{						\
-		.name		= name_str,		\
-		.enablebits	= { {0x41, 0x80, 0x80} }, \
-		.port_ops	= &it8213_port_ops,	\
-		.host_flags	= IDE_HFLAG_SINGLE,	\
-		.pio_mask	= ATA_PIO4,		\
-		.swdma_mask	= ATA_SWDMA2_ONLY,	\
-		.mwdma_mask	= ATA_MWDMA12_ONLY,	\
-		.udma_mask	= ATA_UDMA6,		\
-	}
-
-static const struct ide_port_info it8213_chipsets[] __devinitdata = {
-	/* 0 */ DECLARE_ITE_DEV("IT8213"),
+static const struct ide_port_info it8213_chipset __devinitdata = {
+	.name		= "IT8213",
+	.enablebits	= { {0x41, 0x80, 0x80} },
+	.port_ops	= &it8213_port_ops,
+	.host_flags	= IDE_HFLAG_SINGLE,
+	.pio_mask	= ATA_PIO4,
+	.swdma_mask	= ATA_SWDMA2_ONLY,
+	.mwdma_mask	= ATA_MWDMA12_ONLY,
+	.udma_mask	= ATA_UDMA6,
 };
 
-
 /**
  *	it8213_init_one	-	pci layer discovery entry
  *	@dev: PCI device
@@ -184,7 +178,7 @@ static const struct ide_port_info it8213
 
 static int __devinit it8213_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	return ide_pci_init_one(dev, &it8213_chipsets[id->driver_data], NULL);
+	return ide_pci_init_one(dev, &it8213_chipset, NULL);
 }
 
 static const struct pci_device_id it8213_pci_tbl[] = {
