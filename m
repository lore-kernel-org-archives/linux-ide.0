From: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 08/14] ide_pci: Merges opti621.h into opti621.c
Date: Fri,  4 Feb 2005 16:13:18 +0900 (KST)
Message-ID: <20050204071318.BE4F11326F9@htj.dyndns.org>
References: <42032014.1020606@home-tj.org>
Received: from [211.58.254.17] ([211.58.254.17]:41129 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S263293AbVBDHNX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Feb 2005 02:13:23 -0500
In-Reply-To: <42032014.1020606@home-tj.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


08_ide_pci_opti621_merge.patch

	Merges ide/pci/opti621.h into opti621.c.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-idepci-export/drivers/ide/pci/opti621.c
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/opti621.c	2005-02-04 16:07:36.681395063 +0900
+++ linux-idepci-export/drivers/ide/pci/opti621.c	2005-02-04 16:08:25.782398226 +0900
@@ -104,8 +104,6 @@
 
 #include <asm/io.h>
 
-#include "opti621.h"
-
 #define OPTI621_MAX_PIO 3
 /* In fact, I do not have any PIO 4 drive
  * (address: 25 ns, data: 70 ns, recovery: 35 ns),
@@ -348,6 +346,24 @@ static void __init init_hwif_opti621 (id
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+static ide_pci_device_t opti621_chipsets[] __devinitdata = {
+	{	/* 0 */
+		.name		= "OPTI621",
+		.init_hwif	= init_hwif_opti621,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
+		.bootable	= ON_BOARD,
+	},{	/* 1 */
+		.name		= "OPTI621X",
+		.init_hwif	= init_hwif_opti621,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
+		.bootable	= ON_BOARD,
+	}
+};
+
 static int __devinit opti621_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_setup_pci_device(dev, &opti621_chipsets[id->driver_data]);
Index: linux-idepci-export/drivers/ide/pci/opti621.h
===================================================================
--- linux-idepci-export.orig/drivers/ide/pci/opti621.h	2005-02-04 16:07:36.681395063 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,28 +0,0 @@
-#ifndef OPTI621_H
-#define OPTI621_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-static void init_hwif_opti621(ide_hwif_t *);
-
-static ide_pci_device_t opti621_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "OPTI621",
-		.init_hwif	= init_hwif_opti621,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
-		.bootable	= ON_BOARD,
-	},{	/* 1 */
-		.name		= "OPTI621X",
-		.init_hwif	= init_hwif_opti621,
-		.channels	= 2,
-		.autodma	= AUTODMA,
-		.enablebits	= {{0x45,0x80,0x00}, {0x40,0x08,0x00}},
-		.bootable	= ON_BOARD,
-	}
-};
-
-#endif /* OPTI621_H */
