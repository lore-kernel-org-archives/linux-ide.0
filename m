Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE70EC433DB
	for <linux-ide@archiver.kernel.org>; Mon,  8 Feb 2021 18:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAE364DE1
	for <linux-ide@archiver.kernel.org>; Mon,  8 Feb 2021 18:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhBHSC1 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 8 Feb 2021 13:02:27 -0500
Received: from mail-mw2nam12on2071.outbound.protection.outlook.com ([40.107.244.71]:50388
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235244AbhBHSAQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 8 Feb 2021 13:00:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lquU7jSddqAhqTGIEDCaeYccU2hGZoDxh84o81HTBxOd1qQRaiS14pYdWqSozJrndi61OhKpUM3+vuM3xOB5/A/RsN2Bt7Y7hjaBjIFGJYhVKRXTffFNxcnunn6eOCCq7CHOw6HliJPzeqZOnH+ODxEgCjIbZEjZJn7IYandT7e6SbXfMk3KbuxTCyvxvPR3xLTXUrUfhZI1Z6VnIHHoXZdvSexaJJ8mZhe8JMEXVHgqFTT/LcYX/FHiEL1eiCZnwvxEEo0R6Rigdv1wVVZeSCOgapJhzzLjebR1XiV3MIphI7wbAWy+5ssNsPMxyhVxA2Jo7CfVHrFzXC5S5iChcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCuWH7vIF/MUa5y2uLt0by2pQAtTWRFX1eLhlmF9nGI=;
 b=KrGMCAOrBSvrQAs7z6l2N0sNaI+Jg065w/jDqEvREUaXPBlp4K/pAHe0bXS7foyhXbLSzX0owkGYMkN2jjXwWGSr5vX7ZtM4xuvYa+1o+GrFI7svYgWxcJnkLxE5XVbzkailZJ7hG/tijlUXFzj19cYx+WxBjelVmjO2bnZxXQSzHqbFLvTW44KZrtcdhfDdP4MYVk57RNhdd5jBVx5lj5dOfYOwr1FyCZphJPTk3YdYfmeqDODN0XmzjntiZx8qjxGo73jnnkYc77+bX9DsumoRsBVZ6SMKnpJFWoUKwBdMFjaBaGDnOclm2l1bmIaYG9XZHQRtsRDDyqlRh2YYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.dk smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCuWH7vIF/MUa5y2uLt0by2pQAtTWRFX1eLhlmF9nGI=;
 b=Ge9w+nKb183Hq2y/jAF4vazzO102by2S/GmzVP2TbgSBw4OFVdXFhlfxNsAbxURYf4ZypNJw75VVu3Cu4Wwkt+Ll/2At2tSkaEnFbRslm5P5xIn5KeaU9Kptr6EU/c4gCmIbJbXbXfh9CD64IoF8si1oYFH024dN9PTw4TegVVw=
Received: from SA0PR12CA0001.namprd12.prod.outlook.com (2603:10b6:806:6f::6)
 by SN6PR02MB5312.namprd02.prod.outlook.com (2603:10b6:805:73::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Mon, 8 Feb
 2021 17:59:20 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6f:cafe::7b) by SA0PR12CA0001.outlook.office365.com
 (2603:10b6:806:6f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend
 Transport; Mon, 8 Feb 2021 17:59:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Mon, 8 Feb 2021 17:59:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 8 Feb 2021 09:59:02 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 8 Feb 2021 09:59:02 -0800
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
        id 1l9AoP-0001aF-Ih; Mon, 08 Feb 2021 09:59:02 -0800
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <axboe@kernel.dk>, <p.zabel@pengutronix.de>, <robh+dt@kernel.org>
CC:     <linux-ide@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        <sgoud@xilinx.com>, <michal.simek@xilinx.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH V3 0/2] ata: ahci: ceva: Update the driver to support xilinx GT phy
Date:   Mon, 8 Feb 2021 23:33:54 +0530
Message-ID: <1612807436-5238-1-git-send-email-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fa7e879-f29c-4413-3b0c-08d8cc5b42bd
X-MS-TrafficTypeDiagnostic: SN6PR02MB5312:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5312F7B3AFEF6429CFFF2FF1D48F9@SN6PR02MB5312.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SaDKBlXo1CC2E7pqgodSGF0WDPSbjFYr/aUCfbbtT9arwTVjjP/ZrMqXMX2HUuIYGnkdzNvV92zaksi88T046HiGoniG5CMro4dXOamvWJD7bfttntnHz1Hbat/nd2pN0pRbsbR/EQqA36tn8b6rDvhEvXDMo+V73Gp3hiLirjnRa5cnMXaqh2+b3T5Qn6nT+wVe8o0Nrvjd3WBByhmkAiWw8ZQ1Jp0r9M6Z9mp+G1wjXfQHJFczHgRe2uYfWbnjQuT8dD+4kcDFv1d/i5Z0VoNYOwiDw7h95SUUEMoj7XmSTFyXLNx1XXSBlt4dDRLrhMZIH6G7HnPPnOAP70RIv7bFT6k7/WyxQoayTFi9gmB1qWtr7yJdmed9bp5iQf4BhdnMbnuLlXXHNP2wPPnyZlCm2M1CbcqIRPC4fUzGeGdvaHkS+lP245L/x54nXPpBbuIqs7mRYDa5AnDsqvxdarR6At2Kjs2VOTL4jODQDzXMZ5+qfAomj9f8B9Pres8R+kdUM6rwTbgd5vbJn39leX9CkPfAnQFWFu5bSMjwc6xlkoUDimg0rSgMsdPBT/obwdy+c5UCUQpfUIo4+GFoyD24pd2u0sxAfEALENYPfxHbBNAauUFBhGtxTlY7ioDRg1X0CPBXxxW6jHU38VOVLSIUf4X0SWfTrq/t2k1wb6eVBpNHTv7DWgzrJluBfFnF
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(36840700001)(46966006)(6666004)(83380400001)(356005)(8936002)(36906005)(9786002)(4326008)(70206006)(82310400003)(47076005)(5660300002)(316002)(107886003)(7636003)(15650500001)(8676002)(26005)(2616005)(82740400003)(186003)(4744005)(336012)(426003)(36756003)(70586007)(7696005)(36860700001)(54906003)(2906002)(44832011)(478600001)(110136005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 17:59:20.5913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa7e879-f29c-4413-3b0c-08d8cc5b42bd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5312
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

Changes in V3:
 - Remove phy-names property.
 - Validate backward compatibility with reset controller availability,
   instead of a flag.
---
Piyush Mehta (2):
  dt-bindings: ata: ahci: ceva: Update documentation for CEVA Controller
  ata: ahci: ceva: Update the driver to support xilinx GT phy

 .../devicetree/bindings/ata/ahci-ceva.txt          |  4 ++
 drivers/ata/ahci_ceva.c                            | 43 ++++++++++++++++++++--
 2 files changed, 44 insertions(+), 3 deletions(-)

-- 
2.7.4

