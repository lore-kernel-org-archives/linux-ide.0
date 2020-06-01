Return-Path: <SRS0=gVoV=7O=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3F5C433DF
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jun 2020 10:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D45206A4
	for <linux-ide@archiver.kernel.org>; Mon,  1 Jun 2020 10:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mv9J7U/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgFAKN0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:13:26 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43315 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFAKN0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jun 2020 06:13:26 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200601101324euoutp020d9967466f2855c7cb25794e0e6cd952~UY_U83a5u3021830218euoutp028
        for <linux-ide@vger.kernel.org>; Mon,  1 Jun 2020 10:13:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200601101324euoutp020d9967466f2855c7cb25794e0e6cd952~UY_U83a5u3021830218euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591006404;
        bh=OHPpvFiZE34wyuaajTiViUqmeZXVmXg2EsQc6ds9wOQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mv9J7U/d73ZUz19tReRboQNpB/izF7iF9yw4kTGhXwdzUCvgYQtNAVGmLkG/Lj8/d
         EL25ZRDfA4uwGOESzba2VOxCvIBUHbLmdy2cKAIpPJ+PLIyMEhozreU59VWUSM3w8B
         G+p/9ZdH2xPPdjkocXWeoijkTQooIENhGPfoQZgQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200601101324eucas1p2ae7ab4c7b9378ec6e04f1f7a3359a371~UY_U1BqEt2675526755eucas1p27;
        Mon,  1 Jun 2020 10:13:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 02.80.60698.4C4D4DE5; Mon,  1
        Jun 2020 11:13:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601101324eucas1p16837835ff355d5b42c8099c29270722d~UY_UhvFxF2001920019eucas1p1J;
        Mon,  1 Jun 2020 10:13:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200601101324eusmtrp263c67fd0180586027f1ce6e6b16fc016~UY_UhLpRQ2432024320eusmtrp2K;
        Mon,  1 Jun 2020 10:13:24 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-e2-5ed4d4c44590
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 31.51.07950.4C4D4DE5; Mon,  1
        Jun 2020 11:13:24 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200601101323eusmtip182101ceb7f0eb212baafb1a6e4a21fe5~UY_UN6HOb1231112311eusmtip1d;
        Mon,  1 Jun 2020 10:13:23 +0000 (GMT)
Subject: Re: [PATCH] ata: omit superfluous error message
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <7c2974bd-5aa5-b423-ebb4-2fdf8a41f6ca@samsung.com>
Date:   Mon, 1 Jun 2020 12:13:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200420135342.11984-1-tangbin@cmss.chinamobile.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87pHrlyJM/jWI26x+m4/m8WxHY+Y
        LC7vmsNm8fF/M7MDi8f56b1sHpfPlnp83iQXwBzFZZOSmpNZllqkb5fAlfG2Zw1TwQW+iqXX
        ZjI2ML7m7mLk5JAQMJG483EBexcjF4eQwApGiXezzrJCOF8YJfa92sUM4XxmlFi3bAMLTMvV
        5nNQieWMEocfTmKCcN4ySjxYPpUNpEpYwELiwcPZzCC2iIC2xOZJEN3MAj4SJ+Z3M4LYbAJW
        EhPbV4HZvAJ2EtcvbgWrYRFQkfi9rZsJxBYViJD49OAwK0SNoMTJmU/AajgFnCROTN3FDjFT
        XOLWk/lMELa8xPa3c8CukxDoZpdo2f2AEeJsF4kbnZOgXhCWeHV8CzuELSPxf+d8JoiGdYwS
        fzteQHVvZ5RYPvkfG0SVtcSdc7+AbA6gFZoS63fpQ4QdJX7PWMoKEpYQ4JO48VYQ4gg+iUnb
        pjNDhHklOtqEIKrVJDYs28AGs7Zr50rmCYxKs5C8NgvJO7OQvDMLYe8CRpZVjOKppcW56anF
        xnmp5XrFibnFpXnpesn5uZsYgSnl9L/jX3cw7vuTdIhRgINRiYdX49LlOCHWxLLiytxDjBIc
        zEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnV
        wGgjEJ6xOy/06qsLxzL7z7WsEdu88/xxGaZkw/6b/S/cl06aaqC1e8aftBccO5m+JJkFaWhL
        zUiYHf1o8tE7ccL26z6q/zn64GnmhMAJm9qZShgEz7JaLervfSb53uUV29UdksfE93/vVJar
        9F94t3Dr/rjvHuvmOi1k37p8/kT+1/K/s7kWRxUrsRRnJBpqMRcVJwIAPqV8sCUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7pHrlyJM3i1ksVi9d1+NotjOx4x
        WVzeNYfN4uP/ZmYHFo/z03vZPC6fLfX4vEkugDlKz6Yov7QkVSEjv7jEVina0MJIz9DSQs/I
        xFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Ntzxqmggt8FUuvzWRsYHzN3cXIySEhYCJxtfkc
        cxcjF4eQwFJGiUUzfwA5HEAJGYnj68sgaoQl/lzrYoOoec0o8WLfFVaQhLCAhcSDh7OZQWwR
        AW2JzZM2sIDYzAI+EifmdzNCNExllFh36hNYA5uAlcTE9lWMIDavgJ3E9YtbwRpYBFQkfm/r
        ZgKxRQUiJA7vmAVVIyhxcuYTsBpOASeJE1N3sUMsUJf4M+8SM4QtLnHryXwmCFteYvvbOcwT
        GIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMoG3Hfm7Zwdj1
        LvgQowAHoxIP74Xzl+OEWBPLiitzDzFKcDArifA6nT0dJ8SbklhZlVqUH19UmpNafIjRFOi5
        icxSosn5wOjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAyH55
        WfWrOS+tni1uCl8QscjiYerrzslFyyJDJml+nfkn7dS3m8FNRxN/imqc7dCJLrLuUgycsPDa
        BJv6d2JbHXWDX2w57vIm88PWqRan175SenhZj9v+MLd44tOIXR2fqwUCtUJaTFpfvwl72BWU
        8yJ2WdKBqT9Vvxie0OreaBtleOiO6CvGuUosxRmJhlrMRcWJAGmP0wG2AgAA
X-CMS-MailID: 20200601101324eucas1p16837835ff355d5b42c8099c29270722d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200420135215eucas1p2f807c43a232564804dc864db55bd09a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200420135215eucas1p2f807c43a232564804dc864db55bd09a8
References: <CGME20200420135215eucas1p2f807c43a232564804dc864db55bd09a8@eucas1p2.samsung.com>
        <20200420135342.11984-1-tangbin@cmss.chinamobile.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Hi,

On 4/20/20 3:53 PM, Tang Bin wrote:
> In the probe function, when get irq failed, the function
> platform_get_irq() logs an error message, so remove
> redundant message here.

platform_get_irq() doesn't log an error message for -EPROBE_DEFER
case so the conversion shouldn't be done automatically for device
drivers which don't support deferred probing (i.e. pata_rb532_cf &
sata_highbank).

Unless there is a proof that -PROBE_DEFER can't happen for these
two drivers this patch shouldn't be applied.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/ata/pata_rb532_cf.c | 4 +---
>  drivers/ata/sata_highbank.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
> index 479c4b29b..dcde84f57 100644
> --- a/drivers/ata/pata_rb532_cf.c
> +++ b/drivers/ata/pata_rb532_cf.c
> @@ -115,10 +115,8 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		dev_err(&pdev->dev, "no IRQ resource found\n");
> +	if (irq <= 0)
>  		return -ENOENT;
> -	}
>  
>  	gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_IN);
>  	if (IS_ERR(gpiod)) {
> diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
> index ad3893c62..efd1925a9 100644
> --- a/drivers/ata/sata_highbank.c
> +++ b/drivers/ata/sata_highbank.c
> @@ -469,10 +469,8 @@ static int ahci_highbank_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		dev_err(dev, "no irq\n");
> +	if (irq <= 0)
>  		return -EINVAL;
> -	}
>  
>  	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
>  	if (!hpriv) {
> 

