From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH ide-2.6] pdc202xx_new: hardware auto set timing registers
 fix
Date: Mon, 07 Mar 2005 18:43:27 +0800
Message-ID: <422C304F.5070800@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:28654 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261725AbVCGKng (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2005 05:43:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Hi Bart,

   These is the patches for pdc202xx_new hardware auto set timing register problem.
(Promise pdc2027x hardware will look at the SET FEATURES and set the timing registers
automatically. Under 133MHz PLL, the values set by the hardware is based on 100MHz and is incorrect.)

Changes:
  - Reorder initialization sequence in pdcnew_new_tune_chipset() to issue SETFEATURES_XFER to the drive first.
  - If the adapter is running 133MHz PLL, then override the timing registers set by hardware by software.

  Attached please find the patch against the ide-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
-------
diff -Nru libata-dev-2.6-pll/drivers/ide/pci/pdc202xx_new.c libata-dev-2.6-hwauto/drivers/ide/pci/pdc202xx_new.c
--- libata-dev-2.6-pll/drivers/ide/pci/pdc202xx_new.c	2005-03-04 15:48:09.000000000 +0800
+++ libata-dev-2.6-hwauto/drivers/ide/pci/pdc202xx_new.c	2005-03-07 18:19:06.000000000 +0800
@@ -191,6 +191,13 @@
  	u8 adj			= (drive->dn%2) ? 0x08 : 0x00;
  	u8 speed		= ide_rate_filter(pdcnew_ratemask(drive), xferspeed);
  	unsigned int mode;
+	int rc;
+
+	/*
+	 * Issue SETFEATURES_XFER to the drive first. The pdc202xx hardware will
+	 * automatically set the timing registers based on 100MHz PLL.
+	 */
+	rc = ide_config_drive_speed(drive, speed);

  	if (speed == XFER_UDMA_2) {
  		u8 tmp8;
@@ -200,44 +207,50 @@
  	} else if (speed == XFER_UDMA_7)
  		speed = XFER_UDMA_6;

-	mode = speed & 0x07;
+	/*
+	 * Override the timing registers by software if the PLL is 133MHz.
+	 */
+	if (pdcnew_chip_clock(hwif->pci_dev) == 4) {
+		mode = speed & 0x07;

-	switch (speed) {
-		case XFER_UDMA_6:
-		case XFER_UDMA_5:
-		case XFER_UDMA_4:
-		case XFER_UDMA_3:
-		case XFER_UDMA_2:
-		case XFER_UDMA_1:
-		case XFER_UDMA_0:
-			pdc_set_indexed_reg(hwif, 0x10 + adj, pdcnew_udma_timing_tbl[mode].value0);
-			pdc_set_indexed_reg(hwif, 0x11 + adj, pdcnew_udma_timing_tbl[mode].value1);
-			pdc_set_indexed_reg(hwif, 0x12 + adj, pdcnew_udma_timing_tbl[mode].value2);
-			break;
-
-		case XFER_MW_DMA_2:
-		case XFER_MW_DMA_1:
-		case XFER_MW_DMA_0:
-			pdc_set_indexed_reg(hwif, 0x0e + adj, pdcnew_mdma_timing_tbl[mode].value0);
-			pdc_set_indexed_reg(hwif, 0x0f + adj, pdcnew_mdma_timing_tbl[mode].value1);
-			break;
-
-		case XFER_PIO_4:
-		case XFER_PIO_3:
-		case XFER_PIO_2:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-			pdc_set_indexed_reg(hwif, 0x0c + adj, pdcnew_pio_timing_tbl[mode].value0);
-			pdc_set_indexed_reg(hwif, 0x0d + adj, pdcnew_pio_timing_tbl[mode].value1);
-			pdc_set_indexed_reg(hwif, 0x13 + adj, pdcnew_pio_timing_tbl[mode].value2);
-			break;
-
-		default:
-			printk(KERN_ERR DRV_NAME ": Unknown speed %d ignored\n", speed);
-			;
+	
+		switch (speed) {
+			case XFER_UDMA_6:
+			case XFER_UDMA_5:
+			case XFER_UDMA_4:
+			case XFER_UDMA_3:
+			case XFER_UDMA_2:
+			case XFER_UDMA_1:
+			case XFER_UDMA_0:
+				pdc_set_indexed_reg(hwif, 0x10 + adj, pdcnew_udma_timing_tbl[mode].value0);
+				pdc_set_indexed_reg(hwif, 0x11 + adj, pdcnew_udma_timing_tbl[mode].value1);
+				pdc_set_indexed_reg(hwif, 0x12 + adj, pdcnew_udma_timing_tbl[mode].value2);
+				break;
+
+			case XFER_MW_DMA_2:
+			case XFER_MW_DMA_1:
+			case XFER_MW_DMA_0:
+				pdc_set_indexed_reg(hwif, 0x0e + adj, pdcnew_mdma_timing_tbl[mode].value0);
+				pdc_set_indexed_reg(hwif, 0x0f + adj, pdcnew_mdma_timing_tbl[mode].value1);
+				break;
+
+			case XFER_PIO_4:
+			case XFER_PIO_3:
+			case XFER_PIO_2:
+			case XFER_PIO_1:
+			case XFER_PIO_0:
+				pdc_set_indexed_reg(hwif, 0x0c + adj, pdcnew_pio_timing_tbl[mode].value0);
+				pdc_set_indexed_reg(hwif, 0x0d + adj, pdcnew_pio_timing_tbl[mode].value1);
+				pdc_set_indexed_reg(hwif, 0x13 + adj, pdcnew_pio_timing_tbl[mode].value2);
+				break;
+
+			default:
+				printk(KERN_ERR DRV_NAME ": Unknown speed %d ignored\n", speed);
+				;
+		}
  	}

-	return (ide_config_drive_speed(drive, speed));
+	return rc;
  }

  /*   0    1    2    3    4    5    6   7   8


