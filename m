Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8608C433E0
	for <linux-ide@archiver.kernel.org>; Thu,  4 Mar 2021 15:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD1764F31
	for <linux-ide@archiver.kernel.org>; Thu,  4 Mar 2021 15:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbhCDPzA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:55:00 -0500
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:12644
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235997AbhCDPys (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 4 Mar 2021 10:54:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/e27UoTSyhR6GN9QtZMf698STwBn7m9Pug+VrbrRTjb9itblGYVqqiHP5+57dCi6Ik2RPz6dazw5anyJGVMqor7CpkPzH358u/+WvrX/d15vZ1N2gnN5JpLEsJu8ucNh2gyP7ByIIz0r5oLNFeblsrHTfWbyKDVmQGThuBP5zoIerPFQSsOickROfV7GygyUv/lLBCESS0CrPW3huBHpOVC2DMxAvVkbTqHJFesycw0zpLQWUOxlpckz39MIXvrc/iGp3JR7O0Xh/UY8VT4YIpVmYDPesvMbMzL2Ur948jp1CV2RH/ST+Y7dF0Hca7nb+7tEGunqO88ua94yGS2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6arrU01ZhUc80J2vbzfPV5GSY/ah929O+XCUmn/gQC4=;
 b=Ib/AsRvXa7U266kV2jQu+EQDdsUPBnnAlQt9igMMwduoxWjKQswJvRRzsrOZ0VdWRWVgnEcLw924H9aPL85Tx7gKBL07j1aDN+JLia/GNvPMnHBlhd70wgQSJUK/OEoffNB1LbSDck6FTunix9q2hEnEmzyH3IGkEUMOqrjAeKWS5xK4AvHaoNtee35iSFK7Ta+xr61egDu77yO4XDLr3jIULSki286Kcj6c4m5BCrRtehjyUByq6/mcncOVPWEtbI3mzrduxUlJchlEKMIglvVW9GbQISlJ/V6OZil0VOP1L0/py5DAXM0qL2OhkrLFmZeUA12+8VkOpgUqG1PFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.dk smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6arrU01ZhUc80J2vbzfPV5GSY/ah929O+XCUmn/gQC4=;
 b=GdpjKXbK+YJXjkWxE+kAcdWAz/Abt9cHg7QvRKtisZnSMS1iC2yrMsC75HD4lZ7dwJIEbe7FVJSCWO2sy53XY0XS7jPVWBHsnioY9sks37NxEVEIqAHscU1MENdQoCWUhDkm8b0XrrXl+m9/XBrokvroMPtC9UEKZRRG5RBdANA=
Received: from MN2PR20CA0019.namprd20.prod.outlook.com (2603:10b6:208:e8::32)
 by BL0PR02MB4852.namprd02.prod.outlook.com (2603:10b6:208:52::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 15:53:56 +0000
Received: from BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::2a) by MN2PR20CA0019.outlook.office365.com
 (2603:10b6:208:e8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 15:53:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT054.mail.protection.outlook.com (10.152.77.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 4 Mar 2021 15:53:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 4 Mar 2021 07:53:28 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 4 Mar 2021 07:53:28 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 axboe@kernel.dk,
 linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.6] (port=38532 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1lHqI3-00044o-GR; Thu, 04 Mar 2021 07:53:27 -0800
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>, <michal.simek@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH] ata: ahci: ceva: Updated code by using dev_err_probe()
Date:   Thu, 4 Mar 2021 21:23:08 +0530
Message-ID: <20210304155309.17878-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d38fbfcf-d06a-495e-a4a5-08d8df25b7bf
X-MS-TrafficTypeDiagnostic: BL0PR02MB4852:
X-Microsoft-Antispam-PRVS: <BL0PR02MB48523DFB0DFBA86AB6889327D4979@BL0PR02MB4852.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:131;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKC0alTxsU/PsazTTuaKqOGldGHA9y+Jr+hAlhb1fQP8IMEu9lEfB8kmpfSOu3VlOf7EwBeGD3PPkqo6nx/jILZixHANFSymI7VXESK8l06OByIfxQjupE2i/LnNUFLMCz6jVixOAKEVPmEW10cmzGaPJssVyWurtN5nSlf4y/96SvlLsuBtz7E5+33boFcAKnsnQ15FXIrWa9Dy0i4nHUZEWU4Ywifqg7aEcjj/S1u9XD8M17rWQFFOauKoVH3doBT/15SrywsCn3RkDO8CXMLST6BjHuBUMJXpvSEo3EWe4JD5P1KKaRjxI3mB9OrQd05w4w5SyhtmG74Ga6z2k7j9WCf6fyaeFi8Gvgw5d7MJpsof4cI2vmDGd9kgYUBLybqz2syaA13fAV3sCGFNkjj7EpJGoPH5LNhh4ulc7D9W2PPXIxPV478hRYpfPgZPr6kKWpjDvlk3ViN1U1GSfLY3F2ULYpoLGymOq9rAzvDt0RoaMr+M0U6pzIziHAKi4SQM9altHmrjJcqWePnG9n6fwynDmcVWvbkflzyG/99kuetxDMDTYmlCXmPp6vluBCDhrCZJEQZWEIMB5gApHk3vIm2Ll6Gui0awZhNATcBCfFjZhBEh4lCNMzAhWLBsYBniT1eWjrNkHheLF9DP3MaUG3/hKYUxVrmgkMDz2F4KsE8v3Bg5DWGigOCeKGPAxmy/gZmU4AW84ypL4nupNlWvntZhLpcuyxH9fVdth2HRc3F44tItjLEGYwRz0oUQeSyKtRMaQaKeRx5kkDNLvQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(46966006)(36840700001)(36860700001)(44832011)(7696005)(107886003)(426003)(1076003)(8676002)(316002)(478600001)(82740400003)(8936002)(36906005)(336012)(9786002)(2616005)(4326008)(36756003)(54906003)(966005)(70206006)(70586007)(186003)(82310400003)(356005)(6916009)(2906002)(15650500001)(47076005)(5660300002)(26005)(6666004)(83380400001)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 15:53:56.1081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d38fbfcf-d06a-495e-a4a5-08d8df25b7bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4852
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Updated code with already prepared dev_err_probe(). It reduces code size
and simplifies EPROBE_DEFER handling.

Also, unify message format for similar error cases.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
This patch is based on ahci-ceva patches:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=5542fabd9e07d6c49c07862e73070c325f93d390

Tree: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/tree/?h=for-next
---
 drivers/ata/ahci_ceva.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index b980218..a935209 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -207,9 +207,8 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 	cevapriv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
 								  NULL);
 	if (IS_ERR(cevapriv->rst)) {
-		if (PTR_ERR(cevapriv->rst) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get reset: %ld\n",
-				PTR_ERR(cevapriv->rst));
+		dev_err_probe(&pdev->dev, PTR_ERR(cevapriv->rst),
+			      "failed to get reset\n");
 	}
 
 	hpriv = ahci_platform_get_resources(pdev, 0);
-- 
1.7.1

