From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] sgiioc4: sgiioc4_read_status drive busy check fix
Date: Sun, 28 Sep 2008 23:48:52 +0400
Message-ID: <200809282348.52748.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:52872 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752546AbYI1Trz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 15:47:55 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

Fix the drive non-busy criterion used by sgiioc4_read_status(): neither of the
bits it expects to be set guarantees that the drive is not busy (and might be
interrupting), only the BSY bit itself being zero gurantees that.
While at it, use ATA_BUSY instead of hardcoded value everywhere...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.
                                          
 drivers/ide/pci/sgiioc4.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
+++ linux-2.6/drivers/ide/pci/sgiioc4.c
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2003-2006 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (C) 2008 MontaVista Software, Inc.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -151,7 +152,7 @@ sgiioc4_clearirq(ide_drive_t * drive)
 		int count = 0;
 
 		stat = sgiioc4_read_status(hwif);
-		while ((stat & 0x80) && (count++ < 100)) {
+		while ((stat & ATA_BUSY) && (count++ < 100)) {
 			udelay(1);
 			stat = sgiioc4_read_status(hwif);
 		}
@@ -311,7 +312,7 @@ static u8 sgiioc4_read_status(ide_hwif_t
 	u8 reg = (u8) readb((void __iomem *) port);
 
 	if ((port & 0xFFF) == 0x11C) {	/* Status register of IOC4 */
-		if (reg & 0x51) {	/* Not busy...check for interrupt */
+		if (!(reg & ATA_BUSY)) { /* Not busy... check for interrupt */
 			unsigned long other_ir = port - 0x110;
 			unsigned int intr_reg = (u32) readl((void __iomem *) other_ir);
 

