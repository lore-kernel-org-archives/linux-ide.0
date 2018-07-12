From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 2/3] ata: ahci_platform: convert kzallloc to kcalloc
Date: Thu, 12 Jul 2018 11:41:30 +0000
Message-ID: <1531395691-4653-3-git-send-email-clabbe@baylibre.com>
References: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

It's better to kcalloc instead of kzalloc(n * sizeof())

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/libahci_platform.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 70052c046559..be9f54423a9b 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -351,7 +351,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	struct clk *clk;
 	struct device_node *child;
-	int i, sz, enabled_ports = 0, rc = -ENOMEM, child_nodes;
+	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
 	u32 mask_port_map = 0;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
@@ -403,14 +403,12 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 	if (!child_nodes)
 		hpriv->nports = 1;
 
-	sz = hpriv->nports * sizeof(*hpriv->phys);
-	hpriv->phys = devm_kzalloc(dev, sz, GFP_KERNEL);
+	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
 	if (!hpriv->phys) {
 		rc = -ENOMEM;
 		goto err_out;
 	}
-	sz = hpriv->nports * sizeof(*hpriv->target_pwrs);
-	hpriv->target_pwrs = kzalloc(sz, GFP_KERNEL);
+	hpriv->target_pwrs = kcalloc(hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
 	if (!hpriv->target_pwrs) {
 		rc = -ENOMEM;
 		goto err_out;
-- 
2.16.4
