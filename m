Return-Path: <SRS0=o0wv=U7=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB0BC06511
	for <linux-ide@archiver.kernel.org>; Tue,  2 Jul 2019 12:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2AC206E0
	for <linux-ide@archiver.kernel.org>; Tue,  2 Jul 2019 12:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UkwlEkag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfGBMu5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:50:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43571 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfGBMuz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jul 2019 08:50:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190702125052euoutp017dc22f898e854ef3876430a61d0cda3c~tmBLb5jIw2595925959euoutp01U
        for <linux-ide@vger.kernel.org>; Tue,  2 Jul 2019 12:50:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190702125052euoutp017dc22f898e854ef3876430a61d0cda3c~tmBLb5jIw2595925959euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562071852;
        bh=YMWly/rpEzQItkM+aEx1ekjbFp1h4Rm9skbniLTzAgY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UkwlEkagIHuY9oYjbn/B6tTSYedXcYNoUkGH+k6qCVtoHe5aPOig69Cjvht0gI5LJ
         FTJNoc/NvXBgxfd/7Uh7ClvoVy0f0bJXVrKZrR53O68p0AlI+kGRmRKPgH4vhQ12fS
         1frstJudBw5JuTjBxtKQu6PFIJ71DzOC3Z4ifpe8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190702125051eucas1p16de8ce39afa5506589c3e30ab6ef85c8~tmBK4k2i22984429844eucas1p1z;
        Tue,  2 Jul 2019 12:50:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 53.DF.04298.B235B1D5; Tue,  2
        Jul 2019 13:50:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190702125051eucas1p19af4e8c809539a20ce9259723cfef18d~tmBKOmg-C2989229892eucas1p1w;
        Tue,  2 Jul 2019 12:50:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190702125051eusmtrp1599d86574364beb5fd6ba99dd2c33291~tmBKAlHOn1700317003eusmtrp16;
        Tue,  2 Jul 2019 12:50:51 +0000 (GMT)
X-AuditID: cbfec7f2-3615e9c0000010ca-7e-5d1b532bc8d7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E1.2A.04146.A235B1D5; Tue,  2
        Jul 2019 13:50:50 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190702125050eusmtip1e03111dceb9bc0f09d96153f54dcc798~tmBJszIX21162611626eusmtip1E;
        Tue,  2 Jul 2019 12:50:50 +0000 (GMT)
Subject: Re: [PATCH 1/2] m68k/atari: add platform device for Falcon IDE port
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org,
        geert@linux-m68k.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <89366005-c1f1-4a0c-9917-720bb9e9e100@samsung.com>
Date:   Tue, 2 Jul 2019 14:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1562018556-15090-2-git-send-email-schmitzmic@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsWy7djP87rawdKxBoc71S2e3drLZHFsxyMm
        i93v7zNazG2dzu7A4rFz1l12j0OHOxg9Pm+SC2CO4rJJSc3JLEst0rdL4MpofdPCXvCQuWLS
        z9msDYz9zF2MnBwSAiYS8y58BrK5OIQEVjBKbGifxArhfGGUmHdnNhOE85lRYn37PyaYlmk9
        l1kgEssZJTonHoRy3jJKTFm7kRGkSljAR2LuoclgS0QEtCTO3zwPFOfgYBYIlPi1IwkkzCZg
        JTGxfRVYOa+AnUTHpSVg5SwCKhJfX+9mAbFFBSIk7h/bwApRIyhxcuYTFpAxnAKuElemgrUy
        C4hL3HoynwnClpfY/nYO2DsSAt3sEufedrJAHO0iceHxZ3YIW1ji1fEtULaMxOnJPSwQDesY
        Jf52vIDq3s4osXzyPzaIKmuJw8cvskI8oCmxfpc+RNhR4tyiO0wgYQkBPokbbwUhjuCTmLRt
        OjNEmFeio00IolpNYsOyDWwwa7t2rmSewKg0C8lns5C8MwvJO7MQ9i5gZFnFKJ5aWpybnlps
        mJdarlecmFtcmpeul5yfu4kRmFBO/zv+aQfj10tJhxgFOBiVeHgXBEjHCrEmlhVX5h5ilOBg
        VhLh3b9CMlaINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QD
        I/vavOrw1fnvDS5bzdppFK5vu/6HkIDZoUdHa5MFJr+a/0tdctOsDXNZ24xYD0Q0JQed2hPs
        UPxSOcnQeFlw0N3TFXvaF7Pq+AsYz328QZArKipErfX/mwg/56s7/ATTz/P2CZT8SzqtU94W
        s27Hypkb6vv+fNd7syBO+dMLvvWL+17XnWTkVmIpzkg01GIuKk4EANl2vdckAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsVy+t/xu7pawdKxBrvumls8u7WXyeLYjkdM
        Frvf32e0mNs6nd2BxWPnrLvsHocOdzB6fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfR+qaFveAhc8Wkn7NZGxj7mbsYOTkkBEwkpvVc
        Zuli5OIQEljKKPHgzkPGLkYOoISMxPH1ZRA1whJ/rnWxQdS8ZpSY29DKApIQFvCRmHtoMtgg
        EQEtifM3zzOC2MwCgRL3zu5nh2i4zCgxtWsWWIJNwEpiYvsqMJtXwE6i49ISsGYWARWJr693
        gw0VFYiQOPN+BQtEjaDEyZlPWEAO4hRwlbgyFWq+usSfeZeYIWxxiVtP5jNB2PIS29/OYZ7A
        KDQLSfcsJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmAEbTv2c/MOxksb
        gw8xCnAwKvHw3uCSihViTSwrrsw9xCjBwawkwrt/hWSsEG9KYmVValF+fFFpTmrxIUZToN8m
        MkuJJucDozuvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVAOj/6E4
        xtwS7k1qDueqTI4fCz7NqeToo+l3IOD3l3fLAz8lGicWcf1qql262MUyzSPs4LzX++a97hRY
        3WzXvFtkzqXIfSvO7+JR/3HU7fh12ZnCRswWthZ77Cu3a8kv/zFdvkC09MVZzZXiE1qvP7l+
        j+3NwmtbE7rulOx+/PD1Gf/F2w/1bwoJVmIpzkg01GIuKk4EAAQ+6am2AgAA
X-CMS-MailID: 20190702125051eucas1p19af4e8c809539a20ce9259723cfef18d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190701220245epcas1p1cfe99fd976e41b00ce0f25462a30453c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190701220245epcas1p1cfe99fd976e41b00ce0f25462a30453c
References: <1562018556-15090-1-git-send-email-schmitzmic@gmail.com>
        <CGME20190701220245epcas1p1cfe99fd976e41b00ce0f25462a30453c@epcas1p1.samsung.com>
        <1562018556-15090-2-git-send-email-schmitzmic@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 7/2/19 12:02 AM, Michael Schmitz wrote:
> Autoloading of Falcon IDE driver modules requires converting
> these drivers to platform drivers.
> 
> Add platform device for Falcon IDE interface in Atari platform
> setup code in preparation for this.
> 
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
