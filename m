From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 4/4] drivers: ata: use MODULE_DECLARE_OF_TABLE()
Date: Sat,  1 Jun 2019 15:52:59 +0200
Message-ID: <1559397179-5833-5-git-send-email-info@metux.net>
References: <1559397179-5833-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1559397179-5833-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: vireshk@kernel.org, b.zolnierkie@samsung.com, axboe@kernel.dk, herbert@gondor.apana.org.au, davem@davemloft.net, linux-ide@vger.kernel.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Using MODULE_DECLARE_OF_TABLE() macro to get rid of some #ifdef CONFIG_OF
and make the code a bit slimmer.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/pata_arasan_cf.c | 9 ++-------
 drivers/ata/sata_mv.c        | 9 ++-------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index ebecab8..22de61f 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -943,13 +943,8 @@ static int arasan_cf_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(arasan_cf_pm_ops, arasan_cf_suspend, arasan_cf_resume);
 
-#ifdef CONFIG_OF
-static const struct of_device_id arasan_cf_id_table[] = {
-	{ .compatible = "arasan,cf-spear1340" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, arasan_cf_id_table);
-#endif
+MODULE_DECLARE_OF_TABLE(arasan_cf_id_table,
+	{ .compatible = "arasan,cf-spear1340" });
 
 static struct platform_driver arasan_cf_driver = {
 	.probe		= arasan_cf_probe,
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index da585d2..bac48cd 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -4273,14 +4273,9 @@ static int mv_platform_resume(struct platform_device *pdev)
 #define mv_platform_resume NULL
 #endif
 
-#ifdef CONFIG_OF
-static const struct of_device_id mv_sata_dt_ids[] = {
+MODULE_DECLARE_OF_TABLE(mv_sata_dt_ids,
 	{ .compatible = "marvell,armada-370-sata", },
-	{ .compatible = "marvell,orion-sata", },
-	{},
-};
-MODULE_DEVICE_TABLE(of, mv_sata_dt_ids);
-#endif
+	{ .compatible = "marvell,orion-sata", });
 
 static struct platform_driver mv_platform_driver = {
 	.probe		= mv_platform_probe,
-- 
1.9.1
