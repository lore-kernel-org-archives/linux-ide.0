From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] ide-mpc8xx: fix resources reservation
Date: Wed, 20 Feb 2008 01:49:30 +0100
Message-ID: <200802200149.30646.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:37109 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758202AbYBTAgc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2008 19:36:32 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2708595fkz.5
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2008 16:36:32 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vitaly Bordug <vitb@kernel.crashing.org>

* Tell IDE layer to not manage resources by setting
  hwif->mmio flag and request resources in m8xx_ide_init_ports().

* Use request_mem_region() for resources reservation.

* Use driver name for resources reservation.

Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/mpc8xx.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ppc/mpc8xx.c
===================================================================
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -36,6 +36,8 @@
 #include <asm/machdep.h>
 #include <asm/irq.h>
 
+#define DRV_NAME "ide-mpc8xx"
+
 static int identify  (volatile u8 *p);
 static void print_fixed (volatile u8 *p);
 static void print_funcid (int func);
@@ -182,6 +184,13 @@ static int __init m8xx_ide_init_ports(hw
 			pcmcia_phy_base, pcmcia_phy_end,
 			pcmcia_phy_end - pcmcia_phy_base);
 
+		if (!request_mem_region(pcmcia_phy_base,
+					pcmcia_phy_end - pcmcia_phy_base,
+					DRV_NAME)) {
+			printk(KERN_ERR "%s: resources busy\n", DRV_NAME);
+			return -EBUSY;
+		}
+
 		pcmcia_base=(unsigned long)ioremap(pcmcia_phy_base,
 						   pcmcia_phy_end-pcmcia_phy_base);
 
@@ -326,7 +335,12 @@ static int __init m8xx_ide_init_ports(hw
 		printk ("IDE phys mem : %08x...%08x (size %08x)\n",
 			ide_phy_base, ide_phy_end,
 			ide_phy_end - ide_phy_base);
-		
+
+		if (!request_mem_region(ide_phy_base, 0x200, DRV_NAME)) {
+			printk(KERN_ERR "%s: resources busy\n", DRV_NAME);
+			return -EBUSY;
+		}
+
 		ide_base=(unsigned long)ioremap(ide_phy_base,
 						ide_phy_end-ide_phy_base);
 
@@ -796,6 +810,7 @@ static int __init mpc8xx_ide_probe(void)
 		ide_hwif_t *hwif = &ide_hwifs[0];
 
 		ide_init_port_hw(hwif, &hw);
+		hwif->mmio = 1;
 		hwif->pio_mask = ATA_PIO4;
 		hwif->set_pio_mode = m8xx_ide_set_pio_mode;
 
@@ -807,6 +822,7 @@ static int __init mpc8xx_ide_probe(void)
 		ide_hwif_t *mate = &ide_hwifs[1];
 
 		ide_init_port_hw(mate, &hw);
+		mate->mmio = 1;
 		mate->pio_mask = ATA_PIO4;
 		mate->set_pio_mode = m8xx_ide_set_pio_mode;
 
