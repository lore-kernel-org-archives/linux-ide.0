From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6] hpt366: change timing register masks
Date: Sat, 8 Dec 2007 20:49:20 +0300
Message-ID: <200712082049.20731.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:14792 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751101AbXLHRtF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Dec 2007 12:49:05 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Since PIO autotuning is now done always, there's no need anymore to program
the taskfile timings also on DMA modes, so chenge the IDE timing register
masks accordingly, "inverting the polarity" of the masks while at it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the pata-2.6 patchset...

 drivers/ide/pci/hpt366.c |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.22	Dec 4, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.23	Dec 7, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -689,19 +689,17 @@ static void hpt36x_set_mode(ide_drive_t 
 	struct hpt_info	*info	= pci_get_drvdata(dev);
 	u8  itr_addr		= drive->dn ? 0x44 : 0x40;
 	u32 old_itr		= 0;
-	u32 itr_mask, new_itr;
-
-	itr_mask = speed < XFER_MW_DMA_0 ? 0x30070000 :
-		  (speed < XFER_UDMA_0   ? 0xc0070000 : 0xc03800ff);
-
-	new_itr = get_speed_setting(speed, info);
+	u32 new_itr		= get_speed_setting(speed, info);
+	u32 itr_mask		= speed < XFER_MW_DMA_0 ? 0xc1f8ffff :
+				 (speed < XFER_UDMA_0   ? 0x303800ff :
+							  0x30070000);
 
+	pci_read_config_dword(dev, itr_addr, &old_itr);
+	new_itr = (old_itr & ~itr_mask) | (new_itr & itr_mask);
 	/*
 	 * Disable on-chip PIO FIFO/buffer (and PIO MST mode as well)
 	 * to avoid problems handling I/O errors later
 	 */
-	pci_read_config_dword(dev, itr_addr, &old_itr);
-	new_itr  = (new_itr & ~itr_mask) | (old_itr & itr_mask);
 	new_itr &= ~0xc0000000;
 
 	pci_write_config_dword(dev, itr_addr, new_itr);
@@ -714,16 +712,14 @@ static void hpt37x_set_mode(ide_drive_t 
 	struct hpt_info	*info	= pci_get_drvdata(dev);
 	u8  itr_addr		= 0x40 + (drive->dn * 4);
 	u32 old_itr		= 0;
-	u32 itr_mask, new_itr;
-
-	itr_mask = speed < XFER_MW_DMA_0 ? 0x303c0000 :
-		  (speed < XFER_UDMA_0   ? 0xc03c0000 : 0xc1c001ff);
-
-	new_itr = get_speed_setting(speed, info);
+	u32 new_itr		= get_speed_setting(speed, info);
+	u32 itr_mask		= speed < XFER_MW_DMA_0 ? 0xcfc3ffff :
+				 (speed < XFER_UDMA_0   ? 0x31c001ff :
+				 			  0x303c0000);
 
 	pci_read_config_dword(dev, itr_addr, &old_itr);
-	new_itr = (new_itr & ~itr_mask) | (old_itr & itr_mask);
-	
+	new_itr = (old_itr & ~itr_mask) | (new_itr & itr_mask);
+
 	if (speed < XFER_MW_DMA_0)
 		new_itr &= ~0x80000000; /* Disable on-chip PIO FIFO/buffer */
 	pci_write_config_dword(dev, itr_addr, new_itr);

