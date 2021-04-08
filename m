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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3135DC433B4
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 16:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA416113A
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 16:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhDHQk5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:40:57 -0400
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:7200
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232331AbhDHQkv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 8 Apr 2021 12:40:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfPVjA2de2iv5ruBr5VW+xX/AbvqX2gFEWIHiGoSIJUSWzW5tsizDiW4LBcbbuQ/y3Olb+wCc1mxNT5apwJE1St0o2UTRXCDY84WNmaFELAWxJeIOhPlIMgQBBsOpkBhIrlYsJVWxWbaFHJuYlJdQb7nwY/hFI6YsBkhsEseDesHIV1AJLwM3b+QAIKvhX4l3ZOumEEZ585+q98pzzTkLJfDzpqxBBiNMSOovOs6HKVrp8WOrrh6sVsCbXqFJdunwxlsAd1B+LpDP8+rznnWQEvRTqQB968LmtR2EzqeqHyz7s+iPzQJfKUD88pA6VQGSxVKWJwKok5Ttz6LPNQGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35hfr5ZZ65G5kjr6Uosor2+IgWxXobrsYnF2sOyxmBA=;
 b=nNKV/+2arBjBJy2acE5Ocv16XH15A4O/G3Q9ENgoC16BT0UITxjNu449wr/VRl3dAu0AEsc3f3N0S6I8NY6v7NDZP7S+3ohx4uxjQgBAkDuqXsQoiLa49o2f/6/AsLavd2X65aqXCc40e79sgz7FkDNy8mbjQ81yp/8Cog48m76cxGRdsuXWWZsx8rB8uy3sTOFaj8Ms8OzC21tInVr7SqCVB5Sa8+elf56PjCVi+878aiFmtfOdxAvA8OlfNyA4GMJh6o8igXqX5CCizAOeDGEZG2lri0HGWHeNFrcwdTkiVjbMSz1dNpBh8oujogrMbF5vAleMd091bB6vS+9vNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35hfr5ZZ65G5kjr6Uosor2+IgWxXobrsYnF2sOyxmBA=;
 b=Qk3TeNkNRjdsNz8/oPNxl5SEFZaSjzdE+7FC3eZaGbTVznJZDxItP00FZVz6hFiWUcPFbdbHKjWTC/c4VK/An90oMMd3txgYkzcU0B6VgOo/JV0DMH437unz30GvA9bxj99gRWadbnlLyHE6DDG/LVWlpAiYGVnori9zFa7TxudKhyoP0NXxQK65rsSxVNadycRbtCRgGuwbZ7Rg/E+HbFQ/lkHl9YtLOwXlIZQjJ2ecrc6dYstHnQirZ8S/DFE1GGsLAUH6RXbU6Dim3qNLrLkCZWyqZNQ9SACtaKQTto8nT9zoHakqeTOEwrEDAGvyR2ZB9GY+1AFLUgrjRnxg5w==
Received: from BN6PR17CA0011.namprd17.prod.outlook.com (2603:10b6:404:65::21)
 by BYAPR12MB2631.namprd12.prod.outlook.com (2603:10b6:a03:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 8 Apr
 2021 16:40:38 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::a4) by BN6PR17CA0011.outlook.office365.com
 (2603:10b6:404:65::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 16:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 16:40:37 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Apr
 2021 09:40:37 -0700
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Apr 2021 16:40:36 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <axboe@kernel.dk>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-ide@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] ata: ahci_tegra: call tegra_powergate_power_off only when PM domain is not present
Date:   Thu, 8 Apr 2021 09:40:43 -0700
Message-ID: <1617900043-10506-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617900043-10506-1-git-send-email-skomatineni@nvidia.com>
References: <1617900043-10506-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bddd10d7-5e71-4022-bf25-08d8faad0a48
X-MS-TrafficTypeDiagnostic: BYAPR12MB2631:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26318380D80C5E0D392D41C1C2749@BYAPR12MB2631.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLNnFY7q8xyL1Dc21xjX2lxnlv+RrTNmol2a+0P3Xaej5KDmOqfv0GdTQatkG0Lq7Yh9h3FYufrW7J2LGGfpeFlgYZkYiVsRIvBeThWTPm7B1W3kXwYmK7NXUGIAJYTvuQVNFIN0WWPYEGr/rlEhgZoifP56a4CIi2zIok0uM7aYND0bt+X1yBM2vIFrwtVSho8IGypFae5uuTc4dlg9izbmF45KHuSINb2FiztO7/t+HSLQh7iaklAdZT1mxLnMpPl6uJ2WUbR8AFXnrprBg4tS2MWTQK/Jjj9GPYxmZiesfov8B4XOnNfSW1dM7A9Pl13rNJatcVtt8YO7kEDnjGvmf7NntLiiCuvm76XBqgQqz1DA4cRHG40YpXWg2oMm6a1CjvMastYWVYpnbBh6Eu6XUc+J8ts1vkleyq1ekebuZW7kA6BjfGKNPVPLRYGkk5KcnJJ5pf2DO0+xtEGeYMe9nSdGzvLwqqwM1MTpwL3WVNKJzvXNJWykhV8JKU8mvQEWxluyxh2BNF0K6WOJYH3TEFCE2N9yxgRSK9Y7fP758I2fOD6YefT3e9QOAAe4GIHGGkFd/CEez3ZN2Xnf0cHNjvz+EZyWnxVO9yeRHZgt3bPCWXpqe5lnkcfMV88k/GAlAXXT2bGE58c2zJuJUU1wDSXUUyIz7pzYHejWt9hZ32Z4NOIBoM6scrE7kBXD83tjOHLiQnHzYLyYq8rZvgejmMcv7aY2JuKirp41fN0=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(47076005)(8936002)(54906003)(110136005)(478600001)(8676002)(70206006)(966005)(7636003)(336012)(82740400003)(356005)(186003)(4326008)(26005)(36860700001)(6666004)(316002)(426003)(2616005)(4744005)(5660300002)(82310400003)(36756003)(83380400001)(7696005)(86362001)(2906002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 16:40:37.9902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bddd10d7-5e71-4022-bf25-08d8faad0a48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2631
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch adds a check on present of PM domain and calls legacy power
domain API tegra_powergate_power_off() only when PM domain is not present.

This is a follow-up patch to Tegra186 AHCI support patch series
https://lore.kernel.org/patchwork/cover/1408752/

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

---
 drivers/ata/ahci_tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 56612af..bd484dd 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -287,7 +287,8 @@ static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
 	reset_control_assert(tegra->sata_cold_rst);
 
 	clk_disable_unprepare(tegra->sata_clk);
-	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
+	if (!tegra->pdev->dev.pm_domain)
+		tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
 
 	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
 }
-- 
2.7.4

