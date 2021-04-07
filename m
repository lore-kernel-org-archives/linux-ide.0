Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20B5C433ED
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 23:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767D1611C9
	for <linux-ide@archiver.kernel.org>; Wed,  7 Apr 2021 23:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhDGXAi (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:00:38 -0400
Received: from mail-dm6nam12on2088.outbound.protection.outlook.com ([40.107.243.88]:64704
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229449AbhDGXAg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 7 Apr 2021 19:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLU37oZYRKNESf+0Ig/DN/4A8q8pfYaUCyF6CbmcEKVTr/bNlYZLEuqhCJTBw0vcmOKW5qr2vy/0ka6/bCQ+l3sZZeYvY8aLZPpZhiwS1pvfoEm06wIpkQSJK9uRoAzwWUEVykciECW/mL3DT/fYEooFwQGCj+PBrfZU8mTwu2Niv5GkQS8vgDALNZZewqkGtskXkGa24yiTUGxVdfWMIH7nOsPHKebGpiGjaVXkko92NXariskTUQRXm1HZ/V6IyA1R1/04017Xkopor4XkWsnkRDbREKNd7hVJhqqaaSh6zjBP1dWaKYAH/L9H+wtsGQCxJM2aXCGvNcv2NC8Jew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOpNfZkitU43azEhaIzoaq9rq+K7AAqP5gll3M5uEhc=;
 b=WyD/F2S96L1gSvxjlQtrgFQDD2SKzKV7XR/BTJrPuZ1uLJ98uQlsowlY/BTUBabN+5NDPWzVQ3iB9SETT6EvE5YWlxeyOivq2g+pdS795POV1PsUmCCbNxIlkfq+dGqSRguj4NfeLPObZmmpvZ6a8J9IYxC+7YPzIn6QSntndDiIAf6WHV8YCXUZDoJylAQs14bmB3/xe4QI2r4MXbRfTaIPX02wbkVkm5hDKPKASV2c30uIjdjIVvS9rMpCLLFm/PfUcF1sOs4PdjtyaREB5et419IAFdXM39wkyzB2w0UXfDOJklhYQMszuH54Y8H6e3ioIRd93lElB4qBTaMvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOpNfZkitU43azEhaIzoaq9rq+K7AAqP5gll3M5uEhc=;
 b=Du+4JrYrxp48dDJidgTr/x1OuMXLtBWpxbR3PT9c9Qh6PiJZlqxlhW78sK1EaGMwtgzUdj7N1GdjtKIjvleLqAPdtZx7/fR+IS+otwuPKZs9iEa8XGxw1Nu2IkOTxzLq73DkhqmKHaqul9GyRHHo1h7VPOLvaupOkTCbTuxJsJKv7ftlEtavNi0NHXSP2SEUEuO8X+G5BWVJjMtyrKky4K3FZUmH7bLtcayjPtejSb3p4VcZQkpNxRRHVFzgrbuYAexnO7jT3vbH5wXLm16LqwiVZ6NZGW4J4NDetSlp4eYKS6cEwH8us20Yt2+Igmz3/BrjBtTFwyCzgQ3ghbm4iw==
Received: from DM5PR1101CA0010.namprd11.prod.outlook.com (2603:10b6:4:4c::20)
 by DM4PR12MB5295.namprd12.prod.outlook.com (2603:10b6:5:39f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 7 Apr
 2021 23:00:25 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::5b) by DM5PR1101CA0010.outlook.office365.com
 (2603:10b6:4:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Wed, 7 Apr 2021 23:00:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 23:00:25 +0000
Received: from [10.2.165.36] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Apr
 2021 23:00:24 +0000
Subject: Re: [PATCH v4 3/3] ata: ahci_tegra: Add AHCI support for Tegra186
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>, <axboe@kernel.dk>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <pchandru@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1617758731-12380-1-git-send-email-skomatineni@nvidia.com>
 <1617758731-12380-4-git-send-email-skomatineni@nvidia.com>
 <594c622e-4505-3448-1c7b-eae8f36cbad8@gmail.com>
 <49eba27e-18fa-b682-1385-2930dfff28ac@nvidia.com>
Message-ID: <01fd01ab-f4e7-57ee-2ad7-2aabaeb92a0e@nvidia.com>
Date:   Wed, 7 Apr 2021 16:00:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <49eba27e-18fa-b682-1385-2930dfff28ac@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac8213d2-8264-478e-0036-08d8fa18ee27
X-MS-TrafficTypeDiagnostic: DM4PR12MB5295:
X-Microsoft-Antispam-PRVS: <DM4PR12MB529568B7D3365E2CF6BAADFBC2759@DM4PR12MB5295.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyXOKR3bQ80Zhphg4M5z6x0xaNTEJxVFqloZPy6yWqb/adtTZ98ELYnS3XLuWT28J6AtMb5QcjSnmYOgr9u3f4LYqc4gLX/8jEmUCXGcb0gcvhmLmM8QkumtLbkGarwcDRTy2hh0kvitJ62kQuy0/lv6MVRnqDoNQDiyUvMzGztIu4n+hjf82KFu2x9zpf+0hDeBGJrAK+faUIXVQ0nnYI80EdILPTXXSrewpvLgQPRctbkIXjm7uCMYkEnLdrE4najtAPe6vBnAICyDOLfdA8wqINgu58mTj74MgZhwFXixjPfUVUyRw6kkDWrex1cB0K0Ay0nlcIwHEJ2s8JvxiNFuSL5edDDMX5+Hz/t/qZmnXC3LyLanRq+xXAi61JhpauvPOnpQP3MMCH0XtU3Uv3dXgT2fFfRmglFdyMsFLNzoLn4UxTMN83egCvU1ICh4O5BXJHPoFbVOWeN8jeuecVZYVTY/iU2pZAigCROAMXGd3GwOPSZ5jPEbSVyA+k0wtAjCE9EitriAJ8/+ue3fKHk6Gpqx3NCpKrWcegatMvKQTKLRFm10HKzqBPjPLXjAVPSG+nVMLEpvbs02mH8Vd3Ydu4y4rVIKz0g8UVXIZeU7igRx2/x4KdkjRFYdsQIRljjugcpWaQNKPfiI06teClRKyeWDBF4yzDUvkZTJVAcMhRws16/yFSD9RdMzK2kQ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(82740400003)(16526019)(7636003)(4326008)(83380400001)(31696002)(82310400003)(186003)(31686004)(5660300002)(70586007)(70206006)(356005)(6666004)(26005)(2906002)(36756003)(86362001)(36906005)(426003)(53546011)(8936002)(47076005)(478600001)(336012)(8676002)(54906003)(110136005)(16576012)(36860700001)(2616005)(316002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 23:00:25.3588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8213d2-8264-478e-0036-08d8fa18ee27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5295
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 4/7/21 3:57 PM, Sowjanya Komatineni wrote:
>
> On 4/7/21 2:36 PM, Dmitry Osipenko wrote:
>> 07.04.2021 04:25, Sowjanya Komatineni пишет:
>>> +    if (!tegra->pdev->dev.pm_domain) {
>>> +        ret = tegra_powergate_sequence_power_up(TEGRA_POWERGATE_SATA,
>>> +                            tegra->sata_clk,
>>> +                            tegra->sata_rst);
>>> +        if (ret)
>>> +            goto disable_regulators;
>>> +    }
>> Hi,
>>
>> Why you haven't added condition for tegra_powergate_power_off()? I think
>> it should break GENPD and legacy PD API isn't not supported by T186 
>> at all.
>>
>> I'm also not sure whether the power up/down sequence is correct using 
>> GENPD.
>>
>> Moreover the driver doesn't support runtime PM, so GENPD should be
>> always off?
>
> This driver already using legacy PD API's so thought its supported and 
> added power domain device check during powergate_sequence_power_up and 
> yes same should apply for powergate_power_off as well. But if legacy 
> PD is not supported by T186 then not sure why original driver even 
> using these API's.
>
>
Sorry just took a look and driver supports T210 and prior tegra as well. 
T210 and prior supports legacy PD and this check is applicable for 
those. So we should add power domain device check for power off as well.

But for T186, we should have GENPD working once we add runtime PM 
support to driver.

Preetham/Thierry, Can you confirm where SATA is un powergated prior to 
kernel?


> But as RPM is not implemented yet for this driver, GENPD will be OFF 
> but SATA is not in power-gate by the time kernel starts and 
> functionally works.
>
> But with RPM implementation, I guess we can do proper power gate on/off.
>
