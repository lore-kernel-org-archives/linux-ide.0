Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADEDC433B4
	for <linux-ide@archiver.kernel.org>; Tue,  6 Apr 2021 14:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35750613A7
	for <linux-ide@archiver.kernel.org>; Tue,  6 Apr 2021 14:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhDFOLp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 6 Apr 2021 10:11:45 -0400
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:37952
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232041AbhDFOLp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 6 Apr 2021 10:11:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzee384JeqkizJcL+4T6aiphQqM7V0IVCcF/SugOHoMHqYj22oIjY6vsyDMXrrYxZJ222v4hMJA1rb5cWXWGcarJv80WzU26t8fSJOTzS5ksrvE/suyQXciIObWjbE/TStQpXfhLidKq83MvF9eF2H3x/wZpvNNdzQLcOm0bzhpzp1Up/ffPOsba59BKAV1BHf4/jQ+xll/GP3Z203L7G/F4TvI5tn4m/dNbjH+dYKWtKc0ek5xBH2U8jiR/JHeXSr9mbiwZ01BAbvn9iQTUD29OXzc34UEJPZhDS/lI/QkIxZiUwZI3KfIdYHEmGxZWrKcxi1o2yjU/Exb+6U4pkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcMDlHyoz7FboS2bEQzfaLN/13dlEm0bYn7LMts6MF8=;
 b=LuPNrcdjpV0V0Lwdr4k8EIIxF5BElVUPk3j2+OxrvGQilVISMdbQQXYFc1lacXMHr3HRJuVDr19c5zdiaCEVckXL+dyAHw58ZTuNoryVSD6U2ETA9Y8WK+yuxPHgIj7mJyLQJufLsDzB7C5X60uXLaNmWIF3CV659f6dZpeHY8/rI1sMytKdKrvJzz1ljiJp3yPH4MftaY3QR3kafaKteXLLMOzvIVXwBpMp5bfyJcRDzwO2xm3fBogX4HfYrj9EqKGRbBqMeBpd1uRFk8goJd8eHMn9KN35Y+Mq9ztA2g6Lc/m1QwAAROJyWu70G4CgiPjNajmCBrG2ZD1txnHGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcMDlHyoz7FboS2bEQzfaLN/13dlEm0bYn7LMts6MF8=;
 b=TSk6YnHPG0QloG9yBLwSjqOdpKvTQ0rMDSgEW6DYW8ZAyMrdRCAP0srwpWk0N+cFE5r7P2gltSCG+K2gVlYpGRrxfdALZHnKmeY2C3j5RxX62FmldNJLszhkWYGhUPkrf3NapI/cG56iZiXblkpq7409ZgLVfEUnc5bEe7muH1c=
Received: from MN2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:208:120::26)
 by DM6PR02MB6345.namprd02.prod.outlook.com (2603:10b6:5:1fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 14:11:35 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:120:cafe::5e) by MN2PR10CA0013.outlook.office365.com
 (2603:10b6:208:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 14:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 14:11:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 07:11:34 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 6 Apr 2021 07:11:34 -0700
Envelope-to: git@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org,
 axboe@kernel.dk
Received: from [172.30.17.109] (port=56710)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lTmQW-00071X-Pn; Tue, 06 Apr 2021 07:11:33 -0700
Subject: Re: [PATCH V2] ata: ahci: ceva: Updated code by using dev_err_probe()
To:     Piyush Mehta <piyush.mehta@xilinx.com>, <axboe@kernel.dk>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <sgoud@xilinx.com>, <michal.simek@xilinx.com>
References: <20210305091029.23378-1-piyush.mehta@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <6c485429-62a4-608f-6600-4e1f6e88c4e0@xilinx.com>
Date:   Tue, 6 Apr 2021 16:11:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210305091029.23378-1-piyush.mehta@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63ff816e-1c57-42a1-06b6-08d8f905e300
X-MS-TrafficTypeDiagnostic: DM6PR02MB6345:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6345E0EB2D51DBD4B4954400C6769@DM6PR02MB6345.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNziGtTTFkpiLlSslhy5655c3jqdkVMdGGR8p2pcEpgzN3UKLKgKaWUfwRa4dbq8PodjHI6c/yKBe22mAgwDGNyrudQZtrNinZO0HSkWxwmPnFJkfF71ukEg00QWbfjwcnyX6RFcC6KFIh+Y35/VGHBasyElVnf137PxXDpaNSAeRncc02HT9T8twmAGX6C48XslGbWetqSv0eiytZkpt7ziF/szrQqjnBRqmBpLSA6P6Wph9H+LUWwdj7g2cUcKxo/VvGx6xtTSbd4qx32AkD8G2KiIZWKQ5V8VDaOiaY+ii+PP5OOlELdMph7MOifmYVx/s16bw7AGuKgpfuXLXttYi8ZF8RGkDZqNXQuLfWmaD2arl5m3kJi1l9jDeAktF9v2Gnn7o2LZ8k/JrN+Q5AApkntqExW1YbXsTAaGXQkEv46Tjw94PLUufCr1sZO69IbyAm+pnoq3IUQgPz5yudBCn6nXmmD98lJD74W0vVW+528zt4rD073EXZPXj2Ai2GSULHdzLwqfXDScpig4OHxBze6A7N3lZEIzkbMCFKqkbL6UgK1FezrRg0acL7NeaXUBqXhlVBLM8/hL4l3j4pMZAxyaOGzOBocqzsyuEN7OZMWR3tiZ/KN6M9vM7TPdBctdOhbPY8QO5dAffj0ITNZjbFYnmWYGGrP8OS+OikVWpKfPPFhYqgLOmQLNI4hgz5hqzvaL0majGwzsWgihEk6Vozvyj8LRymkunGN43rJVYF/bsNZUpjq+IQOl5i295bXyfR/ruZm892hqxVy07rlf4dWhqEB/jbzH8bFi3hE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(70206006)(2616005)(70586007)(110136005)(7636003)(186003)(15650500001)(8936002)(36906005)(478600001)(31686004)(5660300002)(83380400001)(36860700001)(8676002)(82740400003)(9786002)(53546011)(356005)(36756003)(336012)(31696002)(316002)(107886003)(966005)(426003)(82310400003)(54906003)(26005)(2906002)(47076005)(44832011)(4326008)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 14:11:35.0108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ff816e-1c57-42a1-06b6-08d8f905e300
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6345
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Jens,

On 3/5/21 10:10 AM, Piyush Mehta wrote:
> Updated code with already prepared dev_err_probe(). It reduces code size
> and simplifies EPROBE_DEFER handling.
> 
> Also, unify message format for similar error cases.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
> This patch is based on ahci-ceva patches:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=5542fabd9e07d6c49c07862e73070c325f93d390
> 
> Tree: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/tree/?h=for-next
> 
> Changes for V2:
> - Address review comment- remove curly brackets {}. 
> ---
>  drivers/ata/ahci_ceva.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
> index b980218..50b56cd 100644
> --- a/drivers/ata/ahci_ceva.c
> +++ b/drivers/ata/ahci_ceva.c
> @@ -206,11 +206,9 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  
>  	cevapriv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
>  								  NULL);
> -	if (IS_ERR(cevapriv->rst)) {
> -		if (PTR_ERR(cevapriv->rst) != -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "failed to get reset: %ld\n",
> -				PTR_ERR(cevapriv->rst));
> -	}
> +	if (IS_ERR(cevapriv->rst))
> +		dev_err_probe(&pdev->dev, PTR_ERR(cevapriv->rst),
> +			      "failed to get reset\n");
>  
>  	hpriv = ahci_platform_get_resources(pdev, 0);
>  	if (IS_ERR(hpriv))
> 

Can you please apply this to your tree?

Thanks,
Michal
