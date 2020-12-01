Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD956C64E8A
	for <linux-ide@archiver.kernel.org>; Tue,  1 Dec 2020 08:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89AAB2085B
	for <linux-ide@archiver.kernel.org>; Tue,  1 Dec 2020 08:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgLAILY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 1 Dec 2020 03:11:24 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35430 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgLAILY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 1 Dec 2020 03:11:24 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3BB8D1A0A4D;
        Tue,  1 Dec 2020 09:10:37 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 42FB21A0A4A;
        Tue,  1 Dec 2020 09:10:35 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 502EA402BC;
        Tue,  1 Dec 2020 09:10:32 +0100 (CET)
From:   andy.tang@nxp.com
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH] ahci: qoriq: update the port register settings
Date:   Tue,  1 Dec 2020 16:18:41 +0800
Message-Id: <20201201081841.16228-1-andy.tang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

The default values for Port register PORT_PHY2 and PORT_PHY3
are better, no need to overwrite them.
The following boards are affected: ls208x, ls1088a, ls1043a,
ls1046a, ls1028a and ls1012a.

Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
---
 drivers/ata/ahci_qoriq.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 5b46fc9aeb4a..896e4dba8500 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -32,8 +32,6 @@
 
 /* port register default value */
 #define AHCI_PORT_PHY_1_CFG	0xa003fffe
-#define AHCI_PORT_PHY2_CFG	0x28184d1f
-#define AHCI_PORT_PHY3_CFG	0x0e081509
 #define AHCI_PORT_TRANS_CFG	0x08000029
 #define AHCI_PORT_AXICC_CFG	0x3fffffff
 
@@ -197,8 +195,6 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 			       ECC_DIS_ARMV8_CH2,
 			       qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
-		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
-		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
 			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
@@ -206,8 +202,6 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 
 	case AHCI_LS2080A:
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
-		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
-		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
 			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
@@ -221,8 +215,6 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 			       ECC_DIS_ARMV8_CH2,
 			       qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
-		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
-		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
 			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
@@ -238,8 +230,6 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 			       ECC_DIS_LS1088A,
 			       qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
-		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
-		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
 			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
@@ -247,8 +237,6 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 
 	case AHCI_LS2088A:
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
-		writel(AHCI_PORT_PHY2_CFG, reg_base + PORT_PHY2);
-		writel(AHCI_PORT_PHY3_CFG, reg_base + PORT_PHY3);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
 			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
-- 
2.17.1

