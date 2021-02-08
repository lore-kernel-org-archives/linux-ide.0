Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63946C43332
	for <linux-ide@archiver.kernel.org>; Mon,  8 Feb 2021 18:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4212564E37
	for <linux-ide@archiver.kernel.org>; Mon,  8 Feb 2021 18:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhBHSD0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:03:26 -0500
Received: from mail-eopbgr760077.outbound.protection.outlook.com ([40.107.76.77]:29669
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235236AbhBHSAN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 8 Feb 2021 13:00:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZQStIJ0FE17xqCSTRrTQDZQ2vX55pM/lrWJFWJNc05BEeAYG6PhrB6pwiJ5r5yJwjRvf93ni5dtqdsGMoVcRBk5H/eSO1YEov6+67oQ+wmZvMfIB3K305IU9qMGOB13BH4iQcZTWtBPklp+WLEqVvX7uLmPuslTswcJA6Bse+N22c4dspkQbO4kQjIRTsWp+H2xVhfAGkSyF157iFtEG7x3YAN1K6NMqn2Yx0MW+cTp3bQKqaMOTsscejDcb5z1ACV9pm0jYNsA0fJlrDgL8KCeGt6+ll0QiWC04uVj4ThN5M3DZlyYCWHH/f1rKeZhN/Rt5s5R4f5DXYO3M5jHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tKvTFjJ8fywYP0+J9ySI6yQXoCrIEfkiOSVHPIvL8c=;
 b=nA26O58rN1s0A4Q0GjpTvbRuHxz9PEuClB2RCDRP34S6uiXVQsIuNSM/w+ZRZ/vrULxSZwD1fMZlizwpwSYnDywD4dgwPbGsAJ9V7WZ4Fnah3opbuvPX0goRYJjKZXztrQ5JCqPq0f+xgghe+UOkeTnbC7qJN4CmEAjtZcn2OKnQ2Hk5Bwxz66408G9NQPtNYfKJ5Ga4h+66tKrTYwPvalYd+2kkRlH+517whFDxfq1Uine/VvmvO03qVFc5TRWlqniDJ/Ie0cpSmc203vm/whWZ8y3NlU3Ak8U+i9yH7rEmMUSAnDOBQfvwk8g9QLwBUgXRGDTptOwnZuOLmhaujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.dk smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tKvTFjJ8fywYP0+J9ySI6yQXoCrIEfkiOSVHPIvL8c=;
 b=R6T5W8VXYCS7muFb6ldjHLPDvwzrkEPgLavfr7SzQmhHZPNdTepp0mZlscYiuRJggC7I4acsXjgDKRbMPTgW080nmLgsMEqMX8qIdgdBVV6CiMI7ZN/s3u9aoHs0oKaYpdE95iGKlQ+liMYhU7FEcWfHF35PD7LksuHK+K3np3E=
Received: from SN4PR0401CA0015.namprd04.prod.outlook.com
 (2603:10b6:803:21::25) by DM5PR02MB2313.namprd02.prod.outlook.com
 (2603:10b6:3:50::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Mon, 8 Feb
 2021 17:59:21 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21::4) by SN4PR0401CA0015.outlook.office365.com
 (2603:10b6:803:21::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend
 Transport; Mon, 8 Feb 2021 17:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Mon, 8 Feb 2021 17:59:21 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 8 Feb 2021 09:59:06 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 8 Feb 2021 09:59:06 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 axboe@kernel.dk,
 p.zabel@pengutronix.de,
 robh+dt@kernel.org,
 linux-ide@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.35] (port=55682 helo=xhdsaipava40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1l9AoS-0001aF-Tw; Mon, 08 Feb 2021 09:59:05 -0800
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <axboe@kernel.dk>, <p.zabel@pengutronix.de>, <robh+dt@kernel.org>
CC:     <linux-ide@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        <sgoud@xilinx.com>, <michal.simek@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH V3 1/2] dt-bindings: ata: ahci: ceva: Update documentation for CEVA Controller
Date:   Mon, 8 Feb 2021 23:33:55 +0530
Message-ID: <1612807436-5238-2-git-send-email-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612807436-5238-1-git-send-email-piyush.mehta@xilinx.com>
References: <1612807436-5238-1-git-send-email-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63061964-8f48-4c0f-5e2e-08d8cc5b4323
X-MS-TrafficTypeDiagnostic: DM5PR02MB2313:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2313808B204E850C73842BB3D48F9@DM5PR02MB2313.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PfpZmlmD9Bjhmajp1ax46diAxVz2kcE0Ra8xQRAHY+/NCDtZEKih8e0lWdaoSzbgiZCqPYHCc/umG4FKF6JtmsEorVdTK/wTYwRQTFI/moPxOllvKm2YfrE2mVCyKBehVCky9yOgN/UrhWBJ1kmOvoqtN0q7qhyyakOQYnGcE4kDixkMxCQLB0bLlB5GqDtMGvR/JBGKPC9axznN0PLlRjAqI6Be4/iYIprHktI8vjfhfm1G7gteFrGXu+lwyUJL4xUty2OL5zBVDvJ9mykCqy3ItgjGIx7aod+pXtso2KYHAPFmCslyorVbO9C8tErEf7Cocqie6vlPFAzXktn6w5pPuw2fMBp4jJhMuFzP9XrJ+MXxlV5fOh7hNpAKmCaAuTdjXvqJUxiOASNjDMLfKcgwRiWUzq+DXR8o8DvodwTILg0oyCB5/xi3n13LJ+w3kPBAnA/iE5B5o46S+BJX1R48lvdX0GKuyhKhTgUxzqFbXQezhU8Y4LCF9r9U/cCfOSaepHwL+sGX0+qoPcIp3M21LSVwyAJyxGVI38CD/fU2T2IGQX5QX6OhUidz0R7ot1i1n+wRfVeytEKz1pE2KsACJMLVJ2thxNHByey/8OF8jXhES/Vaky4yWdTxwdyN0oLeknvKE230CxP4JaUkh7/Qc8Tn1b74jpB5sKhmFMdZ5E09UYyX5hmSWFJGPL0R
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(8676002)(107886003)(4326008)(82310400003)(5660300002)(36906005)(7636003)(36756003)(316002)(54906003)(426003)(9786002)(47076005)(6666004)(15650500001)(8936002)(110136005)(2906002)(478600001)(70586007)(26005)(82740400003)(7696005)(83380400001)(186003)(336012)(36860700001)(2616005)(70206006)(44832011)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 17:59:21.2597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63061964-8f48-4c0f-5e2e-08d8cc5b4323
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2313
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch updates the documentation for the CEVA controller for adding
the optional properties for 'phys' and 'resets'.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 Documentation/devicetree/bindings/ata/ahci-ceva.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
index 7561cc4..bfb6da0 100644
--- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
@@ -38,6 +38,8 @@ Required properties:
 
 Optional properties:
   - ceva,broken-gen2: limit to gen1 speed instead of gen2.
+  - phys: phandle for the PHY device
+  - resets: phandle to the reset controller for the SATA IP
 
 Examples:
 	ahci@fd0c0000 {
@@ -56,4 +58,6 @@ Examples:
 		ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
 		ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
 		ceva,broken-gen2;
+		phys = <&psgtr 1 PHY_TYPE_SATA 1 1>;
+		resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
 	};
-- 
2.7.4

