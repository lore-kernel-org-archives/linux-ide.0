Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C2EC433B4
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 01:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21366124C
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 01:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347714AbhDGBZn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 6 Apr 2021 21:25:43 -0400
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:40288
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241916AbhDGBZg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 6 Apr 2021 21:25:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqEKBGqMb11CffBLAPKLuzm3lS0/QsAyMTWREsaw8JKP4dxG9UblFH/8Q8z4Lah+Z3x+0N82tbdk/rOg8Xr58PJ/6cmQvL02u/umCZiUM55I9+QpUInhfs3kIjCDYb0ehMQK5vUGHJXNg4BApqPC5aNUR1uScsge5wJ8ZPo6D2/mwVMBK1McvkvVtpw25O6fIQZhnn3Ng+5bQ0dZ5DjWygoNdJCUMw8AjRojt7I7Ki3wr6mAa7u26aFpQ9sPG//EeXxSYGUfgYw3kHrhkv0kRt8nO1V0oWn6DSlawC6v/yoJBoIwKoygOnQ11jDhS08ETcHHFEw+neL9HpcCY2I1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqvYhM4gfczmD1UkOCBSQi6kCpayixLg2a8u43aYS8U=;
 b=MdesH2FaQUhC4fn/zHn1tvqIzsbUvR0vFnyEcmRDFMxHzhAUtVstGiL+pvs8k9SxFhDjGFUei8waVjqLx9vPqejJS2MduXNlzlc2BZmpF4F4urMjf66Hw+Jsr1m0pm7gqDHZS+LsrqMPUnZvJ0tS6HTlwasoTiC3sK2xxCnrqb0dcdY05ocaz8KhcmnCftjHpQ9NN9aQvIZC7wlwfEG1rhFMV/UObkP6XCym5F0Ilq5T0+CbniUye+suyBwMYJBgRqZlxqMI6fmjoxeoECQcwmnYDDqMoaBn74vfnDu7XeWcp1t7TzgsX2FebMpZ5b+xaM2oBpblHNDm4t8TtHqUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqvYhM4gfczmD1UkOCBSQi6kCpayixLg2a8u43aYS8U=;
 b=UFrV01WNEcGqtq6cHInkgcdR0vLt1ZzTpDttdEpA5sHi9BEu8NuOLsuvaYrM28ifLx5ROFkzkAlVEvSbGSjPqsML6PnZGGh2F5q/HsRT+SBuAFQE5ALHw6bpvbI+AQM40YXfICVcfFL2vvMfhksUUF3y0PYpLF9WoWn4ARtZkF1sCeQU4Y3deNpZFP3EPRhXQuf2/ymTjXKknX/e1WTXF3EblYMLIbByfzN9x+l4ROMxlTlzKKsh1BtuEbtOOMGXSW3NJ4lQbu2+aav4+x+2gtrOOurB+M45HLzFA9uuLxJTAXqo3S2V6UwPaAJVR9LdVsF0h/kygBXmjdSLcJm50A==
Received: from BN6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:404:13f::34)
 by BYAPR12MB2662.namprd12.prod.outlook.com (2603:10b6:a03:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 01:25:25 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::2b) by BN6PR14CA0048.outlook.office365.com
 (2603:10b6:404:13f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 01:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Wed, 7 Apr 2021 01:25:25 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Apr
 2021 18:25:25 -0700
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 01:25:24 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <axboe@kernel.dk>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <pchandru@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] ata: ahci_tegra: Add AHCI support for Tegra186
Date:   Tue, 6 Apr 2021 18:25:31 -0700
Message-ID: <1617758731-12380-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4647add8-3cad-4493-d8b9-08d8f964058b
X-MS-TrafficTypeDiagnostic: BYAPR12MB2662:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2662CE8FF1CBAB354F5A2EF2C2759@BYAPR12MB2662.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yEunpsal8ksTm970Fry0vTMPrZcoVUihyNktDFJTfNryujKbM7mC7EqHvEx+TNl2D3VdypAPY+XhjL5c7iG3+aMrDnW6yWaIj041CDW9sY0Lylc1KGHDsUB1rSIBiRXGBHQuAkhB5F3Sw6NTFJBG8ss2VJIjWUnPCuYbMjmtZoDJpRfs0poWwCiwDRCcVnqlJjh7RfsPa7yvLGRQudjA3kf3rScWhOLhRs4bvnB/oIoqZLaABzifmlq5vhmMEqMz1Uey/nIaPN6WtnwpqraxyaEViQPlxEpNHtGYcC1oxWOY6UmGNTSHdTXsPDKi80rzHdi5JbxtYm7GbmedPVTDbzBXedqNeBh75jauvfobODqRXeKvtwGdPGRg2arMQtLqO4lpLMeo+b2poOJposO5FYiLc7uQVVhMN2/HEPTfrAAhFs6QktL7gjWEynHjvtCqiLrAGpKALz1BQwNA6HoWvfW+UprJtyICvte6U5ZkZgfjVWyWo3V5DJgaBDa+PjkZlmHH81/nZ8Z3DUK4UOm2xDYhuCaj1WGNcOULTR5+qB/HbnAATh3zynjWfqxLnAhNLRvrFRwBkkt9kVnb4VTq+tolOqjFJMU4A9HHx5C/LDEgVARQOtfw5wxyzPHk7Rs8ady+6ExEYc8b+0rDNNQit4CkVHjpmP/sAmL7wTO0dfw=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(7696005)(5660300002)(36860700001)(36756003)(4326008)(26005)(356005)(7636003)(82740400003)(2616005)(8676002)(186003)(316002)(70206006)(6666004)(336012)(82310400003)(2906002)(70586007)(8936002)(47076005)(426003)(54906003)(478600001)(86362001)(83380400001)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 01:25:25.5893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4647add8-3cad-4493-d8b9-08d8f964058b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2662
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

