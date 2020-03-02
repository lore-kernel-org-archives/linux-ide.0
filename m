Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985C3C3F2CD
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DA52465E
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 17:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Vq1TaiEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCBR5b (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:57:31 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59069 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBR5b (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 12:57:31 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200302175730euoutp01b320197e8a586fd4457f86936a3b4e2b~4jmjlPcWR2010320103euoutp01c
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 17:57:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200302175730euoutp01b320197e8a586fd4457f86936a3b4e2b~4jmjlPcWR2010320103euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583171850;
        bh=7C/tyT2VNvJAALycnVnOlCRXJXXM/7+fimdOsDTOBHw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Vq1TaiEKpf3pEczCNzQXT0BCNWfHgl1s9/F4UKOJmihfHkw1u1PwNT3m2uLUgpo9o
         UCofPfFsEa9Zbb4ZHMLODRFq57wL6mSQ6cHvkLDzur5bLOX+OuBY416rM71Vn0UItW
         B/Mu9xkErc7EKaPQifAVZctBMa2vBacBJx5vyZvo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200302175730eucas1p1c48b3b8945d8cdc1cdc2e4c707ff65f3~4jmjedaIP0986009860eucas1p1Q;
        Mon,  2 Mar 2020 17:57:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9D.EF.60698.9094D5E5; Mon,  2
        Mar 2020 17:57:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302175729eucas1p2429f9aaef8b9db3c1f976c785c075b07~4jmjPnFkh1183811838eucas1p2E;
        Mon,  2 Mar 2020 17:57:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200302175729eusmtrp16288d31ed308cb5a73abd902824f4b60~4jmjPB7y12087220872eusmtrp18;
        Mon,  2 Mar 2020 17:57:29 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-e3-5e5d49090634
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.5B.07950.9094D5E5; Mon,  2
        Mar 2020 17:57:29 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302175729eusmtip2cb4bbfe259739db1887c26f9eb2ab74b~4jmi7WDcS1012210122eusmtip2U;
        Mon,  2 Mar 2020 17:57:29 +0000 (GMT)
Subject: Re: [PATCH 24/42] libata-sff: drop DPRINTK for the HSM state
 machine
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <a687fe23-2cab-0b2b-b9fc-8c0c617394c3@samsung.com>
Date:   Mon, 2 Mar 2020 18:57:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-25-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djP87pcnrFxBt1fGS1W3+1ns9izaBKT
        xbEdj5gsfi0/yujA4nH5bKnHplWdbB6bT1d7fN4kF8ASxWWTkpqTWZZapG+XwJXRfnAlW8FO
        0YpJTwsbGI8IdjFyckgImEgcP76NuYuRi0NIYAWjxNRdu9hBEkICXxglXn3lhkh8ZpSYcXo/
        axcjB1jH9Q4viPhyRomOhj3sEM5bRonvCw6ygXQLC/hLHLh+nAnEFhFQkvjYfghsKrNAhMTG
        DWvB4mwCVhIT21cxgti8AnYSl+Y8AbNZBFQkXi75CVYvClT/6cFhVogaQYmTM5+wgNicAsYS
        L7/1sEDMFJe49WQ+E4QtL7H97RywdyQEutkl9v38xALxp4vEz6+7oWxhiVfHt7BD2DISpyeD
        DAJpWMco8bfjBVT3dkaJ5ZP/sUFUWUvcOfeLDeR/ZgFNifW79CHCjhK/Fr9igwQLn8SNt4IQ
        R/BJTNo2nRkizCvR0SYEUa0msWHZBjaYtV07VzJPYFSaheS1WUjemYXknVkIexcwsqxiFE8t
        Lc5NTy02zkst1ytOzC0uzUvXS87P3cQITCqn/x3/uoNx35+kQ4wCHIxKPLwBzLFxQqyJZcWV
        uYcYJTiYlUR4fTmj44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgST
        ZeLglGpgNJ0dEmOjc9nMdJEXi6rYOjktg+jJS1fqa9WdqmKt1Wj9z86SWfJ95adfx922TD1o
        qLR8E7cV97snjevCkroPCHYuusT0/3rDn1rXb/N4X1zYUfb55bN9nBe2XHdU2/t5xpKWY347
        96oyVS/3FOS4NIN1RXqxqthbw7Q9+08IV6q2lr3betx9jxJLcUaioRZzUXEiAJGV/iAmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7qcnrFxBpfm6FqsvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS+j/eBKtoKdohWTnhY2MB4R7GLk4JAQMJG4
        3uHVxcjFISSwlFHiz/s+Zoi4jMTx9WVdjJxAprDEn2tdbBA1rxklts37yQaSEBbwlei6tJoJ
        xBYRUJL42H6IHcRmFoiQ6H51BqphHaPEz7cXmEESbAJWEhPbVzGC2LwCdhKX5jwBs1kEVCRe
        LvkJ1iwK1Hx4xyyoGkGJkzOfsIDYnALGEi+/9bBALFCX+DPvEjOELS5x68l8JghbXmL72znM
        ExiFZiFpn4WkZRaSlllIWhYwsqxiFEktLc5Nzy020itOzC0uzUvXS87P3cQIjKJtx35u2cHY
        9S74EKMAB6MSD+8Phtg4IdbEsuLK3EOMEhzMSiK8vpzRcUK8KYmVValF+fFFpTmpxYcYTYGe
        m8gsJZqcD4zwvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjN7f
        ve7Hpswy/bZ/TuG7NktXt478XwXzUlMXa8VfuuKbfMl44sxsxYoIle8te7jdfMt2e/Xd+MnX
        0Pmnfs21NjOfNVKBJ8u90qX7I5tn1dVYGvDf26bKxee30kTD/uMijQ1v80809ixb8d1pi3di
        8gt5l6r8JdMndOquq12TNpW5c9KzvuT9SizFGYmGWsxFxYkAmAC1kLgCAAA=
X-CMS-MailID: 20200302175729eucas1p2429f9aaef8b9db3c1f976c785c075b07
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095440eucas1p1b61fc4ffc55268e3947d9d4651ce9ab7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095440eucas1p1b61fc4ffc55268e3947d9d4651ce9ab7
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095440eucas1p1b61fc4ffc55268e3947d9d4651ce9ab7@eucas1p1.samsung.com>
        <20200213095412.23773-25-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> The information is now logged with tracepoints, so the DPRINTK
> calls can be dropped.

The addition of trace_*() statements should be in patch #23 and
this patch should contain only the removal of no longer needed
DPRINTK() instances.

[ Just like it has been done in reset tracepoints conversion. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/ata/libata-sff.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 1078b621d47b..f6a54b574b25 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -660,7 +660,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>  	page = nth_page(page, (offset >> PAGE_SHIFT));
>  	offset %= PAGE_SIZE;
>  
> -	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
> +	trace_ata_sff_pio_transfer_data(qc, offset, qc->sect_size);
>  
>  	/* do the actual data transfer */
>  	buf = kmap_atomic(page);
> @@ -723,7 +723,7 @@ static void ata_pio_sectors(struct ata_queued_cmd *qc)
>  static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
>  {
>  	/* send SCSI cdb */
> -	DPRINTK("send cdb\n");
> +	trace_atapi_send_cdb(qc, 0, qc->dev->cdb_len);
>  	WARN_ON_ONCE(qc->dev->cdb_len < 12);
>  
>  	ap->ops->sff_data_xfer(qc, qc->cdb, qc->dev->cdb_len, 1);
> @@ -794,7 +794,7 @@ static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
>  	/* don't cross page boundaries */
>  	count = min(count, (unsigned int)PAGE_SIZE - offset);
>  
> -	DPRINTK("data %s\n", qc->tf.flags & ATA_TFLAG_WRITE ? "write" : "read");
> +	trace_atapi_pio_transfer_data(qc, offset, count);
>  
>  	/* do the actual data transfer */
>  	buf = kmap_atomic(page);
> @@ -976,8 +976,7 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
>  	WARN_ON_ONCE(in_wq != ata_hsm_ok_in_wq(ap, qc));
>  
>  fsm_start:
> -	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
> -		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
> +	trace_ata_sff_hsm_state(qc, status);
>  
>  	switch (ap->hsm_task_state) {
>  	case HSM_ST_FIRST:
> @@ -1178,8 +1177,7 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
>  		}
>  
>  		/* no more data to transfer */
> -		DPRINTK("ata%u: dev %u command complete, drv_stat 0x%x\n",
> -			ap->print_id, qc->dev->devno, status);
> +		trace_ata_sff_hsm_command_complete(qc, status);
>  
>  		WARN_ON_ONCE(qc->err_mask & (AC_ERR_DEV | AC_ERR_HSM));
>  
