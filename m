From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/7] ide: remove CONFIG_BLK_DEV_IDEDMA_FORCED
Date: Sat, 18 Aug 2007 20:48:03 +0200
Message-ID: <200708182048.04009.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:65316 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756979AbXHRTTG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 15:19:06 -0400
Received: by fk-out-0910.google.com with SMTP id z23so797158fkz
        for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 12:19:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


This code doesn't use pci_assign_resource() and ide_get_or_set_dma_base() uses
pci_resource_start() to get DMA base address so it has no chance of working.
Moreover this belongs to PCI quirks (in case somebody would like to fix it).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig     |    8 --------
 drivers/ide/setup-pci.c |   46 +++-------------------------------------------
 2 files changed, 3 insertions(+), 51 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -435,14 +435,6 @@ config BLK_DEV_IDEDMA_PCI
 	bool
 	select BLK_DEV_IDEPCI
 
-config BLK_DEV_IDEDMA_FORCED
-	bool "Force enable legacy 2.0.X HOSTS to use DMA"
-	depends on BLK_DEV_IDEDMA_PCI
-	help
-	  This is an old piece of lost code from Linux 2.0 Kernels.
-
-	  Generally say N here.
-
 # TODO: remove it
 config IDEDMA_ONLYDISK
 	bool "Enable DMA only for disks "
Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -145,27 +145,13 @@ static int ide_setup_pci_baseregs (struc
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
-
-#ifdef CONFIG_BLK_DEV_IDEDMA_FORCED
-/*
- * Long lost data from 2.0.34 that is now in 2.0.39
- *
- * This was used in ./drivers/block/triton.c to do DMA Base address setup
- * when PnP failed.  Oh the things we forget.  I believe this was part
- * of SFF-8038i that has been withdrawn from public access... :-((
- */
-#define DEFAULT_BMIBA	0xe800	/* in case BIOS did not init it */
-#define DEFAULT_BMCRBA	0xcc00	/* VIA's default value */
-#define DEFAULT_BMALIBA	0xd400	/* ALI's default value */
-#endif /* CONFIG_BLK_DEV_IDEDMA_FORCED */
-
 /**
  *	ide_get_or_set_dma_base		-	setup BMIBA
  *	@hwif: Interface
  *
- *	Fetch the DMA Bus-Master-I/O-Base-Address (BMIBA) from PCI space:
- *	If need be we set up the DMA base. Where a device has a partner that
- *	is already in DMA mode we check and enforce IDE simplex rules.
+ *	Fetch the DMA Bus-Master-I/O-Base-Address (BMIBA) from PCI space.
+ *	Where a device has a partner that is already in DMA mode we check
+ *	and enforce IDE simplex rules.
  */
 
 static unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif)
@@ -173,12 +159,6 @@ static unsigned long ide_get_or_set_dma_
 	unsigned long	dma_base = 0;
 	struct pci_dev	*dev = hwif->pci_dev;
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_FORCED
-	int second_chance = 0;
-
-second_chance_to_dma:
-#endif /* CONFIG_BLK_DEV_IDEDMA_FORCED */
-
 	if (hwif->mmio)
 		return hwif->dma_base;
 
@@ -192,26 +172,6 @@ second_chance_to_dma:
 		}
 	}
 
-#ifdef CONFIG_BLK_DEV_IDEDMA_FORCED
-	/* FIXME - should use pci_assign_resource surely */
-	if ((!dma_base) && (!second_chance)) {
-		unsigned long set_bmiba = 0;
-		second_chance++;
-		switch(dev->vendor) {
-			case PCI_VENDOR_ID_AL:
-				set_bmiba = DEFAULT_BMALIBA; break;
-			case PCI_VENDOR_ID_VIA:
-				set_bmiba = DEFAULT_BMCRBA; break;
-			case PCI_VENDOR_ID_INTEL:
-				set_bmiba = DEFAULT_BMIBA; break;
-			default:
-				return dma_base;
-		}
-		pci_write_config_dword(dev, 0x20, set_bmiba|1);
-		goto second_chance_to_dma;
-	}
-#endif /* CONFIG_BLK_DEV_IDEDMA_FORCED */
-
 	if (dma_base) {
 		u8 simplex_stat = 0;
 		dma_base += hwif->channel ? 8 : 0;
