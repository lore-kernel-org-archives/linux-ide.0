From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 8/9] drivers: ata: sata_gemini: use devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 10:19:33 +0100
Message-ID: <1552382374-28789-8-git-send-email-info@metux.net>
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
 drivers/ata/sata_gemini.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index 46950e0..96cca96 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -317,7 +317,6 @@ static int gemini_sata_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct sata_gemini *sg;
 	struct regmap *map;
-	struct resource *res;
 	enum gemini_muxmode muxmode;
 	u32 gmode;
 	u32 gmask;
@@ -328,11 +327,7 @@ static int gemini_sata_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	sg->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	sg->base = devm_ioremap_resource(dev, res);
+	sg->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sg->base))
 		return PTR_ERR(sg->base);
 
-- 
1.9.1
