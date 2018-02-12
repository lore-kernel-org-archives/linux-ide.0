From: Preetham Chandru Ramchandra <pchandru@nvidia.com>
Subject: [PATCH V7 5/7] ata: ahci_tegra: disable devslp for t124
Date: Mon, 12 Feb 2018 22:56:44 +0530
Message-ID: <1518456406-21564-6-git-send-email-pchandru@nvidia.com>
References: <1518456406-21564-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5076 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbeBLR1q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2018 12:27:46 -0500
In-Reply-To: <1518456406-21564-1-git-send-email-pchandru@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: thierry.reding@gmail.com, tj@kernel.org, cyndis@kapsi.fi, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: preetham260@gmail.com, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com, Preetham Ramchandra <pchandru@nvidia.com>

From: Preetham Ramchandra <pchandru@nvidia.com>

t124 does not support devslp and it should be
disabled.

Signed-off-by: Preetham Chandru R <pchandru@nvidia.com>
---
 drivers/ata/ahci_tegra.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 6aaf8a4571c8..62f2afb54789 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -145,6 +145,10 @@
 #define FUSE_SATA_CALIB					0x124
 #define FUSE_SATA_CALIB_MASK				0x3
 
+enum {
+	NO_DEVSLP	= (1 << 0),
+};
+
 struct sata_pad_calibration {
 	u8 gen1_tx_amp;
 	u8 gen1_tx_peak;
@@ -166,12 +170,14 @@ struct tegra_ahci_ops {
 struct tegra_ahci_soc {
 	const char *const	*supply_names;
 	u32			num_supplies;
+	u32			quirks;
 	struct tegra_ahci_ops	ops;
 };
 
 struct tegra_ahci_priv {
 	struct platform_device	   *pdev;
 	void __iomem		   *sata_regs;
+	void __iomem		   *sata_aux_regs;
 	struct reset_control	   *sata_rst;
 	struct reset_control	   *sata_oob_rst;
 	struct reset_control	   *sata_cold_rst;
@@ -181,6 +187,18 @@ struct tegra_ahci_priv {
 	struct tegra_ahci_soc	   *soc_data;
 };
 
+static void tegra_ahci_handle_quirks(struct ahci_host_priv *hpriv)
+{
+	struct tegra_ahci_priv *tegra = hpriv->plat_data;
+	u32 val;
+
+	if (tegra->sata_aux_regs && (tegra->soc_data->quirks & NO_DEVSLP)) {
+		val = readl(tegra->sata_aux_regs + SATA_AUX_MISC_CNTL_1_0);
+		val &= ~SATA_AUX_MISC_CNTL_1_0_SDS_SUPPORT;
+		writel(val, tegra->sata_aux_regs + SATA_AUX_MISC_CNTL_1_0);
+	}
+}
+
 static int tegra124_ahci_init(struct ahci_host_priv *hpriv)
 {
 	struct tegra_ahci_priv *tegra = hpriv->plat_data;
@@ -400,6 +418,7 @@ static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
 	val &= ~SATA_CONFIGURATION_0_CLK_OVERRIDE;
 	writel(val, tegra->sata_regs + SATA_CONFIGURATION_0);
 
+	tegra_ahci_handle_quirks(hpriv);
 
 	/* Unmask SATA interrupts */
 
@@ -441,6 +460,7 @@ static const char *const tegra124_supply_names[] = {
 static const struct tegra_ahci_soc tegra124_ahci_soc_data = {
 	.supply_names = tegra124_supply_names,
 	.num_supplies = ARRAY_SIZE(tegra124_supply_names),
+	.quirks = NO_DEVSLP,
 	.ops = {
 		.init = tegra124_ahci_init,
 	},
@@ -485,6 +505,15 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	tegra->sata_regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(tegra->sata_regs))
 		return PTR_ERR(tegra->sata_regs);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	/*
+	 * Aux register is optional.
+	 */
+	if (res) {
+		tegra->sata_aux_regs = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(tegra->sata_aux_regs))
+			return PTR_ERR(tegra->sata_aux_regs);
+	}
 
 	tegra->sata_rst = devm_reset_control_get(&pdev->dev, "sata");
 	if (IS_ERR(tegra->sata_rst)) {
-- 
2.7.4

