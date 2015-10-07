From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ata: sata_rcar: Remove obsolete platform_device_id entries
Date: Wed,  7 Oct 2015 12:57:22 +0200
Message-ID: <1444215442-27269-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-ide@vger.kernel.org

Since commit c99cd90d98a98aa1 ("ARM: shmobile: r8a7779: Remove legacy
SoC code"), R-Car SoCs are only supported in generic DT-only ARM
multi-platform builds.  The driver doesn't need to match platform
devices by name anymore, hence remove the remaining platform_device_id
entries and platform device support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/ata/sata_rcar.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 8804127b108c..d8bbe8b7c479 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -858,13 +858,6 @@ static struct of_device_id sata_rcar_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sata_rcar_match);
 
-static const struct platform_device_id sata_rcar_id_table[] = {
-	{ "sata_rcar", RCAR_GEN1_SATA }, /* Deprecated by "sata-r8a7779" */
-	{ "sata-r8a7779", RCAR_GEN1_SATA },
-	{ },
-};
-MODULE_DEVICE_TABLE(platform, sata_rcar_id_table);
-
 static int sata_rcar_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
@@ -884,11 +877,10 @@ static int sata_rcar_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	of_id = of_match_device(sata_rcar_match, &pdev->dev);
-	if (of_id)
-		priv->type = (enum sata_rcar_type)of_id->data;
-	else
-		priv->type = platform_get_device_id(pdev)->driver_data;
+	if (!of_id)
+		return -ENODEV;
 
+	priv->type = (enum sata_rcar_type)of_id->data;
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "failed to get access to sata clock\n");
@@ -1018,7 +1010,6 @@ static const struct dev_pm_ops sata_rcar_pm_ops = {
 static struct platform_driver sata_rcar_driver = {
 	.probe		= sata_rcar_probe,
 	.remove		= sata_rcar_remove,
-	.id_table	= sata_rcar_id_table,
 	.driver = {
 		.name		= DRV_NAME,
 		.of_match_table	= sata_rcar_match,
-- 
1.9.1

