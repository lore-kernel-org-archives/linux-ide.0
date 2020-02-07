Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCB2C3F68F
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34A621775
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="THoXROQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgBGOXo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:23:44 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48193 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBGOXn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:23:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142342euoutp024e430df44533df4b36866fb67f23e2ca~xJNB95nJV2313123131euoutp02C
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:23:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142342euoutp024e430df44533df4b36866fb67f23e2ca~xJNB95nJV2313123131euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085422;
        bh=clCBOESf24I9k4dm3bRTz0WLqiRuLntRo0h2ZpvUv3w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=THoXROQHoFYbzTZpn1z8vTONAsS0daR9uxV+LFgrpdHUKQYU4cz70Z4kU7ZbXTUrm
         ThU9qIkprQJCrWpks/wGw45lSrEIDD4h7trZLkXiRLFAV5rR9Ql7b8Q+8G+ZxwhaWl
         DMNzzQdvIM0VP/KkQnS8o+HYnZb+LMkOIBTB/9Co=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200207142341eucas1p2edddf016338d708e5ce3c9387853fd04~xJNB0m6xi3047530475eucas1p2N;
        Fri,  7 Feb 2020 14:23:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6F.CC.60679.DE27D3E5; Fri,  7
        Feb 2020 14:23:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142341eucas1p2568f155894fda450ad93a8580cee1004~xJNBlVSCU3048730487eucas1p2F;
        Fri,  7 Feb 2020 14:23:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142341eusmtrp10dea3c559480f77046436dcc4f5bbbaf~xJNBkuGt60248702487eusmtrp12;
        Fri,  7 Feb 2020 14:23:41 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-a3-5e3d72ed7ca5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.55.07950.DE27D3E5; Fri,  7
        Feb 2020 14:23:41 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142341eusmtip2b931264e03f990f91c43b2ea97f38eed~xJNBDa0ak2939329393eusmtip2D;
        Fri,  7 Feb 2020 14:23:41 +0000 (GMT)
Subject: Re: [PATCH 13/28] ata: move ata_do_link_spd_horkage() to
 libata-core-sata.c
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <7d7a21d5-3f0a-3c3f-2a23-ec490f5e0f8d@samsung.com>
Date:   Fri, 7 Feb 2020 15:23:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200129172811.GI12616@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7pvi2zjDGZcNLVYfbefzeLZrb1M
        FqcnLGKyOLbjEZPF5V1z2Czmtk5nd2Dz2DnrLrvH5hVaHpfPlnocOtzB6PF5k1wAaxSXTUpq
        TmZZapG+XQJXxsJ1M1gKzrFUXOjsZWlgvMvcxcjJISFgInFkxzzGLkYuDiGBFYwSKxbeZ4Nw
        vjBKHG34wAzhfGaU+N7+hQ2m5UF/IztEYjmjxNmvF5lAEkICbxkldq6sAbGFBcIkmia9ZQex
        RQQ0JW4tbwebxCywgVHi86QtjCAJNgEriYntq8BsXgE7iZ6PG8E2sAioSPx5+BpsqKhAhMSn
        B4dZIWoEJU7OfMICYnMKGEssfHALrJdZQFzi1pP5TBC2vMT2t3PAlkkILGOX6HpxCugKDiDH
        ReLaAh+ID4QlXh3fwg5hy0icntzDAlG/jlHib8cLqObtjBLLJ/+D+tla4s65X2wgg5iB3lm/
        Sx8i7CjxfcNsNoj5fBI33gpC3MAnMWnbdGaIMK9ER5sQRLWaxIZlG9hg1nbtXMk8gVFpFpLP
        ZiH5ZhaSb2Yh7F3AyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMO2c/nf8yw7GXX+S
        DjEKcDAq8fAmONrECbEmlhVX5h5ilOBgVhLh7VO1jRPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        a7zoZayQQHpiSWp2ampBahFMlomDU6qB0U9v75ziqI/yokdiDq/2cfh5Iurp3J5dW9qj2osy
        LB+++q3TLiPkEd+Ztzp4w0GpNa+dtS9d820V32L5wHNdNPf0e5wSnCIhu/w+8FiH/jMQtuzg
        FojJ+2a9TMHr6F4mE60QFwHV1wd9tv332XJe+1Vl0smufmbXzal2heFlEx/Hye7YXSKvxFKc
        kWioxVxUnAgAQWSxXjcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xe7pvi2zjDFovK1msvtvPZvHs1l4m
        i9MTFjFZHNvxiMni8q45bBZzW6ezO7B57Jx1l91j8wotj8tnSz0OHe5g9Pi8SS6ANUrPpii/
        tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY+G6GSwF51gq
        LnT2sjQw3mXuYuTkkBAwkXjQ38gOYgsJLGWUuPmNrYuRAyguI3F8fRlEibDEn2tdQGEuoJLX
        jBJbJy5iA0kIC4RJNE16C9YrIqApcWt5O9hMZoENjBLXvwhCNLxnlHh7/iwjSIJNwEpiYvsq
        MJtXwE6i5+NGsEEsAioSfx6+ZgKxRQUiJA7vmAVVIyhxcuYTFhCbU8BYYuGDW4wQC9Ql/sy7
        BLVMXOLWk/lMELa8xPa3c5gnMArNQtI+C0nLLCQts5C0LGBkWcUoklpanJueW2ykV5yYW1ya
        l66XnJ+7iREYZduO/dyyg7HrXfAhRgEORiUe3gRHmzgh1sSy4srcQ4wSHMxKIrx9qrZxQrwp
        iZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTAB5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNL
        UrNTUwtSi2D6mDg4pRoYZQ4GnBN08X7ikfPgzrJfHWoaj862bXfa3pDJkm+0UYmF386/1yAl
        7FFzxVFPreR2wc2P9svWFO27GPHlcPrtj5p9b/MeOO3l18tovnTrn2HM6qL3Bw+9ijkTeGln
        vnPUyq+13//369rlvDR5Ke31snILy80v2pffdom/iFRnFxC2n/7APfyYEktxRqKhFnNRcSIA
        rOWKHcgCAAA=
X-CMS-MailID: 20200207142341eucas1p2568f155894fda450ad93a8580cee1004
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133415eucas1p258c0d5c313e2ae42a05508b67eec16ef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133415eucas1p258c0d5c313e2ae42a05508b67eec16ef
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133415eucas1p258c0d5c313e2ae42a05508b67eec16ef@eucas1p2.samsung.com>
        <20200128133343.29905-14-b.zolnierkie@samsung.com>
        <20200129172811.GI12616@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/29/20 6:28 PM, Christoph Hellwig wrote:
> On Tue, Jan 28, 2020 at 02:33:28PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> * move ata_do_link_spd_horkage() to libata-core-sata.c
>>
>> * add static inline for CONFIG_SATA_HOST=n case
> 
> Wouldn't it make more sense to stub out sata_scr_valid for the !SATA
> case and just let the compiler optimize the function away now that it
> can't be called in that case?

I've reworked the code to use this approach in v2 of the patchset.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
