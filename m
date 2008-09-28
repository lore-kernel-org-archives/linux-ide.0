From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] sgiioc4: fix messages
Date: Sun, 28 Sep 2008 23:50:26 +0400
Message-ID: <200809282350.26303.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:52879 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751896AbYI1Tt2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Sep 2008 15:49:28 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

Fix several issues with the log messages printed by ide_dma_sgiioc4() and
sgiioc4_ide_setup_pci_device():

- IOC4 registers are memory-mapped but the "BM-DMA at" format corresponds to
  I/O  mapped registers;

- "%p" format specifiers and type casts used to print non-pointer values;

- using KERN_INFO log level for the error message;

- 'hwif->name' printed as drive's name.

While at it, also:

- return more fitting -EBUSY if request_mem_region() fails;

- make the error message style consistent;

- fix indentation, put the printk() facility and message on the same line;

- use comparisions with NULL instead of ! operator..

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
                                          
---
The patch is against the recent Linus' tree.
                                          
 drivers/ide/pci/sgiioc4.c |   39 ++++++++++++++++-----------------------
 1 files changed, 16 insertions(+), 23 deletions(-)

Index: linux-2.6/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
+++ linux-2.6/drivers/ide/pci/sgiioc4.c
@@ -340,23 +340,20 @@ ide_dma_sgiioc4(ide_hwif_t *hwif, const 
 	if (dma_base == 0)
 		return -1;
 
-	printk(KERN_INFO "%s: BM-DMA at 0x%04lx-0x%04lx\n", hwif->name,
-	       dma_base, dma_base + num_ports - 1);
+	printk(KERN_INFO "    %s: MMIO-DMA\n", hwif->name);
 
-	if (!request_mem_region(dma_base, num_ports, hwif->name)) {
-		printk(KERN_ERR
-		       "%s(%s) -- ERROR, Addresses 0x%p to 0x%p "
-		       "ALREADY in use\n",
-		       __func__, hwif->name, (void *) dma_base,
-		       (void *) dma_base + num_ports - 1);
+	if (request_mem_region(dma_base, num_ports, hwif->name) == NULL) {
+		printk(KERN_ERR "%s(%s) -- ERROR: addresses 0x%08lx to 0x%08lx "
+		       "already in use\n", __func__, hwif->name,
+		       dma_base, dma_base + num_ports - 1);
 		return -1;
 	}
 
 	virt_dma_base = ioremap(dma_base, num_ports);
 	if (virt_dma_base == NULL) {
-		printk(KERN_ERR
-		       "%s(%s) -- ERROR, Unable to map addresses 0x%lx to 0x%lx\n",
-		       __func__, hwif->name, dma_base, dma_base + num_ports - 1);
+		printk(KERN_ERR "%s(%s) -- ERROR: unable to map addresses "
+		       "0x%lx to 0x%lx\n", __func__, hwif->name,
+		       dma_base, dma_base + num_ports - 1);
 		goto dma_remap_failure;
 	}
 	hwif->dma_base = (unsigned long) virt_dma_base;
@@ -379,11 +376,9 @@ ide_dma_sgiioc4(ide_hwif_t *hwif, const 
 
 	pci_free_consistent(dev, IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
 			    hwif->dmatable_cpu, hwif->dmatable_dma);
-	printk(KERN_INFO
-	       "%s() -- Error! Unable to allocate DMA Maps for drive %s\n",
+	printk(KERN_ERR "%s(%s) -- ERROR: Unable to allocate DMA maps\n",
 	       __func__, hwif->name);
-	printk(KERN_INFO
-	       "Changing from DMA to PIO mode for Drive %s\n", hwif->name);
+	printk(KERN_INFO "%s: changing from DMA to PIO mode", hwif->name);
 
 dma_pci_alloc_failure:
 	iounmap(virt_dma_base);
@@ -619,14 +614,12 @@ sgiioc4_ide_setup_pci_device(struct pci_
 	irqport = (unsigned long) virt_base + IOC4_INTR_OFFSET;
 
 	cmd_phys_base = bar0 + IOC4_CMD_OFFSET;
-	if (!request_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE,
-	    DRV_NAME)) {
-		printk(KERN_ERR
-			"%s %s: -- ERROR, Addresses "
-			"0x%p to 0x%p ALREADY in use\n",
-		       DRV_NAME, pci_name(dev), (void *)cmd_phys_base,
-		       (void *) cmd_phys_base + IOC4_CMD_CTL_BLK_SIZE);
-		return -ENOMEM;
+	if (request_mem_region(cmd_phys_base, IOC4_CMD_CTL_BLK_SIZE,
+			       DRV_NAME) == NULL) {
+		printk(KERN_ERR "%s %s -- ERROR: addresses 0x%08lx to 0x%08lx "
+		       "already in use\n", DRV_NAME, pci_name(dev),
+		       cmd_phys_base, cmd_phys_base + IOC4_CMD_CTL_BLK_SIZE);
+		return -EBUSY;
 	}
 
 	/* Initialize the IO registers */

