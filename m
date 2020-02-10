Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910BCC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA2B20661
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PFYshD9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgBJQvQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:51:16 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55214 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJQvP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 11:51:15 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210165113euoutp013c3222b4137d2832fe6a3d17ace2e2bd~yGJsptYMN0148801488euoutp01k
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 16:51:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210165113euoutp013c3222b4137d2832fe6a3d17ace2e2bd~yGJsptYMN0148801488euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581353473;
        bh=rH4r2bmd44kFaW+hYaj8rREO8f4IfHpE8/xOtg1rA2A=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PFYshD9VwZ8w8XCJRwKSeJlAkDx5jbuNUwsMArIXr7wendyJFu3YMN+ABqpwYjnOH
         Y9KxR5iAQj9wZSs0FmBT8ApGaiJIDoc18wMPAQZUwkmTYlt0lIRWI+tNKM+9Vvae5t
         Z/pBpO+8oJYD07SffBCMPS4w1zbNgVbvajriD2yI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210165113eucas1p19a0bd53e33a0cf1554cba81a5efd262b~yGJsfr95x2467924679eucas1p1x;
        Mon, 10 Feb 2020 16:51:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BC.AC.60698.10A814E5; Mon, 10
        Feb 2020 16:51:13 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210165113eucas1p2bb29d6fd509765bae6b72220a69c72d2~yGJsLj66F2572025720eucas1p2I;
        Mon, 10 Feb 2020 16:51:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210165113eusmtrp23edbcff118067a7d67aeaaf308b8531a~yGJsLB37p0051100511eusmtrp2P;
        Mon, 10 Feb 2020 16:51:13 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-ef-5e418a010ec0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 07.65.07950.10A814E5; Mon, 10
        Feb 2020 16:51:13 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210165113eusmtip10a196379d75097f92205a8ff396f6eab~yGJr4XUh80364303643eusmtip1U;
        Mon, 10 Feb 2020 16:51:12 +0000 (GMT)
Subject: Re: [PATCH 46/46] libata: remove ATA_NDEBUG
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <8c6d4d27-5d99-5adf-4730-b80556367d42@samsung.com>
Date:   Mon, 10 Feb 2020 17:51:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-47-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LZduznOV3GLsc4g8Mt6har7/azWexZNInJ
        4tiOR0wOzB6Xz5Z6bD5d7fF5k1wAcxSXTUpqTmZZapG+XQJXxo4NXWwFa9kqmnZsZGtg7Gft
        YuTkkBAwkZh09R17FyMXh5DACkaJnuMHWCCcL4wSTT9/M0E4nxklThyZyg7T0r/8AhOILSSw
        nFFiVUs+RNFbRolXp2cwgiSEgYrmnzsCZosIKEl8bD8E1swsYC0xe/F6sGY2ASuJie2rwGp4
        Bewkdq5/zQZiswioSvw/fhcsLioQIfHpwWFWiBpBiZMzn7CA2JxA83+s/ckIMVNc4taT+UwQ
        trzE9rdzmEEOkhD4zyYxq+MeM8TVLhJ72hsYIWxhiVfHt0B9IyPxf+d8JoiGdYwSfzteQHVv
        Z5RYPvkfG0SVtcSdc7+AbA6gFZoS63fpQ4QdJb4cfc0OEpYQ4JO48VYQ4gg+iUnbpjNDhHkl
        OtqEIKrVJDYs28AGs7Zr50rmCYxKs5C8NgvJO7OQvDMLYe8CRpZVjOKppcW56anFxnmp5XrF
        ibnFpXnpesn5uZsYgUnk9L/jX3cw7vuTdIhRgINRiYf3QrBjnBBrYllxZe4hRgkOZiURXktp
        oBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2MDH1uv6In
        P5o4hTugqXlzpuz25fUZ124uWfheb/U3+7PKfPILuTTUbrxf93bH533nz+gZfOzX/fnsXosD
        wwuHlrp03xqvjxIbT9xNSwm6ZPXz0ZIPlyrc1prv82qJFKprWn6WI7i+wJO70kpjZvLs5uV8
        Eacc23JKI8r39mZquynsKJkgUHdKiaU4I9FQi7moOBEAbknJmh4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsVy+t/xu7qMXY5xBl/6+C1W3+1ns9izaBKT
        xbEdj5gcmD0uny312Hy62uPzJrkA5ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NY
        KyNTJX07m5TUnMyy1CJ9uwS9jB0butgK1rJVNO3YyNbA2M/axcjJISFgItG//AJTFyMXh5DA
        UkaJH539jF2MHEAJGYnj68sgaoQl/lzrYoOoec0o8evEHyaQhDBQ8/xzRxhBbBEBJYmP7YfY
        QWxmAWuJ2YvXQw3dwCjRMgOkm5ODTcBKYmL7KrAGXgE7iZ3rX4PFWQRUJf4fvwsWFxWIkDi8
        YxZUjaDEyZlPWEBsTqBlP9b+ZIRYoC7xZ94lZghbXOLWk/lMELa8xPa3c5gnMArNQtI+C0nL
        LCQts5C0LGBkWcUoklpanJueW2ykV5yYW1yal66XnJ+7iREYNduO/dyyg7HrXfAhRgEORiUe
        3gvBjnFCrIllxZW5hxglOJiVRHgtpYFCvCmJlVWpRfnxRaU5qcWHGE2BnpvILCWanA+M6LyS
        eENTQ3MLS0NzY3NjMwslcd4OgYMxQgLpiSWp2ampBalFMH1MHJxSDYypxlPcT547+lPl1vc9
        Irl3ilVbIkRN6hMWsxY6L9vw/sIuK//Vu1IWXlXdte/COYHLqrE8H6ofrk74k/v/Yziff/3M
        yOVRbwrDkheI7dNh/nOUbeqeH21vPrZwpRh/YD0Vd+yusmGDlf2EyjW6gcYuD/dYrt+fdMk4
        PqAttZKve/8Xpwds5f+VWIozEg21mIuKEwESKerVsAIAAA==
X-CMS-MailID: 20200210165113eucas1p2bb29d6fd509765bae6b72220a69c72d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165618eucas1p178db2e8e37770821178445e677798451
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165618eucas1p178db2e8e37770821178445e677798451
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165618eucas1p178db2e8e37770821178445e677798451@eucas1p1.samsung.com>
        <20200204165547.115220-47-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> No functionality.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  include/linux/libata.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 06d6a3e18e18..021ca967b4df 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -40,7 +40,6 @@
>   */
>  #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
>  #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
> -#undef ATA_NDEBUG		/* define to disable quick runtime checks */
>  
>  
>  /* note: prints function name for you */
> 
