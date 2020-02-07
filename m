Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7ADC04EB5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581BF20838
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hLr3EvHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgBGOU4 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:20:56 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47135 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGOUz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:20:55 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142054euoutp021612f9817a2c572e3783464c60bf69b4~xJKmCpzd82175121751euoutp02I
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:20:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142054euoutp021612f9817a2c572e3783464c60bf69b4~xJKmCpzd82175121751euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085254;
        bh=dR3sQIWJZT3k7BrytsuRU5pTs/CqzFfpXSNMjU/Mpj0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hLr3EvHfjJIPAHs2n7uFcspK2dPIa4158LhUjz8MyoeGoUkdf5CG7y6Ap0B1m7fIM
         ZqcVbPo18vf9kxSMoYjbDDKp7niWpR4QTcIjqL7aYbLeR5S3Dffx/3K7BQqbmIReyf
         /vfymoKmXPycYiY1nA9wlo7QS7xu5a5oqgFkhmLs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142054eucas1p1adfd95d9e820765af71276dd94b5dbe1~xJKlvF0O32372923729eucas1p1B;
        Fri,  7 Feb 2020 14:20:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C2.E7.60698.6427D3E5; Fri,  7
        Feb 2020 14:20:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142053eucas1p1d542476c0c6e6888ee67a3d42a0e9ce8~xJKlWKmHV2174321743eucas1p1H;
        Fri,  7 Feb 2020 14:20:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142053eusmtrp1f2d37298d427a82198577cb0dea93d7b~xJKlViRaM0078900789eusmtrp14;
        Fri,  7 Feb 2020 14:20:53 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-04-5e3d7246e476
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1C.A8.08375.5427D3E5; Fri,  7
        Feb 2020 14:20:53 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142053eusmtip17d0bb2be84a672da9befdf0147b27e8f~xJKkw94tz2633926339eusmtip15;
        Fri,  7 Feb 2020 14:20:53 +0000 (GMT)
Subject: Re: [PATCH 10/28] ata: separate PATA timings code from
 libata-core.c
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <47876d63-4cf2-49dc-6d7a-8a3d82ee6ee7@samsung.com>
Date:   Fri, 7 Feb 2020 15:20:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200129172323.GF12616@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87puRbZxBl8n81qsvtvPZvHs1l4m
        i9MTFjFZHNvxiMni8q45bBZzW6ezO7B57Jx1l91j8wotj8tnSz0OHe5g9Pi8SS6ANYrLJiU1
        J7MstUjfLoEr48r/hawFBwQrpt+7ztzA+Iq3i5GTQ0LAROLtmd1sXYxcHEICKxglWv/+ZYFw
        vjBKfNm1HirzmVHi5dS77DAtu99cZ4dILGeUWDr9N1TLW0aJW3+OMIJUCQv4S0xfdg+sQ0RA
        U+LW8nZmkCJmgQ2MEp8nbQErYhOwkpjYvgrM5hWwk5i0/jtYA4uAikTv4blgtqhAhMSnB4dZ
        IWoEJU7OfMICYnMKGEus/bKVGcRmFhCXuPVkPhOELS+x/e0csGUSAsvYJWZ9nsoIcbeLRMv7
        zSwQtrDEq+NboP6RkTg9uYcFomEdo8TfjhdQ3dsZJZZP/scGUWUtcefcLyCbA2iFpsT6XfoQ
        YUeJrm0LWUDCEgJ8EjfeCkIcwScxadt0Zogwr0RHmxBEtZrEhmUb2GDWdu1cyTyBUWkWktdm
        IXlnFpJ3ZiHsXcDIsopRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw9Zz+d/zrDsZ9f5IO
        MQpwMCrx8CY42sQJsSaWFVfmHmKU4GBWEuHtU7WNE+JNSaysSi3Kjy8qzUktPsQozcGiJM5r
        vOhlrJBAemJJanZqakFqEUyWiYNTqoHRzkzany04bycTi02DXsmJDyzvD61LNjj6RPLJ0drp
        fp5r3ogb9F1/k9XZfvF/o8C285Fl+ZclT6Tn3jxzv3Di/ovrracxtweVa/BMEFwlzVCRquwV
        VLj22ZnsNJUdy7ufume/Ll688cf+W643JrtsmmExueuF0eHPLYL77vSJPjgUcugfv/8fJZbi
        jERDLeai4kQAOAXrBTkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xu7quRbZxBrsbjC1W3+1ns3h2ay+T
        xekJi5gsju14xGRxedccNou5rdPZHdg8ds66y+6xeYWWx+WzpR6HDncwenzeJBfAGqVnU5Rf
        WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXceX/QtaCA4IV
        0+9dZ25gfMXbxcjJISFgIrH7zXX2LkYuDiGBpYwSF2f9B3I4gBIyEsfXl0HUCEv8udbFBlHz
        mlFi0oFdLCAJYQFfiTPXrjOC2CICmhK3lrczg9jMAhsYJa5/EYRoeM8ocXPZUnaQBJuAlcTE
        9lVgDbwCdhKT1n8Hi7MIqEj0Hp4LZosKREgc3jELqkZQ4uTMJ2DLOAWMJdZ+2Qq1QF3iz7xL
        ULa4xK0n85kgbHmJ7W/nME9gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQv
        XS85P3cTIzDOth37uXkH46WNwYcYBTgYlXh4Exxt4oRYE8uKK3MPMUpwMCuJ8Pap2sYJ8aYk
        VlalFuXHF5XmpBYfYjQFem4is5Rocj4wBeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJ
        zU5NLUgtgulj4uCUamAMvvJjqVi79qd3Ktk15kL/p23dFysYODex1akjNCzW/y7vlLXTZuuZ
        7tdZIrtPK31V+aL89SsL7qz5OZmzXc3H+P7ZsGPS6QcvNptpXO+foNR4J6DP/k+aZsBR3krm
        //by7Rf/Vc7btiz7/fM1+UffVHGwSx9fFvu8i3ORsfRTE6NUwb8H7gUrsRRnJBpqMRcVJwIA
        9WeoaMkCAAA=
X-CMS-MailID: 20200207142053eucas1p1d542476c0c6e6888ee67a3d42a0e9ce8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133414eucas1p14b041a2d58ca70817f3007c0f405ee73
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133414eucas1p14b041a2d58ca70817f3007c0f405ee73
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133414eucas1p14b041a2d58ca70817f3007c0f405ee73@eucas1p1.samsung.com>
        <20200128133343.29905-11-b.zolnierkie@samsung.com>
        <20200129172323.GF12616@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/29/20 6:23 PM, Christoph Hellwig wrote:
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + *  libata-pata-timings.c - helper library for PATA timings
> 
> Please remove the file name from the top of the file header.
> 
>> +static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q, int T, int UT)
>> +{
> 
>> +void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
>> +		      struct ata_timing *m, unsigned int what)
>> +{
> 
> Please fix the overly long lines while you're at it.
> 
>> +	if (what & ATA_TIMING_SETUP  ) m->setup   = max(a->setup,   b->setup);
>> +	if (what & ATA_TIMING_ACT8B  ) m->act8b   = max(a->act8b,   b->act8b);
>> +	if (what & ATA_TIMING_REC8B  ) m->rec8b   = max(a->rec8b,   b->rec8b);
>> +	if (what & ATA_TIMING_CYC8B  ) m->cyc8b   = max(a->cyc8b,   b->cyc8b);
>> +	if (what & ATA_TIMING_ACTIVE ) m->active  = max(a->active,  b->active);
>> +	if (what & ATA_TIMING_RECOVER) m->recover = max(a->recover, b->recover);
>> +	if (what & ATA_TIMING_DMACK_HOLD) m->dmack_hold = max(a->dmack_hold, b->dmack_hold);
>> +	if (what & ATA_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
>> +	if (what & ATA_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
> 
> and this very strange coding style.
> 
>> +	if (!(s = ata_timing_find_mode(speed)))
>> +		return -EINVAL;
> 
> This should be:
> 
> 	s = ata_timing_find_mode(speed);
> 	if (!s)
> 		return -EINVAL;
> 
>> +	/* In a few cases quantisation may produce enough errors to
>> +	   leave t->cycle too low for the sum of active and recovery
>> +	   if so we must correct this */
> 
> .. non-standard comment style here.

I've added additional patch in v2 version of the patchset fixing
above CodingStyle issues in PATA timings code in libata-core.c
(just before the code gets separated to libata-pata-timings.c).

>> +#ifdef CONFIG_ATA_ACPI
>>  extern u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle);
>> +#endif
> 
> I don't think we need this ifdef - unused prototypes are completely
> harmless.

Fixed in v2 version of the patch.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
