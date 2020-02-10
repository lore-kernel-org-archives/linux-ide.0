Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B86C3F68F
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E6F24671
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="P2EE9HI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgBJNnw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:43:52 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41422 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgBJNnw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:43:52 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210134351euoutp0199eb6c10d7b1a85547461c8aa95cde7a~yDmGKmk330527205272euoutp01e
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:43:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210134351euoutp0199eb6c10d7b1a85547461c8aa95cde7a~yDmGKmk330527205272euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581342231;
        bh=lUWW5pn7JgT5KmyQcLba25wrpEgcglEcDZzZf3y/+0s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=P2EE9HI945AhM1cfItl6hYnFLMZFsJnY1jJcAbB7ACXgUTvLKrk1qCS6i9HLZxqsk
         FDEXeNrAEct52TZ/M2gXlpIjMluooa61w8ATiEJHm7CtNhJJNi1EHJ3lLsEETvf72l
         toL76r5yEDXe0JD47k//DMjDRVGA8YjBai8Lt+gs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210134351eucas1p29f2e9df2a7005974bccf1dcc2a0e4475~yDmGBGKfV1569315693eucas1p2J;
        Mon, 10 Feb 2020 13:43:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D6.AD.61286.61E514E5; Mon, 10
        Feb 2020 13:43:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210134350eucas1p13e56cf485a747bbb21830dc62b81d544~yDmFcV4gk2361023610eucas1p1V;
        Mon, 10 Feb 2020 13:43:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210134350eusmtrp203e0225cd9a1ac79e1b984832b51e573~yDmFbqrlz2886428864eusmtrp2i;
        Mon, 10 Feb 2020 13:43:50 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-30-5e415e162819
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 35.5F.08375.61E514E5; Mon, 10
        Feb 2020 13:43:50 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210134350eusmtip2b7ca8745a04a829b8cc7b00680997fbd~yDmFEQGHL2916729167eusmtip2A;
        Mon, 10 Feb 2020 13:43:50 +0000 (GMT)
Subject: Re: [PATCH 15/46] ahci: drop DPRINTK() calls in reset
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <5455460c-74d3-f953-2a45-c1645d99279a@samsung.com>
Date:   Mon, 10 Feb 2020 14:43:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-16-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzneV3xOMc4g99WFqvv9rNZ7Fk0icni
        2I5HTA7MHpfPlnpsPl3t8XmTXABzFJdNSmpOZllqkb5dAlfGvIsr2Ase8VSs79vN2MA4mauL
        kZNDQsBE4teZi6xdjFwcQgIrGCU2nrzPDOF8YZSY27GdHcL5zCjRuHULO0zL/WUHWCASyxkl
        dvZ9gap6yyixbksrE0iVsICdxOLu62AdIgJKEh/bD4HZzALWErMXrwerYROwkpjYvooRxOYF
        qv/wvJMVxGYRUJXY27wQrEZUIELi04PDrBA1ghInZz5hAbE5ga748bGZGWKmuMStJ/OZIGx5
        ie1v54D9ICHwn03ixoofUGe7SCzctpsRwhaWeHUc5h0Zif87QZpBGtYxSvzteAHVvZ1RYvnk
        f2wQVdYSd879ArI5gFZoSqzfpQ9iSgg4SjTuEIEw+SRuvBWEuIFPYtK26cwQYV6JjjYhiBlq
        EhuWbWCD2dq1cyXzBEalWUg+m4Xkm1lIvpmFsHYBI8sqRvHU0uLc9NRiw7zUcr3ixNzi0rx0
        veT83E2MwBRy+t/xTzsYv15KOsQowMGoxMNbEegYJ8SaWFZcmXuIUYKDWUmE11IaKMSbklhZ
        lVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAOjxi2Njelhh90v3TT1
        jFeIczUPfXVTWjrcvPnrhsUB4sJ6/St5zj40z390iz1CJu3bvUPFU9ccsT0rJeYw03nzf6Mv
        L698Ud9RW2666MGGtebfjWzd5+Qy7dRnmPZwr71twJppb/Wku62k8i9tq7XPvaT4pv8qS9fX
        GT2iiZfeqPxnWj/v+e/3SizFGYmGWsxFxYkAO4O1ER0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xe7picY5xBmdXiFmsvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6GfMurmAveMRTsb5vN2MD42SuLkZODgkBE4n7yw6wdDFycQgJ
        LGWU+H/8CmsXIwdQQkbi+PoyiBphiT/Xutggal4zSvQ37mUGSQgL2Eks7r7ODmKLCChJfGw/
        BGYzC1hLzF68ngmiYQOjxOueNjaQBJuAlcTE9lWMIDYvUPOH552sIDaLgKrE3uaFTCC2qECE
        xOEds6BqBCVOznzCAmJzAl3642MzM8QCdYk/8y5B2eISt57MZ4Kw5SW2v53DPIFRaBaS9llI
        WmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwKjZduzn5h2MlzYGH2IU4GBU
        4uGtCHSME2JNLCuuzD3EKMHBrCTCaykNFOJNSaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YETn
        lcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgTN1nl5X5+c5VKckL
        GpsiG/M3vCyqrEhjtosRN26S9vQ1LFlwzvqRXVYtu8quvsd1qetWbOxX5Zh77Fvobh6XcPF+
        i4esNcrnX5vKP1gT+GmviO/md7w/9hcU1c6TP7FB5NWRtwxciUmtHpbJu5v5M1f92vi/LG7p
        /Bt8K7PK+f0Dbv38WGWoxFKckWioxVxUnAgAC7tufbACAAA=
X-CMS-MailID: 20200210134350eucas1p13e56cf485a747bbb21830dc62b81d544
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165615eucas1p1acfee666d9c3b328de79d3834e4845f5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165615eucas1p1acfee666d9c3b328de79d3834e4845f5
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165615eucas1p1acfee666d9c3b328de79d3834e4845f5@eucas1p1.samsung.com>
        <20200204165547.115220-16-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Reset is now logged with tracepoints, so the DPRINTK() calls can
> be dropped.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/ahci.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 4f628e33f52e..56066cb4506f 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -683,8 +683,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
>  	bool online;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	hpriv->stop_engine(ap);
>  
>  	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
> @@ -692,8 +690,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
>  
>  	hpriv->start_engine(ap);
>  
> -	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
> -
>  	/* vt8251 doesn't clear BSY on signature FIS reception,
>  	 * request follow-up softreset.
>  	 */
> @@ -773,8 +769,6 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
>  	bool online;
>  	int rc, i;
>  
> -	DPRINTK("ENTER\n");
> -
>  	hpriv->stop_engine(ap);
>  
>  	for (i = 0; i < 2; i++) {
> @@ -812,7 +806,6 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
>  	if (online)
>  		*class = ahci_dev_classify(ap);
>  
> -	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
>  	return rc;
>  }
>  
