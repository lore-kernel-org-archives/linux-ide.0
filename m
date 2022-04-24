Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59063C433EF
	for <linux-ide@archiver.kernel.org>; Sun, 24 Apr 2022 17:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiDXR4l (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Apr 2022 13:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbiDXR4l (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2022 13:56:41 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778E915E87F;
        Sun, 24 Apr 2022 10:53:39 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 11CEC20A0468
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 2/5] ata: libata-core: Refactor force_tbl definition
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
References: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
 <20220407123748.1170212-3-damien.lemoal@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <eefb2f6e-3f38-28bb-6e96-8eb42d27933b@omp.ru>
Date:   Sun, 24 Apr 2022 20:53:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220407123748.1170212-3-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/7/22 3:37 PM, Damien Le Moal wrote:

> Introduce the macro definitions force_cbl(), force_spd_limit(),
> force_xfer(), force_lflag_on(), force_horkage_on() and
> force_horkage_onoff() to define with a more compact syntax the struct
> ata_force_param entries in the force_tbl array defined in the function
> ata_parse_force_one().
> To reduce the indentation of the array declaration, force_tbl definition
> is also moved out of the ata_parse_force_one() function.

   Some entries are reordered too... :-)

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index bc59c77b99b6..c0cf42ffcc38 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -6143,67 +6143,90 @@ int ata_platform_remove_one(struct platform_device *pdev)
>  EXPORT_SYMBOL_GPL(ata_platform_remove_one);
>  
>  #ifdef CONFIG_ATA_FORCE
> +
> +#define force_cbl(name, flag)				\
> +	{ # name,	.cbl		= (flag) }

   Why not #name here and below?

> +
> +#define force_spd_limit(spd, val)			\
> +	{ # spd,	.spd_limit	= (val) }
> +
> +#define force_xfer(mode, shift)				\
> +	{ # mode,	.xfer_mask	= (1UL << (shift)) }
> +
> +#define force_lflag_on(name, flags)			\

   Not just force_lflag()?

> +	{ # name,	.lflags		= (flags) }
> +
> +#define force_horkage_on(name, flag)			\
> +	{ # name,	.horkage_on	= (flag) }
> +
> +#define force_horkage_onoff(name, flag)			\
> +	{ "no" # name,	.horkage_on	= (flag) },	\
> +	{ # name,	.horkage_off	= (flag) }
> +
[...]
> @@ -6285,7 +6308,7 @@ static void __init ata_parse_force_param(void)
>  	int last_port = -1, last_device = -1;
>  	char *p, *cur, *next;
>  
> -	/* calculate maximum number of params and allocate force_tbl */
> +	/* Calculate maximum number of params and allocate ata_force_tbl */

   Drove-by change? :-)

[...]

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

MBR, Sergey
