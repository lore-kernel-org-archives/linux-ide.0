From: Preetham Chandru Ramchandra <pchandru@nvidia.com>
Subject: [PATCH V7 4/7] ata: ahci_tegra: initialize regulators from soc_data
Date: Mon, 12 Feb 2018 22:56:43 +0530
Message-ID: <1518456406-21564-5-git-send-email-pchandru@nvidia.com>
References: <1518456406-21564-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5070 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbeBLR1k (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2018 12:27:40 -0500
In-Reply-To: <1518456406-21564-1-git-send-email-pchandru@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: thierry.reding@gmail.com, tj@kernel.org, cyndis@kapsi.fi, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: preetham260@gmail.com, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com, Preetham Ramchandra <pchandru@nvidia.com>

From: Preetham Ramchandra <pchandru@nvidia.com>

Get the regulator names to be initialized from soc_data
and initialize them.

Signed-off-by: Preetham Chandru R <pchandru@nvidia.com>
---
v7:
* moved tegra124_supply_names definition to just above
   the tegra124_ahci_soc_data structure.
---
 drivers/ata/ahci_tegra.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 7ffe8a97447a..6aaf8a4571c8 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -164,6 +164,8 @@ struct tegra_ahci_ops {
 };
 
 struct tegra_ahci_soc {
+	const char *const	*supply_names;
+	u32			num_supplies;
 	struct tegra_ahci_ops	ops;
 };
 
@@ -175,7 +177,7 @@ struct tegra_ahci_priv {
 	struct reset_control	   *sata_cold_rst;
 	/* Needs special handling, cannot use ahci_platform */
 	struct clk		   *sata_clk;
-	struct regulator_bulk_data supplies[5];
+	struct regulator_bulk_data *supplies;
 	struct tegra_ahci_soc	   *soc_data;
 };
 
@@ -228,7 +230,7 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 	struct tegra_ahci_priv *tegra = hpriv->plat_data;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(tegra->supplies),
+	ret = regulator_bulk_enable(tegra->soc_data->num_supplies,
 				    tegra->supplies);
 	if (ret)
 		return ret;
@@ -257,7 +259,7 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
 
 disable_regulators:
-	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
+	regulator_bulk_disable(tegra->soc_data->num_supplies, tegra->supplies);
 	return ret;
 }
 
@@ -274,7 +276,7 @@ static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
 	clk_disable_unprepare(tegra->sata_clk);
 	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
 
-	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
+	regulator_bulk_disable(tegra->soc_data->num_supplies, tegra->supplies);
 }
 
 static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
@@ -432,7 +434,13 @@ static const struct ata_port_info ahci_tegra_port_info = {
 	.port_ops	= &ahci_tegra_port_ops,
 };
 
+static const char *const tegra124_supply_names[] = {
+	"avdd", "hvdd", "vddio", "target-5v", "target-12v"
+};
+
 static const struct tegra_ahci_soc tegra124_ahci_soc_data = {
+	.supply_names = tegra124_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra124_supply_names),
 	.ops = {
 		.init = tegra124_ahci_init,
 	},
@@ -457,6 +465,7 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	struct tegra_ahci_priv *tegra;
 	struct resource *res;
 	int ret;
+	unsigned int i;
 
 	hpriv = ahci_platform_get_resources(pdev);
 	if (IS_ERR(hpriv))
@@ -501,13 +510,17 @@ static int tegra_ahci_probe(struct platform_device *pdev)
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

