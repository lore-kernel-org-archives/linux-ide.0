Return-Path: <SRS0=o0wv=U7=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2753DC06510
	for <linux-ide@archiver.kernel.org>; Tue,  2 Jul 2019 12:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D92206E0
	for <linux-ide@archiver.kernel.org>; Tue,  2 Jul 2019 12:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SW0DJVcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGBMvU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:51:20 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34316 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfGBMvU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jul 2019 08:51:20 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190702125118euoutp0227548ceba95f1fb0d56baa6e7ed2996a~tmBj_MVAO0282702827euoutp02k
        for <linux-ide@vger.kernel.org>; Tue,  2 Jul 2019 12:51:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190702125118euoutp0227548ceba95f1fb0d56baa6e7ed2996a~tmBj_MVAO0282702827euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562071878;
        bh=2KwshvQUGs+DNPCaavSPATqMfOGHQTjo65uEEtiq4+s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SW0DJVcRNEiI/YWyZSsKdoWMzJ4qUEIX3MIyslYxpYnwEZla14Iqmibu4Vw0Az7Fq
         iuOlLveC7SwKa6bb9br9qXZSc7nn02K8/SCA0zas7X6Xxds7JeUsv8x1ZKdDgUtaTs
         Rt5/6tioKmlf3MS2tfVpHWj1axxjA5HLK3uS5W1E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190702125118eucas1p135421385fa8c9f05f33598c663d3d4af~tmBjkon1L2337323373eucas1p1d;
        Tue,  2 Jul 2019 12:51:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C0.EF.04298.6435B1D5; Tue,  2
        Jul 2019 13:51:18 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190702125117eucas1p25a1f877a0aff5e0cd36e0b032bee2cc4~tmBi3c6rb1788417884eucas1p21;
        Tue,  2 Jul 2019 12:51:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190702125117eusmtrp1c7e3eb5eee9c6ab82500955e5349df16~tmBipYuCm1700317003eusmtrp1k;
        Tue,  2 Jul 2019 12:51:17 +0000 (GMT)
X-AuditID: cbfec7f2-f13ff700000010ca-c4-5d1b5346372b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9C.2A.04146.5435B1D5; Tue,  2
        Jul 2019 13:51:17 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190702125117eusmtip2821569490a389c7301362640b8b53f36~tmBiaU3QB1024510245eusmtip2I;
        Tue,  2 Jul 2019 12:51:17 +0000 (GMT)
Subject: Re: [PATCH 2/2] drivers/ata: convert pata_falcon to arch platform
 device
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org,
        geert@linux-m68k.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <69dd2d85-c9f2-23b9-b45c-34147e4dab86@samsung.com>
Date:   Tue, 2 Jul 2019 14:51:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1562018556-15090-3-git-send-email-schmitzmic@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djPc7puwdKxBs2rOCye3drLZHFsxyMm
        i93v7zNazG2dzu7A4rFz1l12j0OHOxg9Pm+SC2CO4rJJSc3JLEst0rdL4Mr4s2oye8E55oo/
        R/vZGxj/MXUxcnJICJhILJr1jLWLkYtDSGAFo0Tjgr0sEM4XRolHV96wQzifGSXe/roHlOEA
        a3m7EapjOaPEpx/XGCGct0DOuwMsIHOFBYIlJpxrYQWxRQS0JM7fPM8I0swsECjxa0cSSJhN
        wEpiYvsqRhCbV8BO4vqck2wgNouAisSnI9fBbFGBCIn7xzawQtQISpyc+QTsBk4BV4krL6VB
        wswC4hK3nsxngrDlJba/ncMMco6EQDe7xJ9T99kg3nSROH3rGJQtLPHq+BZ2CFtG4vTkHhaI
        hnWMEn87XkB1b2eUWD75H1SHtcTh4xdZIR7QlFi/Sx8i7Chx8d9iNkig8EnceCsIcQSfxKRt
        05khwrwSHW1CENVqEhuWbWCDWdu1cyXzBEalWUg+m4XknVlI3pmFsHcBI8sqRvHU0uLc9NRi
        w7zUcr3ixNzi0rx0veT83E2MwHRy+t/xTzsYv15KOsQowMGoxMO7IEA6Vog1say4MvcQowQH
        s5II7/4VkrFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRmp6YWpBbBZJk4OKUa
        GPdN1Zcod31SLcumeuyPFtNJc2aW/tLaZfc9JzXPnf8ssrBezOvEusyC4LzUA/KtG3796rt/
        gLtNrDXjbWDHyntXdcvLwzqmPphdrDp1E3+wupLhW+/fXFOUC4xE7a6Wuydb/GQ/L84Zt4/f
        xI3JQ1dKof9YEZ/3g9LsG0s92OOertp9TEFUiaU4I9FQi7moOBEAsieDzSMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7quwdKxBt/uSFo8u7WXyeLYjkdM
        Frvf32e0mNs6nd2BxWPnrLvsHocOdzB6fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfxZ9Vk9oJzzBV/jvazNzD+Y+pi5OCQEDCReLuR
        tYuRk0NIYCmjxL2VNRBhGYnj68tAwhICwhJ/rnWxdTFyAZW8ZpT43v6TBSQhLBAsMeFcC1iv
        iICWxPmb5xlBbGaBQIl7Z/ezQzRcZpSY//UQWAObgJXExPZVYEW8AnYS1+ecZAOxWQRUJD4d
        uQ5miwpESJx5v4IFokZQ4uTMJywgB3EKuEpceSkNMV9d4s+8S8wQtrjErSfzmSBseYntb+cw
        T2AUmoWkexaSlllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMHq2Hfu5eQfj
        pY3BhxgFOBiVeHhvcEnFCrEmlhVX5h5ilOBgVhLh3b9CMlaINyWxsiq1KD++qDQntfgQoynQ
        bxOZpUST84GRnVcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgTGr
        LO/l/MprBloyy/Uy/QyZTWTm6MoXvGHiUq3uvHr5iH2ZZswEH8XqTY//ZfD/f54svuQCx9qH
        fYKujkHOuavn9Lhq7yrZqvgsmdkt73HsKh5+7+dvGA7kX1tQHX7I5enuf7qayQxumVWX/knW
        Fq27dvp99pt6p4iLNR+0HaV0Jd7qFW7MVmIpzkg01GIuKk4EAMZ8TIS0AgAA
X-CMS-MailID: 20190702125117eucas1p25a1f877a0aff5e0cd36e0b032bee2cc4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701220246epcas1p42cecbc46cefc19b3c7b0bf05c769486c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701220246epcas1p42cecbc46cefc19b3c7b0bf05c769486c
References: <1562018556-15090-1-git-send-email-schmitzmic@gmail.com>
        <CGME20190701220246epcas1p42cecbc46cefc19b3c7b0bf05c769486c@epcas1p4.samsung.com>
        <1562018556-15090-3-git-send-email-schmitzmic@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 7/2/19 12:02 AM, Michael Schmitz wrote:
> The Atari platform device setup now provides a platform device
> for the Falcon IDE interface. Use this in place of the simple platform
> device set up in the old pata_falcon probe code.
> 
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
