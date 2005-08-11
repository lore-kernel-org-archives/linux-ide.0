From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 1/3] libata-dev: Convert pdc2027x from PIO to MMIO
Date: Thu, 11 Aug 2005 17:49:44 +0800
Message-ID: <42FB1F38.8010007@tw.ibm.com>
References: <42F24DBE.0@tw.ibm.com> <42F25114.1050009@tw.ibm.com> <42FABFEC.8080600@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040709070200010003000309"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:57321 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S932337AbVHKJuf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 05:50:35 -0400
In-Reply-To: <42FABFEC.8080600@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>

This is a multi-part message in MIME format.
--------------040709070200010003000309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Jeff,

> Albert Lee wrote:
> 
>> Jeff,
>>
>> Patch 1/3: Convert pdc2027x from PIO to MMIO
>>
>> Description:
>>     Indexed registers need two PIO accesses: one access writes to the 
>> index register and the other access
>> reads/writes the indexed register. Using MMIO can access the register 
>> directly and simplify the code.
>>
>> Changes:
>>   - Use MMIO instead of PIO and indexed registers.
>>   - Minor fix such as add ata_host_stop hook and indent 
>> beautification, etc.
> 
> 
> Comments:
> 
> 1) port_mmio() and dev_mmio() should be static inline

Fixed.

> 
> 2) The -only- valid way to flush a write to the device across the PCI 
> bus is with a corresponding read[bwl]().  wmb() is not sufficient.
> 

Fixed to use readl() instead of wmb(). Thanks for the advice.
Attached please find the fixed patch for your review.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>


--------------040709070200010003000309
Content-Type: text/plain;
 name="pdc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc1.diff"

--- linux/drivers/scsi/pata_pdc2027x.c	2005-08-02 13:50:14.000000000 +0800
+++ 01_pdc_mmio/drivers/scsi/pata_pdc2027x.c	2005-08-11 16:43:25.000000000 +0800
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.60"
+#define DRV_VERSION	"0.70"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
@@ -39,11 +39,19 @@
 #endif
 
 enum {
-	PDC_UDMA_100        = 0,
-	PDC_UDMA_133        = 1,
+	PDC_UDMA_100		= 0,
+	PDC_UDMA_133		= 1,
 	
-	PDC_100_MHZ         = 100000000,
-	PDC_133_MHZ         = 133333333,
+	PDC_100_MHZ		= 100000000,
+	PDC_133_MHZ		= 133333333,
+
+	PDC_SYS_CTL		= 0x1100,
+	PDC_ATA_CTL		= 0x1104,
+	PDC_GLOBAL_CTL		= 0x1108,
+	PDC_CTCR0		= 0x110C,
+	PDC_CTCR1		= 0x1110,
+	PDC_BYTE_COUNT		= 0x1120,
+	PDC_PLL_CTL		= 0x1202,
 };
 
 static int pdc2027x_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -187,6 +195,7 @@
 
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
 };
 
 static struct ata_port_info pdc2027x_port_info[] = {
@@ -194,7 +203,7 @@
 	{
 		.sht		= &pdc2027x_sht,
 		.host_flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS | 
-		                  ATA_FLAG_SRST,
+		                  ATA_FLAG_SRST | ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA5, /* udma0-5 */
@@ -204,7 +213,7 @@
 	{
 		.sht		= &pdc2027x_sht,
 		.host_flags	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS | 
-                        	  ATA_FLAG_SRST,
+                        	  ATA_FLAG_SRST | ATA_FLAG_MMIO,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= ATA_UDMA6, /* udma0-6 */
@@ -218,31 +227,27 @@
 MODULE_DEVICE_TABLE(pci, pdc2027x_pci_tbl);
 
 /**
- * pdc_get_indexed_reg - Get pdc202xx extended register
- * @ap: Port to get the extended register
- * @index: index of the extended register
+ *	port_mmio - Get the MMIO address of PDC2027x extended registers
+ *	@ap: Port
+ *	@offset: offset from mmio base
  */
-static u8 pdc_get_indexed_reg(struct ata_port *ap, u8 index)
+static inline void* port_mmio(struct ata_port *ap, unsigned int offset)
 {
-	u8 tmp8;
-
-	outb(index, ap->ioaddr.bmdma_addr + 1); 
-	tmp8 = inb(ap->ioaddr.bmdma_addr + 3);
-
-	PDPRINTK("Get index reg%X[%X] \n", index, tmp8);
-	return tmp8;
+	return ap->host_set->mmio_base + ap->port_no * 0x100 + offset;
 }
+
 /**
- * pdc_set_indexed_reg - Set pdc202xx extended register
- * @ap: Port to set the extended register
- * @index: index of the extended register
+ *	dev_mmio - Get the MMIO address of PDC2027x extended registers
+ *	@ap: Port
+ *	@adev: device
+ *	@offset: offset from mmio base
  */
-static void pdc_set_indexed_reg(struct ata_port *ap, u8 index, u8 value)
+static inline void* dev_mmio(struct ata_port *ap, struct ata_device *adev, unsigned int offset)
 {
-	outb(index, ap->ioaddr.bmdma_addr + 1); 
-	outb(value, ap->ioaddr.bmdma_addr + 3);
-	PDPRINTK("Set index reg%X[%X] \n", index, value);
+	u8 adj = (adev->devno) ? 0x08 : 0x00;
+	return port_mmio(ap, offset) + adj;
 }
+
 /**
  *	pdc2027x_pata_cbl_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
@@ -255,12 +260,11 @@
  */
 static void pdc2027x_cbl_detect(struct ata_port *ap)
 {
-	u8 cbl40c;
+	u32 cgcr;
 
 	/* check cable detect results */
-	cbl40c = pdc_get_indexed_reg(ap, 0x0b) & 0x04;
-
-	if (cbl40c)
+	cgcr = readl(port_mmio(ap, PDC_GLOBAL_CTL));
+	if (cgcr & (1 << 26))
 		goto cbl40;
 
 	PDPRINTK("No cable or 80-conductor cable on port %d\n", ap->port_no);
@@ -273,14 +277,16 @@
 	ap->cbl = ATA_CBL_PATA40;
 	ap->udma_mask &= ATA_UDMA_MASK_40C;
 }
+
 /**
- * pdc2027x_port_enabled - Check extended register at 0x04 to see whether the port is enabled.
+ * pdc2027x_port_enabled - Check PDC ATA control register to see whether the port is enabled.
  * @ap: Port to check
  */
 static inline int pdc2027x_port_enabled(struct ata_port *ap)
 {
-	return pdc_get_indexed_reg(ap, 0x04) & 0x02;
+	return readb(port_mmio(ap, PDC_ATA_CTL)) & 0x02;
 }
+
 /**
  *	pdc2027x_phy_reset - Probe specified port on PATA host controller
  *	@ap: Port to probe
@@ -303,6 +309,7 @@
 	ata_port_probe(ap);
 	ata_bus_reset(ap);
 }
+
 /**
  *	pdc2027x_set_piomode - Initialize host controller PATA PIO timings
  *	@ap: Port to configure
@@ -316,9 +323,8 @@
  */
 static void pdc2027x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
-	unsigned int pio      = adev->pio_mode - XFER_PIO_0;
-	unsigned int drive_dn = (ap->port_no ? 2 : 0) + adev->devno;
-	u8 adj		      = (drive_dn%2) ? 0x08 : 0x00;
+	unsigned int pio = adev->pio_mode - XFER_PIO_0;
+	u32 ctcr0, ctcr1;
 
 	PDPRINTK("adev->pio_mode[%X]\n", adev->pio_mode);
 
@@ -332,14 +338,22 @@
 	/* Set the PIO timing registers using value table for 133MHz */
 	PDPRINTK("Set pio regs... \n");
 
-	pdc_set_indexed_reg(ap, 0x0c + adj, pdc2027x_pio_timing_tbl[pio].value0);
-	pdc_set_indexed_reg(ap, 0x0d + adj, pdc2027x_pio_timing_tbl[pio].value1);
-	pdc_set_indexed_reg(ap, 0x13 + adj, pdc2027x_pio_timing_tbl[pio].value2);
+	ctcr0 = readl(dev_mmio(ap, adev, PDC_CTCR0));
+	ctcr0 &= 0xffff0000;
+	ctcr0 |= pdc2027x_pio_timing_tbl[pio].value0 |
+		(pdc2027x_pio_timing_tbl[pio].value1 << 8);
+	writel(ctcr0, dev_mmio(ap, adev, PDC_CTCR0));
+
+	ctcr1 = readl(dev_mmio(ap, adev, PDC_CTCR1));
+	ctcr1 &= 0x00ffffff;
+	ctcr1 |= (pdc2027x_pio_timing_tbl[pio].value2 << 24);
+	writel(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
 
 	PDPRINTK("Set pio regs done\n");
 
 	PDPRINTK("Set to pio mode[%u] \n", pio);
 }
+
 /**
  *	pdc2027x_set_dmamode - Initialize host controller PATA UDMA timings
  *	@ap: Port to configure
@@ -353,12 +367,10 @@
  */
 static void pdc2027x_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
-	unsigned int dma_mode	= adev->dma_mode;
-	unsigned int drive_dn	= (ap->port_no ? 2 : 0) + adev->devno;
-	u8 adj			= (drive_dn%2) ? 0x08 : 0x00;
-	u8 tmp8;
+	unsigned int dma_mode = adev->dma_mode;
+	u32 ctcr0, ctcr1;
 
-	if ((dma_mode >= XFER_UDMA_0) && 
+	if ((dma_mode >= XFER_UDMA_0) &&
 	   (dma_mode <= XFER_UDMA_6)) {
 		/* Set the UDMA timing registers with value table for 133MHz */
 		unsigned int udma_mode = dma_mode & 0x07;
@@ -369,14 +381,19 @@
 			 * If tHOLD is '1', the hardware will add half clock for data hold time.
 			 * This code segment seems to be no effect. tHOLD will be overwritten below.
 			 */
-			tmp8 = pdc_get_indexed_reg(ap, 0x10 + adj);
-			pdc_set_indexed_reg(ap, 0x10 + adj, tmp8 & 0x7f);
+			ctcr1 = readl(dev_mmio(ap, adev, PDC_CTCR1));
+			writel(ctcr1 & ~(1 << 7), dev_mmio(ap, adev, PDC_CTCR1));
 		} 
 
 		PDPRINTK("Set udma regs... \n");
-		pdc_set_indexed_reg(ap, 0x10 + adj, pdc2027x_udma_timing_tbl[udma_mode].value0);
-		pdc_set_indexed_reg(ap, 0x11 + adj, pdc2027x_udma_timing_tbl[udma_mode].value1);
-		pdc_set_indexed_reg(ap, 0x12 + adj, pdc2027x_udma_timing_tbl[udma_mode].value2);
+
+		ctcr1 = readl(dev_mmio(ap, adev, PDC_CTCR1));
+		ctcr1 &= 0xff000000;
+		ctcr1 |= pdc2027x_udma_timing_tbl[udma_mode].value0 |
+			(pdc2027x_udma_timing_tbl[udma_mode].value1 << 8) |
+			(pdc2027x_udma_timing_tbl[udma_mode].value2 << 16);
+		writel(ctcr1, dev_mmio(ap, adev, PDC_CTCR1));
+		
 		PDPRINTK("Set udma regs done\n");
 		
 		PDPRINTK("Set to udma mode[%u] \n", udma_mode);
@@ -387,8 +404,13 @@
 		unsigned int mdma_mode = dma_mode & 0x07;
 
 		PDPRINTK("Set mdma regs... \n");
-		pdc_set_indexed_reg(ap, 0x0e + adj, pdc2027x_mdma_timing_tbl[mdma_mode].value0);
-		pdc_set_indexed_reg(ap, 0x0f + adj, pdc2027x_mdma_timing_tbl[mdma_mode].value1);
+		ctcr0 = readl(dev_mmio(ap, adev, PDC_CTCR0));
+
+		ctcr0 &= 0x0000ffff;
+		ctcr0 |= (pdc2027x_mdma_timing_tbl[mdma_mode].value0 << 16) |
+			(pdc2027x_mdma_timing_tbl[mdma_mode].value1 << 24);
+		
+		writel(ctcr0, dev_mmio(ap, adev, PDC_CTCR0));
 		PDPRINTK("Set mdma regs done\n");
 		
 		PDPRINTK("Set to mdma mode[%u] \n", mdma_mode);
@@ -413,18 +435,17 @@
 		struct ata_device *dev = &ap->device[i];
 
 		if (ata_dev_present(dev)) {
-			u8 adj = (i % 2) ? 0x08 : 0x00;
-			u8 tmp8;
 			
 			pdc2027x_set_piomode(ap, dev);
 
 			/*
 			 * Enable prefetch if the device support PIO only.
 			 */
-			if (dev->xfer_shift == ATA_SHIFT_PIO) { 
-				tmp8 = pdc_get_indexed_reg(ap, 0x13 + adj);
-				pdc_set_indexed_reg(ap, 0x13 + adj, tmp8 | 0x02);
-				
+			if (dev->xfer_shift == ATA_SHIFT_PIO) {
+				u32 ctcr1 = readl(dev_mmio(ap, dev, PDC_CTCR1));
+				ctcr1 |= (1 << 25);
+				writel(ctcr1, dev_mmio(ap, dev, PDC_CTCR1));
+
 				PDPRINTK("Turn on prefetch\n");
 			} else {
 				pdc2027x_set_dmamode(ap, dev);
@@ -462,43 +483,31 @@
 
 static unsigned long pdc_read_counter(struct ata_probe_ent *probe_ent)
 {
-	u8 ctr0, ctr1, ctr2, ctr3;
 	unsigned long counter;
-	u8 ctr0v, ctr1v, ctr2v, ctr3v;
 	int retry = 1;
+	u32 bccrl, bccrh, bccrlv, bccrhv;
 
 retry:
-	outb(0x20, probe_ent->port[0].bmdma_addr + 0x01);
-	ctr0 = inb(probe_ent->port[0].bmdma_addr + 0x03);
-	outb(0x21, probe_ent->port[0].bmdma_addr + 0x01);
-	ctr1 = inb(probe_ent->port[0].bmdma_addr + 0x03);
-	outb(0x20, probe_ent->port[1].bmdma_addr + 0x01);
-	ctr2 = inb(probe_ent->port[1].bmdma_addr + 0x03);
-	outb(0x21, probe_ent->port[1].bmdma_addr + 0x01);
-	ctr3 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+	bccrl = readl(probe_ent->mmio_base + PDC_BYTE_COUNT) & 0xffff;
+	bccrh = readl(probe_ent->mmio_base + PDC_BYTE_COUNT + 0x100) & 0xffff;
+	rmb();
 
 	/* Read the counter values again for verification */
-	outb(0x20,  probe_ent->port[0].bmdma_addr + 0x01);
-	ctr0v = inb(probe_ent->port[0].bmdma_addr + 0x03);
-	outb(0x21,  probe_ent->port[0].bmdma_addr + 0x01);
-	ctr1v = inb(probe_ent->port[0].bmdma_addr + 0x03);
-	outb(0x20,  probe_ent->port[1].bmdma_addr + 0x01);
-	ctr2v = inb(probe_ent->port[1].bmdma_addr + 0x03);
-	outb(0x21,  probe_ent->port[1].bmdma_addr + 0x01);
-	ctr3v = inb(probe_ent->port[1].bmdma_addr + 0x03);
-
-	counter = (ctr3 << 23) | (ctr2 << 15) | (ctr1 << 8) | ctr0;
-
-	PDPRINTK("ctr0[%X] ctr1[%X] ctr2[%X] ctr3[%X]\n", 
-		 ctr0, ctr1, ctr2, ctr3);
-	PDPRINTK("ctr0[%X] ctr1[%X] ctr2[%X] ctr3[%X]\n", 
-		 ctr0v, ctr1v, ctr2v, ctr3v);
+	bccrlv = readl(probe_ent->mmio_base + PDC_BYTE_COUNT) & 0xffff;
+	bccrhv = readl(probe_ent->mmio_base + PDC_BYTE_COUNT + 0x100) & 0xffff;
+	rmb();
+
+	counter = (bccrh << 15) | bccrl;
+
+	PDPRINTK("bccrh [%X] bccrl [%X]\n", bccrh,  bccrl);
+	PDPRINTK("bccrhv[%X] bccrlv[%X]\n", bccrhv, bccrlv);
 
 	/*
-	 * The 30-bit decreasing counter are read by 4 pieces.
-	 * Incorrect value may be read when ctr2 and ctr3 are changing.
+	 * The 30-bit decreasing counter are read by 2 pieces.
+	 * Incorrect value may be read when both bccrh and bccrl are changing.
+	 * Ex. When 7900 decrease to 78FF, wrong value 7800 might be read.
 	 */
-	if (retry && !(ctr3 == ctr3v && ctr2 == ctr2v && ctr1 >= ctr1v)) {
+	if (retry && !(bccrh == bccrhv && bccrl >= bccrlv)) {
 		retry--;
 		PDPRINTK("rereading counter\n");
 		goto retry;
@@ -517,12 +526,11 @@
 static void pdc_adjust_pll(struct ata_probe_ent *probe_ent, long pll_clock, unsigned int board_idx) 
 {
 
-	u8 pll_ctl0, pll_ctl1;
+	u16 pll_ctl;
 	long pll_clock_khz = pll_clock / 1000;
 	long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;
 	long ratio = pout_required / pll_clock_khz;
 	int F, R;
-	
 
 	/* Sanity check */
 	if (unlikely(pll_clock_khz < 5000L || pll_clock_khz > 70000L)) {
@@ -536,12 +544,9 @@
 	/* Show the current clock value of PLL control register
 	 * (maybe already configured by the firmware)
 	 */
-	outb(0x02, probe_ent->port[1].bmdma_addr + 0x01);
-	pll_ctl0 = inb(probe_ent->port[1].bmdma_addr + 0x03);
-	outb(0x03, probe_ent->port[1].bmdma_addr + 0x01);
-	pll_ctl1 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+	pll_ctl = readw(probe_ent->mmio_base + PDC_PLL_CTL);
 
-	PDPRINTK("pll_ctl[%X][%X]\n", pll_ctl0, pll_ctl1);
+	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
 #endif
 
 	/* 
@@ -575,15 +580,12 @@
 
 	PDPRINTK("F[%d] R[%d] ratio*1000[%ld]\n", F, R, ratio);
 
-	pll_ctl0 = (u8) F;
-	pll_ctl1 = (u8) R;
+	pll_ctl = (R << 8) | F;
 
-	PDPRINTK("Writing pll_ctl[%X][%X]\n", pll_ctl0, pll_ctl1);
+	PDPRINTK("Writing pll_ctl[%X]\n", pll_ctl);
 
-	outb(0x02,     probe_ent->port[1].bmdma_addr + 0x01);
-	outb(pll_ctl0, probe_ent->port[1].bmdma_addr + 0x03);
-	outb(0x03,     probe_ent->port[1].bmdma_addr + 0x01);
-	outb(pll_ctl1, probe_ent->port[1].bmdma_addr + 0x03);
+	writew(pll_ctl, probe_ent->mmio_base + PDC_PLL_CTL);
+	readw(probe_ent->mmio_base + PDC_PLL_CTL); /* flush */
 
 	/* Wait the PLL circuit to be stable */
 	mdelay(30);
@@ -593,12 +595,9 @@
 	 *  Show the current clock value of PLL control register
 	 * (maybe configured by the firmware)
 	 */
-	outb(0x02, probe_ent->port[1].bmdma_addr + 0x01);
-	pll_ctl0 = inb(probe_ent->port[1].bmdma_addr + 0x03);
-	outb(0x03, probe_ent->port[1].bmdma_addr + 0x01);
-	pll_ctl1 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+	pll_ctl = readw(probe_ent->mmio_base + PDC_PLL_CTL);
 
-	PDPRINTK("pll_ctl[%X][%X]\n", pll_ctl0, pll_ctl1);
+	PDPRINTK("pll_ctl[%X]\n", pll_ctl);
 #endif
 
 	return;
@@ -612,7 +611,7 @@
  */
 static long pdc_detect_pll_input_clock(struct ata_probe_ent *probe_ent) 
 {
-	u8 scr1;
+	u32 scr;
 	unsigned long start_count, end_count;
 	long pll_clock;
 
@@ -620,10 +619,10 @@
 	start_count = pdc_read_counter(probe_ent);
 
 	/* Start the test mode */
-	outb(0x01, probe_ent->port[0].bmdma_addr + 0x01);
-	scr1 = inb(probe_ent->port[0].bmdma_addr + 0x03);
-	PDPRINTK("scr1[%X]\n", scr1);
-	outb(scr1 | 0x40, probe_ent->port[0].bmdma_addr + 0x03);
+	scr = readl(probe_ent->mmio_base + PDC_SYS_CTL);
+	PDPRINTK("scr[%X]\n", scr);
+	writel(scr | (0x01 << 14), probe_ent->mmio_base + PDC_SYS_CTL);
+	readl(probe_ent->mmio_base + PDC_SYS_CTL); /* flush */
 
 	/* Let the counter run for 100 ms. */
 	mdelay(100);
@@ -632,10 +631,10 @@
 	end_count = pdc_read_counter(probe_ent);
 
 	/* Stop the test mode */
-	outb(0x01, probe_ent->port[0].bmdma_addr + 0x01);
-	scr1 = inb(probe_ent->port[0].bmdma_addr + 0x03);
-	PDPRINTK("scr1[%X]\n", scr1);
-	outb(scr1 & 0xBF, probe_ent->port[0].bmdma_addr + 0x03);
+	scr = readl(probe_ent->mmio_base + PDC_SYS_CTL);
+	PDPRINTK("scr[%X]\n", scr);
+	writel(scr & ~(0x01 << 14), probe_ent->mmio_base + PDC_SYS_CTL);
+	readl(probe_ent->mmio_base + PDC_SYS_CTL); /* flush */
 
 	/* calculate the input clock in Hz */
 	pll_clock = (long) ((start_count - end_count) * 10);
@@ -645,6 +644,7 @@
 
 	return pll_clock;
 }
+
 /**
  * pdc_hardware_init - Initialize the hardware.
  * @pdev: instance of pci_dev found
@@ -673,6 +673,29 @@
 
 	return 0;
 }
+
+/**
+ * pdc_ata_setup_port - setup the mmio address
+ * @port: ata ioports to setup
+ * @base: base address
+ */
+static void pdc_ata_setup_port(struct ata_ioports *port, unsigned long base)
+{
+	port->cmd_addr		=
+	port->data_addr		= base;
+	port->feature_addr	=
+	port->error_addr	= base + 0x05;
+	port->nsect_addr	= base + 0x0a;
+	port->lbal_addr		= base + 0x0f;
+	port->lbam_addr		= base + 0x10;
+	port->lbah_addr		= base + 0x15;
+	port->device_addr	= base + 0x1a;
+	port->command_addr	=
+	port->status_addr	= base + 0x1f;
+	port->altstatus_addr	=
+	port->ctl_addr		= base + 0x81a;
+}
+
 /**
  * pdc2027x_init_one - PCI probe function
  * Called when an instance of PCI adapter is inserted.
@@ -690,6 +713,8 @@
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 
 	struct ata_probe_ent *probe_ent = NULL;
+	unsigned long base;
+	void *mmio_base;
 	int rc;
 
 	if (!printed_version++)
@@ -722,28 +747,31 @@
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
 
+	mmio_base = ioremap(pci_resource_start(pdev, 5),
+		            pci_resource_len(pdev, 5));
+
+	if (mmio_base == NULL) {
+		rc = -ENOMEM;
+		goto err_out_free_ent;
+	}
+
+	base = (unsigned long) mmio_base;
+
 	probe_ent->sht		= pdc2027x_port_info[board_idx].sht;
 	probe_ent->host_flags	= pdc2027x_port_info[board_idx].host_flags;
 	probe_ent->pio_mask	= pdc2027x_port_info[board_idx].pio_mask;
+	probe_ent->mwdma_mask	= pdc2027x_port_info[board_idx].mwdma_mask;
 	probe_ent->udma_mask	= pdc2027x_port_info[board_idx].udma_mask;
 	probe_ent->port_ops	= pdc2027x_port_info[board_idx].port_ops;
 
        	probe_ent->irq = pdev->irq;
        	probe_ent->irq_flags = SA_SHIRQ;
+	probe_ent->mmio_base = mmio_base;
 
-	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
-	ata_std_ports(&probe_ent->port[0]);
-	probe_ent->port[0].altstatus_addr =
-		probe_ent->port[0].ctl_addr =
-		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
-	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
-
-	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
-	ata_std_ports(&probe_ent->port[1]);
-	probe_ent->port[1].altstatus_addr =
-		probe_ent->port[1].ctl_addr =
-		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
-	probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
+	pdc_ata_setup_port(&probe_ent->port[0], base + 0x17c0);
+	probe_ent->port[0].bmdma_addr = base + 0x1000;
+	pdc_ata_setup_port(&probe_ent->port[1], base + 0x15c0);
+	probe_ent->port[1].bmdma_addr = base + 0x1008;
 
 	probe_ent->n_ports = 2;
 
@@ -767,6 +795,7 @@
 	pci_disable_device(pdev);
 	return rc;
 }
+
 /**
  * pdc2027x_remove_one - Called to remove a single instance of the
  * adapter.
@@ -778,6 +807,7 @@
 {
 	ata_pci_remove_one(pdev);
 }
+
 /**
  * pdc2027x_init - Called after this module is loaded into the kernel.
  */
@@ -785,6 +815,7 @@
 {
 	return pci_module_init(&pdc2027x_pci_driver);
 }
+
 /**
  * pdc2027x_exit - Called before this module unloaded from the kernel
  */

--------------040709070200010003000309--


