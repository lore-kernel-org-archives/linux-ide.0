Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C84C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  8 Mar 2022 08:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240640AbiCHIlh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Mar 2022 03:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiCHIlh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Mar 2022 03:41:37 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC9C3FBD5;
        Tue,  8 Mar 2022 00:40:38 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 7728820EAF98
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] ata: Use platform_get_irq() to get the interrupt
To:     <cgel.zte@gmail.com>
CC:     <damien.lemoal@opensource.wdc.com>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "Zeal Robot" <zealci@zte.com.cn>
References: <20220308025940.2077329-1-chi.minghao@zte.com.cn>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <db22c7c4-8b87-cd6d-469d-2cdd7046a25e@omp.ru>
Date:   Tue, 8 Mar 2022 11:40:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220308025940.2077329-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello!

   Please be more specific in the subject: s/ata:/pata_pxa:/.

On 3/8/22 5:59 AM, cgel.zte@gmail.com wrote:

> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> 
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypassed the hierarchical setup and messed up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---
>  drivers/ata/pata_pxa.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 41430f79663c..6394ab4cbc1b 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
[...]
> @@ -205,8 +205,8 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	/*
>  	 * IRQ pin
>  	 */
> -	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (unlikely(irq_res == NULL))
> +	irq = platform_get_irq(pdev, 0);
> +	if (unlikely(irq < 0))
>  		return -EINVAL;

   Why did you not switch to returning 'irq'? The way it is now, the deferred
probing doesn't work...

[...]

MBR, Sergey
