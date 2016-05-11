From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] ata: dwc: add DMADEVICES dependency
Date: Wed, 11 May 2016 15:42:08 +0200
Message-ID: <1462974151-1467200-1-git-send-email-arnd@arndb.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:59101 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbcEKNmr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 May 2016 09:42:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

The dwc_460ex SATA driver has become available on non-powerpc architectures
and may cause randconfig build errors when CONFIG_DMADEVICES is not set
and SATA_DWC_OLD_DMA is enabled:

warning: (SATA_DWC_OLD_DMA) selects DW_DMAC_CORE which has unmet direct dependencies (DMADEVICES)
ERROR: "dw_dma_probe" [drivers/ata/sata_dwc_460ex.ko] undefined!
ERROR: "dw_dma_remove" [drivers/ata/sata_dwc_460ex.ko] undefined!

This adds an explcit Kconfig dependency to CONFIG_SATA_DWC so we
cannot run into broken configurations. While it would also be
possible to build the driver with both CONFIG_DMADEVICES
and SATA_DWC_OLD_DMA disabled, that case is not useful because
there is no fallback to PIO mode when the DMA engine is not
usable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 50b433753df6 ("ata: sata_dwc_460ex: use "dmas" DT property to find dma channel")
---
 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 41b0725e58ad..e2dc4c045146 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -313,6 +313,7 @@ config ATA_PIIX
 
 config SATA_DWC
 	tristate "DesignWare Cores SATA support"
+	depends on DMADEVICES
 	select GENERIC_PHY
 	help
 	  This option enables support for the on-chip SATA controller of the
-- 
2.7.0

