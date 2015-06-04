From: <Yuantian.Tang@freescale.com>
Subject: [PATCH] ahci: added support for Freescale AHCI sata
Date: Thu, 4 Jun 2015 15:10:04 +0800
Message-ID: <1433401804-21524-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bon0113.outbound.protection.outlook.com ([157.56.111.113]:57664
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750868AbbFDH3T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Jun 2015 03:29:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hdegoede@redhat.com
Cc: tj@kernel.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Tang Yuantian <Yuantian.Tang@freescale.com>, Shaohui Xie <Shaohui.Xie@freescale.com>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

Freescale introduced QorIQ series SOCs, like ls1021 ls2085, with AHCI
sata support. It complies with the serial ATA 3.0 specification
and the AHCI 1.3 specification.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Yuantian Tang <Yuantian.Tang@freescale.com>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
 drivers/ata/ahci_platform.c                             | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index c2340ee..a232181 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -16,6 +16,8 @@ Required properties:
   - "snps,dwc-ahci"
   - "snps,exynos5440-ahci"
   - "snps,spear-ahci"
+  - "fsl,qoriq-ahci" : for qoriq series socs which include ls1021, ls2085, etc.
+  - "fsl,<chip>-ahci" : chip could be ls1021, ls2085 etc.
   - "generic-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 78d6ae0..614c78f 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -74,6 +74,7 @@ static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "ibm,476gtr-ahci", },
 	{ .compatible = "snps,dwc-ahci", },
 	{ .compatible = "hisilicon,hisi-ahci", },
+	{ .compatible = "fsl,qoriq-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
2.1.0.27.g96db324

