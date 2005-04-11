From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/4] libata-dev-2.6: pdc2027x change comments
Date: Mon, 11 Apr 2005 18:04:38 +0800
Message-ID: <425A4BB6.8090907@tw.ibm.com>
References: <425A49F6.3040904@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060307020400020008070309"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:29667 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261753AbVDKKFl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Apr 2005 06:05:41 -0400
In-Reply-To: <425A49F6.3040904@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060307020400020008070309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeff,

Change:
    pdc2027x: change comments, indent, etc.

Attached please find the patch 2/4 against the libata-dev-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--------------060307020400020008070309
Content-Type: text/plain;
 name="pdc_059.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pdc_059.diff"

--- libata-dev-2.6-058/drivers/scsi/pata_pdc2027x.c	2005-04-11 09:41:50.000000000 +0800
+++ libata-dev-2.6-059/drivers/scsi/pata_pdc2027x.c	2005-04-11 15:04:32.000000000 +0800
@@ -29,11 +29,11 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"pata_pdc2027x"
-#define DRV_VERSION	"0.58"
+#define DRV_VERSION	"0.59"
 #undef PDC_DEBUG
 
 #ifdef PDC_DEBUG
-#define PDPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__, ## args)
+#define PDPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __FUNCTION__, ## args)
 #else
 #define PDPRINTK(fmt, args...)
 #endif
@@ -217,8 +217,8 @@
 MODULE_DEVICE_TABLE(pci, pdc2027x_pci_tbl);
 
 /**
- * pdc_get_indexed_reg - Set pdc202xx extended register
- * @ap: Port to which the extended register is set
+ * pdc_get_indexed_reg - Get pdc202xx extended register
+ * @ap: Port to get the extended register
  * @index: index of the extended register
  */
 static u8 pdc_get_indexed_reg(struct ata_port *ap, u8 index)
@@ -232,8 +232,8 @@
 	return tmp8;
 }
 /**
- * pdc_set_indexed_reg - Read pdc202xx extended register
- * @ap: Port to which the extended register is read
+ * pdc_set_indexed_reg - Set pdc202xx extended register
+ * @ap: Port to set the extended register
  * @index: index of the extended register
  */
 static void pdc_set_indexed_reg(struct ata_port *ap, u8 index, u8 value)
@@ -322,7 +322,7 @@
 	PDPRINTK("adev->pio_mode[%X]\n", adev->pio_mode);
 
 	/* Sanity check */
-	if(pio > 4) {
+	if (pio > 4) {
 		printk(KERN_ERR DRV_NAME ": Unknown pio mode [%d] ignored\n", pio);
 		return;
 
@@ -357,7 +357,7 @@
 	u8 adj			= (drive_dn%2) ? 0x08 : 0x00;
 	u8 tmp8;
 
-	if((dma_mode >= XFER_UDMA_0) && 
+	if ((dma_mode >= XFER_UDMA_0) && 
 	   (dma_mode <= XFER_UDMA_6)) {
 		/* Set the UDMA timing registers with value table for 133MHz */
 		unsigned int udma_mode = dma_mode & 0x07;
@@ -380,7 +380,7 @@
 		
 		PDPRINTK("Set to udma mode[%u] \n", udma_mode);
 
-	} else  if((dma_mode >= XFER_MW_DMA_0) && 
+	} else  if ((dma_mode >= XFER_MW_DMA_0) && 
 		   (dma_mode <= XFER_MW_DMA_2)) {
 		/* Set the MDMA timing registers with value table for 133MHz */
 		unsigned int mdma_mode = dma_mode & 0x07;
@@ -451,7 +451,6 @@
 	if (cmd->request_bufflen % 256)
 		rc = 1;
 
-	PDPRINTK("request_bufflen %d, rc %d\n", cmd->request_bufflen, rc);
 	return rc;
 }
 
@@ -496,16 +495,16 @@
 	 * Calculate the ratio of F, R and OD
 	 * POUT = (F + 2) / (( R + 2) * NO)
 	 */
-	if (ratio < 8600L) { // 8.6x
+	if (ratio < 8600L) { /* 8.6x */
 		/* Using NO = 0x01, R = 0x0D */
 		R = 0x0d;
-	} else if (ratio < 12900L) { // 12.9x
+	} else if (ratio < 12900L) { /* 12.9x */
 		/* Using NO = 0x01, R = 0x08 */
 		R = 0x08;
-	} else if (ratio < 16100L) { // 16.1x
+	} else if (ratio < 16100L) { /* 16.1x */
 		/* Using NO = 0x01, R = 0x06 */
 		R = 0x06;
-	} else if (ratio < 64000L) { // 64x
+	} else if (ratio < 64000L) { /* 64x */
 		R = 0x00;
 	} else {
 		/* Invalid ratio */
@@ -639,7 +638,7 @@
 	 */
 	pll_clock = pdc_detect_pll_input_clock(pe);
 
-	if(pll_clock < 0) /* counter overflow? Try again. */
+	if (pll_clock < 0) /* counter overflow? Try again. */
 		pll_clock = pdc_detect_pll_input_clock(pe);
 
 	printk(KERN_INFO DRV_NAME ": PLL input clock %ld kHz\n", pll_clock/1000);
@@ -727,7 +726,7 @@
 	//pci_enable_intx(pdev);
 
 	/* initialize adapter */
-	if(pdc_hardware_init(pdev, probe_ent, board_idx) != 0)
+	if (pdc_hardware_init(pdev, probe_ent, board_idx) != 0)
 		goto err_out_free_ent;
 
 	ata_device_add(probe_ent);

--------------060307020400020008070309--


