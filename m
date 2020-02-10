Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B0AC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67ED2070A
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 13:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Dqn4LZ0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgBJNsV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:48:21 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43374 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgBJNsV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 08:48:21 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210134818euoutp01c23c0de4eec6157b244373c9a3d66f08~yDp-Ldtnx0956309563euoutp01I
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 13:48:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210134818euoutp01c23c0de4eec6157b244373c9a3d66f08~yDp-Ldtnx0956309563euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581342498;
        bh=tzLtNHLXW4M4F9n8BY8vRH8PbRyE/lWxBbzObJpb0Y4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Dqn4LZ0KX1Y0q2nFKCZM2W7AVrU/4a/2KJbGrRdLBTaNN/9iAj48olMfaYbIQkJc5
         kg/YErVe/aBs1Be8b0yq4zUY1R9d7334WnElWec0con11PS8dzLaXoaIY8uJYHTD7q
         A53vlFYp21DRUqzMq/SXxGwfephk5U+HSpwYinjA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210134818eucas1p201f9d10bc2449ba2b09bea913c07871f~yDp-AoH1Q1483414834eucas1p25;
        Mon, 10 Feb 2020 13:48:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 19.B1.60698.22F514E5; Mon, 10
        Feb 2020 13:48:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210134818eucas1p2e6116359d2c37d4a9e3dc5e3edbad05d~yDp_p6_IU1891418914eucas1p2k;
        Mon, 10 Feb 2020 13:48:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210134818eusmtrp16783171cbe6158e5351dd4ad2e99cf71~yDp_pYaTL2007920079eusmtrp1X;
        Mon, 10 Feb 2020 13:48:18 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-e2-5e415f226f53
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 54.10.08375.22F514E5; Mon, 10
        Feb 2020 13:48:18 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210134817eusmtip2c61fd2f4c94aa172d6f828c355a4e87e~yDp_dxi4F2745127451eusmtip2v;
        Mon, 10 Feb 2020 13:48:17 +0000 (GMT)
Subject: Re: [PATCH 19/46] sata_rcar: drop DPRINTK() calls in reset
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <4be14566-a67c-ca1c-3f4d-b326e967bd7c@samsung.com>
Date:   Mon, 10 Feb 2020 14:48:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-20-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZduzneV2leMc4g709Uhar7/azWexZNInJ
        4tiOR0wOzB6Xz5Z6bD5d7fF5k1wAcxSXTUpqTmZZapG+XQJXxv4Fj9kK3vFU7Pv2hr2BcRtX
        FyMnh4SAicSbvq1MXYxcHEICKxglPp9+xwbhfGGU6P+2gxHC+cwocfn6IhaYlve3b0FVLWeU
        WNa9Esp5C+S0PGQEqRIWcJa4+W0dWIeIgJLEx/ZD7CA2s4C1xOzF65lAbDYBK4mJ7avA6nkF
        7CT2f5sMZrMIqEr8WP4BrEZUIELi04PDrBA1ghInZz4Bm8kJdMXTu92MEDPFJW49mc8EYctL
        bH87hxnkIAmB/2wSq3fdBWrgAHJcJDYeMID4QFji1fEt7BC2jMTpyT0sEPXrGCX+dryAat7O
        KLF88j82iCpriTvnfrGBDGIW0JRYv0sfYqajxMxHPhAmn8SNt4IQJ/BJTNo2nRkizCvR0SYE
        MUNNYsOyDWwwW7t2rmSewKg0C8ljs5A8MwvJM7MQ1i5gZFnFKJ5aWpybnlpsnJdarlecmFtc
        mpeul5yfu4kRmEJO/zv+dQfjvj9JhxgFOBiVeHgvBDvGCbEmlhVX5h5ilOBgVhLhtZQGCvGm
        JFZWpRblxxeV5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbLxMEp1cC46vaXRwnr/VPs
        3Y6ofL3MYSwZmsdpPc1h+tbLU5arnJ2a7WNjYv7MJuByKeecE357lLMOq5Tt2CzhP6HK/ewW
        n5K+t9ffqt/qdHI5t2fSbufjp+NbLzzkTSiKOqkVVJ0bkbsuU6E4Yitn8Uur/XN+Sr8+clZ2
        ebl+dfePGWmems+Kk2fWz05SYinOSDTUYi4qTgQAhgkxth0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7pK8Y5xBu9bmC1W3+1ns9izaBKT
        xbEdj5gcmD0uny312Hy62uPzJrkA5ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NY
        KyNTJX07m5TUnMyy1CJ9uwS9jP0LHrMVvOOp2PftDXsD4zauLkZODgkBE4n3t2+xdTFycQgJ
        LGWUeN71hL2LkQMoISNxfH0ZRI2wxJ9rXVA1rxklZq/awAaSEBZwlrj5bR0LiC0ioCTxsf0Q
        O4jNLGAtMXvxeiYQW0hgA6PEhxZ/EJtNwEpiYvsqRhCbV8BOYv+3yWA2i4CqxI/lH8DqRQUi
        JA7vmAVVIyhxcuYTsPmcQIc+vdvNCDFfXeLPvEvMELa4xK0n85kgbHmJ7W/nME9gFJqFpH0W
        kpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBmth37uXkH46WNwYcYBTgY
        lXh4KwId44RYE8uKK3MPMUpwMCuJ8FpKA4V4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5HxjP
        eSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGBVWf26IXP2ULVli
        mnahes9fZc+iBQEXtHcdlzFXzlXUkWBQ2uuk9cuVo6euN+JXeaiNkrLZGUP2hXzlXntsHga2
        s8+TXCgQYs285SRXHEf0LHVB8b3n/RzXntolvZXl6soPM3atuHb7hx3/+5l6qqrX42fpFhep
        6GyXe/l2VlhiekjCWaZ5SizFGYmGWsxFxYkASka8uq8CAAA=
X-CMS-MailID: 20200210134818eucas1p2e6116359d2c37d4a9e3dc5e3edbad05d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165615eucas1p1085c481af2cb3afcdfcb624b20488884
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165615eucas1p1085c481af2cb3afcdfcb624b20488884
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165615eucas1p1085c481af2cb3afcdfcb624b20488884@eucas1p1.samsung.com>
        <20200204165547.115220-20-hare@suse.de>
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
>  drivers/ata/sata_rcar.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> index 980aacdbcf3b..1b42be234761 100644
> --- a/drivers/ata/sata_rcar.c
> +++ b/drivers/ata/sata_rcar.c
> @@ -323,8 +323,6 @@ static int sata_rcar_bus_softreset(struct ata_port *ap, unsigned long deadline)
>  {
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
> -
>  	/* software reset.  causes dev0 to be selected */
>  	iowrite32(ap->ctl, ioaddr->ctl_addr);
>  	udelay(20);
> @@ -350,7 +348,6 @@ static int sata_rcar_softreset(struct ata_link *link, unsigned int *classes,
>  		devmask |= 1 << 0;
>  
>  	/* issue bus reset */
> -	DPRINTK("about to softreset, devmask=%x\n", devmask);
>  	rc = sata_rcar_bus_softreset(ap, deadline);
>  	/* if link is occupied, -ENODEV too is an error */
>  	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
> @@ -361,7 +358,6 @@ static int sata_rcar_softreset(struct ata_link *link, unsigned int *classes,
>  	/* determine by signature whether we have ATA or ATAPI devices */
>  	classes[0] = ata_sff_dev_classify(&link->device[0], devmask, &err);
>  
> -	DPRINTK("classes[0]=%u\n", classes[0]);
>  	return 0;
>  }
>  
