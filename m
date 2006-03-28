From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: [PATCH] IDE: remove 'dma_base2' field form 'ide_hwif_t'
Date: Tue, 28 Mar 2006 23:30:46 +0400
Message-ID: <44298EE6.5030608@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010804010600010503010409"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:54178 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751289AbWC1Tcn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Mar 2006 14:32:43 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This is a multi-part message in MIME format.
--------------010804010600010503010409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hail.

      Remove 'dma_base2' field from 'ide_hwif_t' as it's used only by 2 drivers
and without a great need.

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------010804010600010503010409
Content-Type: text/plain;
 name="IDE-remove-dma_base2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IDE-remove-dma_base2.patch"

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 0523da7..049d60e 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -803,8 +803,6 @@ static int ide_release_iomio_dma(ide_hwi
 	if ((hwif->dma_extra) && (hwif->channel == 0))
 		release_region((hwif->dma_base + 16), hwif->dma_extra);
 	release_region(hwif->dma_base, 8);
-	if (hwif->dma_base2)
-		release_region(hwif->dma_base, 8);
 	return 1;
 }
 
@@ -871,14 +869,6 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;
 	else
 		hwif->dma_master = base;
-	if (hwif->dma_base2) {
-		if (!request_region(hwif->dma_base2, ports, hwif->name))
-		{
-			printk(" -- Error, secondary ports in use.\n");
-			release_region(base, ports);
-			return 1;
-		}
-	}
 	return 0;
 }
 
diff --git a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
index 43b96e2..2e06a1b 100644
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
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
 
diff --git a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
index f1ca154..bc66756 100644
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -939,11 +939,9 @@ static void __devinit init_mmio_iops_sii
 #ifdef SIIMAGE_LARGE_DMA
 /* Watch the brackets - even Ken and Dennis get some language design wrong */
 	hwif->dma_base			= base + (ch ? 0x18 : 0x10);
-	hwif->dma_base2			= base + (ch ? 0x08 : 0x00);
-	hwif->dma_prdtable		= hwif->dma_base2 + 4;
+	hwif->dma_prdtable		= base + (ch ? 0x0c : 0x04);
 #else /* ! SIIMAGE_LARGE_DMA */
 	hwif->dma_base			= base + (ch ? 0x08 : 0x00);
-	hwif->dma_base2			= base + (ch ? 0x18 : 0x10);
 #endif /* SIIMAGE_LARGE_DMA */
 	hwif->mmio			= 2;
 }
diff --git a/include/linux/ide.h b/include/linux/ide.h
index a7fc4cc..97f3ca1 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -773,7 +773,6 @@ typedef struct hwif_s {
 	unsigned long	dma_status;	/* dma status register */
 	unsigned long	dma_vendor3;	/* dma vendor 3 register */
 	unsigned long	dma_prdtable;	/* actual prd table address */
-	unsigned long	dma_base2;	/* extended base addr for dma ports */
 
 	unsigned	dma_extra;	/* extra addr for dma ports */
 	unsigned long	config_data;	/* for use by chipset-specific code */



--------------010804010600010503010409--
