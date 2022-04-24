Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26D7C433F5
	for <linux-ide@archiver.kernel.org>; Sun, 24 Apr 2022 18:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiDXSER (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Apr 2022 14:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbiDXSEQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2022 14:04:16 -0400
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7CFBFD;
        Sun, 24 Apr 2022 11:01:11 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru E52C820ED8D0
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 3/5] ata: libata-core: Improve link flags forced settings
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <linux-ide@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
References: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
 <20220407123748.1170212-4-damien.lemoal@opensource.wdc.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d5440596-d599-06df-ad9f-96edee5bf514@omp.ru>
Date:   Sun, 24 Apr 2022 21:01:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220407123748.1170212-4-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 4/7/22 3:37 PM, Damien Le Moal wrote:

> Similarly to the horkage flags, introduce the force_lflag_onoff() macro
> to define struct ata_force_param entries of the force_tbl array that
> allow turning on or off a link flag using the libata.force boot
> parameter. Using this new helper macro, define a new force_tbl entry
> for the ATA_LFLAG_NO_DEBOUNCE_DELAY link flag, thus allowing testing if
> an adapter requires a link debounce delay or not.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/ata/libata-core.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c0cf42ffcc38..75856f4210d7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
[...]
> @@ -6154,7 +6161,11 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
>  	{ # mode,	.xfer_mask	= (1UL << (shift)) }
>  
>  #define force_lflag_on(name, flags)			\
> -	{ # name,	.lflags		= (flags) }
> +	{ # name,	.lflags_on	= (flags) }

   The same comment about #name...

> +
> +#define force_lflag_onoff(name, flags)			\
> +	{ "no" # name,	.lflags_on	= (flags) },	\
> +	{ # name,	.lflags_off	= (flags) }
>  
>  #define force_horkage_on(name, flag)			\
>  	{ # name,	.horkage_on	= (flag) }
[...]

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

MBR, Sergey
