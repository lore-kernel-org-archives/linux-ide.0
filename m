Return-Path: <SRS0=jz0E=C7=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C404C4727E
	for <linux-ide@archiver.kernel.org>; Tue, 22 Sep 2020 10:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A552399A
	for <linux-ide@archiver.kernel.org>; Tue, 22 Sep 2020 10:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OISU278T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIVKQR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Sep 2020 06:16:17 -0400
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82]:18981
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbgIVKQR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 22 Sep 2020 06:16:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWuwmyL6Hg0fpJj5B2ROMlXa6ySahUyfBVOFFVoacVfN4ww1yI8ENNgPO4BhDuA9UAtSmXm0o/9I7t1pwu1pRNNalupmAEPg0thOCKWorSgOaKX9Sk5vXjrH1rH5I4/ssa8RtUV/U69Rkn82xayPxVMvyIqMNHHoiCHDs2N86ridqffCdZUw+Rmk4LTAj74pB/M/A6ZuZS9as5I/mCB3nOIN3fX1LwycYA6DZq9YNXqysRDPLJexZ5e/fFjg9UR21YtteLl4zVhJlxHDTXMiDqRgfZn25E5llCnAw5KCrgjDbOOaMmjuL4ifPKJZRgPNnboeASbEAfmI9sWwtvp8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkC/uzAKgdKdGgROSU1H/z94wWubU8q48TjQpw7YGLw=;
 b=AiTs8RX1vGpBBOizsyA391GyqAyyiswj7NDHrm8jv06nBi9YsWBfist+JYP3eVNp0jLrq2nhkOuuWbeoj2Kt8cFgwIj2QNYTJyIOjIv50RMvlGgWV3gnlW36TIeLVt/Jd2uzL20uvp2zV2GztefpChAk+fn1DBimO0VF1mD3Mn4sthrxHTHe+X+MLIeJBKJhxNfKTeWsgtA3IvVVkrEj+RsCp8L6JeZyYUK5CWq8BuTabLgVnypWFnbrPAc9gYMRlN9rnbU9DJpWiAWhVpZXoEFDm/idqr2ro0L0hptO8VkRrKN2/GG0P5RNdvv9xVWmwEiZlGro25ctw1hGk5RXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkC/uzAKgdKdGgROSU1H/z94wWubU8q48TjQpw7YGLw=;
 b=OISU278Tv0UYwVFGwXWWV2zJL772SHjRpJGqde+Zk8yrUm2Z9g0/TxWnTEYuaRFFy2qP2wsF+97ifn5Bpih3VQgPn1rirYP38RiViiKgLr191s9/xqKv0UTUNL5nyzmig/PO2q06Vund1rrMSgTL5BWK43uvFH2Q1cMag+1wM/w=
Received: from SN4PR0401CA0040.namprd04.prod.outlook.com
 (2603:10b6:803:2a::26) by SN6PR02MB3920.namprd02.prod.outlook.com
 (2603:10b6:805:2b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.21; Tue, 22 Sep
 2020 10:16:13 +0000
Received: from SN1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2a:cafe::a8) by SN4PR0401CA0040.outlook.office365.com
 (2603:10b6:803:2a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15 via Frontend
 Transport; Tue, 22 Sep 2020 10:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT043.mail.protection.outlook.com (10.152.72.184) with Microsoft SMTP
 Server id 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 10:16:12
 +0000
Received: from [149.199.38.66] (port=47640 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kKfL4-0005x6-GR; Tue, 22 Sep 2020 03:15:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kKfLI-0001nH-N8; Tue, 22 Sep 2020 03:16:12 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08MAG85I010530;
        Tue, 22 Sep 2020 03:16:08 -0700
Received: from [10.140.6.6] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kKfLE-0001dQ-1W; Tue, 22 Sep 2020 03:16:08 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     axboe@kernel.dk, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com, sgoud@xilinx.com,
        michal.simek@xilinx.com, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH V2 1/2] dt-bindings: ata: ahci: ceva: Update documentation for CEVA Controller
Date:   Tue, 22 Sep 2020 15:45:12 +0530
Message-Id: <1600769713-944-2-git-send-email-piyush.mehta@xilinx.com>
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
X-MS-Office365-Filtering-Correlation-Id: a7e3f28b-7673-41d4-2a86-08d85ee08892
X-MS-TrafficTypeDiagnostic: SN6PR02MB3920:
X-Microsoft-Antispam-PRVS: <SN6PR02MB3920D8D404750F67885A343AD43B0@SN6PR02MB3920.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gxliQDw+C6c+YVy4qTQgWwokSBybvHbgUkpu7DC+JjevKRSDgvmWvdB3d0rr3nRPjLV3BejCBDVkT7ylmnbQo6X3rYa/DfKdPPKK1a6MyZrmQJb2tOFr3Njj3wpLOfUyc6xlT6rwNHY8dw9Oa3/auzlEqjbs4sCnPArGxzrvpX77TF7zkjKoREIqhtOREbtBwKruZxtU3WENffCbLBtgn7nNYfC5WhKqF2VD6pUu+XcKegNqnNbmv2JWin4cTz3xNtqavx/cBW2lI97aXcGTwwNB1JIzqiiHO7M1WApzSRiBRKNB5OlNIIWQwsR8+g+IZaMMUCnX0U/Schn0vBuq86nxM+wgvkb3JdrUc1jp4/twXNu3j61p5cIVxo2mDq4F2sgOlcXb1y7hp1ozRAQYA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(39860400002)(46966005)(4326008)(107886003)(316002)(81166007)(15650500001)(186003)(26005)(9786002)(8676002)(82310400003)(36756003)(356005)(83380400001)(44832011)(2616005)(6666004)(8936002)(47076004)(70206006)(70586007)(478600001)(426003)(336012)(5660300002)(2906002)(7696005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 10:16:12.9820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e3f28b-7673-41d4-2a86-08d85ee08892
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT043.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB3920
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch updates the documentation for the CEVA controller for adding
the optional properties for 'phys' and 'resets'.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 Documentation/devicetree/bindings/ata/ahci-ceva.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-ceva.txt b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
index 7561cc4..da423eb 100644
--- a/Documentation/devicetree/bindings/ata/ahci-ceva.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-ceva.txt
@@ -38,6 +38,9 @@ Required properties:
 
 Optional properties:
   - ceva,broken-gen2: limit to gen1 speed instead of gen2.
+  - phys: phandle for the PHY device
+  - phy-names: Should be "sata-phy"
+  - resets: phandle to the reset controller for the SATA IP
 
 Examples:
 	ahci@fd0c0000 {
@@ -56,4 +59,7 @@ Examples:
 		ceva,p1-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
 		ceva,p1-retry-params = /bits/ 16 <0x0216 0x7F06>;
 		ceva,broken-gen2;
+		phy-names = "sata-phy";
+		phys = <&psgtr 1 PHY_TYPE_SATA 1 1>;
+		resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
 	};
-- 
2.7.4

