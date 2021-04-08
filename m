Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CFEC433ED
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 16:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7653761006
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 16:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhDHQkt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Apr 2021 12:40:49 -0400
Received: from mail-mw2nam08on2066.outbound.protection.outlook.com ([40.107.101.66]:10629
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231908AbhDHQkt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 8 Apr 2021 12:40:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7fEHHstdNK2REWpFdo/u//XCFmZM9KmVRnbhqCl0+UxrJ/ApdLslMmOPnPbQ1M+dWocDxDgu+I8B92Xbij/gqRHH+7NV9OUej5TG2Mps/lWWoXjQ2jK1Wp6GGxW182LvibI1PvPa9+xPHQu8fXIRbhyqQl7XS4HAVE07kw456nZpbA26ghQfJRk17L1LGAoWkfk6ToZTjPw2JEvHjuQ7cBb9Yh3yz5ciyle1i9on7ZNN2uR/Zfn0jAeF1xVCCe8ZkYLpOxBIUY2147qOVdBZCMtwO8Qq1qlQxCWOe24+QyFEfDgRCYinBLCuEEkHCbKCP2C9YA8vddM+QJdXhkcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJbGjCJ/fRIxuoIGznGQoeJNQtB7FBA+u57PfOoIsrM=;
 b=ocZLeuFNPvLSh31H3KYsVGQ91GIiLKfO/IYRNgIvIRXHNeNQFVe6p1qyDtwN9xFmgCNCQX5syYMi+0KfgHHlOY8bozRWF5zsFl39cYpT40sdn9JHwUxq/g4AV9RzZH8oAgQDqvXS1I31FlwjxmcEjCUSkcDr+MPLCKidS+nvCA7EPG4V4URi/RhSEPNVu3UfZfui3vxBC5NODrdONUViKmikevzRw5b780KU+NZHAVSjEaOmPZiNFZ73dx8jRS7+bOCjSIXzfI2fqFof+elYhjA/SMwPZ3SC7fJahdOI3IAnQ7f1xY/sB5K4zFYU+WZiAoKhlwORjkilPry4jhyV5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJbGjCJ/fRIxuoIGznGQoeJNQtB7FBA+u57PfOoIsrM=;
 b=HNtHt92z7LezdTbDDQO3ycDJk62nuzBWTk4Edptou2jVZ6AO/gROQN0QVVHW24j/yo8N79DQbb+RHAZHVnwlFNvtDvAdtlHcVnUMtApoY6UGnZnvXrA6gR+SEKM4YfZ6WMvMZzza9UpDkxm521bo2tZ2WqiXNa5V2khfaLIwxJ8MQf1ehKIayLMGeHQo9EalIA9on2gswMj5xo/5jMLtCZhHbriV25iu4T662jIpJyQAicVARxr6JnNw+uN1w4IuNaK9ddwmbz9ZoIsjAvMbKV2jc1r2kCuQ68Y7dCFFZg8grY1WC0/uoXZWqh3YOSWT+MukbL5KyovLKKm5DqFcqQ==
Received: from BN9PR03CA0244.namprd03.prod.outlook.com (2603:10b6:408:ff::9)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 16:40:36 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::c4) by BN9PR03CA0244.outlook.office365.com
 (2603:10b6:408:ff::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18 via Frontend
 Transport; Thu, 8 Apr 2021 16:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 16:40:36 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Apr
 2021 09:40:35 -0700
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Apr 2021 16:40:34 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <axboe@kernel.dk>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-ide@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] Follow up patch to Tegra186 AHCI support patch series
Date:   Thu, 8 Apr 2021 09:40:42 -0700
Message-ID: <1617900043-10506-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0989f6b-888e-4c57-9919-08d8faad0955
X-MS-TrafficTypeDiagnostic: BL1PR12MB5206:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5206B6EBE707AD395F683198C2749@BL1PR12MB5206.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:457;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9qZHg5AmWLQfT4XPkl3kkGRS2caaOY9zmXhOnzH2Plxke7Ub6OC3teKW6deRgGcrXYOjk/pSELghpPVvOfINDBDNLVKk9iEYJ4sNaw2ETBcNtaILnJXO6jIuxgL0FZ6ADokWmG+bpyAE2bFsiFG3kJPdqKm8UZ1ojO6hjuoflJtvzr2DP3pxR809Ta4JxClGo2AoYmIWTIQEKMhLndeR/4EOHV6zt2D7h7H3/lFCE3NIgRRZTvsSpnkGW4yDiax+02pbzMMQazULcnaHEX3kBNZa0wGc1dQe9xDQYZT5DTpbyTHcCwe4HryAtAHaeX8MCm+5+4L57d4KQ3C2olBKu0I1TGO32vcwd8C0a8tbSjb05cYNPVpQblHdj7pwnml9D1UMCNi80/fGuupV5+jsHIwGlCKRG170znwDLvmENSNFp4kmFlQf+jXCnpLx8cf8Uim04YxvAbpDt6bmELgPx/YauzwkNxW0g/tGm4wJhlLi2nNAzzH/6kmkRqm6p5qwybsdbIDHMgfpBuguvVnhphcx6EiB216XdeioX4rxzG/gjzevNMj8EA7P0QNu4G2hiW9RgP1hyMPRBfZypqaxC8vp+Z3axMrJNERvtBZMCBZpPglvezz651jQPdhNPF8pmMqK3W0+EyLZmQNaulNXNRvjqnZ6L/bpnwqlmwEtKTG2CRxKwPtOH9YkEb1ztba2QDwlxxLIIq9g7iyqlbIi5dx9oejscqNBlrwbqv1ctJA=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(46966006)(36840700001)(426003)(2616005)(83380400001)(54906003)(82310400003)(336012)(966005)(86362001)(5660300002)(316002)(36756003)(7696005)(8936002)(47076005)(8676002)(478600001)(110136005)(186003)(70586007)(2906002)(4326008)(356005)(4744005)(36860700001)(26005)(6666004)(82740400003)(7636003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 16:40:36.3007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0989f6b-888e-4c57-9919-08d8faad0955
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This includes a follow up patch to Tegra186 AHCI support patch series
https://lore.kernel.org/patchwork/cover/1408752/


Sowjanya Komatineni (1):
  ata: ahci_tegra: call tegra_powergate_power_off only when PM domain is
    not present

 drivers/ata/ahci_tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.4

