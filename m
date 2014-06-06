From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH] libahci_platform: Fail when PHY required but PHY support disabled
Date: Fri, 6 Jun 2014 10:45:49 +0300
Message-ID: <1402040749-14464-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16242 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbaFFHqR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jun 2014 03:46:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, swarren@wwwdotorg.org, Mikko Perttunen <mperttunen@nvidia.com>

ahci_platform_get_resources handles resource management for
platform AHCI drivers, including getting a possible PHY
from the device tree. Since not all drivers need a PHY, it
ignores -ENODEV and -ENOSYS from devm_get_phy. However, when
the PHY subsystem is mistakenly disabled, -ENOSYS can be
returned even when a PHY is needed.

This patch modifies the -ENOSYS case to check if a "phys"
device tree node exists. If it exists, then clearly the PHY
subsystem is mistakenly disabled and the driver cannot work,
ahci_platform_get_resources will fail and propagate the error.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/ata/libahci_platform.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 3a5b4ed..b007758 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -250,8 +250,13 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 	if (IS_ERR(hpriv->phy)) {
 		rc = PTR_ERR(hpriv->phy);
 		switch (rc) {
-		case -ENODEV:
 		case -ENOSYS:
+			/* No PHY support. Check if PHY is required. */
+			if (of_find_property(dev->of_node, "phys", NULL)) {
+				dev_err(dev, "couldn't get sata-phy: ENOSYS\n");
+				goto err_out;
+			}
+		case -ENODEV:
 			/* continue normally */
 			hpriv->phy = NULL;
 			break;
-- 
1.8.1.5

