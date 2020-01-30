Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB05C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFE2206D3
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VbSA5KZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgA3KuR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:50:17 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43354 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KuR (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:50:17 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130105015euoutp027b7bbc1d2278caffdb9b5d1a12d9acf5~upIYqbf5h3039230392euoutp02N
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:50:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130105015euoutp027b7bbc1d2278caffdb9b5d1a12d9acf5~upIYqbf5h3039230392euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580381415;
        bh=OO9Dnbg63b24GAi5HgKfSaaaDiJvlqSX+fPvk5KcpNo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VbSA5KZaqjqXY5R6pydCrXIASxZKQk1jlfcRPPALoFfhMtilYncZ9K3yW5I0efje9
         WNYoRjFPxfpvIkj+G+yivOXLQybSdUj5LhNz2fhfsWQ3mE2httkmcV2tN5Ed8NxX20
         7BxjcjA0r80sO3rh/kZylYFbsd0bhla88DTTfHl0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130105015eucas1p1d3084e924018021e5a0bca79e19f7a76~upIYguCy21412814128eucas1p1Q;
        Thu, 30 Jan 2020 10:50:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 88.C9.60698.7E4B23E5; Thu, 30
        Jan 2020 10:50:15 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130105014eucas1p12df3e90cb875914fd0c01d1cabd2666d~upIYHKJ9V1416014160eucas1p1T;
        Thu, 30 Jan 2020 10:50:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130105014eusmtrp22055dfa96abac4f5af68f7934b68465d~upIYGmJ9B2187221872eusmtrp27;
        Thu, 30 Jan 2020 10:50:14 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-a0-5e32b4e7e24f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A1.0E.07950.6E4B23E5; Thu, 30
        Jan 2020 10:50:14 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200130105014eusmtip23d58bc8bb4a44e2c0c73a99d7041d177~upIXy7vPZ0788107881eusmtip2M;
        Thu, 30 Jan 2020 10:50:14 +0000 (GMT)
Subject: Re: [PATCH 08/24] ahci: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a4d752c6-ab6d-725d-c21f-5ce74e02a451@samsung.com>
Date:   Thu, 30 Jan 2020 11:50:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-20-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7rPtxjFGXx9wWmx+m4/m8WCN3vZ
        LPYsmsRkcWzHIyYHFo/LZ0s91m+5yuKx+XS1x+dNcgEsUVw2Kak5mWWpRfp2CVwZ/U0LWQu2
        8Vb8e7aEsYHxMVcXIyeHhICJxPamvUwgtpDACkaJlmuyXYxcQPYXRonvJ+8yQTifGSXetz5h
        hemYuuc5VMdyRomObl+IoreMEtcbP7CDJIQF7CS+XprJDGKLCChJfGw/BBZnFoiTaLpyF8xm
        E7CSmNi+ihHE5gWqP/fmHVicRUBVonvPDbAFogIREp8eHGaFqBGUODnzCQuIzSlgLLF7+Qtm
        iJniEreezGeCsOUltr+dwwxykIRAP7tEz7+3LBBXu0j8+NTPBmELS7w6voUdwpaR+L9zPhNE
        wzpGib8dL6C6tzNKLJ/8D6rDWuLOuV9ANgfQCk2J9bv0IcKOEm/W9bGChCUE+CRuvBWEOIJP
        YtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auZJ5AqPSLCSvzULyziwk78xC2LuAkWUVo3hqaXFu
        emqxcV5quV5xYm5xaV66XnJ+7iZGYFo5/e/41x2M+/4kHWIU4GBU4uHV2GAUJ8SaWFZcmXuI
        UYKDWUmEV9TVME6INyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYO
        TqkGxlymXTuWxP/w3Cvll7Qt//uV94GGpVbL+D46Mm3pKDywavJF2xcO8a/8g4rV1a71XPzn
        rzF34hLt3DdL5mjz91qxWvpZNHran7z79lqOufvfM2Zhx+5UJalv4Kh8mJe84XDFnpZ50fvD
        Jp1pXLvwl/aLvbfFeTTi50xpuuV58vRaXtVQ/oKCNCWW4oxEQy3mouJEADEa3bInAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7rPthjFGXzo1bVYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M/qaFrAXbeCv+PVvC2MD4mKuLkZNDQsBE
        Yuqe50xdjFwcQgJLGSW2/n7B1sXIAZSQkTi+vgyiRljiz7UuNoia14wS/7pWMYMkhAXsJL5e
        mglmiwgoSXxsP8QOYjMLxEn869sNNXQdo8Tu3ZNZQRJsAlYSE9tXMYLYvEDN5968A2tgEVCV
        6N5zgwnEFhWIkDi8YxZUjaDEyZlPWEBsTgFjid3LXzBDLFCX+DPvEpQtLnHryXwmCFteYvvb
        OcwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMpG3Hfm7Z
        wdj1LvgQowAHoxIPr8YGozgh1sSy4srcQ4wSHMxKIryiroZxQrwpiZVVqUX58UWlOanFhxhN
        gZ6byCwlmpwPjPK8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2M
        hw/a77ff2xTrMS/mz/2brTxF0Yy9wRrzX5lHecR/zPhgp2Igdue07YQa3t4SJu7FAaH2Ta8E
        6psL5NaL/vZaaqyb/dv/94Xjf+dc19/yoPKU/SfxeAXmSRLX69cYftvWXNd9yeVWQGOz3fJ/
        Vo9/s3mxf1CbeFgg58yKSWfX+oTMffTQMEdciaU4I9FQi7moOBEAAhvUU7oCAAA=
X-CMS-MailID: 20200130105014eucas1p12df3e90cb875914fd0c01d1cabd2666d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104745epcas2p20c8dc2116482a250d09928fac8cea709
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104745epcas2p20c8dc2116482a250d09928fac8cea709
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104745epcas2p20c8dc2116482a250d09928fac8cea709@epcas2p2.samsung.com>
        <20181213104716.31930-20-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/ahci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 021ce46e2e57..89d9980f3de4 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -698,7 +698,7 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
>  	bool online;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> +	ata_link_dbg(link, "ENTER\n");

Please preserve __func__ printing in the conversion.

>  	hpriv->stop_engine(ap);
>  
> @@ -707,7 +707,7 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
>  
>  	hpriv->start_engine(ap);
>  
> -	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
> +	ata_link_dbg(link, "EXIT, rc=%d, class=%u\n", rc, *class);

ditto

>  	/* vt8251 doesn't clear BSY on signature FIS reception,
>  	 * request follow-up softreset.
> @@ -788,7 +788,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
>  	bool online;
>  	int rc, i;
>  
> -	DPRINTK("ENTER\n");
> +	ata_link_dbg(link, "ENTER\n");

ditto

>  	hpriv->stop_engine(ap);
>  
> @@ -828,7 +828,7 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
>  	if (online)
>  		*class = ahci_dev_classify(ap);
>  
> -	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
> +	ata_link_dbg(link, "EXIT, rc=%d, class=%u\n", rc, *class);

ditto

>  	return rc;
>  }

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
