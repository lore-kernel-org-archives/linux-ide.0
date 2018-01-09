From: Preetham Chandru Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V6 4/7] ata: ahci_tegra: initialize regulators from soc_data
Date: Tue, 9 Jan 2018 12:47:11 +0530
Message-ID: <1515482234-24716-5-git-send-email-pchandru@nvidia.com>
References: <1515482234-24716-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515482234-24716-1-git-send-email-pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cyndis-/1wQRMveznE@public.gmane.org
Cc: preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Get the regulator names to be initialized from soc_data
and initialize them.

Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/ata/ahci_tegra.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 71850e96e787..90dfa803607e 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -164,6 +164,8 @@ struct tegra_ahci_ops {
 };
 
 struct tegra_ahci_soc {
+	const char *const	*supply_names;
+	u32			num_supplies;
 	struct tegra_ahci_ops	ops;
 };
 
@@ -175,10 +177,14 @@ struct tegra_ahci_priv {
 	struct reset_control	   *sata_cold_rst;
 	/* Needs special handling, cannot use ahci_platform */
 	struct clk		   *sata_clk;
-	struct regulator_bulk_data supplies[5];
+	struct regulator_bulk_data *supplies;
 	struct tegra_ahci_soc	   *soc_data;
 };
 
+static const char *const tegra124_supply_names[] = {
+	"avdd", "hvdd", "vddio", "target-5v", "target-12v"
+};
+
 static int tegra124_ahci_init(struct ahci_host_priv *hpriv)
 {
 	struct tegra_ahci_priv *tegra = hpriv->plat_data;
@@ -224,6 +230,8 @@ static int tegra124_ahci_init(struct ahci_host_priv *hpriv)
 }
 
 static const struct tegra_ahci_soc tegra124_ahci_soc_data = {
+	.supply_names = tegra124_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra124_supply_names),
 	.ops = {
 		.init = tegra124_ahci_init,
 	},
@@ -234,7 +242,7 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 	struct tegra_ahci_priv *tegra = hpriv->plat_data;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(tegra->supplies),
+	ret = regulator_bulk_enable(tegra->soc_data->num_supplies,
 				    tegra->supplies);
 	if (ret)
 		return ret;
@@ -263,7 +271,7 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
 
 disable_regulators:
-	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
+	regulator_bulk_disable(tegra->soc_data->num_supplies, tegra->supplies);
 	return ret;
 }
 
@@ -280,7 +288,7 @@ static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
 	clk_disable_unprepare(tegra->sata_clk);
 	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
 
-	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
+	regulator_bulk_disable(tegra->soc_data->num_supplies, tegra->supplies);
 }
 
 static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
@@ -502,13 +510,17 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->sata_clk);
 	}
 
-	tegra->supplies[0].supply = "avdd";
-	tegra->supplies[1].supply = "hvdd";
-	tegra->supplies[2].supply = "vddio";
-	tegra->supplies[3].supply = "target-5v";
-	tegra->supplies[4].supply = "target-12v";
+	tegra->supplies = devm_kcalloc(&pdev->dev,
+				       tegra->soc_data->num_supplies,
+				       sizeof(*tegra->supplies), GFP_KERNEL);
+	if (!tegra->supplies)
+		return -ENOMEM;
+
+	for (i = 0; i < tegra->soc_data->num_supplies; i++)
+		tegra->supplies[i].supply = tegra->soc_data->supply_names[i];
 
-	ret = devm_regulator_bulk_get(&pdev->dev, ARRAY_SIZE(tegra->supplies),
+	ret = devm_regulator_bulk_get(&pdev->dev,
+				      tegra->soc_data->num_supplies,
 				      tegra->supplies);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to get regulators\n");
-- 
2.7.4
