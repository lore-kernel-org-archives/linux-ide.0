From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] sata_dwc_460ex: enable COMPILE_TEST for the driver
Date: Wed,  7 Jan 2015 15:24:21 +0200
Message-ID: <1420637062-15450-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1420637062-15450-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20927 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753058AbbAGNYq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jan 2015 08:24:46 -0500
In-Reply-To: <1420637062-15450-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Miesfeld <mmiesfeld@amcc.com>, Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

To test how the driver could be compiled in the non-native environment let's
enable COMPILE_TEST for it. It would be useful for further work.

This patch enables COMPILE_TEST for the driver and fixes compilation errors on
at least x86 platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/Kconfig          |  2 +-
 drivers/ata/sata_dwc_460ex.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a3a1360..5ed20e3 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -269,7 +269,7 @@ config ATA_PIIX
 
 config SATA_DWC
 	tristate "DesignWare Cores SATA support"
-	depends on 460EX
+	depends on 460EX || COMPILE_TEST
 	help
 	  This option enables support for the on-chip SATA controller of the
 	  AppliedMicro processor 460EX.
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 5c34395..c1723e0 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -48,6 +48,18 @@
 #define DRV_NAME        "sata-dwc"
 #define DRV_VERSION     "1.3"
 
+#ifndef out_le32
+#define out_le32(a, v)	__raw_writel(__cpu_to_le32(v), (void __iomem *)(a))
+#endif
+
+#ifndef in_le32
+#define in_le32(a)	__le32_to_cpu(__raw_readl((void __iomem *)(a)))
+#endif
+
+#ifndef NO_IRQ
+#define NO_IRQ		0
+#endif
+
 /* SATA DMA driver Globals */
 #define DMA_NUM_CHANS		1
 #define DMA_NUM_CHAN_REGS	8
-- 
2.1.3

