Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6EBC433EF
	for <linux-ide@archiver.kernel.org>; Wed,  9 Mar 2022 07:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiCIHcU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 9 Mar 2022 02:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiCIHcR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 9 Mar 2022 02:32:17 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A7D97BB6
        for <linux-ide@vger.kernel.org>; Tue,  8 Mar 2022 23:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646811078; x=1678347078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z0K9EobAhTG23cdSoI4HeQz1FcdsM41KlEgvysVGDFM=;
  b=NBj6j/xHXaSDx5qoW++awOhMNNMstwExYG91szrCEyxYzO0ZefraCGXV
   jk+exn5CgdISkz/xEeQjGBXOE00PDbeRiLljX/v0lh2Aqidpfg/8vZEYG
   l7Swe1MerIeVh4/1qnWz/Ip7JJKVNwXNWFNPAZy6eL0/oErWHG/K1wXID
   Ly00ZV1dPC3xh/q5B+XTj7LJzjNPsR92uMyRIE1z6zIf09opC5TVwzaDi
   nBA4mVulIjOujjfdJBtqfPUiFm4Bnze4SgOkn6MPBmmsfwnmBO31qFFsZ
   dN2+xU8fTu7w/q2ZB8yqbkw1jhgkZZcd+M07LCZ4FrhFOEnH+z5JQDjhF
   g==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643644800"; 
   d="scan'208";a="195789152"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 15:31:17 +0800
IronPort-SDR: D2iUfL0YSx1piSs4sKem8GPLKv5Ijd2P7QZ+5Q2GoLduzTlI1TRarkOcax8vAoAof7jv+PX25h
 p+mRxw7pxg6218iokexU7AXFKBvVmf5Wi+jtU9ER1sbuoEUOwBpET23d+Wq2z4eBW59ETxSW/H
 0fOt14MX3Gs/uSR9TabZUY4QeLKCeYYG/lK+G+m2PVk7LvzXoDREPx2gM1JFa9egFLcPFzETlO
 GbB8LqCxuoSgNUYzPzVLzMCnFBw0nebs8T2+o9CADMmUo07uiJTw4NHWDkbZ+tww3jetpNaGne
 5gsS1XeFnujhy8BNm+ZLSPlz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 23:02:32 -0800
IronPort-SDR: 015uOFKV4/RrK5Tuu33E35cd+0yUEhagFdLjQmZW2gqrLhV8tdm7xxxv+Wf9XKp60oZwRvTKQY
 fh2uD8towvRi4c5UScKefqqU/OgZ87glc8ixkn9GyXPLhUzuW/L4X62nFJ9L+52jFmjduK9pWg
 zPh4fm0k6bGzo8LYTtM6PKGnLfxLmWYBWTKBFC4REha6SxDjHX/O33koRbmnmT8VdkETl1UL6f
 RlieSrm16No+VBXYps/j4AfXqBVGeEK+Q2Wt9Agk9p3Pp0qF3QA2O82kDdpHIXCYzws2pDx045
 Eag=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 23:31:17 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KD3lm6LMrz1Rwrw
        for <linux-ide@vger.kernel.org>; Tue,  8 Mar 2022 23:31:16 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646811076; x=1649403077; bh=Z0K9EobAhTG23cdSoI4HeQz1FcdsM41KlEg
        vysVGDFM=; b=dUzh8tD9W4dkHikcHsMSr78nRssWI6qeX2rfujB7A1sxcD25EM7
        KSI2CxfDR7bo3r+JBtStLtUVJ5nV9aUwA+iQGtRejWPsIT+i8cIIOeQm0p8Op2hb
        x4TcRL2A62vH+79Qjl8ua28oYKN9eurXHuLUM4a8dF/WHO0Dd6oWrzvVIQaixN3m
        ZHDM8i/WdB+sjYCbwGUU4HqHKTnA3BRe1V22bdZ4Zm7PNV9K2x5mJJ1F1PGR0pEA
        2utloeJ9NYjm+55gH94f0fQeobOLu1QSwq8QAx/9wt42BUhKkccHCyAppJSYoNC2
        7s9RNKW/V9y1BaeRtWpywLJMa667LYVMwwg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2-W0CxJXYcR6 for <linux-ide@vger.kernel.org>;
        Tue,  8 Mar 2022 23:31:16 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KD3ll47HGz1Rvlx;
        Tue,  8 Mar 2022 23:31:15 -0800 (PST)
Message-ID: <4ce9ad67-7102-1ad8-2726-5e96aecfde80@opensource.wdc.com>
Date:   Wed, 9 Mar 2022 16:31:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3] ata: pata_pxa: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, s.shtylyov@omp.ru, zealci@zte.com.cn
References: <d1dfb244-eda3-b5c6-c6bd-c0294a9a4a94@opensource.wdc.com>
 <20220309072834.2081944-1-chi.minghao@zte.com.cn>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220309072834.2081944-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/9/22 16:28, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
> 
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq().
> 
> v1->v2:
>     - Use more specific in the subject: ata: pata_pxa:
>     - Switch to returning 'irq'
> v2->v3:
>     - drop the unlikely()

Looks good. FYI, the changelog above should be placed under the "---"
after your Signed-off-by so that it does not stay as part of the commit
message. No need to resend, I will remove this when applying.

Sergey,

Review OK ?

> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/ata/pata_pxa.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 41430f79663c..985f42c4fd70 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
> @@ -164,10 +164,10 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	struct resource *cmd_res;
>  	struct resource *ctl_res;
>  	struct resource *dma_res;
> -	struct resource *irq_res;
>  	struct pata_pxa_pdata *pdata = dev_get_platdata(&pdev->dev);
>  	struct dma_slave_config	config;
>  	int ret = 0;
> +	int irq;
>  
>  	/*
>  	 * Resource validation, three resources are needed:
> @@ -205,9 +205,9 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	/*
>  	 * IRQ pin
>  	 */
> -	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> -	if (unlikely(irq_res == NULL))
> -		return -EINVAL;
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
>  
>  	/*
>  	 * Allocate the host
> @@ -287,7 +287,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	/*
>  	 * Activate the ATA host
>  	 */
> -	ret = ata_host_activate(host, irq_res->start, ata_sff_interrupt,
> +	ret = ata_host_activate(host, irq, ata_sff_interrupt,
>  				pdata->irq_flags, &pxa_ata_sht);
>  	if (ret)
>  		dma_release_channel(data->dma_chan);


-- 
Damien Le Moal
Western Digital Research
