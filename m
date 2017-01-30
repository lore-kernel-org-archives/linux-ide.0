From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v7 07/14] sata: ahci-da850: add device tree match table
Date: Mon, 30 Jan 2017 11:02:04 +0100
Message-ID: <1485770531-6772-8-git-send-email-bgolaszewski@baylibre.com>
References: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wj0-f176.google.com ([209.85.210.176]:33292 "EHLO
        mail-wj0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbdA3KCa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2017 05:02:30 -0500
Received: by mail-wj0-f176.google.com with SMTP id un2so3734596wjb.0
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2017 02:02:29 -0800 (PST)
In-Reply-To: <1485770531-6772-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Patrick Titiano <ptitiano@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Tejun Heo <tj@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, David Lechner <david@lechnology.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

We're using device tree for da850-lcdk. Add the match table to allow
to probe the driver.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/ahci_da850.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index e397bab..72126a0 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -121,11 +121,18 @@ static int ahci_da850_probe(struct platform_device *pdev)
 static SIMPLE_DEV_PM_OPS(ahci_da850_pm_ops, ahci_platform_suspend,
 			 ahci_platform_resume);
 
+static const struct of_device_id ahci_da850_of_match[] = {
+	{ .compatible = "ti,da850-ahci", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ahci_da850_of_match);
+
 static struct platform_driver ahci_da850_driver = {
 	.probe = ahci_da850_probe,
 	.remove = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = ahci_da850_of_match,
 		.pm = &ahci_da850_pm_ops,
 	},
 };
-- 
2.9.3

