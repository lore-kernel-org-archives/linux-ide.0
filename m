Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BDBC433E0
	for <linux-ide@archiver.kernel.org>; Thu,  4 Mar 2021 16:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7623764F4D
	for <linux-ide@archiver.kernel.org>; Thu,  4 Mar 2021 16:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbhCDQYU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 4 Mar 2021 11:24:20 -0500
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:31942
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237025AbhCDQYJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 4 Mar 2021 11:24:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIVI4vTt35YSCmyD4xy0ESfnI21j4a5pi+s7HFGel8+apsVQO+ppgWMpTt8J2KqUhD6S5R/NpzLtBsSl3u6reKzx2eANhQ8kXzr5b9KrSHglqxuhcrsIHZFgQctL0BSrNWyyOO/FBLHhTH7WdVl7W5dSpGvEkmahq9dDmZw5UTxac02dRQ9/UyNQuE3yuz7/+ATWtoaQP7+th3RClum0B4DeEp31h75z5xNQx19fGs0lPnA06PlmofbWRMF0quHDyxa3CNJ8tu4Ok/Xs2urKFFxY0JJOBg2uZjm3W1R197MzKjzDzt7rHsbfLSiOo+RVoSe4WSDkoeOCDjEot/O5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grs4ht2fzCEH3vYJtRZuum08JZ56Ujx+ot+6Tcw+tUY=;
 b=HzzT1XsL6uahPbltxDWachvTMZ9pLtyLFisj33IkIZ9J3JB6AZr/egsiWW/a4tpd21sKVTlLjWghYg6wM1Voyt7BA1NnkrXT0+bUayJoNfluDL8i2BzFtiY3rlY2v4FIbfe0n4Bq9mhBMA+TTGLFmx+/cL5uMrHkk2R8PKyceONCble1um5NUvYxyxUIp5KJg5KNjeF0iDsc0YVDRKF8eZnEgA57giMALcwhTa+9R8yJqmbd+lwTCSBhG384g0UPvcQoW1I7uHm+P+QJKWywMB+MUew8LPsrVlvkgZCB1+hJ4OBmfL/UY7x9q4S/8/TFbs/SZKO/YX/NLWvFM5bsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grs4ht2fzCEH3vYJtRZuum08JZ56Ujx+ot+6Tcw+tUY=;
 b=EB+/+uvlAqDLcQaMZR+6OPib5DZKpLhb2HFbUiBZ9lgGc4B5+8v/SYo3zXZCbbRKWxt//vA+GoF7W/kXm6YfD6KOWOomGGI/3LpZadEHkt1HbJxXUVDiPzifWj0syv0QZwNWqax0QNNytHu5acYR/rT/Wb5tRed/1NEJ6lQ7UOA=
Received: from DM6PR06CA0031.namprd06.prod.outlook.com (2603:10b6:5:120::44)
 by DM6PR02MB4217.namprd02.prod.outlook.com (2603:10b6:5:9a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 4 Mar
 2021 16:23:16 +0000
Received: from DM3NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::eb) by DM6PR06CA0031.outlook.office365.com
 (2603:10b6:5:120::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend
 Transport; Thu, 4 Mar 2021 16:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT003.mail.protection.outlook.com (10.13.4.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 4 Mar 2021 16:23:15 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 4 Mar 2021 08:23:02 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 4 Mar 2021 08:23:02 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org,
 axboe@kernel.dk
Received: from [172.30.17.109] (port=52412)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lHqkf-0000Oz-Q5; Thu, 04 Mar 2021 08:23:02 -0800
Subject: Re: [PATCH] ata: ahci: ceva: Updated code by using dev_err_probe()
To:     Piyush Mehta <piyush.mehta@xilinx.com>, <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>, <michal.simek@xilinx.com>
References: <20210304155309.17878-1-piyush.mehta@xilinx.com>
 <20210304155309.17878-2-piyush.mehta@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d67580bc-6178-6c7f-54c8-a3dffe8d554d@xilinx.com>
Date:   Thu, 4 Mar 2021 17:22:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210304155309.17878-2-piyush.mehta@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e51ad6c1-6800-4f7d-ba8d-08d8df29d0ac
X-MS-TrafficTypeDiagnostic: DM6PR02MB4217:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4217893410529DD57F0C2821C6979@DM6PR02MB4217.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EkN0tWsjBlrhwY2pZsjioh/RHFFLm0Co2j1ZLr/YhnHxp7qU8TrzRDxTu72BJFcgwJF492EoU6wufKXD4PDPZ0LHltHgoYMHBnyAg1QoJCUf0Pyi+4UlXzpSHOFWZ3bw6Aj5NpU5NTkQordYlDCuUGksczTKh1b/D6bxh3ket9hpsgOmTcictt53sTMw5w0l1GBLTJQN6ncOUA0/9uauK5bbjCAv7hn2cR17U6pbGoKsXX2A38LR9L8GZPZcv9XWQQ15jOGTyww7Igxga71UtdKkZs+44J/H4X5lHws8AsEuvfncjh18Ejs9GC7UETzwf3pr5pd996GqKu8x+fTUY38P9DAt9VLK2jB21y2Y9g4vP5gL2ITiwc4wyeDmvdo0HbvktEW08mmC73e4lgiu9m0Symo+Utu448mYgkNWUyEef73Ww/4+rzcx2MN5/ThNpqizaUExYUQsJguUGF18Ie85l+W8rD+GkGlK64ijbhmx/1rS1+ol2gb/x/scuIrk6KZowZCwpG0ob3oH7itHUGof9Nu5K/uSFB94Z2rnpkOgg8tSFHZzuQmELztHLRQ+EocloqS1XIf0wwhZLzatS97nGpTjIgRtw5bFceksOrlvHuiTrLsA0oc03oxwlFX880LsewEA2ZKIP7ajRQrzq7/T+PEN0afDJQpMOvd1+cNd8D0PzQci59Lj8Ue9ChHr5YQsR8dh+u+OdHQgaOg2c34PcvLyfn6m/pH4V0RgFoclMs7liHPF9/o/V9cLgmVib2ZNSVoc4kodhlXS6l11e/jts1TYsNMCzvl2k0SehWU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(54906003)(356005)(186003)(8936002)(110136005)(7636003)(9786002)(31686004)(36860700001)(8676002)(83380400001)(53546011)(478600001)(15650500001)(2616005)(107886003)(47076005)(5660300002)(4326008)(426003)(2906002)(31696002)(70206006)(82310400003)(966005)(36756003)(336012)(82740400003)(70586007)(44832011)(36906005)(6666004)(316002)(26005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 16:23:15.9669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e51ad6c1-6800-4f7d-ba8d-08d8df29d0ac
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4217
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 3/4/21 4:53 PM, Piyush Mehta wrote:
> Updated code with already prepared dev_err_probe(). It reduces code size
> and simplifies EPROBE_DEFER handling.
> 
> Also, unify message format for similar error cases.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
> This patch is based on ahci-ceva patches:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=5542fabd9e07d6c49c07862e73070c325f93d390
> 
> Tree: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/tree/?h=for-next
> ---
>  drivers/ata/ahci_ceva.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
> index b980218..a935209 100644
> --- a/drivers/ata/ahci_ceva.c
> +++ b/drivers/ata/ahci_ceva.c
> @@ -207,9 +207,8 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  	cevapriv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
>  								  NULL);
>  	if (IS_ERR(cevapriv->rst)) {
> -		if (PTR_ERR(cevapriv->rst) != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "failed to get reset: %ld\n",
> -				PTR_ERR(cevapriv->rst));
> +		dev_err_probe(&pdev->dev, PTR_ERR(cevapriv->rst),
> +			      "failed to get reset\n");
>  	}

I got it twice not sure why.

nit: Sorry I didn't spot it in the first internal review.
But you can also remove that {} around.

With that fixed please add my
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

