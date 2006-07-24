From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [Fwd: - ide-remove-dma_base2-field-form-ide_hwif_t.patch removed
 from -mm tree]
Date: Tue, 25 Jul 2006 00:25:50 +0400
Message-ID: <44C52CCE.7070204@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:29768 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1751428AbWGXU1I
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 16:27:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>, Jes Sorensen <jes@sgi.com>, Brent Casavant <bcasavan@sgi.com>, jpk@sgi.com
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux IDE <linux-ide@vger.kernel.org>

Hello.

    Alan and Andrew wanted me to coordinate the change with SGI before 
recasting this patch because the sgiioc4.c is the only real user of the
'dma_base2' field which the IDE maintaner wanted me to remove. The use of
this field in this driver doesn't seem necessary or even well grounded -- 
hwif_data seem to fit the task better... Will you ACK this change?

WBR, Sergei

-------- Original Message --------
Subject: - ide-remove-dma_base2-field-form-ide_hwif_t.patch removed from -mm tree
Date: Mon, 26 Jun 2006 11:19:17 -0700
From: akpm@osdl.org
To: sshtylyov@ru.mvista.com, alan@lxorguk.ukuu.org.uk,
B.Zolnierkiewicz@elka.pw.edu.pl, mm-commits@vger.kernel.org


The patch titled

      IDE: remove 'dma_base2' field form 'ide_hwif_t'

has been removed from the -mm tree.  Its filename is

      ide-remove-dma_base2-field-form-ide_hwif_t.patch

This patch was dropped because it conflicts with ide-clean-up-siimage.patch

------------------------------------------------------
Subject: IDE: remove 'dma_base2' field form 'ide_hwif_t'
From: Sergei Shtylylov <sshtylyov@ru.mvista.com>


Remove 'dma_base2' field from 'ide_hwif_t' as it's used only by 2 drivers
and without a great need.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

  drivers/ide/ide-dma.c     |   14 +-------------
  drivers/ide/pci/sgiioc4.c |   22 ++++++++++------------
  include/linux/ide.h       |    1 -
  3 files changed, 11 insertions(+), 26 deletions(-)

diff -puN drivers/ide/ide-dma.c~ide-remove-dma_base2-field-form-ide_hwif_t
drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c~ide-remove-dma_base2-field-form-ide_hwif_t
+++ a/drivers/ide/ide-dma.c
@@ -802,8 +802,6 @@ static int ide_release_iomio_dma(ide_hwi
  	release_region(hwif->dma_base, 8);
  	if (hwif->extra_ports)
  		release_region(hwif->extra_base, hwif->extra_ports);
-	if (hwif->dma_base2)
-		release_region(hwif->dma_base, 8);
  	return 1;
  }

@@ -877,19 +875,9 @@ static int ide_iomio_dma(ide_hwif_t *hwi
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

diff -puN drivers/ide/pci/sgiioc4.c~ide-remove-dma_base2-field-form-ide_hwif_t
drivers/ide/pci/sgiioc4.c
--- a/drivers/ide/pci/sgiioc4.c~ide-remove-dma_base2-field-form-ide_hwif_t
+++ a/drivers/ide/pci/sgiioc4.c
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

diff -puN drivers/ide/pci/siimage.c~ide-remove-dma_base2-field-form-ide_hwif_t
drivers/ide/pci/siimage.c
diff -puN include/linux/ide.h~ide-remove-dma_base2-field-form-ide_hwif_t
include/linux/ide.h
--- a/include/linux/ide.h~ide-remove-dma_base2-field-form-ide_hwif_t
+++ a/include/linux/ide.h
@@ -773,7 +773,6 @@ typedef struct hwif_s {
  	unsigned long	dma_status;	/* dma status register */
  	unsigned long	dma_vendor3;	/* dma vendor 3 register */
  	unsigned long	dma_prdtable;	/* actual prd table address */
-	unsigned long	dma_base2;	/* extended base addr for dma ports */

  	unsigned long	config_data;	/* for use by chipset-specific code */
  	unsigned long	select_data;	/* for use by chipset-specific code */
_

Patches currently in -mm which might be from sshtylyov@ru.mvista.com are

origin.patch
ide-actually-honor-drives-minimum-pio-dma-cycle-times.patch
ide-pdc202xx_old-remove-the-obsolete-busproc.patch
pdc202xx_old-depends-on-config_blk_dev_idedma.patch
remove-code-that-has-long-been-commented-out-from-pdc20265_old.patch
ide-clean-up-siimage.patch
ide-claim-extra-dma-ports-regardless-of-channel.patch
ide-remove-dma_base2-field-form-ide_hwif_t.patch
ide-always-release-dma-engine.patch
ide-hpt3xxn-clocking-fixes.patch
ide-fix-hpt37x-timing-tables.patch
ide-optimize-hpt37x-timing-tables.patch
ide-fix-hpt3xx-hotswap-support.patch
ide-fix-the-case-of-multiple-hpt3xx-chips-present.patch
ide-hpt3xx-fix-pci-clock-detection.patch
ide-hpt3xx-fix-pci-clock-detection-fix-2.patch
piix-fix-82371mx-enablebits.patch
piix-remove-check-for-broken-mw-dma-mode-0.patch
piix-slc90e66-pio-mode-fallback-fix.patch
ide_dma_speed-fixes.patch
hpt3xx-rework-rate-filtering.patch
hpt3xx-rework-rate-filtering-tidy.patch
hpt3xx-print-the-real-chip-name-at-startup.patch
hpt3xx-switch-to-using-pci_get_slot.patch
hpt3xx-cache-channels-mcr-address.patch
hpt3x7-merge-speedproc-handlers.patch
hpt370-clean-up-dma-timeout-handling.patch
enable-cdrom-dma-access-with-pdc20265_old.patch

