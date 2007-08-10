From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] hpt366: fix PCI clock detection for HPT374
Date: Fri, 10 Aug 2007 22:26:35 +0400
Message-ID: <200708102226.35996.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:7728 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756321AbXHJSY2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 14:24:28 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

HPT374 BIOS seems to only save f_CNT register value for the function #0 before
re-tuning DPLL (that causes the driver to report obviously distorted f_CNT for
the function #1) -- fix this by always reading the saved f_CNT register value
from the function #0 in init_chipset_hpt374().
While at it, introduce 'chip_type' for holding the 'struct hpt_info' field
of the same name and replace the structure assignment with memcpy()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This is against the current Linus tree and unfortunately I was able to
only compile test it since that tree gives MODPOST warning and dies early.

 drivers/ide/pci/hpt366.c |   41 +++++++++++++++++++++++++++++------------
 1 files changed, 29 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.10	Jun 29, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.11	Aug 9, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -981,6 +981,7 @@ static unsigned int __devinit init_chips
 	struct hpt_info *info	= kmalloc(sizeof(struct hpt_info), GFP_KERNEL);
 	unsigned long io_base	= pci_resource_start(dev, 4);
 	u8 pci_clk,  dpll_clk	= 0;	/* PCI and DPLL clock in MHz */
+	u8 chip_type;
 	enum ata_clock	clock;
 
 	if (info == NULL) {
@@ -992,7 +993,8 @@ static unsigned int __devinit init_chips
 	 * Copy everything from a static "template" structure
 	 * to just allocated per-chip hpt_info structure.
 	 */
-	*info = *(struct hpt_info *)pci_get_drvdata(dev);
+	memcpy(info, pci_get_drvdata(dev), sizeof(struct hpt_info));
+	chip_type = info->chip_type;
 
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x78);
@@ -1002,7 +1004,7 @@ static unsigned int __devinit init_chips
 	/*
 	 * First, try to estimate the PCI clock frequency...
 	 */
-	if (info->chip_type >= HPT370) {
+	if (chip_type >= HPT370) {
 		u8  scr1  = 0;
 		u16 f_cnt = 0;
 		u32 temp  = 0;
@@ -1016,7 +1018,7 @@ static unsigned int __devinit init_chips
 		 * HighPoint does this for HPT372A.
 		 * NOTE: This register is only writeable via I/O space.
 		 */
-		if (info->chip_type == HPT372A)
+		if (chip_type == HPT372A)
 			outb(0x0e, io_base + 0x9c);
 
 		/*
@@ -1034,13 +1036,28 @@ static unsigned int __devinit init_chips
 		 * First try reading the register in which the HighPoint BIOS
 		 * saves f_CNT value before  reprogramming the DPLL from its
 		 * default setting (which differs for the various chips).
-		 * NOTE: This register is only accessible via I/O space.
 		 *
-		 * In case the signature check fails, we'll have to resort to
-		 * reading the f_CNT register itself in hopes that nobody has
-		 * touched the DPLL yet...
+		 * NOTE: This register is only accessible via I/O space;
+		 * the HPT374 BIOS seems to only set it for the function 0,
+		 * so we always get it from there -- there's no need to check
+		 * result of pci_get_slot() since the function 0 is guaranteed
+		 * to be there by this time (by the IDE core itself)...
+		 */
+		if (chip_type == HPT374 && (PCI_FUNC(dev->devfn) & 1)) {
+			struct pci_dev	*dev1 = pci_get_slot(dev->bus,
+							     dev->devfn - 1);
+			unsigned long io_base = pci_resource_start(dev1, 4);
+
+			temp =	inl(io_base + 0x90);
+			pci_dev_put(dev1);
+		} else
+			temp =	inl(io_base + 0x90);
+
+		/*
+		 * In case the signature check fails, we'll have to
+		 * resort to reading the f_CNT register itself in hopes
+		 * that nobody has touched the DPLL yet...
 		 */
-		temp = inl(io_base + 0x90);
 		if ((temp & 0xFFFFF000) != 0xABCDE000) {
 			int i;
 
@@ -1120,7 +1137,7 @@ static unsigned int __devinit init_chips
 	 * We also  don't like using  the DPLL because this causes glitches
 	 * on PRST-/SRST- when the state engine gets reset...
 	 */
-	if (info->chip_type >= HPT374 || info->settings[clock] == NULL) {
+	if (chip_type >= HPT374 || info->settings[clock] == NULL) {
 		u16 f_low, delta = pci_clk < 50 ? 2 : 4;
 		int adjust;
 
@@ -1190,7 +1207,7 @@ static unsigned int __devinit init_chips
 	/* Point to this chip's own instance of the hpt_info structure. */
 	pci_set_drvdata(dev, info);
 
-	if (info->chip_type >= HPT370) {
+	if (chip_type >= HPT370) {
 		u8  mcr1, mcr4;
 
 		/*
@@ -1209,7 +1226,7 @@ static unsigned int __devinit init_chips
 	 * the MISC. register to stretch the UltraDMA Tss timing.
 	 * NOTE: This register is only writeable via I/O space.
 	 */
-	if (info->chip_type == HPT371N && clock == ATA_CLOCK_66MHZ)
+	if (chip_type == HPT371N && clock == ATA_CLOCK_66MHZ)
 
 		outb(inb(io_base + 0x9c) | 0x04, io_base + 0x9c);
 

