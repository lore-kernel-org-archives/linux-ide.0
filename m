Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4D0C3B186
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0670E2465D
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pCYB5ND7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgBJN1i (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:27:38 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57345 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgBJMgc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 07:36:32 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210123631euoutp027a3d8b3cb25e1162a59afc095d4c3b90~yCrT7R18d2571325713euoutp02s
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 12:36:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210123631euoutp027a3d8b3cb25e1162a59afc095d4c3b90~yCrT7R18d2571325713euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581338191;
        bh=TT5pMZ/oqc1r+k1Lei6+zs7A/MFFHCvBhH6YGVmI2VE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pCYB5ND7lZvnE8ZYExyhk89a/SHV9dWySUpZy/pn+defAco9nUMecvrwDbY5Qjw6Z
         j/sw3FhnM9O7/Bx57BKMxntOI00WPqLikONZxZMdnrRojVeVpmVY/Nbq/gwITZLKZq
         FOq7ubkZ6bYHDXpZt/njc2ELcIiLEdY7IbdayGZo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210123631eucas1p18ee892b7e3501033c083e7811f91c0c8~yCrTZfG000879408794eucas1p1s;
        Mon, 10 Feb 2020 12:36:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 03.42.61286.E4E414E5; Mon, 10
        Feb 2020 12:36:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210123630eucas1p191203c7456132e7e5d3b6889dbaf5f01~yCrTJSl152606326063eucas1p1p;
        Mon, 10 Feb 2020 12:36:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210123630eusmtrp2573b10cc81ea49afd7584858ff452fb0~yCrTIv4BR2485824858eusmtrp2B;
        Mon, 10 Feb 2020 12:36:30 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-5b-5e414e4e2614
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 40.F4.08375.E4E414E5; Mon, 10
        Feb 2020 12:36:30 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210123630eusmtip21fa834a28cf5fdfd51d1461bf880a00a~yCrSzJSCg2037920379eusmtip2Q;
        Mon, 10 Feb 2020 12:36:30 +0000 (GMT)
Subject: Re: [PATCH 06/46] ata_piix: remove debugging message in piix_init()
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <616a0374-32ca-3993-6bd9-82277f890e7d@samsung.com>
Date:   Mon, 10 Feb 2020 13:36:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-7-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87p+fo5xBheabCxW3+1ns1jwZi+b
        xZ5Fk5gsju14xOTA4nH5bKnH+i1XWTw2n672+LxJLoAlissmJTUnsyy1SN8ugSvjQusmtoKb
        bBULNk5kbmBcw9rFyMkhIWAisfF5EwuILSSwglFi+7zkLkYuIPsLo8Sam70sEM5nRon3Ww6x
        dzFygHUc3qMGEV/OKLHry3mooreMEocPfWYDGSUs4CNxvH8emC0ioCTxsR2kmZODWSBOounK
        XTCbTcBKYmL7KkYQm1fATuLXr1YmEJtFQFVi5452MFtUIELi04PDrBA1ghInZz4BO5VTwFji
        15fLUDPFJW49mc8EYctLbH87hxnkIAmBfnaJ+X2ToP50kTh1ZyoThC0s8er4FnYIW0bi/06Q
        ZpCGdYwSfzteQHVvZ5RYPvkfG0SVtcSdc7/YQP5nFtCUWL9LHyLsKHH1/CJWSLDwSdx4Kwhx
        BJ/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZSF6bheSdWUjemYWwdwEjyypG8dTS
        4tz01GLDvNRyveLE3OLSvHS95PzcTYzAtHL63/FPOxi/Xko6xCjAwajEw+tg7xAnxJpYVlyZ
        e4hRgoNZSYTXUtoxTog3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZ
        Jg5OqQbGpOorwnukfZQs7lsszHZLe71OssLywJep/Q13mat/8zYK9H35wPnzvtSb5ZmFAsIf
        j14+eFl9g+UurdIdMx9eWm2yqds2OXnqtnXbAnv0muxnZSzc0nOCY+qiD/Psy5f4LJhxMI4t
        Xl4y61vSX43Dl36YcF1/c4HhxV8NmwitK+GzeOz7T504pcRSnJFoqMVcVJwIAF8YQ+cnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7p+fo5xBp/2qVmsvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GhdZNbAU32SoWbJzI3MC4hrWLkYNDQsBE
        4vAetS5GLg4hgaWMEnvf/YOKy0gcX1/WxcgJZApL/LnWxQZR85pRouXtTSaQhLCAj8Tx/nls
        ILaIgJLEx/ZD7CA2s0CcxL++3WA1QgLrGSVunAOz2QSsJCa2r2IEsXkF7CR+/WoFi7MIqErs
        3NEOZosKREgc3jELqkZQ4uTMJywgNqeAscSvL5eh5qtL/Jl3iRnCFpe49WQ+E4QtL7H97Rzm
        CYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIERtG2Yz8372C8
        tDH4EKMAB6MSD6+DvUOcEGtiWXFl7iFGCQ5mJRFeS2nHOCHelMTKqtSi/Pii0pzU4kOMpkDP
        TWSWEk3OB0Z4Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxvZJ
        xiuXV8Ruv3q0piT5rODeaV95rV8datl9/Y+faemW1FevTSJbsnxizx62+39ps7BW0aOerd/s
        4991TVjwwNpna8bPnxv5cp26ngsarEwy44z60Zrsctxr+abZZV57ahclbz890/3UkW/3V7VX
        mq9Tc74Y52GuFHraJHhT5wahqE3fr9n+6FJiKc5INNRiLipOBADZkg6guAIAAA==
X-CMS-MailID: 20200210123630eucas1p191203c7456132e7e5d3b6889dbaf5f01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165612eucas1p1126d505b54388d84c35eda28bac8f2c7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165612eucas1p1126d505b54388d84c35eda28bac8f2c7
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165612eucas1p1126d505b54388d84c35eda28bac8f2c7@eucas1p1.samsung.com>
        <20200204165547.115220-7-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Drop pointless debugging message in piix_init()
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/ata_piix.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
> index 3ca7720e7d8f..f940ecf72aaa 100644
> --- a/drivers/ata/ata_piix.c
> +++ b/drivers/ata/ata_piix.c
> @@ -1767,14 +1767,12 @@ static int __init piix_init(void)
>  {
>  	int rc;
>  
> -	DPRINTK("pci_register_driver\n");
>  	rc = pci_register_driver(&piix_pci_driver);
>  	if (rc)
>  		return rc;
>  
>  	in_module_init = 0;
>  
> -	DPRINTK("done\n");
>  	return 0;
>  }
>  
