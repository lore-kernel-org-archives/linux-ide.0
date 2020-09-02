Return-Path: <SRS0=9WFx=CL=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4957C433E2
	for <linux-ide@archiver.kernel.org>; Wed,  2 Sep 2020 07:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD5520826
	for <linux-ide@archiver.kernel.org>; Wed,  2 Sep 2020 07:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IWP7kpuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBHGP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:06:15 -0400
Received: from mail-eopbgr750053.outbound.protection.outlook.com ([40.107.75.53]:28827
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbgIBHGM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 2 Sep 2020 03:06:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtfOEvDv88ZkOZ1olsWS1rRVPXScXAsMk0iSiyK+1/YOXT+bCNFOB+jopAumprEvY3SQHGt5mt8DsfGxkatO8wereqsFW7+tGtWR/oo+kvR59DUq8g6+r8SnSDQ96PsMLdu0P+N/rZr2QNAkRfNDOb9obFQUrtMeHoiiTqSEAvQB5qVYn7zITtwBBFp7s13qlyqoNPaIz4wrh75/rG5xHnZWyY4xeKlkvLO9gaZpW81TlT6xEvUg1e/1oJZdKJAC4rU72pVt/LUO5bfBfTcyULb2QyvVGsYM7ZHr7DPppoKI5JMGdeeB05Zx8Fcz5MDmkeM1agOK3UFfFd2VIQeEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5ZcI2StEtLtbbo2Wq2P3QI4ke/kDDrFTjr0fsAPqF0=;
 b=bQEV5LhSh0zrMRFOTXSyA9qCzKCT00INc1jWhZ8IVej0mGJre2+McjSMYMlwGQpi2VC0PDcTeJZ6OjwTGxx6akiZzW/Bw0KsIm7xeyxNcApEdbbv7rz3xiZ+kb2u1nYXXPDUX8PB2+ghUuZ/RShbeT453n5DOmKEh1UcROCepdMO+DlXgWyjW1EDkdqmhqPxbOTdENF5dkJneAvtZTchFHu7Srin5lBuWFt17PjHEnelCxNkn6ikaCtUm3oEKvX5mMlVCItc4lFItec1sDUpYN63tmBO4Uf6QdhjbtuzYVi9DwXIR278oGgaDpPP74pIzf9MkzE2QQFvqXENc9IOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5ZcI2StEtLtbbo2Wq2P3QI4ke/kDDrFTjr0fsAPqF0=;
 b=IWP7kpuzpaQHE58GOhGown6wzadqUy9zU0P7aZVP06OYxX2j9zLqSNav0gA2NdoSB+ej+gPPF9Y6ojryb9jHphRf6GHf3Kxd65fUp7l3/O44DCemUwgSRXk6t7YsLzPuePt0cpegKiznTD6NGfBVMVh8x30T5x0bO1fMCU89t14=
Received: from SN2PR01CA0019.prod.exchangelabs.com (2603:10b6:804:2::29) by
 BYAPR02MB4037.namprd02.prod.outlook.com (2603:10b6:a02:f4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15; Wed, 2 Sep 2020 07:06:08 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:804:2:cafe::17) by SN2PR01CA0019.outlook.office365.com
 (2603:10b6:804:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend
 Transport; Wed, 2 Sep 2020 07:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 07:06:08
 +0000
Received: from [149.199.38.66] (port=38717 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kDMqJ-0005ah-NG; Wed, 02 Sep 2020 00:06:03 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kDMqN-0002NL-QQ; Wed, 02 Sep 2020 00:06:07 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 082761Tm004155;
        Wed, 2 Sep 2020 00:06:01 -0700
Received: from [10.140.6.6] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kDMqG-0002Ee-NI; Wed, 02 Sep 2020 00:06:01 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     axboe@kernel.dk, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com, sgoud@xilinx.com,
        michal.simek@xilinx.com, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH 2/2] dt-bindings: ata: achi: ceva: Update documentation for CEVA Controller
Date:   Wed,  2 Sep 2020 12:35:48 +0530
Message-Id: <1599030348-3334-3-git-send-email-piyush.mehta@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: 76d98d78-769b-4439-8914-08d84f0eaa77
X-MS-TrafficTypeDiagnostic: BYAPR02MB4037:
X-Microsoft-Antispam-PRVS: <BYAPR02MB40375A2FA75530D5E21F9FE5D42F0@BYAPR02MB4037.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n02Ee6FDZRlOeS+D6s+QPszv1qJFIbWGaHMzZ0sWrSEoT55vIaXsH3d3j43DjSTIqRdRqXqUwL3Bc4e2wKOoq0r+Ewwg47u4gXmY2qdcdWr14ad3tuCu7B3Ov0u36j3eEiJiyhw2i+eBaJZF7gSLgGI7zFIefawzo2A2v5FsiVzN6IwrEl1/bsO1vzClsAd30IZQ52CuFY5Rm1vY0cvLXmePpdI3YqQUu8TZuWHI/G7hWSN8D3UULIMMTWwEm433DDLMROGYI4Y06nHkQU70QV5T1pwqNKxyLBcm5VGbXFuhx7ebnhFqEVvyOdXCvwQDHEmYubdsoY2Ci8lhOAzx5EULmzS2GOMSvZKLdXJyEbWuTraqbteRNRsQgep/wOCI8DsoEipyQQHKsJzpIolaAQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(39860400002)(346002)(376002)(136003)(396003)(46966005)(2906002)(7696005)(8936002)(15650500001)(70586007)(81166007)(316002)(82310400003)(83380400001)(70206006)(5660300002)(8676002)(6666004)(356005)(4326008)(426003)(36756003)(478600001)(107886003)(26005)(336012)(82740400003)(47076004)(9786002)(2616005)(186003)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 07:06:08.0932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d98d78-769b-4439-8914-08d84f0eaa77
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4037
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch updates the documentation for the CEVA controller for adding
the required properties for 'phys' and 'resets'.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 Documentation/devicetree/bindings/ata/ahci-ceva.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
index 7561cc4..f01d317 100644
--- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
@@ -35,6 +35,10 @@ Required properties:
 			ceva,pN-retry-params = /bits/ 16 <RIT RCT>;
 			RIT:  Retry Interval Timer.
 			RCT:  Rate Change Timer.
+  - phys: phandle for the PHY device
+  - phy-names: Should be "sata-phy"
+  - resets: phandle to the reset controller for the SATA IP
+  - reset-names: Should be "sata_rst".
 
 Optional properties:
   - ceva,broken-gen2: limit to gen1 speed instead of gen2.
@@ -56,4 +60,8 @@ Examples:
 		ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
 		ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
 		ceva,broken-gen2;
+		phy-names = "sata-phy";
+		phys = <&psgtr 1 PHY_TYPE_SATA 1 1>;
+		reset-names = "sata_rst";
+		resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
 	};
-- 
2.7.4

