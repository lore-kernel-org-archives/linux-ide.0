From: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH] ata: fix kconfig selection warning
Date: Tue, 15 Apr 2014 13:50:55 -0400
Message-ID: <1397584255-15038-1-git-send-email-pefoley2@pefoley.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:33404 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaDORvb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2014 13:51:31 -0400
Received: by mail-qc0-f173.google.com with SMTP id r5so10617655qcx.4
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2014 10:51:30 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Foley <pefoley2@pefoley.com>, tj@kernel.org, linux-ide@vger.kernel.org

When building with COMPILE_TEST, AHCI_XGENE is enabled even though
PHY_XGENE (which it selects) requires OF to be enabled.
Fix this by adding a dependency on OF to AHCI_XGENE.

warning: (AHCI_XGENE) selects PHY_XGENE which has unmet direct
dependencies (HAS_IOMEM && OF && (ARM64 || COMPILE_TEST))

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 20e03a7..071f399 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -134,7 +134,7 @@ config AHCI_SUNXI
 
 config AHCI_XGENE
 	tristate "APM X-Gene 6.0Gbps AHCI SATA host controller support"
-	depends on ARM64 || COMPILE_TEST
+	depends on OF && (ARM64 || COMPILE_TEST)
 	select PHY_XGENE
 	help
 	 This option enables support for APM X-Gene SoC SATA host controller.
-- 
1.9.2

