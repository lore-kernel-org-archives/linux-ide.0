From: Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 1/7] IBM Akebono: Add support to AHCI platform driver
Date: Tue,  5 Nov 2013 16:31:05 +1100
Message-ID: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:36205 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751006Ab3KEFb3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Nov 2013 00:31:29 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>, linux-ide@vger.kernel.org

The new IBM Akebono board has an AHCI compliant SATA controller. This
patch adds a compatible property for the new board to the AHCI
platform driver.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/ahci_platform.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 7d3b853..b20b130 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -328,6 +328,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_suspend, ahci_resume);
 static const struct of_device_id ahci_of_match[] = {
 	{ .compatible = "snps,spear-ahci", },
 	{ .compatible = "snps,exynos5440-ahci", },
+	{ .compatible = "ibm,akebono-ahci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_of_match);
-- 
1.7.10.4

