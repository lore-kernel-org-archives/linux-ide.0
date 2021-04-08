Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58866C43460
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 20:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E5D610FB
	for <linux-ide@archiver.kernel.org>; Thu,  8 Apr 2021 20:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhDHUtl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 8 Apr 2021 16:49:41 -0400
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:30717
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231676AbhDHUtk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 8 Apr 2021 16:49:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf/LnonOlbv6SqYWsG8Yr8xIdH5dy3OsI+moUlJ1pzy9e4eT015cWCL5OCMGp/fGut7W2FBdtQia987zA1Rd2OBlnpc7E9JW/TUHpNqcNNF0kEnxpStZlkIcjiFy9kSLbHvHvkiI7uf7sSHTrGxP9BdvUqyUSwknPmTnXdE9dJnOOGpfpegwcjgYETjv5WzyGIC2fR+ayaN5JwuLtcgHcSZ0WuVxGkInMrJz6UOCA/EpveGSf9/KXHpj7LbBTSdUcvkOps5f96bfQE7TxhgIP/+sxxhyMDb9v+fjNFJz9LUK8iWEdPZqoIpDPKjXvAqLNanRivXCCkyvtgrYfDxkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54z1sS9fYpgkNbmAMIkRQvr2EXQ1k193OM4qvoH7/tg=;
 b=Bm3yf600Up83jmmWQcnGWK52PTUIxD1e2DbKh03jncp9XJZPvNjjnSw3/JUtO1wLJNCSJETujpQOWxrqwAorINwZhCsZh/ilduHjDgOrKg1x+4XUppd7O8D13vJms3X70Faw26JhryhOAcCbYscLhkGYvqK4ZpVg07IoqtyZeZEe8CMPUwzJlwSt/+o59cJeE0C+6a1snYThUnw2QNH5sT/AzRRHGTWIkxeTCm42hFws9OvaH7h+WHlUai912UF16fkTX1Nzy21ihef6YkOBaMqOIIA3YMzaZtCJ/5/zHyuEiRg+jaSS3td3PmWK/ruoMhYxO5lM1YyZZW+RdKkExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54z1sS9fYpgkNbmAMIkRQvr2EXQ1k193OM4qvoH7/tg=;
 b=Doilw5fjtwgOBGuv31CTTmH4Vo9u90sPRXsD59E6wLPmSeYkhsTrJdBT27cCfSfA5TRQxJuSSkqhj0hSZ+7e/eYV5A8q8kcxLEB0VPmyEbymtcFM+nURGSSsmcnC7H0rB53O9zDuxP6yELe37duOACyS4XGk2N9RvtEjf5kyi4fGwzW1b4A/u1IBO4ErX7GHAiSsUUWqfOV8LwiRcdoZuF1B4EnbphP0oSk8mPHFGLMWFSkGWP4ZA7SFfBVeLojaUS4TYxw5RL/m9FwEqDTI0FIgXHKYMVd2fi0VTdutUCBCBO7/RpL/uXvmy7J/k1vh6VBTdymc1dpYSo6aKpWe4A==
Received: from CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23) by
 CH2PR12MB3878.namprd12.prod.outlook.com (2603:10b6:610:2a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29; Thu, 8 Apr 2021 20:49:27 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::61) by CO2PR04CA0145.outlook.office365.com
 (2603:10b6:104::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend
 Transport; Thu, 8 Apr 2021 20:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 20:49:27 +0000
Received: from [10.2.165.36] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Apr
 2021 20:49:26 +0000
Subject: Re: [PATCH v1] ata: ahci_tegra: call tegra_powergate_power_off only
 when PM domain is not present
To:     Dmitry Osipenko <digetx@gmail.com>, <axboe@kernel.dk>,
        <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-ide@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1617900043-10506-1-git-send-email-skomatineni@nvidia.com>
 <1617900043-10506-2-git-send-email-skomatineni@nvidia.com>
 <32ff84ba-60a7-e498-d656-bcd29d23fb02@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <b9f1a8dc-cf46-e501-606e-ce95f32b12d7@nvidia.com>
Date:   Thu, 8 Apr 2021 13:49:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <32ff84ba-60a7-e498-d656-bcd29d23fb02@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 927407c6-ae15-4c65-3b20-08d8facfcca2
X-MS-TrafficTypeDiagnostic: CH2PR12MB3878:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3878EAFDF8786ED131761176C2749@CH2PR12MB3878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RcVg4wgsQWVisUSzLpyaEQJJKp05icl3HZdfb9akPz+keOeDHpuL3704wdgFPIT7p4FvhDJzPWA/YyIwxoj2pDyQACauLY1qv9by1cT6fJMq8GkMN59x1vtq/mHK31JCcmW2R4H8Mijb8EIHdTKBacoDv4vrT5MowqeDpbUR5cUpLNX4V8e8AvlvNseU9Jddo14xpQ/6RoMwUAj0soj3yFTFmK6btA3/FQy9cYChA0IujdOeMkTYiIllHfAJw8T+0ps7zvR8GuKzWU6AxkfCjfZPUVi7Qk9OlUon5QOPPLCsupYOUttg5YqYu6CtJ0QGAuML7RbKUXfl141JYz5Fv+tlx49mV2ZMF38T3dDt/U1eDcqMS97QgkqZ6ELxQH3kktt8I7otQh2xKehYT6jOyNXYd/vbFO7bun5Nvy+OBq8AhDWUoVYG0u6JhBkpc70yd6t9bpH6wJzNNqHpPT5GrwbjdWqy1+ZbjK/7jAfsgJmVYtp/toxJAwB46bgcLVhklnxpD4NT+vcC8i2J84+og4KV3CvC7gZn72BofeRnFA4CbJTOk8fU+6OWi19g3jthsdX7KdjfeBeEdcJsbTtCr+Kf6/tXtBzEOeRUD9aRHXrNNR5yShemVzlshjoOK3SGS1gu8+41KJ2cOP6WcPzO/tMFnlkTmBhFSqay0Ffn3iZ+QSNwakjwwhatjpon4qpX5iVl8E31pOytJDKhF/VNmR2opBsl9jcafjbJ7RdwcZHXg/9wE7dQec8YKldUNabSwc6zUfrRRRCjy+Qu/l3W9Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(36840700001)(46966006)(2616005)(6666004)(426003)(336012)(31696002)(26005)(86362001)(36860700001)(8676002)(82310400003)(82740400003)(7636003)(16576012)(70206006)(70586007)(5660300002)(36756003)(2906002)(36906005)(16526019)(83380400001)(316002)(110136005)(186003)(356005)(54906003)(47076005)(966005)(4326008)(53546011)(31686004)(478600001)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 20:49:27.0324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 927407c6-ae15-4c65-3b20-08d8facfcca2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3878
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 4/8/21 12:58 PM, Dmitry Osipenko wrote:
> 08.04.2021 19:40, Sowjanya Komatineni пишет:
>> This patch adds a check on present of PM domain and calls legacy power
>> domain API tegra_powergate_power_off() only when PM domain is not present.
>>
>> This is a follow-up patch to Tegra186 AHCI support patch series
>> https://lore.kernel.org/patchwork/cover/1408752/
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>
>> ---
>>   drivers/ata/ahci_tegra.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
>> index 56612af..bd484dd 100644
>> --- a/drivers/ata/ahci_tegra.c
>> +++ b/drivers/ata/ahci_tegra.c
>> @@ -287,7 +287,8 @@ static void tegra_ahci_power_off(struct ahci_host_priv *hpriv)
>>   	reset_control_assert(tegra->sata_cold_rst);
>>   
>>   	clk_disable_unprepare(tegra->sata_clk);
>> -	tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
>> +	if (!tegra->pdev->dev.pm_domain)
>> +		tegra_powergate_power_off(TEGRA_POWERGATE_SATA);
>>   
>>   	regulator_bulk_disable(tegra->soc->num_supplies, tegra->supplies);
>>   }
>>
> There are two instances of tegra_powergate_power_off() in the driver.
Thanks Dmitry. Sorry missed it. Will fix
