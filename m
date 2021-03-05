Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6E7C433E9
	for <linux-ide@archiver.kernel.org>; Fri,  5 Mar 2021 09:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40C064EEE
	for <linux-ide@archiver.kernel.org>; Fri,  5 Mar 2021 09:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhCEJLB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:11:01 -0500
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:52320
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229563AbhCEJKv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 5 Mar 2021 04:10:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLNXAOOneU+8eImWEIqV6xa0vHYD959BVozquMT17PvyV/dY4fKj+gL5s0S00c725cMulu0eh85CmPiZUY6JcxOGkFhOMoNt7pKDueQ27P2qzEAVplayMCn6/xOf8DgNV62e8M7sypbgL/oEMxmyL3AVjnE7d7UykACoSg2t5vX+1P4QmqtE2Ul1ky03U6dBM69hZ3dVmQuubLdbKKP+NjsHCeuDpoCgCYnq3Gpq3PPJ6GETVqBaTjHKWLj+E+goX75eaNtZoTBzDEhCnYd4XHYaDkG35Of089JYHTOSUD/z/jRCg8sxcFYUG3l+tbaof1hfYUtugdhtYx6vFa5/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60DRLo7/HLSmrekniY3404kGn+4Pz/FidqLWAJFN84w=;
 b=gasJ0ib4w96m20/KPg3wk5xnQWOfR03enOSEYYQ+cCmp2hQRPTwyxWqzE0ZUJqXKgVjN0LQWs75w8Jfkj+rCK7TMpxR1kZv4G/1dX4nIS9RX+W2xymvh6KbywOgyQURDCgLTXP0S5WYx3up1SI6VVlbgCNA+AmnYARiq4LHLuztMOHMb/8vy56wE0J3wSN5eTrfeZrUU7ZqrfhZedxSCVrvRdIIowf7m4daV32NgjXGezDwzzufbd1+FPHoddZ6f/73omJhvvnuJRGaOSEjAlks8G7BNZxFBR89dMw81ZsHOsw6Y3uShtp/pV/5m5gQ6QQXio14ZIy9y6CxGge1Dbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.dk smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60DRLo7/HLSmrekniY3404kGn+4Pz/FidqLWAJFN84w=;
 b=KHBdU4lRV+0ko4Qi/socVbXlu5kcKm7Z7dNlbbO6WD49hRnMScU+lryllmwh0jCnrxsjyRnljAAYwLru0OVw62xz7K5hFBapa6guZqclLq77f6K7q9Yd1cYlo9COhbn8ihgUl/A6ZqVzpCr2iWH3Sb/TaGg0ZxImVBnAZEBcD+g=
Received: from CY4PR16CA0028.namprd16.prod.outlook.com (2603:10b6:910:60::15)
 by DM6PR02MB5337.namprd02.prod.outlook.com (2603:10b6:5:4f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Fri, 5 Mar
 2021 09:10:45 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:60:cafe::94) by CY4PR16CA0028.outlook.office365.com
 (2603:10b6:910:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 09:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Fri, 5 Mar 2021 09:10:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 5 Mar 2021 01:10:40 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 5 Mar 2021 01:10:40 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 axboe@kernel.dk,
 linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.6] (port=39668 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1lI6Tn-0000f9-6B; Fri, 05 Mar 2021 01:10:39 -0800
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>, <michal.simek@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH V2] ata: ahci: ceva: Updated code by using dev_err_probe()
Date:   Fri, 5 Mar 2021 14:40:29 +0530
Message-ID: <20210305091029.23378-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20eb73f2-3ad0-43fa-c28e-08d8dfb68ecd
X-MS-TrafficTypeDiagnostic: DM6PR02MB5337:
X-Microsoft-Antispam-PRVS: <DM6PR02MB53370A82FCE5512D467873E7D4969@DM6PR02MB5337.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:131;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIbio2XwFzAj/InnQ9vnVltP2pxFMK5ucxqaJW3qBnsEvixv6gUmcXqb8xG6cI3FGgy8SuGiGY/7Z3OmuD9ghp+b5FPCsJSkhhetqfLdj/vy4XXrh/SbonfZYgvGyCO4b3rYditPpZkxH7ypITtT9vTvmEe5Y8rPv70RMiTOtCVXeeJNNtQhR3+XjTBKF4SCChwHW+pNUnxsYCrvZVc0MbaOnd1hM64d+FvW9LlIrJV1aNQkXwxwG7M/hWaSc7gJOTQuTZsI2AkGP2/VoJetV3SiLiXdOMHfep3IXcupSKN2emmlDoBzCD8zSyYmKfnU8wnfThU0YKwXyjZvTAk+6ZIlGRAdMNjMfZLOJqzXio0z8wDRyC5fp8aq7PVanFvXgmwZx52WYdFNdag6a7xqeplTPciEWod8Frruocwac88ny97sT8KJqRRn2Qk0ceu1d5eKrvYghwk2u0FcF5+d9m9pCBlo2NmQrN1FQqbvmgjIUovFdwqEs5mm7QceNQWyWx9e3DllMI6YaxoQMXVDnDoshk7c7GNhK9CTHEJpRgXWB+C6gN7pCvb9SJp291QHnqyGrWiVslUivC98TmLz4bRNqmTEAfZHTy7nDoujqlVWy4ZBatH0ay2jvk18h/QHHftW2X1+lNIEPrXmDzj52mG3Eiz8P58GxhOswtgBhZO+OUsgMQb48JsPqQ21mX9tUsMo40cN7L2EfTSPMJC6fvZIhv5Thh3LiClS2NiXTqeIq2TtorIimmJY6K3yvXAwZNfzuNXpxAIXeneSxWYhzw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36840700001)(46966006)(6666004)(5660300002)(26005)(36756003)(478600001)(47076005)(186003)(9786002)(82740400003)(82310400003)(1076003)(2616005)(966005)(316002)(107886003)(7696005)(2906002)(70586007)(4326008)(6916009)(356005)(8676002)(336012)(54906003)(36860700001)(15650500001)(36906005)(8936002)(7636003)(70206006)(44832011)(426003)(83380400001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 09:10:44.5186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20eb73f2-3ad0-43fa-c28e-08d8dfb68ecd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5337
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Updated code with already prepared dev_err_probe(). It reduces code size
and simplifies EPROBE_DEFER handling.

Also, unify message format for similar error cases.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
This patch is based on ahci-ceva patches:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=5542fabd9e07d6c49c07862e73070c325f93d390

Tree: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/tree/?h=for-next

Changes for V2:
- Address review comment- remove curly brackets {}. 
---
 drivers/ata/ahci_ceva.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index b980218..50b56cd 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -206,11 +206,9 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 
 	cevapriv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
 								  NULL);
-	if (IS_ERR(cevapriv->rst)) {
-		if (PTR_ERR(cevapriv->rst) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get reset: %ld\n",
-				PTR_ERR(cevapriv->rst));
-	}
+	if (IS_ERR(cevapriv->rst))
+		dev_err_probe(&pdev->dev, PTR_ERR(cevapriv->rst),
+			      "failed to get reset\n");
 
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
-- 
2.7.4

