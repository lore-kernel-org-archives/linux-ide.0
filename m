From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] sgiioc4: coding style cleanup
Date: Thu, 11 Jun 2009 21:54:40 +0400
Message-ID: <200906112154.40247.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:2979 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754518AbZFKRxH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Jun 2009 13:53:07 -0400
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Fix several errors and warnings given by checkpatch.pl:

- space between the asterisk and parameter name;

- inconsistent spacing between operator and operands;

- space between *sizeof* and open parenthesis;

- #include <asm/io.h> instead of #include <linux/io.h>

- use of *typedef* instead of a structure tag;

- line over 80 characters.

In addition to these changes, also do the following:

- indent with tabs instead of spaces;

- put the function's result type and name/parameters on the same line;

- join back the needlessly broken lines;

- get rid of needless type cast in sgiioc4_checkirq();

- remove space between the type cast and the variable name;

- remove commented out field initializer;

- uppercase the acronyms, lowercase the normal words in the comments;

- fix up the multi-line comment style...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch has been laying around for several months now, time to send it out.
It is atop of ide-2.6.git 'for-next' branch.
                                          
 drivers/ide/sgiioc4.c |  119 ++++++++++++++++++++++----------------------------
 1 files changed, 54 insertions(+), 65 deletions(-)

Index: ide-2.6/drivers/ide/sgiioc4.c
===================================================================
--- ide-2.6.orig/drivers/ide/sgiioc4.c
+++ ide-2.6/drivers/ide/sgiioc4.c
@@ -1,6 +1,6 @@
 /*
  * Copyright (c) 2003-2006 Silicon Graphics, Inc.  All Rights Reserved.
- * Copyright (C) 2008 MontaVista Software, Inc.
+ * Copyright (C) 2008-2009 MontaVista Software, Inc.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -29,8 +29,7 @@
 #include <linux/blkdev.h>
 #include <linux/scatterlist.h>
 #include <linux/ioc4.h>
-#include <asm/io.h>
-
+#include <linux/io.h>
 #include <linux/ide.h>
 
 #define DRV_NAME "SGIIOC4"
@@ -72,7 +71,7 @@
 #define IOC4_CMD_CTL_BLK_SIZE	0x20
 #define IOC4_SUPPORTED_FIRMWARE_REV 46
 
-typedef struct {
+struct ioc4_dma_regs {
 	u32 timing_reg0;
 	u32 timing_reg1;
 	u32 low_mem_ptr;
@@ -82,17 +81,18 @@ typedef struct {
 	u32 dev_byte_count;
 	u32 mem_byte_count;
 	u32 status;
-} ioc4_dma_regs_t;
+};
 
 /* Each Physical Region Descriptor Entry size is 16 bytes (2 * 64 bits) */
 /* IOC4 has only 1 IDE channel */
-#define IOC4_PRD_BYTES       16
-#define IOC4_PRD_ENTRIES     (PAGE_SIZE /(4*IOC4_PRD_BYTES))
+#define IOC4_PRD_BYTES		16
+#define IOC4_PRD_ENTRIES	(PAGE_SIZE / (4 * IOC4_PRD_BYTES))
 
 
-static void
-sgiioc4_init_hwif_ports(struct ide_hw *hw, unsigned long data_port,
-			unsigned long ctrl_port, unsigned long irq_port)
+static void sgiioc4_init_hwif_ports(struct ide_hw *hw,
+				    unsigned long data_port,
+				    unsigned long ctrl_port,
+				    unsigned long irq_port)
 {
 	unsigned long reg = data_port;
 	int i;
@@ -105,13 +105,11 @@ sgiioc4_init_hwif_ports(struct ide_hw *h
 	hw->io_ports.irq_addr = irq_port;
 }
 
-static int
-sgiioc4_checkirq(ide_hwif_t * hwif)
+static int sgiioc4_checkirq(ide_hwif_t *hwif)
 {
-	unsigned long intr_addr =
-		hwif->io_ports.irq_addr + IOC4_INTR_REG * 4;
+	unsigned long intr_addr = hwif->io_ports.irq_addr + IOC4_INTR_REG * 4;
 
-	if ((u8)readl((void __iomem *)intr_addr) & 0x03)
+	if (readl((void __iomem *)intr_addr) & 0x03)
 		return 1;
 
 	return 0;
@@ -119,8 +117,7 @@ sgiioc4_checkirq(ide_hwif_t * hwif)
 
 static u8 sgiioc4_read_status(ide_hwif_t *);
 
-static int
-sgiioc4_clearirq(ide_drive_t * drive)
+static int sgiioc4_clearirq(ide_drive_t *drive)
 {
 	u32 intr_reg;
 	ide_hwif_t *hwif = drive->hwif;
@@ -158,12 +155,10 @@ sgiioc4_clearirq(ide_drive_t * drive)
 				readl((void __iomem *)(io_ports->irq_addr + 4));
 			pci_read_config_dword(dev, PCI_COMMAND,
 					      &pci_stat_cmd_reg);
-			printk(KERN_ERR
-			       "%s(%s) : PCI Bus Error when doing DMA:"
-				   " status-cmd reg is 0x%x\n",
+			printk(KERN_ERR "%s(%s): PCI Bus Error when doing DMA: "
+			       "status-cmd reg is 0x%x\n",
 			       __func__, drive->name, pci_stat_cmd_reg);
-			printk(KERN_ERR
-			       "%s(%s) : PCI Error Address is 0x%x%x\n",
+			printk(KERN_ERR "%s(%s): PCI Error Address is 0x%x%x\n",
 			       __func__, drive->name,
 			       pci_err_addr_high, pci_err_addr_low);
 			/* Clear the PCI Error indicator */
@@ -189,8 +184,7 @@ static void sgiioc4_dma_start(ide_drive_
 	writel(temp_reg, (void __iomem *)ioc4_dma_addr);
 }
 
-static u32
-sgiioc4_ide_dma_stop(ide_hwif_t *hwif, u64 dma_base)
+static u32 sgiioc4_ide_dma_stop(ide_hwif_t *hwif, u64 dma_base)
 {
 	unsigned long ioc4_dma_addr = dma_base + IOC4_DMA_CTRL * 4;
 	u32	ioc4_dma;
@@ -227,7 +221,7 @@ static int sgiioc4_dma_end(ide_drive_t *
 	}
 
 	/*
-	 * The IOC4 will DMA 1's to the ending dma area to indicate that
+	 * The IOC4 will DMA 1's to the ending DMA area to indicate that
 	 * previous data DMA is complete.  This is necessary because of relaxed
 	 * ordering between register reads and DMA writes on the Altix.
 	 */
@@ -265,7 +259,7 @@ static void sgiioc4_set_dma_mode(ide_dri
 {
 }
 
-/* returns 1 if dma irq issued, 0 otherwise */
+/* Returns 1 if DMA IRQ issued, 0 otherwise */
 static int sgiioc4_dma_test_irq(ide_drive_t *drive)
 {
 	return sgiioc4_checkirq(drive->hwif);
@@ -286,8 +280,7 @@ static void sgiioc4_resetproc(ide_drive_
 	sgiioc4_clearirq(drive);
 }
 
-static void
-sgiioc4_dma_lost_irq(ide_drive_t * drive)
+static void sgiioc4_dma_lost_irq(ide_drive_t *drive)
 {
 	sgiioc4_resetproc(drive);
 
@@ -313,13 +306,13 @@ static u8 sgiioc4_read_status(ide_hwif_t
 	return reg;
 }
 
-/* Creates a dma map for the scatter-gather list entries */
-static int __devinit
-ide_dma_sgiioc4(ide_hwif_t *hwif, const struct ide_port_info *d)
+/* Creates a DMA map for the scatter-gather list entries */
+static int __devinit ide_dma_sgiioc4(ide_hwif_t *hwif,
+				     const struct ide_port_info *d)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
 	unsigned long dma_base = pci_resource_start(dev, 0) + IOC4_DMA_OFFSET;
-	int num_ports = sizeof (ioc4_dma_regs_t);
+	int num_ports = sizeof(struct ioc4_dma_regs);
 	void *pad;
 
 	printk(KERN_INFO "    %s: MMIO-DMA\n", hwif->name);
@@ -362,8 +355,7 @@ dma_pci_alloc_failure:
 }
 
 /* Initializes the IOC4 DMA Engine */
-static void
-sgiioc4_configure_for_dma(int dma_direction, ide_drive_t * drive)
+static void sgiioc4_configure_for_dma(int dma_direction, ide_drive_t *drive)
 {
 	u32 ioc4_dma;
 	ide_hwif_t *hwif = drive->hwif;
@@ -374,31 +366,27 @@ sgiioc4_configure_for_dma(int dma_direct
 	ioc4_dma = readl((void __iomem *)ioc4_dma_addr);
 
 	if (ioc4_dma & IOC4_S_DMA_ACTIVE) {
-		printk(KERN_WARNING
-			"%s(%s):Warning!! DMA from previous transfer was still active\n",
-		       __func__, drive->name);
+		printk(KERN_WARNING "%s(%s): Warning!! DMA from previous "
+		       "transfer was still active\n", __func__, drive->name);
 		writel(IOC4_S_DMA_STOP, (void __iomem *)ioc4_dma_addr);
 		ioc4_dma = sgiioc4_ide_dma_stop(hwif, dma_base);
 
 		if (ioc4_dma & IOC4_S_DMA_STOP)
-			printk(KERN_ERR
-			       "%s(%s) : IOC4 Dma STOP bit is still 1\n",
-			       __func__, drive->name);
+			printk(KERN_ERR "%s(%s): IOC4 DMA STOP bit is "
+			       "still 1\n", __func__, drive->name);
 	}
 
 	ioc4_dma = readl((void __iomem *)ioc4_dma_addr);
 	if (ioc4_dma & IOC4_S_DMA_ERROR) {
-		printk(KERN_WARNING
-		       "%s(%s) : Warning!! - DMA Error during Previous"
-		       " transfer | status 0x%x\n",
+		printk(KERN_WARNING "%s(%s): Warning!! DMA Error during "
+		       "previous transfer, status 0x%x\n",
 		       __func__, drive->name, ioc4_dma);
 		writel(IOC4_S_DMA_STOP, (void __iomem *)ioc4_dma_addr);
 		ioc4_dma = sgiioc4_ide_dma_stop(hwif, dma_base);
 
 		if (ioc4_dma & IOC4_S_DMA_STOP)
-			printk(KERN_ERR
-			       "%s(%s) : IOC4 DMA STOP bit is still 1\n",
-			       __func__, drive->name);
+			printk(KERN_ERR "%s(%s): IOC4 DMA STOP bit is "
+			       "still 1\n", __func__, drive->name);
 	}
 
 	/* Address of the Scatter Gather List */
@@ -408,20 +396,22 @@ sgiioc4_configure_for_dma(int dma_direct
 	/* Address of the Ending DMA */
 	memset(ide_get_hwifdata(hwif), 0, IOC4_IDE_CACHELINE_SIZE);
 	ending_dma_addr = cpu_to_le32(hwif->extra_base);
-	writel(ending_dma_addr, (void __iomem *)(dma_base + IOC4_DMA_END_ADDR * 4));
+	writel(ending_dma_addr, (void __iomem *)(dma_base +
+						 IOC4_DMA_END_ADDR * 4));
 
 	writel(dma_direction, (void __iomem *)ioc4_dma_addr);
 }
 
-/* IOC4 Scatter Gather list Format 					 */
+/* IOC4 Scatter Gather list Format					 */
 /* 128 Bit entries to support 64 bit addresses in the future		 */
 /* The Scatter Gather list Entry should be in the BIG-ENDIAN Format	 */
 /* --------------------------------------------------------------------- */
-/* | Upper 32 bits - Zero           |	 	Lower 32 bits- address | */
+/* | Upper 32 bits - Zero	    |		Lower 32 bits- address | */
 /* --------------------------------------------------------------------- */
 /* | Upper 32 bits - Zero	    |EOL| 15 unused     | 16 Bit Length| */
 /* --------------------------------------------------------------------- */
-/* Creates the scatter gather list, DMA Table */
+/* Creates the scatter gather list, DMA Table				 */
+
 static int sgiioc4_build_dmatable(ide_drive_t *drive, struct ide_cmd *cmd)
 {
 	ide_hwif_t *hwif = drive->hwif;
@@ -448,8 +438,10 @@ static int sgiioc4_build_dmatable(ide_dr
 				if (bcount > cur_len)
 					bcount = cur_len;
 
-				/* put the addr, length in
-				 * the IOC4 dma-table format */
+				/*
+				 * Put the address, length in
+				 * the IOC4 dma-table format
+				 */
 				*table = 0x0;
 				table++;
 				*table = cpu_to_be32(cur_addr);
@@ -540,8 +532,7 @@ static const struct ide_port_info sgiioc
 	.mwdma_mask		= ATA_MWDMA2_ONLY,
 };
 
-static int __devinit
-sgiioc4_ide_setup_pci_device(struct pci_dev *dev)
+static int __devinit sgiioc4_ide_setup_pci_device(struct pci_dev *dev)
 {
 	unsigned long cmd_base, irqport;
 	unsigned long bar0, cmd_phys_base, ctl;
@@ -549,7 +540,7 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	struct ide_hw hw, *hws[] = { &hw };
 	int rc;
 
-	/*  Get the CmdBlk and CtrlBlk Base Registers */
+	/* Get the CmdBlk and CtrlBlk base registers */
 	bar0 = pci_resource_start(dev, 0);
 	virt_base = pci_ioremap_bar(dev, 0);
 	if (virt_base == NULL) {
@@ -557,9 +548,9 @@ sgiioc4_ide_setup_pci_device(struct pci_
 				DRV_NAME, bar0);
 		return -ENOMEM;
 	}
-	cmd_base = (unsigned long) virt_base + IOC4_CMD_OFFSET;
-	ctl = (unsigned long) virt_base + IOC4_CTRL_OFFSET;
-	irqport = (unsigned long) virt_base + IOC4_INTR_OFFSET;
+	cmd_base = (unsigned long)virt_base + IOC4_CMD_OFFSET;
+	ctl = (unsigned long)virt_base + IOC4_CTRL_OFFSET;
+	irqport = (unsigned long)virt_base + IOC4_INTR_OFFSET;
 
 	cmd_phys_base = bar0 + IOC4_CMD_OFFSET;
 	if (request_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE,
@@ -577,7 +568,7 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	hw.irq = dev->irq;
 	hw.dev = &dev->dev;
 
-	/* Initializing chipset IRQ Registers */
+	/* Initialize chipset IRQ registers */
 	writel(0x03, (void __iomem *)(irqport + IOC4_INTR_SET * 4));
 
 	rc = ide_host_add(&sgiioc4_port_info, hws, 1, NULL);
@@ -590,8 +581,7 @@ req_mem_rgn_err:
 	return rc;
 }
 
-static unsigned int __devinit
-pci_init_sgiioc4(struct pci_dev *dev)
+static unsigned int __devinit pci_init_sgiioc4(struct pci_dev *dev)
 {
 	int ret;
 
@@ -611,10 +601,10 @@ out:
 	return ret;
 }
 
-int __devinit
-ioc4_ide_attach_one(struct ioc4_driver_data *idd)
+int __devinit ioc4_ide_attach_one(struct ioc4_driver_data *idd)
 {
-	/* PCI-RT does not bring out IDE connection.
+	/*
+	 * PCI-RT does not bring out IDE connection.
 	 * Do not attach to this particular IOC4.
 	 */
 	if (idd->idd_variant == IOC4_VARIANT_PCI_RT)
@@ -627,7 +617,6 @@ static struct ioc4_submodule __devinitda
 	.is_name = "IOC4_ide",
 	.is_owner = THIS_MODULE,
 	.is_probe = ioc4_ide_attach_one,
-/*	.is_remove = ioc4_ide_remove_one,	*/
 };
 
 static int __init ioc4_ide_init(void)

