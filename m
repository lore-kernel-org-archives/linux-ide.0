Return-Path: <SRS0=9WFx=CL=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D8FC2BB56
	for <linux-ide@archiver.kernel.org>; Wed,  2 Sep 2020 07:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3368C20826
	for <linux-ide@archiver.kernel.org>; Wed,  2 Sep 2020 07:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QD2RkVw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIBHGK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:06:10 -0400
Received: from mail-mw2nam10on2074.outbound.protection.outlook.com ([40.107.94.74]:59041
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbgIBHGA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 2 Sep 2020 03:06:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bs1hr1MRIIOUaXRUGYTKnMYQ1Elqx5GXS7Ni28Db7qokeFL0vpQKmJfkp2jLWjku1AdmbVPkyivd65HYTrEDVm3AbXX93frLmk3OutSkgr4DqGiEDZbajLoXpKN84Vm4jZQsVJ7MKzyUuYOQzyTXZPMS42s+aySrdr/B+BYcF6LrgZd7Tp1lP1fPrFNDVaju/jJ1GE3eqhOAh+jM15hhFu08VrJjFEdkGPLcZFj6etv1oU3BRSSEL21grlghzirCiUMfJFClce8efvdZkR3AS9BP+fKhLCHebx+beR7gZntwpATfbHRaJ2oljFtJiKKApXU/TkNSUuV8zrLvK5FVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+pKfQ6Bw8b1c02d89GwZAgSlUe3x4w8rGFSDPE0R3Q=;
 b=F/fvTxEP8hivVkNlFgJyy4s/ETE6L98erRQZcSH7eEgz8Vpv6oDuZvl1HJCFjPQw9Ric/pFpOfHQAarzzw+jz6yrxmh7xW9O8vmQbndC0wH5fDw0ASKnNo+1xlPgCyPC7tAzNGHlaZrSS2z0/DWhEupitidzOhEEY5FyByXvSwgmsaeI5jNmO1PzdjjItWE3tP4y0VRnCyhP33Req8b9jMYKOyxWrFEWVU3GKQ6gFNgv6wKUysEkhcosf9KkqYSDNcYbD2PujrvIwws2zJesRwftduog4Ag0HRNwh5BORIWGMB2KbjM5BPppJCqyc2PYYmXxSgK1C1bwyhA1oiwBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+pKfQ6Bw8b1c02d89GwZAgSlUe3x4w8rGFSDPE0R3Q=;
 b=QD2RkVw0Ba7K8j5UGqrk1zR5YUWL9e+5kQn8uN9yI5oClzsVzAhpSrgclfF5wP98Gvb/rcvpGRomWdzGH+4bbE/35Oskqb3/Gfgd1J0U+D1rxNAuCTm2n0l5h1kGOCfpYYEYwCqmIbskXQ7AoU0Fxi6z4JRyUr2GgI8ObqQqbAY=
Received: from CY4PR2201CA0008.namprd22.prod.outlook.com
 (2603:10b6:910:5f::18) by BN6PR02MB3364.namprd02.prod.outlook.com
 (2603:10b6:405:63::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 2 Sep
 2020 07:05:58 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:5f:cafe::9e) by CY4PR2201CA0008.outlook.office365.com
 (2603:10b6:910:5f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 2 Sep 2020 07:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 07:05:57
 +0000
Received: from [149.199.38.66] (port=38190 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kDMq9-0005aM-Bs; Wed, 02 Sep 2020 00:05:53 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kDMqD-0002GP-Ew; Wed, 02 Sep 2020 00:05:57 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08275tZk004135;
        Wed, 2 Sep 2020 00:05:55 -0700
Received: from [10.140.6.6] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kDMqA-0002Ee-Nd; Wed, 02 Sep 2020 00:05:55 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     axboe@kernel.dk, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com, sgoud@xilinx.com,
        michal.simek@xilinx.com, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH 0/2] ata: ahci: ceva: Update the driver to support xilinx GT phy
Date:   Wed,  2 Sep 2020 12:35:46 +0530
Message-Id: <1599030348-3334-1-git-send-email-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e564ad56-0b80-4fa8-70e0-08d84f0ea457
X-MS-TrafficTypeDiagnostic: BN6PR02MB3364:
X-Microsoft-Antispam-PRVS: <BN6PR02MB336475ACC8734CDDBABBF936D42F0@BN6PR02MB3364.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g4SuJnW42jhTOLGOcV/gQ8VSlAY1/HNwwGzbNpuRbvXEMMb8RCU4L+7T1SrLGB6d0fXqZz6+NnqsI3iDERIk1VQ4Oa4M8ayA30sybbHnwaV16AT2yPjDgmwPSkqXHdHMOVeWWvhpI0Xgy2Udx4fbadi4WzYzXpUBIj25HLsvN/xmAwZHli+aUf0msM6AMlJHGk/h7Bl2na8VIl04BDS/FIqX6fd//5jfnqJUcNC5iJHJnhwnExWbZxwOyQTc4JnK8Goo0FgUeyPoexH9XIaTOeZJ1Vt5D48AdvXqQsO0kxe3IBUPOsmrXCVqV8DygKYvREfuLNiTPcxCUj7NfMDXH+wXelUseg0ovauoqunab4D65ogRFLcaoZFVfcdWImq48Hynr6x/h8JH9F+PsOEwFQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(376002)(346002)(39860400002)(396003)(46966005)(336012)(8936002)(186003)(8676002)(70206006)(83380400001)(82310400003)(356005)(82740400003)(478600001)(70586007)(81166007)(4744005)(6666004)(47076004)(5660300002)(9786002)(4326008)(316002)(2906002)(15650500001)(44832011)(107886003)(36756003)(26005)(7696005)(2616005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 07:05:57.8155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e564ad56-0b80-4fa8-70e0-08d84f0ea457
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3364
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch series updates the ceva driver to add support for Xilinx GT phy.
This also updates the documentation with the device tree binding required
for working with Xilinx GT phy.

Piyush Mehta (2):
  ata: ahci: ceva: Update the driver to support xilinx GT phy
  dt-bindings: ata: achi: ceva: Update documentation for CEVA Controller

 .../devicetree/bindings/ata/ahci-ceva.txt          |  8 +++++
 drivers/ata/ahci_ceva.c                            | 34 ++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.7.4

