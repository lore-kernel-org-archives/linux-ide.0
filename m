From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] sgiioc4: kill duplicate ioremap()
Date: Wed, 15 Oct 2008 23:31:22 +0400
Message-ID: <200810152331.22972.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:3439 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752829AbYJOTbi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 15:31:38 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, jeremy@sgi.com

By the time ide_dma_sgiioc4() gets called, sgiioc4_ide_setup_pci_device() will
have called ioremap() on the whole BAR0 region, so calling ioremap() on the DMA
registers means wasting a page. Replace this call by a mere address calculation,
based on the fact that IRQ registers (pointed to by 'hwif->io_ports.irq_addr')
are situated at offset 0 from BAR0.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent pata-2.6 series...
Phew, it's been around since August -- sending out at last...

 drivers/ide/pci/sgiioc4.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
+++ linux-2.6/drivers/ide/pci/sgiioc4.c
@@ -320,7 +320,6 @@ ide_dma_sgiioc4(ide_hwif_t *hwif, const 
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
 	unsigned long dma_base = pci_resource_start(dev, 0) + IOC4_DMA_OFFSET;
-	void __iomem *virt_dma_base;
 	int num_ports = sizeof (ioc4_dma_regs_t);
 	void *pad;
 
@@ -333,14 +332,8 @@ ide_dma_sgiioc4(ide_hwif_t *hwif, const 
 		return -1;
 	}
 
-	virt_dma_base = ioremap(dma_base, num_ports);
-	if (virt_dma_base == NULL) {
-		printk(KERN_ERR "%s(%s) -- ERROR: unable to map addresses "
-		       "0x%lx to 0x%lx\n", __func__, hwif->name,
-		       dma_base, dma_base + num_ports - 1);
-		goto dma_remap_failure;
-	}
-	hwif->dma_base = (unsigned long) virt_dma_base;
+	hwif->dma_base = (unsigned long)hwif->io_ports.irq_addr +
+			 IOC4_DMA_OFFSET;
 
 	hwif->sg_max_nents = IOC4_PRD_ENTRIES;
 
@@ -364,9 +357,6 @@ ide_dma_sgiioc4(ide_hwif_t *hwif, const 
 	printk(KERN_INFO "%s: changing from DMA to PIO mode", hwif->name);
 
 dma_pci_alloc_failure:
-	iounmap(virt_dma_base);
-
-dma_remap_failure:
 	release_mem_region(dma_base, num_ports);
 
 	return -1;

