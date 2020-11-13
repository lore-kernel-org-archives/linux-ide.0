Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B85C63697
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 19:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE55F22256
	for <linux-ide@archiver.kernel.org>; Fri, 13 Nov 2020 19:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aZ+jQqCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgKMTg7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 13 Nov 2020 14:36:59 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17905 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgKMTg6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 13 Nov 2020 14:36:58 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5faee0620000>; Fri, 13 Nov 2020 11:37:06 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Nov
 2020 19:36:57 +0000
Received: from skomatineni-linux.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 13 Nov 2020 19:36:57 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/6] ata: ahci_tegra: Add AHCI support for Tegra186
Date:   Fri, 13 Nov 2020 11:36:58 -0800
Message-ID: <1605296218-2510-7-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
References: <1605296218-2510-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605296226; bh=bqvYhM4gfczmD1UkOCBSQi6kCpayixLg2a8u43aYS8U=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:X-NVConfidentiality:MIME-Version:Content-Type;
        b=aZ+jQqCxEUboM6XMeiPKoCEOuxVDCK2qK9ZYY91Lrurh0i8Qk0zZIAJxChDhmABuY
         wXBWGDaWuVwKxEiDZ0UekIUuRxAGfImLtrueFb2MR4UYmvyNsO8N87GzOz+lnWO+95
         LF+Ei/Mco1X34nwfxN/Mj/pRrRPKWW7Ia8BQn3TXA6w/X4QD74xCSDqcR1twyThBoT
         ZsHikWXhsfPzIMAv70mHNK6O/KpY/3MSKw73UKsFTBung5xXQAhJUMK+Fl5aiQY0iP
         Nhk8KOJS5nkhYkoOjf8IQB/xLVfhiB1vB+cWhHCLaTAFPlY30MGEq8KEmW5AaGH7go
         imu80vOPrKDzg==
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch adds support for AHCI-compliant Serial ATA controller
on Tegra186 SoC.

Tegra186 does not have sata-oob reset.
Tegra186 SATA_NVOOB register filed COMMA_CNT position and width are
different compared to Tegra210 and prior.

So, this patch adds a flag has_sata_oob_rst and tegra_ahci_regs to
SoC specific strcuture tegra_ahci_soc and updated their implementation
accordingly.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/ata/ahci_tegra.c | 60 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index cb55ebc1..56612af 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -59,8 +59,6 @@
 #define T_SATA0_CFG_PHY_1_PAD_PLL_IDDQ_EN		BIT(22)
 
 #define T_SATA0_NVOOB                                   0x114
-#define T_SATA0_NVOOB_COMMA_CNT_MASK                    (0xff << 16)
-#define T_SATA0_NVOOB_COMMA_CNT                         (0x07 << 16)
 #define T_SATA0_NVOOB_SQUELCH_FILTER_MODE_MASK          (0x3 << 24)
 #define T_SATA0_NVOOB_SQUELCH_FILTER_MODE               (0x1 << 24)
 #define T_SATA0_NVOOB_SQUELCH_FILTER_LENGTH_MASK        (0x3 << 26)
@@ -154,11 +152,18 @@ struct tegra_ahci_ops {
 	int (*init)(struct ahci_host_priv *hpriv);
 };
 
+struct tegra_ahci_regs {
+	unsigned int nvoob_comma_cnt_mask;
+	unsigned int nvoob_comma_cnt_val;
+};
+
 struct tegra_ahci_soc {
 	const char *const		*supply_names;
 	u32				num_supplies;
 	bool				supports_devslp;
+	bool				has_sata_oob_rst;
 	const struct tegra_ahci_ops	*ops;
+	const struct tegra_ahci_regs	*regs;
 };
 
 struct tegra_ahci_priv {
@@ -240,11 +245,13 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 	if (ret)
 		return ret;
 
-	ret = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_SATA,
-						tegra->sata_clk,
-						tegra->sata_rst);
-	if (ret)
-		goto disable_regulators;
+	if (!tegra->pdev->dev.pm_domain) {
+		ret = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_SATA,
+							tegra->sata_clk,
+							tegra->sata_rst);
+		if (ret)
+			goto disable_regulators;
+	}
 
 	reset_control_assert(tegra->sata_oob_rst);
 	reset_control_assert(tegra->sata_cold_rst);
@@ -330,10 +337,10 @@ static int tegra_ahci_controller_init(struct ahci_host_priv *hpriv)
 	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA_CFG_PHY_0);
 
 	val = readl(tegra->sata_regs + SCFG_OFFSET + T_SATA0_NVOOB);
-	val &= ~(T_SATA0_NVOOB_COMMA_CNT_MASK |
+	val &= ~(tegra->soc->regs->nvoob_comma_cnt_mask |
 		 T_SATA0_NVOOB_SQUELCH_FILTER_LENGTH_MASK |
 		 T_SATA0_NVOOB_SQUELCH_FILTER_MODE_MASK);
-	val |= (T_SATA0_NVOOB_COMMA_CNT |
+	val |= (tegra->soc->regs->nvoob_comma_cnt_val |
 		T_SATA0_NVOOB_SQUELCH_FILTER_LENGTH |
 		T_SATA0_NVOOB_SQUELCH_FILTER_MODE);
 	writel(val, tegra->sata_regs + SCFG_OFFSET + T_SATA0_NVOOB);
@@ -449,15 +456,35 @@ static const struct tegra_ahci_ops tegra124_ahci_ops = {
 	.init = tegra124_ahci_init,
 };
 
+static const struct tegra_ahci_regs tegra124_ahci_regs = {
+	.nvoob_comma_cnt_mask = GENMASK(30, 28),
+	.nvoob_comma_cnt_val = (7 << 28),
+};
+
 static const struct tegra_ahci_soc tegra124_ahci_soc = {
 	.supply_names = tegra124_supply_names,
 	.num_supplies = ARRAY_SIZE(tegra124_supply_names),
 	.supports_devslp = false,
+	.has_sata_oob_rst = true,
 	.ops = &tegra124_ahci_ops,
+	.regs = &tegra124_ahci_regs,
 };
 
 static const struct tegra_ahci_soc tegra210_ahci_soc = {
 	.supports_devslp = false,
+	.has_sata_oob_rst = true,
+	.regs = &tegra124_ahci_regs,
+};
+
+static const struct tegra_ahci_regs tegra186_ahci_regs = {
+	.nvoob_comma_cnt_mask = GENMASK(23, 16),
+	.nvoob_comma_cnt_val = (7 << 16),
+};
+
+static const struct tegra_ahci_soc tegra186_ahci_soc = {
+	.supports_devslp = false,
+	.has_sata_oob_rst = false,
+	.regs = &tegra186_ahci_regs,
 };
 
 static const struct of_device_id tegra_ahci_of_match[] = {
@@ -469,6 +496,10 @@ static const struct of_device_id tegra_ahci_of_match[] = {
 		.compatible = "nvidia,tegra210-ahci",
 		.data = &tegra210_ahci_soc
 	},
+	{
+		.compatible = "nvidia,tegra186-ahci",
+		.data = &tegra186_ahci_soc
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, tegra_ahci_of_match);
@@ -518,10 +549,13 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 		return PTR_ERR(tegra->sata_rst);
 	}
 
-	tegra->sata_oob_rst = devm_reset_control_get(&pdev->dev, "sata-oob");
-	if (IS_ERR(tegra->sata_oob_rst)) {
-		dev_err(&pdev->dev, "Failed to get sata-oob reset\n");
-		return PTR_ERR(tegra->sata_oob_rst);
+	if (tegra->soc->has_sata_oob_rst) {
+		tegra->sata_oob_rst = devm_reset_control_get(&pdev->dev,
+							     "sata-oob");
+		if (IS_ERR(tegra->sata_oob_rst)) {
+			dev_err(&pdev->dev, "Failed to get sata-oob reset\n");
+			return PTR_ERR(tegra->sata_oob_rst);
+		}
 	}
 
 	tegra->sata_cold_rst = devm_reset_control_get(&pdev->dev, "sata-cold");
-- 
2.7.4

