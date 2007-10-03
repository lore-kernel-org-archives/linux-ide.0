From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 11/15] ide: PCI BMDMA initialization fixes
Date: Wed, 3 Oct 2007 23:59:32 +0200
Message-ID: <200710032359.32630.bzolnier@gmail.com>
References: <200710012338.31404.bzolnier@gmail.com> <47039571.20907@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:28895 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715AbXJCWhp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 18:37:45 -0400
Received: by fk-out-0910.google.com with SMTP id z23so4821056fkz
        for <linux-ide@vger.kernel.org>; Wed, 03 Oct 2007 15:37:43 -0700 (PDT)
In-Reply-To: <47039571.20907@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 03 October 2007, Sergei Shtylyov wrote:
> Hello.
> 
> Bartlomiej Zolnierkiewicz wrote:
> 
> > * Set hwif->dma_base only if allocation of extra ports succeeds.
> 
> > * Allocate hwif->dmatable_cpu before reserving I/O ports.
> 
>     Looks like a bit of teardown code was missed with that change...

Thanks for catching this!

Actually it turns out that the whole change was based on a thinko. :)

> > While at it:
> 
> > * Move setting of hwif->dma_{base,master} from ide_{mapped_mmio,iomio}_dma()
> >   to ide_setup_dma().
> 
> > * Rename 'dma_base' argument to 'base' in ide_setup_dma().
> 
>     I'm not sure what that achieves...

Makes the code obey 80-columns limit and increases its readability :)

Revised patch follows...


[PATCH] ide: PCI BMDMA initialization fixes (take 2)

* Set hwif->dma_base only if allocation of extra ports succeeds.

While at it:

* Move setting of hwif->dma_{base,master} from ide_{mapped_mmio,iomio}_dma()
  to ide_setup_dma().

* Rename 'dma_base' argument to 'base' in ide_setup_dma() (to make the code
  obey 80-columns limit and increase its readability).

* Remove stale ide_setup_dma() comment.

v2:
* Change to allocate hwif->dmatable_cpu before reserving I/O ports missed
  teardown code (spotted by Sergei).  On the second thought this change is
  actually unnecessary so revert it in v2.

* Make ide_release_dma_engine() void and remove needless comment.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |   32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -901,10 +901,7 @@ void ide_dma_timeout (ide_drive_t *drive
 
 EXPORT_SYMBOL(ide_dma_timeout);
 
-/*
- * Needed for allowing full modular support of ide-driver
- */
-static int ide_release_dma_engine(ide_hwif_t *hwif)
+static void ide_release_dma_engine(ide_hwif_t *hwif)
 {
 	if (hwif->dmatable_cpu) {
 		pci_free_consistent(hwif->pci_dev,
@@ -913,7 +910,6 @@ static int ide_release_dma_engine(ide_hw
 				    hwif->dmatable_dma);
 		hwif->dmatable_cpu = NULL;
 	}
-	return 1;
 }
 
 static int ide_release_iomio_dma(ide_hwif_t *hwif)
@@ -956,12 +952,6 @@ static int ide_mapped_mmio_dma(ide_hwif_
 {
 	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
 
- 	hwif->dma_base = base;
-
-	if(hwif->mate)
-		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;
-	else
-		hwif->dma_master = base;
 	return 0;
 }
 
@@ -975,8 +965,6 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 		return 1;
 	}
 
-	hwif->dma_base = base;
-
 	if (hwif->cds->extra) {
 		hwif->extra_base = base + (hwif->channel ? 8 : 16);
 
@@ -991,10 +979,6 @@ static int ide_iomio_dma(ide_hwif_t *hwi
 		}
 	}
 
-	if(hwif->mate)
-		hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base:base;
-	else
-		hwif->dma_master = base;
 	return 0;
 }
 
@@ -1006,12 +990,9 @@ static int ide_dma_iobase(ide_hwif_t *hw
 	return ide_iomio_dma(hwif, base, ports);
 }
 
-/*
- * This can be called for a dynamically installed interface. Don't __init it
- */
-void ide_setup_dma (ide_hwif_t *hwif, unsigned long dma_base, unsigned int num_ports)
+void ide_setup_dma(ide_hwif_t *hwif, unsigned long base, unsigned num_ports)
 {
-	if (ide_dma_iobase(hwif, dma_base, num_ports))
+	if (ide_dma_iobase(hwif, base, num_ports))
 		return;
 
 	if (ide_allocate_dma_engine(hwif)) {
@@ -1019,6 +1000,13 @@ void ide_setup_dma (ide_hwif_t *hwif, un
 		return;
 	}
 
+	hwif->dma_base = base;
+
+	if (hwif->mate)
+		hwif->dma_master = hwif->channel ? hwif->mate->dma_base : base;
+	else
+		hwif->dma_master = base;
+
 	if (!(hwif->dma_command))
 		hwif->dma_command	= hwif->dma_base;
 	if (!(hwif->dma_vendor1))

