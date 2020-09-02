Return-Path: <SRS0=9WFx=CL=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2188CC433E7
	for <linux-ide@archiver.kernel.org>; Wed,  2 Sep 2020 07:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC6F20826
	for <linux-ide@archiver.kernel.org>; Wed,  2 Sep 2020 07:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VYlfLjec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIBHGP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:06:15 -0400
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:32321
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726726AbgIBHGN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 2 Sep 2020 03:06:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOt7Bl3azWq60DMTD2mq8q7X2xk28MvxkeToq6TARml1t1MRCUygZ0ksknyf/VrYuLFALVJBQFFUOZAhcwZsSpGZehMoXSDZT2xN/R9rQryUDf38u4NkHeRtuOEbL/ahh1J+p3dV+PRb5htlYn1S6R/BbIFRncrUWfybDjm/oIcgX1AkAP5Rvo7qjBY814fJ4Qgf3HdQJF1fkkvfqCkJBdEoZKit7I1NeQA1t+0W5T060Urv3teAK1KqM+RQNotgf1RiA4XpZ/va0spuDEG7zWdrlqzYiRle7+FDLdVU1Mj1Yp1p6FU1IEOQeC41v8Rujd7zvgB0OPo+Cr9maq5FHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHV6IAM0JscFTKjpRqYQwGoC5l6ct9xkLOxUMgX3Sds=;
 b=PFs005HWdSGVNICpS5ox/eQYUWib+A9KYY5t3Bl7IrgiC9WHOrL9gXi6kgNYb34H40K7cUMtxCwn/AKrKaFk6NDjl5Os85y7hdtptJ2lnyNP7X0XgUy5oxNWugGwUd0r/XJYECBNHCp64wzQdJIHbp0mXSlb3thwxN1j7IaEyux/PS15RYF1F3nwlaUtt8Z1LatVCwj2izHjEVso9cXKpeRdYKY0biS42XgjTkxt+r0NAsa7CaG8UBM57U7dR6szcPwfNDOyPOqpQR0EGxdGSe25DtF36fzGg7AhZlVsYlzJpJRpmaVo9omBujA39CJ+BU0S0Dkf/X09kWTR99scjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHV6IAM0JscFTKjpRqYQwGoC5l6ct9xkLOxUMgX3Sds=;
 b=VYlfLjec4a4BOptNFlTp5MSClTVo72ta/Mn88FMjb49ko09kGW8RCU9+n10tPo6WDVO4cbXDl4VaThes3t4AlXIJtxXmwRWvP3dejkzScUfhUxnxwgYyj79qfZD1APg35UzIOOqNlNM+5aIopwcinfLTc2ON+jo72IgWSUXKSps=
Received: from MN2PR19CA0055.namprd19.prod.outlook.com (2603:10b6:208:19b::32)
 by DM5PR02MB2715.namprd02.prod.outlook.com (2603:10b6:3:112::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 07:06:08 +0000
Received: from BL2NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:19b:cafe::f0) by MN2PR19CA0055.outlook.office365.com
 (2603:10b6:208:19b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 2 Sep 2020 07:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT037.mail.protection.outlook.com (10.152.77.11) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 07:06:08
 +0000
Received: from [149.199.38.66] (port=38714 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kDMqJ-0005ae-Lh; Wed, 02 Sep 2020 00:06:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kDMqN-0002NL-Ov; Wed, 02 Sep 2020 00:06:07 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08275wtG004139;
        Wed, 2 Sep 2020 00:05:58 -0700
Received: from [10.140.6.6] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kDMqD-0002Ee-OK; Wed, 02 Sep 2020 00:05:58 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     axboe@kernel.dk, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com, sgoud@xilinx.com,
        michal.simek@xilinx.com, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH 1/2] ata: ahci: ceva: Update the driver to support xilinx GT phy
Date:   Wed,  2 Sep 2020 12:35:47 +0530
Message-Id: <1599030348-3334-2-git-send-email-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599030348-3334-1-git-send-email-piyush.mehta@xilinx.com>
References: <1599030348-3334-1-git-send-email-piyush.mehta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 72391fd3-543c-4c99-e4f5-08d84f0eaa7b
X-MS-TrafficTypeDiagnostic: DM5PR02MB2715:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2715A6E3776D925BA15D2564D42F0@DM5PR02MB2715.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zX0ssyYTIh+YpByftGemdnSnfic/GAzjBjHnpwIlqey7dOBSQsv1pclKG2Ui7iKXZGddsxysLCS8eX9ja0MUdc/XajcJvaUnyZpPXNPwvDubG+UNRI7PmktPCwdGGcrnOp85lt5SdBlgMQWZjF37sYApBvR5u/lsLbsQedFiQp6AEWQ1H/m3YhfeJzXL/4LXMjV9l/aVQwn5+xBaUAlf/TYwlrKERG7+dnODXalXSFFKhCxDeNpZ02vQyKxIZyfBi5/blTwOuS/Pp7MfxHcuyg0EQDDjuDLTVg0rUloP2FO/ApcKxDATxOdIwLDN9dj/4k2r+mrZ1Adn3eWOMqckx0X0nhBsj8LaFoWsuagbOUC9cB5/xBUaxxHaHCzHHy8K8UZYHd6ed7Ewajno17MrXQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(136003)(39860400002)(396003)(346002)(46966005)(70206006)(107886003)(316002)(2906002)(8936002)(5660300002)(336012)(8676002)(70586007)(44832011)(6666004)(4326008)(2616005)(82740400003)(9786002)(478600001)(26005)(426003)(36756003)(47076004)(7696005)(83380400001)(15650500001)(82310400003)(186003)(81166007)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 07:06:08.1227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72391fd3-543c-4c99-e4f5-08d84f0eaa7b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2715
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

SATA controller used in Xilinx ZynqMP platform uses xilinx GT phy
which has 4 GT lanes and can used by 4 peripherals at a time.
SATA controller uses 1 GT phy lane among the 4 GT lanes. To configure
the GT lane for SATA controller, the below sequence is expected.

1. Assert the SATA controller reset.
2. Configure the xilinx GT phy lane for SATA controller (phy_init).
3. De-assert the SATA controller reset.
4. Wait for PLL of the GT lane used by SATA to be locked (phy_power_on).

The ahci_platform_enable_resources() by default does the phy_init()
and phy_power_on() but the default sequence doesn't work with Xilinx
platforms. Because of this reason, updated the driver to support the
new sequence.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 drivers/ata/ahci_ceva.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index b10fd4c..5341d89 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include "ahci.h"
 
 /* Vendor Specific Register Offsets */
@@ -87,6 +88,7 @@ struct ceva_ahci_priv {
 	u32 axicc;
 	bool is_cci_enabled;
 	int flags;
+	struct reset_control *rst;
 };
 
 static unsigned int ceva_ahci_read_id(struct ata_device *dev,
@@ -194,7 +196,7 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 	struct ahci_host_priv *hpriv;
 	struct ceva_ahci_priv *cevapriv;
 	enum dev_dma_attr attr;
-	int rc;
+	int rc, i;
 
 	cevapriv = devm_kzalloc(dev, sizeof(*cevapriv), GFP_KERNEL);
 	if (!cevapriv)
@@ -202,14 +204,42 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 
 	cevapriv->ahci_pdev = pdev;
 
+	cevapriv->rst = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(cevapriv->rst)) {
+		if (PTR_ERR(cevapriv->rst) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get reset: %ld\n",
+				PTR_ERR(cevapriv->rst));
+		return PTR_ERR(cevapriv->rst);
+	}
+
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-	rc = ahci_platform_enable_resources(hpriv);
+	rc = ahci_platform_enable_clks(hpriv);
 	if (rc)
 		return rc;
 
+	/* Assert the controller reset */
+	reset_control_assert(cevapriv->rst);
+
+	for (i = 0; i < hpriv->nports; i++) {
+		rc = phy_init(hpriv->phys[i]);
+		if (rc)
+			return rc;
+	}
+
+	/* De-assert the controller reset */
+	reset_control_deassert(cevapriv->rst);
+
+	for (i = 0; i < hpriv->nports; i++) {
+		rc = phy_power_on(hpriv->phys[i]);
+		if (rc) {
+			phy_exit(hpriv->phys[i]);
+			return rc;
+		}
+	}
+
 	if (of_property_read_bool(np, "ceva,broken-gen2"))
 		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
 
-- 
2.7.4

