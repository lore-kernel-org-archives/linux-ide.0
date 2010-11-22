From: Viresh Kumar <viresh.kumar@st.com>
Subject: ata: hotplug not working with arasan CF controller driver
Date: Mon, 22 Nov 2010 16:24:56 +0530
Message-ID: <ede5127fb76113dd7560fa8919c0e125b38985a2.1290422728.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:37403 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752911Ab0KVKzF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Nov 2010 05:55:05 -0500
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 66AC7EF
	for <linux-ide@vger.kernel.org>; Mon, 22 Nov 2010 10:54:59 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas2.st.com [10.80.176.10])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 132E4D1C
	for <linux-ide@vger.kernel.org>; Mon, 22 Nov 2010 10:54:59 +0000 (GMT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@st.com>

Hello,

I am writing arasan CF controller driver (pio mode). Hotplug is not working
with my driver and i can't find the reason for this. What i am expecting is,
inserting CF card on already booted machine should add /dev/sd* node for CF
card and removing card should remove /dev/sd* node. If i insert card before
booting my board and then start my board, things work fine. I am able to mount,
read, write, unmount. But hotplug is not working.

I am working on linux-2.6.32.

Can somebody please help me on this??

--
viresh

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/pata_arasan_cf.c        |  374 +++++++++++++++++++++++++++++++++++
 drivers/ata/pata_arasan_cf.h        |  166 ++++++++++++++++

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
new file mode 100644
index 0000000..b0eec31
--- /dev/null
+++ b/drivers/ata/pata_arasan_cf.c
@@ -0,0 +1,374 @@
+/*
+ * drivers/ata/pata_arasan_cf.c
+ *
+ * Arasan Compact Flash host controller source file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/*
+ * The Arasan CompactFlash Device Controller IP core has three basic modes of
+ * operation: PC card ATA using I/O mode, PC card ATA using memory mode, PC card
+ * ATA using true IDE modes.
+ * This driver supports only True IDE mode currently.
+ */
+
+#include <linux/ata.h>
+#include <linux/pata_arasan_cf_data.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/libata.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include "pata_arasan_cf.h"
+
+#define DRV_NAME "pata_arasan_cf"
+
+struct arasan_cf_dev {
+	struct ata_host *host;
+	void __iomem *base;
+	struct clk *clk;
+	u8 card_ready;
+};
+
+static struct scsi_host_template arasan_cf_sht = {
+	ATA_PIO_SHT(DRV_NAME),
+};
+
+static void cf_card_reset(struct arasan_cf_dev *acdev)
+{
+	u32 val = readl(acdev->base + OP_MODE);
+
+	writel(val | CARD_RESET, acdev->base + OP_MODE);
+	udelay(20);
+	writel(val & ~CARD_RESET, acdev->base + OP_MODE);
+}
+
+static void cf_ginterrupt_enable(struct arasan_cf_dev *acdev, u8 enable)
+{
+	/* enable/disable global interrupts shared between CF and XD ctrlr. */
+	writel(!!enable, acdev->base + GIRQ_STS_EN);
+	writel(!!enable, acdev->base + GIRQ_SGN_EN);
+}
+
+static void
+cf_interrupt_enable(struct arasan_cf_dev *acdev, u32 mask, u8 enable)
+{
+	u32 val = readl(acdev->base + IRQ_EN);
+	/* clear & enable/disable irqs */
+	if (enable) {
+		writel(mask, acdev->base + IRQ_STS);
+		writel(val | mask, acdev->base + IRQ_EN);
+	} else
+		writel(val & ~mask, acdev->base + IRQ_EN);
+}
+
+static void cf_card_insert(struct arasan_cf_dev *acdev)
+{
+	cf_card_reset(acdev);
+}
+
+static void cf_card_detect(struct arasan_cf_dev *acdev)
+{
+	u32 val = readl(acdev->base + CFI_STS);
+
+	/* Both CD1 & CD2 should be low if card inserted completely */
+	if (!(val & (CARD_DETECT1 | CARD_DETECT2))) {
+		printk(KERN_ERR "card inserted\n");
+		cf_card_insert(acdev);
+	}
+	else
+		printk(KERN_ERR "card removed\n");
+}
+
+static int cf_init(struct arasan_cf_dev *acdev)
+{
+	int ret = 0;
+	struct arasan_cf_pdata *pdata = dev_get_platdata(acdev->host->dev);
+	u8 cf_if_clk = CF_IF_CLK_166M;
+
+	ret = clk_enable(acdev->clk);
+	if (ret) {
+		dev_err(acdev->host->dev, "clock enable fail");
+		return ret;
+	}
+
+	/* configure CF interface clock */
+	if (pdata->cf_if_clk <= CF_IF_CLK_200M)
+		cf_if_clk = pdata->cf_if_clk;
+	writel(cf_if_clk, acdev->base + CLK_CFG);
+
+	writel(TRUE_IDE_MODE | CFHOST_ENB, acdev->base + OP_MODE);
+	cf_ginterrupt_enable(acdev, 1);
+	cf_interrupt_enable(acdev, CARD_DETECT_IRQ, 1);
+
+	return ret;
+}
+
+static void cf_exit(struct arasan_cf_dev *acdev)
+{
+	cf_ginterrupt_enable(acdev, 0);
+	cf_interrupt_enable(acdev, TRUE_IDE_IRQS, 0);
+	cf_card_reset(acdev);
+	writel(readl(acdev->base + OP_MODE) & ~CFHOST_ENB,
+			acdev->base + OP_MODE);
+	clk_disable(acdev->clk);
+}
+
+static irqreturn_t arasan_cf_interrupt(int irq, void *dev)
+{
+	struct ata_host *host = dev;
+	struct arasan_cf_dev *acdev = host->private_data;
+	u32 handled = 0, irqsts;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	irqsts = readl(acdev->base + GIRQ_STS);
+	if (!(irqsts & GIRQ_CF))
+		goto end;
+	writel(GIRQ_CF, acdev->base + GIRQ_STS);	/* clear girqs */
+	handled = 1;
+
+	irqsts = readl(acdev->base + IRQ_STS);
+	writel(irqsts, acdev->base + IRQ_STS);		/* clear girqs */
+
+	if (irqsts & CARD_DETECT_IRQ) {
+		irqsts &= ~CARD_DETECT_IRQ;
+		cf_card_detect(acdev);
+	}
+	if (irqsts & PIO_XFER_ERR_IRQ) {
+		irqsts &= ~PIO_XFER_ERR_IRQ;
+		dev_err(host->dev, "pio xfer err irq\n");
+	}
+	if (irqsts & BUF_AVAIL_IRQ) {
+		irqsts &= ~BUF_AVAIL_IRQ;
+		dev_err(host->dev, "buf avail irq\n");
+	}
+	if (irqsts & XFER_DONE_IRQ) {
+		irqsts &= ~XFER_DONE_IRQ;
+		dev_err(host->dev, "xfer done irq\n");
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+	handled += ata_sff_interrupt(irq, dev);
+
+end:
+	return IRQ_RETVAL(handled);
+}
+
+static void arasan_cf_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct arasan_cf_dev *acdev = ap->host->private_data;
+	u8 pio = adev->pio_mode - XFER_PIO_0;
+	u32 val;
+
+	dev_info(ap->dev, "set PIO mode\n");
+	/* Arasan ctrl supports Mode0 -> Mode6 */
+	if (pio > 6) {
+		dev_err(ap->dev, "Unknown PIO mode\n");
+		return;
+	}
+
+	val = readl(acdev->base + OP_MODE) &
+		~(ULTRA_DMA_ENB | MULTI_WORD_DMA_ENB | DRQ_BLOCK_SIZE_MASK);
+	writel(val, acdev->base + OP_MODE);
+	val = readl(acdev->base + TM_CFG) & ~TRUEIDE_PIO_TIMING_MASK;
+	val |= pio;
+	writel(val, acdev->base + TM_CFG);
+
+	cf_interrupt_enable(acdev, BUF_AVAIL_IRQ | XFER_DONE_IRQ, 0);
+	cf_interrupt_enable(acdev, PIO_XFER_ERR_IRQ, 1);
+}
+
+static void arasan_cf_set_dmamode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct arasan_cf_dev *acdev = ap->host->private_data;
+	u32 opmode, tmcfg, dma_mode = adev->dma_mode;
+
+	dev_info(ap->dev, "set DMA mode\n");
+	opmode = readl(acdev->base + OP_MODE) & ~(MULTI_WORD_DMA_ENB |
+			ULTRA_DMA_ENB);
+	tmcfg = readl(acdev->base + TM_CFG);
+
+	if ((dma_mode >= XFER_UDMA_0) && (dma_mode <= XFER_UDMA_6)) {
+		opmode |= ULTRA_DMA_ENB;
+		tmcfg &= ~ULTRA_DMA_TIMING_MASK;
+		tmcfg |= dma_mode - XFER_UDMA_0;
+	} else if ((dma_mode >= XFER_MW_DMA_0) && (dma_mode <= XFER_MW_DMA_4)) {
+		opmode |= MULTI_WORD_DMA_ENB;
+		tmcfg &= ~TRUEIDE_MWORD_DMA_TIMING_MASK;
+		tmcfg |= dma_mode - XFER_MW_DMA_0;
+	} else {
+		dev_err(ap->dev, "Unknown DMA mode\n");
+		return;
+	}
+	writel(opmode, acdev->base + OP_MODE);
+	writel(tmcfg, acdev->base + TM_CFG);
+
+	cf_interrupt_enable(acdev, PIO_XFER_ERR_IRQ, 0);
+	cf_interrupt_enable(acdev, BUF_AVAIL_IRQ | XFER_DONE_IRQ, 1);
+}
+
+static struct ata_port_operations arasan_cf_ops = {
+	.inherits		= &ata_sff_port_ops,
+	.set_piomode		= arasan_cf_set_piomode,
+	.set_dmamode		= arasan_cf_set_dmamode,
+};
+
+static int __devinit arasan_cf_probe(struct platform_device *pdev)
+{
+	struct arasan_cf_dev *acdev;
+	struct arasan_cf_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct ata_host *host;
+	struct ata_port *ap;
+	struct resource *res;
+	int irq = platform_get_irq(pdev, 0), ret = 0;
+	irq_handler_t irq_handler = NULL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+	if (!request_mem_region(res->start, resource_size(res), DRV_NAME)) {
+		dev_warn(&pdev->dev, "Failed to get memory region resource\n");
+		return -ENOENT;
+	}
+
+	acdev = kzalloc(sizeof(*acdev), GFP_KERNEL);
+	if (!acdev) {
+		ret = -ENOMEM;
+		goto err_kfree;
+	}
+
+	acdev->base = devm_ioremap_nocache(&pdev->dev, res->start,
+			resource_size(res));
+	if (!acdev->base) {
+		ret = -ENOMEM;
+		goto err_ioremap;
+	}
+
+	acdev->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(acdev->clk)) {
+		dev_warn(&pdev->dev, "Clock not found\n");
+		ret = PTR_ERR(acdev->clk);
+		goto err_clk_get;
+	}
+
+	/* allocate host */
+	host = ata_host_alloc(&pdev->dev, 1);
+	if (!host) {
+		ret = -ENOMEM;
+		goto err_host_alloc;
+	}
+
+	if (irq)
+		irq_handler = arasan_cf_interrupt;
+
+	ap = host->ports[0];
+	host->private_data = acdev;
+	acdev->host = host;
+	ap->ops = &arasan_cf_ops;
+	ap->pio_mask = ATA_PIO6;
+	ap->mwdma_mask = ATA_MWDMA4;
+	ap->udma_mask = ATA_UDMA6;
+
+	/* Handle platform specific quirks */
+	if(pdata->quirk) {
+		if (pdata->quirk & CF_BROKEN_PIO) {
+			ap->ops->set_piomode = NULL;
+			ap->pio_mask = 0;
+		}
+		if (pdata->quirk & CF_BROKEN_MWDMA)
+			ap->mwdma_mask = 0;
+		if (pdata->quirk & CF_BROKEN_UDMA)
+			ap->udma_mask = 0;
+		if ((pdata->quirk & (CF_BROKEN_MWDMA | CF_BROKEN_UDMA)) ==
+				(CF_BROKEN_MWDMA | CF_BROKEN_UDMA))
+			ap->ops->set_dmamode = NULL;
+	}
+	ap->flags |= ATA_FLAG_NO_LEGACY | ATA_FLAG_NO_ATAPI
+		| ATA_FLAG_PIO_POLLING;
+
+	ap->ioaddr.cmd_addr = acdev->base + ATA_DATA_PORT;
+	ap->ioaddr.data_addr = acdev->base + ATA_DATA_PORT;
+	ap->ioaddr.error_addr = acdev->base + ATA_ERR_FTR;
+	ap->ioaddr.feature_addr = acdev->base + ATA_ERR_FTR;
+	ap->ioaddr.nsect_addr = acdev->base + ATA_SC;
+	ap->ioaddr.lbal_addr = acdev->base + ATA_SN;
+	ap->ioaddr.lbam_addr = acdev->base + ATA_CL;
+	ap->ioaddr.lbah_addr = acdev->base + ATA_CH;
+	ap->ioaddr.device_addr = acdev->base + ATA_SH;
+	ap->ioaddr.status_addr = acdev->base + ATA_STS_CMD;
+	ap->ioaddr.command_addr = acdev->base + ATA_STS_CMD;
+	ap->ioaddr.altstatus_addr = acdev->base + ATA_ASTS_DCTR;
+	ap->ioaddr.ctl_addr = acdev->base + ATA_ASTS_DCTR;
+
+	ata_port_desc(ap, "phy_addr %x virt_addr %p", res->start, acdev->base);
+
+	ret = cf_init(acdev);
+	if (ret)
+		goto err_cf_init;
+
+	return ata_host_activate(host, irq, irq_handler, 0, &arasan_cf_sht);
+
+err_cf_init:
+err_host_alloc:
+	clk_put(acdev->clk);
+err_clk_get:
+err_ioremap:
+	kfree(acdev);
+err_kfree:
+	release_mem_region(res->start, resource_size(res));
+	return ret;
+}
+
+static int __devexit arasan_cf_remove(struct platform_device *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	struct arasan_cf_dev *acdev = host->ports[0]->private_data;
+	struct resource *res;
+
+	ata_host_detach(host);
+	cf_exit(acdev);
+	clk_put(acdev->clk);
+	kfree(acdev);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
+
+	return 0;
+}
+
+static struct platform_driver arasan_cf_driver = {
+	.probe		= arasan_cf_probe,
+	.remove		= __devexit_p(arasan_cf_remove),
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init arasan_cf_init(void)
+{
+	return platform_driver_register(&arasan_cf_driver);
+}
+module_init(arasan_cf_init);
+
+static void __exit arasan_cf_exit(void)
+{
+	platform_driver_unregister(&arasan_cf_driver);
+}
+module_exit(arasan_cf_exit);
+
+MODULE_AUTHOR("Viresh Kumar <viresh.kumar@st.com>");
+MODULE_DESCRIPTION("Arasan ATA Compact Flash driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/ata/pata_arasan_cf.h b/drivers/ata/pata_arasan_cf.h
new file mode 100644
index 0000000..abab240
--- /dev/null
+++ b/drivers/ata/pata_arasan_cf.h
@@ -0,0 +1,166 @@
+/*
+ * drivers/ata/pata_arasan_cf.h
+ *
+ * Arasan Compact Flash host controller header file
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _PATA_ARASAN_CF_H
+#define _PATA_ARASAN_CF_H
+
+/* Registers */
+/* CompactFlash Interface Status */
+#define CFI_STS			0x000
+	#define STS_CHG				(1)
+	#define BIN_AUDIO_OUT			(1 << 1)
+	#define CARD_DETECT1			(1 << 2)
+	#define CARD_DETECT2			(1 << 3)
+	#define INP_ACK				(1 << 4)
+	#define CARD_READY			(1 << 5)
+	#define IO_READY			(1 << 6)
+	#define B16_IO_PORT_SEL			(1 << 7)
+/* IRQ */
+#define IRQ_STS			0x004
+/* Interrupt Enable */
+#define IRQ_EN			0x008
+	#define CARD_DETECT_IRQ			(1)
+	#define STATUS_CHNG_IRQ			(1 << 1)
+	#define MEM_MODE_IRQ			(1 << 2)
+	#define IO_MODE_IRQ			(1 << 3)
+	#define TRUE_IDE_MODE_IRQ		(1 << 8)
+	#define PIO_XFER_ERR_IRQ		(1 << 9)
+	#define BUF_AVAIL_IRQ			(1 << 10)
+	#define XFER_DONE_IRQ			(1 << 11)
+	#define TRUE_IDE_IRQS	(CARD_DETECT_IRQ | PIO_XFER_ERR_IRQ |\
+					BUF_AVAIL_IRQ | XFER_DONE_IRQ)
+/* Operation Mode */
+#define OP_MODE			0x00C
+	#define CARD_MODE_MASK			(0x3)
+	#define MEM_MODE			(0x0)
+	#define IO_MODE				(0x1)
+	#define TRUE_IDE_MODE			(0x2)
+
+	#define CARD_TYPE_MASK			(1 << 2)
+	#define CF_CARD				(0)
+	#define CF_PLUS_CARD			(1 << 2)
+
+	#define CARD_RESET			(1 << 3)
+	#define CFHOST_ENB			(1 << 4)
+	#define OUTPUTS_TRISTATE		(1 << 5)
+	#define ULTRA_DMA_ENB			(1 << 8)
+	#define MULTI_WORD_DMA_ENB		(1 << 9)
+	#define DRQ_BLOCK_SIZE_MASK		(0x3 << 11)
+	#define DRQ_BLOCK_SIZE_512		(0)
+	#define DRQ_BLOCK_SIZE_1024		(1 << 11)
+	#define DRQ_BLOCK_SIZE_2048		(2 << 11)
+	#define DRQ_BLOCK_SIZE_4096		(3 << 11)
+/* CF Interface Clock Configuration */
+#define CLK_CFG			0x010
+	#define CF_IF_CLK_MASK			(0XF)
+/* CF Timing Mode Configuration */
+#define TM_CFG			0x014
+	#define MEM_MODE_TIMING_MASK		(0x3)
+	#define MEM_MODE_TIMING_250NS		(0x0)
+	#define MEM_MODE_TIMING_120NS		(0x1)
+	#define MEM_MODE_TIMING_100NS		(0x2)
+	#define MEM_MODE_TIMING_80NS		(0x3)
+
+	#define IO_MODE_TIMING_MASK		(0x3 << 2)
+	#define IO_MODE_TIMING_250NS		(0x0 << 2)
+	#define IO_MODE_TIMING_120NS		(0x1 << 2)
+	#define IO_MODE_TIMING_100NS		(0x2 << 2)
+	#define IO_MODE_TIMING_80NS		(0x3 << 2)
+
+	#define TRUEIDE_PIO_TIMING_MASK		(0x7 << 4)
+	#define TRUEIDE_PIO_TIMING_MODE0	(0x0)
+	#define TRUEIDE_PIO_TIMING_MODE1	(0x1 << 4)
+	#define TRUEIDE_PIO_TIMING_MODE2	(0x2 << 4)
+	#define TRUEIDE_PIO_TIMING_MODE3	(0x3 << 4)
+	#define TRUEIDE_PIO_TIMING_MODE4	(0x4 << 4)
+	#define TRUEIDE_PIO_TIMING_MODE5	(0x5 << 4)
+	#define TRUEIDE_PIO_TIMING_MODE6	(0x6 << 4)
+
+	#define TRUEIDE_MWORD_DMA_TIMING_MASK	(0x7 << 7)
+	#define TRUEIDE_MWORD_DMA_TIMING_MODE0	(0x0)
+	#define TRUEIDE_MWORD_DMA_TIMING_MODE1	(0x1 << 7)
+	#define TRUEIDE_MWORD_DMA_TIMING_MODE2	(0x2 << 7)
+	#define TRUEIDE_MWORD_DMA_TIMING_MODE3	(0x3 << 7)
+	#define TRUEIDE_MWORD_DMA_TIMING_MODE4	(0x4 << 7)
+
+	#define ULTRA_DMA_TIMING_MASK		(0x7 << 10)
+	#define ULTRA_DMA_TIMING_MODE0		(0x0)
+	#define ULTRA_DMA_TIMING_MODE1		(0x1 << 10)
+	#define ULTRA_DMA_TIMING_MODE2		(0x2 << 10)
+	#define ULTRA_DMA_TIMING_MODE3		(0x3 << 10)
+	#define ULTRA_DMA_TIMING_MODE4		(0x4 << 10)
+	#define ULTRA_DMA_TIMING_MODE5		(0x5 << 10)
+	#define ULTRA_DMA_TIMING_MODE6		(0x6 << 10)
+/* CF Transfer Address */
+#define XFER_ADDR		0x014
+	#define XFER_ADDR_MASK			(0x7FF)
+/* Transfer Control */
+#define XFER_CTR		0x01C
+	#define XFER_COUNT_MASK			(0x3FFFF)
+	#define ADDR_INC_DISABLE		(1 << 24)
+	#define XFER_WIDTH_MASK			(1 << 25)
+	#define XFER_WIDTH_8B			(0)
+	#define XFER_WIDTH_16B			(1 << 25)
+
+	#define MEM_TYPE_MASK			(1 << 26)
+	#define MEM_TYPE_COMMON			(0)
+	#define MEM_TYPE_ATTRIBUTE		(1 << 26)
+
+	#define MEM_IO_XFER_MASK		(1 << 27)
+	#define MEM_XFER			(0)
+	#define IO_XFER				(1 << 27)
+
+	/* TBD bit 28 */
+	#define AHB_BUS_NORMAL_PIO_OPRTN	(~(1 << 29))
+	#define XFER_DIR_MASK			(1 << 30)
+	#define XFER_READ			(0)
+	#define XFER_WRITE			(1 << 30)
+
+	#define XFER_START			(1 << 31)
+/* Write Data Port */
+#define WRITE_PORT		0x024
+/* Read Data Port */
+#define READ_PORT		0x028
+/* ATA Data Port */
+#define ATA_DATA_PORT		0x030
+	#define ATA_DATA_PORT_MASK		(0xFFFF)
+/* ATA Error/Features */
+#define ATA_ERR_FTR		0x034
+/* ATA Sector Count */
+#define ATA_SC			0x038
+/* ATA Sector Number */
+#define ATA_SN			0x03C
+/* ATA Cylinder Low */
+#define ATA_CL			0x040
+/* ATA Cylinder High */
+#define ATA_CH			0x044
+/* ATA Select Card/Head */
+#define ATA_SH			0x048
+/* ATA Status-Command */
+#define ATA_STS_CMD		0x04C
+/* ATA Alternate Status/Device Control */
+#define ATA_ASTS_DCTR		0x050
+/* Extended Write Data Port 0x200-0x3FC */
+#define EXT_WRITE_PORT_x	0x200
+/* Extended Read Data Port 0x400-0x5FC */
+#define EXT_READ_PORT_x		0x400
+/* Global Interrupt Status */
+#define GIRQ_STS		0x800
+/* Global Interrupt Status enable */
+#define GIRQ_STS_EN		0x804
+/* Global Interrupt Signal enable */
+#define GIRQ_SGN_EN		0x808
+	#define GIRQ_CF		(1)
+	#define GIRQ_XD		(1 << 1)
+
+#endif /* _PATA_ARASAN_CF_H */
-- 
1.7.2.2

