Return-Path: <SRS0=3I3m=4T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE66C3F2CD
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 16:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE38222C4
	for <linux-ide@archiver.kernel.org>; Mon,  2 Mar 2020 16:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kOjs+WrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCBQyY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:54:24 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38312 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgCBQyX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 2 Mar 2020 11:54:23 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200302165421euoutp0263b21658297375f6368eb0785592bb21~4ivbg5TDG2154621546euoutp02N
        for <linux-ide@vger.kernel.org>; Mon,  2 Mar 2020 16:54:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200302165421euoutp0263b21658297375f6368eb0785592bb21~4ivbg5TDG2154621546euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583168062;
        bh=EHf/02cuH8LVeGWFbfLbiEWK8N7+bVz/HkRpFeSV0x8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kOjs+WrYJpZ7vXViTVB+65DXpahSe0DTWcaAED/RYrJstHD299+zRZtAtvcXGiYp4
         cT79vwehlbA0oxj2W/OXuqOtzFM3W9T4rpWEz5ZWv2tZsH9H3GLeBtyBnebK5MUe5x
         J5EU+vCkmEgIxrmSRkzO50/6km4ULHkjmxijSoQQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200302165421eucas1p1d6bb24417e62465a09b6263274116344~4ivbVp3Yc2058020580eucas1p1B;
        Mon,  2 Mar 2020 16:54:21 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8F.C5.61286.D3A3D5E5; Mon,  2
        Mar 2020 16:54:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200302165421eucas1p2e27e2eba48759343533108f23939a6e7~4ivbFfQDd2332223322eucas1p2N;
        Mon,  2 Mar 2020 16:54:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200302165421eusmtrp2c19078a802dc789b46e933bfc53aa1d2~4ivbE97cu1249212492eusmtrp2V;
        Mon,  2 Mar 2020 16:54:21 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-6a-5e5d3a3dc2a9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 04.77.07950.D3A3D5E5; Mon,  2
        Mar 2020 16:54:21 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200302165420eusmtip24d1c9e640e7b6acf7200c7e81d35db2d~4ivanOGKn2816028160eusmtip2c;
        Mon,  2 Mar 2020 16:54:20 +0000 (GMT)
Subject: Re: [PATCH 10/42] libata: move ata_dump_id() to dynamic debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <d0b51792-3b21-f30c-893b-e05c470d21d3@samsung.com>
Date:   Mon, 2 Mar 2020 17:54:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213095412.23773-11-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsWy7djPc7q2VrFxBj27tC1W3+1ns9izaBKT
        xbEdj5gsfi0/yujA4nH5bKnHplWdbB6bT1d7fN4kF8ASxWWTkpqTWZZapG+XwJVx9sAGxoIP
        QhXdy2YxNTC+4uti5OSQEDCRuDD5GGMXIxeHkMAKRokvK66zgCSEBL4wSqxprYBIfGaU6L27
        lxmm4/PMZmaIxHJGiRcL70A5bxkllp+bxARSJSzgJfH/8DYwW0RASeJj+yF2EJtZIEJi44a1
        YHE2ASuJie2rGEFsXgE7iaZTU8DiLAIqErffvQE7QxSo/tODw6wQNYISJ2c+AYtzChhLnLk2
        FWqmuMStJ/OZIGx5ie1v54AdJCHQzy5x9t9SVoizXSRWf/0PZQtLvDq+hR3ClpH4vxOkGaRh
        HaPE344XUN3bgd6Z/I8Nospa4s65X0A2B9AKTYn1u/RBTAkBR4lNnwsgTD6JG28FIW7gk5i0
        bTozRJhXoqNNCGKGmsSGZRvYYLZ27VzJPIFRaRaSz2Yh+WYWkm9mIaxdwMiyilE8tbQ4Nz21
        2DAvtVyvODG3uDQvXS85P3cTIzCtnP53/NMOxq+Xkg4xCnAwKvHwBjDHxgmxJpYVV+YeYpTg
        YFYS4fXljI4T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1Oq
        gdEltvWWY+DBwzoWrhvX35Na0DW14IC51vl9R9b1hti+a3hb/JfzqPx+Jkv7M09V6mWa1k8p
        CV1pzBr2262365WLyNZl93cXZy311rz2qLmnKzk7LIH7gZZP6RNNIcGTIYe32ESYz7V0EdZw
        dK++NnHGEdd3YnOf7FLLEJ577qc/V5fC95MnGZVYijMSDbWYi4oTAUVgRYgnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7q2VrFxBh/eSlmsvtvPZrFn0SQm
        i2M7HjFZ/Fp+lNGBxePy2VKPTas62Tw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j7IENjAUfhCq6l81iamB8xdfFyMkhIWAi
        8XlmM3MXIxeHkMBSRolXi2+xdTFyACVkJI6vL4OoEZb4c62LDaLmNaPE7t4lzCAJYQEvif+H
        tzGB2CICShIf2w+xg9jMAhES3a/OQDWsY5R43ryYDSTBJmAlMbF9FSOIzStgJ9F0agpYM4uA
        isTtd29YQGxRoObDO2ZB1QhKnJz5BCzOKWAscebaVKgF6hJ/5l1ihrDFJW49mc8EYctLbH87
        h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGRtO3Yzy07
        GLveBR9iFOBgVOLh/cEQGyfEmlhWXJl7iFGCg1lJhNeXMzpOiDclsbIqtSg/vqg0J7X4EKMp
        0HMTmaVEk/OBUZ5XEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoGx
        II3Vd0kP19mPsoZMD3eGtKaV2WRf27d/6n8m14KSVdkZsw3KPrZd/33ppHSpxOGLdlr7bG8/
        efHm7R7XR3eOM34pMX9YzOdgPDEihWfJuXoVzlUmVhMPpDPXNt6UePtQzfdOeWGOdWvs39p1
        q3purTSaW1S6bueee+FezVGFx70U1qyQ/fZdiaU4I9FQi7moOBEAWUhAWLoCAAA=
X-CMS-MailID: 20200302165421eucas1p2e27e2eba48759343533108f23939a6e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200213095433eucas1p1eb36d517abfcc0c24c85e66c161b0ecd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200213095433eucas1p1eb36d517abfcc0c24c85e66c161b0ecd
References: <20200213095412.23773-1-hare@suse.de>
        <CGME20200213095433eucas1p1eb36d517abfcc0c24c85e66c161b0ecd@eucas1p1.samsung.com>
        <20200213095412.23773-11-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/13/20 10:53 AM, Hannes Reinecke wrote:
> Use ata_dev_dbg() to print out the information in ata_dump_id()
> and remove the ata_msg_probe() conditional.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/libata-core.c | 38 ++++++++++----------------------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 17abc52ce41e..1987886140b6 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1440,6 +1440,7 @@ static int ata_hpa_resize(struct ata_device *dev)
>  
>  /**
>   *	ata_dump_id - IDENTIFY DEVICE info debugging output
> + *	@dev: device from which the information is fetched
>   *	@id: IDENTIFY DEVICE page to dump
>   *
>   *	Dump selected 16-bit words from the given IDENTIFY DEVICE
> @@ -1449,32 +1450,14 @@ static int ata_hpa_resize(struct ata_device *dev)
>   *	caller.
>   */
>  
> -static inline void ata_dump_id(const u16 *id)
> -{
> -	DPRINTK("49==0x%04x  "
> -		"53==0x%04x  "
> -		"63==0x%04x  "
> -		"64==0x%04x  "
> -		"75==0x%04x  \n",
> -		id[49],
> -		id[53],
> -		id[63],
> -		id[64],
> -		id[75]);
> -	DPRINTK("80==0x%04x  "
> -		"81==0x%04x  "
> -		"82==0x%04x  "
> -		"83==0x%04x  "
> -		"84==0x%04x  \n",
> -		id[80],
> -		id[81],
> -		id[82],
> -		id[83],
> -		id[84]);
> -	DPRINTK("88==0x%04x  "
> -		"93==0x%04x\n",
> -		id[88],
> -		id[93]);
> +static inline void ata_dump_id(struct ata_device *dev, const u16 *id)
> +{
> +	ata_dev_dbg(dev,
> +		"49==0x%04x  53==0x%04x  63==0x%04x  64==0x%04x  75==0x%04x\n"
> +		"80==0x%04x  81==0x%04x  82==0x%04x  83==0x%04x  84==0x%04x\n"
> +		"88==0x%04x  93==0x%04x\n",
> +		id[49], id[53], id[63], id[64], id[75], id[80],
> +		id[81], id[82], id[83], id[84], id[88], id[93]);
>  }
>  
>  /**
> @@ -2551,8 +2534,7 @@ int ata_dev_configure(struct ata_device *dev)
>  	/* find max transfer mode; for printk only */
>  	xfer_mask = ata_id_xfermask(id);
>  
> -	if (ata_msg_probe(ap))
> -		ata_dump_id(id);
> +	ata_dump_id(dev, id);
>  
>  	/* SCSI only uses 4-char revisions, dump full 8 chars from ATA */
>  	ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV,
> 

