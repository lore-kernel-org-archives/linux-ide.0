Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8CAC3F2CD
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F0321D56
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u7dbmQiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgCBQrK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:47:10 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45480 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgCBQrJ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 11:47:09 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302164707euoutp015c65467efd9681c1a2fb1ae3336ffa71~4ipHMXbGc3275332753euoutp01k
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 16:47:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302164707euoutp015c65467efd9681c1a2fb1ae3336ffa71~4ipHMXbGc3275332753euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583167627;
        bh=k14umeTOKmyfGWvUMOL6JLum4aWLtROCtjyyUBUvU3c=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=u7dbmQiVd7aqz5MQuIzNX5yyfnTzLmpWHINA8srjZ60KrEp7FPL5ms/AQQ/nyBPfq
         dfdDBGnrwEg06ibPV/jy50uLPX3U1drN9DniWUNJMXVJKjdpTAPeudpG6tsdTyc4tr
         hTMfxMErj4QG8NXbilfKVb0JCj0LHW7ixjz5uK1w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200302164707eucas1p17ef9af28f400454eb1cd32933a25dc80~4ipHAaQFm1460814608eucas1p1f;
        Mon,  2 Mar 2020 16:47:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2E.25.61286.B883D5E5; Mon,  2
        Mar 2020 16:47:07 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200302164707eucas1p15f4b556b14a97b195c41851b3ef55e5a~4ipGs05uD2031420314eucas1p17;
        Mon,  2 Mar 2020 16:47:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302164707eusmtrp22c4fd8a5951a3ba0b04c0d5d01376f8f~4ipGsS5De0795407954eusmtrp2H;
        Mon,  2 Mar 2020 16:47:07 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-7e-5e5d388ba4d8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 08.E6.07950.B883D5E5; Mon,  2
        Mar 2020 16:47:07 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200302164707eusmtip1ae84b299b99d979f793222615630d105~4ipGdVzmT2910929109eusmtip1q;
        Mon,  2 Mar 2020 16:47:06 +0000 (GMT)
Subject: Re: [PATCH 05/42] libata: move __func__ into
 ata_{port,link,dev}_dbg() helper
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <e632a4a2-cb57-0268-2d80-1babda1c6fa0@samsung.com>
Date:   Mon, 2 Mar 2020 17:47:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-6-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87rdFrFxBhdeqVisvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlissmJTUnsyy1SN8ugStjxsGvrAWP
        dCsWv25nbWA8r9LFyMkhIWAi8e/AX+YuRi4OIYEVjBK/dt5ignC+MErMujSHDcL5zChx/t1a
        VpiWIw8WsEIkljNKdHVcYgdJCAm8ZZT4+rS+i5GDQ1ggQmLadLCwiICSxMf2Q2A2M1B444a1
        TCA2m4CVxMT2VYwgNq+AncTqJT9YQGwWARWJ96+bwHaJAtV/enCYFaJGUOLkzCcsIOM5BYwk
        Vi+uhBgpLnHryXwmCFteYvvbOWDfSAh0s0vca73NCHGzi8Ttjz+gbGGJV8e3sEPYMhL/d85n
        gmhYxyjxt+MFVPd2Ronlk/+xQVRZS9w594sNZDOzgKbE+l36EGFHiZevW5lAwhICfBI33gpC
        HMEnMWnbdGaIMK9ER5sQRLWaxIZlG9hg1nbtXMk8gVFpFpLPZiF5ZxaSd2Yh7F3AyLKKUTy1
        tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMKmc/nf80w7Gr5eSDjEKcDAq8fAGMMfGCbEmlhVX
        5h5ilOBgVhLh9eWMjhPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFM
        lomDU6qB0aHRRSRXWNDrjXPx0yf+2fFKTZaCc5e9kr/zoSV0hcFzz3f7RSTt1olp6T135irK
        4Uybk8DoMv/dCvNQAdeUw1Mzp0gb5V/1D52dWf300C9xafuAPBXFppvvk05uaEmWCfCZKRL4
        uznnzYawNBHFJ2fMEy6W13YJNejP0a++aPfO33FSQLcSS3FGoqEWc1FxIgAcanOIJgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7rdFrFxBg/38VusvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jxsGvrAWPdCsWv25nbWA8r9LFyMkhIWAi
        ceTBAtYuRi4OIYGljBIvP85h6WLkAErISBxfXwZRIyzx51oXG0TNa0aJv/MmMYLUCAtESEyb
        zg5SIyKgJPGx/RCYzQwU7n51Bqp+LaPE5vfrWUASbAJWEhPbVzGC2LwCdhKrl/wAi7MIqEi8
        f93ECmKLAjUf3jELqkZQ4uTMJ2D3cAoYSaxeXAkxX13iz7xLzBC2uMStJ/OZIGx5ie1v5zBP
        YBSahaR7FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwirYd+7llB2PX
        u+BDjAIcjEo8vD8YYuOEWBPLiitzDzFKcDArifD6ckbHCfGmJFZWpRblxxeV5qQWH2I0Bfpt
        IrOUaHI+MMLzSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUwCk79
        83q7/JqwZVHxC/rSzzPpqq7Mld9zqyjuqsjpw7PtLbv4pytcdnkY+e+KfCeb1N638VVsxpIF
        0+V/3dslbqOzISDh3G03HuYKv12Tzh4+bSFcnfr0zSy5iBUKM8TfNv7L26Gf3BgyS3PSDfNL
        vHzl1Ud+Rc40me2+6ceN6RKs25Mn38l2UmIpzkg01GIuKk4EAB+MaPO4AgAA
X-CMS-MailID: 20200302164707eucas1p15f4b556b14a97b195c41851b3ef55e5a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213101349eucas1p26f6bc526e07cf9ac94de8dc754ab5c06
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213101349eucas1p26f6bc526e07cf9ac94de8dc754ab5c06
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213101349eucas1p26f6bc526e07cf9ac94de8dc754ab5c06@eucas1p2.samsung.com>
        <20200213095412.23773-6-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> Move the __func__ argument into the ata_{port,link,dev}_dbg()
> helper and drop the explicit argument from the caller.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-acpi.c | 14 ++++++--------
>  drivers/ata/libata-core.c |  9 ++++-----
>  drivers/ata/libata-sff.c  |  2 +-
>  include/linux/libata.h    |  6 +++---
>  4 files changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 9a7c25252e50..d5bcf5718fd3 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -419,8 +419,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
>  	output.pointer = NULL;	/* ACPI-CA sets this; save/free it later */
>  
>  	if (ata_msg_probe(ap))
> -		ata_dev_dbg(dev, "%s: ENTER: port#: %d\n",
> -			    __func__, ap->port_no);
> +		ata_dev_dbg(dev, "ENTER: port#: %d\n", ap->port_no);
>  
>  	/* _GTF has no input parameters */
>  	status = acpi_evaluate_object(ata_dev_acpi_handle(dev), "_GTF", NULL,
> @@ -438,8 +437,7 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
>  
>  	if (!output.length || !output.pointer) {
>  		if (ata_msg_probe(ap))
> -			ata_dev_dbg(dev, "%s: Run _GTF: length or ptr is NULL (0x%llx, 0x%p)\n",
> -				    __func__,
> +			ata_dev_dbg(dev, "Run _GTF: length or ptr is NULL (0x%llx, 0x%p)\n",
>  				    (unsigned long long)output.length,
>  				    output.pointer);
>  		rc = -EINVAL;
> @@ -465,8 +463,8 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
>  	if (gtf) {
>  		*gtf = (void *)out_obj->buffer.pointer;
>  		if (ata_msg_probe(ap))
> -			ata_dev_dbg(dev, "%s: returning gtf=%p, gtf_count=%d\n",
> -				    __func__, *gtf, rc);
> +			ata_dev_dbg(dev, "returning gtf=%p, gtf_count=%d\n",
> +				    *gtf, rc);
>  	}
>  	return rc;
>  
> @@ -780,8 +778,8 @@ static int ata_acpi_push_id(struct ata_device *dev)
>  	union acpi_object in_params[1];
>  
>  	if (ata_msg_probe(ap))
> -		ata_dev_dbg(dev, "%s: ix = %d, port#: %d\n",
> -			    __func__, dev->devno, ap->port_no);
> +		ata_dev_dbg(dev, "ix = %d, port#: %d\n",
> +			    dev->devno, ap->port_no);
>  
>  	/* Give the drive Identify data to the drive via the _SDD method */
>  	/* _SDD: set up input parameters */
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 5bf6e4da218a..3a8af0fef540 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1846,7 +1846,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
>  	int rc;
>  
>  	if (ata_msg_ctl(ap))
> -		ata_dev_dbg(dev, "%s: ENTER\n", __func__);
> +		ata_dev_dbg(dev, "ENTER\n");
>  
>  retry:
>  	ata_tf_init(dev, &tf);
> @@ -2447,7 +2447,7 @@ int ata_dev_configure(struct ata_device *dev)
>  	}
>  
>  	if (ata_msg_probe(ap))
> -		ata_dev_dbg(dev, "%s: ENTER\n", __func__);
> +		ata_dev_dbg(dev, "ENTER\n");
>  
>  	/* set horkage */
>  	dev->horkage |= ata_dev_blacklisted(dev);
> @@ -2498,9 +2498,8 @@ int ata_dev_configure(struct ata_device *dev)
>  	/* print device capabilities */
>  	if (ata_msg_probe(ap))
>  		ata_dev_dbg(dev,
> -			    "%s: cfg 49:%04x 82:%04x 83:%04x 84:%04x "
> +			    "cfg 49:%04x 82:%04x 83:%04x 84:%04x "
>  			    "85:%04x 86:%04x 87:%04x 88:%04x\n",
> -			    __func__,
>  			    id[49], id[82], id[83], id[84],
>  			    id[85], id[86], id[87], id[88]);
>  
> @@ -2767,7 +2766,7 @@ int ata_dev_configure(struct ata_device *dev)
>  
>  err_out_nosup:
>  	if (ata_msg_probe(ap))
> -		ata_dev_dbg(dev, "%s: EXIT, err\n", __func__);
> +		ata_dev_dbg(dev, "EXIT, err\n");
>  	return rc;
>  }
>  
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 038db94216a9..277398427e4e 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1266,7 +1266,7 @@ void ata_sff_flush_pio_task(struct ata_port *ap)
>  	ap->sff_pio_task_link = NULL;
>  
>  	if (ata_msg_ctl(ap))
> -		ata_port_dbg(ap, "%s: EXIT\n", __func__);
> +		ata_port_dbg(ap, "EXIT\n");
>  }
>  
>  static void ata_sff_pio_task(struct work_struct *work)
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 6b1ffb78a410..508f501095c9 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1424,7 +1424,7 @@ static inline int sata_srst_pmp(struct ata_link *link)
>  #define ata_port_info(ap, fmt, ...)				\
>  	dev_info(&ap->tdev, fmt, ##__VA_ARGS__)
>  #define ata_port_dbg(ap, fmt, ...)				\
> -	dev_dbg(&ap->tdev, fmt, ##__VA_ARGS__)
> +	dev_dbg(&ap->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
>  
>  #define ata_link_err(link, fmt, ...)				\
>  	dev_err(&link->tdev, fmt, ##__VA_ARGS__)
> @@ -1435,7 +1435,7 @@ static inline int sata_srst_pmp(struct ata_link *link)
>  #define ata_link_info(link, fmt, ...)				\
>  	dev_info(&link->tdev, fmt, ##__VA_ARGS__)
>  #define ata_link_dbg(link, fmt, ...)				\
> -	dev_dbg(&link->tdev, fmt, ##__VA_ARGS__)
> +	dev_dbg(&link->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
>  
>  #define ata_dev_err(dev, fmt, ...)				\
>  	dev_err(&dev->tdev, fmt, ##__VA_ARGS__)
> @@ -1446,7 +1446,7 @@ static inline int sata_srst_pmp(struct ata_link *link)
>  #define ata_dev_info(dev, fmt, ...)				\
>  	dev_info(&dev->tdev, fmt, ##__VA_ARGS__)
>  #define ata_dev_dbg(dev, fmt, ...)				\
> -	dev_dbg(&dev->tdev, fmt, ##__VA_ARGS__)
> +	dev_dbg(&dev->tdev, "%s: " fmt, __func__, ##__VA_ARGS__)
>  
>  void ata_print_version(const struct device *dev, const char *version);
>  

