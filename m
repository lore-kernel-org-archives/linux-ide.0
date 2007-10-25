From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] ide: remove CONFIG_IDEPCI_SHARE_IRQ config option
Date: Fri, 26 Oct 2007 01:38:06 +0200
Message-ID: <200710260138.06815.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:1958 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759264AbXJYXdn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 19:33:43 -0400
Received: by nf-out-0910.google.com with SMTP id g13so631752nfb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 16:33:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Now that drive_is_ready() has been fixed for non-PCI hosts we can safely
remove CONFIG_IDEPCI_SHARE_IRQ and always support PCI IRQ sharing.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig    |   12 ------------
 drivers/ide/ide-iops.c |    2 --
 2 files changed, 14 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -366,17 +366,6 @@ comment "PCI IDE chipsets support"
 config BLK_DEV_IDEPCI
 	bool
 
-config IDEPCI_SHARE_IRQ
-	bool "Sharing PCI IDE interrupts support"
-	depends on BLK_DEV_IDEPCI
-	help
-	  Some ATA/IDE chipsets have hardware support which allows for
-	  sharing a single IRQ with other cards. To enable support for
-	  this in the ATA/IDE driver, say Y here.
-
-	  It is safe to say Y to this question, in most cases.
-	  If unsure, say N.
-
 config IDEPCI_PCIBUS_ORDER
 	def_bool BLK_DEV_IDE=y && BLK_DEV_IDEPCI
 
@@ -693,7 +682,6 @@ config BLK_DEV_SVWKS
 config BLK_DEV_SGIIOC4
 	tristate "Silicon Graphics IOC4 chipset ATA/ATAPI support"
 	depends on (IA64_SGI_SN2 || IA64_GENERIC) && SGI_IOC4
-	select IDEPCI_SHARE_IRQ
 	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds PIO & MultiMode DMA-2 support for the SGI IOC4
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -448,7 +448,6 @@ int drive_is_ready (ide_drive_t *drive)
 	udelay(1);
 #endif
 
-#ifdef CONFIG_IDEPCI_SHARE_IRQ
 	/*
 	 * We do a passive status test under shared PCI interrupts on
 	 * cards that truly share the ATA side interrupt, but may also share
@@ -458,7 +457,6 @@ int drive_is_ready (ide_drive_t *drive)
 	if (hwif->pci_dev && IDE_CONTROL_REG)
 		stat = hwif->INB(IDE_ALTSTATUS_REG);
 	else
-#endif /* CONFIG_IDEPCI_SHARE_IRQ */
 		/* Note: this may clear a pending IRQ!! */
 		stat = hwif->INB(IDE_STATUS_REG);
 
