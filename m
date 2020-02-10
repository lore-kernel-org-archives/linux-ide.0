Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C066C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125F420714
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JuOIKP6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBJPxP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:53:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54585 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgBJPxP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:53:15 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200210155314euoutp02785e81a80cf0438ed03a7fa0741d6807~yFXEIo28t2875328753euoutp025
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:53:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200210155314euoutp02785e81a80cf0438ed03a7fa0741d6807~yFXEIo28t2875328753euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581349994;
        bh=ssQ7DxSDFrM9OY1kRBCVzoE2xFLSKuxXBLKa3tyN3A8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JuOIKP6M98uIHMlqToFi0o77jhITdJK3/HbpNmWOjXbjwzk+ezVmEtyxLqFUlGJMA
         0d7ACPu4VN4WJaiEerayd4v7aNmZNsbFK37++LdTQKd/SsmmRvM5w9ssg/uxfoCs8O
         9sH21fiC6BhmHsMecqXjfG3FCaVhwySj5kfJ+DNw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210155314eucas1p13424c18d459c7c9a357689683a143c72~yFXEAwzje1303013030eucas1p1n;
        Mon, 10 Feb 2020 15:53:14 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EC.F1.61286.A6C714E5; Mon, 10
        Feb 2020 15:53:14 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210155313eucas1p2d034f693a457fd18c1e6a304121de606~yFXDwVMHK0708607086eucas1p28;
        Mon, 10 Feb 2020 15:53:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210155313eusmtrp2975a691fc3e8bd35e289ad86cf06e37f~yFXDvuXS20181301813eusmtrp2n;
        Mon, 10 Feb 2020 15:53:13 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-f0-5e417c6a8c16
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A8.E2.08375.96C714E5; Mon, 10
        Feb 2020 15:53:13 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200210155313eusmtip1c33f5d5c61916c16b841a7a1d84d6d25~yFXDgOwjg1184911849eusmtip1M;
        Mon, 10 Feb 2020 15:53:13 +0000 (GMT)
Subject: Re: [PATCH 36/46] sata_qstor: move DPRINTK to VPRINTK
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <e97bff40-abbf-4d11-c8df-209dda703351@samsung.com>
Date:   Mon, 10 Feb 2020 16:53:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-37-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsWy7djPc7pZNY5xBhv/cVmsvtvPZrHgzV42
        iz2LJjFZHNvxiMmBxePy2VKP9VuusnhsPl3t8XmTXABLFJdNSmpOZllqkb5dAlfGkxkzWAo+
        cVT0Tn7C0sA4l72LkZNDQsBE4nHHY0YQW0hgBaPEjeUJXYxcQPYXRonm3UuZIZzPjBI/d05m
        gumYNH0hE0RiOaPE41k72SCct4wS59Y+A3I4OIQF7CTOLMsHaRARUJL42H4IbB2zQJxE05W7
        YDabgJXExPZVjCDlvEDlpx8ngIRZBFQl5h5YDrZLVCBC4tODw6wgNq+AoMTJmU9YQGxOoBuu
        XfjGDDFSXOLWk/lMELa8xPa3c8COlhDoZ5e4eu0c1JsuEjv6b0HZwhKvjm+BsmUk/u+czwTR
        sI5R4m/HC6ju7YwSyyf/Y4Oospa4c+4X2GPMApoS63fpQ4QdJT41fQALSwjwSdx4KwhxBJ/E
        pG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27VzJfMERqVZSF6bheSdWUjemYWwdwEjyypG8dTS4tz0
        1GLDvNRyveLE3OLSvHS95PzcTYzApHL63/FPOxi/Xko6xCjAwajEw1sR6BgnxJpYVlyZe4hR
        goNZSYTXUhooxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dU
        A2P4hXiVuoUckVL/pq+/63C1UF3oTdWrmQl8QWr8rLb503/+Mkz4FWdzzK/nY8jvuddOpH9y
        7t+vsk6ac873lXNZO2ff8rjsuMRQ/VS4t8BGMS/NNzJHIw7z/TSvLBI6FibtIufP9aA9bYVC
        XdGkjbe3TWi+qfw7pC3sY66laMS+P2dm91hqWSuxFGckGmoxFxUnAgBfXZ/mJgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7qZNY5xBh0zrCxW3+1ns1jwZi+b
        xZ5Fk5gsju14xOTA4nH5bKnH+i1XWTw2n672+LxJLoAlSs+mKL+0JFUhI7+4xFYp2tDCSM/Q
        0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jyYwZLAWfOCp6Jz9haWCcy97FyMkhIWAi
        MWn6QiYQW0hgKaPEv6OFXYwcQHEZiePryyBKhCX+XOtigyh5zSgxdaItSImwgJ3EmWX5IGER
        ASWJj+2HwCYyC8RJ/OvbDTSRC6h8A6PE7w/dYOPZBKwkJravYgTp5QXqPf04ASTMIqAqMffA
        crASUYEIicM7ZjGC2LwCghInZz5hAbE5ga68duEbM8R8dYk/8y5B2eISt57MZ4Kw5SW2v53D
        PIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwAjaduzn5h2M
        lzYGH2IU4GBU4uGtCHSME2JNLCuuzD3EKMHBrCTCaykNFOJNSaysSi3Kjy8qzUktPsRoCvTc
        RGYp0eR8YHTnlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgDPys
        edLVit/tSav/Kqm24++LFFZnrjo6+VG29PlFNsoWrtFlnrvnPAhrcXzx6dytlEkrb87qN5pv
        cnnTcynbCVvYH09dWvlY+8XTidWCLcp3m5cd2dNQd4Z5S9HUC273Jc5aV6VFf96aJbXp7J6v
        PjdUW/3zFs2+EGPvuEdJsfqc3uIXKhP0/yqxFGckGmoxFxUnAgAZ0KtYtgIAAA==
X-CMS-MailID: 20200210155313eucas1p2d034f693a457fd18c1e6a304121de606
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204165617eucas1p2a48f94bfb2d84b0c6c92430e7b44a69f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204165617eucas1p2a48f94bfb2d84b0c6c92430e7b44a69f
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204165617eucas1p2a48f94bfb2d84b0c6c92430e7b44a69f@eucas1p2.samsung.com>
        <20200204165547.115220-37-hare@suse.de>
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
>  drivers/ata/sata_qstor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
> index ef00ab644afb..579a8a8f12ba 100644
> --- a/drivers/ata/sata_qstor.c
> +++ b/drivers/ata/sata_qstor.c
> @@ -374,7 +374,7 @@ static inline unsigned int qs_intr_pkt(struct ata_host *host)
>  			struct qs_port_priv *pp = ap->private_data;
>  			struct ata_queued_cmd *qc;
>  
> -			DPRINTK("SFF=%08x%08x: sCHAN=%u sHST=%d sDST=%02x\n",
> +			VPRINTK("SFF=%08x%08x: sCHAN=%u sHST=%d sDST=%02x\n",
>  					sff1, sff0, port_no, sHST, sDST);
>  			handled = 1;
>  			if (!pp || pp->state != qs_state_pkt)
> 
