From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 9/9] drivers: ata: sata_rcar: use devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 10:19:34 +0100
Message-ID: <1552382374-28789-9-git-send-email-info@metux.net>
References: <1552382374-28789-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552382374-28789-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com, linus.walleij@linaro.org, linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/sata_rcar.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 59b2317..293cc62 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -886,7 +886,6 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ata_host *host;
 	struct sata_rcar_priv *priv;
-	struct resource *mem;
 	int irq;
 	int ret = 0;
 
@@ -916,8 +915,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 
 	host->private_data = priv;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, mem);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
 		goto err_pm_put;
-- 
1.9.1
