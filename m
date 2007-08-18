From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/7] ide: remove CONFIG_IDEDMA_ONLYDISK
Date: Sat, 18 Aug 2007 20:51:26 +0200
Message-ID: <200708182051.26177.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:65316 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757016AbXHRTTL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Aug 2007 15:19:11 -0400
Received: by fk-out-0910.google.com with SMTP id z23so797158fkz
        for <linux-ide@vger.kernel.org>; Sat, 18 Aug 2007 12:19:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


ATAPI devices with broken DMA support should be handled by DMA blacklist
and for debugging purposes we have new shiny "hdx=nodma" kernel paremeter.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig     |   10 ----------
 drivers/ide/ide-probe.c |    5 +----
 2 files changed, 1 insertion(+), 14 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -435,16 +435,6 @@ config BLK_DEV_IDEDMA_PCI
 	bool
 	select BLK_DEV_IDEPCI
 
-# TODO: remove it
-config IDEDMA_ONLYDISK
-	bool "Enable DMA only for disks "
-	depends on BLK_DEV_IDEDMA_PCI
-	help
-	  This is used if you know your ATAPI Devices are going to fail DMA
-	  Transfers.
-
-	  Generally say N here.
-
 config BLK_DEV_AEC62XX
 	tristate "AEC62XX chipset support"
 	select BLK_DEV_IDEDMA_PCI
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -843,10 +843,7 @@ static void probe_hwif(ide_hwif_t *hwif,
 				 *   PARANOIA!!!
 				 */
 				hwif->dma_off_quietly(drive);
-#ifdef CONFIG_IDEDMA_ONLYDISK
-				if (drive->media == ide_disk)
-#endif
-					ide_set_dma(drive);
+				ide_set_dma(drive);
 			}
 		}
 	}
