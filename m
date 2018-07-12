From: Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 3/3] ata: ahci_platform: convert kcalloc to devm_kcalloc
Date: Thu, 12 Jul 2018 11:41:31 +0000
Message-ID: <1531395691-4653-4-git-send-email-clabbe@baylibre.com>
References: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531395691-4653-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hdegoede@redhat.com, tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
List-Id: linux-ide@vger.kernel.org

Like phys, target_pwrs could be allocated with devm_ function

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/libahci_platform.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index be9f54423a9b..fe8939e161ea 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -271,8 +271,6 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
 	for (c = 0; c < hpriv->nports; c++)
 		if (hpriv->target_pwrs && hpriv->target_pwrs[c])
 			regulator_put(hpriv->target_pwrs[c]);
-
-	kfree(hpriv->target_pwrs);
 }
 
 static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
@@ -408,7 +406,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 		rc = -ENOMEM;
 		goto err_out;
 	}
-	hpriv->target_pwrs = kcalloc(hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
+	hpriv->target_pwrs = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
 	if (!hpriv->target_pwrs) {
 		rc = -ENOMEM;
 		goto err_out;
-- 
2.16.4
