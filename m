From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH 2/3] ata: sata_dwc_460ex: add phy support
Date: Tue, 15 Dec 2015 23:25:33 +0000
Message-ID: <1450221935-6034-2-git-send-email-mans@mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:41858 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083AbbLOX00 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Dec 2015 18:26:26 -0500
In-Reply-To: <1450221935-6034-1-git-send-email-mans@mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This adds support for powering on an optional PHY when activating the
device.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/Kconfig          |  1 +
 drivers/ata/sata_dwc_460ex.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 193c673..b13c609 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -296,6 +296,7 @@ config ATA_PIIX
 
 config SATA_DWC
 	tristate "DesignWare Cores SATA support"
+	select GENERIC_PHY
 	help
 	  This option enables support for the on-chip SATA controller of the
 	  AppliedMicro processor 460EX.
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 9985749..d07aae1 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -35,6 +35,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/phy/phy.h>
 #include <linux/libata.h>
 #include <linux/slab.h>
 
@@ -145,6 +146,7 @@ struct sata_dwc_device {
 	struct ata_host		*host;
 	u8 __iomem		*reg_base;
 	struct sata_dwc_regs	*sata_dwc_regs;	/* DW Synopsys SATA specific */
+	struct phy		*phy;
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	struct dw_dma_chip	*dma;
 #endif
@@ -1318,6 +1320,21 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	}
 #endif
 
+	hsdev->phy = devm_phy_optional_get(hsdev->dev, "sata-phy");
+	if (IS_ERR(hsdev->phy)) {
+		err = PTR_ERR(hsdev->phy);
+		hsdev->phy = NULL;
+		goto error_out;
+	}
+
+	err = phy_init(hsdev->phy);
+	if (err)
+		goto error_out;
+
+	err = phy_power_on(hsdev->phy);
+	if (err)
+		goto error_out;
+
 	/*
 	 * Now, register with libATA core, this will also initiate the
 	 * device discovery process, invoking our port_start() handler &
@@ -1331,6 +1348,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	return 0;
 
 error_out:
+	phy_exit(hsdev->phy);
 	iounmap(base);
 	return err;
 }
@@ -1343,6 +1361,9 @@ static int sata_dwc_remove(struct platform_device *ofdev)
 
 	ata_host_detach(host);
 
+	phy_power_off(hsdev->phy);
+	phy_exit(hsdev->phy);
+
 #ifdef CONFIG_SATA_DWC_OLD_DMA
 	/* Free SATA DMA resources */
 	if (hsdev->dma) {
-- 
2.6.3

