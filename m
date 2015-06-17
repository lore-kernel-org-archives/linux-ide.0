From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] ata: ahci_mvebu: add suspend/resume support
Date: Wed, 17 Jun 2015 14:11:01 +0200
Message-ID: <1434543061-3066-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57709 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755020AbbFQMLO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jun 2015 08:11:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

This commit adds suspend/resume support to the ahci_mvebu driver. The
suspend hook doesn't do anything special despite calling the generic
ahci_platform_suspend_host() function. However, the resume hook has to
restore the MBus windows configuration, as well as the regret option.

Tested on Marvell Armada 388 GP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/ata/ahci_mvebu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 5928d07..8490d37 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -62,6 +62,26 @@ static void ahci_mvebu_regret_option(struct ahci_host_priv *hpriv)
 	writel(0x80, hpriv->mmio + AHCI_VENDOR_SPECIFIC_0_DATA);
 }
 
+static int ahci_mvebu_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	return ahci_platform_suspend_host(&pdev->dev);
+}
+
+static int ahci_mvebu_resume(struct platform_device *pdev)
+{
+	struct ata_host *host = platform_get_drvdata(pdev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	const struct mbus_dram_target_info *dram;
+
+	dram = mv_mbus_dram_info();
+	if (dram)
+		ahci_mvebu_mbus_config(hpriv, dram);
+
+	ahci_mvebu_regret_option(hpriv);
+
+	return ahci_platform_resume_host(&pdev->dev);
+}
+
 static const struct ata_port_info ahci_mvebu_port_info = {
 	.flags	   = AHCI_FLAG_COMMON,
 	.pio_mask  = ATA_PIO4,
@@ -120,6 +140,8 @@ MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
 static struct platform_driver ahci_mvebu_driver = {
 	.probe = ahci_mvebu_probe,
 	.remove = ata_platform_remove_one,
+	.suspend = ahci_mvebu_suspend,
+	.resume = ahci_mvebu_resume,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_mvebu_of_match,
-- 
2.1.0

