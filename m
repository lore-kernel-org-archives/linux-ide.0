From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] bast-ide: fix resources reservation
Date: Wed, 20 Feb 2008 01:47:14 +0100
Message-ID: <200802200147.15040.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:37168 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbYBTAg3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 19:36:29 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2708594fkz.5
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2008 16:36:28 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ben Dooks <support@simtec.co.uk>

* Tell IDE layer to not manage resources by setting
  hwif->mmio flag and request resources in bastide_init().

* Use request_mem_region() for resources reservation.

* Use driver name for resources reservation.

Cc: Ben Dooks <support@simtec.co.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/bast-ide.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: b/drivers/ide/arm/bast-ide.c
===================================================================
--- a/drivers/ide/arm/bast-ide.c
+++ b/drivers/ide/arm/bast-ide.c
@@ -21,6 +21,8 @@
 #include <asm/arch/bast-map.h>
 #include <asm/arch/bast-irq.h>
 
+#define DRV_NAME "bast-ide"
+
 static int __init bastide_register(unsigned int base, unsigned int aux, int irq)
 {
 	ide_hwif_t *hwif;
@@ -53,6 +55,7 @@ static int __init bastide_register(unsig
 		ide_init_port_data(hwif, i);
 
 	ide_init_port_hw(hwif, &hw);
+	hwif->mmio = 1;
 	hwif->quirkproc = NULL;
 
 	idx[0] = i;
@@ -64,6 +67,8 @@ out:
 
 static int __init bastide_init(void)
 {
+	unsigned long base = BAST_VA_IDEPRI + BAST_IDE_CS;
+
 	/* we can treat the VR1000 and the BAST the same */
 
 	if (!(machine_is_bast() || machine_is_vr1000()))
@@ -71,6 +76,11 @@ static int __init bastide_init(void)
 
 	printk("BAST: IDE driver, (c) 2003-2004 Simtec Electronics\n");
 
+	if (!request_mem_region(base, 0x400000, DRV_NAME)) {
+		printk(KERN_ERR "%s: resources busy\n", DRV_NAME);
+		return -EBUSY;
+	}
+
 	bastide_register(BAST_VA_IDEPRI, BAST_VA_IDEPRIAUX, IRQ_IDE0);
 	bastide_register(BAST_VA_IDESEC, BAST_VA_IDESECAUX, IRQ_IDE1);
 
