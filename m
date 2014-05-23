From: <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/1] ata: Check and set 64-bit DMA mask for platform AHCI driver
Date: Fri, 23 May 2014 12:35:10 -0500
Message-ID: <1400866510-3130-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1blp0190.outbound.protection.outlook.com ([207.46.163.190]:39034
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751050AbaEWRfQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 May 2014 13:35:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

The current platform AHCI drier does not set the dma_mask correctly
for 64-bit DMA capable AHCI controller.  This patch checks the AHCI
capability bit and set the dma_mask and coherent_dma_mask accordingly.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/ata/libahci_platform.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 7cb3a85..85049ef 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -368,6 +368,15 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	ahci_init_controller(host);
 	ahci_print_info(host, "platform");
 
+	if (hpriv->cap & HOST_CAP_64) {
+		if (!dev->dma_mask)
+			dev->dma_mask = &dev->coherent_dma_mask;
+
+		rc = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+		if (rc)
+			return rc;
+	}
+
 	return ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
 				 &ahci_platform_sht);
 }
-- 
1.9.0

