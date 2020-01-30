Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08AAC33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 12:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A003320702
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 12:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HW8Ik5ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA3MDP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:03:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42040 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgA3MDO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 07:03:14 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130120312euoutp0210d1efd02ab541d097fd55f62d6a3be2~uqIFdVkNe1379213792euoutp02i
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 12:03:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130120312euoutp0210d1efd02ab541d097fd55f62d6a3be2~uqIFdVkNe1379213792euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580385792;
        bh=FZmexHEegUr+xt5LXpiU5x4iLVew0+nCofqAmz6JCzo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HW8Ik5nejjxYrvVHkbBku7zVjtfiwQB9MOW7Xm0CeHnec1G8SButCQR5CFFT5Rare
         tGJtXKO6CU8zu8eRCgKgiUiBXWoI9O78jVTAxcKcgbTdDImrSmQ2BuQPji21qz/Aa5
         ayDPJxnKOKeELBO1ghHIgG9X8aaNkCNHOJlXJ8no=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130120312eucas1p2599590a808a706559d066201774465f0~uqIFIjcZ92989729897eucas1p2P;
        Thu, 30 Jan 2020 12:03:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 27.04.61286.006C23E5; Thu, 30
        Jan 2020 12:03:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200130120312eucas1p18c3720de44357e5eb59730fc70eecf27~uqIEwb_RX2496724967eucas1p1C;
        Thu, 30 Jan 2020 12:03:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130120312eusmtrp2565fb1f0a5ab006b68353c27260dcb37~uqIEv3yxp0371303713eusmtrp2D;
        Thu, 30 Jan 2020 12:03:12 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-36-5e32c60058fa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.29.08375.006C23E5; Thu, 30
        Jan 2020 12:03:12 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200130120311eusmtip205f48d9c8818f5f318095fbf35272198~uqIEhbzSW2014020140eusmtip2E;
        Thu, 30 Jan 2020 12:03:11 +0000 (GMT)
Subject: Re: [PATCH 24/24] libata.h: Whitespace cleanup
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <ff30036d-de3e-0afb-8393-5bcc6552fa83@samsung.com>
Date:   Thu, 30 Jan 2020 13:03:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-36-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsWy7djP87oMx4ziDKZ/FLdYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6Mc42SBacE
        K5pPPWNtYLzC28XIySEhYCIxp289UxcjF4eQwApGiZ9th9khnC+MEpdP/YFyPjNK/OvrYoFp
        eXdxHiuILSSwnFHi5Xt/iKK3jBKTf7xhBEkIC5hLnL75FcwWEVCS+Nh+iB3EZhaIk2i6chfM
        ZhOwkpjYvgqshlfATuLWzwtsIDaLgKpE+/epYHFRgQiJTw8Os0LUCEqcnPkE7AhOAWOJD+/P
        MkHMFJe49WQ+lC0vsf3tHGaQgyQE+tklNjQvBmrgAHJcJBqfV0A8ICzx6vgWdghbRuL/zvlM
        EPXrGCX+dryAat7OKLF88j82iCpriTvnfrGBDGIW0JRYv0sfYqajxJxHXhAmn8SNt4IQJ/BJ
        TNo2nRkizCvR0SYEMUNNYsOyDWwwW7t2rmSewKg0C8ljs5A8MwvJM7MQ1i5gZFnFKJ5aWpyb
        nlpsmJdarlecmFtcmpeul5yfu4kRmFJO/zv+aQfj10tJhxgFOBiVeHg1NhjFCbEmlhVX5h5i
        lOBgVhLhFXU1jBPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomD
        U6qBMff5x0lzhXfEGPQ9/DHrSXX1BIMoHvlZVZF7T9z3eiXx5Unk+27J53tWxt3k1gz4LXrT
        zyjlZvfkhbV3As9vMBMNfLG3sfK/ZFDAfMXM0mW9qesmfdvcdSae3f3E6W/+HvJxN/XiE2NZ
        Zie1CF1JPBAhYtpUb654f6GJrzYrTy5LZZH/gXW2SizFGYmGWsxFxYkAXpfrJyUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xe7oMx4ziDK48YLJYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Mc42SBacEK5pPPWNtYLzC28XIySEhYCLx
        7uI81i5GLg4hgaWMEvOuTGLuYuQASshIHF9fBlEjLPHnWhcbRM1rRomjyx4wgSSEBcwlTt/8
        yghiiwgoSXxsP8QOYjMLxEn869vNBNGwjlHi1M0XYA1sAlYSE9tXgTXwCthJ3Pp5gQ3EZhFQ
        lWj/PhUsLioQIXF4xyyoGkGJkzOfsIDYnALGEh/en2WCWKAu8WfeJWYIW1zi1pP5UHF5ie1v
        5zBPYBSahaR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwjrYd+7l5
        B+OljcGHGAU4GJV4eDU2GMUJsSaWFVfmHmKU4GBWEuEVdTWME+JNSaysSi3Kjy8qzUktPsRo
        CvTcRGYp0eR8YIznlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpg
        VNkvumP/IVOl/MmeJgevbJ687foFNVWrDad8GHWDCjfFr3k49+kl4Y6c/A06UulO/JnHzjY8
        fB/73NvTTexpwOvG+L4/Zs5VDR2nHjxza/ApOtI/vfdLyB6Vm0s7fh1UTLm17N9Z57SpipPO
        rrgRO7XO272Ca6p9Y/NGIznFKIYrJnOPinGdV2Ipzkg01GIuKk4EABPNBGS5AgAA
X-CMS-MailID: 20200130120312eucas1p18c3720de44357e5eb59730fc70eecf27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104739epcas5p1e0991efea2a383501aefa5613639afaa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104739epcas5p1e0991efea2a383501aefa5613639afaa
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104739epcas5p1e0991efea2a383501aefa5613639afaa@epcas5p1.samsung.com>
        <20181213104716.31930-36-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Signed-off-by: Hannes Reinecke <hare@suse.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

This patch is obviously correct and is independent of all other
patches in the series so it should be moved at the beginning of
the patchset (or simply applied now).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  include/linux/libata.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 2f992b6ad626..3ed1b9ce1888 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -602,7 +602,7 @@ struct ata_ioports {
>  
>  struct ata_host {
>  	spinlock_t		lock;
> -	struct device 		*dev;
> +	struct device		*dev;
>  	void __iomem * const	*iomap;
>  	unsigned int		n_ports;
>  	unsigned int		n_tags;			/* nr of NCQ tags */
> @@ -822,7 +822,7 @@ struct ata_port {
>  	/* Flags that change dynamically, protected by ap->lock */
>  	unsigned int		pflags; /* ATA_PFLAG_xxx */
>  	unsigned int		print_id; /* user visible unique port ID */
> -	unsigned int            local_port_no; /* host local port num */
> +	unsigned int		local_port_no; /* host local port num */
>  	unsigned int		port_no; /* 0 based port no. inside the host */
>  
>  #ifdef CONFIG_ATA_SFF
> @@ -857,7 +857,7 @@ struct ata_port {
>  
>  	struct ata_port_stats	stats;
>  	struct ata_host		*host;
> -	struct device 		*dev;
> +	struct device		*dev;
>  	struct device		tdev;
>  
>  	struct mutex		scsi_scan_mutex;
> @@ -1008,7 +1008,7 @@ struct ata_port_info {
>  	unsigned long		mwdma_mask;
>  	unsigned long		udma_mask;
>  	struct ata_port_operations *port_ops;
> -	void 			*private_data;
> +	void			*private_data;
>  };
>  
>  struct ata_timing {
> @@ -1499,7 +1499,7 @@ static inline bool ata_tag_valid(unsigned int tag)
>   * Internal use only, iterate commands ignoring error handling and
>   * status of 'qc'.
>   */
> -#define ata_qc_for_each_raw(ap, qc, tag)					\
> +#define ata_qc_for_each_raw(ap, qc, tag)			\
>  	__ata_qc_for_each(ap, qc, tag, ATA_MAX_QUEUE, __ata_qc_from_tag)
>  
>  /*
