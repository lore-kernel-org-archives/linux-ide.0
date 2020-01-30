Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057B2C33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 12:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B3720702
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 12:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rDZ5dBwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA3MAL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:00:11 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40723 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgA3MAL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 07:00:11 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130120009euoutp02cdd9e927b70b6f3c7cd39d27aa44b421~uqFbCMgdq1110111101euoutp02e
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 12:00:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130120009euoutp02cdd9e927b70b6f3c7cd39d27aa44b421~uqFbCMgdq1110111101euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580385609;
        bh=PfDH6xRGfcc016/ZiXqvnlILrsAdCYflBzO1CNVD3PY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rDZ5dBwojVNWAhRpZAKMoxzVQdMqJcfNsSz/VXJsjSjrYIpAsXjmii6HddlkUw53f
         TsbPym9MG8xQQVIX7G3EKbUEJcOedwwwiBDAyKvOnCpPrb9W3PnLDiMOHInFsouR8X
         ZxAsuStyyeMFNLK+q8OH6HV65qoy3MlJ3k5fFn/Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200130120009eucas1p2bdc79dd004fc23da4f93c3675b791c78~uqFa4eucd0622106221eucas1p2n;
        Thu, 30 Jan 2020 12:00:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6D.83.61286.945C23E5; Thu, 30
        Jan 2020 12:00:09 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200130120009eucas1p29be256a96f8a6ffe21afabad945e572b~uqFahIJf_2479424794eucas1p2m;
        Thu, 30 Jan 2020 12:00:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130120009eusmtrp25350583ff38a37b6896b72acb23df2da~uqFagj_Pr0087500875eusmtrp2m;
        Thu, 30 Jan 2020 12:00:09 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-ca-5e32c54944b9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6B.B8.08375.945C23E5; Thu, 30
        Jan 2020 12:00:09 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200130120008eusmtip2a4a79f6296c5cbf9ad9057b8c7cc472b~uqFaMpjg11607916079eusmtip2J;
        Thu, 30 Jan 2020 12:00:08 +0000 (GMT)
Subject: Re: [PATCH 22/24] ata: Remove remaining references to ATA_DEBUG
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <c6ffe70c-cbc1-ec7c-914d-738e8a159b5c@samsung.com>
Date:   Thu, 30 Jan 2020 13:00:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-34-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djP87qeR43iDM7NUbFYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6M8zf3sRRc
        kKl4t+EDSwPjHPEuRk4OCQETic8nv7N1MXJxCAmsYJT4euYCI4TzhVHi+Lu7TBDOZ0aJheeX
        McK09H3/AFW1nFFi3uU3rCAJIYG3jBKr9oEVCQt4SPy7+hnMFhFwkHh6q4EFxGYWsJO4eLWV
        HcRmE7CSmNi+CqyGFyjesuI8WJxFQFVi1s2nzCC2qECExKcHh1khagQlTs58AjaHU8BYoq9/
        CRPETHGJW0/mQ9nyEtvfzmEGOU5CoJtd4sW/jewQV7tIvDlzF+oDYYlXx7dAxWUk/u+czwTR
        sI5R4m/HC6ju7YwSyyf/Y4Oospa4c+4XkM0BtEJTYv0ufYiwo8TkE83MIGEJAT6JG28FIY7g
        k5i0bTpUmFeio00IolpNYsOyDWwwa7t2rmSewKg0C8lrs5C8MwvJO7MQ9i5gZFnFKJ5aWpyb
        nlpsmJdarlecmFtcmpeul5yfu4kRmFhO/zv+aQfj10tJhxgFOBiVeHg1NhjFCbEmlhVX5h5i
        lOBgVhLhFXU1jBPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomD
        U6qBsed8T9WLYr2ydwttNzKv/z9rcreZ2Oq9Mzd3Bmafn3n9l++v/vt2hoxrGPWfh970/C7E
        3c15XO2R/CeDBskulq9JRce47JbOjNB+vJWRqe61ftgEm/wqgdktueo6x0IznvXl/tGc8vUv
        39Ej+7XvlwXsrDukz5k+68kECfX5q2tCF1a1fj1ToMRSnJFoqMVcVJwIAMiV1FgoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7qeR43iDJ4c4bdYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKD2bovzSklSFjPziElulaEMLIz1D
        Sws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M8zf3sRRckKl4t+EDSwPjHPEuRk4OCQET
        ib7vHxi7GLk4hASWMkpc/rMUyOEASshIHF9fBlEjLPHnWhcbRM1rRonFj2eygySEBTwk/l39
        zAhiiwg4SDy91cACYjML2ElcvNrKDtGwDmjo5S/MIAk2ASuJie2rwBp4gYpaVpwHG8QioCox
        6+ZTsBpRgQiJwztmQdUISpyc+QRsKKeAsURf/xImiAXqEn/mXWKGsMUlbj2ZDxWXl9j+dg7z
        BEahWUjaZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI2nbsZ+bdzBe
        2hh8iFGAg1GJh1djg1GcEGtiWXFl7iFGCQ5mJRFeUVfDOCHelMTKqtSi/Pii0pzU4kOMpkDP
        TWSWEk3OB0Z5Xkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxv6u
        ZG++AusVs2WineVTWxK+2FuGt2geOTjz40FxvzV9J/xzVxg/1J66Ic3oWKCdY2+M00UdmYmS
        9/40/uLdL7tOW2JV6LX5iyqXnBI9I8RskXgzgmVbg7WD3qHHZ9bEuH17l5h2Z/uhJRqruA8Z
        BbmsrDKdUHd0q+uqi2dnNilfUgzaMt3CT4mlOCPRUIu5qDgRAHSW00m6AgAA
X-CMS-MailID: 20200130120009eucas1p29be256a96f8a6ffe21afabad945e572b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104752epcas4p2e4bfedf01151d022ebc8057d5725e27f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104752epcas4p2e4bfedf01151d022ebc8057d5725e27f
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104752epcas4p2e4bfedf01151d022ebc8057d5725e27f@epcas4p2.samsung.com>
        <20181213104716.31930-34-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> ATA_DEBUG is now only used to switch on additional message levels.
> So move those two levels (ATA_MSG_INFO and ATA_MSG_CTL) over to
> ata_XXX_dbg() and remove the remaining references to ATA_DEBUG.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-core.c |  6 ++----
>  drivers/ata/libata-sff.c  |  3 +--
>  include/linux/libata.h    | 11 ++---------
>  3 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 914520254215..598b92d24530 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2464,8 +2464,8 @@ int ata_dev_configure(struct ata_device *dev)
>  	char modelbuf[ATA_ID_PROD_LEN+1];
>  	int rc;
>  
> -	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
> -		ata_dev_info(dev, "%s: ENTER/EXIT -- nodev\n", __func__);
> +	if (!ata_dev_enabled(dev)) {
> +		ata_dev_dbg(dev, "%s: ENTER/EXIT -- nodev\n", __func__);
>  		return 0;
>  	}
>  
> @@ -6025,8 +6025,6 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>  #if defined(ATA_VERBOSE_DEBUG)
>  	/* turn on all debugging levels */
>  	ap->msg_enable = 0x00FF;
> -#elif defined(ATA_DEBUG)
> -	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_INFO | ATA_MSG_CTL | ATA_MSG_WARN | ATA_MSG_ERR;
>  #else
>  	ap->msg_enable = ATA_MSG_DRV | ATA_MSG_ERR | ATA_MSG_WARN;
>  #endif
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 48b27f4e52fe..6587ae4fe0f4 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -1277,8 +1277,7 @@ void ata_sff_flush_pio_task(struct ata_port *ap)
>  
>  	ap->sff_pio_task_link = NULL;
>  
> -	if (ata_msg_ctl(ap))
> -		ata_port_dbg(ap, "%s: EXIT\n", __func__);
> +	ata_port_dbg(ap, "%s: EXIT\n", __func__);
>  }
>  
>  static void ata_sff_pio_task(struct work_struct *work)
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index cf62f3bdf4ef..4b5b174994b5 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -54,22 +54,17 @@
>   * compile-time options: to be removed as soon as all the drivers are
>   * converted to the new debugging mechanism
>   */
> -#undef ATA_DEBUG		/* debugging output */
>  #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
>  #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
>  #undef ATA_NDEBUG		/* define to disable quick runtime checks */
>  
>  
>  /* note: prints function name for you */
> -#ifdef ATA_DEBUG
>  #ifdef ATA_VERBOSE_DEBUG
>  #define VPRINTK(fmt, args...) printk(KERN_ERR "%s: " fmt, __func__, ## args)
>  #else
>  #define VPRINTK(fmt, args...)
>  #endif	/* ATA_VERBOSE_DEBUG */
> -#else
> -#define VPRINTK(fmt, args...)
> -#endif	/* ATA_DEBUG */
>  
>  #define BPRINTK(fmt, args...) if (ap->flags & ATA_FLAG_DEBUGMSG) printk(KERN_ERR "%s: " fmt, __func__, ## args)
>  
> @@ -1979,11 +1974,9 @@ static inline u8 ata_wait_idle(struct ata_port *ap)
>  {
>  	u8 status = ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
>  
> -#ifdef ATA_DEBUG
>  	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
> -		ata_port_printk(ap, KERN_DEBUG, "abnormal Status 0x%X\n",
> -				status);
> -#endif
> +		ata_port_dbg(ap, "%s: abnormal Status 0x%X\n",
> +			     __func__, status);
>  
>  	return status;
>  }

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
