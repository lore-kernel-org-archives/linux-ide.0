From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH ide-2.6 2/3] pdc202xx_new: PLL initialization support
Date: Fri, 04 Mar 2005 16:21:12 +0800
Message-ID: <42281A78.8030406@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:9704 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262619AbVCDIVU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Mar 2005 03:21:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>


Hi Bart,

   Attached please find the patch 2/3 against the ide-2.6 tree for your review. Thanks.

Changes:
2/3: Replace the index register macros with functions

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
----------------------------------------------------------------------------------------------------------
diff -Nru libata-dev-2.6-2/drivers/ide/pci/pdc202xx_new.c libata-dev-2.6-3/drivers/ide/pci/pdc202xx_new.c
--- libata-dev-2.6-2/drivers/ide/pci/pdc202xx_new.c	2005-03-03 17:54:56.000000000 +0800
+++ libata-dev-2.6-3/drivers/ide/pci/pdc202xx_new.c	2005-03-04 15:22:38.000000000 +0800
@@ -38,6 +38,13 @@
  #endif

  #define PDC202_DEBUG_CABLE	0
+#undef PDC_DEBUG
+
+#ifdef PDC_DEBUG
+#define PDPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__, ## args)
+#else
+#define PDPRINTK(fmt, args...)
+#endif

  const static char *pdc_quirk_drives[] = {
  	"QUANTUM FIREBALLlct08 08",
@@ -51,31 +58,71 @@
  	NULL
  };

-#define set_2regs(a, b)					\
-	do {						\
-		hwif->OUTB((a + adj), indexreg);	\
-		hwif->OUTB(b, datareg);			\
-	} while(0)
-
-#define set_ultra(a, b, c)				\
-	do {						\
-		set_2regs(0x10,(a));			\
-		set_2regs(0x11,(b));			\
-		set_2regs(0x12,(c));			\
-	} while(0)
-
-#define set_ata2(a, b)					\
-	do {						\
-		set_2regs(0x0e,(a));			\
-		set_2regs(0x0f,(b));			\
-	} while(0)
-
-#define set_pio(a, b, c)				\
-	do { 						\
-		set_2regs(0x0c,(a));			\
-		set_2regs(0x0d,(b));			\
-		set_2regs(0x13,(c));			\
-	} while(0)
+/*
+ * ATA Timing Tables based on 133MHz controller clock.
+ * These tables are only used when the controller is in 133MHz clock.
+ * If the controller is in 100MHz clock, the ASIC hardware will
+ * set the timing registers automatically when "set feature" command
+ * is issued to the device. However, if the controller clock is 133MHz,
+ * the following tables must be used.
+ */
+static struct pdcnew_pio_timing {
+	u8 value0, value1, value2;
+} pdcnew_pio_timing_tbl [] = {
+	{ 0xfb, 0x2b, 0xac }, /* PIO mode 0, IORDY off, Prefetch off */
+	{ 0x46, 0x29, 0xa4 }, /* PIO mode 1, IORDY off, Prefetch off */
+	{ 0x23, 0x26, 0x64 }, /* PIO mode 2, IORDY on,  Prefetch off */
+	{ 0x27, 0x0d, 0x35 }, /* PIO mode 3, IORDY on,  Prefetch off */
+	{ 0x23, 0x09, 0x25 }, /* PIO mode 4, IORDY on,  Prefetch off */
+};
+
+static struct pdcnew_mdma_timing {
+	u8 value0, value1;
+} pdcnew_mdma_timing_tbl [] = {
+	{ 0xdf, 0x5f }, /* MDMA mode 0 */
+	{ 0x6b, 0x27 }, /* MDMA mode 1 */
+	{ 0x69, 0x25 }, /* MDMA mode 2 */
+};
+
+static struct pdcnew_udma_timing {
+	u8 value0, value1, value2;
+} pdcnew_udma_timing_tbl [] = {
+	{ 0x4a, 0x0f, 0xd5 }, /* UDMA mode 0 */
+	{ 0x3a, 0x0a, 0xd0 }, /* UDMA mode 1 */
+	{ 0x2a, 0x07, 0xcd }, /* UDMA mode 2 */
+	{ 0x1a, 0x05, 0xcd }, /* UDMA mode 3 */
+	{ 0x1a, 0x03, 0xcd }, /* UDMA mode 4 */
+	{ 0x1a, 0x02, 0xcb }, /* UDMA mode 5 */
+	{ 0x1a, 0x01, 0xcb }, /* UDMA mode 6 */
+};
+
+/**
+ * pdc_get_indexed_reg - Get pdc202xx indexed register
+ * @hwif: Port to which the indexed register is set
+ * @index: index of the indexed register
+ */
+static u8 pdc_get_indexed_reg(ide_hwif_t *hwif, u8 index)
+{
+	u8 tmp8;
+
+	hwif->OUTB(index, hwif->dma_base + 1);
+	tmp8 = hwif->INB(hwif->dma_base + 3);
+
+	PDPRINTK("Get index reg%X[%X] \n", index, tmp8);
+	return tmp8;
+}
+
+/**
+ * pdc_set_indexed_reg - Set pdc202xx indexed register
+ * @hwif: Port to which the indexed register is read
+ * @index: index of the indexed register
+ */
+static void pdc_set_indexed_reg(ide_hwif_t *hwif, u8 index, u8 value)
+{
+	hwif->OUTB(index, hwif->dma_base + 1);
+	hwif->OUTB(value, hwif->dma_base + 3);
+	PDPRINTK("Set index reg%X[%X] \n", index, value);
+}

  static u8 pdcnew_ratemask(ide_drive_t *drive)
  {
@@ -126,36 +173,52 @@
  static int pdcnew_new_tune_chipset(ide_drive_t *drive, u8 xferspeed)
  {
  	ide_hwif_t *hwif	= HWIF(drive);
-	unsigned long indexreg	= hwif->dma_vendor1;
-	unsigned long datareg	= hwif->dma_vendor3;
-	u8 thold		= 0x10;
  	u8 adj			= (drive->dn%2) ? 0x08 : 0x00;
  	u8 speed		= ide_rate_filter(pdcnew_ratemask(drive), xferspeed);
+	unsigned int mode;

  	if (speed == XFER_UDMA_2) {
-		hwif->OUTB((thold + adj), indexreg);
-		hwif->OUTB((hwif->INB(datareg) & 0x7f), datareg);
-	}
+		u8 tmp8;
+
+		tmp8 = pdc_get_indexed_reg(hwif, 0x10 + adj);
+		pdc_set_indexed_reg(hwif, 0x10 + adj, tmp8 & 0x7f);
+	} else if (speed == XFER_UDMA_7)
+		speed = XFER_UDMA_6;
+
+	mode = speed & 0x07;

  	switch (speed) {
-		case XFER_UDMA_7:
-			speed = XFER_UDMA_6;
-		case XFER_UDMA_6:	set_ultra(0x1a, 0x01, 0xcb); break;
-		case XFER_UDMA_5:	set_ultra(0x1a, 0x02, 0xcb); break;
-		case XFER_UDMA_4:	set_ultra(0x1a, 0x03, 0xcd); break;
-		case XFER_UDMA_3:	set_ultra(0x1a, 0x05, 0xcd); break;
-		case XFER_UDMA_2:	set_ultra(0x2a, 0x07, 0xcd); break;
-		case XFER_UDMA_1:	set_ultra(0x3a, 0x0a, 0xd0); break;
-		case XFER_UDMA_0:	set_ultra(0x4a, 0x0f, 0xd5); break;
-		case XFER_MW_DMA_2:	set_ata2(0x69, 0x25); break;
-		case XFER_MW_DMA_1:	set_ata2(0x6b, 0x27); break;
-		case XFER_MW_DMA_0:	set_ata2(0xdf, 0x5f); break;
-		case XFER_PIO_4:	set_pio(0x23, 0x09, 0x25); break;
-		case XFER_PIO_3:	set_pio(0x27, 0x0d, 0x35); break;
-		case XFER_PIO_2:	set_pio(0x23, 0x26, 0x64); break;
-		case XFER_PIO_1:	set_pio(0x46, 0x29, 0xa4); break;
-		case XFER_PIO_0:	set_pio(0xfb, 0x2b, 0xac); break;
+		case XFER_UDMA_6:
+		case XFER_UDMA_5:
+		case XFER_UDMA_4:
+		case XFER_UDMA_3:
+		case XFER_UDMA_2:
+		case XFER_UDMA_1:
+		case XFER_UDMA_0:
+			pdc_set_indexed_reg(hwif, 0x10 + adj, pdcnew_udma_timing_tbl[mode].value0);
+			pdc_set_indexed_reg(hwif, 0x11 + adj, pdcnew_udma_timing_tbl[mode].value1);
+			pdc_set_indexed_reg(hwif, 0x12 + adj, pdcnew_udma_timing_tbl[mode].value2);
+			break;
+
+		case XFER_MW_DMA_2:
+		case XFER_MW_DMA_1:
+		case XFER_MW_DMA_0:
+			pdc_set_indexed_reg(hwif, 0x0e + adj, pdcnew_mdma_timing_tbl[mode].value0);
+			pdc_set_indexed_reg(hwif, 0x0f + adj, pdcnew_mdma_timing_tbl[mode].value1);
+			break;
+
+		case XFER_PIO_4:
+		case XFER_PIO_3:
+		case XFER_PIO_2:
+		case XFER_PIO_1:
+		case XFER_PIO_0:
+			pdc_set_indexed_reg(hwif, 0x0c + adj, pdcnew_pio_timing_tbl[mode].value0);
+			pdc_set_indexed_reg(hwif, 0x0d + adj, pdcnew_pio_timing_tbl[mode].value1);
+			pdc_set_indexed_reg(hwif, 0x13 + adj, pdcnew_pio_timing_tbl[mode].value2);
+			break;
+
  		default:
+			printk(KERN_ERR ": Unknown speed %d ignored\n", speed);
  			;
  	}

@@ -181,8 +244,7 @@

  static u8 pdcnew_new_cable_detect(ide_hwif_t *hwif)
  {
-	hwif->OUTB(0x0b, hwif->dma_vendor1);
-	return ((u8)((hwif->INB(hwif->dma_vendor3) & 0x04)));
+	return pdc_get_indexed_reg(hwif, 0x0b) & 0x04;
  }
  static int config_chipset_for_dma(ide_drive_t *drive)
  {
@@ -190,7 +252,6 @@
  	ide_hwif_t *hwif	= HWIF(drive);
  	u8 speed		= -1;
  	u8 cable;
-
  	u8 ultra_66		= ((id->dma_ultra & 0x0010) ||
  				   (id->dma_ultra & 0x0008)) ? 1 : 0;

@@ -205,8 +266,11 @@
  		return 0;

  	if (id->capability & 4) {	/* IORDY_EN & PREFETCH_EN */
-		hwif->OUTB((0x13 + ((drive->dn%2) ? 0x08 : 0x00)), hwif->dma_vendor1);
-		hwif->OUTB((hwif->INB(hwif->dma_vendor3)|0x03), hwif->dma_vendor3);
+		u8 adj = (drive->dn%2) ? 0x08 : 0x00;
+		u8 tmp8;
+
+		tmp8 = pdc_get_indexed_reg(hwif, 0x13 + adj);
+		pdc_set_indexed_reg(hwif, 0x13 + adj, tmp8 | 0x03);
  	}

  	speed = ide_dma_speed(drive, pdcnew_ratemask(drive));



