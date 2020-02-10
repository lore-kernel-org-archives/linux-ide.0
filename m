Return-Path: <SRS0=vLfT=36=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8F2C352A3
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6B020733
	for <linux-ide@archiver.kernel.org>; Mon, 10 Feb 2020 15:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GfveJPRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBJPtj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:49:39 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36050 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgBJPtj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 10 Feb 2020 10:49:39 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200210154938euoutp01626015681d2838276e207c4d7db6c7d9~yFT64jFJY1586115861euoutp012
        for <linux-ide@vger.kernel.org>; Mon, 10 Feb 2020 15:49:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200210154938euoutp01626015681d2838276e207c4d7db6c7d9~yFT64jFJY1586115861euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581349778;
        bh=iB4JfnlwPNcnp8ONO956BmDKBpeSHa0HWBLsJje4ipk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=GfveJPRmmDhiAfFtH0iQ/kNDuNftXvkdyLgMmXIcPpUch+w6LkidUWqiuatDKjO43
         tRsbOrsCjP7Hz+qva/lR7y1pTbN18tyifW1+2aMKNbhSQKEoRpljelMnAxJ9BcYqF9
         z5HC1KDG+d2eC2S3BV8Hn4uAYGZYdV++kzhX/yhQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200210154938eucas1p182b93f8e3c8472f8b4fcd9c3881dea58~yFT6sojUw0224102241eucas1p1L;
        Mon, 10 Feb 2020 15:49:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 67.71.61286.19B714E5; Mon, 10
        Feb 2020 15:49:38 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200210154937eucas1p2140f3445206cacea73816667a00062f9~yFT6Y9a6w1668016680eucas1p23;
        Mon, 10 Feb 2020 15:49:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200210154937eusmtrp2a60e2614c5902a774865d40588e13247~yFT6YZJwA3249732497eusmtrp2Z;
        Mon, 10 Feb 2020 15:49:37 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-a2-5e417b91b5a8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 01.72.08375.19B714E5; Mon, 10
        Feb 2020 15:49:37 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200210154937eusmtip27e4efa32f239e66a1a32b11259517783~yFT6JN_lp0317903179eusmtip2D;
        Mon, 10 Feb 2020 15:49:37 +0000 (GMT)
Subject: Re: [PATCH 32/46] pata_pdc202xx_old: Drop DPRINTK in
 pdc202xx_exec_command()
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <429c25f4-e97b-4678-f094-64ebf4175fbc@samsung.com>
Date:   Mon, 10 Feb 2020 16:49:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200204165547.115220-33-hare@suse.de>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduznOd1J1Y5xBk8yLVbf7Wez2LNoEpPF
        sR2PmByYPS6fLfXYfLra4/MmuQDmKC6blNSczLLUIn27BK6MdUs6GQuWs1csWfGNtYGxg62L
        kZNDQsBE4sG2/axdjFwcQgIrGCXWNnxih3C+MEpMffebEcL5zCgx++QpVpiWRaeOskEkljNK
        3N9zEmyWkMBbRok1E21BbGGBcImFrQ9YQGwRASWJj+2H2EFsZgFridmL1zOB2GwCVhIT21cx
        gti8AnYS/37MBFvAIqAqsXnpETBbVCBC4tODw6wQNYISJ2c+AZvJCXTEvLPToWaKS9x6Mp8J
        wpaX2P52DjPIcRIC/9kkvvesBTqOA8hxkVj0OBjiAWGJV8e3sEPYMhL/d4L0gtSvY5T42/EC
        qnk7o8Tyyf+goWQtcefcL7BBzAKaEut36UOEHSUuT5vLCDGfT+LGW0GIG/gkJm2bzgwR5pXo
        aBOCqFaT2LBsAxvM2q6dK5knMCrNQvLZLCTfzELyzSyEvQsYWVYxiqeWFuempxYb5qWW6xUn
        5haX5qXrJefnbmIEJpDT/45/2sH49VLSIUYBDkYlHt6KQMc4IdbEsuLK3EOMEhzMSiK8ltJA
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhgZu5JkVuzj
        Pn8v8qzaZ4NrV/Y4+UcqrtoQtOWOPJOh/eTK9qh5T35tnpI/Y6XOuROZPVGJVqabmqoK5rRx
        CkpJxRWIHbhr/IQ792tV7sKZ8dlKm0ot3pxoaNTb8lfUVmuWiO3/D3HLFPrksl5/zrJJaFTl
        UWe5dvPQ6R2vQ47LpVZzvS+PWK/EUpyRaKjFXFScCACeQqTkHAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7oTqx3jDLq2aVusvtvPZrFn0SQm
        i2M7HjE5MHtcPlvqsfl0tcfnTXIBzFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6GeuWdDIWLGevWLLiG2sDYwdbFyMnh4SAicSiU0eBbC4OIYGl
        jBI3br9l7mLkAErISBxfXwZRIyzx51oXVM1rRomVO0BqODmEBcIlFrY+YAGxRQSUJD62H2IH
        sZkFrCVmL17PBGILCWxglGi7Zg9iswlYSUxsX8UIYvMK2En8+zGTFcRmEVCV2Lz0CJgtKhAh
        cXjHLKgaQYmTM5+AzecEOnTe2elQ89Ul/sy7xAxhi0vcejKfCcKWl9j+dg7zBEahWUjaZyFp
        mYWkZRaSlgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY2bbsZ+bdzBe2hh8iFGAg1GJ
        h7ci0DFOiDWxrLgy9xCjBAezkgivpTRQiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OB8ZxX
        Em9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoGx56BgfIux45sW/kOd
        P/0W31QqmLPIq+ZzdE/ZGo3H9ZcOFJcW7m9PUlv1KO1+I+fs1genQqcvYPmxmEPLP/zW6lST
        r6sOrHPpqTgn0bUwZV5gz/mYq8JH0kWXhz259bf0ccy6tecnLGspmZ3I/KfAIKcg69OtgK/N
        qjsTU7i9zryYeFD4esQHJZbijERDLeai4kQA+r5wNK8CAAA=
X-CMS-MailID: 20200210154937eucas1p2140f3445206cacea73816667a00062f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204171351eucas1p1aeee74b6426c0d24aa96516ac58d38d7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204171351eucas1p1aeee74b6426c0d24aa96516ac58d38d7
References: <20200204165547.115220-1-hare@suse.de>
        <CGME20200204171351eucas1p1aeee74b6426c0d24aa96516ac58d38d7@eucas1p1.samsung.com>
        <20200204165547.115220-33-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 2/4/20 5:55 PM, Hannes Reinecke wrote:
> Now covered with a generic tracepoint.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/ata/pata_pdc202xx_old.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ata/pata_pdc202xx_old.c b/drivers/ata/pata_pdc202xx_old.c
> index 378ed9ea97e9..3778270e762f 100644
> --- a/drivers/ata/pata_pdc202xx_old.c
> +++ b/drivers/ata/pata_pdc202xx_old.c
> @@ -38,8 +38,6 @@ static int pdc2026x_cable_detect(struct ata_port *ap)
>  static void pdc202xx_exec_command(struct ata_port *ap,
>  				  const struct ata_taskfile *tf)
>  {
> -	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> -
>  	iowrite8(tf->command, ap->ioaddr.command_addr);
>  	ndelay(400);
>  }
> 

