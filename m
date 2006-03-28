From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: [PATCH] IDE: claim extra DMA ports regardless of channel
Date: Tue, 28 Mar 2006 23:06:47 +0400
Message-ID: <44298947.5090600@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080105070508090105080309"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:33185 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751263AbWC1TIf
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Mar 2006 14:08:35 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This is a multi-part message in MIME format.
--------------080105070508090105080309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hail.

     Claim extra DMA I/O ports regardless of what IDE channels are
present/enabled.
     Remove extra ports handling from ide_mapped_mmio_dma() since
it's not applicable to the custom-mapping IDE drivers.

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>




--------------080105070508090105080309
Content-Type: text/plain;
 name="IDE-always-claim-extra-DMA-ports.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IDE-always-claim-extra-DMA-ports.patch"

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index c481be8..f2ecee6 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -800,9 +800,9 @@ static int ide_release_dma_engine(ide_hw
 
 static int ide_release_iomio_dma(ide_hwif_t *hwif)
 {
-	if ((hwif->dma_extra) && (hwif->channel == 0))
-		release_region((hwif->dma_base + 16), hwif->dma_extra);
 	release_region(hwif->dma_base, 8);
+	if (hwif->extra_ports)
+		release_region(hwif->extra_base, hwif->extra_ports);
 	if (hwif->dma_base2)
 		release_region(hwif->dma_base, 8);
 	return 1;
@@ -842,9 +842,7 @@ static int ide_mapped_mmio_dma(ide_hwif_
 {
 	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
 
-	hwif->dma_base = base;
-	if (hwif->cds->extra && hwif->channel == 0)
-		hwif->dma_extra = hwif->cds->extra;
+ 	hwif->dma_base = base;
 
 	if(hwif->mate)
 		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;
@@ -856,17 +854,29 @@ static int ide_mapped_mmio_dma(ide_hwif_
 static int ide_iomio_dma(ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
 	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
-		hwif->name, base, base + ports - 1);
+	       hwif->name, base, base + ports - 1);
+
 	if (!request_region(base, ports, hwif->name)) {
 		printk(" -- Error, ports in use.\n");
 		return 1;
 	}
+
 	hwif->dma_base = base;
-	if ((hwif->cds->extra) && (hwif->channel == 0)) {
-		request_region(base+16, hwif->cds->extra, hwif->cds->name);
-		hwif->dma_extra = hwif->cds->extra;
-	}
-	
+
+	if (hwif->cds->extra) {
+		hwif->extra_base = base + (hwif->channel ? 8 : 16);
+
+		if (!hwif->mate || !hwif->mate->extra_ports) {
+			if (!request_region(hwif->extra_base,
+					    hwif->cds->extra, hwif->cds->name)) {
+				printk(" -- Error, extra ports in use.\n");
+				release_region(base, ports);
+				return 1;
+			}
+			hwif->extra_ports = hwif->cds->extra;
+		}
+	}	
+
 	if(hwif->mate)
 		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;
 	else
@@ -876,6 +886,8 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 		{
 			printk(" -- Error, secondary ports in use.\n");
 			release_region(base, ports);
+			if (hwif->extra_ports)
+				release_region(hwif->extra_base, hwif->extra_ports);
 			return 1;
 		}
 	}
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index 3fdab56..029390a 100644
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
 
@@ -541,9 +541,10 @@ static void ide_hwif_restore(ide_hwif_t 
 	hwif->dma_vendor3		= tmp_hwif->dma_vendor3;
 	hwif->dma_prdtable		= tmp_hwif->dma_prdtable;
 
-	hwif->dma_extra			= tmp_hwif->dma_extra;
 	hwif->config_data		= tmp_hwif->config_data;
 	hwif->select_data		= tmp_hwif->select_data;
+	hwif->extra_base		= tmp_hwif->extra_base;
+	hwif->extra_ports		= tmp_hwif->extra_ports;
 	hwif->autodma			= tmp_hwif->autodma;
 	hwif->udma_four			= tmp_hwif->udma_four;
 	hwif->no_dsc			= tmp_hwif->no_dsc;
@@ -552,7 +553,7 @@ static void ide_hwif_restore(ide_hwif_t 
 }
 
 /**
- *	ide_unregister		-	free an ide interface
+ *	ide_unregister		-	free an IDE interface
  *	@index: index of interface (will change soon to a pointer)
  *
  *	Perform the final unregister of an IDE interface. At the moment
@@ -565,8 +566,8 @@ static void ide_hwif_restore(ide_hwif_t 
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
@@ -681,6 +682,9 @@ void ide_unregister(unsigned int index)
 		hwif->dma_status = 0;
 		hwif->dma_vendor3 = 0;
 		hwif->dma_prdtable = 0;
+
+		hwif->extra_base  = 0;
+		hwif->extra_ports = 0;
 	}
 
 	/* copy original settings */
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 8d2db41..898e102 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -775,10 +775,12 @@ typedef struct hwif_s {
 	unsigned long	dma_prdtable;	/* actual prd table address */
 	unsigned long	dma_base2;	/* extended base addr for dma ports */
 
-	unsigned	dma_extra;	/* extra addr for dma ports */
 	unsigned long	config_data;	/* for use by chipset-specific code */
 	unsigned long	select_data;	/* for use by chipset-specific code */
 
+	unsigned long	extra_base;	/* extra addr for dma ports */
+	unsigned	extra_ports;	/* number of extra dma ports */
+
 	unsigned	noprobe    : 1;	/* don't probe for this interface */
 	unsigned	present    : 1;	/* this interface exists */
 	unsigned	hold       : 1; /* this interface is always present */




--------------080105070508090105080309--
