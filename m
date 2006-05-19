From: Jeremy Higdon <jeremy@sgi.com>
Subject: [patch 1/1] sgiioc4: use mmio ops instead of port io
Date: Thu, 18 May 2006 22:00:15 -0700
Message-ID: <20060519050015.GA572159@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:34697 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932226AbWESFAR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 01:00:17 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id k4J7I7pH024564
	for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 00:18:07 -0700
Received: from classic.engr.sgi.com (classic.engr.sgi.com [163.154.5.111])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with ESMTP id k4J50G4126361538
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 22:00:16 -0700 (PDT)
Received: from classic.engr.sgi.com (localhost [127.0.0.1])
	by classic.engr.sgi.com (SGI-8.12.5/8.12.5) with ESMTP id k4J50G0q572193
	for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 22:00:16 -0700 (PDT)
Received: (from jeremy@localhost)
	by classic.engr.sgi.com (SGI-8.12.5/8.12.5/Submit) id k4J50FQE572123
	for linux-ide@vger.kernel.org; Thu, 18 May 2006 22:00:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The IDE part of the IOC4 chip uses MMIO to map the chip registers.
Unfortunately, the sgiioc4 driver uses the default port IO operations,
which happens to have worked for the past few years.  That's about
to change, however, thus this change from inX/outX to readX/writeX.

Signed-off-by: jeremy@sgi.com

--- linux-2.6.17-rc4/drivers/ide/pci/sgiioc4.c	2006-05-11 16:31:53.000000000 -0700
+++ linux-2.6.17-rc4-mod/drivers/ide/pci/sgiioc4.c	2006-05-18 21:56:52.075277540 -0700
@@ -345,17 +345,17 @@
 static u8
 sgiioc4_INB(unsigned long port)
 {
-	u8 reg = (u8) inb(port);
+	u8 reg = (u8) readb((void __iomem *) port);
 
 	if ((port & 0xFFF) == 0x11C) {	/* Status register of IOC4 */
 		if (reg & 0x51) {	/* Not busy...check for interrupt */
 			unsigned long other_ir = port - 0x110;
-			unsigned int intr_reg = (u32) inl(other_ir);
+			unsigned int intr_reg = (u32) readl((void __iomem *) other_ir);
 
 			/* Clear the Interrupt, Error bits on the IOC4 */
 			if (intr_reg & 0x03) {
-				outl(0x03, other_ir);
-				intr_reg = (u32) inl(other_ir);
+				writel(0x03, (void __iomem *) other_ir);
+				intr_reg = (u32) readl((void __iomem *) other_ir);
 			}
 		}
 	}
@@ -606,6 +606,12 @@
 	hwif->ide_dma_host_off = &sgiioc4_ide_dma_host_off;
 	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
 	hwif->ide_dma_timeout = &__ide_dma_timeout;
+
+	/*
+	 * The IOC4 uses MMIO rather than Port IO.
+	 * It also needs special workarounds for INB.
+	 */
+	default_hwif_mmiops(hwif);
 	hwif->INB = &sgiioc4_INB;
 }
 
@@ -743,6 +749,6 @@
 module_init(ioc4_ide_init);
 module_exit(ioc4_ide_exit);
 
-MODULE_AUTHOR("Aniket Malatpure - Silicon Graphics Inc. (SGI)");
+MODULE_AUTHOR("Aniket Malatpure/Jeremy Higdon");
 MODULE_DESCRIPTION("IDE PCI driver module for SGI IOC4 Base-IO Card");
 MODULE_LICENSE("GPL");
