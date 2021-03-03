Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C6C43333
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545FF64EBD
	for <linux-ide@archiver.kernel.org>; Wed,  3 Mar 2021 22:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390140AbhCCWBH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Mar 2021 17:01:07 -0500
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:45174
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235276AbhCCMMK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 3 Mar 2021 07:12:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHrdR4MWed+w+G0eeHA9l4k8tob211ULFvp/ev7UcfzvIfOMxzcmYB4pkl9AwsQYRdOJRH4cS+d0N/gb4LgV8NnJpxXyRMjG+vjOhzXtQ/55wiLNJ2fesQicTMEe3Zx2+FwKHxmM8iDLvjVEKtgGDeRHAhplCb0MjiiKG8cX7QLDouFrvspUGk6xzd9P5scVBVwK9XyorJntY/wExnbRAn5W8N38vsMHOWEOARzDpHmQkDgGfdV3o4ZhAo4ePnyq4PfusZnQaGwKA7fxQJkcS7g+dfvs86yrLfIZ26y7tiWmt+Gu4Tt7uBxuXsuP77tW1nmS85Bq3AdEhRUBpc5Y9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J99bGyfBDz+jR2exGIN0X7eRCzNgcXf1QKrmW6L4f5w=;
 b=PPJDNye/b5MKAVMeAsmfnaoSI5Gihuo/lmoH4XijtF3vSISfua00yuunBLDiBnUeOS1GAFQdWbf9ZEwa363XpWg45op6migEOgksVAIsHQsrUPFxQFLPUAkTn7iRD40oXoh+tShqtYf7cdbpFyQhQi2Y84QFe9xAASgchO6RZ76DNwk7/DM1khJWkObD4/Gb9alanK3XGqkkDq+pgbyDTpIDcMlWJn3LCtHx5SDTeno5JH7OgW/tRtE35fTbGHe/2y7V5wIp62Cdfe1gymTh9NRqOUmwGrVS+d9hWDhMgpTOQbLI12xXH8DrD3OlITZNaLglW1SzZE059+41DK6F1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J99bGyfBDz+jR2exGIN0X7eRCzNgcXf1QKrmW6L4f5w=;
 b=BsPNaxHDioY/TluAra8dCgX0Rz4mxKXJoBsCu7zCSOavrekPqUTTSiegL6EL1zkxF7CiEIhtEOU9OXu4jMQxUJg259TjkVN+ZfJNhEejxSNQPiCjd3C35haN0fmxENgaHZ+f+WR0cn5njnlWCwZ4cOy6Etl9IJFYOWE2EvjCPGw=
Received: from CY4PR01CA0003.prod.exchangelabs.com (2603:10b6:903:1f::13) by
 CH2PR02MB6662.namprd02.prod.outlook.com (2603:10b6:610:aa::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Wed, 3 Mar 2021 12:07:53 +0000
Received: from CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:1f:cafe::7a) by CY4PR01CA0003.outlook.office365.com
 (2603:10b6:903:1f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 3 Mar 2021 12:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT018.mail.protection.outlook.com (10.152.75.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Wed, 3 Mar 2021 12:07:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 3 Mar 2021 04:07:46 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 3 Mar 2021 04:07:46 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-ide@vger.kernel.org,
 robh+dt@kernel.org,
 p.zabel@pengutronix.de,
 axboe@kernel.dk
Received: from [172.30.17.109] (port=43202)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lHQI5-0001MR-7P; Wed, 03 Mar 2021 04:07:45 -0800
To:     Piyush Mehta <piyush.mehta@xilinx.com>, <axboe@kernel.dk>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>
CC:     <linux-ide@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        <sgoud@xilinx.com>, <michal.simek@xilinx.com>
References: <1612807436-5238-1-git-send-email-piyush.mehta@xilinx.com>
 <1612807436-5238-3-git-send-email-piyush.mehta@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH V3 2/2] ata: ahci: ceva: Update the driver to support
 xilinx GT phy
Message-ID: <c60d9993-e16b-ef5e-ff01-c11212e0d0f8@xilinx.com>
Date:   Wed, 3 Mar 2021 13:07:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1612807436-5238-3-git-send-email-piyush.mehta@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 822075dc-8084-4091-76c9-08d8de3cf90b
X-MS-TrafficTypeDiagnostic: CH2PR02MB6662:
X-Microsoft-Antispam-PRVS: <CH2PR02MB666229A397B092A2265B91EFC6989@CH2PR02MB6662.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATjrUxbPG7aG2wj07fkhpto2jQfnTyZYm3gsOo35v1V0MWGEywiw6HgFj17WGtHcmX6gg+bZQSBQGxwNdBJ3aPcHsywfDVb7F6EYK1J+rIbZDLC1TIP/BDGJwZxvcI1Urgcho68JUkC/VDlCKkGRVghVECeuwg99Z33AIrKXdx41ro6lpEtzGm9LkD1R5VsXxBA+SIpJvLhOJrHNgy2An1ph6DngXeK0+dv834msD2wesRM+NqthUdvoqWzbY0k+oRHzeLFohvlge/x7BMyFAbeILsrL70PIiVjMpXs30WaDPdcLcWZChjbZqfkP/uoMT1AcVUDG4T3jY652ohnEYia0hm0KisyM071RhvDx+Uv1i96Dcl6IJYsZ4RgGONhXQKlDtRZ/Liz9ixqNxdLHRCeWtcCxNYb7nxoXv2qe6vSqyk0WaPN1tdqIRbn2Os6LQoSswV8sJcOycd0638ZHvS0wwgkvCP4V9qKzcrVBSm1I/HFwZYYMy0Fue4LTYoGcLToeh4mKrsOqdnFh6FPnmHr5vcRG/0jKq+iyBwmJtWS9EtE3wX3h3JzpVdDZWv0FFWACrH6nQTeI5LjlUqFpnUAXBLJie3SVVjMJJQ0ID11nIV+zLywRkQXEc/tg4wbDIAF72nLynd7Y6mvllOqGxU7qZCfVAfw1fUGwzBwYl9Rgj8vv40erQW69RlYHlj0ORQtU+BwfwQWGgmVhkW50XA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39850400004)(376002)(46966006)(36840700001)(6666004)(2616005)(478600001)(107886003)(47076005)(31686004)(44832011)(4326008)(2906002)(186003)(9786002)(356005)(7636003)(26005)(83380400001)(54906003)(110136005)(53546011)(70586007)(8676002)(70206006)(36756003)(31696002)(82740400003)(8936002)(15650500001)(36860700001)(336012)(316002)(426003)(82310400003)(36906005)(5660300002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 12:07:52.9977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 822075dc-8084-4091-76c9-08d8de3cf90b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6662
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 2/8/21 7:03 PM, Piyush Mehta wrote:
> SATA controller used in Xilinx ZynqMP platform uses xilinx GT phy
> which has 4 GT lanes and can be used by 4 peripherals at a time.
> SATA controller uses 1 GT phy lane among the 4 GT lanes. To configure
> the GT lane for the SATA controller, the below sequence is expected.
> 
> 1. Assert the SATA controller reset.
> 2. Configure the xilinx GT phy lane for SATA controller (phy_init).
> 3. De-assert the SATA controller reset.
> 4. Wait for PLL of the GT lane used by SATA to be locked (phy_power_on).
> 
> The ahci_platform_enable_resources() by default does the phy_init()
> and phy_power_on() but the default sequence doesn't work with Xilinx
> platforms. Because of this reason, updated the driver to support the
> new sequence.
> 
> Added cevapriv->rst check, for backward compatibility with the older
> sequence. If the reset controller is not available, then the SATA
> controller will configure with the older sequences.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
> ---
>  drivers/ata/ahci_ceva.c | 43 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
> index b10fd4c..b980218 100644
> --- a/drivers/ata/ahci_ceva.c
> +++ b/drivers/ata/ahci_ceva.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include "ahci.h"
>  
>  /* Vendor Specific Register Offsets */
> @@ -87,6 +88,7 @@ struct ceva_ahci_priv {
>  	u32 axicc;
>  	bool is_cci_enabled;
>  	int flags;
> +	struct reset_control *rst;
>  };
>  
>  static unsigned int ceva_ahci_read_id(struct ata_device *dev,
> @@ -202,13 +204,48 @@ static int ceva_ahci_probe(struct platform_device *pdev)
>  
>  	cevapriv->ahci_pdev = pdev;
>  
> +	cevapriv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
> +								  NULL);
> +	if (IS_ERR(cevapriv->rst)) {
> +		if (PTR_ERR(cevapriv->rst) != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "failed to get reset: %ld\n",
> +				PTR_ERR(cevapriv->rst));
> +	}

nit: This can be handled via dev_err_probe() to simplify this logic here.
It was added by a787e5400a1c ("driver core: add device probe log
helper") but up to Jens if he wants this to be fixed.

> +
>  	hpriv = ahci_platform_get_resources(pdev, 0);
>  	if (IS_ERR(hpriv))
>  		return PTR_ERR(hpriv);
>  
> -	rc = ahci_platform_enable_resources(hpriv);
> -	if (rc)
> -		return rc;
> +	if (!cevapriv->rst) {
> +		rc = ahci_platform_enable_resources(hpriv);
> +		if (rc)
> +			return rc;
> +	} else {
> +		int i;
> +
> +		rc = ahci_platform_enable_clks(hpriv);
> +		if (rc)
> +			return rc;
> +		/* Assert the controller reset */
> +		reset_control_assert(cevapriv->rst);
> +
> +		for (i = 0; i < hpriv->nports; i++) {
> +			rc = phy_init(hpriv->phys[i]);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		/* De-assert the controller reset */
> +		reset_control_deassert(cevapriv->rst);
> +
> +		for (i = 0; i < hpriv->nports; i++) {
> +			rc = phy_power_on(hpriv->phys[i]);
> +			if (rc) {
> +				phy_exit(hpriv->phys[i]);
> +				return rc;
> +			}
> +		}
> +	}
>  
>  	if (of_property_read_bool(np, "ceva,broken-gen2"))
>  		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Jens:  Can you please take a look at this patch if you see any other issue?

Thanks,
Michal
