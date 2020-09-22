Return-Path: <SRS0=jz0E=C7=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7147C4727D
	for <linux-ide@archiver.kernel.org>; Tue, 22 Sep 2020 10:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4DD2395C
	for <linux-ide@archiver.kernel.org>; Tue, 22 Sep 2020 10:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tXB6Kw0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIVKQR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Sep 2020 06:16:17 -0400
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:53250
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbgIVKQR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 22 Sep 2020 06:16:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCCPP0OUV1dD88pQIPetY8YqenJl9Ac5vBntKLqh7ivVaMqBW15RJzayj9jLhGPjl39QXkOnB/kLgerrxTeeBXbTRAt5b2NaiBlQ1hh2/crW+KwJVI/Ykulh5X8DpxU6ZCt5BXaykge9tmoInwqpqh63uWPAyHep1+KjZLOcLenpCMKsFIEZIehSjwWXJl522FsA/003Y0X1zacWiA++cDepokDBoK+6XI4SEuazn4savAekRoe12K3KpJRAP/56JRpZegEONhPzMa7fRwRGs+8BCKmsLvZfIgkvzYlpeOQ6LEBUpcDxId8VrZbW9Zr9hpJ6m1E+kJv9h+9BqZ6Q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3Kwn3a6DAe5FyjA7reT+/bGlZsf7JAO3C/IfiHJ/tw=;
 b=biAlDiVA3FGBp4krB9Nv2cj/YhDZeLHDddiNGa5Rz3gLmM1dVCOe0mYA7mV6SgVT3UiP3gZU5/QCnSeDHlIdc3wpD6SmWkYf7pQM5fzmgkbe3GagygWAS5VqvUxEWuhusu2Ep1zLe3JtGaKJeKCQcsOmpNrFdTm6sdD5UBjXlsJZ/BKN6cR3h9BKW0QzpRmsSqohNNTr90A1KqwxM4zfTNB7YRxlQYTUa7GH9jsnv7nFdweT516Rx2VEeems1BEhUvimPXfy0EkhYul2FbFGYaUbYlDTwGcyeVPde7HTmU8evqgQzkRomdJqebUk/7cMi5ytWkAh8Gw6Z/0yuIL0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3Kwn3a6DAe5FyjA7reT+/bGlZsf7JAO3C/IfiHJ/tw=;
 b=tXB6Kw0P6VKOxX8bmB1bWuHuXB+hukWU8p8Eyc/jSZqdcPSaHZnrvYuuc9YM8i3ZsnLouqgfT0Hw/mtKFbZXk3+3wgeV+El5wKMui+v75JmyRwzrNBy8eVIBH7Zgs4Qa6io+q/JIr+AGrvtBcv1v1mRNdqYbHc0oQGQLCU9mJhY=
Received: from CY4PR13CA0045.namprd13.prod.outlook.com (2603:10b6:903:99::31)
 by MWHPR02MB2446.namprd02.prod.outlook.com (2603:10b6:300:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Tue, 22 Sep
 2020 10:16:13 +0000
Received: from CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:99:cafe::f1) by CY4PR13CA0045.outlook.office365.com
 (2603:10b6:903:99::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4 via Frontend
 Transport; Tue, 22 Sep 2020 10:16:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT021.mail.protection.outlook.com (10.152.75.187) with Microsoft SMTP
 Server id 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 10:16:12
 +0000
Received: from [149.199.38.66] (port=47630 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kKfL4-0005x3-Bj; Tue, 22 Sep 2020 03:15:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kKfLI-0001nH-IP; Tue, 22 Sep 2020 03:16:12 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08MAG5RM017692;
        Tue, 22 Sep 2020 03:16:05 -0700
Received: from [10.140.6.6] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1kKfLA-0001dQ-PX; Tue, 22 Sep 2020 03:16:05 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     axboe@kernel.dk, p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com, sgoud@xilinx.com,
        michal.simek@xilinx.com, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH V2 0/2] ata: ahci: ceva: Update the driver to support xilinx GT phy
Date:   Tue, 22 Sep 2020 15:45:11 +0530
Message-Id: <1600769713-944-1-git-send-email-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c17e7dac-3d0e-4e5e-0b88-08d85ee08878
X-MS-TrafficTypeDiagnostic: MWHPR02MB2446:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2446E387AD6BFB869D4FF1F6D43B0@MWHPR02MB2446.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amttLuXsSH22Zo6k3hdxGgeELyFaU6h3/y3tuAf3CsWPxuGebDrnz0zup054fvTTX057cn42fqMOCv5AoeJ2ZiIMKAR0b4dDXylJb7uie0ww2egB6hkJXlEPdMOLyD8jHzuHPrS6W0BEeyQHzTovWv4nwjguhO09cB5Dd2ShDTJ8BeP2MtYQZzj1zeZuNVcchiLDKaN2Yus+gmVeg5ULD0Phil8KWEFmfOQXhhhH+KvtElf4bRVhikAzhAeZu23ylBGDZDz2uU4/u2MwGEQO8YLRe/6QnBU1tOMjyUKhgq2ym5BxLGJjEawat7O3MtrZHEkGoVCwiFXEt4LG/Kcr3W3nNO1uwi3uxuWpQ8UVkqJNlJudh9ecJzcDdMzV6bYD9NSRjhaj/YokUjFRuPCpRkbKd5MxxBTgFQji1cq67oSFNXyLDm2Bkn1xPY+K9rxK
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(46966005)(81166007)(107886003)(47076004)(356005)(2906002)(316002)(26005)(70586007)(44832011)(70206006)(82740400003)(2616005)(478600001)(5660300002)(36756003)(6666004)(186003)(426003)(82310400003)(15650500001)(9786002)(4744005)(83380400001)(7696005)(8676002)(4326008)(8936002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 10:16:12.8099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c17e7dac-3d0e-4e5e-0b88-08d85ee08878
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2446
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch series updates the ceva driver to add support for Xilinx GT phy.
This also updates the documentation with the device tree binding required
for working with Xilinx GT phy.

---
Changes in V2:
 - Added backward compatibility with the older sequence of the CEVA controller.
 - Update dt-bindings document: To make phy and reset properties optional.
 - Remove rst_names property.
---
Piyush Mehta (2):
  dt-bindings: ata: ahci: ceva: Update documentation for CEVA Controller
  ata: ahci: ceva: Update the driver to support xilinx GT phy

 .../devicetree/bindings/ata/ahci-ceva.txt          |  6 ++++
 drivers/ata/ahci_ceva.c                            | 39 ++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.7.4

