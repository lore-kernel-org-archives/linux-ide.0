Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF54C43462
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78EC161179
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 20:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhDHUzU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:55:20 -0400
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:57057
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231897AbhDHUzT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 8 Apr 2021 16:55:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwvgO19qknv5AIRorJLS22lzo0fk2TG9ZujWKoUakiXCuoGxGTnCDwmeHhsrlQg9OOFMnPu0wHmodojxhAZNS4tZ9fTjBSrHkwQW/RbU5kQQ5dRJgAiVCZ7UYk5l5dKtF4p2+4V40MkOYkyHu2VqexMJW1Mx7tJVArYlJTZM+u773rN5KFsZWfgwhhY+3tSooI1gpo/7wsoRP3YoGeE9Dn1y4vAnhinCamyCBQVxmw1lKjhl/uBfvUwg64wyO53XB6WrjWrKX3LZvyydaT0N6ztsxr3L1qPFjmATaqKOdjbuupeJvXvyyIQp8MBZ50vWCCo0ag+0hpuoHHTuTuzA5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsHD62F4rrlzTZQ3QAgoAGUDmkPqsNUS+LxK3YE/Gts=;
 b=RLG2L8tJIt0ucWINLeGA1fXr/2//B3ywEuTfUTQ2lnpeMWQKpwHkJAPetmBbg9ZoRsg938JcBcLcZs6uaKEmiH4Gxhmbm2H2z5QPPjK2A5hqbEBydQDFHw2W7G+Akx2vXH9tEsG5hrqWaMWv7XgZWXIHQ5eFZgWH6g48TvpL+kiQV6G9u8zyVb0nvOqkpO9jmj4goWBxFC8wlQfjaPchV2ZCSJblNiq/iby0NY3sGMvajn2GlmCOqVM21GXNUE5Bh3Psjz1d5hCzX6esjWc8AueQ/CUb2Kn5Yx0Dffm61E5w/d22T4Lsi8G1/jzxJUu5+e3GuZMgraJGD+ZC1suLdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsHD62F4rrlzTZQ3QAgoAGUDmkPqsNUS+LxK3YE/Gts=;
 b=MJ88fwhFO2IMnntuIv7Y/n1Yuxcr+/ogsNznvUsZkMEoXavoJ8jgqY2PjZ/4cLRkodR0m350R9TP1WkvsvSWi4lLfkjMFL0ZXwQ4bwT4Z/AYKpvI+X3dzxzoVCUyTOXEw8JZ/4Dk03dn6uiwsVEfxmgqGL/i/w9UtJk3v1/HnOGgVAY86zZ+Vjr2SgJ8QcWt+3qy/tfN01IJKsjdCljF167Ktvtzh4oxZ0LX5jhHYlmSltSEsKcO7OR6/3QliwRXF4MoKgo9uzEHzl83O4KWPsXXejB3prO01UhHAdFrxxn0LuYerLucAAAjuogoUbWXrfTHLYYQ+FEg7SQXnDQJcQ==
Received: from BN9PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:fb::15)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 20:55:06 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::b7) by BN9PR03CA0040.outlook.office365.com
 (2603:10b6:408:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend
 Transport; Thu, 8 Apr 2021 20:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 20:55:06 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Apr
 2021 20:55:05 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Apr 2021 13:55:05 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <axboe@kernel.dk>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-ide@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ata: ahci_tegra: call tegra_powergate_power_off only when PM domain is not present
Date:   Thu, 8 Apr 2021 13:55:15 -0700
Message-ID: <1617915315-13639-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617915315-13639-1-git-send-email-skomatineni@nvidia.com>
References: <1617915315-13639-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90c90018-5d92-4686-4af6-08d8fad096d3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4226:
X-Microsoft-Antispam-PRVS: <BY5PR12MB422662521115B73D44774118C2749@BY5PR12MB4226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hQpDm4WMQEgLKt7M3rhvo9/ZaY0e9SfpNWTDtPM1Oi7p135B1Mp9eaci+1NNRYxLRFYJZoacBBO2kxZz7Z7Uu1jKQ8FeeZvbNCtQ8Ug2v3ykyeOfOrkNr7al+pnIQt7uCzUjeuAoulhL5yOym6i3sFfKYGPJH+nbIBgmXa+mgev+zSasxmAY6hDCMKFcr7vg1u0895QwNVU/Fq7fc6hnOdP3HtdEDbuEW2s84KJmVuOBlmhH/YSyWS5ACjtD3tkkUdhk7eTFrigPBdLf/4GjTnMF1ZZRTsAH3RMaKsWAaTRAtpayK/bAO1Wpr1T2qvDy3Hrvy1sHMCgGyHxHVVkf+QZht645e/MMVrg5woDSckTImO1u8FqgyF4F8LyA6BHHK39rgfzsy+eFCCu1/GB1OY2wYt6pVgfkhyyZFdp389wfLVCEchVYTD4kmLtHr/YIAGVfmez/5coqSxjLdftu1frQnaCWbExHf/lO6jjr8pMZqWxLiobeFNJQgwAxGaPnMBmSXdR+8I4U4Qm+3DUlq8QgS9L+rjZsGEWxG7G+qJmSwv15WCGlT9VlS2mu3ziD/QZCbvIfhygaINzOkN+IJld65up9X9cSPbPS/KA4v2DA6n/f9FKS68JS9oXtrhLPDv0g6yedZ5zl2ADJeloipIPuRKGr7oJUgIqFhDXCMg=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966006)(36840700001)(336012)(316002)(70586007)(54906003)(36860700001)(110136005)(6666004)(426003)(5660300002)(4326008)(82310400003)(8936002)(83380400001)(8676002)(36756003)(36906005)(356005)(82740400003)(47076005)(2906002)(86362001)(186003)(478600001)(26005)(70206006)(2616005)(7636003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 20:55:06.1737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c90018-5d92-4686-4af6-08d8fad096d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch adds check to call legacy power domain API
tegra_powergate_power_off() only when PM domain is not present.

This is a follow-up patch to Tegra186 AHCI support patch series.
---
 drivers/ata/ahci_tegra.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 56612af..4fb94db 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -268,7 +268,8 @@ static int tegra_ahci_power_on(struct ahci_host_priv *hpriv)
 disable_power:
 	clk_disable_unprepare(tegra->sata_clk);
 
-	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
+	if (!tegra->pdev->dev.pm_domain)
+		tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
 
 disable_regulators:
 	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
@@ -287,7 +288,8 @@ static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
 	reset_control_assert(tegra->sata_cold_rst);
 
 	clk_disable_unprepare(tegra->sata_clk);
-	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
+	if (!tegra->pdev->dev.pm_domain)
+		tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
 
 	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
 }
-- 
2.7.4

