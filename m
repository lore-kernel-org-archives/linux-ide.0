From: Preetham Chandru Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V7 3/7] ata: ahci_tegra: Update initialization sequence
Date: Mon, 12 Feb 2018 22:56:42 +0530
Message-ID: <1518456406-21564-4-git-send-email-pchandru@nvidia.com>
References: <1518456406-21564-1-git-send-email-pchandru@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518456406-21564-1-git-send-email-pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, cyndis-/1wQRMveznE@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: preetham260-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, pkunapuli-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

From: Preetham Ramchandra <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Update the controller initialization sequence and move
t124 specifics to tegra124_ahci_init.

Signed-off-by: Preetham Chandru R <pchandru-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
v7:
* moveed tegra124_ahci_soc_data definition to be
  just above the of_device_id table.
---
 drivers/ata/ahci_tegra.c | 288 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 223 insertions(+), 65 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 3a62eb246d80..7ffe8a97447a 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -34,7 +34,8 @@
 #define DRV_NAME "tegra-ahci"
 
 #define SATA_CONFIGURATION_0				0x180
-#define SATA_CONFIGURATION_EN_FPCI			BIT(0)
+#define SATA_CONFIGURATION_0_EN_FPCI			BIT(0)
+#define SATA_CONFIGURATION_0_CLK_OVERRIDE			BIT(31)
 
 #define SCFG_OFFSET					0x1000
 
@@ -45,17 +46,55 @@
 #define T_SATA0_CFG_1_SERR				BIT(8)
 
 #define T_SATA0_CFG_9					0x24
-#define T_SATA0_CFG_9_BASE_ADDRESS_SHIFT		13
+#define T_SATA0_CFG_9_BASE_ADDRESS			0x40020000
 
 #define SATA_FPCI_BAR5					0x94
-#define SATA_FPCI_BAR5_START_SHIFT			4
+#define SATA_FPCI_BAR5_START_MASK			(0xfffffff << 4)
+#define SATA_FPCI_BAR5_START				(0x0040020 << 4)
+#define SATA_FPCI_BAR5_ACCESS_TYPE			(0x1)
 
 #define SATA_INTR_MASK					0x188
 #define SATA_INTR_MASK_IP_INT_MASK			BIT(16)
 
+#define T_SATA0_CFG_35					0x94
+#define T_SATA0_CFG_35_IDP_INDEX_MASK			(0x7ff << 2)
+#define T_SATA0_CFG_35_IDP_INDEX			(0x2a << 2)
+
+#define T_SATA0_AHCI_IDP1				0x98
+#define T_SATA0_AHCI_IDP1_DATA				(0x400040)
+
+#define T_SATA0_CFG_PHY_1				0x12c
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
+#define T_SATA0_CFG2NVOOB_2				0x134
+#define T_SATA0_CFG2NVOOB_2_COMWAKE_IDLE_CNT_LOW_MASK	(0x1ff << 18)
+#define T_SATA0_CFG2NVOOB_2_COMWAKE_IDLE_CNT_LOW	(0xc << 18)
+
 #define T_SATA0_AHCI_HBA_CAP_BKDR			0x300
+#define T_SATA0_AHCI_HBA_CAP_BKDR_PARTIAL_ST_CAP	BIT(13)
+#define T_SATA0_AHCI_HBA_CAP_BKDR_SLUMBER_ST_CAP	BIT(14)
+#define T_SATA0_AHCI_HBA_CAP_BKDR_SALP			BIT(26)
+#define T_SATA0_AHCI_HBA_CAP_BKDR_SUPP_PM		BIT(17)
+#define T_SATA0_AHCI_HBA_CAP_BKDR_SNCQ			BIT(30)
 
 #define T_SATA0_BKDOOR_CC				0x4a4
+#define T_SATA0_BKDOOR_CC_CLASS_CODE_MASK		(0xffff << 16)
+#define T_SATA0_BKDOOR_CC_CLASS_CODE			(0x0106 << 16)
+#define T_SATA0_BKDOOR_CC_PROG_IF_MASK			(0xff << 8)
+#define T_SATA0_BKDOOR_CC_PROG_IF			(0x01 << 8)
 
 #define T_SATA0_CFG_SATA				0x54c
 #define T_SATA0_CFG_SATA_BACKDOOR_PROG_IF_EN		BIT(12)
@@ -82,6 +121,27 @@
 #define T_SATA0_CHX_PHY_CTRL11				0x6d0
 #define T_SATA0_CHX_PHY_CTRL11_GEN2_RX_EQ		(0x2800 << 16)
 
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
+#define SATA_AUX_MISC_CNTL_1_0_DEVSLP_OVERRIDE		BIT(17)
+#define SATA_AUX_MISC_CNTL_1_0_SDS_SUPPORT		BIT(13)
+#define SATA_AUX_MISC_CNTL_1_0_DESO_SUPPORT		BIT(15)
+
+#define SATA_AUX_RX_STAT_INT_0				0xc
+#define SATA_AUX_RX_STAT_INT_0_SATA_DEVSLP		BIT(7)
+
+#define SATA_AUX_SPARE_CFG0_0				0x18
+#define SATA_AUX_SPARE_CFG0_0_MDAT_TIMER_AFTER_PG_VALID	BIT(14)
+
 #define FUSE_SATA_CALIB					0x124
 #define FUSE_SATA_CALIB_MASK				0x3
 
@@ -99,6 +159,14 @@ static const struct sata_pad_calibration tegra124_pad_calibration[] = {
 	{0x14, 0x0e, 0x1a, 0x0e},
 };
 
+struct tegra_ahci_ops {
+	int (*init)(struct ahci_host_priv *hpriv);
+};
+
+struct tegra_ahci_soc {
+	struct tegra_ahci_ops	ops;
+};
+
 struct tegra_ahci_priv {
 	struct platform_device	   *pdev;
 	void __iomem		   *sata_regs;
@@ -108,8 +176,53 @@ struct tegra_ahci_priv {
 	/* Needs special handling, cannot use ahci_platform */
 	struct clk		   *sata_clk;
 	struct regulator_bulk_data supplies[5];
+	struct tegra_ahci_soc	   *soc_data;
 };
 
+static int tegra124_ahci_init(struct ahci_host_priv *hpriv)
+{
+	struct tegra_ahci_priv *tegra = hpriv->plat_data;
+	struct sata_pad_calibration calib;
+	int ret;
+	u32 val;
+
+	/* Pad calibration */
+	ret = tegra_fuse_readl(FUSE_SATA_CALIB, &val);
+	if (ret)
+		return ret;
+
+	calib = tegra124_pad_calibration[val & FUSE_SATA_CALIB_MASK];
+
+	writel(BIT(0), tegra->sata_regs + SCFG_OFFSET + T_SATA0_INDEX);
+
+	val = readl(tegra->sata_regs +
+		    SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL1_GEN1);
+	val &= ~T_SATA0_CHX_PHY_CTRL1_GEN1_TX_AMP_MASK;
+	val &= ~T_SATA0_CHX_PHY_CTRL1_GEN1_TX_PEAK_MASK;
+	val |= calib.gen1_tx_amp << T_SATA0_CHX_PHY_CTRL1_GEN1_TX_AMP_SHIFT;
+	val |= calib.gen1_tx_peak << T_SATA0_CHX_PHY_CTRL1_GEN1_TX_PEAK_SHIFT;
+	writel(val, tegra->sata_regs + SCFG_OFFSET +
+	       T_SATA0_CHX_PHY_CTRL1_GEN1);
+
+	val = readl(tegra->sata_regs +
+		    SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL1_GEN2);
+	val &= ~T_SATA0_CHX_PHY_CTRL1_GEN2_TX_AMP_MASK;
+	val &= ~T_SATA0_CHX_PHY_CTRL1_GEN2_TX_PEAK_MASK;
+	val |= calib.gen2_tx_amp << T_SATA0_CHX_PHY_CTRL1_GEN1_TX_AMP_SHIFT;
+	val |= calib.gen2_tx_peak << T_SATA0_CHX_PHY_CTRL1_GEN1_TX_PEAK_SHIFT;
+	writel(val, tegra->sata_regs + SCFG_OFFSET +
+	       T_SATA0_CHX_PHY_CTRL1_GEN2);
+
+	writel(T_SATA0_CHX_PHY_CTRL11_GEN2_RX_EQ,
+	       tegra->sata_regs + SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL11);
+	writel(T_SATA0_CHX_PHY_CTRL2_CDR_CNTL_GEN1,
+	       tegra->sata_regs + SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL2);
+
+	writel(0, tegra->sata_regs + SCFG_OFFSET + T_SATA0_INDEX);
+
+	return 0;
+}
+
 static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 {
 	struct tegra_ahci_priv *tegra = hpriv->plat_data;
@@ -145,7 +258,6 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 
 disable_regulators:
 	regulator_bulk_disable(ARRAY_SIZE(tegra->supplies), tegra->supplies);
-
 	return ret;
 }
 
@@ -169,8 +281,7 @@ static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
 {
 	struct tegra_ahci_priv *tegra = hpriv->plat_data;
 	int ret;
-	unsigned int val;
-	struct sata_pad_calibration calib;
+	u32 val;
 
 	ret = tegra_ahci_power_on(hpriv);
 	if (ret) {
@@ -179,78 +290,114 @@ static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
 		return ret;
 	}
 
+	/*
+	 * Program the following SATA IPFS registers
+	 * to allow SW accesses to SATA's MMIO register range.
+	 */
+	val = readl(tegra->sata_regs + SATA_FPCI_BAR5);
+	val &= ~(SATA_FPCI_BAR5_START_MASK | SATA_FPCI_BAR5_ACCESS_TYPE);
+	val |= SATA_FPCI_BAR5_START | SATA_FPCI_BAR5_ACCESS_TYPE;
+	writel(val, tegra->sata_regs + SATA_FPCI_BAR5);
+
+	/* Program the following SATA IPFS register to enable the SATA */
 	val = readl(tegra->sata_regs + SATA_CONFIGURATION_0);
-	val |= SATA_CONFIGURATION_EN_FPCI;
+	val |= SATA_CONFIGURATION_0_EN_FPCI;
 	writel(val, tegra->sata_regs + SATA_CONFIGURATION_0);
 
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
-
-	writel(T_SATA0_CHX_PHY_CTRL11_GEN2_RX_EQ,
-		tegra->sata_regs + SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL11);
-	writel(T_SATA0_CHX_PHY_CTRL2_CDR_CNTL_GEN1,
-		tegra->sata_regs + SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL2);
-
-	writel(0, tegra->sata_regs + SCFG_OFFSET + T_SATA0_INDEX);
-
-	/* Program controller device ID */
+	/* Electrical settings for better link stability */
+	val = T_SATA0_CHX_PHY_CTRL17_0_RX_EQ_CTRL_L_GEN1;
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL17_0);
+	val = T_SATA0_CHX_PHY_CTRL18_0_RX_EQ_CTRL_L_GEN2;
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL18_0);
+	val = T_SATA0_CHX_PHY_CTRL20_0_RX_EQ_CTRL_H_GEN1;
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL20_0);
+	val = T_SATA0_CHX_PHY_CTRL21_0_RX_EQ_CTRL_H_GEN2;
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CHX_PHY_CTRL21_0);
+
+	/* For SQUELCH Filter & Gen3 drive getting detected as Gen1 drive */
+
+	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA_CFG_PHY_0);
+	val |= T_SATA_CFG_PHY_0_MASK_SQUELCH;
+	val &= ~T_SATA_CFG_PHY_0_USE_7BIT_ALIGN_DET_FOR_SPD;
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA_CFG_PHY_0);
+
+	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_NVOOB);
+	val &= ~(T_SATA0_NVOOB_COMMA_CNT_MASK |
+		 T_SATA0_NVOOB_SQUELCH_FILTER_LENGTH_MASK |
+		 T_SATA0_NVOOB_SQUELCH_FILTER_MODE_MASK);
+	val |= (T_SATA0_NVOOB_COMMA_CNT |
+		T_SATA0_NVOOB_SQUELCH_FILTER_LENGTH |
+		T_SATA0_NVOOB_SQUELCH_FILTER_MODE);
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_NVOOB);
+
+	/*
+	 * Change CFG2NVOOB_2_COMWAKE_IDLE_CNT_LOW from 83.3 ns to 58.8ns
+	 */
+	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG2NVOOB_2);
+	val &= ~T_SATA0_CFG2NVOOB_2_COMWAKE_IDLE_CNT_LOW_MASK;
+	val |= T_SATA0_CFG2NVOOB_2_COMWAKE_IDLE_CNT_LOW;
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG2NVOOB_2);
+
+	if (tegra->soc_data->ops.init)
+		tegra->soc_data->ops.init(hpriv);
+
+	/*
+	 * Program the following SATA configuration registers
+	 * to initialize SATA
+	 */
+	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_1);
+	val |= (T_SATA0_CFG_1_IO_SPACE | T_SATA0_CFG_1_MEMORY_SPACE |
+		T_SATA0_CFG_1_BUS_MASTER | T_SATA0_CFG_1_SERR);
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_1);
+	val = T_SATA0_CFG_9_BASE_ADDRESS;
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_9);
 
+	/* Program Class Code and Programming interface for SATA */
 	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_SATA);
 	val |= T_SATA0_CFG_SATA_BACKDOOR_PROG_IF_EN;
 	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_SATA);
 
-	writel(0x01060100, tegra->sata_regs + SCFG_OFFSET + T_SATA0_BKDOOR_CC);
+	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_BKDOOR_CC);
+	val &=
+	    ~(T_SATA0_BKDOOR_CC_CLASS_CODE_MASK |
+	      T_SATA0_BKDOOR_CC_PROG_IF_MASK);
+	val |= T_SATA0_BKDOOR_CC_CLASS_CODE | T_SATA0_BKDOOR_CC_PROG_IF;
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_BKDOOR_CC);
 
 	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_SATA);
 	val &= ~T_SATA0_CFG_SATA_BACKDOOR_PROG_IF_EN;
 	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_SATA);
 
-	/* Enable IO & memory access, bus master mode */
-
-	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_1);
-	val |= T_SATA0_CFG_1_IO_SPACE | T_SATA0_CFG_1_MEMORY_SPACE |
-		T_SATA0_CFG_1_BUS_MASTER | T_SATA0_CFG_1_SERR;
-	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_1);
-
-	/* Program SATA MMIO */
-
-	writel(0x10000 << SATA_FPCI_BAR5_START_SHIFT,
-	       tegra->sata_regs + SATA_FPCI_BAR5);
+	/* Enabling LPM capabilities through Backdoor Programming */
+	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_AHCI_HBA_CAP_BKDR);
+	val |= (T_SATA0_AHCI_HBA_CAP_BKDR_PARTIAL_ST_CAP |
+		T_SATA0_AHCI_HBA_CAP_BKDR_SLUMBER_ST_CAP |
+		T_SATA0_AHCI_HBA_CAP_BKDR_SALP |
+		T_SATA0_AHCI_HBA_CAP_BKDR_SUPP_PM);
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_AHCI_HBA_CAP_BKDR);
+
+	/* SATA Second Level Clock Gating configuration
+	 * Enabling Gating of Tx/Rx clocks and driving Pad IDDQ and Lane
+	 * IDDQ Signals
+	 */
+	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_35);
+	val &= ~T_SATA0_CFG_35_IDP_INDEX_MASK;
+	val |= T_SATA0_CFG_35_IDP_INDEX;
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_35);
+
+	val = T_SATA0_AHCI_IDP1_DATA;
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_AHCI_IDP1);
+
+	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_PHY_1);
+	val |= (T_SATA0_CFG_PHY_1_PADS_IDDQ_EN |
+		T_SATA0_CFG_PHY_1_PAD_PLL_IDDQ_EN);
+	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_PHY_1);
+
+	/* Enabling IPFS Clock Gating */
+	val = readl(tegra->sata_regs + SATA_CONFIGURATION_0);
+	val &= ~SATA_CONFIGURATION_0_CLK_OVERRIDE;
+	writel(val, tegra->sata_regs + SATA_CONFIGURATION_0);
 
-	writel(0x08000 << T_SATA0_CFG_9_BASE_ADDRESS_SHIFT,
-	       tegra->sata_regs + SCFG_OFFSET + T_SATA0_CFG_9);
 
 	/* Unmask SATA interrupts */
 
@@ -285,8 +432,17 @@ static const struct ata_port_info ahci_tegra_port_info = {
 	.port_ops	= &ahci_tegra_port_ops,
 };
 
+static const struct tegra_ahci_soc tegra124_ahci_soc_data = {
+	.ops = {
+		.init = tegra124_ahci_init,
+	},
+};
+
 static const struct of_device_id tegra_ahci_of_match[] = {
-	{ .compatible = "nvidia,tegra124-ahci" },
+	{
+		.compatible = "nvidia,tegra124-ahci",
+		.data = &tegra124_ahci_soc_data
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, tegra_ahci_of_match);
@@ -313,6 +469,8 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 	hpriv->plat_data = tegra;
 
 	tegra->pdev = pdev;
+	tegra->soc_data =
+	    (struct tegra_ahci_soc *)of_device_get_match_data(&pdev->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	tegra->sata_regs = devm_ioremap_resource(&pdev->dev, res);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
