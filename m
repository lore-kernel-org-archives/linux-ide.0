Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907EAC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6427D2070A
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G7Ebjk/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgBJNsw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:48:52 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43594 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgBJNsv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:48:51 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210134850euoutp01b55de52766668ea321d48cb4af1d8071~yDqdHs5ZX0956309563euoutp01U
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:48:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210134850euoutp01b55de52766668ea321d48cb4af1d8071~yDqdHs5ZX0956309563euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581342530;
        bh=n6/Wpu/+m6Y7ihgd7O31dCebfplxKR/DxdwaC9/Qq0o=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=G7Ebjk/VOUVCug4aseqj2/PQSUqMqg2WU+jLIIEKr5sc6iPu2BgO7OkXqLt7wnIBv
         Nv5AWESVw3IeHsAbkjltmAL5fPvKZvaIQ+fbRsGdyGE8shcUia50JFmQtR5/3WFt9A
         rVQxeK5WWZDmxd3QKv7X39eI2YUvjlTrhJC41jJ0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210134850eucas1p144935e954564be6aa1f7c3def9f030ac~yDqc6Pv6t0594205942eucas1p1S;
        Mon, 10 Feb 2020 13:48:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C5.1A.60679.24F514E5; Mon, 10
        Feb 2020 13:48:50 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210134850eucas1p1c5506e24a074ab08e73da2225e50c80f~yDqcpjmhV0390903909eucas1p1Z;
        Mon, 10 Feb 2020 13:48:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210134850eusmtrp249c7a1901f8dca3c3b3a7caf6e8dd999~yDqco_K2W3096930969eusmtrp2C;
        Mon, 10 Feb 2020 13:48:50 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-19-5e415f421e3a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4D.20.08375.24F514E5; Mon, 10
        Feb 2020 13:48:50 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210134849eusmtip15b979433d0b37e50fd5af5e2a09be10d~yDqcPQHaF0605506055eusmtip1V;
        Mon, 10 Feb 2020 13:48:49 +0000 (GMT)
Subject: Re: [PATCH 20/46] sata_sil24: drop DPRINTK() calls in reset
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a0e987e2-2893-5ce9-2633-c17820310ba8@samsung.com>
Date:   Mon, 10 Feb 2020 14:48:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-21-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduznOV2neMc4g3nn5C1W3+1ns9izaBKT
        xbEdj5gcmD0uny312Hy62uPzJrkA5igum5TUnMyy1CJ9uwSujAkvzzEXvOWo6H+g18DYw97F
        yMkhIWAiMfPIH5YuRi4OIYEVjBJb9jZDOV8YJV7vamaEcD4zSuxd2g3XMvv4P1aIxHJGiRXf
        T0K1vGWU6Nk+lbmLkYNDWMBFYu4EE5AGEQEliY/th8CamQWsJWYvXs8EYrMJWElMbF/FCGLz
        CthJtBw7ygZiswioSuyZNRvMFhWIkPj04DArRI2gxMmZT1hAbE6gIyY8+AU1U1zi1pP5TBC2
        vMT2t3OYQe6REPjNJrG6eT8zxNUuEm9fbmaFsIUlXh3fAvWNjMT/nSDNIA3rGCX+dryA6t7O
        KLF88j82iCpriTvnfrGBfMYsoCmxfpc+RNhR4vb5/ywgYQkBPokbbwUhjuCTmLRtOjNEmFei
        o00IolpNYsOyDWwwa7t2rmSewKg0C8lrs5C8MwvJO7MQ9i5gZFnFKJ5aWpybnlpslJdarlec
        mFtcmpeul5yfu4kRmEJO/zv+ZQfjrj9JhxgFOBiVeHgrAh3jhFgTy4orcw8xSnAwK4nwWkoD
        hXhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamCcHsPSrNG6
        WnGvpFH53CfTV6+ZcnTbhIqqxw96OKOPOHBbbj0vGWpaeCmRMzSgYYNm3JPYzizfysYu2f7D
        Z/f+PHBZdc3ZhA0Tynd+fRTyNjrxmVV77Eq2uqdXEx6GW9sUVUou096ewPJpb9U2Z8/1LFuT
        RdYpTdk8Pz1LiLX9Aut28yMqx3crsRRnJBpqMRcVJwIA8NY5Tx0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7pO8Y5xBq2L+CxW3+1ns9izaBKT
        xbEdj5gcmD0uny312Hy62uPzJrkA5ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NY
        KyNTJX07m5TUnMyy1CJ9uwS9jAkvzzEXvOWo6H+g18DYw97FyMkhIWAiMfv4P9YuRi4OIYGl
        jBIHXjxk7mLkAErISBxfXwZRIyzx51oXG0TNa0aJlrv7WUFqhAVcJOZOMAGpERFQkvjYfghs
        JrOAtcTsxeuZIOo3MEpMnr6GESTBJmAlMbF9FZjNK2An0XLsKBuIzSKgKrFn1mwwW1QgQuLw
        jllQNYISJ2c+YQGxOYEOnfDgF9QCdYk/8y4xQ9jiEreezGeCsOUltr+dwzyBUWgWkvZZSFpm
        IWmZhaRlASPLKkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMCI2Xbs5+YdjJc2Bh9iFOBgVOLh
        rQh0jBNiTSwrrsw9xCjBwawkwmspDRTiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGA055XE
        G5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRqYDSs29rT0+cSn/lujf7v
        1PkXhetmdKzfcL8q63/mNS72+RmbePTzdX5tVWg42lHgGl58Lzsu1ufYoXSlvpk3ny9ROedk
        8MB8l2/eSZ471Y+mJnyetmPbFKFHhXZr+1dasQRanuDQnfNuk1aDSVXUr68fikVbmcI6ZWda
        X4zjmR5w6IBsr/cJTiWW4oxEQy3mouJEADyyMkquAgAA
X-CMS-MailID: 20200210134850eucas1p1c5506e24a074ab08e73da2225e50c80f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165616eucas1p12e76f8b9585142837082ed044b4211ac
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165616eucas1p12e76f8b9585142837082ed044b4211ac
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165616eucas1p12e76f8b9585142837082ed044b4211ac@eucas1p1.samsung.com>
        <20200204165547.115220-21-hare@suse.de>
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
>  drivers/ata/sata_sil24.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
> index 2373cf5d8d14..48e2b3ec2afd 100644
> --- a/drivers/ata/sata_sil24.c
> +++ b/drivers/ata/sata_sil24.c
> @@ -653,8 +653,6 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
>  	const char *reason;
>  	int rc;
>  
> -	DPRINTK("ENTER\n");
> -
>  	/* put the port into known state */
>  	if (sil24_init_port(ap)) {
>  		reason = "port not ready";
> @@ -679,7 +677,6 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
>  	sil24_read_tf(ap, 0, &tf);
>  	*class = ata_port_classify(ap, &tf);
>  
> -	DPRINTK("EXIT, class=%u\n", *class);
>  	return 0;
>  
>   err:
> 
