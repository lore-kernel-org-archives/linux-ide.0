Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1C4C433B4
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073CF6113C
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 20:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhDHUzU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:55:20 -0400
Received: from mail-eopbgr680061.outbound.protection.outlook.com ([40.107.68.61]:52996
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231862AbhDHUzT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 8 Apr 2021 16:55:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqRukKHJhF9Bos5OYiVg8/ADA2H4OjIUOHWVbEIYdD3rX9RwnOZIFyL7AfKJJHRInCOtdhLG+4ccgSYLGEJIPkZGAKlY97CoWlZiAdTk3UWJz6qiB0jCBBUS6GXjiTmBzZjAouzvwRcLaMV3wyOSPYIBTvVMkikY4TNELPoUJFsA6NmBaiCac5r8L8DijaQ9EwCN8Ea98Gq7pe0XFfre87FHTNw0vhAEYsa/16rIhEdrIe7XMT7SXDcAuled7zaxOWn540Qh4+c5i97Gd9upYx8DFqQqsnsH7oaO3gSwP14b7FfpYtts4/ZbWXn3uQpul7BM8GnO/DG9eiPqnpgOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zor3xLTIFJ4RFtTSiEG3GtELBnud9y8A4INPJebJnoE=;
 b=TLUbUh8CIb+T2nJC0M0KSxkjeJKcrzb8vhaTcxnI3ZXxqd5iFTIV8DUmOljXxT4BuP5XNHQhkVxEt/3kyJWc6l38USZWwNZ8k7ix2wBBS/5Vdub7+QQm49E+iacP+9vwcIj31k3ryEO6bmrB/nQV2VpXp5M1PuU9+9JyCaA0iiVFpNa4yJtgG2ch/4mESBo/vSECkUFpcIlZ0izLx8d9gXbs7Ca94xdNaA73TYzG95Sn305ugVdNwMvZPLXK/JbOPXzehwYsXeVHrEHY3s4VwDUlJkTifr6RI0Xw++FO0GL/rOJZAHAD9y9fHqB9aN/bOkGMDHAcjTHCM8cCeEJVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zor3xLTIFJ4RFtTSiEG3GtELBnud9y8A4INPJebJnoE=;
 b=WvsSW7Szfta3LGrF6fPeu3X7A4ZMWYELD4gNEq9oQB3e56VF/pN9X5/30yzv8yQQ4s8QVhUP5uGn4OMKV2i2+wEnyShKkf131/T/SkBHuPl8a61WtKb/RCLiJLNjQJZuXlSk5nfUSPOdFPWtnCWe9ytO/nPAegNXtcxeQN3X6VkYOOGZVCTzjLFq5NWpiqxC0illftr5ljzH4gPeOzszqejZhxmNJfwEH2kfPcI/VmSAdiK4iXsF/OGTQlYb3gY10JVAd93J5WPpkL8fEjBimUwfyE5BsctmaV1GwWGrZGqBkI9+/x101OsvRvEfEQwRZ17rolLzU3B87zS5TmlXmQ==
Received: from DM6PR08CA0043.namprd08.prod.outlook.com (2603:10b6:5:1e0::17)
 by MWHPR12MB1406.namprd12.prod.outlook.com (2603:10b6:300:14::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 20:55:05 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::bb) by DM6PR08CA0043.outlook.office365.com
 (2603:10b6:5:1e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Thu, 8 Apr 2021 20:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 20:55:05 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Apr
 2021 20:55:05 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Apr 2021 13:55:04 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <axboe@kernel.dk>,
        <thierry.reding@gmail.com>, <digetx@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-ide@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] Follow up patch to Tegra186 AHCI support patch series
Date:   Thu, 8 Apr 2021 13:55:14 -0700
Message-ID: <1617915315-13639-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb07237d-f4d4-489f-8be7-08d8fad0967f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1406:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1406EA4F54B1063852E536E3C2749@MWHPR12MB1406.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFhn8c0Bosm6/kHtWWvojPJLEUK/4Ca/qpzhgd8dAfRuTTJyrtdxOz6FCwopkywVYf9t9R+qOy1AxXIeTu0gLLBXqnzqi4ZshcC/DPBjxiMkbzTO8ZTnJGmiGU/Tf6rqdQ4Dm8IjgsH7ucy9EJr/8jk2nvkZ4ZIKQ9XDPcxwW0Rr1x5TbYmbe8cTrAS5xdpop20l603ce0dtbCDTG1xeN6cekJORcvbh35ynaKeSrlF9YJZaR92vCXSScwKgMMMwmUPnld2a4pY/rFX8lrnHbA9lMCzcSB1nTusGSA3GMMw0Jd4p4DNLQoC/NnRD/avmcXYUJPCLiDjTC2xAI+hff6tgyjHOSGt8unPC4zvFoNcx1VElQM6ja+9/JnfB5s7L3Q84yq9Av3t3rwxhAT0vK+PoTL3MSEs+ypt2FCk/XM2gCaBBqcqhL4/995ixjrfyHnuLyUiIGl1mJMtGnxrYV9TYA8f5En6SzYdKEyKZGMDXsZQ+Lvoqp9EZF/+KHNq6Bfo5+qGnUJEp1PRvluz5PWFAufoi24+Q99M2f4bufuNffiBw9bM9DWtKoKgzXxKMsRkRlB17+MTs2qE2YC/9k1wGVw8o0YhUN678l/CnQcI9w0FWRj8nQxRlBoYAyT3ZzVBpedb52gdHknfSrRE+Tvd6g80dMM1mFChxag9H9fFqaLSfDM5RFzuPym+I8C5bErOjvps1uCXchamkZLKAmtwdUIeS4xIFdYqzp3z8Kxg=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(966005)(83380400001)(336012)(8936002)(36756003)(2906002)(4326008)(7696005)(478600001)(5660300002)(186003)(70206006)(110136005)(26005)(4744005)(82310400003)(47076005)(54906003)(356005)(2616005)(426003)(8676002)(7636003)(6666004)(36860700001)(316002)(70586007)(86362001)(36906005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 20:55:05.6768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb07237d-f4d4-489f-8be7-08d8fad0967f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1406
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This includes a follow up patch to Tegra186 AHCI support patch series
https://lore.kernel.org/patchwork/cover/1408752/

Delta between patch versions:
[v2]:	v1 has missing PM domain check in error path. Fixed in v2.


Sowjanya Komatineni (1):
  ata: ahci_tegra: call tegra_powergate_power_off only when PM domain is
    not present

 drivers/ata/ahci_tegra.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.7.4

