Return-Path: <SRS0=qgYx=3E=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24FFC33CB1
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jan 2020 13:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756E32073A
	for <linux-ide@archiver.kernel.org>; Wed, 15 Jan 2020 13:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nPDCiW+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgAONEN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:04:13 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60312 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgAONEM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 15 Jan 2020 08:04:12 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200115130410euoutp02ca0ef3827da53c902f205e3cbdd7d113~qESBwwB0Q1365513655euoutp02i
        for <linux-ide@vger.kernel.org>; Wed, 15 Jan 2020 13:04:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200115130410euoutp02ca0ef3827da53c902f205e3cbdd7d113~qESBwwB0Q1365513655euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579093450;
        bh=LoaTV2n5Eoqzvx6Gxu+M9H4pmHkxUC7eO0DHb88DkeA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nPDCiW+HBT7Ij4h/DNX8zWfOsLoCBPnM4ZHct70hMjnz11iJsnw7b2pX3sTkHEcWy
         JjAt4ymyfwqF3VLwp1OSMugyp53VeEEbBYcY9uZyv6bszLP+iVAj6i1+1kuwM1iojy
         4ATfjT/1b9i1/5tzAyXyHd6xIbcnuApfcUCJi1SU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200115130410eucas1p128522d8bb705e517b100358168660e6e~qESBp5Flr2849528495eucas1p1U;
        Wed, 15 Jan 2020 13:04:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 4E.6D.60698.ACD0F1E5; Wed, 15
        Jan 2020 13:04:10 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200115130409eucas1p251a4e356d21c6b3ea536aba33ea1a624~qESBHF3pT2361223612eucas1p25;
        Wed, 15 Jan 2020 13:04:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200115130409eusmtrp2c4a6c794f3b0899776adcb44da01b51d~qESBGT7cQ0534205342eusmtrp2z;
        Wed, 15 Jan 2020 13:04:09 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-6d-5e1f0dcaafd2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6A.8B.07950.9CD0F1E5; Wed, 15
        Jan 2020 13:04:09 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200115130408eusmtip2f0dc32512b4bf9aab813674c8435aad6~qESAboN8D2382323823eusmtip2P;
        Wed, 15 Jan 2020 13:04:08 +0000 (GMT)
Subject: Re: [PATCH v2] ata: pata_arasan_cf: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     vireshk@kernel.org, axboe@kernel.dk, vkoul@kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <c305572c-7412-f4c5-1599-668983000c8c@samsung.com>
Date:   Wed, 15 Jan 2020 14:04:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200113142747.15240-1-peter.ujfalusi@ti.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djPc7qneOXjDI485LBYfbefzeLYjkdM
        Fpd3zWGzmPXxB6vF5gfH2Cx23jnB7MDmcflsqcemVZ1sHsdvbGfy+LxJLoAlissmJTUnsyy1
        SN8ugSujb9ZDloK9vBVTrvYwNzB+4epi5OSQEDCRaF9/i7GLkYtDSGAFo0RvYw+U84VR4uip
        f2wQzmdGiZuNV9lhWn433WOFSCxnlJg4E6b/LaPEsT0/WUCqhAUyJV7N+ccIYosIaEncunYT
        yObgYBYokdiwxwMkzCZgJTGxfRVYCa+AncT8M7vBFrAIqEpcvPARLC4qECHx6cFhVogaQYmT
        M5+AjecUsJZ49WQ/E4jNLCAucevJfChbXmL72znMIPdICCxil/jxYhLYXgkBF4mJzfYQDwhL
        vDq+BeoZGYn/O0F6QerXMUr87XgB1bydUWL5ZJD/QaqsJe6c+8UG8YCmxPpd+hBhR4nVd1vY
        IObzSdx4KwhxA5/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZSD6bheSbWUi+mYWw
        dwEjyypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAZHP63/GvOxj3/Uk6xCjAwajEw5vx
        Ry5OiDWxrLgy9xCjBAezkgjvyRmycUK8KYmVValF+fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8s
        Sc1OTS1ILYLJMnFwSjUw8u0wT9hVtKD6vueMZ3ovtUxbtt5dI9WXnShS2noy/GnBpOZl5SGx
        H7vmSVzVddG/Lm2c99R1p2WabgFbaETwHB/dXbevRZTcXJbzb6bZxr5NTsyOAssrpyh+en3o
        rP7fuVI1BneW7y1bICndc6lf6kG5hn8//5tk94OSTZMcFpx/dXCm1pfFSizFGYmGWsxFxYkA
        AxPvvjIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsVy+t/xe7oneeXjDA42qFisvtvPZnFsxyMm
        i8u75rBZzPr4g9Vi84NjbBY775xgdmDzuHy21GPTqk42j+M3tjN5fN4kF8ASpWdTlF9akqqQ
        kV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfRN+shS8Fe3oopV3uY
        Gxi/cHUxcnJICJhI/G66x9rFyMUhJLCUUWJJ92K2LkYOoISMxPH1ZRA1whJ/rnWxQdS8ZpQ4
        +ecgC0hCWCBT4tWcf4wgtoiAlsStazfBbGaBEonlK2eC1QgJ9DFKzLxbBGKzCVhJTGxfBVbD
        K2AnMf/MbnYQm0VAVeLihY9gcVGBCInDO2ZB1QhKnJz5BGwOp4C1xKsn+5kg5qtL/Jl3iRnC
        Fpe49WQ+VFxeYvvbOcwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dL
        zs/dxAiMrm3Hfm7Zwdj1LvgQowAHoxIP74F/cnFCrIllxZW5hxglOJiVRHhPzpCNE+JNSays
        Si3Kjy8qzUktPsRoCvTcRGYp0eR8YOTnlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1O
        TS1ILYLpY+LglGpg1Eje829u2SEz1vAjjdUJx0Nf/k7KEU+7ofpk5bPrVwNsGIXiP762DDU4
        tLvmregpk4+sursVjFvWSMYJeFoXCz0Mb/g+5RTTBO/ZB4+9u79b9ebkeQcVFArcp4c+Ndyu
        +EKVky/p5J69YdsKnjy00qqX0AtYVxC97KGXYE/JESeGtcnGT+V2KbEUZyQaajEXFScCAMP9
        KiLEAgAA
X-CMS-MailID: 20200115130409eucas1p251a4e356d21c6b3ea536aba33ea1a624
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200113142721eucas1p2b925aa86ed9230da52d2f1652cf83db0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200113142721eucas1p2b925aa86ed9230da52d2f1652cf83db0
References: <CGME20200113142721eucas1p2b925aa86ed9230da52d2f1652cf83db0@eucas1p2.samsung.com>
        <20200113142747.15240-1-peter.ujfalusi@ti.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/13/20 3:27 PM, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> The dma_request_chan() is the standard API to request slave channel,
> clients should be moved away from the legacy API to allow us to retire
> them.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
> Hi,
> 
> Changes since v1:
> - Fixed type in subject
> - Removed reference to deferred probing in commit message
> 
> Regards,
> Peter
> 
>  drivers/ata/pata_arasan_cf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
> index 391dff0f25a2..e9cf31f38450 100644
> --- a/drivers/ata/pata_arasan_cf.c
> +++ b/drivers/ata/pata_arasan_cf.c
> @@ -526,9 +526,10 @@ static void data_xfer(struct work_struct *work)
>  
>  	/* request dma channels */
>  	/* dma_request_channel may sleep, so calling from process context */
> -	acdev->dma_chan = dma_request_slave_channel(acdev->host->dev, "data");
> -	if (!acdev->dma_chan) {
> +	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
> +	if (IS_ERR(acdev->dma_chan)) {
>  		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
> +		acdev->dma_chan = NULL;
>  		goto chan_request_fail;
>  	}
>  
> @@ -539,6 +540,7 @@ static void data_xfer(struct work_struct *work)
>  	}
>  
>  	dma_release_channel(acdev->dma_chan);
> +	acdev->dma_chan = NULL;
>  
>  	/* data xferred successfully */
>  	if (!ret) {
> 
