From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ata: dwc: add DMADEVICES dependency
Date: Wed, 11 May 2016 14:44:16 +0200
Message-ID: <1462970683-451525-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The dwc_460ex SATA driver has become available on non-powerpc architectures
and may cause randconfig build errors when CONFIG_DMADEVICES is not set:

warning: (SATA_DWC_OLD_DMA) selects DW_DMAC_CORE which has unmet direct dependencies (DMADEVICES)
ERROR: "dw_dma_probe" [drivers/ata/sata_dwc_460ex.ko] undefined!
ERROR: "dw_dma_remove" [drivers/ata/sata_dwc_460ex.ko] undefined!

This adds an explcit Kconfig dependency so we can only build
configurations that build without warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 50b433753df6 ("ata: sata_dwc_460ex: use "dmas" DT property to find dma channel")
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 41b0725e58ad..8f7a4a4d2566 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -322,7 +322,7 @@ config SATA_DWC
 
 config SATA_DWC_OLD_DMA
 	bool "Support old device trees"
-	depends on SATA_DWC
+	depends on SATA_DWC && DMADEVICES
 	select DW_DMAC_CORE
 	default y if 460EX
 	help
-- 
2.7.0
