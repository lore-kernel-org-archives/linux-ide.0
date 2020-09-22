Return-Path: <SRS0=jz0E=C7=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BC3C2D0E2
	for <linux-ide@archiver.kernel.org>; Tue, 22 Sep 2020 10:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF98F2395C
	for <linux-ide@archiver.kernel.org>; Tue, 22 Sep 2020 10:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="FKGa/LYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgIVKQ1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Sep 2020 06:16:27 -0400
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com ([40.107.93.72]:31821
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbgIVKQ0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 22 Sep 2020 06:16:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeGCNf4lD4E0y4bvFDTtlij8F7DajHaenqf+ZvsK9VCOWwp/hvwNgHDjkS+/YLi+iLxB8ZG8YiqiEk+8Rb8bC6iM1RMIXP4woajKoG93nGwlqVAUiD3ePJxDKKIfcpz5aJGvX/AJ0K151Ap5UTiFR13roTP1o9Xh7Fk7j9avM4BGc5K9UxzxCZP1yFN4hYPhQA09n2mPY7wL8JMqhwHp3kX0owF/tRu9313TwTlUbDY8nvYRcyP6AgV02/JxbdK/ch3+DDaAScAnksFF/+9ZJf3+IFbzxjaEHwYZp4Lz9Ep7iXYjXL2hYheO+KKp5RTEg9+RSoeTGa4VgKBrGDuojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbev/vdcgjdrJxtsTaHgqs2qlRhGCIMgLsyqBmn9zg0=;
 b=aOnIgJYXvPo/4FnWokfAMNd+nqv65x9LE+ZF7wrfTp+S54i2Kh6OrKLl2Ii/KzaD9oyNpgnFJWzOf8MUUcobBNb+N5VbDeAMC6/LhoDeB6YOUVqacgb2rDi97ehWH9RqAM1YC91TlEqjq0ZVc5uz01lmWcQu54d9rHzsujVTTfwWDlI6SvuS6mq7RJcrbkr8BjomGTFMKByXGma3O6lNVYPmvSKzGzyIowmHv8PGkFdK6W9Mp24yNI7iFZQh24IwjL1o4uXXZpoUuWMPFFtwh+Wzj6a6/3GMuM1pnX14dMmB31mQ8GNU7ndZP/l4MugOVKxFGCtzhGIE75QjkdKFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbev/vdcgjdrJxtsTaHgqs2qlRhGCIMgLsyqBmn9zg0=;
 b=FKGa/LYJ9ZMIDTzjEMhBUmchUhSDZflwvG0dEbfxDyGXmZdJGmsg6lMAVAg+lYdB8yz00+PZd/hkfBw+pvJiBS+sXOLbQM9JLLWMfAhOdE4K2SNlEkB1L7tsiSC7cFu1LlUcbcC1L8wtLOGvXJ+w4U5BbRygL33dqh/iNY2oISg=
Received: from CY4PR06CA0072.namprd06.prod.outlook.com (2603:10b6:903:13d::34)
 by MN2PR02MB6638.namprd02.prod.outlook.com (2603:10b6:208:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Tue, 22 Sep
 2020 10:16:23 +0000
Received: from CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13d:cafe::e) by CY4PR06CA0072.outlook.office365.com
 (2603:10b6:903:13d::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Tue, 22 Sep 2020 10:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT038.mail.protection.outlook.com (10.152.74.217) with Microsoft SMTP
 Server id 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 10:16:23
 +0000
Received: from [149.199.38.66] (port=47904 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kKfLE-0005xO-LN; Tue, 22 Sep 2020 03:16:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kKfLS-0001r1-S0; Tue, 22 Sep 2020 03:16:22 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08MAGBlv010546;
        Tue, 22 Sep 2020 03:16:11 -0700
Received: from [10.140.6.6] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kKfLH-0001dQ-9j; Tue, 22 Sep 2020 03:16:11 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     axboe@kernel.dk, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com, sgoud@xilinx.com,
        michal.simek@xilinx.com, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH V2 2/2] ata: ahci: ceva: Update the driver to support xilinx GT phy
Date:   Tue, 22 Sep 2020 15:45:13 +0530
Message-Id: <1600769713-944-3-git-send-email-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600769713-944-1-git-send-email-piyush.mehta@xilinx.com>
References: <1600769713-944-1-git-send-email-piyush.mehta@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b9eea4f7-a92d-4ba2-e281-08d85ee08e9c
X-MS-TrafficTypeDiagnostic: MN2PR02MB6638:
X-Microsoft-Antispam-PRVS: <MN2PR02MB66386150787202A1F8C97B99D43B0@MN2PR02MB6638.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAzhErG1j58+UDl91lTLjfl/HKJUTUBpNmahXgpPVtOPD2rjBKIeCj3bDlg9w3NMdK97zsRxtGZ11E8LN1H/MtzH0tcGCB5F4CUiIvaqnUy+2a9SLL1UW2hkrZJH6FLFGCjwpRSuE0yutkBqop04SDDsVhmwK8lCfe8faBXzJeG25zmAF4e0qQ+1q4BQhILaoEjuaShw6j4S7rgif8R1/4i3D7gsVbvHq+Gitu5r9Gdt5+46svrSG3N2sM2jd7MikA17yrLGJeUYjpSK9PMLYjs8F8vjBl2GdFnc71/ohqmlf2zFCdBEDTz4IFmZ4MJIR8wtlcwUfzqYw7JcQI8l0XissRWztv8POvalcmEAfE1L235MEFqgrkY+CaYe0CQGTrULgRPl1a6Zlz0/xn+aDA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(346002)(46966005)(44832011)(26005)(186003)(356005)(36756003)(81166007)(426003)(316002)(336012)(107886003)(82310400003)(4326008)(70206006)(83380400001)(7696005)(70586007)(8936002)(15650500001)(5660300002)(8676002)(47076004)(9786002)(2616005)(2906002)(82740400003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 10:16:23.1176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9eea4f7-a92d-4ba2-e281-08d85ee08e9c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6638
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

Added is_rst_ctrl flag, for backward compatibility with the older
sequence. If the reset controller is not available, then the SATA
controller will configure with the older sequences.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 drivers/ata/ahci_ceva.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index b10fd4c..c704906 100644
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
+	int rc, i, is_rst_ctrl = 1;
 
 	cevapriv = devm_kzalloc(dev, sizeof(*cevapriv), GFP_KERNEL);
 	if (!cevapriv)
@@ -202,14 +204,47 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 
 	cevapriv->ahci_pdev = pdev;
 
+	cevapriv->rst = devm_reset_control_get(&pdev->dev, NULL);
+	if (IS_ERR(cevapriv->rst)) {
+		if (PTR_ERR(cevapriv->rst) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get reset: %ld\n",
+				PTR_ERR(cevapriv->rst));
+		is_rst_ctrl = 0;
+	}
+
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
+	if (is_rst_ctrl)
+		rc = ahci_platform_enable_clks(hpriv);
+	else
+		rc = ahci_platform_enable_resources(hpriv);
 
-	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
 
+	if (is_rst_ctrl) {
+		/* Assert the controller reset */
+		reset_control_assert(cevapriv->rst);
+
+		for (i = 0; i < hpriv->nports; i++) {
+			rc = phy_init(hpriv->phys[i]);
+			if (rc)
+				return rc;
+		}
+
+		/* De-assert the controller reset */
+		reset_control_deassert(cevapriv->rst);
+
+		for (i = 0; i < hpriv->nports; i++) {
+			rc = phy_power_on(hpriv->phys[i]);
+			if (rc) {
+				phy_exit(hpriv->phys[i]);
+				return rc;
+			}
+		}
+	}
+
 	if (of_property_read_bool(np, "ceva,broken-gen2"))
 		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
 
-- 
2.7.4

