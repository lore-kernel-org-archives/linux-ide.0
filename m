From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/3] hpt366: cleanup maskproc() method
Date: Wed, 15 Oct 2008 00:21:14 +0400
Message-ID: <200810150021.14661.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:62385 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751532AbYJNUV3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Oct 2008 16:21:29 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Since the maskproc() method calls either mirror the interrupt en/disable via
the nIEN bit of the device control register done by the IDE core before issuing
a command or unmask the interrupt after a command executed in polled mode (when
interrupt is already not expected), it is pointless to manipulate the nIEN bit
in this method; therefore, just do nothing for the drives not on the quirk list.
Move the code to the left by using an early return and the 'else if' construct,
while at it....

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch (and the previous one) is against the recent pata-2.6 series...

 drivers/ide/pci/hpt366.c |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -3,7 +3,7 @@
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
  * Portions Copyright (C) 2007		Bartlomiej Zolnierkiewicz
- * Portions Copyright (C) 2005-2007	MontaVista Software, Inc.
+ * Portions Copyright (C) 2005-2008	MontaVista Software, Inc.
  *
  * Thanks to HighPoint Technologies for their assistance, and hardware.
  * Special Thanks to Jon Burchmore in SanDiego for the deep pockets, his
@@ -748,26 +748,24 @@ static void hpt3xx_maskproc(ide_drive_t 
 	struct pci_dev	*dev	= to_pci_dev(hwif->dev);
 	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
 
-	if (drive->quirk_list) {
-		if (info->chip_type >= HPT370) {
-			u8 scr1 = 0;
-
-			pci_read_config_byte(dev, 0x5a, &scr1);
-			if (((scr1 & 0x10) >> 4) != mask) {
-				if (mask)
-					scr1 |=  0x10;
-				else
-					scr1 &= ~0x10;
-				pci_write_config_byte(dev, 0x5a, scr1);
-			}
-		} else {
+	if (drive->quirk_list == 0)
+		return;
+
+	if (info->chip_type >= HPT370) {
+		u8 scr1 = 0;
+
+		pci_read_config_byte(dev, 0x5a, &scr1);
+		if (((scr1 & 0x10) >> 4) != mask) {
 			if (mask)
-				disable_irq(hwif->irq);
+				scr1 |=  0x10;
 			else
-				enable_irq (hwif->irq);
+				scr1 &= ~0x10;
+			pci_write_config_byte(dev, 0x5a, scr1);
 		}
-	} else
-		outb(ATA_DEVCTL_OBS | (mask ? 2 : 0), hwif->io_ports.ctl_addr);
+	} else if (mask)
+		disable_irq(hwif->irq);
+	else
+		enable_irq (hwif->irq);
 }
 
 /*

