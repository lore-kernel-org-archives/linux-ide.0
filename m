Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C015C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B8020733
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 16:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WLWVexAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgBJQt6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:49:58 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54896 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgBJQt6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 11:49:58 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210164957euoutp01711cd8e31141d802854240c17f360efd~yGIlGWtH63237632376euoutp013
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 16:49:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210164957euoutp01711cd8e31141d802854240c17f360efd~yGIlGWtH63237632376euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581353397;
        bh=a4w1BihNKToDuRB8AY/wBejzYOHIZ5UvC2aY7aS/vM4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=WLWVexAHxjLdISG28drK9iKY0oDjusn3KDqKsNTSbddmSV22YAh+LDD55tUqZVrnZ
         LPEg3hSxx+oIvzvCGH3k6fuSwAzkuail5E7PY2oqFYaqZUL2wRgTtLJTSHw8E49U+/
         kn/zgvFQQJfzxRksxofqM3WK+Pcns0ugfZ2cbZtg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210164956eucas1p210bed4361c0ef05be6cd81b179289144~yGIk9Ixpc1728917289eucas1p23;
        Mon, 10 Feb 2020 16:49:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6F.8C.60698.4B9814E5; Mon, 10
        Feb 2020 16:49:56 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210164956eucas1p2d451624436536b005a47dc8d46c3c872~yGIkp_BGl1929519295eucas1p27;
        Mon, 10 Feb 2020 16:49:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210164956eusmtrp2a96df4b8cba459eb5d861a734cec1692~yGIkpXyHw3239232392eusmtrp2a;
        Mon, 10 Feb 2020 16:49:56 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-39-5e4189b4f210
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 86.45.07950.4B9814E5; Mon, 10
        Feb 2020 16:49:56 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210164956eusmtip1c8eaf46708d6c4f1e0b265374bded954~yGIkV8FoO0945009450eusmtip13;
        Mon, 10 Feb 2020 16:49:56 +0000 (GMT)
Subject: Re: [PATCH 44/46] libata: kill ATA_MSG_CTL
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <460a07ce-41a2-e5e8-aaeb-41da67473940@samsung.com>
Date:   Mon, 10 Feb 2020 17:49:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-45-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87pbOh3jDP7fNbRYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6Mtb37WAsO
        CFY0zJrI0sC4iq+LkZNDQsBE4sLDZ+xdjFwcQgIrGCVuLelghXC+MEocnrKIDcL5zCix4tZu
        FpiW/hOroBLLGSUufelihHDeMkrs2vKHDaRKWMBYYuvcRiYQW0RASeJj+yF2EJtZIE6i6cpd
        MJtNwEpiYvsqRhCbV8BOYubqRlYQm0VAVeLiiWdgtqhAhMSnB4dZIWoEJU7OfAJ0BQcHJ9AV
        c7bHQYwUl7j1ZD4ThC0vsf3tHGaIQ7vZJU6stoawXSROHN8A9YCwxKvjW9ghbBmJ/ztBermA
        7HWMEn87XjBDONsZJZZP/scGUWUtcefcLzaQxcwCmhLrd+lDhB0lbl9fBHaPhACfxI23ghA3
        8ElM2jadGSLMK9HRJgRRrSaxYdkGNpi1XTtXMk9gVJqF5LFZSL6ZheSbWQh7FzCyrGIUTy0t
        zk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMK6f/Hf+6g3Hfn6RDjAIcjEo8vBeCHeOEWBPLiitz
        DzFKcDArifBaSgOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xovehkrJJCeWJKanZpakFoEk2Xi
        4JRqYPT6sGKt+hbT1FsXfQ182y0mc+1x1XavnT/ree5T9RvLP5pMSZopIzD9e/gPp/+rvt+Y
        //B2woT+FounDbeaXFX87zWoO1789tgwdh+nSeohgdnFxYEdB9akLGBp6Nhqzeiy69WrxxEH
        z2u+zMwTX/0ude20XRMjmjgCj8abPpr99YnfJR/m1+JKLMUZiYZazEXFiQD1vH7rJwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7pbOh3jDD5clLdYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mtb37WAsOCFY0zJrI0sC4iq+LkZNDQsBE
        ov/EKrYuRi4OIYGljBJzO6cxdTFyACVkJI6vL4OoEZb4c60LquY1o8S1w1OZQBLCAsYSW+c2
        gtkiAkoSH9sPsYPYzAJxEv/6doPFhQQ2MEpcnJUIYrMJWElMbF/FCGLzCthJzFzdyApiswio
        Slw88QzMFhWIkDi8YxZUjaDEyZlPWEDu4QQ6dM72OIjx6hJ/5l1ihrDFJW49mc8EYctLbH87
        h3kCo9AsJN2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIFRtO3Yzy07
        GLveBR9iFOBgVOLhvRDsGCfEmlhWXJl7iFGCg1lJhNdSGijEm5JYWZValB9fVJqTWnyI0RTo
        t4nMUqLJ+cAIzyuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCeWJKanZpakFoE08fEwSnVwJhs
        uLK9Ve1syyztU/JdMeyLCi23hpjXbiyVzGs9ICizQz6vM+P8lDbtlX+fbnlz6dzJoktJe5Y/
        5Jp1wEKYUcDPOnvL6zZprnVbD+U+zKwrmyjQUMsduz84NILFat1z8VmSui/5zCvDFddq8DJV
        trjwHinZvTVYyXDHw9YoO4W8DX3ntH2fKrEUZyQaajEXFScCABGrtzy4AgAA
X-CMS-MailID: 20200210164956eucas1p2d451624436536b005a47dc8d46c3c872
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165618eucas1p25e3b27075d1aa43c4b7fe1245a55e7a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165618eucas1p25e3b27075d1aa43c4b7fe1245a55e7a5
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165618eucas1p25e3b27075d1aa43c4b7fe1245a55e7a5@eucas1p2.samsung.com>
        <20200204165547.115220-45-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> All instances had been converted to ata_XXX_dbg() anyway, so
> the conditional is pointless anyway.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-core.c | 5 ++---
>  include/linux/libata.h    | 2 --
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index a81e7006e73f..0f1682a55b54 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1858,8 +1858,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
>  	int may_fallback = 1, tried_spinup = 0;
>  	int rc;
>  
> -	if (ata_msg_ctl(ap))
> -		ata_dev_dbg(dev, "%s: ENTER\n", __func__);
> +	ata_dev_dbg(dev, "ENTER\n");
>  
>  retry:
>  	ata_tf_init(dev, &tf);
> @@ -6036,7 +6035,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  	/* turn on all debugging levels */
>  	ap->msg_enable = 0x00FF;
>  #elif defined(ATA_DEBUG)
> -	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
> +	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_WARN | ATA_MSG_ERR;
>  #else
>  	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
>  #endif
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index cab7aa3f0ed0..1012aed05187 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -73,7 +73,6 @@ enum {
>  	ATA_MSG_PROBE	= 0x0004,
>  	ATA_MSG_WARN	= 0x0008,
>  	ATA_MSG_MALLOC	= 0x0010,
> -	ATA_MSG_CTL	= 0x0020,
>  	ATA_MSG_INTR	= 0x0040,
>  	ATA_MSG_ERR	= 0x0080,
>  };
> @@ -82,7 +81,6 @@ enum {
>  #define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
>  #define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
>  #define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
> -#define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
>  #define ata_msg_intr(p)   ((p)->msg_enable & ATA_MSG_INTR)
>  #define ata_msg_err(p)    ((p)->msg_enable & ATA_MSG_ERR)
>  
