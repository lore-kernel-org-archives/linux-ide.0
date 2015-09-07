From: <Yuantian.Tang@freescale.com>
Subject: [PATCH 1/3] Revert "ahci: added support for Freescale AHCI sata"
Date: Mon, 7 Sep 2015 16:23:14 +0800
Message-ID: <1441614196-4284-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1on0134.outbound.protection.outlook.com ([157.56.110.134]:17248
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753327AbbIGI3G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Sep 2015 04:29:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hdegoede@redhat.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Tang Yuantian <Yuantian.Tang@freescale.com>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

This reverts commit 5163fb62541e
("ahci: added support for Freescale AHCI sata")

The reverted patch added Freescale QorIQ AHCI sata support to
ahci_platform driver though, but it left SoC specific settings to uboot.
It leads to QorIQ sata heavily depending on uboot. In order to removing
the dependency we first revert the old patch and then will add a new driver
for QorIQ SATA.
Since there are no LS* platforms that have been upstreamed, So
the revert would not break anything exists.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 --
 drivers/ata/ahci_platform.c                             | 1 -
 2 files changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index a232181..c2340ee 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -16,8 +16,6 @@ Required properties:
   - "snps,dwc-ahci"
   - "snps,exynos5440-ahci"
   - "snps,spear-ahci"
-  - "fsl,qoriq-ahci" : for qoriq series socs which include ls1021, ls2085, etc.
-  - "fsl,<chip>-ahci" : chip could be ls1021, ls2085 etc.
   - "generic-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 1befb11..04975b8 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -76,7 +76,6 @@ static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "ibm,476gtr-ahci", },
 	{ .compatible = "snps,dwc-ahci", },
 	{ .compatible = "hisilicon,hisi-ahci", },
-	{ .compatible = "fsl,qoriq-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
2.1.0.27.g96db324

