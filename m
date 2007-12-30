From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/2] trm290: cannot call ide_setup_dma()
Date: Sun, 30 Dec 2007 19:46:40 +0300
Message-ID: <200712301946.40108.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:35094 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752521AbXL3QqL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Dec 2007 11:46:11 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The TRM-290 chip is *not* SFF-8038i compatible and therefore can *not* call
ide_setup_dma() -- fix this and also cleanup the code a bit...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/ide-dma.c    |   13 ++++-----
 drivers/ide/pci/trm290.c |   62 ++++++++++++++++++++++++++++-------------------
 2 files changed, 43 insertions(+), 32 deletions(-)

Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -935,6 +935,8 @@ static int ide_dma_iobase(ide_hwif_t *hw
 
 void ide_setup_dma(ide_hwif_t *hwif, unsigned long base, unsigned num_ports)
 {
+	u8 dma_stat;
+
 	if (ide_dma_iobase(hwif, base, num_ports))
 		return;
 
@@ -973,13 +975,10 @@ void ide_setup_dma(ide_hwif_t *hwif, uns
 	if (!hwif->dma_lost_irq)
 		hwif->dma_lost_irq = &ide_dma_lost_irq;
 
-	if (hwif->chipset != ide_trm290) {
-		u8 dma_stat = hwif->INB(hwif->dma_status);
-		printk(", BIOS settings: %s:%s, %s:%s",
-		       hwif->drives[0].name, (dma_stat & 0x20) ? "DMA" : "pio",
-		       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "pio");
-	}
-	printk("\n");
+	dma_stat = hwif->INB(hwif->dma_status);
+	printk(KERN_CONT ", BIOS settings: %s:%s, %s:%s\n",
+	       hwif->drives[0].name, (dma_stat & 0x20) ? "DMA" : "PIO",
+	       hwif->drives[1].name, (dma_stat & 0x40) ? "DMA" : "PIO");
 }
 
 EXPORT_SYMBOL_GPL(ide_setup_dma);
Index: linux-2.6/drivers/ide/pci/trm290.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/trm290.c
+++ linux-2.6/drivers/ide/pci/trm290.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/trm290.c		Version 1.05	Dec. 26, 2007
+ *  linux/drivers/ide/pci/trm290.c		Version 1.05	Dec. 30, 2007
  *
  *  Copyright (c) 1997-1998  Mark Lord
  *  Copyright (c) 2007       MontaVista Software, Inc. <source@mvista.com>
@@ -209,10 +209,10 @@ static int trm290_dma_setup(ide_drive_t 
 	}
 	/* select DMA xfer */
 	trm290_prepare_drive(drive, 1);
-	outl(hwif->dmatable_dma | rw, hwif->dma_command);
+	outl(hwif->dmatable_dma | rw, hwif->dma_base);
 	drive->waiting_for_dma = 1;
 	/* start DMA */
-	outw((count * 2) - 1, hwif->dma_status);
+	outw(count * 2 - 1, hwif->dma_base + 2);
 	return 0;
 }
 
@@ -222,23 +222,21 @@ static void trm290_dma_start(ide_drive_t
 
 static int trm290_ide_dma_end (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-	u16 status = 0;
+	u16 status;
 
 	drive->waiting_for_dma = 0;
 	/* purge DMA mappings */
 	ide_destroy_dmatable(drive);
-	status = inw(hwif->dma_status);
-	return (status != 0x00ff);
+	status = inw(HWIF(drive)->dma_base + 2);
+	return status != 0x00ff;
 }
 
 static int trm290_ide_dma_test_irq (ide_drive_t *drive)
 {
-	ide_hwif_t *hwif = HWIF(drive);
-	u16 status = 0;
+	u16 status;
 
-	status = inw(hwif->dma_status);
-	return (status == 0x00ff);
+	status = inw(HWIF(drive)->dma_base + 2);
+	return status == 0x00ff;
 }
 
 static void trm290_dma_host_set(ide_drive_t *drive, int on)
@@ -247,21 +245,37 @@ static void trm290_dma_host_set(ide_driv
 
 static void __devinit init_hwif_trm290(ide_hwif_t *hwif)
 {
-	unsigned int cfgbase = 0;
+	struct pci_dev *dev	= hwif->pci_dev;
+	unsigned int  cfg_base	= pci_resource_start(dev, 4);
 	unsigned long flags;
 	u8 reg = 0;
-	struct pci_dev *dev = hwif->pci_dev;
 
-	cfgbase = pci_resource_start(dev, 4);
-	if ((dev->class & 5) && cfgbase) {
-		hwif->config_data = cfgbase;
-		printk(KERN_INFO "TRM290: chip config base at 0x%04lx\n",
-			hwif->config_data);
-	} else {
-		hwif->config_data = 0x3df0;
-		printk(KERN_INFO "TRM290: using default config base at 0x%04lx\n",
-			hwif->config_data);
+	if ((dev->class & 5) && cfg_base)
+		printk(KERN_INFO "TRM290: chip");
+	else {
+		cfg_base = 0x3df0;
+		printk(KERN_INFO "TRM290: using default");
+	}
+	printk(KERN_CONT " config base at 0x%04x\n", cfg_base);
+	hwif->config_data = cfg_base;
+	hwif->dma_base = (cfg_base + 4) ^ (hwif->channel ? 0x80 : 0);
+
+	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
+	       hwif->name, hwif->dma_base, hwif->dma_base + 3);
+
+	if (!request_region(hwif->dma_base, 4, hwif->name)) {
+		printk(KERN_CONT " -- Error, ports in use.\n");
+		return;
+	}
+
+	hwif->dmatable_cpu = pci_alloc_consistent(dev, PRD_ENTRIES * PRD_BYTES,
+						  &hwif->dmatable_dma);
+	if (!hwif->dmatable_cpu) {
+		printk(KERN_CONT " -- Error, unable to allocate DMA table.\n");
+		release_region(hwif->dma_base, 4);
+		return;
 	}
+	printk(KERN_CONT "\n");
 
 	local_irq_save(flags);
 	/* put config reg into first byte of hwif->select_data */
@@ -276,15 +290,13 @@ static void __devinit init_hwif_trm290(i
 	outb(reg, hwif->config_data + 3);
 	local_irq_restore(flags);
 
-	if ((reg & 0x10))
+	if (reg & 0x10)
 		/* legacy mode */
 		hwif->irq = hwif->channel ? 15 : 14;
 	else if (!hwif->irq && hwif->mate && hwif->mate->irq)
 		/* sharing IRQ with mate */
 		hwif->irq = hwif->mate->irq;
 
-	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->channel ? 0x0080 : 0x0000), 3);
-
 	hwif->dma_host_set	= &trm290_dma_host_set;
 	hwif->dma_setup 	= &trm290_dma_setup;
 	hwif->dma_exec_cmd	= &trm290_dma_exec_cmd;

