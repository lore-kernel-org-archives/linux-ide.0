Return-Path: <SRS0=S1Gt=3T=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6003BC33C9E
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AB4206F0
	for <linux-ide@archiver.kernel.org>; Thu, 30 Jan 2020 10:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b7EVywIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgA3Kwj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:52:39 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44348 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgA3Kwj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2020 05:52:39 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200130105238euoutp02a839695256dbe362da6be03b89dabef2~upKdvkvTs0043900439euoutp02y
        for <linux-ide@vger.kernel.org>; Thu, 30 Jan 2020 10:52:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200130105238euoutp02a839695256dbe362da6be03b89dabef2~upKdvkvTs0043900439euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580381558;
        bh=hw0mMvaDC/Oph0WRlZWaD1Fk/lWO3HjwZcSO5AdAoLQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=b7EVywIFqqxi+hnjpB+hDAWklngQVdkRq+CW3+96HcwjNmKyCzqJbKllITPk1vS6+
         ytKih0QIjjT5Vyy0TI24YxvFzrVHir84fjAdje9vzFK04km2v/ehheInOnlu9fGVbk
         Ukb/fs7SpJ3eMk/VR49AhTMYXLlIkBfR+3gb4bGg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200130105238eucas1p107b31f88fbe57d066aab1408ebbf4497~upKdo5n2z2336123361eucas1p1c;
        Thu, 30 Jan 2020 10:52:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D0.79.61286.675B23E5; Thu, 30
        Jan 2020 10:52:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200130105237eucas1p2482947e2d1157fab5aed0ff84267b0c0~upKdWajFQ1474514745eucas1p2x;
        Thu, 30 Jan 2020 10:52:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200130105237eusmtrp2f1dbe271a8279b035ddbdf4814766327~upKdV2BCx2342323423eusmtrp29;
        Thu, 30 Jan 2020 10:52:37 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-90-5e32b576c39c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.2F.08375.575B23E5; Thu, 30
        Jan 2020 10:52:37 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200130105237eusmtip1eba47686ce42b102854adc84f186f8be~upKdC8MuY1647916479eusmtip1H;
        Thu, 30 Jan 2020 10:52:37 +0000 (GMT)
Subject: Re: [PATCH 11/24] pata_sil680: move DPRINTK to ata debugging
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <07a36667-4e8a-d150-4ee1-b105da56a2f1@samsung.com>
Date:   Thu, 30 Jan 2020 11:52:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20181213104716.31930-23-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7plW43iDL6cZbFYfbefzWLBm71s
        FnsWTWKyOLbjEZMDi8fls6Ue67dcZfHYfLra4/MmuQCWKC6blNSczLLUIn27BK6My5t72Ara
        OSqe7r3I2MB4m62LkZNDQsBE4tGSaUA2F4eQwApGiTdND5ggnC+MEncmfmCEcD4zSlw+3g7X
        snvpIWaIxHJGiRcX1kA5bxklmv78ZAapEhZwlXhxbSUTiC0ioCTxsf0QO4jNLBAn0XTlLpjN
        JmAlMbF9FSOIzStgJ3H19HSwOIuAqkTv+8lg20QFIiQ+PTjMClEjKHFy5hMWEJtTwFjiwBeI
        GmYBcYlbT+YzQdjyEtvfzmGGuLSfXeLOUT8I20XixbHJUHFhiVfHt7BD2DIS/3fOB/tZQmAd
        o8TfjhfMEM52Ronlk/9B/WwtcefcLyCbA2iDpsT6XfoQYUeJO+fvs4CEJQT4JG68FYS4gU9i
        0rbpzBBhXomONiGIajWJDcs2sMGs7dq5knkCo9IsJJ/NQvLNLCTfzELYu4CRZRWjeGppcW56
        arFhXmq5XnFibnFpXrpecn7uJkZgYjn97/inHYxfLyUdYhTgYFTi4dXYYBQnxJpYVlyZe4hR
        goNZSYRX1NUwTog3JbGyKrUoP76oNCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZJg5O
        qQbGdablfjm6XFVvd9UYugn+nFQfFfScQ/6QEa/DglSv9b0qPQweZxm9HRZsDfqrx3jn4GW/
        +dVOlw7f1LL7XnfbjyVyy+lD6QY6HyYUT2y90m4v+PgD84uYK6+4FvlJX7y0/F3JY9uNl1+K
        fDuz7+VXtySnFdqNUXUs3k+eVgQutuCRzvh1VLhfiaU4I9FQi7moOBEAES0alygDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xu7qlW43iDPoOGVisvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLlJ5NUX5pSapCRn5xia1StKGFkZ6h
        pYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G5c09bAXtHBVP915kbGC8zdbFyMkhIWAi
        sXvpIWYQW0hgKaPErscZXYwcQHEZiePryyBKhCX+XOtigyh5zSjR02QGYgsLuEq8uLaSCcQW
        EVCS+Nh+iB3EZhaIk/jXtxsozgVUv45R4sy1JhaQBJuAlcTE9lWMIDavgJ3E1dPTwRpYBFQl
        et9PBlsgKhAhcXjHLKgaQYmTM5+A9XIKGEsc+AJRwyygLvFn3iVmCFtc4taT+UwQtrzE9rdz
        mCcwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERhF24793LyD
        8dLG4EOMAhyMSjy8GhuM4oRYE8uKK3MPMUpwMCuJ8Iq6GsYJ8aYkVlalFuXHF5XmpBYfYjQF
        em4is5Rocj4wwvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5akZqemFqQWwfQxcXBKNTCm
        bPg9ccb+NQ8MtmlktGXeeKHCyrbufrYe55qm1Etrvn+f9THLrjaz2Hd7auWGP/enPNbcER5a
        coez16qna9uuQxfuzxENYj6hffTbqz9d92c89/vPf2vxFbdMhiuTVFVVZXeZvbKoFDskJnzO
        eueCVQKuO1+sianJYXTS//fj9us7y3wXF7cdVmIpzkg01GIuKk4EAMNjVe64AgAA
X-CMS-MailID: 20200130105237eucas1p2482947e2d1157fab5aed0ff84267b0c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181213104752epcas1p47af8f76a903a917f9a1b6b9a6a1313d8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181213104752epcas1p47af8f76a903a917f9a1b6b9a6a1313d8
References: <20181213104716.31930-1-hare@suse.de>
        <CGME20181213104752epcas1p47af8f76a903a917f9a1b6b9a6a1313d8@epcas1p4.samsung.com>
        <20181213104716.31930-23-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/13/18 11:47 AM, Hannes Reinecke wrote:
> Replace all DPRINTK calls with the ata_XXX_dbg functions.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  drivers/ata/pata_sil680.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> index c14071be4f55..5830808c932d 100644
> --- a/drivers/ata/pata_sil680.c
> +++ b/drivers/ata/pata_sil680.c
> @@ -211,7 +211,7 @@ static void sil680_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>  static void sil680_sff_exec_command(struct ata_port *ap,
>  				    const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> +	ata_port_dbg(ap, "cmd 0x%X\n", tf->command);

Please preserve __func__ printing in the conversion.

>  	iowrite8(tf->command, ap->ioaddr.command_addr);
>  	ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_CMD);
>  }

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
