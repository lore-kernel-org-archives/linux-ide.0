From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/8] ide: print banner message once per controller in m68k host drivers
Date: Thu, 29 Nov 2007 01:05:10 +0100
Message-ID: <200711290105.10474.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:43996 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327AbXK2ACs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2007 19:02:48 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1659751ugc
        for <linux-ide@vger.kernel.org>; Wed, 28 Nov 2007 16:02:47 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>


* Print banner message once per controller in m68k host drivers.

* Change printk() level to KERN_INFO in buddha, falconide and gayle.

* Add banner message to q40ide.

This is basically a preparation for the future IDE layer changes.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/buddha.c    |   19 +++++--------------
 drivers/ide/legacy/falconide.c |    4 ++--
 drivers/ide/legacy/gayle.c     |   18 +++++++-----------
 drivers/ide/legacy/macide.c    |   14 ++++++--------
 drivers/ide/legacy/q40ide.c    |    2 ++
 5 files changed, 22 insertions(+), 35 deletions(-)

Index: b/drivers/ide/legacy/buddha.c
===================================================================
--- a/drivers/ide/legacy/buddha.c
+++ b/drivers/ide/legacy/buddha.c
@@ -112,6 +112,7 @@ typedef enum BuddhaType_Enum {
     BOARD_BUDDHA, BOARD_CATWEASEL, BOARD_XSURF
 } BuddhaType;
 
+static const char *buddha_board_name[] = { "Buddha", "Catweasel", "X-Surf" };
 
     /*
      *  Check and acknowledge the interrupt status
@@ -197,7 +198,10 @@ fail_base2:
 		/* X-Surf doesn't have this.  IRQs are always on */
 		if (type != BOARD_XSURF)
 			z_writeb(0, buddha_board+BUDDHA_IRQ_MR);
-		
+
+		printk(KERN_INFO "ide: %s IDE controller\n",
+				 buddha_board_name[type]);
+
 		for(i=0;i<buddha_num_hwifs;i++) {
 			if(type != BOARD_XSURF) {
 				ide_setup_ports(&hw, (buddha_board+buddha_bases[i]),
@@ -223,19 +227,6 @@ fail_base2:
 				ide_init_port_hw(hwif, &hw);
 
 				hwif->mmio = 1;
-				printk("ide%d: ", index);
-				switch(type) {
-				case BOARD_BUDDHA:
-					printk("Buddha");
-					break;
-				case BOARD_CATWEASEL:
-					printk("Catweasel");
-					break;
-				case BOARD_XSURF:
-					printk("X-Surf");
-					break;
-				}
-				printk(" IDE interface\n");
 
 				idx[i] = index;
 			}
Index: b/drivers/ide/legacy/falconide.c
===================================================================
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -67,6 +67,8 @@ static int __init falconide_init(void)
     if (MACH_IS_ATARI && ATARIHW_PRESENT(IDE)) {
 	hw_regs_t hw;
 
+	printk(KERN_INFO "ide: Falcon IDE controller\n");
+
 	ide_setup_ports(&hw, ATA_HD_BASE, falconide_offsets,
 			0, 0, NULL,
 //			falconide_iops,
@@ -80,8 +82,6 @@ static int __init falconide_init(void)
 		ide_init_port_data(hwif, index);
 		ide_init_port_hw(hwif, &hw);
 
-		printk("ide%d: Falcon IDE interface\n", index);
-
 		ide_device_add(idx);
 	}
     }
Index: b/drivers/ide/legacy/gayle.c
===================================================================
--- a/drivers/ide/legacy/gayle.c
+++ b/drivers/ide/legacy/gayle.c
@@ -129,6 +129,13 @@ static int __init gayle_init(void)
     return -ENODEV;
 
 found:
+	printk(KERN_INFO "ide: Gayle IDE controller (A%d style%s)\n",
+			 a4000 ? 4000 : 1200,
+#ifdef CONFIG_BLK_DEV_IDEDOUBLER
+			 ide_doubler ? ", IDE doubler" :
+#endif
+			 "");
+
     for (i = 0; i < GAYLE_NUM_PROBE_HWIFS; i++) {
 	unsigned long base, ctrlport, irqport;
 	ide_ack_intr_t *ack_intr;
@@ -173,17 +180,6 @@ found:
 	    ide_init_port_hw(hwif, &hw);
 
 	    hwif->mmio = 1;
-	    switch (i) {
-		case 0:
-		    printk("ide%d: Gayle IDE interface (A%d style)\n", index,
-			   a4000 ? 4000 : 1200);
-		    break;
-#ifdef CONFIG_BLK_DEV_IDEDOUBLER
-		case 1:
-		    printk("ide%d: IDE doubler\n", index);
-		    break;
-#endif /* CONFIG_BLK_DEV_IDEDOUBLER */
-	    }
 
 	    idx[i] = index;
 	} else
Index: b/drivers/ide/legacy/macide.c
===================================================================
--- a/drivers/ide/legacy/macide.c
+++ b/drivers/ide/legacy/macide.c
@@ -77,6 +77,9 @@ int macide_ack_intr(ide_hwif_t* hwif)
 	return 0;
 }
 
+static const char *mac_ide_name[] =
+	{ "Quadra", "Powerbook", "Powerbook Baboon" };
+
 /*
  * Probe for a Macintosh IDE interface
  */
@@ -109,6 +112,9 @@ static int __init macide_init(void)
 		return -ENODEV;
 	}
 
+	printk(KERN_INFO "ide: Macintosh %s IDE controller\n",
+			 mac_ide_name[macintosh_config->ide_type - 1]);
+
 	hwif = ide_find_port(hw.io_ports[IDE_DATA_OFFSET]);
 	if (hwif) {
 		u8 index = hwif->index;
@@ -128,14 +134,6 @@ static int __init macide_init(void)
 		}
 
 		hwif->mmio = 1;
-		if (macintosh_config->ide_type == MAC_IDE_QUADRA)
-			printk(KERN_INFO "ide%d: Macintosh Quadra IDE interface\n", index);
-		else if (macintosh_config->ide_type == MAC_IDE_PB)
-			printk(KERN_INFO "ide%d: Macintosh Powerbook IDE interface\n", index);
-		else if (macintosh_config->ide_type == MAC_IDE_BABOON)
-			printk(KERN_INFO "ide%d: Macintosh Powerbook Baboon IDE interface\n", index);
-		else
-			printk(KERN_INFO "ide%d: Unknown Macintosh IDE interface\n", index);
 
 		ide_device_add(idx);
 	}
Index: b/drivers/ide/legacy/q40ide.c
===================================================================
--- a/drivers/ide/legacy/q40ide.c
+++ b/drivers/ide/legacy/q40ide.c
@@ -121,6 +121,8 @@ static int __init q40ide_init(void)
     if (!MACH_IS_Q40)
       return -ENODEV;
 
+    printk(KERN_INFO "ide: Q40 IDE controller\n");
+
     for (i = 0; i < Q40IDE_NUM_HWIFS; i++) {
 	hw_regs_t hw;
 
