Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EB2C04EB5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9808621775
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SYJSZDfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBGOYC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:24:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48316 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBGOYC (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:24:02 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142401euoutp0201fab9d62491ef042f73d58623dab2d4~xJNTmhOaU2418224182euoutp02c
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:24:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142401euoutp0201fab9d62491ef042f73d58623dab2d4~xJNTmhOaU2418224182euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085441;
        bh=kzXvzaaZKFKXW+A1PV3LLFal6SH3Vd5TpUSGzTiqevE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SYJSZDfULIBp9lJdGRAoMoR995B+y1hIisrNwr5Y0yJzJUtT6C1n3tTmWCTfPa6bc
         /IscKkSfyOg8p/tuSNqfI7z3bvr6IIHauI9YO90IVk8xEK2bNqv+NYyHnRzYoZoEvU
         90O7GZGv4oSOirfQLYiFs5b03hQQBoLVwqpQczJA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142400eucas1p1becd24d2641a2e5ba786054805410b63~xJNTcgGTp2392123921eucas1p1G;
        Fri,  7 Feb 2020 14:24:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 81.58.60698.0037D3E5; Fri,  7
        Feb 2020 14:24:00 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142400eucas1p118d3ee3ba0dc81b41b1eb737255b917a~xJNTITKKo2394323943eucas1p10;
        Fri,  7 Feb 2020 14:24:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142400eusmtrp1edea7f1223177c26896bc87d88105051~xJNTHd9RB0248602486eusmtrp1Y;
        Fri,  7 Feb 2020 14:24:00 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-39-5e3d7300e47d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 96.65.07950.0037D3E5; Fri,  7
        Feb 2020 14:24:00 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142400eusmtip163a2ea46c988e122947f284484ec94dc~xJNSueHGJ0074100741eusmtip1P;
        Fri,  7 Feb 2020 14:24:00 +0000 (GMT)
Subject: Re: [PATCH 14/28] ata: move ata_dev_config_ncq*() to
 libata-core-sata.c
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <cc3b7968-368f-554f-d12f-e53e4858bc98@samsung.com>
Date:   Fri, 7 Feb 2020 15:23:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200129172944.GJ12616@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djP87oMxbZxBpPO6VusvtvPZvHs1l4m
        i9MTFjFZHNvxiMni8q45bBZzW6ezO7B57Jx1l91j8wotj8tnSz0OHe5g9Pi8SS6ANYrLJiU1
        J7MstUjfLoEro2vNFLaCNawVy6+lNDCuZ+li5OCQEDCRmNwY28XIxSEksIJR4vmqC4wQzhdG
        iaN3l0A5nxklFm+ZzNbFyAnWcWXtDVaIxHJGiRcvj0JVvWWUmNLxmgmkSlggSOLHv15GEFtE
        QFPi1vJ2ZpAiZoENjBKfJ20BS7AJWElMbF8FZvMK2EkcvH6YHcRmEVCRWHB1AwuILSoQIfHp
        wWFWiBpBiZMzn4DFOQWMJdZ/mwDWyywgLnHryXwmCFteYvvbOWDLJASWsUucOHUH6m4XifOT
        djFC2MISr45vYYewZSROT+5hgWhYxyjxt+MFVPd2Ronlk/9BdVtL3Dn3iw0UZsxA/6zfpQ8R
        dpTYfecBKyQo+SRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auZJ5AqPSLCSvzULy
        ziwk78xC2LuAkWUVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYNo5/e/41x2M+/4kHWIU
        4GBU4uFNcLSJE2JNLCuuzD3EKMHBrCTC26dqGyfEm5JYWZValB9fVJqTWnyIUZqDRUmc13jR
        y1ghgfTEktTs1NSC1CKYLBMHp1QD4wyOsh0yVz17j3Btl1vKJvy+atuFB983b42wZs7f8+nr
        rWzdjNMFVT62l61v6pta+7yLzDnAI+wdZnqrZdpG0bkOLDpXflgZPsytj2bZwrdi7yejydHP
        dBmelS9+LVdoYZjhcm6RZ97i6I4Fv9v1liZJKFhoGSzk3aK803XSr0m3ExOWu+wRUmIpzkg0
        1GIuKk4EAC4zyXw3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7oMxbZxBt/WSFisvtvPZvHs1l4m
        i9MTFjFZHNvxiMni8q45bBZzW6ezO7B57Jx1l91j8wotj8tnSz0OHe5g9Pi8SS6ANUrPpii/
        tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvo2vNFLaCNawV
        y6+lNDCuZ+li5OSQEDCRuLL2BmsXIxeHkMBSRolTrffYuxg5gBIyEsfXl0HUCEv8udbFBlHz
        mlFi3eXHrCAJYYEgiR//ehlBbBEBTYlby9uZQWxmgQ2MEte/CEI0vGeU6P3yD6yITcBKYmL7
        KjCbV8BO4uD1w+wgNouAisSCqxvALhIViJA4vGMWVI2gxMmZT8DinALGEuu/TWCEWKAu8Wfe
        Jahl4hK3nsxngrDlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLS
        vHS95PzcTYzAKNt27OeWHYxd74IPMQpwMCrx8CY42sQJsSaWFVfmHmKU4GBWEuHtU7WNE+JN
        SaysSi3Kjy8qzUktPsRoCvTcRGYp0eR8YALIK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5Y
        kpqdmlqQWgTTx8TBKdXA2PTW6eCE5ICX7ysOXLWQrLetYV4x5ZvQGg7R+s0vc9Ji5nCU3Nve
        6HLXqr5Dbsqc2qjW89HLXq+yvPgipTWl13Nf/MlXWj65P7+sX9MbpLjzsCHr5kSlNTOWt7BO
        37BjS5vjWpV1/8pc4qOtl6zgdZ/hajDh8KMDRh5xx32mvi5aO+fuXv3GLUosxRmJhlrMRcWJ
        APCA6anIAgAA
X-CMS-MailID: 20200207142400eucas1p118d3ee3ba0dc81b41b1eb737255b917a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133415eucas1p1cd35ec3ee9783b76c1a32de63796ce30
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133415eucas1p1cd35ec3ee9783b76c1a32de63796ce30
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133415eucas1p1cd35ec3ee9783b76c1a32de63796ce30@eucas1p1.samsung.com>
        <20200128133343.29905-15-b.zolnierkie@samsung.com>
        <20200129172944.GJ12616@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/29/20 6:29 PM, Christoph Hellwig wrote:
> On Tue, Jan 28, 2020 at 02:33:29PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> * move ata_log_supported() to libata.h and make it inline
>>
>> * move ata_dev_config_ncq*() to libata-core-sata.c
>>
>> * add static inline version of ata_dev_config_ncq() for
>>   CONFIG_SATA_HOST=n case
> 
> Wouldn't it be easier to throw in an IS_ENABLED() into the
> ATA_FLAG_FPDMA_AUX before calling ata_dev_config_ncq_* and let the
> compiler optimize out the functions?

I've reworked the code to use this approach in v2 of the patchset.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
