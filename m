From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ata: sata_rcar: Use of_device_get_match_data() helper
Date: Wed,  4 Oct 2017 14:13:07 +0200
Message-ID: <1507119187-12297-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-ide@vger.kernel.org

Use the of_device_get_match_data() helper instead of open coding.
Note that the sata_rcar driver is used with DT only, so there's always a
valid match.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/ata/sata_rcar.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 537d11869069aae7..80ee2f2a50d02872 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -872,7 +872,6 @@ MODULE_DEVICE_TABLE(of, sata_rcar_match);
 
 static int sata_rcar_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	struct ata_host *host;
 	struct sata_rcar_priv *priv;
 	struct resource *mem;
@@ -888,11 +887,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	of_id = of_match_device(sata_rcar_match, &pdev->dev);
-	if (!of_id)
-		return -ENODEV;
-
-	priv->type = (enum sata_rcar_type)of_id->data;
+	priv->type = (enum sata_rcar_type)of_device_get_match_data(&pdev->dev);
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "failed to get access to sata clock\n");
-- 
2.7.4
