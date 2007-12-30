From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] ide_setup_dma() assumes 8 ports
Date: Sun, 30 Dec 2007 19:48:55 +0300
Message-ID: <200712301948.55016.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:35101 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755900AbXL3QsZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Dec 2007 11:48:25 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

According to http://marc.info/?l=linux-ide&m=114346138611631, the drivers must
always register 8 DMA ports with ide_setup_dma(), so its last argument is  not
needed. While at it, kill some useless parens in that function...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Both patches are aginst the top of pata-2.6 patchset...

 drivers/ide/ide-dma.c          |   40 ++++++++++++++++++++--------------------
 drivers/ide/pci/alim15x3.c     |    2 +-
 drivers/ide/pci/hpt366.c       |    2 +-
 drivers/ide/pci/pdc202xx_old.c |    4 ++--
 drivers/ide/setup-pci.c        |    2 +-
 include/linux/ide.h            |    2 +-
 6 files changed, 26 insertions(+), 26 deletions(-)

Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -891,19 +891,19 @@ static int ide_allocate_dma_engine(ide_h
 	return 1;
 }
 
-static int ide_mapped_mmio_dma(ide_hwif_t *hwif, unsigned long base, unsigned int ports)
+static int ide_mapped_mmio_dma(ide_hwif_t *hwif, unsigned long base)
 {
 	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
 
 	return 0;
 }
 
-static int ide_iomio_dma(ide_hwif_t *hwif, unsigned long base, unsigned int ports)
+static int ide_iomio_dma(ide_hwif_t *hwif, unsigned long base)
 {
 	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
-	       hwif->name, base, base + ports - 1);
+	       hwif->name, base, base + 7);
 
-	if (!request_region(base, ports, hwif->name)) {
+	if (!request_region(base, 8, hwif->name)) {
 		printk(" -- Error, ports in use.\n");
 		return 1;
 	}
@@ -915,7 +915,7 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 			if (!request_region(hwif->extra_base,
 					    hwif->cds->extra, hwif->cds->name)) {
 				printk(" -- Error, extra ports in use.\n");
-				release_region(base, ports);
+				release_region(base, 8);
 				return 1;
 			}
 			hwif->extra_ports = hwif->cds->extra;
@@ -925,19 +925,19 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 	return 0;
 }
 
-static int ide_dma_iobase(ide_hwif_t *hwif, unsigned long base, unsigned int ports)
+static int ide_dma_iobase(ide_hwif_t *hwif, unsigned long base)
 {
 	if (hwif->mmio)
-		return ide_mapped_mmio_dma(hwif, base,ports);
+		return ide_mapped_mmio_dma(hwif, base);
 
-	return ide_iomio_dma(hwif, base, ports);
+	return ide_iomio_dma(hwif, base);
 }
 
-void ide_setup_dma(ide_hwif_t *hwif, unsigned long base, unsigned num_ports)
+void ide_setup_dma(ide_hwif_t *hwif, unsigned long base)
 {
 	u8 dma_stat;
 
-	if (ide_dma_iobase(hwif, base, num_ports))
+	if (ide_dma_iobase(hwif, base))
 		return;
 
 	if (ide_allocate_dma_engine(hwif)) {
@@ -947,16 +947,16 @@ void ide_setup_dma(ide_hwif_t *hwif, uns
 
 	hwif->dma_base = base;
 
-	if (!(hwif->dma_command))
-		hwif->dma_command	= hwif->dma_base;
-	if (!(hwif->dma_vendor1))
-		hwif->dma_vendor1	= (hwif->dma_base + 1);
-	if (!(hwif->dma_status))
-		hwif->dma_status	= (hwif->dma_base + 2);
-	if (!(hwif->dma_vendor3))
-		hwif->dma_vendor3	= (hwif->dma_base + 3);
-	if (!(hwif->dma_prdtable))
-		hwif->dma_prdtable	= (hwif->dma_base + 4);
+	if (!hwif->dma_command)
+		hwif->dma_command	= hwif->dma_base + 0;
+	if (!hwif->dma_vendor1)
+		hwif->dma_vendor1	= hwif->dma_base + 1;
+	if (!hwif->dma_status)
+		hwif->dma_status	= hwif->dma_base + 2;
+	if (!hwif->dma_vendor3)
+		hwif->dma_vendor3	= hwif->dma_base + 3;
+	if (!hwif->dma_prdtable)
+		hwif->dma_prdtable	= hwif->dma_base + 4;
 
 	if (!hwif->dma_host_set)
 		hwif->dma_host_set = &ide_dma_host_set;
Index: linux-2.6/drivers/ide/pci/alim15x3.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/alim15x3.c
+++ linux-2.6/drivers/ide/pci/alim15x3.c
@@ -745,7 +745,7 @@ static void __devinit init_dma_ali15x3 (
 		return;
 	if (!hwif->channel)
 		outb(inb(dmabase + 2) & 0x60, dmabase + 2);
-	ide_setup_dma(hwif, dmabase, 8);
+	ide_setup_dma(hwif, dmabase);
 }
 
 static const struct ide_port_info ali15x3_chipset __devinitdata = {
Index: linux-2.6/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6/drivers/ide/pci/hpt366.c
@@ -1413,7 +1413,7 @@ static void __devinit init_dma_hpt366(id
 
 	local_irq_restore(flags);
 
-	ide_setup_dma(hwif, dmabase, 8);
+	ide_setup_dma(hwif, dmabase);
 }
 
 static void __devinit hpt374_init(struct pci_dev *dev, struct pci_dev *dev2)
Index: linux-2.6/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/pdc202xx_old.c
+++ linux-2.6/drivers/ide/pci/pdc202xx_old.c
@@ -334,7 +334,7 @@ static void __devinit init_dma_pdc202xx(
 	u8 udma_speed_flag = 0, primary_mode = 0, secondary_mode = 0;
 
 	if (hwif->channel) {
-		ide_setup_dma(hwif, dmabase, 8);
+		ide_setup_dma(hwif, dmabase);
 		return;
 	}
 
@@ -358,7 +358,7 @@ static void __devinit init_dma_pdc202xx(
 	}
 #endif /* CONFIG_PDC202XX_BURST */
 
-	ide_setup_dma(hwif, dmabase, 8);
+	ide_setup_dma(hwif, dmabase);
 }
 
 static void __devinit pdc202ata4_fixup_irq(struct pci_dev *dev,
Index: linux-2.6/drivers/ide/setup-pci.c
===================================================================
--- linux-2.6.orig/drivers/ide/setup-pci.c
+++ linux-2.6/drivers/ide/setup-pci.c
@@ -451,7 +451,7 @@ static void ide_hwif_setup_dma(struct pc
 			if (d->init_dma) {
 				d->init_dma(hwif, dma_base);
 			} else {
-				ide_setup_dma(hwif, dma_base, 8);
+				ide_setup_dma(hwif, dma_base);
 			}
 		} else {
 			printk(KERN_INFO "%s: %s Bus-Master DMA disabled "
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -1158,7 +1158,7 @@ extern int ide_build_sglist(ide_drive_t 
 extern int ide_build_dmatable(ide_drive_t *, struct request *);
 extern void ide_destroy_dmatable(ide_drive_t *);
 extern int ide_release_dma(ide_hwif_t *);
-extern void ide_setup_dma(ide_hwif_t *, unsigned long, unsigned int);
+extern void ide_setup_dma(ide_hwif_t *, unsigned long);
 
 void ide_dma_host_set(ide_drive_t *, int);
 extern int ide_dma_setup(ide_drive_t *);

