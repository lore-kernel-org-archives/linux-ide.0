From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Subject: [BK PATCHES] ide-2.6 update
Date: Thu, 23 Sep 2004 20:49:06 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200409232049.06435.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:5335 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S268212AbUIWSt2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Sep 2004 14:49:28 -0400
Received: from hadron.elka.pw.edu.pl ([194.29.160.13]:54732 "EHLO localhost")
	by higgs.elka.pw.edu.pl with ESMTP id S53559AbUIWSt0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Sep 2004 20:49:26 +0200
Received: from chello062179083169.chello.pl ([62.179.83.169]:63977 "EHLO
	[192.168.123.164]" ident: "NO-IDENT-SERVICE[2]" smtp-auth: "bzolnier"
	TLS-CIPHER: <none> TLS-PEER-CN1: <none>) by mion.elka.pw.edu.pl
	with ESMTP id S73801AbUIWSrc (ORCPT
	<rfc822;linux-ide@vger.kernel.org> + 1 other);
	Thu, 23 Sep 2004 20:47:32 +0200
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org


Please do a

	bk pull bk://bart.bkbits.net/ide-2.6

This will update the following files:

 drivers/ide/arm/icside.c  |    5 ---
 drivers/ide/ide-dma.c     |    5 ---
 drivers/ide/pci/amd74xx.c |    3 ++
 drivers/ide/pci/hpt34x.c  |   68 ----------------------------------------------
 drivers/ide/pci/hpt34x.h  |    2 -
 drivers/ide/pci/sgiioc4.c |    1 
 drivers/ide/ppc/pmac.c    |    5 ---
 include/linux/ide.h       |    1 
 8 files changed, 3 insertions(+), 87 deletions(-)

through these ChangeSets:

<bzolnier@trik.(none)> (04/09/23 1.1939.8.3)
   [ide] amd74xx: don't probe for IRQs
   
   From: Nicholas Reilly <nreilly@magma.ca>
   
   I have a Shuttle SN41G2 and the secondary IDE channel alternates between
   IRQ 15 (correct) and IRQ 7 (causing failures accessing the DVD+-RW which is
   master, no slave and also messing with the parallel port if it is enabled)
   on each boot.  This is running ACPI and APIC on 2.6.5, 2.6.7 and 2.6.8. 
   dmesg, dmidecode and /proc/acpi/dsdt are all identical (apart from dmesg
   printing of IRQ and errors it causes) regardless of whether it decides to
   go on 7 or 15.  It is now running the latest BIOS, earlier BIOS did the
   same.
   
   bart: IRQ auto-detection sometimes fails and gets "screaming" IRQ
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

<bzolnier@trik.(none)> (04/09/22 1.1939.8.2)
   [ide] remove ide_hwif_t->sg_dma_active
   
   It is always equal to zero.
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

<bzolnier@trik.(none)> (04/09/22 1.1939.8.1)
   [ide] hpt34x: remove dead /proc/ide/hpt34x code
   
   Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

diff -Nru a/drivers/ide/arm/icside.c b/drivers/ide/arm/icside.c
--- a/drivers/ide/arm/icside.c	2004-09-23 20:43:23 +02:00
+++ b/drivers/ide/arm/icside.c	2004-09-23 20:43:23 +02:00
@@ -215,8 +215,6 @@
 	struct scatterlist *sg = hwif->sg_table;
 	int nents;
 
-	BUG_ON(hwif->sg_dma_active);
-
 	if (rq->flags & REQ_DRIVE_TASKFILE) {
 		ide_task_t *args = rq->special;
 
@@ -401,8 +399,6 @@
 	dma_unmap_sg(state->dev, hwif->sg_table, hwif->sg_nents,
 		     hwif->sg_dma_direction);
 
-	hwif->sg_dma_active = 0;
-
 	return get_dma_residue(hwif->hw.dma) != 0;
 }
 
@@ -454,7 +450,6 @@
 	/*
 	 * We can not enable DMA on both channels.
 	 */
-	BUG_ON(hwif->sg_dma_active);
 	BUG_ON(dma_channel_active(hwif->hw.dma));
 
 	icside_build_sglist(drive, rq);
diff -Nru a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2004-09-23 20:43:23 +02:00
+++ b/drivers/ide/ide-dma.c	2004-09-23 20:43:23 +02:00
@@ -208,9 +208,6 @@
 	struct scatterlist *sg = hwif->sg_table;
 	int nents;
 
-	if (hwif->sg_dma_active)
-		BUG();
-
 	nents = blk_rq_map_sg(drive->queue, rq, hwif->sg_table);
 		
 	if (rq_data_dir(rq) == READ)
@@ -366,7 +363,6 @@
 		     hwif->sg_table,
 		     hwif->sg_nents,
 		     hwif->sg_dma_direction);
-	hwif->sg_dma_active = 0;
 	return 0; /* revert to PIO for this request */
 }
 
@@ -390,7 +386,6 @@
 	int nents = HWIF(drive)->sg_nents;
 
 	pci_unmap_sg(dev, sg, nents, HWIF(drive)->sg_dma_direction);
-	HWIF(drive)->sg_dma_active = 0;
 }
 
 EXPORT_SYMBOL_GPL(ide_destroy_dmatable);
diff -Nru a/drivers/ide/pci/amd74xx.c b/drivers/ide/pci/amd74xx.c
--- a/drivers/ide/pci/amd74xx.c	2004-09-23 20:43:23 +02:00
+++ b/drivers/ide/pci/amd74xx.c	2004-09-23 20:43:23 +02:00
@@ -416,6 +416,9 @@
 {
 	int i;
 
+	if (!hwif->irq)
+		hwif->irq = hwif->channel ? 15 : 14;
+
 	hwif->autodma = 0;
 
 	hwif->tuneproc = &amd74xx_tune_drive;
diff -Nru a/drivers/ide/pci/hpt34x.c b/drivers/ide/pci/hpt34x.c
--- a/drivers/ide/pci/hpt34x.c	2004-09-23 20:43:23 +02:00
+++ b/drivers/ide/pci/hpt34x.c	2004-09-23 20:43:23 +02:00
@@ -44,65 +44,6 @@
 
 #include "hpt34x.h"
 
-#if defined(DISPLAY_HPT34X_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 hpt34x_proc = 0;
-
-#define HPT34X_MAX_DEVS		8
-static struct pci_dev *hpt34x_devs[HPT34X_MAX_DEVS];
-static int n_hpt34x_devs;
-
-static int hpt34x_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	int i, len;
-
-	p += sprintf(p, "\n                             "
-			"HPT34X Chipset.\n");
-	for (i = 0; i < n_hpt34x_devs; i++) {
-		struct pci_dev *dev = hpt34x_devs[i];
-		unsigned long bibma = pci_resource_start(dev, 4);
-		u8  c0 = 0, c1 = 0;
-
-		/*
-		 * at that point bibma+0x2 et bibma+0xa are byte registers
-		 * to investigate:
-		 */
-		c0 = inb_p((u16)bibma + 0x02);
-		c1 = inb_p((u16)bibma + 0x0a);
-		p += sprintf(p, "\nController: %d\n", i);
-		p += sprintf(p, "--------------- Primary Channel "
-				"---------------- Secondary Channel "
-				"-------------\n");
-		p += sprintf(p, "                %sabled "
-				"                        %sabled\n",
-				(c0&0x80) ? "dis" : " en",
-				(c1&0x80) ? "dis" : " en");
-		p += sprintf(p, "--------------- drive0 --------- drive1 "
-				"-------- drive0 ---------- drive1 ------\n");
-		p += sprintf(p, "DMA enabled:    %s              %s"
-				"             %s               %s\n",
-				(c0&0x20) ? "yes" : "no ",
-				(c0&0x40) ? "yes" : "no ",
-				(c1&0x20) ? "yes" : "no ",
-				(c1&0x40) ? "yes" : "no " );
-
-		p += sprintf(p, "UDMA\n");
-		p += sprintf(p, "DMA\n");
-		p += sprintf(p, "PIO\n");
-	}
-	p += sprintf(p, "\n");
-
-	/* p - buffer must be less than 4k! */
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-	
-	return len > count ? count : len;
-}
-#endif  /* defined(DISPLAY_HPT34X_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 static u8 hpt34x_ratemask (ide_drive_t *drive)
 {
 	return 1;
@@ -276,15 +217,6 @@
 	pci_write_config_word(dev, PCI_COMMAND, cmd);
 
 	local_irq_restore(flags);
-
-#if defined(DISPLAY_HPT34X_TIMINGS) && defined(CONFIG_PROC_FS)
-	hpt34x_devs[n_hpt34x_devs++] = dev;
-
-	if (!hpt34x_proc) {
-		hpt34x_proc = 1;
-		ide_pci_create_host_proc("hpt34x", hpt34x_get_info);
-	}
-#endif /* DISPLAY_HPT34X_TIMINGS && CONFIG_PROC_FS */
 
 	return dev->irq;
 }
diff -Nru a/drivers/ide/pci/hpt34x.h b/drivers/ide/pci/hpt34x.h
--- a/drivers/ide/pci/hpt34x.h	2004-09-23 20:43:23 +02:00
+++ b/drivers/ide/pci/hpt34x.h	2004-09-23 20:43:23 +02:00
@@ -11,8 +11,6 @@
 #define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
 #endif
 
-#undef DISPLAY_HPT34X_TIMINGS
-
 static unsigned int init_chipset_hpt34x(struct pci_dev *, const char *);
 static void init_hwif_hpt34x(ide_hwif_t *);
 
diff -Nru a/drivers/ide/pci/sgiioc4.c b/drivers/ide/pci/sgiioc4.c
--- a/drivers/ide/pci/sgiioc4.c	2004-09-23 20:43:23 +02:00
+++ b/drivers/ide/pci/sgiioc4.c	2004-09-23 20:43:23 +02:00
@@ -570,7 +570,6 @@
 use_pio_instead:
 	pci_unmap_sg(hwif->pci_dev, hwif->sg_table, hwif->sg_nents,
 		     hwif->sg_dma_direction);
-	hwif->sg_dma_active = 0;
 
 	return 0;		/* revert to PIO for this request */
 }
diff -Nru a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c	2004-09-23 20:43:23 +02:00
+++ b/drivers/ide/ppc/pmac.c	2004-09-23 20:43:23 +02:00
@@ -1578,9 +1578,6 @@
 	struct scatterlist *sg = pmif->sg_table;
 	int nents;
 
-	if (hwif->sg_dma_active)
-		BUG();
-		
 	nents = blk_rq_map_sg(drive->queue, rq, sg);
 		
 	if (rq_data_dir(rq) == READ)
@@ -1715,7 +1712,6 @@
 		     pmif->sg_table,
 		     pmif->sg_nents,
 		     pmif->sg_dma_direction);
-	hwif->sg_dma_active = 0;
 	return 0; /* revert to PIO for this request */
 }
 
@@ -1731,7 +1727,6 @@
 	if (nents) {
 		pci_unmap_sg(dev, sg, nents, pmif->sg_dma_direction);
 		pmif->sg_nents = 0;
-		HWIF(drive)->sg_dma_active = 0;
 	}
 }
 
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2004-09-23 20:43:23 +02:00
+++ b/include/linux/ide.h	2004-09-23 20:43:23 +02:00
@@ -929,7 +929,6 @@
 	struct scatterlist *sg_table;
 	int sg_nents;			/* Current number of entries in it */
 	int sg_dma_direction;		/* dma transfer direction */
-	int sg_dma_active;		/* is it in use */
 
 	/* data phase of the active command (currently only valid for PIO/DMA) */
 	int		data_phase;
