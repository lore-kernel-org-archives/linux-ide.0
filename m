Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7ABC43381
	for <linux-ide@archiver.kernel.org>; Thu,  4 Mar 2021 15:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAEE864F1E
	for <linux-ide@archiver.kernel.org>; Thu,  4 Mar 2021 15:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbhCDPzA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:55:00 -0500
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:9921
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236006AbhCDPyt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 4 Mar 2021 10:54:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Po0nNWXAe1pAYQaueQxFL9krBmR56jfnVepokciwVeDkzLk0lD9lFRjBLCdIt5dy1TotYHEO+3Xg7x5XsQQC+kzFOPJ37SNMHuPievh9p6pDNJ5RoPyQmiK/RwkjQt783SOj6dTHFAjHUJRmKHn0dOrVME6cqJl8qFUtMxvPuLlRDieETLkD5oGT97OXC/+NZuOE1nmd4HKxwfWU02SaJcNwnCkMf9dqGKKnmpCXmeRA5tcJQ+Fejv7JhIUcRpQA1bLCnvghw1o7aBVyZKguC0xGquRa04RqcKeVmJHaOALhE6vYXCWb6EXjAjHQJV+yBR8bMr37oKXitpo9xxmiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6arrU01ZhUc80J2vbzfPV5GSY/ah929O+XCUmn/gQC4=;
 b=nnrSjkqn6VFOaj1gWsPU5tzPv3b5cRJTceR0XL1YeAwprnJKJ6m51M06wRRk4R5xYR/f9kgfKbVGlL1RDaaIGS7ePHLmWTCXwngeQLQQ/TjvNXsuz10Wq3xwFiQH9RwooGl30OZvEPpOVBn1gIosVD3T6MaIRYMluEMgDLg/19rUbH58CXnV5X0ZMuXtyBXYuVHqQlN9mgRaipWITfSlqLurP9vXGQ08MCV+YE4BOKLBOCbHHbWE49vRR2UiuZnqY5s9X8QqXe6xTxstdG6WL1YhCuNjJ99WTba+djYiLAKNcEzd2vgyvWnLyQYxy5Y+li2LXGB6ZZSD4eFO9VhoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.dk smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6arrU01ZhUc80J2vbzfPV5GSY/ah929O+XCUmn/gQC4=;
 b=Xz4OxE55qY4g/MwEJIzKfFbANZQDV3cM5beH4HAVd/YpH32LY0TklbRTCJusnynUw8CGLEvmrzOzt5HVa1XdIdI1yJ4quNUK3lnRtY6XVjHzSCz6BY19v2bcmRil0iYpkrj7O2RzYbMa94OmBrksrcmYBtyKiiYFfYHcU7v3elQ=
Received: from BLAPR03CA0082.namprd03.prod.outlook.com (2603:10b6:208:329::27)
 by BY5PR02MB6961.namprd02.prod.outlook.com (2603:10b6:a03:23b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Thu, 4 Mar
 2021 15:53:57 +0000
Received: from BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:329:cafe::57) by BLAPR03CA0082.outlook.office365.com
 (2603:10b6:208:329::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 15:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT043.mail.protection.outlook.com (10.152.77.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 4 Mar 2021 15:53:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 4 Mar 2021 07:53:31 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 4 Mar 2021 07:53:31 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 axboe@kernel.dk,
 linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.6] (port=38532 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1lHqI5-00044o-RB; Thu, 04 Mar 2021 07:53:30 -0800
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>, <michal.simek@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH] ata: ahci: ceva: Updated code by using dev_err_probe()
Date:   Thu, 4 Mar 2021 21:23:09 +0530
Message-ID: <20210304155309.17878-2-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210304155309.17878-1-piyush.mehta@xilinx.com>
References: <20210304155309.17878-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d87905c-17d2-4c5b-be12-08d8df25b885
X-MS-TrafficTypeDiagnostic: BY5PR02MB6961:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6961C40F504F49DF62424F99D4979@BY5PR02MB6961.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:131;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TH11xYn6PN7Egu8aINkb5My6lTkLQq/++duKqgYiLvD9qK5MLeCRuuYQY6V3J3LbVG+IsJ/L0RyvKMex8BGENQXPkVWAnoBxCG2s91/+D6aFy2C8cm6cwE0w3L+PnrmLjk9zD5TsE+/HhRb/8S3iX3Kpm9t4SU8PCBLYCAa8LwL3Cd6Pyq3hKoUIOTZd7h6nXwW+1LqIL/9xRd20cKOwHmIkOopPoKz1HV6L0FXxqP4UZKyvkjZvLJlP01VshiuiI79OW1WG/lrR2x0ZeFojq4mrC9ORTy6WJEmVXM857uzlsQrp7OrpFJS12nJMo1WO7OhUp4gD5IGO8fPlYo+61frd8tfnsylOGZOo0jsNsD1RwJ8P6WVGqIYB+iiZuXr8RJrQbBHa8oVUZOH18m7foStZxenWm+utpEs1aMG5jSGfeEOoYVxKKAA3UtZBxAP/nlh1RKiry1PSuDtg3uLRjVmqodLFMAMHaMK6Ltt7LOepS4HxdMXhERiqG0jH2dbuwG3Db8jPA4LN7exi7yK+O8rYEt1nbot0DToMVxqFN4ebr/wz9eFUEAk4XSoH/1H0dph2BZxjZgfdS8JTDroJFIUhrCNPPgLzq/ChqsttSICcotSHFZvYloMpvh9BeA8tIEVPDlbs7/mYTFRIb8p0SaIhOcNerRCuuQa9/wRff/fKuHxfITVJtN24O4I6Cvs22Oz7AG5T3I9gQfSjsLxSs5H+ayiCEeozUumipKhy/0zMs6+XAV0WVtKz9zsV3jv6+LplhNzyX9efmOBHb762tg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(70586007)(5660300002)(8936002)(7636003)(70206006)(8676002)(426003)(356005)(107886003)(36906005)(82310400003)(4326008)(316002)(36860700001)(6916009)(6666004)(9786002)(44832011)(36756003)(83380400001)(47076005)(7696005)(2906002)(15650500001)(2616005)(82740400003)(966005)(336012)(54906003)(186003)(478600001)(1076003)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 15:53:57.4072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d87905c-17d2-4c5b-be12-08d8df25b885
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6961
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

