From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH ide-2.6 3/3] pdc202xx_new: PLL initialization support
Date: Fri, 04 Mar 2005 16:24:10 +0800
Message-ID: <42281B2A.8060005@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from bluehawaii.tikira.net ([61.62.22.51]:31718 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262623AbVCDIYP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Mar 2005 03:24:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>


Hi Bart,

   Attached please find the patch 3/3 against the ide-2.6 tree for your review. Thanks.

Changes:
3/3: Add PLL initialization code

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
-----------------------------------------------------------------------------------------------------------
diff -Nru libata-dev-2.6-3/drivers/ide/pci/pdc202xx_new.c libata-dev-2.6-pll/drivers/ide/pci/pdc202xx_new.c
--- libata-dev-2.6-3/drivers/ide/pci/pdc202xx_new.c	2005-03-04 15:22:38.000000000 +0800
+++ libata-dev-2.6-pll/drivers/ide/pci/pdc202xx_new.c	2005-03-04 15:48:09.000000000 +0800
@@ -32,6 +32,9 @@
  #include <asm/io.h>
  #include <asm/irq.h>

+#define DRV_NAME	"pdc202xx_new"
+#define DRV_VERSION	"0.50"
+
  #ifdef CONFIG_PPC_PMAC
  #include <asm/prom.h>
  #include <asm/pci-bridge.h>
@@ -46,6 +49,11 @@
  #define PDPRINTK(fmt, args...)
  #endif

+enum {
+	PDC_100_MHZ         = 100000000,
+	PDC_133_MHZ         = 133333333,
+};
+
  const static char *pdc_quirk_drives[] = {
  	"QUANTUM FIREBALLlct08 08",
  	"QUANTUM FIREBALLP KA6.4",
@@ -124,11 +132,11 @@
  	PDPRINTK("Set index reg%X[%X] \n", index, value);
  }

-static u8 pdcnew_ratemask(ide_drive_t *drive)
+static u8 pdcnew_chip_clock(struct pci_dev *pdev)
  {
  	u8 mode;

-	switch(HWIF(drive)->pci_dev->device) {
+	switch(pdev->device) {
  		case PCI_DEVICE_ID_PROMISE_20277:
  		case PCI_DEVICE_ID_PROMISE_20276:
  		case PCI_DEVICE_ID_PROMISE_20275:
@@ -144,6 +152,13 @@
  			return 0;
  	}

+	return mode;
+}
+
+static u8 pdcnew_ratemask(ide_drive_t *drive)
+{
+	u8 mode = pdcnew_chip_clock(HWIF(drive)->pci_dev);
+
  	if (!eighty_ninty_three(drive))
  		mode = min(mode, (u8)1);

@@ -218,7 +233,7 @@
  			break;

  		default:
-			printk(KERN_ERR ": Unknown speed %d ignored\n", speed);
+			printk(KERN_ERR DRV_NAME ": Unknown speed %d ignored\n", speed);
  			;
  	}

@@ -333,16 +348,233 @@
  	/*
  	 * Deleted this because it is redundant from the caller.
  	 */
-	printk(KERN_WARNING "PDC202XX: %s channel reset.\n",
+	printk(KERN_WARNING DRV_NAME ": %s channel reset.\n",
  		HWIF(drive)->channel ? "Secondary" : "Primary");
  }

+/**
+ * adjust_pll - Adjust the PLL input clock in Hz.
+ *
+ * @pdc_controller: controller specific information
+ * @probe_ent: For the port address
+ * @pll_clock: The input of PLL in HZ
+ */
+static void pdc_adjust_pll(unsigned long dma_base, long pll_clock, long pout_required)
+{
+	unsigned long port1_dma_base = dma_base + 8;
+
+	u8 pll_ctl0, pll_ctl1;
+	long pll_clock_khz = pll_clock / 1000;
+	long ratio = pout_required / pll_clock_khz;
+	int F, R;
+	
+
+	/* Sanity check */
+	if (unlikely(pll_clock_khz < 5000L || pll_clock_khz > 70000L)) {
+		printk(KERN_ERR DRV_NAME ": Invalid PLL input clock %ldkHz, give up!\n", pll_clock_khz);
+		return;
+	}
+
+#ifdef PDC_DEBUG
+	PDPRINTK("pout_required is %ld\n", pout_required);
+
+	/* Show the current clock value of PLL control register
+	 * (maybe already configured by the firmware)
+	 */
+	outb(0x02, port1_dma_base + 0x01);
+	pll_ctl0 = inb(port1_dma_base + 0x03);
+	outb(0x03, port1_dma_base + 0x01);
+	pll_ctl1 = inb(port1_dma_base + 0x03);
+
+	PDPRINTK("pll_ctl[%X][%X]\n", pll_ctl0, pll_ctl1);
+#endif
+
+	/*
+	 * Calculate the ratio of F, R and OD
+	 * POUT = (F + 2) / (( R + 2) * NO)
+	 */
+	if (ratio < 8600L) { // 8.6x
+		/* Using NO = 0x01, R = 0x0D */
+		R = 0x0d;
+	} else if (ratio < 12900L) { // 12.9x
+		/* Using NO = 0x01, R = 0x08 */
+		R = 0x08;
+	} else if (ratio < 16100L) { // 16.1x
+		/* Using NO = 0x01, R = 0x06 */
+		R = 0x06;
+	} else if (ratio < 64000L) { // 64x
+		R = 0x00;
+	} else {
+		/* Invalid ratio */
+		printk(KERN_ERR DRV_NAME ": Invalid ratio %ld, give up!\n", ratio);
+		return;
+	}
+
+	F = (ratio * (R+2)) / 1000 - 2;
+
+	if (unlikely(F < 0 || F > 127)) {
+		/* Invalid F */
+		printk(KERN_ERR DRV_NAME ": F[%d] invalid!\n", F);
+		return;
+	}
+
+	PDPRINTK("F[%d] R[%d] ratio*1000[%ld]\n", F, R, ratio);
+
+	pll_ctl0 = (u8) F;
+	pll_ctl1 = (u8) R;
+
+	PDPRINTK("Writing pll_ctl[%X][%X]\n", pll_ctl0, pll_ctl1);
+
+	outb(0x02,     port1_dma_base + 0x01);
+	outb(pll_ctl0, port1_dma_base + 0x03);
+	outb(0x03,     port1_dma_base + 0x01);
+	outb(pll_ctl1, port1_dma_base + 0x03);
+
+	/* Wait the PLL circuit to be stable */
+	mdelay(30);
+
+#ifdef PDC_DEBUG
+	/*
+	 *  Show the current clock value of PLL control register
+	 * (maybe configured by the firmware)
+	 */
+	outb(0x02, port1_dma_base + 0x01);
+	pll_ctl0 = inb(port1_dma_base + 0x03);
+	outb(0x03, port1_dma_base + 0x01);
+	pll_ctl1 = inb(port1_dma_base + 0x03);
+
+	PDPRINTK("pll_ctl[%X][%X]\n", pll_ctl0, pll_ctl1);
+#endif
+
+	return;
+}
+
+/**
+ * detect_pll_input_clock - Detect the PLL input clock in Hz.
+ * @dma_base: for the port address
+ * Ex. 16949000 on 33MHz PCI bus for pdc20275.
+ *     Half of the PCI clock.
+ */
+static long pdc_detect_pll_input_clock(unsigned long dma_base)
+{
+	unsigned long port0_dma_base = dma_base;
+	unsigned long port1_dma_base = dma_base + 8;
+
+	u8 scr1;
+	unsigned long ctr0;
+	unsigned long ctr1;
+	unsigned long ctr2 = 0;
+	unsigned long ctr3 = 0;
+
+	unsigned long start_count, end_count;
+	long pll_clock;
+
+	/* Read current counter value */
+	outb(0x20, port0_dma_base + 0x01);
+	ctr0 = inb(port0_dma_base + 0x03);
+	outb(0x21, port0_dma_base + 0x01);
+	ctr1 = inb(port0_dma_base + 0x03);
+	
+	outb(0x20, port1_dma_base + 0x01);
+	ctr2 = inb(port1_dma_base + 0x03);
+	outb(0x21, port1_dma_base + 0x01);
+	ctr3 = inb(port1_dma_base + 0x03);
+
+	start_count = (ctr3 << 23 ) | (ctr2 << 15) | (ctr1 << 8) | ctr0;
+
+	PDPRINTK("ctr0[%lX] ctr1[%lX] ctr2 [%lX] ctr3 [%lX]\n", ctr0, ctr1, ctr2, ctr3);
+
+	/* Start the test mode */
+	outb(0x01, port0_dma_base + 0x01);
+	scr1 = inb(port0_dma_base + 0x03);
+	PDPRINTK("scr1[%X]\n", scr1);
+	outb(scr1 | 0x40, port0_dma_base + 0x03);
+
+	/* Let the counter run for 1000 us. */
+	udelay(1000);
+
+	/* Read the counter values again */
+	outb(0x20, port0_dma_base + 0x01);
+	ctr0 = inb(port0_dma_base + 0x03);
+	outb(0x21, port0_dma_base + 0x01);
+	ctr1 = inb(port0_dma_base + 0x03);
+	
+	outb(0x20, port1_dma_base + 0x01);
+	ctr2 = inb(port1_dma_base + 0x03);
+	outb(0x21, port1_dma_base + 0x01);
+	ctr3 = inb(port1_dma_base + 0x03);
+
+	end_count = (ctr3 << 23 ) | (ctr2 << 15) | (ctr1 << 8) | ctr0;
+
+	PDPRINTK("ctr0[%lX] ctr1[%lX] ctr2 [%lX] ctr3 [%lX]\n", ctr0, ctr1, ctr2, ctr3);
+
+	/* Stop the test mode */
+	outb(0x01, port0_dma_base + 0x01);
+	scr1 = inb(port0_dma_base + 0x03);
+	PDPRINTK("scr1[%X]\n", scr1);
+	outb(scr1 & 0xBF, port0_dma_base + 0x03);
+
+	/* calculate the input clock in Hz */
+	pll_clock = (long) ((start_count - end_count) * 1000);
+
+	PDPRINTK("start[%lu] end[%lu] \n", start_count, end_count);
+	PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);
+
+	return pll_clock;
+}
+
+/**
+ * pdc_hardware_init - Initialize the hardware.
+ * @pdev: instance of pci_dev found
+ * @pdc_controller: controller specific information
+ * @pe:  for the port address
+ */
+static int pdc_hardware_init(struct pci_dev *pdev)
+{
+	unsigned long dma_base;
+	u8 mode;
+	long pout_required = 0;
+	long pll_clock;
+
+	/* Get dma_base */
+	dma_base = pci_resource_start(pdev, 4);
+	if (!dma_base) {
+		printk(KERN_ERR DRV_NAME ": dma_base is invalid\n");
+		return -1;
+	}
+
+	/* Calculate pout_required */
+	mode = pdcnew_chip_clock(pdev);
+
+	if (mode == 4)
+		pout_required =  PDC_133_MHZ;
+	else if (mode == 3)
+		pout_required =  PDC_100_MHZ;
+
+	/*
+	 * Detect PLL input clock rate.
+	 * On some system, where PCI bus is running at non-standard clock rate.
+	 * Ex. 25MHz or 40MHz, we have to adjust the cycle_time.
+	 * The pdc20275 controller employs PLL circuit to help correct timing registers setting.
+	 */
+	pll_clock = pdc_detect_pll_input_clock(dma_base);
+
+	if(pll_clock < 0) /* counter overflow? Try again. */
+		pll_clock = pdc_detect_pll_input_clock(dma_base);
+
+	PDPRINTK("PLL input clock %ld kHz\n", pll_clock/1000);
+
+	/* Adjust PLL control register */
+	pdc_adjust_pll(dma_base, pll_clock, pout_required);
+
+	return 0;
+}
+
  #ifdef CONFIG_PPC_PMAC
  static void __devinit apple_kiwi_init(struct pci_dev *pdev)
  {
  	struct device_node *np = pci_device_to_OF_node(pdev);
  	unsigned int class_rev = 0;
-	void __iomem *mmio;
  	u8 conf;

  	if (np == NULL || !device_is_compatible(np, "kiwi-root"))
@@ -356,22 +588,7 @@
  		pci_read_config_byte(pdev, 0x40, &conf);
  		pci_write_config_byte(pdev, 0x40, conf | 0x01);
  	}
-	mmio = ioremap(pci_resource_start(pdev, 5),
-				      pci_resource_len(pdev, 5));
-
-	/* Setup some PLL stuffs */
-	switch (pdev->device) {
-	case PCI_DEVICE_ID_PROMISE_20270:
-		writew(0x0d2b, mmio + 0x1202);
-		mdelay(30);
-		break;
-	case PCI_DEVICE_ID_PROMISE_20271:
-		writew(0x0826, mmio + 0x1202);
-		mdelay(30);
-		break;
-	}

-	iounmap(mmio);
  }
  #endif /* CONFIG_PPC_PMAC */

@@ -387,6 +604,7 @@
  #ifdef CONFIG_PPC_PMAC
  	apple_kiwi_init(dev);
  #endif
+	pdc_hardware_init(dev);

  	return dev->irq;
  }



