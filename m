From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/5] it821x: remove DECLARE_ITE_DEV() macro
Date: Mon, 14 Jul 2008 17:11:09 +0200
Message-ID: <20080714151109.3106.80300.sendpatchset@localhost.localdomain>
References: <20080714151055.3106.78013.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:13328 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbYGMPND (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jul 2008 11:13:03 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1522132mue.1
        for <linux-ide@vger.kernel.org>; Sun, 13 Jul 2008 08:13:02 -0700 (PDT)
In-Reply-To: <20080714151055.3106.78013.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

While at it:

* it821x_chipsets[] -> it821x_chipset.

* Fix it821x_chipset's name field (as it is used for IT8211/8212).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/it821x.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -622,17 +622,12 @@ static const struct ide_port_ops it821x_
 	.cable_detect		= it821x_cable_detect,
 };
 
-#define DECLARE_ITE_DEV(name_str)			\
-	{						\
-		.name		= name_str,		\
-		.init_chipset	= init_chipset_it821x,	\
-		.init_hwif	= init_hwif_it821x,	\
-		.port_ops	= &it821x_port_ops,	\
-		.pio_mask	= ATA_PIO4,		\
-	}
-
-static const struct ide_port_info it821x_chipsets[] __devinitdata = {
-	/* 0 */ DECLARE_ITE_DEV("IT8212"),
+static const struct ide_port_info it821x_chipset __devinitdata = {
+	.name		= "IT821X",
+	.init_chipset	= init_chipset_it821x,
+	.init_hwif	= init_hwif_it821x,
+	.port_ops	= &it821x_port_ops,
+	.pio_mask	= ATA_PIO4,
 };
 
 /**
@@ -655,7 +650,7 @@ static int __devinit it821x_init_one(str
 		return -ENOMEM;
 	}
 
-	rc = ide_pci_init_one(dev, &it821x_chipsets[id->driver_data], itdevs);
+	rc = ide_pci_init_one(dev, &it821x_chipset, itdevs);
 	if (rc)
 		kfree(itdevs);
 
