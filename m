From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pdc2027x: Switch properly to ioread/iowrite
Date: Thu, 20 Sep 2007 15:07:12 +0100
Message-ID: <20070920150712.33d2973a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43659 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754707AbXITOAM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 10:00:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org, albertcc@tw.ibm.com

Some iomap functions were still using readl/writel and friends which
happens to work on most platforms but is not correct.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc6-mm1/drivers/ata/pata_pdc2027x.c linux-2.6.23rc6-mm1/drivers/ata/pata_pdc2027x.c
--- linux.vanilla-2.6.23rc6-mm1/drivers/ata/pata_pdc2027x.c	2007-09-18 15:32:51.000000000 +0100
+++ linux-2.6.23rc6-mm1/drivers/ata/pata_pdc2027x.c	2007-09-18 16:46:43.000000000 +0100
@@ -273,7 +273,7 @@
 	u32 cgcr;
 
 	/* check cable detect results */
-	cgcr = readl(port_mmio(ap, PDC_GLOBAL_CTL));
+	cgcr = ioread32(port_mmio(ap, PDC_GLOBAL_CTL));
 	if (cgcr & (1 << 26))
 		goto cbl40;
 
@@ -291,7 +291,7 @@
  */
 static inline int pdc2027x_port_enabled(struct ata_port *ap)
 {
-	return readb(port_mmio(ap, PDC_ATA_CTL)) & 0x02;
+	return ioread8(port_mmio(ap, PDC_ATA_CTL)) & 0x02;
 }
 
 /**
@@ -383,16 +383,16 @@
 	/* Set the PIO timing registers using value table for 133MHz */
 	PDPRINTK("Set pio regs... \n");
 
-	ctcr0 = readl(dev_mmio(ap, adev, PDC_CTCR0));
+	ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
 	ctcr0 &= 0xffff0000;
 	ctcr0 |= pdc2027x_pio_timing_tbl[pio].value0 |
 		(pdc2027x_pio_timing_tbl[pio].value1 << 8);
-	writel(ctcr0, dev_mmio(ap, adev, PDC_CTCR0));
+	iowrite32(ctcr0, dev_mmio(ap, adev, PDC_CTCR0));
 
-	ctcr1 = readl(dev_mmio(ap, adev, PDC_CTCR1));
+	ctcr1 = ioread32(dev_mmio(ap, adev, PDC_CTCR1));
 	ctcr1 &= 0x00ffffff;
 	ctcr1 |= (pdc2027x_pio_timing_tbl[pio].value2 << 24);
-	writel(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
+	iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
 
 	PDPRINTK("Set pio regs done\n");
 
@@ -426,18 +426,18 @@
 			 * If tHOLD is '1', the hardware will add half clock for data hold time.
 			 * This code segment seems to be no effect. tHOLD will be overwritten below.
 			 */
-			ctcr1 = readl(dev_mmio(ap, adev, PDC_CTCR1));
-			writel(ctcr1 & ~(1 << 7), dev_mmio(ap, adev, PDC_CTCR1));
+			ctcr1 = ioread32(dev_mmio(ap, adev, PDC_CTCR1));
+			iowrite32(ctcr1 & ~(1 << 7), dev_mmio(ap, adev, PDC_CTCR1));
 		}
 
 		PDPRINTK("Set udma regs... \n");
 
-		ctcr1 = readl(dev_mmio(ap, adev, PDC_CTCR1));
+		ctcr1 = ioread32(dev_mmio(ap, adev, PDC_CTCR1));
 		ctcr1 &= 0xff000000;
 		ctcr1 |= pdc2027x_udma_timing_tbl[udma_mode].value0 |
 			(pdc2027x_udma_timing_tbl[udma_mode].value1 << 8) |
 			(pdc2027x_udma_timing_tbl[udma_mode].value2 << 16);
-		writel(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
+		iowrite32(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
 
 		PDPRINTK("Set udma regs done\n");
 
@@ -449,13 +449,13 @@
 		unsigned int mdma_mode = dma_mode & 0x07;
 
 		PDPRINTK("Set mdma regs... \n");
-		ctcr0 = readl(dev_mmio(ap, adev, PDC_CTCR0));
+		ctcr0 = ioread32(dev_mmio(ap, adev, PDC_CTCR0));
 
 		ctcr0 &= 0x0000ffff;
 		ctcr0 |= (pdc2027x_mdma_timing_tbl[mdma_mode].value0 << 16) |
 			(pdc2027x_mdma_timing_tbl[mdma_mode].value1 << 24);
 
-		writel(ctcr0, dev_mmio(ap, adev, PDC_CTCR0));
+		iowrite32(ctcr0, dev_mmio(ap, adev, PDC_CTCR0));
 		PDPRINTK("Set mdma regs done\n");
 
 		PDPRINTK("Set to mdma mode[%u] \n", mdma_mode);
@@ -492,9 +492,9 @@
 			 * Enable prefetch if the device support PIO only.
 			 */
 			if (dev->xfer_shift == ATA_SHIFT_PIO) {
-				u32 ctcr1 = readl(dev_mmio(ap, dev, PDC_CTCR1));
+				u32 ctcr1 = ioread32(dev_mmio(ap, dev, PDC_CTCR1));
 				ctcr1 |= (1 << 25);
-				writel(ctcr1, dev_mmio(ap, dev, PDC_CTCR1));
+				iowrite32(ctcr1, dev_mmio(ap, dev, PDC_CTCR1));
 
 				PDPRINTK("Turn on prefetch\n");
 			} else {
@@ -559,12 +559,12 @@
 	u32 bccrl, bccrh, bccrlv, bccrhv;
 
 retry:
-	bccrl = readl(mmio_base + PDC_BYTE_COUNT) & 0x7fff;
-	bccrh = readl(mmio_base + PDC_BYTE_COUNT + 0x100) & 0x7fff;
+	bccrl = ioread32(mmio_base + PDC_BYTE_COUNT) & 0x7fff;
+	bccrh = ioread32(mmio_base + PDC_BYTE_COUNT + 0x100) & 0x7fff;
 
 	/* Read the counter values again for verification */
-	bccrlv = readl(mmio_base + PDC_BYTE_COUNT) & 0x7fff;
-	bccrhv = readl(mmio_base + PDC_BYTE_COUNT + 0x100) & 0x7fff;
+	bccrlv = ioread32(mmio_base + PDC_BYTE_COUNT) & 0x7fff;
+	bccrhv = ioread32(mmio_base + PDC_BYTE_COUNT + 0x100) & 0x7fff;
 
 	counter = (bccrh << 15) | bccrl;
 
@@ -613,7 +613,7 @@
 	/* Show the current clock value of PLL control register
 	 * (maybe already configured by the firmware)
 	 */
-	pll_ctl = readw(mmio_base + PDC_PLL_CTL);
+	pll_ctl = ioread16(mmio_base + PDC_PLL_CTL);
 
 	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
 #endif
@@ -653,8 +653,8 @@
 
 	PDPRINTK("Writing pll_ctl[%X]\n", pll_ctl);
 
-	writew(pll_ctl, mmio_base + PDC_PLL_CTL);
-	readw(mmio_base + PDC_PLL_CTL); /* flush */
+	iowrite16(pll_ctl, mmio_base + PDC_PLL_CTL);
+	ioread16(mmio_base + PDC_PLL_CTL); /* flush */
 
 	/* Wait the PLL circuit to be stable */
 	mdelay(30);
@@ -664,7 +664,7 @@
 	 *  Show the current clock value of PLL control register
 	 * (maybe configured by the firmware)
 	 */
-	pll_ctl = readw(mmio_base + PDC_PLL_CTL);
+	pll_ctl = ioread16(mmio_base + PDC_PLL_CTL);
 
 	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
 #endif
@@ -687,10 +687,10 @@
 	long pll_clock, usec_elapsed;
 
 	/* Start the test mode */
-	scr = readl(mmio_base + PDC_SYS_CTL);
+	scr = ioread32(mmio_base + PDC_SYS_CTL);
 	PDPRINTK("scr[%X]\n", scr);
-	writel(scr | (0x01 << 14), mmio_base + PDC_SYS_CTL);
-	readl(mmio_base + PDC_SYS_CTL); /* flush */
+	iowrite32(scr | (0x01 << 14), mmio_base + PDC_SYS_CTL);
+	ioread32(mmio_base + PDC_SYS_CTL); /* flush */
 
 	/* Read current counter value */
 	start_count = pdc_read_counter(host);
@@ -704,10 +704,10 @@
 	do_gettimeofday(&end_time);
 
 	/* Stop the test mode */
-	scr = readl(mmio_base + PDC_SYS_CTL);
+	scr = ioread32(mmio_base + PDC_SYS_CTL);
 	PDPRINTK("scr[%X]\n", scr);
-	writel(scr & ~(0x01 << 14), mmio_base + PDC_SYS_CTL);
-	readl(mmio_base + PDC_SYS_CTL); /* flush */
+	iowrite32(scr & ~(0x01 << 14), mmio_base + PDC_SYS_CTL);
+	ioread32(mmio_base + PDC_SYS_CTL); /* flush */
 
 	/* calculate the input clock in Hz */
 	usec_elapsed = (end_time.tv_sec - start_time.tv_sec) * 1000000 +
