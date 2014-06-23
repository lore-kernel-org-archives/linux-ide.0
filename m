From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 2/5] ata: ahci_imx: allow hardware parameters to be specified
 in DT
Date: Mon, 23 Jun 2014 12:59:13 +0100
Message-ID: <E1Wz2u1-0000eI-Py@rmk-PC.arm.linux.org.uk>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:38928 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752408AbaFWL7S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Jun 2014 07:59:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Various SATA phy parameters are board specific, and therefore need to
be configured.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/ata/ahci_imx.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 160 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 4eba1c5279ec..3768f7e4e7dd 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -62,6 +62,7 @@ struct imx_ahci_priv {
 	struct regmap *gpr;
 	bool no_device;
 	bool first_time;
+	u32 phy_params;
 };
 
 static int ahci_imx_hotplug;
@@ -246,14 +247,7 @@ static int imx_sata_enable(struct ahci_host_priv *hpriv)
 				   IMX6Q_GPR13_SATA_TX_LVL_MASK |
 				   IMX6Q_GPR13_SATA_MPLL_CLK_EN |
 				   IMX6Q_GPR13_SATA_TX_EDGE_RATE,
-				   IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB |
-				   IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
-				   IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
-				   IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
-				   IMX6Q_GPR13_SATA_MPLL_SS_EN |
-				   IMX6Q_GPR13_SATA_TX_ATTEN_9_16 |
-				   IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB |
-				   IMX6Q_GPR13_SATA_TX_LVL_1_025_V);
+				   imxpriv->phy_params);
 		regmap_update_bits(imxpriv->gpr, IOMUXC_GPR13,
 				   IMX6Q_GPR13_SATA_MPLL_CLK_EN,
 				   IMX6Q_GPR13_SATA_MPLL_CLK_EN);
@@ -368,6 +362,152 @@ static const struct of_device_id imx_ahci_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, imx_ahci_of_match);
 
+struct reg_value {
+	u32 of_value;
+	u32 reg_value;
+};
+
+struct reg_property {
+	const char *name;
+	const struct reg_value *values;
+	size_t num_values;
+	u32 def_value;
+};
+
+static const struct reg_value gpr13_tx_level[] = {
+	{  937, IMX6Q_GPR13_SATA_TX_LVL_0_937_V },
+	{  947, IMX6Q_GPR13_SATA_TX_LVL_0_947_V },
+	{  957, IMX6Q_GPR13_SATA_TX_LVL_0_957_V },
+	{  966, IMX6Q_GPR13_SATA_TX_LVL_0_966_V },
+	{  976, IMX6Q_GPR13_SATA_TX_LVL_0_976_V },
+	{  986, IMX6Q_GPR13_SATA_TX_LVL_0_986_V },
+	{  996, IMX6Q_GPR13_SATA_TX_LVL_0_996_V },
+	{ 1005, IMX6Q_GPR13_SATA_TX_LVL_1_005_V },
+	{ 1015, IMX6Q_GPR13_SATA_TX_LVL_1_015_V },
+	{ 1025, IMX6Q_GPR13_SATA_TX_LVL_1_025_V },
+	{ 1035, IMX6Q_GPR13_SATA_TX_LVL_1_035_V },
+	{ 1045, IMX6Q_GPR13_SATA_TX_LVL_1_045_V },
+	{ 1054, IMX6Q_GPR13_SATA_TX_LVL_1_054_V },
+	{ 1064, IMX6Q_GPR13_SATA_TX_LVL_1_064_V },
+	{ 1074, IMX6Q_GPR13_SATA_TX_LVL_1_074_V },
+	{ 1084, IMX6Q_GPR13_SATA_TX_LVL_1_084_V },
+	{ 1094, IMX6Q_GPR13_SATA_TX_LVL_1_094_V },
+	{ 1104, IMX6Q_GPR13_SATA_TX_LVL_1_104_V },
+	{ 1113, IMX6Q_GPR13_SATA_TX_LVL_1_113_V },
+	{ 1123, IMX6Q_GPR13_SATA_TX_LVL_1_123_V },
+	{ 1133, IMX6Q_GPR13_SATA_TX_LVL_1_133_V },
+	{ 1143, IMX6Q_GPR13_SATA_TX_LVL_1_143_V },
+	{ 1152, IMX6Q_GPR13_SATA_TX_LVL_1_152_V },
+	{ 1162, IMX6Q_GPR13_SATA_TX_LVL_1_162_V },
+	{ 1172, IMX6Q_GPR13_SATA_TX_LVL_1_172_V },
+	{ 1182, IMX6Q_GPR13_SATA_TX_LVL_1_182_V },
+	{ 1191, IMX6Q_GPR13_SATA_TX_LVL_1_191_V },
+	{ 1201, IMX6Q_GPR13_SATA_TX_LVL_1_201_V },
+	{ 1211, IMX6Q_GPR13_SATA_TX_LVL_1_211_V },
+	{ 1221, IMX6Q_GPR13_SATA_TX_LVL_1_221_V },
+	{ 1230, IMX6Q_GPR13_SATA_TX_LVL_1_230_V },
+	{ 1240, IMX6Q_GPR13_SATA_TX_LVL_1_240_V }
+};
+
+static const struct reg_value gpr13_tx_boost[] = {
+	{    0, IMX6Q_GPR13_SATA_TX_BOOST_0_00_DB },
+	{  370, IMX6Q_GPR13_SATA_TX_BOOST_0_37_DB },
+	{  740, IMX6Q_GPR13_SATA_TX_BOOST_0_74_DB },
+	{  111, IMX6Q_GPR13_SATA_TX_BOOST_1_11_DB },
+	{  148, IMX6Q_GPR13_SATA_TX_BOOST_1_48_DB },
+	{  185, IMX6Q_GPR13_SATA_TX_BOOST_1_85_DB },
+	{  222, IMX6Q_GPR13_SATA_TX_BOOST_2_22_DB },
+	{  259, IMX6Q_GPR13_SATA_TX_BOOST_2_59_DB },
+	{  296, IMX6Q_GPR13_SATA_TX_BOOST_2_96_DB },
+	{  333, IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB },
+	{  370, IMX6Q_GPR13_SATA_TX_BOOST_3_70_DB },
+	{  407, IMX6Q_GPR13_SATA_TX_BOOST_4_07_DB },
+	{  444, IMX6Q_GPR13_SATA_TX_BOOST_4_44_DB },
+	{  481, IMX6Q_GPR13_SATA_TX_BOOST_4_81_DB },
+	{  528, IMX6Q_GPR13_SATA_TX_BOOST_5_28_DB },
+	{  575, IMX6Q_GPR13_SATA_TX_BOOST_5_75_DB }
+};
+
+static const struct reg_value gpr13_tx_atten[] = {
+	{  8, IMX6Q_GPR13_SATA_TX_ATTEN_8_16 },
+	{  9, IMX6Q_GPR13_SATA_TX_ATTEN_9_16 },
+	{ 10, IMX6Q_GPR13_SATA_TX_ATTEN_10_16 },
+	{ 12, IMX6Q_GPR13_SATA_TX_ATTEN_12_16 },
+	{ 14, IMX6Q_GPR13_SATA_TX_ATTEN_14_16 },
+	{ 16, IMX6Q_GPR13_SATA_TX_ATTEN_16_16 },
+};
+
+static const struct reg_value gpr13_rx_eq[] = {
+	{  500, IMX6Q_GPR13_SATA_RX_EQ_VAL_0_5_DB },
+	{ 1000, IMX6Q_GPR13_SATA_RX_EQ_VAL_1_0_DB },
+	{ 1500, IMX6Q_GPR13_SATA_RX_EQ_VAL_1_5_DB },
+	{ 2000, IMX6Q_GPR13_SATA_RX_EQ_VAL_2_0_DB },
+	{ 2500, IMX6Q_GPR13_SATA_RX_EQ_VAL_2_5_DB },
+	{ 3000, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB },
+	{ 3500, IMX6Q_GPR13_SATA_RX_EQ_VAL_3_5_DB },
+	{ 4000, IMX6Q_GPR13_SATA_RX_EQ_VAL_4_0_DB },
+};
+
+static const struct reg_property gpr13_props[] = {
+	{
+		.name = "fsl,transmit-level-mV",
+		.values = gpr13_tx_level,
+		.num_values = ARRAY_SIZE(gpr13_tx_level),
+		.def_value = IMX6Q_GPR13_SATA_TX_LVL_1_025_V,
+	}, {
+		.name = "fsl,transmit-boost-mdB",
+		.values = gpr13_tx_boost,
+		.num_values = ARRAY_SIZE(gpr13_tx_boost),
+		.def_value = IMX6Q_GPR13_SATA_TX_BOOST_3_33_DB,
+	}, {
+		.name = "fsl,transmit-atten-16ths",
+		.values = gpr13_tx_atten,
+		.num_values = ARRAY_SIZE(gpr13_tx_atten),
+		.def_value = IMX6Q_GPR13_SATA_TX_ATTEN_9_16,
+	}, {
+		.name = "fsl,receive-eq-mdB",
+		.values = gpr13_rx_eq,
+		.num_values = ARRAY_SIZE(gpr13_rx_eq),
+		.def_value = IMX6Q_GPR13_SATA_RX_EQ_VAL_3_0_DB,
+	},
+};
+
+static u32 imx_ahci_parse_props(struct device *dev,
+				const struct reg_property *prop, size_t num)
+{
+	struct device_node *np = dev->of_node;
+	u32 reg_value = 0;
+	int i, j;
+
+	for (i = 0; i < num; i++, prop++) {
+		u32 of_val;
+
+		if (of_property_read_u32(np, prop->name, &of_val)) {
+			dev_info(dev, "%s not specified, using %08x\n",
+				prop->name, prop->def_value);
+			reg_value |= prop->def_value;
+			continue;
+		}
+
+		for (j = 0; j < prop->num_values; j++) {
+			if (prop->values[j].of_value == of_val) {
+				dev_info(dev, "%s value %u, using %08x\n",
+					prop->name, of_val, prop->values[j].reg_value);
+				reg_value |= prop->values[j].reg_value;
+				break;
+			}
+		}
+
+		if (j == prop->num_values) {
+			dev_err(dev, "DT property %s is not a valid value\n",
+				prop->name);
+			reg_value |= prop->def_value;
+		}
+	}
+
+	return reg_value;
+}
+
 static int imx_ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -396,6 +536,8 @@ static int imx_ahci_probe(struct platform_device *pdev)
 	}
 
 	if (imxpriv->type == AHCI_IMX6Q) {
+		u32 reg_value;
+
 		imxpriv->gpr = syscon_regmap_lookup_by_compatible(
 							"fsl,imx6q-iomuxc-gpr");
 		if (IS_ERR(imxpriv->gpr)) {
@@ -403,6 +545,16 @@ static int imx_ahci_probe(struct platform_device *pdev)
 				"failed to find fsl,imx6q-iomux-gpr regmap\n");
 			return PTR_ERR(imxpriv->gpr);
 		}
+
+		reg_value = imx_ahci_parse_props(dev, gpr13_props,
+						 ARRAY_SIZE(gpr13_props));
+
+		imxpriv->phy_params =
+				   IMX6Q_GPR13_SATA_RX_LOS_LVL_SATA2M |
+				   IMX6Q_GPR13_SATA_RX_DPLL_MODE_2P_4F |
+				   IMX6Q_GPR13_SATA_SPD_MODE_3P0G |
+				   IMX6Q_GPR13_SATA_MPLL_SS_EN |
+				   reg_value;
 	}
 
 	hpriv = ahci_platform_get_resources(pdev);
-- 
1.8.3.1

