Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D9CC433FE
	for <linux-ide@archiver.kernel.org>; Sat, 12 Nov 2022 02:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiKLCLS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 11 Nov 2022 21:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiKLCLR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 11 Nov 2022 21:11:17 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DB91D0F9
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 18:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668219076; x=1699755076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tVnzCIB/D4Hs8hr4UQqxx65RGUiscS9RdxgdHub7Ww8=;
  b=UpJ8Chr/kwqFqV9F+7ekOMNqC9Da9en8kPMmCdwypvcrmMCjXciCH0ZG
   66iviJvuS+CRY0hhXZdAbUFsnUu9qyBXzmOLudi0Gzf+nA3tICYktzsxH
   VEF1DQ8ks2TYldQ7Mx7F4D7fAjBByV997H3G3GIBvNZlA3ytawxrkSZW+
   ZF7yZu1vCQPrJuYjbQAxR+lYqjCSmUFqw6xzocrMR9Rn5Z0/XiVUIDM+n
   S8ZGr49ufxOG/A9NnUT9SYxhoHXJHKIsyL9kS6EVBMx+XCfIYPtf2Y6jc
   RZjopzKtWKkXwOPP/JRvwZavaOWLwcAwgn5N2Xjaqp2c0M6QSq14zwGMr
   g==;
X-IronPort-AV: E=Sophos;i="5.96,158,1665417600"; 
   d="scan'208";a="328193772"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2022 10:11:15 +0800
IronPort-SDR: NHUyoissaXHFHidgENgVwWGcrYexHjdpUm31y1lNgMtxHSHRJZC0Tao8mYyruyj/UmtWEkG0cK
 inkr3NfZxPeJvDPYGV3hLBikpif4Jd+QOxwpgHsdvTyoi9TaEpWzXJxYLb88csPV8Pt42Ph488
 NzYVUNH2DiZkk9zAfF+sqvH4FQR6T2LpY1OY38exg5+AUQGKS5k0vGZwL2kMTPU2cgEUDiB/GH
 FudHKM5egftS6DXNe8V0OgdcBGuEbZnWDBJJw2YdWZX8EMaXKBNtCt4I7Waz29aPNfooPNTBVr
 NJs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 17:30:17 -0800
IronPort-SDR: F/WENt3NYOMo1X1r7lw+7RenNGgSYd3SNeGuHZxFY6cR6I/CF+xH9pDkopz9DuxoG95Y03n9IF
 lOuxaOZFmLQKLeu9LXg4cE5VrKFizIWS6Q4UsC8NHXEfjYZMPByrdaSBOauhpjF1ZwDj3tGWk5
 1BawB+zTKwXmszi8aIuKQQws2yGeosaXHAU9iwC2x7WMhTfL/sPDC1eCfCJ4EJv0G5URuoFHau
 SyWDWygWiwYcPyBC0m7/3GCO3M8CZ92sQ7+fMv4DwvGggPB0fP7GiY+2nC9otxRAMtRDgRqX4T
 7uU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2022 18:11:16 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N8Jw33Cqfz1RvTp
        for <linux-ide@vger.kernel.org>; Fri, 11 Nov 2022 18:11:15 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668219074; x=1670811075; bh=tVnzCIB/D4Hs8hr4UQqxx65RGUiscS9Rdxg
        dHub7Ww8=; b=lrwVaEUeAZSAaKpdTNpkJ3GE/AIl4RokhhuiCRbPybEbVCg7uLB
        misKBM+ilt66cPBhlqgfv/tNfBKRMOyVBumzP6ysKAdhy49wumXz54ndevqziFc6
        ayVbjfi7VXVjI/f/lWMNdLISXoL2Zvt9YTByqxjG1BeaGL1jfXqgeD+D5ooxg234
        e796zoEswOQIf+rqWGPsKpEN4h8hZ6gMu+Xpqu85KQoaechNDi9G2lC8x9QK79gX
        5QITXevD/z9ZqajV1GnyphPY29gP2tva5xVo4caPH/AGk4KN8q29aLgaGSzM9q4f
        c85YxWjLVwusf37cznL9rgzP34Jj8pS6VBA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dchNksm3lRst for <linux-ide@vger.kernel.org>;
        Fri, 11 Nov 2022 18:11:14 -0800 (PST)
Received: from [10.225.163.43] (unknown [10.225.163.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N8Jw22W0mz1RvLy;
        Fri, 11 Nov 2022 18:11:14 -0800 (PST)
Message-ID: <f46021a8-03f1-60ea-a783-5626272de2a6@opensource.wdc.com>
Date:   Sat, 12 Nov 2022 11:11:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] ata: sata_dwc_460ex: Check !irq instead of irq ==
 NO_IRQ
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
References: <146506d93c96b842422d31a90b5d23c98b70a111.1668155425.git.christophe.leroy@csgroup.eu>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <146506d93c96b842422d31a90b5d23c98b70a111.1668155425.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 11/11/22 17:30, Christophe Leroy wrote:
> NO_IRQ is a relic from the old days. It is not used anymore in core
> functions. By the way, function irq_of_parse_and_map() returns value 0
> on error.
> 
> In some drivers, NO_IRQ is erroneously used to check the return of
> irq_of_parse_and_map().
> 
> It is not a real bug today because the only architectures using the
> drivers being fixed by this patch define NO_IRQ as 0, but there are
> architectures which define NO_IRQ as -1. If one day those
> architectures start using the non fixed drivers, there will be a
> problem.
> 
> Long time ago Linus advocated for not using NO_IRQ, see
> https://lkml.org/lkml/2005/11/21/221 . He re-iterated the same view
> recently in https://lkml.org/lkml/2022/10/12/622
> 
> So test !irq instead of tesing irq == NO_IRQ.
> 
> And remove the fallback definition of NO_IRQ at the top of the file.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Applied to for-6.2. Thanks !

> ---
> v2: Also removed the #ifndef NO_IRQ #define NO_IRQ 0 at the top
> ---
>  drivers/ata/sata_dwc_460ex.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index e3263e961045..7b7e1516dbdd 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -42,10 +42,6 @@
>  #define sata_dwc_writel(a, v)	writel_relaxed(v, a)
>  #define sata_dwc_readl(a)	readl_relaxed(a)
>  
> -#ifndef NO_IRQ
> -#define NO_IRQ		0
> -#endif
> -
>  #define AHB_DMA_BRST_DFLT	64	/* 16 data items burst length */
>  
>  enum {
> @@ -242,7 +238,7 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
>  
>  	/* Get SATA DMA interrupt number */
>  	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
> -	if (hsdev->dma->irq == NO_IRQ) {
> +	if (!hsdev->dma->irq) {
>  		dev_err(dev, "no SATA DMA irq\n");
>  		return -ENODEV;
>  	}
> @@ -1180,7 +1176,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
>  
>  	/* Get SATA interrupt number */
>  	irq = irq_of_parse_and_map(np, 0);
> -	if (irq == NO_IRQ) {
> +	if (!irq) {
>  		dev_err(dev, "no SATA DMA irq\n");
>  		return -ENODEV;
>  	}

-- 
Damien Le Moal
Western Digital Research

