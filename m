From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: [PATCH] Fix IDE DMA resource managment
Date: Tue, 21 Mar 2006 23:32:01 +0300
Message-ID: <442062C1.4070708@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050709020804000206010605"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:13532 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751266AbWCUUd7
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 15:33:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This is a multi-part message in MIME format.
--------------050709020804000206010605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hail.

Resolve several IDE DMA resource management issues:

- release DMA engine for memory mapped DMA as well
- release the same number of DMA I/O ports that was requested by a driver
- release the channel's secondary DMA I/O ports for real
- claim extra DMA I/O ports regardless of what IDE channels are present/enabled
- merge the duplicate code into ide_dma_iobase()

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------050709020804000206010605
Content-Type: text/plain;
 name="IDE-DMA-resource-mgmt-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IDE-DMA-resource-mgmt-fix.patch"

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 0523da7..dd2a3d5 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -800,26 +800,25 @@ static int ide_release_dma_engine(ide_hw
 
 static int ide_release_iomio_dma(ide_hwif_t *hwif)
 {
-	if ((hwif->dma_extra) && (hwif->channel == 0))
-		release_region((hwif->dma_base + 16), hwif->dma_extra);
-	release_region(hwif->dma_base, 8);
+	release_region(hwif->dma_base, hwif->dma_ports);
+	if (hwif->extra_base)
+		release_region(hwif->extra_base, hwif->extra_ports);
 	if (hwif->dma_base2)
-		release_region(hwif->dma_base, 8);
+		release_region(hwif->dma_base2, hwif->dma_ports);
 	return 1;
 }
 
 /*
  * Needed for allowing full modular support of ide-driver
  */
-int ide_release_dma (ide_hwif_t *hwif)
+int ide_release_dma(ide_hwif_t *hwif)
 {
+	ide_release_dma_engine(hwif);
+
 	if (hwif->mmio == 2)
 		return 1;
-	if (hwif->chipset == ide_etrax100)
-		return 1;
-
-	ide_release_dma_engine(hwif);
-	return ide_release_iomio_dma(hwif);
+	else
+		return ide_release_iomio_dma(hwif);
 }
 
 static int ide_allocate_dma_engine(ide_hwif_t *hwif)
@@ -840,16 +839,7 @@ static int ide_allocate_dma_engine(ide_h
 
 static int ide_mapped_mmio_dma(ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
-	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
-
-	hwif->dma_base = base;
-	if (hwif->cds->extra && hwif->channel == 0)
-		hwif->dma_extra = hwif->cds->extra;
-
-	if(hwif->mate)
-		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;
-	else
-		hwif->dma_master = base;
+	printk(KERN_INFO "    %s: MMIO-DMA at 0x%08lx", hwif->name, base);
 	return 0;
 }
 
@@ -857,43 +847,48 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 {
 	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
 		hwif->name, base, base + ports - 1);
+
 	if (!request_region(base, ports, hwif->name)) {
 		printk(" -- Error, ports in use.\n");
 		return 1;
 	}
-	hwif->dma_base = base;
-	if ((hwif->cds->extra) && (hwif->channel == 0)) {
-		request_region(base+16, hwif->cds->extra, hwif->cds->name);
-		hwif->dma_extra = hwif->cds->extra;
-	}
-	
-	if(hwif->mate)
-		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;
-	else
-		hwif->dma_master = base;
-	if (hwif->dma_base2) {
-		if (!request_region(hwif->dma_base2, ports, hwif->name))
-		{
-			printk(" -- Error, secondary ports in use.\n");
-			release_region(base, ports);
-			return 1;
-		}
+
+	if (hwif->dma_base2 && !request_region(hwif->dma_base2, ports, hwif->name)) {
+		release_region(base, ports);
+		printk(" -- Error, secondary ports in use.\n");
+		return 1;
 	}
+
+	if (hwif->extra_base)
+		request_region(hwif->extra_base, hwif->extra_ports,
+			       hwif->cds->name);
 	return 0;
 }
 
 static int ide_dma_iobase(ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
-	if (hwif->mmio == 2)
-		return ide_mapped_mmio_dma(hwif, base,ports);
 	BUG_ON(hwif->mmio == 1);
-	return ide_iomio_dma(hwif, base, ports);
+
+	hwif->dma_base	= base;
+	hwif->dma_ports = ports;
+
+	if (hwif->cds->extra && !(hwif->mate && hwif->mate->extra_base)) {
+		hwif->extra_base  = base + (hwif->channel ? 8 : 16);
+		hwif->extra_ports = hwif->cds->extra;
+	}
+
+	hwif->dma_master = (hwif->channel && hwif->mate) ? hwif->mate->dma_base : base;
+
+	if (hwif->mmio == 2)
+		return ide_mapped_mmio_dma(hwif, base, ports);
+	else
+		return ide_iomio_dma(hwif, base, ports);
 }
 
 /*
  * This can be called for a dynamically installed interface. Don't __init it
  */
-void ide_setup_dma (ide_hwif_t *hwif, unsigned long dma_base, unsigned int num_ports)
+void ide_setup_dma(ide_hwif_t *hwif, unsigned long dma_base, unsigned int num_ports)
 {
 	if (ide_dma_iobase(hwif, dma_base, num_ports))
 		return;
@@ -903,16 +898,16 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		return;
 	}
 
-	if (!(hwif->dma_command))
+	if (!hwif->dma_command)
 		hwif->dma_command	= hwif->dma_base;
-	if (!(hwif->dma_vendor1))
-		hwif->dma_vendor1	= (hwif->dma_base + 1);
-	if (!(hwif->dma_status))
-		hwif->dma_status	= (hwif->dma_base + 2);
-	if (!(hwif->dma_vendor3))
-		hwif->dma_vendor3	= (hwif->dma_base + 3);
-	if (!(hwif->dma_prdtable))
-		hwif->dma_prdtable	= (hwif->dma_base + 4);
+	if (!hwif->dma_vendor1)
+		hwif->dma_vendor1	= hwif->dma_base + 1;
+	if (!hwif->dma_status)
+		hwif->dma_status	= hwif->dma_base + 2;
+	if (!hwif->dma_vendor3)
+		hwif->dma_vendor3	= hwif->dma_base + 3;
+	if (!hwif->dma_prdtable)
+		hwif->dma_prdtable	= hwif->dma_base + 4;
 
 	if (!hwif->ide_dma_off_quietly)
 		hwif->ide_dma_off_quietly = &__ide_dma_off_quietly;
@@ -947,7 +942,7 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 	}
 	printk("\n");
 
-	if (!(hwif->dma_master))
+	if (!hwif->dma_master)
 		BUG();
 }
 
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index b2cc437..5c31f2a 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -452,7 +452,7 @@ void ide_hwif_release_regions(ide_hwif_t
  *	@hwif: hwif to update
  *	@tmp_hwif: template
  *
- *	Restore hwif to a previous state by copying most settngs
+ *	Restore hwif to a previous state by copying most settings
  *	from the template.
  */
 
@@ -540,8 +540,11 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->dma_status		= tmp_hwif->dma_status;
 	hwif->dma_vendor3		= tmp_hwif->dma_vendor3;
 	hwif->dma_prdtable		= tmp_hwif->dma_prdtable;
+	hwif->dma_base2			= tmp_hwif->dma_base2;
+	hwif->extra_base		= tmp_hwif->extra_base;
 
-	hwif->dma_extra			= tmp_hwif->dma_extra;
+	hwif->dma_ports			= tmp_hwif->dma_ports;
+	hwif->extra_ports		= tmp_hwif->extra_ports;
 	hwif->config_data		= tmp_hwif->config_data;
 	hwif->select_data		= tmp_hwif->select_data;
 	hwif->autodma			= tmp_hwif->autodma;
@@ -552,7 +555,7 @@ static void ide_hwif_restore(ide_hwif_t 
 }
 
 /**
- *	ide_unregister		-	free an ide interface
+ *	ide_unregister		-	free an IDE interface
  *	@index: index of interface (will change soon to a pointer)
  *
  *	Perform the final unregister of an IDE interface. At the moment
@@ -565,8 +568,8 @@ static void ide_hwif_restore(ide_hwif_t 
  *	deadlocking the IDE layer. The shutdown callback is called
  *	before we take the lock and free resources. It is up to the
  *	caller to be sure there is no pending I/O here, and that
- *	the interfce will not be reopened (present/vanishing locking
- *	isnt yet done btw). After we commit to the final kill we
+ *	the interface will not be reopened (present/vanishing locking
+ *	isn't yet done BTW). After we commit to the final kill we
  *	call the cleanup callback with the ide locks held.
  *
  *	Unregister restores the hwif structures to the default state.
diff --git a/include/linux/ide.h b/include/linux/ide.h
index a7fc4cc..122cb54 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -774,8 +774,10 @@ typedef struct hwif_s {
 	unsigned long	dma_vendor3;	/* dma vendor 3 register */
 	unsigned long	dma_prdtable;	/* actual prd table address */
 	unsigned long	dma_base2;	/* extended base addr for dma ports */
+	unsigned long	extra_base;	/* extra addr for dma ports */
 
-	unsigned	dma_extra;	/* extra addr for dma ports */
+	unsigned	dma_ports;	/* number of dma ports */
+	unsigned	extra_ports;	/* number of extra dma ports */
 	unsigned long	config_data;	/* for use by chipset-specific code */
 	unsigned long	select_data;	/* for use by chipset-specific code */
 



--------------050709020804000206010605--
