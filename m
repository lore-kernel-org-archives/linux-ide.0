Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF84DC433B4
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 22:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF22661184
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 22:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhDGW5h (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:57:37 -0400
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:48706
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229460AbhDGW5g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Apr 2021 18:57:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEUFUU8a50woy/c3Ie+tq1V3yxB1StnWGZpsL/akR57BZysGOT7MH+Yzrdu3C/kM5lpEAI5FIkC5KlfkaCQU6O7CA8I8tWFuWD4kbkZDPbakVHOVZy7TG0tHjOeI6mCMrEVWHvlgBIAQuifnA4nhCDjZD8rYys6LtGvD1LLaNvaMO3b+AluTSNS3dQjF778+KhYiUAImIQL6sz301NGpu8SCCQQywlkNDgOwATS+VQrXC2PvC9QP8FsEKrAPf1tDXoxYsb9jyOiZ1adK9y9k5LPGgPaqG+4j45kPl1ezpBysR1sCinHtndOiH9x8zeJhw/zLQJxTCiXg6c6rOK+Qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82eQO5BLrBYGvsBZUWD7g7FnUDicg9n0FfI32Ip9Sgs=;
 b=jNkKuY+56J+88ix3g7zFJecfeSjvcGmIctusZUBwKsiIJfmTOoE9a6LjabXE0fw+eXZqbZQ5capv2cVlUy4uqEEtCazvta6gZY21ze/NaFGduBk97aZwhs5TfM7dEZWVFXIreEiD2Txp7m4S/3KK9gNpYrGsqM+Gl5LzjWH/86ahL97yFgcNAAimIF6Jx8Hs4XMfPcmjT59T8ViiAtB+ee9tYcB9eE8V5NlGxXx6qCGX/EXRA9355rLfm/x71R8gEC6C4sOWi9dFuafbCc3XUvsVzR6Ea7RTrmyQ2gWIf3LM9LRVth8+UfvjMiwzC3eZO+hwg7LJdfF143Jf8sBnvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82eQO5BLrBYGvsBZUWD7g7FnUDicg9n0FfI32Ip9Sgs=;
 b=A/5+s3GE0tanw6rgAu9YLnsphQQhYSzLilWG1TAYAIdLP4OXojEwr8Tl0FGeuClUMzbhSPYHYJ0EKockUK+r/WfHv1tqIwIuKKNllRmR/SrgG5XIlHBSJhk84rP66XGeQKGLf7E1P/pi6JLNabILWckwd16kBNQUyutmJfGiNOJQyr1ADNype3pHwhv1WL1mKrhN2rj+c5p2++EhmK6So6Awr314M+E5hCZ/PlneKKn2H3+psMHr1nkPK1fj6KHKo306r+14QRiHfhl8Qkvcdq+CeU7TM2mdMeLyBlNI0TwKgGuFwb00G8hDdyEdc/OyEOBGXc8VBE1qCIT03wRGtg==
Received: from DM5PR1401CA0003.namprd14.prod.outlook.com (2603:10b6:4:4a::13)
 by BL0PR12MB4961.namprd12.prod.outlook.com (2603:10b6:208:1c9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 22:57:25 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::79) by DM5PR1401CA0003.outlook.office365.com
 (2603:10b6:4:4a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Wed, 7 Apr 2021 22:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 22:57:25 +0000
Received: from [10.2.165.36] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Apr
 2021 22:57:24 +0000
Subject: Re: [PATCH v4 3/3] ata: ahci_tegra: Add AHCI support for Tegra186
To:     Dmitry Osipenko <digetx@gmail.com>, <axboe@kernel.dk>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <pchandru@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
 <1617758731-12380-4-git-send-email-skomatineni@nvidia.com>
 <594c622e-4505-3448-1c7b-eae8f36cbad8@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <49eba27e-18fa-b682-1385-2930dfff28ac@nvidia.com>
Date:   Wed, 7 Apr 2021 15:57:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <594c622e-4505-3448-1c7b-eae8f36cbad8@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fdf8e35-1a75-475d-76e0-08d8fa1882ca
X-MS-TrafficTypeDiagnostic: BL0PR12MB4961:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4961EEEE971D47578C604D1EC2759@BL0PR12MB4961.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzQv+mMe0NWoN84ou02FBOSkqFWuLsm66YpkoWXbBDevfHt0FziMTnG/V1yTRp13fD7BMm6ZLfQ8Y8hNRFR8K2Dp17gpirsO5eIK4D/DuCQ9cXwgKaX4xtieXb/iuT5euaEwnCBUqkzRLfB772O0vvKMwOPWw9lSpIlJ5GarDreLQt01SKtKO8DWeQot1yXyOTUTPxzvghUpvcajFwKSz0RjNQnZbDZgl+XetbtQFBYhRtRN2adV/mNCGHQ4FQXRcE9p6loQBrDuuifPov5dAz0VNh2zMjda8SxAfFymylxVljn3b0klXGSIT1MUzd+0mhEObxJHvOzYMm5jiCLmivxToiTln5SSiuhT2dWQaJY8LZtzN5OwlAOQX4+jMbNm7ntGnmOjL8d2x5mI4yWICbdWxqj6p9kJmr/13PkitsTFk+P+7M2F9rZx2rLkCpc0vgzGVYc5OK07kfyxxB8MTILh38EqhySHoMG6w9co+kOUoecKzhGyBlP/qBS2QXD0ERTDMqxM7wLJfn86tJsDcvnPpWaTdSBG8TPxwTvdGMzfFvlItkenoljVGcv6eizL0vpctm/qwHeoy8kDmXZWrgzOL8sZ/2RVby3C83x7dswDcFtliPbrXuyTFs9bZkq7Rg1kCZzagE28oQibz94PM54EWnR0DNT/8g3btB/Qd/JDkNgnCQbsaqR1Cpu/BhuV
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36840700001)(46966006)(47076005)(82310400003)(26005)(86362001)(31686004)(186003)(478600001)(36906005)(31696002)(316002)(2906002)(426003)(16576012)(6666004)(336012)(110136005)(54906003)(5660300002)(70206006)(70586007)(53546011)(82740400003)(83380400001)(356005)(4326008)(16526019)(7636003)(36756003)(8936002)(2616005)(36860700001)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 22:57:25.2241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdf8e35-1a75-475d-76e0-08d8fa1882ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4961
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 4/7/21 2:36 PM, Dmitry Osipenko wrote:
> 07.04.2021 04:25, Sowjanya Komatineni пишет:
>> +	if (!tegra->pdev->dev.pm_domain) {
>> +		ret = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_SATA,
>> +							tegra->sata_clk,
>> +							tegra->sata_rst);
>> +		if (ret)
>> +			goto disable_regulators;
>> +	}
>>   
> Hi,
>
> Why you haven't added condition for tegra_powergate_power_off()? I think
> it should break GENPD and legacy PD API isn't not supported by T186 at all.
>
> I'm also not sure whether the power up/down sequence is correct using GENPD.
>
> Moreover the driver doesn't support runtime PM, so GENPD should be
> always off?

This driver already using legacy PD API's so thought its supported and 
added power domain device check during powergate_sequence_power_up and 
yes same should apply for powergate_power_off as well. But if legacy PD 
is not supported by T186 then not sure why original driver even using 
these API's.

Preetham/Thierry, Can you please comment ?

But as RPM is not implemented yet for this driver, GENPD will be OFF but 
SATA is not in power-gate by the time kernel starts and functionally works.

But with RPM implementation, I guess we can do proper power gate on/off.

