Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5217AC33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0640D206D3
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uW+l5Ibz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgA3KrX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:47:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:49942 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KrX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:47:23 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200130104722euoutp0180999f4880fd3123661bbb99a2c10b8d~upF3YORqJ3016730167euoutp01C
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:47:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200130104722euoutp0180999f4880fd3123661bbb99a2c10b8d~upF3YORqJ3016730167euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580381242;
        bh=8aZ7/5zIHdUeV5a9bCM+rtgEKM7Vz+3QqnYJLAlNYNw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uW+l5IbzNOICniOy1W7hMn/THNr+MesMobIMRJUgamo/lsZ57Q4ELv+5IM5Bs9JsF
         gYjhcdXbA+BHeS+D7cUloYAur7hCZXG7BJCDf6UtvttvPWLZo1d1fFBvPEFAidfxUy
         0CbtfgpHkm3R4N7iE+gi2cbaXDODcXR2rydIbm+I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130104722eucas1p28a9a40d5a863bf161df22404ec5ddce7~upF3SN6r_2620326203eucas1p2B;
        Thu, 30 Jan 2020 10:47:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 17.98.61286.A34B23E5; Thu, 30
        Jan 2020 10:47:22 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130104721eucas1p1303e51d76869af6045589816e3ac9675~upF3EAs7n3082530825eucas1p1v;
        Thu, 30 Jan 2020 10:47:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200130104721eusmtrp1bdc3cb856a49e32e231235eba85d9871~upF3DdFY91005410054eusmtrp1A;
        Thu, 30 Jan 2020 10:47:21 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-75-5e32b43a136e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.9D.07950.934B23E5; Thu, 30
        Jan 2020 10:47:21 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200130104721eusmtip2f2efdb11518912b8c2648e20b55a8768~upF2qXlEJ0419804198eusmtip2k;
        Thu, 30 Jan 2020 10:47:21 +0000 (GMT)
Subject: Re: [PATCH 04/24] sata_sil24: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <97ec3ca3-9dbe-ae71-ec67-cf567fdc50b5@samsung.com>
Date:   Thu, 30 Jan 2020 11:47:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-16-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87pWW4ziDF7PZrFYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6Ma/1nmQtW
        c1ZMPfyXuYHxJHsXIyeHhICJxIeZz5i6GLk4hARWMEosXXSLEcL5wiixaPNzqMxnoEzHHCaY
        lvb+Xqiq5YwScz8eZINw3jJKrDpzCqxKWMBFYtnkm2wgtoiAksTH9kNgC5kF4iSartwFs9kE
        rCQmtq9iBLF5Bewkjl04wgJiswioSuxc3McKYosKREh8enCYFaJGUOLkzCdgNZwCxhKTD2xk
        hZgpLnHryXwmCFteYvvbOcwgB0kI9LNLPNu9mAXibKCDjn6HekFY4tXxLdAQkJE4PbmHBaJh
        HaPE344XUN3bGSWWT/7HBlFlLXHn3C8gmwNohabE+l36IKaEgKPEsYO2ECafxI23ghA38ElM
        2jadGSLMK9HRJgQxQ01iw7INbDBbu3auZJ7AqDQLyWezkHwzC8k3sxDWLmBkWcUonlpanJue
        WmyYl1quV5yYW1yal66XnJ+7iRGYWE7/O/5pB+PXS0mHGAU4GJV4eDU2GMUJsSaWFVfmHmKU
        4GBWEuEVdTWME+JNSaysSi3Kjy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNT
        qoFR6PyPL4Wfnd7OvXzx5l/O5yy3hO56t1ZerwsrnmGm8rA64lMj66uGIy5azIlOu2p+z905
        +/mmlW/eKJvPvhX91fgDx8Gglzcn205znGmY+UlF2HKWeE6QvE6Jx4vfOgtjOI2bLVoZD7Gv
        0TocKbGJ5flRwclCi6OZroe/OVD/tbyIezV/SQu/EktxRqKhFnNRcSIAxEo/zCgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7qWW4ziDI4fNrRYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Ma/1nmQtWc1ZMPfyXuYHxJHsXIyeHhICJ
        RHt/L2MXIxeHkMBSRonDJyYBORxACRmJ4+vLIGqEJf5c62KDqHnNKLFk6hywZmEBF4llk2+y
        gdgiAkoSH9sPgcWZBeIk/vXtZoJoWMco0Tv5MCtIgk3ASmJi+ypGEJtXwE7i2IUjLCA2i4Cq
        xM7FfWA1ogIREod3zIKqEZQ4OfMJWA2ngLHE5AMbWSEWqEv8mXeJGcIWl7j1ZD4ThC0vsf3t
        HOYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG0rZjP7fs
        YOx6F3yIUYCDUYmHV2ODUZwQa2JZcWXuIUYJDmYlEV5RV8M4Id6UxMqq1KL8+KLSnNTiQ4ym
        QM9NZJYSTc4HRnleSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbG
        cHGL3/o5GxsPVr6/OW1ukZ2E6qoPbep38lS+ufj4/Nl35MFjp/nZYhn+E5rnLlaet4tzdq+A
        c/jBb98drZa0Xerp0hTfFWm0UOTkmbAOe/NE/UJ3Ft9n4ntDvnyqj172X3e/4rIi2b9Mmja1
        T8QCtaYf0VKVXXwm7t2r7zPcVvgYiISfYr6uxFKckWioxVxUnAgA2N0HNLoCAAA=
X-CMS-MailID: 20200130104721eucas1p1303e51d76869af6045589816e3ac9675
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104753epcas4p2a438bc1a7eb6196a44644b0f93463d9d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104753epcas4p2a438bc1a7eb6196a44644b0f93463d9d
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104753epcas4p2a438bc1a7eb6196a44644b0f93463d9d@epcas4p2.samsung.com>
        <20181213104716.31930-16-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:46 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/sata_sil24.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 319f517137cd..4b00dce151eb 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -663,7 +663,7 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
>  	const char *reason;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> +	ata_link_dbg(link, "%s: ENTER\n", __func__);
>  
>  	/* put the port into known state */
>  	if (sil24_init_port(ap)) {
> @@ -689,7 +689,7 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
>  	sil24_read_tf(ap, 0, &tf);
>  	*class = ata_dev_classify(&tf);
>  
> -	DPRINTK("EXIT, class=%u\n", *class);
> +	ata_link_dbg(link, "%s: EXIT, class=%u\n", __func__, *class);

Please preserve __func__ printing in the conversion.

>  	return 0;
>  
>   err:

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
