Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08621C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C967920733
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qdFYQPUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgBJPrb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:47:31 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35316 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgBJPrb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:47:31 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210154730euoutp01fcffd2acd06d427d8489464510a96476~yFSDZ-eDv1344813448euoutp01h
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:47:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210154730euoutp01fcffd2acd06d427d8489464510a96476~yFSDZ-eDv1344813448euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581349650;
        bh=6CviwP+6yeUcRlMY4fouxZZvaFrd8V7vaf3xrb5aXXI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qdFYQPUFoAh9PXtGCQvqyV4N1KDyskMBbjaTc5z/2zGp4zUnuqxsimK0IMsmVcUwQ
         gSZSrCmgQiRGvCTSJ+BwsVYRjNwUyBnISRJe8ET5wDKIaf/ZqRaB/nn4VAU3kbJJqk
         DYRJT0N5PDGyueQxfPwgHwExAtKyqLk+7rhTQfNU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210154729eucas1p18a42f999696931355dc4a6c1527269e5~yFSC_7vME2695726957eucas1p12;
        Mon, 10 Feb 2020 15:47:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 97.F4.60698.11B714E5; Mon, 10
        Feb 2020 15:47:29 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210154729eucas1p1c997367d1d5d44f9438aaf52b3f25e0a~yFSCjr_ae2690826908eucas1p15;
        Mon, 10 Feb 2020 15:47:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210154729eusmtrp2f8869954f37b2ba6e990e6258dbb21e1~yFSCjFFKy3149731497eusmtrp2I;
        Mon, 10 Feb 2020 15:47:29 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-3f-5e417b118a33
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 68.22.08375.11B714E5; Mon, 10
        Feb 2020 15:47:29 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210154728eusmtip227641ee7b23bf5f4f6ef61f02b6e66a2~yFSCN70rI0486204862eusmtip2r;
        Mon, 10 Feb 2020 15:47:28 +0000 (GMT)
Subject: Re: [PATCH 30/46] libata-core: add postreset tracepoints
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <97d535f1-130a-0645-de17-2b3d607a162d@samsung.com>
Date:   Mon, 10 Feb 2020 16:47:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-31-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djPc7qC1Y5xBstmy1usvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGidPpBQ9F
        Kh4cPMrewPhOoIuRg0NCwETiyOWqLkYuDiGBFYwSVxb2M3UxcgI5XxglHv7VgUh8ZpRYv20V
        K0gCpOHtk3fMEInljBKHLz9hg3DeMkr0nX8O1i4s4Cgxf/oXRhBbREBJ4mP7IXYQm1kgTqLp
        yl0wm03ASmJi+ypGkDN4Bewk3h7zAAmzCKhKrNm/AWyMqECExKcHh8EW8woISpyc+YQFxOYE
        OmJN0xJmiJHiEreezGeCsOUltr+dA3achEA/u8TE66vYIK52kbi3bC0ThC0s8er4FnYIW0bi
        /06QZpCGdYwSfzteQHVvZ5RYPvkfVLe1xJ1zv9hALmUW0JRYv0sfIuwocX76QiZIOPJJ3Hgr
        CHEEn8SkbdOZIcK8Eh1tQhDVahIblm1gg1nbtXMl8wRGpVlIXpuF5J1ZSN6ZhbB3ASPLKkbx
        1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMCUcvrf8a87GPf9STrEKMDBqMTDeyHYMU6INbGs
        uDL3EKMEB7OSCK+lNFCINyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUw
        WSYOTqkGRuUPexnLjDNb2zIKZRXO8OpazeJi2r5Kcf1d5tlqz3av2an9ir1c2FfFb2GJUunX
        afXCwQ0bLxzM+8pr+NLqrrb74pZVTMHvLir4ai5laphR9b7d0ntpYhjzktNZMxrvtN9xZJbo
        FFnYu+D15loxiy7d0xsENevkWJ0lvTIZ7KP1FTymLTmpxFKckWioxVxUnAgACk1+ciUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7qC1Y5xBsu3MVusvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GidPpBQ9FKh4cPMrewPhOoIuRk0NCwETi
        7ZN3zF2MXBxCAksZJWZenMrSxcgBlJCROL6+DKJGWOLPtS42iJrXjBJnl3xiAkkICzhKzJ/+
        hRHEFhFQkvjYfogdxGYWiJP417ebCaJhA6NE/4V1YA1sAlYSE9tXMYIs4BWwk3h7zAMkzCKg
        KrFm/wawElGBCInDO2aBzeQVEJQ4OfMJC4jNCXTomqYlzBDz1SX+zLsEZYtL3HoynwnClpfY
        /nYO8wRGoVlI2mchaZmFpGUWkpYFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqNo27Gf
        m3cwXtoYfIhRgINRiYe3ItAxTog1say4MvcQowQHs5IIr6U0UIg3JbGyKrUoP76oNCe1+BCj
        KdBzE5mlRJPzgRGeVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qB
        0WjjsoM+52ynh8teO7L5/ReNw0yO61pu75skotLs/73B8+J9S43AtxcVlS2K+F5JfzeWVBRT
        mKFle0x4ys68opvZeiEdf8wqjv+ZazLpXtcXAc5pQY3NxpG2qY4Xp9+QSyo7nejt9XeXG1fN
        BPeOc3M70nl/fgwV4X91V+SRQ6Xf5k1rf6y7r8RSnJFoqMVcVJwIAESO7Zm4AgAA
X-CMS-MailID: 20200210154729eucas1p1c997367d1d5d44f9438aaf52b3f25e0a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165615eucas1p2aa8b09e0e456f03b5a288307a82f81c5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165615eucas1p2aa8b09e0e456f03b5a288307a82f81c5
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165615eucas1p2aa8b09e0e456f03b5a288307a82f81c5@eucas1p2.samsung.com>
        <20200204165547.115220-31-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Add additional tracepoints for postreset and remove
> the DPRINTK() call.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

How's about merging this with "[PATCH 14/46] libata: add reset
tracepoints"?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-eh.c       | 5 ++++-
>  drivers/ata/libata-sff.c      | 4 +---
>  include/trace/events/libata.h | 8 ++++++++
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 253dcf903c1b..ef3576eb5874 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2900,8 +2900,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  	 */
>  	if (postreset) {
>  		postreset(link, classes);
> -		if (slave)
> +		trace_ata_link_postreset(link, classes, rc);
> +		if (slave) {
>  			postreset(slave, classes);
> +			trace_ata_slave_postreset(slave, classes, rc);
> +		}
>  	}
>  
>  	/*
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 228f801ef611..ffe633f13f55 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -2052,10 +2052,8 @@ void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
>  		ap->ops->sff_dev_select(ap, 0);
>  
>  	/* bail out if no device is present */
> -	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
> -		DPRINTK("EXIT, no device\n");
> +	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE)
>  		return;
> -	}
>  
>  	/* set up device control */
>  	if (ap->ops->sff_set_devctl || ap->ioaddr.ctl_addr) {
> diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
> index 446f56cb3f01..40027d8424f8 100644
> --- a/include/trace/events/libata.h
> +++ b/include/trace/events/libata.h
> @@ -526,6 +526,14 @@ DEFINE_EVENT(ata_link_reset_end_template, ata_link_softreset_end,
>  	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
>  	     TP_ARGS(link, class, rc));
>  
> +DEFINE_EVENT(ata_link_reset_end_template, ata_link_postreset,
> +	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
> +	     TP_ARGS(link, class, rc));
> +
> +DEFINE_EVENT(ata_link_reset_end_template, ata_slave_postreset,
> +	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
> +	     TP_ARGS(link, class, rc));
> +
>  DECLARE_EVENT_CLASS(ata_sff_hsm_template,
>  
>  	TP_PROTO(struct ata_queued_cmd *qc, unsigned char status),
> 

