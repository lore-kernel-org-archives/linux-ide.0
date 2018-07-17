From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] Revert "ata: ahci_platform: convert kcalloc to devm_kcalloc"
Date: Tue, 17 Jul 2018 10:49:35 +0000
Message-ID: <1531824575-852-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, tj@kernel.org, sfr@canb.auug.org.au, mperttunen@nvidia.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

Since ahci_platform_put_resources() use target_pwrs after "devm_" freed
it, we cannot use devm_kcalloc for allocating target_pwrs.

This reverts commit bd0038b1b4f499d814d8f33a55b1df5ea6cf3b85.

Reported-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/libahci_platform.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index fe8939e161ea..2ceebaf2ed56 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -271,6 +271,8 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
 	for (c = 0; c < hpriv->nports; c++)
 		if (hpriv->target_pwrs && hpriv->target_pwrs[c])
 			regulator_put(hpriv->target_pwrs[c]);
+
+	kfree(hpriv->target_pwrs);
 }
 
 static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
@@ -406,7 +408,11 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		rc = -ENOMEM;
 		goto err_out;
 	}
-	hpriv->target_pwrs = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
+	/*
+	 * We cannot use devm_ here, since ahci_platform_put_resources() uses
+	 * target_pwrs after devm_ have freed memory
+	 */
+	hpriv->target_pwrs = kcalloc(hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
 	if (!hpriv->target_pwrs) {
 		rc = -ENOMEM;
 		goto err_out;
-- 
2.16.4
