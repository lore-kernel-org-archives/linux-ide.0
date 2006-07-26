From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] remove dma_base2 field form ide_hwif_t
Date: Wed, 26 Jul 2006 23:21:20 +0400
Message-ID: <44C7C0B0.8010605@ru.mvista.com>
References: <44C52CCE.7070204@ru.mvista.com> <20060724225703.GD776006@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090002040007020309000409"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:4231 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1751765AbWGZTWj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Jul 2006 15:22:39 -0400
In-Reply-To: <20060724225703.GD776006@sgi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Jes Sorensen <jes@sgi.com>, Brent Casavant <bcasavan@sgi.com>, jpk@sgi.com, Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090002040007020309000409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Remove dma_base2 field from ide_hwif_t as it's used only in 2 drivers and
without great need.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------090002040007020309000409
Content-Type: text/plain;
 name="remove-dma_base2-field-from-ide_hwif_t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove-dma_base2-field-from-ide_hwif_t.patch"

Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -799,8 +799,6 @@ static int ide_release_iomio_dma(ide_hwi
 	release_region(hwif->dma_base, 8);
 	if (hwif->extra_ports)
 		release_region(hwif->extra_base, hwif->extra_ports);
-	if (hwif->dma_base2)
-		release_region(hwif->dma_base, 8);
 	return 1;
 }
 
@@ -872,19 +870,9 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 	}
 
 	if(hwif->mate)
-		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;
+		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base:base;
 	else
 		hwif->dma_master = base;
-	if (hwif->dma_base2) {
-		if (!request_region(hwif->dma_base2, ports, hwif->name))
-		{
-			printk(" -- Error, secondary ports in use.\n");
-			release_region(base, ports);
-			if (hwif->extra_ports)
-				release_region(hwif->extra_base, hwif->extra_ports);
-			return 1;
-		}
-	}
 	return 0;
 }
 
Index: linux-2.6/drivers/ide/pci/sgiioc4.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/sgiioc4.c
+++ linux-2.6/drivers/ide/pci/sgiioc4.c
@@ -220,7 +220,7 @@ sgiioc4_ide_dma_end(ide_drive_t * drive)
 	ide_hwif_t *hwif = HWIF(drive);
 	u64 dma_base = hwif->dma_base;
 	int dma_stat = 0;
-	unsigned long *ending_dma = (unsigned long *) hwif->dma_base2;
+	unsigned long *ending_dma = ide_get_hwifdata(hwif);
 
 	hwif->OUTL(IOC4_S_DMA_STOP, dma_base + IOC4_DMA_CTRL * 4);
 
@@ -367,7 +367,8 @@ sgiioc4_INB(unsigned long port)
 static void __devinit
 ide_dma_sgiioc4(ide_hwif_t * hwif, unsigned long dma_base)
 {
-	int num_ports = sizeof (ioc4_dma_regs_t);
+	int   num_ports = sizeof(ioc4_dma_regs_t);
+	void *pad;
 
 	printk(KERN_INFO "%s: BM-DMA at 0x%04lx-0x%04lx\n", hwif->name,
 	       dma_base, dma_base + num_ports - 1);
@@ -391,17 +392,14 @@ ide_dma_sgiioc4(ide_hwif_t * hwif, unsig
 
 	hwif->sg_max_nents = IOC4_PRD_ENTRIES;
 
-	hwif->dma_base2 = (unsigned long)
-		pci_alloc_consistent(hwif->pci_dev,
-				     IOC4_IDE_CACHELINE_SIZE,
-				     (dma_addr_t *) &(hwif->dma_status));
+	pad = pci_alloc_consistent(hwif->pci_dev, IOC4_IDE_CACHELINE_SIZE,
+				   (dma_addr_t *) &(hwif->dma_status));
 
-	if (!hwif->dma_base2)
-		goto dma_base2alloc_failure;
-
-	return;
+	if (pad) {
+		ide_set_hwifdata(hwif, pad);
+		return;
+	}
 
-dma_base2alloc_failure:
 	pci_free_consistent(hwif->pci_dev,
 			    IOC4_PRD_ENTRIES * IOC4_PRD_BYTES,
 			    hwif->dmatable_cpu, hwif->dmatable_dma);
@@ -461,7 +459,7 @@ sgiioc4_configure_for_dma(int dma_direct
 	hwif->OUTL(dma_addr, dma_base + IOC4_DMA_PTR_L * 4);
 
 	/* Address of the Ending DMA */
-	memset((unsigned int *) hwif->dma_base2, 0, IOC4_IDE_CACHELINE_SIZE);
+	memset(ide_get_hwifdata(hwif), 0, IOC4_IDE_CACHELINE_SIZE);
 	ending_dma_addr = cpu_to_le32(hwif->dma_status);
 	hwif->OUTL(ending_dma_addr, dma_base + IOC4_DMA_END_ADDR * 4);
 
Index: linux-2.6/drivers/ide/pci/siimage.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/siimage.c
+++ linux-2.6/drivers/ide/pci/siimage.c
@@ -898,7 +898,6 @@ static void __devinit init_mmio_iops_sii
        	base = (unsigned long) addr;
 
 	hwif->dma_base			= base + (ch ? 0x08 : 0x00);
-	hwif->dma_base2			= base + (ch ? 0x18 : 0x10);
 	hwif->mmio			= 2;
 }
 
Index: linux-2.6/include/linux/ide.h
===================================================================
--- linux-2.6.orig/include/linux/ide.h
+++ linux-2.6/include/linux/ide.h
@@ -773,7 +773,6 @@ typedef struct hwif_s {
 	unsigned long	dma_status;	/* dma status register */
 	unsigned long	dma_vendor3;	/* dma vendor 3 register */
 	unsigned long	dma_prdtable;	/* actual prd table address */
-	unsigned long	dma_base2;	/* extended base addr for dma ports */
 
 	unsigned long	config_data;	/* for use by chipset-specific code */
 	unsigned long	select_data;	/* for use by chipset-specific code */


--------------090002040007020309000409--
