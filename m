From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6] hpt366: fix HPT37x PIO mode timings
Date: Fri, 7 Dec 2007 21:16:21 +0300
Message-ID: <200712072116.21795.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:12449 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753697AbXLGSQH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Dec 2007 13:16:07 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

After looking into the HPT370 manual (now that I have it) and re-checking all
the timing tables, here's what I have discovered:

- at 33 MHz clock, PIO mode 0 timings turned to be overclocked, and all other
  PIO modes underclocked;

- at 50 MHz clock, PIO modes 0 to 2 turned to be oveclocked;

- at 66 MHz clock, PIO mode 0 was oveclocked too.

Finally, the taskfile timing (matching PIO mode 0) turned to be overclocked at
all clock frequencies (and in all manuals)...

The new timings have been tested on HPT370 chip (at 33 MHz PCI clock) and on
HPT371N chip (at both 50 and 66 MHz DPLL clock).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Many PIO modes at 55/66 MHz (as well as MDDMA modes at all clocks) are also
underclocked but I decided not to touch them, at least for the time being...
The patch is agains the Linus' tree.

 drivers/ide/pci/hpt366.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 70 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/hpt366.c		Version 1.21	Oct 23, 2007
+ * linux/drivers/ide/pci/hpt366.c		Version 1.22	Dec 4, 2007
  *
  * Copyright (C) 1999-2003		Andre Hedrick <andre@linux-ide.org>
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
@@ -310,6 +310,8 @@ static u32 twenty_five_base_hpt36x[] = {
 	/* XFER_PIO_0 */	0xc0d08585
 };
 
+#if 0
+/* These are the timing tables from the HighPoint open source drivers... */
 static u32 thirty_three_base_hpt37x[] = {
 	/* XFER_UDMA_6 */	0x12446231,	/* 0x12646231 ?? */
 	/* XFER_UDMA_5 */	0x12446231,
@@ -369,6 +371,73 @@ static u32 sixty_six_base_hpt37x[] = {
 	/* XFER_PIO_1 */	0x0d029d26,
 	/* XFER_PIO_0 */	0x0d029d5e
 };
+#else
+/*
+ * The following are the new timing tables with PIO mode data/taskfile transfer
+ * overclocking fixed...
+ */
+
+/* This table is taken from the HPT370 data manual rev. 1.02 */
+static u32 thirty_three_base_hpt37x[] = {
+	/* XFER_UDMA_6 */	0x16455031,	/* 0x16655031 ?? */
+	/* XFER_UDMA_5 */	0x16455031,
+	/* XFER_UDMA_4 */	0x16455031,
+	/* XFER_UDMA_3 */	0x166d5031,
+	/* XFER_UDMA_2 */	0x16495031,
+	/* XFER_UDMA_1 */	0x164d5033,
+	/* XFER_UDMA_0 */	0x16515097,
+
+	/* XFER_MW_DMA_2 */	0x26515031,
+	/* XFER_MW_DMA_1 */	0x26515033,
+	/* XFER_MW_DMA_0 */	0x26515097,
+
+	/* XFER_PIO_4 */	0x06515021,
+	/* XFER_PIO_3 */	0x06515022,
+	/* XFER_PIO_2 */	0x06515033,
+	/* XFER_PIO_1 */	0x06915065,
+	/* XFER_PIO_0 */	0x0691508a
+};
+
+static u32 fifty_base_hpt37x[] = {
+	/* XFER_UDMA_6 */	0x1a861842,
+	/* XFER_UDMA_5 */	0x1a861842,
+	/* XFER_UDMA_4 */	0x1aae1842,
+	/* XFER_UDMA_3 */	0x1a8e1842,
+	/* XFER_UDMA_2 */	0x1a0e1842,
+	/* XFER_UDMA_1 */	0x1a161854,
+	/* XFER_UDMA_0 */	0x1a1a18ea,
+
+	/* XFER_MW_DMA_2 */	0x2a821842,
+	/* XFER_MW_DMA_1 */	0x2a821854,
+	/* XFER_MW_DMA_0 */	0x2a8218ea,
+
+	/* XFER_PIO_4 */	0x0a821842,
+	/* XFER_PIO_3 */	0x0a821843,
+	/* XFER_PIO_2 */	0x0a821855,
+	/* XFER_PIO_1 */	0x0ac218a8,
+	/* XFER_PIO_0 */	0x0ac2190c
+};
+
+static u32 sixty_six_base_hpt37x[] = {
+	/* XFER_UDMA_6 */	0x1c86fe62,
+	/* XFER_UDMA_5 */	0x1caefe62,	/* 0x1c8afe62 */
+	/* XFER_UDMA_4 */	0x1c8afe62,
+	/* XFER_UDMA_3 */	0x1c8efe62,
+	/* XFER_UDMA_2 */	0x1c92fe62,
+	/* XFER_UDMA_1 */	0x1c9afe62,
+	/* XFER_UDMA_0 */	0x1c82fe62,
+
+	/* XFER_MW_DMA_2 */	0x2c82fe62,
+	/* XFER_MW_DMA_1 */	0x2c82fe66,
+	/* XFER_MW_DMA_0 */	0x2c82ff2e,
+
+	/* XFER_PIO_4 */	0x0c82fe62,
+	/* XFER_PIO_3 */	0x0c82fe84,
+	/* XFER_PIO_2 */	0x0c82fea6,
+	/* XFER_PIO_1 */	0x0d02ff26,
+	/* XFER_PIO_0 */	0x0d42ff7f
+};
+#endif
 
 #define HPT366_DEBUG_DRIVE_INFO		0
 #define HPT371_ALLOW_ATA133_6		1

