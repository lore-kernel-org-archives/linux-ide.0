From: Preetham Chandru Ramchandra <pchandru@nvidia.com>
Subject: [PATCH  2/2] ata: ahci_tegra: add support for tegra210
Date: Wed, 19 Oct 2016 23:45:56 +0530
Message-ID: <1476900956-23719-3-git-send-email-pchandru@nvidia.com>
References: <1476900956-23719-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8795 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944546AbcJSSRE (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Oct 2016 14:17:04 -0400
In-Reply-To: <1476900956-23719-1-git-send-email-pchandru@nvidia.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, swarren@wwwdotorg.org, thierry.reding@gmail.com, preetham260@gmail.com
Cc: ldewangan@nvidia.com, linux-ide@vger.kernel.org, vbyravarasu@nvidia.com, pkunapuli@nvidia.com, Preetham Chandru R <pchandru@nvidia.com>

From: Preetham Chandru R <pchandru@nvidia.com>

Add AHCI support for tegra210.
1. Moved tegra124 specifics to tegra124_ahci_init.
2. Separated out the regulators needed for tegra124 and tegra210.
3. Set the LPM capabilities
4. Added support to disable features through DT
5. Created inline functions for read/write and modify to
   SATA, SATA Config and SATA Aux registers.

Signed-off-by: Preetham Chandru R <pchandru@nvidia.com>
---
 drivers/ata/ahci_tegra.c | 630 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 500 insertions(+), 130 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 3a62eb2..fa88def 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -33,32 +33,74 @@
 
 #define DRV_NAME "tegra-ahci"
 
+#define SATA_FPCI_BAR5_0				0x94
+#define FPCI_BAR5_START_MASK				(0xFFFFFFF << 4)
+#define FPCI_BAR5_START					(0x0040020 << 4)
+#define FPCI_BAR5_ACCESS_TYPE				(0x1)
+
 #define SATA_CONFIGURATION_0				0x180
-#define SATA_CONFIGURATION_EN_FPCI			BIT(0)
+#define SATA_CONFIGURATION_0_EN_FPCI			BIT(0)
+#define SATA_CONFIGURATION_CLK_OVERRIDE			BIT(31)
+
+#define SATA_INTR_MASK_0				0x188
+#define IP_INT_MASK					BIT(16)
 
 #define SCFG_OFFSET					0x1000
 
-#define T_SATA0_CFG_1					0x04
-#define T_SATA0_CFG_1_IO_SPACE				BIT(0)
-#define T_SATA0_CFG_1_MEMORY_SPACE			BIT(1)
-#define T_SATA0_CFG_1_BUS_MASTER			BIT(2)
-#define T_SATA0_CFG_1_SERR				BIT(8)
+#define T_SATA_CFG_1					0x4
+#define T_SATA_CFG_1_IO_SPACE				BIT(0)
+#define T_SATA_CFG_1_MEMORY_SPACE			BIT(1)
+#define T_SATA_CFG_1_BUS_MASTER				BIT(2)
+#define T_SATA_CFG_1_SERR				BIT(8)
+
+#define T_SATA_CFG_9					0x24
+#define T_SATA_CFG_9_BASE_ADDRESS			0x40020000
 
-#define T_SATA0_CFG_9					0x24
-#define T_SATA0_CFG_9_BASE_ADDRESS_SHIFT		13
+#define T_SATA0_CFG_35					0x94
+#define T_SATA0_CFG_35_IDP_INDEX_MASK			(0x7FF << 2)
+#define T_SATA0_CFG_35_IDP_INDEX			(0x2A << 2)
 
-#define SATA_FPCI_BAR5					0x94
-#define SATA_FPCI_BAR5_START_SHIFT			4
+#define T_SATA0_AHCI_IDP1				0x98
+#define T_SATA0_AHCI_IDP1_DATA				(0x400040)
 
-#define SATA_INTR_MASK					0x188
-#define SATA_INTR_MASK_IP_INT_MASK			BIT(16)
+#define T_SATA0_CFG_PHY_1				0x12C
+#define T_SATA0_CFG_PHY_1_PADS_IDDQ_EN			BIT(23)
+#define T_SATA0_CFG_PHY_1_PAD_PLL_IDDQ_EN		BIT(22)
+
+#define T_SATA0_NVOOB                                   0x114
+#define T_SATA0_NVOOB_COMMA_CNT_MASK                    (0xff << 16)
+#define T_SATA0_NVOOB_COMMA_CNT                         (0x07 << 16)
+#define T_SATA0_NVOOB_SQUELCH_FILTER_MODE_MASK          (0x3 << 24)
+#define T_SATA0_NVOOB_SQUELCH_FILTER_MODE               (0x1 << 24)
+#define T_SATA0_NVOOB_SQUELCH_FILTER_LENGTH_MASK        (0x3 << 26)
+#define T_SATA0_NVOOB_SQUELCH_FILTER_LENGTH             (0x3 << 26)
+
+#define T_SATA_CFG_PHY_0                                0x120
+#define T_SATA_CFG_PHY_0_USE_7BIT_ALIGN_DET_FOR_SPD     BIT(11)
+#define T_SATA_CFG_PHY_0_MASK_SQUELCH                   BIT(24)
+
+#define FUSE_SATA_CALIB					0x124
+#define FUSE_SATA_CALIB_MASK				0x3
+
+#define T_SATA0_CFG2NVOOB_2				0x134
+#define T_SATA0_CFG2NVOOB_2_COMWAKE_IDLE_CNT_LOW_MASK	(0x1ff << 18)
+#define T_SATA0_CFG2NVOOB_2_COMWAKE_IDLE_CNT_LOW	(0xc << 18)
 
 #define T_SATA0_AHCI_HBA_CAP_BKDR			0x300
+#define T_SATA0_AHCI_HBA_CAP_BKDR_PARTIAL_ST_CAP	BIT(13)
+#define T_SATA0_AHCI_HBA_CAP_BKDR_SLUMBER_ST_CAP	BIT(14)
+#define T_SATA0_AHCI_HBA_CAP_BKDR_SALP			BIT(26)
+#define T_SATA0_AHCI_HBA_CAP_BKDR_SUPP_PM		BIT(17)
+#define T_SATA0_AHCI_HBA_CAP_BKDR_SNCQ			BIT(30)
 
-#define T_SATA0_BKDOOR_CC				0x4a4
+#define T_SATA_BKDOOR_CC				0x4A4
+#define T_SATA_BKDOOR_CC_CLASS_CODE_MASK		(0xFFFF << 16)
+#define T_SATA_BKDOOR_CC_CLASS_CODE			(0x0106 << 16)
+#define T_SATA_BKDOOR_CC_PROG_IF_MASK			(0xFF << 8)
+#define T_SATA_BKDOOR_CC_PROG_IF			(0x01 << 8)
 
-#define T_SATA0_CFG_SATA				0x54c
-#define T_SATA0_CFG_SATA_BACKDOOR_PROG_IF_EN		BIT(12)
+#define T_SATA_CFG_SATA					0x54C
+#define T_SATA_CFG_SATA_BACKDOOR_PROG_IF_EN		BIT(12)
 
 #define T_SATA0_CFG_MISC				0x550
 
@@ -82,8 +124,27 @@
 #define T_SATA0_CHX_PHY_CTRL11				0x6d0
 #define T_SATA0_CHX_PHY_CTRL11_GEN2_RX_EQ		(0x2800 << 16)
 
-#define FUSE_SATA_CALIB					0x124
-#define FUSE_SATA_CALIB_MASK				0x3
+/* Electrical settings for better link stability */
+#define T_SATA0_CHX_PHY_CTRL17_0			0x6e8
+#define T_SATA0_CHX_PHY_CTRL17_0_RX_EQ_CTRL_L_GEN1	0x55010000
+#define T_SATA0_CHX_PHY_CTRL18_0			0x6ec
+#define T_SATA0_CHX_PHY_CTRL18_0_RX_EQ_CTRL_L_GEN2	0x55010000
+#define T_SATA0_CHX_PHY_CTRL20_0			0x6f4
+#define T_SATA0_CHX_PHY_CTRL20_0_RX_EQ_CTRL_H_GEN1	0x1
+#define T_SATA0_CHX_PHY_CTRL21_0			0x6f8
+#define T_SATA0_CHX_PHY_CTRL21_0_RX_EQ_CTRL_H_GEN2	0x1
+
+/* AUX Registers */
+#define SATA_AUX_MISC_CNTL_1_0				0x8
+#define DEVSLP_OVERRIDE					BIT(17)
+#define SDS_SUPPORT					BIT(13)
+#define DESO_SUPPORT					BIT(15)
+
+#define SATA_AUX_RX_STAT_INT_0				0xc
+#define SATA_DEVSLP					BIT(7)
+
+#define SATA_AUX_SPARE_CFG0_0				0x18
+#define MDAT_TIMER_AFTER_PG_VALID			BIT(14)
 
 struct sata_pad_calibration {
 	u8 gen1_tx_amp;
@@ -99,15 +160,161 @@ static const struct sata_pad_calibration tegra124_pad_calibration[] = {
 	{0x14, 0x0e, 0x1a, 0x0e},
 };
 
+struct tegra_ahci_ops {
+	int (*init)(struct ahci_host_priv *);
+};
+
+struct tegra_ahci_soc {
+	const char * const *supply_names;
+	unsigned int num_supplies;
+	struct tegra_ahci_ops ops;
+};
+
 struct tegra_ahci_priv {
 	struct platform_device	   *pdev;
 	void __iomem		   *sata_regs;
+	void __iomem		   *sata_aux_regs;
 	struct reset_control	   *sata_rst;
 	struct reset_control	   *sata_oob_rst;
 	struct reset_control	   *sata_cold_rst;
 	/* Needs special handling, cannot use ahci_platform */
 	struct clk		   *sata_clk;
-	struct regulator_bulk_data supplies[5];
+	struct regulator_bulk_data *supplies;
+	struct tegra_ahci_soc *soc_data;
+};
+
+static const char * const tegra124_supply_names[] = {
+	"avdd", "hvdd", "vddio", "target-5v", "target-12v"
+};
+
+static inline void tegra_ahci_sata_update(
+		struct tegra_ahci_priv *tegra,
+		u32 val, u32 mask, u32 offset
+
+		)
+{
+	u32 uval = 0;
+
+	uval = readl(tegra->sata_regs + offset);
+	uval = (uval & ~mask) | (val & mask);
+	writel(uval, tegra->sata_regs + offset);
+}
+
+static inline void tegra_ahci_scfg_writel(
+		struct tegra_ahci_priv *tegra, u32 val, u32 offset
+
+		)
+{
+	writel(val, tegra->sata_regs + SCFG_OFFSET + offset);
+}
+
+static inline void tegra_ahci_scfg_update(
+		struct tegra_ahci_priv *tegra, u32 val,	u32 mask, u32 offset
+
+		)
+{
+	u32 uval = 0;
+
+	uval = readl(tegra->sata_regs + SCFG_OFFSET + offset);
+	uval = (uval & ~mask) | (val & mask);
+	writel(uval, tegra->sata_regs + SCFG_OFFSET + offset);
+}
+
+static inline u32 tegra_ahci_aux_readl(
+		struct tegra_ahci_priv *tegra, u32 offset
+
+		)
+{
+	u32 rval = 0;
+
+	rval = readl(tegra->sata_aux_regs + offset);
+	return rval;
+}
+
+static inline void tegra_ahci_aux_update(
+		struct tegra_ahci_priv *tegra, u32 val,	u32 mask, u32 offset
+
+		)
+{
+	u32 uval = 0;
+
+	uval = readl(tegra->sata_aux_regs + offset);
+	uval = (uval & ~mask) | (val & mask);
+	writel(uval, tegra->sata_aux_regs + offset);
+}
+
+static int tegra124_ahci_init(struct ahci_host_priv *hpriv)
+{
+	struct tegra_ahci_priv *tegra = hpriv->plat_data;
+	struct sata_pad_calibration calib;
+	int ret;
+	u32 val;
+	u32 mask;
+
+	/* Pad calibration */
+
+	ret = tegra_fuse_readl(FUSE_SATA_CALIB, &val);
+	if (ret) {
+		dev_err(&tegra->pdev->dev,
+			"failed to read calibration fuse: %d\n", ret);
+		return ret;
+	}
+
+	calib = tegra124_pad_calibration[val & FUSE_SATA_CALIB_MASK];
+
+	tegra_ahci_scfg_writel(tegra, BIT(0), T_SATA0_INDEX);
+
+	mask = T_SATA0_CHX_PHY_CTRL1_GEN1_TX_AMP_MASK;
+	mask |= T_SATA0_CHX_PHY_CTRL1_GEN1_TX_PEAK_MASK;
+	val = calib.gen1_tx_amp <<
+		T_SATA0_CHX_PHY_CTRL1_GEN1_TX_AMP_SHIFT;
+	val |= calib.gen1_tx_peak <<
+		T_SATA0_CHX_PHY_CTRL1_GEN1_TX_PEAK_SHIFT;
+	tegra_ahci_scfg_update(tegra, val, mask, T_SATA0_CHX_PHY_CTRL1_GEN1);
+
+	mask = T_SATA0_CHX_PHY_CTRL1_GEN2_TX_AMP_MASK;
+	mask |= T_SATA0_CHX_PHY_CTRL1_GEN2_TX_PEAK_MASK;
+	val = calib.gen2_tx_amp <<
+		T_SATA0_CHX_PHY_CTRL1_GEN1_TX_AMP_SHIFT;
+	val |= calib.gen2_tx_peak <<
+		T_SATA0_CHX_PHY_CTRL1_GEN1_TX_PEAK_SHIFT;
+	tegra_ahci_scfg_update(tegra, val, mask, T_SATA0_CHX_PHY_CTRL1_GEN2);
+
+	tegra_ahci_scfg_writel(
+			tegra,
+			T_SATA0_CHX_PHY_CTRL11_GEN2_RX_EQ,
+			T_SATA0_CHX_PHY_CTRL11
+			);
+	tegra_ahci_scfg_writel(
+			tegra,
+			T_SATA0_CHX_PHY_CTRL2_CDR_CNTL_GEN1,
+			T_SATA0_CHX_PHY_CTRL2
+			);
+
+	tegra_ahci_scfg_writel(tegra, 0, T_SATA0_INDEX);
+
+	return 0;
+}
+
+static const char * const tegra210_supply_names[] = {
+	"dvdd-sata-pll",
+	"hvdd-sata",
+	"l0-hvddio-sata",
+	"l0-dvddio-sata",
+	"hvdd-pex-pll-e"
+};
+
+static const struct tegra_ahci_soc tegra124_ahci = {
+	.supply_names = tegra124_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra124_supply_names),
+	.ops = {
+		.init = tegra124_ahci_init,
+	},
+};
+
+static const struct tegra_ahci_soc tegra210_ahci = {
+	.supply_names = tegra210_supply_names,
+	.num_supplies = ARRAY_SIZE(tegra210_supply_names),
 };
 
 static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
@@ -115,8 +322,10 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 	struct tegra_ahci_priv *tegra = hpriv->plat_data;
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(tegra->supplies),
-				    tegra->supplies);
+	ret = regulator_bulk_enable(
+			tegra->soc_data->num_supplies,
+			tegra->supplies
+			);
 	if (ret)
 		return ret;
 
@@ -144,8 +353,10 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
 
 disable_regulators:
-	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
-
+	regulator_bulk_disable(
+			tegra->soc_data->num_supplies,
+			tegra->supplies
+			);
 	return ret;
 }
 
@@ -162,131 +373,264 @@ static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
 	clk_disable_unprepare(tegra->sata_clk);
 	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
 
-	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
+	regulator_bulk_disable(
+			tegra->soc_data->num_supplies,
+			tegra->supplies
+			);
 }
 
-static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
+static void tegra_ahci_controller_deinit(struct ahci_host_priv *hpriv)
 {
-	struct tegra_ahci_priv *tegra = hpriv->plat_data;
-	int ret;
-	unsigned int val;
-	struct sata_pad_calibration calib;
-
-	ret = tegra_ahci_power_on(hpriv);
-	if (ret) {
-		dev_err(&tegra->pdev->dev,
-			"failed to power on AHCI controller: %d\n", ret);
-		return ret;
-	}
-
-	val = readl(tegra->sata_regs + SATA_CONFIGURATION_0);
-	val |= SATA_CONFIGURATION_EN_FPCI;
-	writel(val, tegra->sata_regs + SATA_CONFIGURATION_0);
-
-	/* Pad calibration */
-
-	ret = tegra_fuse_readl(FUSE_SATA_CALIB, &val);
-	if (ret) {
-		dev_err(&tegra->pdev->dev,
-			"failed to read calibration fuse: %d\n", ret);
-		return ret;
-	}
-
-	calib = tegra124_pad_calibration[val & FUSE_SATA_CALIB_MASK];
-
-	writel(BIT(0), tegra->sata_regs + SCFG_OFFSET + T_SATA0_INDEX);
-
-	val = readl(tegra->sata_regs +
-		SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL1_GEN1);
-	val &= ~T_SATA0_CHX_PHY_CTRL1_GEN1_TX_AMP_MASK;
-	val &= ~T_SATA0_CHX_PHY_CTRL1_GEN1_TX_PEAK_MASK;
-	val |= calib.gen1_tx_amp <<
-			T_SATA0_CHX_PHY_CTRL1_GEN1_TX_AMP_SHIFT;
-	val |= calib.gen1_tx_peak <<
-			T_SATA0_CHX_PHY_CTRL1_GEN1_TX_PEAK_SHIFT;
-	writel(val, tegra->sata_regs + SCFG_OFFSET +
-		T_SATA0_CHX_PHY_CTRL1_GEN1);
-
-	val = readl(tegra->sata_regs +
-			SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL1_GEN2);
-	val &= ~T_SATA0_CHX_PHY_CTRL1_GEN2_TX_AMP_MASK;
-	val &= ~T_SATA0_CHX_PHY_CTRL1_GEN2_TX_PEAK_MASK;
-	val |= calib.gen2_tx_amp <<
-			T_SATA0_CHX_PHY_CTRL1_GEN1_TX_AMP_SHIFT;
-	val |= calib.gen2_tx_peak <<
-			T_SATA0_CHX_PHY_CTRL1_GEN1_TX_PEAK_SHIFT;
-	writel(val, tegra->sata_regs + SCFG_OFFSET +
-		T_SATA0_CHX_PHY_CTRL1_GEN2);
+	tegra_ahci_power_off(hpriv);
+}
 
-	writel(T_SATA0_CHX_PHY_CTRL11_GEN2_RX_EQ,
-		tegra->sata_regs + SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL11);
-	writel(T_SATA0_CHX_PHY_CTRL2_CDR_CNTL_GEN1,
-		tegra->sata_regs + SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL2);
+static void tegra_ahci_host_stop(struct ata_host *host)
+{
+	struct ahci_host_priv *hpriv = host->private_data;
 
-	writel(0, tegra->sata_regs + SCFG_OFFSET + T_SATA0_INDEX);
+	tegra_ahci_controller_deinit(hpriv);
+}
 
-	/* Program controller device ID */
+static struct ata_port_operations ahci_tegra_port_ops = {
+	.inherits	= &ahci_ops,
+	.host_stop	= tegra_ahci_host_stop,
+};
 
-	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_SATA);
-	val |= T_SATA0_CFG_SATA_BACKDOOR_PROG_IF_EN;
-	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_SATA);
+static struct ata_port_info ahci_tegra_port_info = {
+	.flags		= AHCI_FLAG_COMMON,
+	.pio_mask	= ATA_PIO4,
+	.udma_mask	= ATA_UDMA6,
+	.port_ops	= &ahci_tegra_port_ops,
+};
 
-	writel(0x01060100, tegra->sata_regs + SCFG_OFFSET + T_SATA0_BKDOOR_CC);
+static void tegra_ahci_disable_devslp(struct tegra_ahci_priv *tegra)
+{
+	u32 val = 0;
+	u32 mask = SDS_SUPPORT;
 
-	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_SATA);
-	val &= ~T_SATA0_CFG_SATA_BACKDOOR_PROG_IF_EN;
-	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_SATA);
+	val = 0xFFFFFFFF & ~SDS_SUPPORT;
+	tegra_ahci_aux_update(tegra, val, mask, SATA_AUX_MISC_CNTL_1_0);
+}
 
-	/* Enable IO & memory access, bus master mode */
+static void tegra_ahci_disable_hipm(struct tegra_ahci_priv *tegra)
+{
+	u32 val = 0;
+	u32 mask = T_SATA0_AHCI_HBA_CAP_BKDR_SALP;
 
-	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_1);
-	val |= T_SATA0_CFG_1_IO_SPACE | T_SATA0_CFG_1_MEMORY_SPACE |
-		T_SATA0_CFG_1_BUS_MASTER | T_SATA0_CFG_1_SERR;
-	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_1);
+	val = 0xFFFFFFFF & ~T_SATA0_AHCI_HBA_CAP_BKDR_SALP;
+	tegra_ahci_scfg_update(tegra, val, mask, T_SATA0_AHCI_HBA_CAP_BKDR);
+}
 
-	/* Program SATA MMIO */
+static void tegra_ahci_disable_partial(struct tegra_ahci_priv *tegra)
+{
+	u32 val = 0;
+	u32 mask = T_SATA0_AHCI_HBA_CAP_BKDR_PARTIAL_ST_CAP;
 
-	writel(0x10000 << SATA_FPCI_BAR5_START_SHIFT,
-	       tegra->sata_regs + SATA_FPCI_BAR5);
+	val = 0xFFFFFFFF & ~T_SATA0_AHCI_HBA_CAP_BKDR_PARTIAL_ST_CAP;
+	tegra_ahci_scfg_update(tegra, val, mask, T_SATA0_AHCI_HBA_CAP_BKDR);
+}
 
-	writel(0x08000 << T_SATA0_CFG_9_BASE_ADDRESS_SHIFT,
-	       tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_9);
+static void tegra_ahci_disable_slumber(struct tegra_ahci_priv *tegra)
+{
+	u32 val = 0;
+	u32 mask = T_SATA0_AHCI_HBA_CAP_BKDR_SLUMBER_ST_CAP;
 
-	/* Unmask SATA interrupts */
+	val = 0xFFFFFFFF & ~T_SATA0_AHCI_HBA_CAP_BKDR_SLUMBER_ST_CAP;
+	tegra_ahci_scfg_update(tegra, val, mask, T_SATA0_AHCI_HBA_CAP_BKDR);
+}
 
-	val = readl(tegra->sata_regs + SATA_INTR_MASK);
-	val |= SATA_INTR_MASK_IP_INT_MASK;
-	writel(val, tegra->sata_regs + SATA_INTR_MASK);
+static void tegra_ahci_disable_ncq(struct tegra_ahci_priv *tegra)
+{
+	u32 val = 0;
+	u32 mask = T_SATA0_AHCI_HBA_CAP_BKDR_SNCQ;
 
-	return 0;
+	val = 0xFFFFFFFF & ~T_SATA0_AHCI_HBA_CAP_BKDR_SNCQ;
+	tegra_ahci_scfg_update(tegra, val, mask, T_SATA0_AHCI_HBA_CAP_BKDR);
 }
 
-static void tegra_ahci_controller_deinit(struct ahci_host_priv *hpriv)
+static int tegra_ahci_disable_features(struct ahci_host_priv *hpriv)
 {
-	tegra_ahci_power_off(hpriv);
+	struct tegra_ahci_priv *tegra = hpriv->plat_data;
+	struct platform_device *pdev = tegra->pdev;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct property *prop;
+	const char *feature;
+	int ret = 0;
+
+	if (of_property_count_strings(np, "nvidia,disable-features") <= 0)
+		return 0;
+
+	of_property_for_each_string(
+			np, "nvidia,disable-features", prop, feature
+			) {
+		if (!strcmp(feature, "devslp"))
+			tegra_ahci_disable_devslp(tegra);
+		else if (!strcmp(feature, "hipm"))
+			tegra_ahci_disable_hipm(tegra);
+		else if (!strcmp(feature, "ncq"))
+			tegra_ahci_disable_ncq(tegra);
+		else if (!strcmp(feature, "dipm"))
+			ahci_tegra_port_info.flags |= ATA_FLAG_NO_DIPM;
+		else if (!strcmp(feature, "partial"))
+			tegra_ahci_disable_partial(tegra);
+		else if (!strcmp(feature, "slumber"))
+			tegra_ahci_disable_slumber(tegra);
+	}
+
+	return ret;
 }
 
-static void tegra_ahci_host_stop(struct ata_host *host)
+static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
 {
-	struct ahci_host_priv *hpriv = host->private_data;
+	struct tegra_ahci_priv *tegra = hpriv->plat_data;
+	int ret;
+	unsigned int val;
+	unsigned int mask;
 
-	tegra_ahci_controller_deinit(hpriv);
-}
+	ret = tegra_ahci_power_on(hpriv);
+	if (ret) {
+		dev_err(&tegra->pdev->dev,
+			"failed to power on AHCI controller: %d\n", ret);
+		return ret;
+	}
 
-static struct ata_port_operations ahci_tegra_port_ops = {
-	.inherits	= &ahci_ops,
-	.host_stop	= tegra_ahci_host_stop,
-};
+	/* Program the following  SATA IPFS registers
+	 * to allow SW accesses to SATA's MMIO Register
+	 */
+	mask = FPCI_BAR5_START_MASK | FPCI_BAR5_ACCESS_TYPE;
+	val = FPCI_BAR5_START | FPCI_BAR5_ACCESS_TYPE;
+	tegra_ahci_sata_update(tegra, val, mask, SATA_FPCI_BAR5_0);
+
+	/* Program the following SATA IPFS register to enable the SATA */
+	val = SATA_CONFIGURATION_0_EN_FPCI;
+	tegra_ahci_sata_update(tegra, val, val, SATA_CONFIGURATION_0);
+
+	/* Electrical settings for better link stability */
+	tegra_ahci_scfg_writel(
+			tegra,
+			T_SATA0_CHX_PHY_CTRL17_0_RX_EQ_CTRL_L_GEN1,
+			T_SATA0_CHX_PHY_CTRL17_0
+			);
+	tegra_ahci_scfg_writel(
+			tegra,
+			T_SATA0_CHX_PHY_CTRL18_0_RX_EQ_CTRL_L_GEN2,
+			T_SATA0_CHX_PHY_CTRL18_0);
+	tegra_ahci_scfg_writel(
+			tegra,
+			T_SATA0_CHX_PHY_CTRL20_0_RX_EQ_CTRL_H_GEN1,
+			T_SATA0_CHX_PHY_CTRL20_0
+			);
+	tegra_ahci_scfg_writel(
+			tegra,
+			T_SATA0_CHX_PHY_CTRL21_0_RX_EQ_CTRL_H_GEN2,
+			T_SATA0_CHX_PHY_CTRL21_0
+			);
+
+	/* For SQUELCH Filter & Gen3 drive getting detected as Gen1 drive */
+
+	mask = T_SATA_CFG_PHY_0_MASK_SQUELCH |
+		T_SATA_CFG_PHY_0_USE_7BIT_ALIGN_DET_FOR_SPD;
+	val = T_SATA_CFG_PHY_0_MASK_SQUELCH;
+	val &= ~T_SATA_CFG_PHY_0_USE_7BIT_ALIGN_DET_FOR_SPD;
+	tegra_ahci_scfg_update(tegra, val, mask, T_SATA_CFG_PHY_0);
+
+	mask = (
+			T_SATA0_NVOOB_COMMA_CNT_MASK |
+			T_SATA0_NVOOB_SQUELCH_FILTER_LENGTH_MASK |
+			T_SATA0_NVOOB_SQUELCH_FILTER_MODE_MASK
+	       );
+	val = (
+			T_SATA0_NVOOB_COMMA_CNT |
+			T_SATA0_NVOOB_SQUELCH_FILTER_LENGTH |
+			T_SATA0_NVOOB_SQUELCH_FILTER_MODE
+	      );
+	tegra_ahci_scfg_update(tegra, val, mask, T_SATA0_NVOOB);
+
+	/*
+	 * Change CFG2NVOOB_2_COMWAKE_IDLE_CNT_LOW from 83.3 ns to 58.8ns
+	 */
+	mask = T_SATA0_CFG2NVOOB_2_COMWAKE_IDLE_CNT_LOW_MASK;
+	val = T_SATA0_CFG2NVOOB_2_COMWAKE_IDLE_CNT_LOW;
+	tegra_ahci_scfg_update(tegra, val, mask, T_SATA0_CFG2NVOOB_2);
+
+	if (tegra->soc_data->ops.init)
+		tegra->soc_data->ops.init(hpriv);
+
+	/* Program the following SATA configuration registers
+	 * to initialize SATA
+	 */
+	val = (T_SATA_CFG_1_IO_SPACE | T_SATA_CFG_1_MEMORY_SPACE |
+			T_SATA_CFG_1_BUS_MASTER | T_SATA_CFG_1_SERR);
+	tegra_ahci_scfg_update(tegra, val, val, T_SATA_CFG_1);
+	tegra_ahci_scfg_writel(tegra, T_SATA_CFG_9_BASE_ADDRESS, T_SATA_CFG_9);
+
+	/* Program Class Code and Programming interface for SATA */
+	val = T_SATA_CFG_SATA_BACKDOOR_PROG_IF_EN;
+	tegra_ahci_scfg_update(tegra, val, val, T_SATA_CFG_SATA);
+
+	mask = T_SATA_BKDOOR_CC_CLASS_CODE_MASK | T_SATA_BKDOOR_CC_PROG_IF_MASK;
+	val = T_SATA_BKDOOR_CC_CLASS_CODE | T_SATA_BKDOOR_CC_PROG_IF;
+	tegra_ahci_scfg_update(tegra, val, mask, T_SATA_BKDOOR_CC);
+
+	mask = T_SATA_CFG_SATA_BACKDOOR_PROG_IF_EN;
+	val = (u32)~T_SATA_CFG_SATA_BACKDOOR_PROG_IF_EN;
+	tegra_ahci_scfg_update(tegra, val, mask, T_SATA_CFG_SATA);
+
+	/* Enabling LPM capabilities through Backdoor Programming */
+	val = (T_SATA0_AHCI_HBA_CAP_BKDR_PARTIAL_ST_CAP |
+			T_SATA0_AHCI_HBA_CAP_BKDR_SLUMBER_ST_CAP |
+			T_SATA0_AHCI_HBA_CAP_BKDR_SALP |
+			T_SATA0_AHCI_HBA_CAP_BKDR_SUPP_PM);
+	tegra_ahci_scfg_update(tegra, val, val, T_SATA0_AHCI_HBA_CAP_BKDR);
+
+	/* SATA Second Level Clock Gating configuration
+	 * Enabling Gating of Tx/Rx clocks and driving Pad IDDQ and Lane
+	 * IDDQ Signals
+	 */
+	mask = T_SATA0_CFG_35_IDP_INDEX_MASK;
+	val = T_SATA0_CFG_35_IDP_INDEX;
+	tegra_ahci_scfg_update(tegra, val, mask, T_SATA0_CFG_35);
+	tegra_ahci_scfg_writel(
+			tegra, T_SATA0_AHCI_IDP1_DATA,
+			T_SATA0_AHCI_IDP1
+			);
+	val = (
+			T_SATA0_CFG_PHY_1_PADS_IDDQ_EN |
+			T_SATA0_CFG_PHY_1_PAD_PLL_IDDQ_EN
+	      );
+	tegra_ahci_scfg_update(tegra, val, val, T_SATA0_CFG_PHY_1);
+
+	/*
+	 *  Indicate Sata only has the capability to enter DevSleep
+	 * from slumber link.
+	 */
+	tegra_ahci_aux_update(
+			tegra, DESO_SUPPORT, DESO_SUPPORT,
+			SATA_AUX_MISC_CNTL_1_0
+			);
+	/* Enabling IPFS Clock Gating */
+	mask = SATA_CONFIGURATION_CLK_OVERRIDE;
+	val = (u32)~SATA_CONFIGURATION_CLK_OVERRIDE;
+	tegra_ahci_sata_update(tegra, val, mask, SATA_CONFIGURATION_0);
+
+	tegra_ahci_disable_features(hpriv);
+
+	val = IP_INT_MASK;
+	tegra_ahci_sata_update(tegra, val, val, SATA_INTR_MASK_0);
 
-static const struct ata_port_info ahci_tegra_port_info = {
-	.flags		= AHCI_FLAG_COMMON,
-	.pio_mask	= ATA_PIO4,
-	.udma_mask	= ATA_UDMA6,
-	.port_ops	= &ahci_tegra_port_ops,
-};
+	return 0;
+}
 
 static const struct of_device_id tegra_ahci_of_match[] = {
-	{ .compatible = "nvidia,tegra124-ahci" },
+	{
+		.compatible = "nvidia,tegra124-ahci",
+		.data = &tegra124_ahci
+	},
+	{
+		.compatible = "nvidia,tegra210-ahci",
+		.data = &tegra210_ahci
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, tegra_ahci_of_match);
@@ -300,7 +644,9 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	struct tegra_ahci_priv *tegra;
 	struct resource *res;
+	const struct of_device_id *match = NULL;
 	int ret;
+	unsigned int i;
 
 	hpriv = ahci_platform_get_resources(pdev);
 	if (IS_ERR(hpriv))
@@ -314,10 +660,23 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 
 	tegra->pdev = pdev;
 
+	match = of_match_device(
+			of_match_ptr(tegra_ahci_of_match), &pdev->dev
+			);
+	if (!match)
+		return -ENODEV;
+
+	tegra->soc_data =
+		(struct tegra_ahci_soc *)of_device_get_match_data(&pdev->dev);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	tegra->sata_regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(tegra->sata_regs))
 		return PTR_ERR(tegra->sata_regs);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	tegra->sata_aux_regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(tegra->sata_aux_regs))
+		return PTR_ERR(tegra->sata_aux_regs);
 
 	tegra->sata_rst = devm_reset_control_get(&pdev->dev, "sata");
 	if (IS_ERR(tegra->sata_rst)) {
@@ -343,14 +702,23 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->sata_clk);
 	}
 
-	tegra->supplies[0].supply = "avdd";
-	tegra->supplies[1].supply = "hvdd";
-	tegra->supplies[2].supply = "vddio";
-	tegra->supplies[3].supply = "target-5v";
-	tegra->supplies[4].supply = "target-12v";
-
-	ret = devm_regulator_bulk_get(&pdev->dev, ARRAY_SIZE(tegra->supplies),
-				      tegra->supplies);
+	tegra->supplies = devm_kcalloc(
+			&pdev->dev,
+			tegra->soc_data->num_supplies,
+			sizeof(*tegra->supplies),
+			GFP_KERNEL
+			);
+	if (IS_ERR(tegra->supplies))
+		return PTR_ERR(tegra->supplies);
+
+	for (i = 0; i < tegra->soc_data->num_supplies; i++)
+		tegra->supplies[i].supply = tegra->soc_data->supply_names[i];
+
+	ret = devm_regulator_bulk_get(
+			&pdev->dev,
+			tegra->soc_data->num_supplies,
+			tegra->supplies
+			);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to get regulators\n");
 		return ret;
@@ -360,8 +728,10 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = ahci_platform_init_host(pdev, hpriv, &ahci_tegra_port_info,
-				      &ahci_platform_sht);
+	ret = ahci_platform_init_host(
+			pdev, hpriv, &ahci_tegra_port_info,
+			&ahci_platform_sht
+			);
 	if (ret)
 		goto deinit_controller;
 
@@ -385,5 +755,5 @@ static struct platform_driver tegra_ahci_driver = {
 module_platform_driver(tegra_ahci_driver);
 
 MODULE_AUTHOR("Mikko Perttunen <mperttunen@nvidia.com>");
-MODULE_DESCRIPTION("Tegra124 AHCI SATA driver");
+MODULE_DESCRIPTION("Tegra AHCI SATA driver");
 MODULE_LICENSE("GPL v2");
-- 
2.1.4

