Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88ADC352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F5720714
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DEfqxw/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgBJPw2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:52:28 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54298 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgBJPw2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:52:28 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210155226euoutp0215fa6e3d07c08bd67732433efd0f5928~yFWX7TuyB2860428604euoutp022
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:52:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210155226euoutp0215fa6e3d07c08bd67732433efd0f5928~yFWX7TuyB2860428604euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581349946;
        bh=O2yKKsdEm/q/WqxmZSjkE0RyN4g41DQ4Dgu1ooA0XM0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DEfqxw/6JYBDDD66nu7LcoPU5fA16SfZcaF3k2gg91QNEvjC68Zq3EOtCyUJkLhcU
         3tV1MPS2BUxK1qD/0C6VEtNzoTp8sFiFmMOfSsWqLvsuaNRd3VSvRwW2jODU4JOEp5
         xxeverD+QfNNljfVvabJX8VGRpFkG4Y7pyGixw2M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200210155226eucas1p2358b6f17f886e41cb4149164b53aadc9~yFWXu627O0710407104eucas1p2b;
        Mon, 10 Feb 2020 15:52:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 42.A5.60698.A3C714E5; Mon, 10
        Feb 2020 15:52:26 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200210155226eucas1p19542c139877032e9582f68eac2785918~yFWXYWAHW1774217742eucas1p1U;
        Mon, 10 Feb 2020 15:52:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200210155226eusmtrp1e2c777f313789f2bb011814defcf6e91~yFWXXvPy02641026410eusmtrp1U;
        Mon, 10 Feb 2020 15:52:26 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-aa-5e417c3af704
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.CE.07950.A3C714E5; Mon, 10
        Feb 2020 15:52:26 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210155225eusmtip1501206725680067cbf0f0efd393a1b57~yFWXDL1oT1111911119eusmtip1g;
        Mon, 10 Feb 2020 15:52:25 +0000 (GMT)
Subject: Re: [PATCH 34/46] pdc_adma: move DPRINTK to VPRINTK
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <703f5012-88a8-2fac-eb87-f11cb4184b78@samsung.com>
Date:   Mon, 10 Feb 2020 16:52:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-35-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djP87pWNY5xBv8/aFisvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfG3TOWBTc4
        Kv63bGRrYGxj72Lk5JAQMJHouH+FuYuRi0NIYAWjxN6bb5hBEkICXxglvp/2gEh8ZpT4d3Me
        K0zHtr8PGCESyxklNn58wQ7hvGWUeHvlJhtIlbCAjcTTaWfAdogIKEl8bD8EZjMLxEk0XbkL
        ZrMJWElMbF/FCGLzCthJbN3bB7aBRUBVYvvPLrC4qECExKcHh1khagQlTs58wgJicwJdMePh
        VlaImeISt57MZ4Kw5SW2v50D9o+EQDe7xJaLLxghznaRWNP0hg3CFpZ4dXwLNABkJE5P7mGB
        aFjHKPG34wVU93ZGieWT/0F1WEvcOfcLyOYAWqEpsX6XPkTYUWLJvDZmkLCEAJ/EjbeCEEfw
        SUzaNh0qzCvR0SYEUa0msWHZBjaYtV07VzJPYFSaheS1WUjemYXknVkIexcwsqxiFE8tLc5N
        Ty02zkst1ytOzC0uzUvXS87P3cQITCun/x3/uoNx35+kQ4wCHIxKPLwXgh3jhFgTy4orcw8x
        SnAwK4nwWkoDhXhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCU
        amCse3p03q0JblZfL0+0Dbh2+ah4xMUdm5jOppwUfXBIpfLf0oaX5kxXeR3vil/pOl0x2yJj
        3q658xbUXmZ+zfRlwbeKjFsT3rgW7P/FWFd8b9uJ7qM+Cw5w+DL+NgrRtIvc9qLyhuXqIKPV
        /01MZ82es/3w3yD3rryzOuYxfY2ymnIB7kwdATnCSizFGYmGWsxFxYkAsA1wQScDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7pWNY5xBi0beS1W3+1ns1jwZi+b
        xZ5Fk5gsju14xOTA4nH5bKnH+i1XWTw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j7hnLghscFf9bNrI1MLaxdzFyckgImEhs
        +/uAsYuRi0NIYCmjxLlzLcxdjBxACRmJ4+vLIGqEJf5c62KDqHnNKPFxRzsjSEJYwEbi6bQz
        YINEBJQkPrYfArOZBeIk/vXtZoJo2MAocfLnITaQBJuAlcTE9lVgzbwCdhJb9/axgtgsAqoS
        2392gcVFBSIkDu+YBVUjKHFy5hMWEJsT6NIZD7eyQixQl/gz7xIzhC0ucevJfCYIW15i+9s5
        zBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIyjbcd+btnB
        2PUu+BCjAAejEg/vhWDHOCHWxLLiytxDjBIczEoivJbSQCHelMTKqtSi/Pii0pzU4kOMpkDP
        TWSWEk3OB8Z4Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxhlZ
        swrzy/2LN1m7uIt//dz4d8ILx/jld94e2vBIwazJ0LcnPXDJV72dLMURfwJEa5nWc//dXPD2
        tvxUxpIdlvd3zfGwnVFZlLamYMa2A1uf2rj0JNmF2O5c8MRmP6dmIzOPteq8r7/irZX6OW/u
        UtrCuk5RMl/DSCRYZqHXhCn3q6MXuZt5KLEUZyQaajEXFScCAC5dTf65AgAA
X-CMS-MailID: 20200210155226eucas1p19542c139877032e9582f68eac2785918
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165617eucas1p1b6d5efe9aa4a3143c0feff97cf667fd7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165617eucas1p1b6d5efe9aa4a3143c0feff97cf667fd7
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165617eucas1p1b6d5efe9aa4a3143c0feff97cf667fd7@eucas1p1.samsung.com>
        <20200204165547.115220-35-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.com>
> 
> Move the remaining DPRINTK statement in the interrupt handler to
> VPRINTK. It'll be converted later with the remaining VPRINTK
> calls.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/pdc_adma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
> index 5db55e1e2a61..255738efea89 100644
> --- a/drivers/ata/pdc_adma.c
> +++ b/drivers/ata/pdc_adma.c
> @@ -475,7 +475,7 @@ static inline unsigned int adma_intr_mmio(struct ata_host *host)
>  			u8 status = ata_sff_check_status(ap);
>  			if ((status & ATA_BUSY))
>  				continue;
> -			DPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
> +			VPRINTK("ata%u: protocol %d (dev_stat 0x%X)\n",
>  				ap->print_id, qc->tf.protocol, status);
>  
>  			/* complete taskfile transaction */
> 
