From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] trivial IDE cleanups for 2.6.5-rc2-bk3 (1/4)
Date: Tue, 23 Mar 2004 19:39:55 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403231939.55223.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64430 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262797AbUCWSdD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Mar 2004 13:33:03 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


[IDE] ide.c: remove unused code for hwif->mmio == 1

 linux-2.6.5-rc2-bk3-root/drivers/ide/ide.c   |   26 +++++++++-----------------
 linux-2.6.5-rc2-bk3-root/include/linux/ide.h |    2 +-
 2 files changed, 10 insertions(+), 18 deletions(-)

diff -puN drivers/ide/ide.c~ide_mmio_cleanup drivers/ide/ide.c
--- linux-2.6.5-rc2-bk3/drivers/ide/ide.c~ide_mmio_cleanup	2004-03-23 19:18:37.952195272 +0100
+++ linux-2.6.5-rc2-bk3-root/drivers/ide/ide.c	2004-03-23 19:18:37.963193600 +0100
@@ -482,23 +482,14 @@ ide_proc_entry_t generic_subdriver_entri
 static struct resource* hwif_request_region(ide_hwif_t *hwif,
 					    unsigned long addr, int num)
 {
-	struct resource *res;
-
-	if (hwif->mmio)
-		res = request_mem_region(addr, num, hwif->name);
-	else
-		res = request_region(addr, num, hwif->name);
+	struct resource *res = request_region(addr, num, hwif->name);
 
 	if (!res)
-		printk(KERN_ERR "%s: %s resource 0x%lX-0x%lX not free.\n",
-				hwif->name, hwif->mmio ? "MMIO" : "I/O",
-				addr, addr+num-1);
+		printk(KERN_ERR "%s: I/O resource 0x%lX-0x%lX not free.\n",
+				hwif->name, addr, addr+num-1);
 	return res;
 }
 
-#define hwif_release_region(addr, num) \
-	((hwif->mmio) ? release_mem_region((addr),(num)) : release_region((addr),(num)))
-
 /**
  *	ide_hwif_request_regions - request resources for IDE
  *	@hwif: interface to use
@@ -515,6 +506,7 @@ int ide_hwif_request_regions(ide_hwif_t 
 
 	if (hwif->mmio == 2)
 		return 0;
+	BUG_ON(hwif->mmio == 1);
 	addr = hwif->io_ports[IDE_CONTROL_OFFSET];
 	if (addr && !hwif_request_region(hwif, addr, 1))
 		goto control_region_busy;
@@ -530,7 +522,7 @@ int ide_hwif_request_regions(ide_hwif_t 
 		addr = hwif->io_ports[i];
 		if (!hwif_request_region(hwif, addr, 1)) {
 			while (--i)
-				hwif_release_region(addr, 1);
+				release_region(addr, 1);
 			goto data_region_busy;
 		}
 	}
@@ -539,7 +531,7 @@ int ide_hwif_request_regions(ide_hwif_t 
 data_region_busy:
 	addr = hwif->io_ports[IDE_CONTROL_OFFSET];
 	if (addr)
-		hwif_release_region(addr, 1);
+		release_region(addr, 1);
 control_region_busy:
 	/* If any errors are return, we drop the hwif interface. */
 	return -EBUSY;
@@ -565,14 +557,14 @@ void ide_hwif_release_regions(ide_hwif_t
 	if (hwif->mmio == 2)
 		return;
 	if (hwif->io_ports[IDE_CONTROL_OFFSET])
-		hwif_release_region(hwif->io_ports[IDE_CONTROL_OFFSET], 1);
+		release_region(hwif->io_ports[IDE_CONTROL_OFFSET], 1);
 	if (hwif->straight8) {
-		hwif_release_region(hwif->io_ports[IDE_DATA_OFFSET], 8);
+		release_region(hwif->io_ports[IDE_DATA_OFFSET], 8);
 		return;
 	}
 	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
 		if (hwif->io_ports[i])
-			hwif_release_region(hwif->io_ports[i], 1);
+			release_region(hwif->io_ports[i], 1);
 }
 
 EXPORT_SYMBOL(ide_hwif_release_regions);
diff -puN include/linux/ide.h~ide_mmio_cleanup include/linux/ide.h
--- linux-2.6.5-rc2-bk3/include/linux/ide.h~ide_mmio_cleanup	2004-03-23 19:18:37.958194360 +0100
+++ linux-2.6.5-rc2-bk3-root/include/linux/ide.h	2004-03-23 19:18:37.967192992 +0100
@@ -932,7 +932,7 @@ typedef struct hwif_s {
 	int sg_dma_direction;		/* dma transfer direction */
 	int sg_dma_active;		/* is it in use */
 
-	int		mmio;		/* hosts iomio (0), mmio (1) or custom (2) select */
+	int		mmio;		/* hosts iomio (0) or custom (2) select */
 	int		rqsize;		/* max sectors per request */
 	int		irq;		/* our irq number */
 

_

