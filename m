Return-Path: <SRS0=H5qQ=3K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A88C2D0CE
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 11:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881772253D
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 11:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vIvqxVcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgAULP6 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:15:58 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56717 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgAULP5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jan 2020 06:15:57 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200121111556euoutp02e49c6d5e8e8e53ae24e4257594697965~r4rPQYYMe2551625516euoutp02h
        for <linux-ide@vger.kernel.org>; Tue, 21 Jan 2020 11:15:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200121111556euoutp02e49c6d5e8e8e53ae24e4257594697965~r4rPQYYMe2551625516euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579605356;
        bh=2bIprW/XSQCnFLkBpxHfjhjK6WmZE+gf/GzHixro6bE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vIvqxVcbciww/PNl9NJutcZN84L4vN0U/jbhuVIqali2NLNAnN5hG6dqI1GPXqzAl
         zxgUej/WDe9Xc1SbLxeV279C6jJFhxS9OXofA0C4g8p9cbB8DhvxY25qOLNoAa2g28
         AiKzZ9fdUO23fP2cDfjLNHHKlypZc9P2+4GNy+jg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200121111556eucas1p1bd67d770681608e10dd349d9409e530c~r4rPEg91R0545805458eucas1p1p;
        Tue, 21 Jan 2020 11:15:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E6.3F.60679.B6DD62E5; Tue, 21
        Jan 2020 11:15:56 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200121111555eucas1p2d26b5230ab428f40ee3fc76d687e601f~r4rOn9nsi0745607456eucas1p2d;
        Tue, 21 Jan 2020 11:15:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200121111555eusmtrp2d3de407074171807ce2b0e3290fa4c42~r4rOnXSDA0794607946eusmtrp2o;
        Tue, 21 Jan 2020 11:15:55 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-42-5e26dd6b327f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.F9.08375.B6DD62E5; Tue, 21
        Jan 2020 11:15:55 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200121111555eusmtip12f2e3f0ed3e23baa700e75069a8673f6~r4rOQb4pc0248902489eusmtip1N;
        Tue, 21 Jan 2020 11:15:55 +0000 (GMT)
Subject: Re: Re: [PATCH 1/2] cmd64x: potential buffer overflow in
 cmd64x_program_timings()
To:     David Miller <davem@davemloft.net>, dan.carpenter@oracle.com
Cc:     linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <faf4b367-29b3-474c-73bc-400f6ab36758@samsung.com>
Date:   Tue, 21 Jan 2020 12:15:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200120.144042.1810086369376110530.davem@davemloft.net>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd2cu2pxBm0mFq//TWexmHO+hcVi
        6y1pi2M7HjE5sHhsWXmTyePj01ssHp83yQUwR3HZpKTmZJalFunbJXBlXN5YXDCFteJF4wLW
        BsZOli5GDg4JAROJyc/quhi5OIQEVjBK7J87nRXC+cIo0fr8IDuE85lR4tuFXqAMJ1jHyQPX
        mSESyxklps2YxgThvGWUuPv+KyNIlbBAjMTNda2sIDtEBBwkTk/xBwkzC9hJ7Ln1CmwQm4CV
        xMT2VWDlvEDxLcvOMIKUswioSlzaagQSFhWIkPj04DArRImgxMmZT1hAbE4BN4mWZXfZIEaK
        S9x6Mp8JwpaX2P52DthtEgLt7BKzn+xlg3jTReLfzkSI+4UlXh3fwg5hy0j83zmfCaJ+HaPE
        344XUM3bGSWWT/7HBlFlLXHn3C+wQcwCmhLrd+lDhB0ljv04Ag1GPokbbwUhbuCTmLRtOjNE
        mFeio00IolpNYsOyDWwwa7t2rmSewKg0C8lns5B8MwvJN7MQ9i5gZFnFKJ5aWpybnlpslJda
        rlecmFtcmpeul5yfu4kRmEZO/zv+ZQfjrj9JhxgFOBiVeHhfTFaNE2JNLCuuzD3EKMHBrCTC
        u6AJKMSbklhZlVqUH19UmpNafIhRmoNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVANj3v+y
        33Zz/pb8l+rRz1j8T1niRUsVk2dUslTskQdGW3gSz7m4nlmVtJLjwvqc0JaejHm3PuYsUbpb
        6DBr+y6uwraQhSG2eYt5L2gERnzPulXTu8O0/pd1nGdD/KFbCwTk2rICfzEKPZ0pnuHE/dTk
        bMObl1GzRNfn6Kd+8I5+WLV4tZJl9k4lluKMREMt5qLiRADkoHwwHwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7rZd9XiDN42yVm8/jedxWLO+RYW
        i623pC2O7XjE5MDisWXlTSaPj09vsXh83iQXwBylZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdk
        YqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3F5Y3HBFNaKF40LWBsYO1m6GDk5JARMJE4euM7c
        xcjFISSwlFFi9e49jF2MHEAJGYnj68sgaoQl/lzrYoOoec0oMXvbIlaQhLBAjMTNda2sIPUi
        Ag4Sp6f4g4SZBewk9tx6BVYiJFAuMXl7DxuIzSZgJTGxfRUjiM0LVLNl2RmwVSwCqhKXthqB
        hEUFIiQO75gFVSIocXLmE7AzOQXcJFqW3WWDGK8u8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAK
        zULSPgtJyywkLbOQtCxgZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGDnbjv3cvIPx0sbg
        Q4wCHIxKPLwO01TjhFgTy4orcw8xSnAwK4nwLmgCCvGmJFZWpRblxxeV5qQWH2I0BfptIrOU
        aHI+MKrzSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeWpGanphakFsH0MXFwSjUw6nRequJ5
        +uzM9ot3lh/j57A94HxEhyf8yTmf6g2b91578imDzeX5prk5F2W274j9PnNFaFLubnMvw6eb
        N16T5/nkdayMacfm5PI/LvpXDLVunk847zhnQSVneMWvyoorsf8Offjh45u79+mK2Z5TzprK
        C9s1T2VirTA6qmzWa8TvePlZIrehsxJLcUaioRZzUXEiAIfJNsayAgAA
X-CMS-MailID: 20200121111555eucas1p2d26b5230ab428f40ee3fc76d687e601f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200121111555eucas1p2d26b5230ab428f40ee3fc76d687e601f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200121111555eucas1p2d26b5230ab428f40ee3fc76d687e601f
References: <20200107130441.y3owvcnxdljailt5@kili.mountain>
        <20200120.144042.1810086369376110530.davem@davemloft.net>
        <CGME20200121111555eucas1p2d26b5230ab428f40ee3fc76d687e601f@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Hi,

On 1/20/20 2:40 PM, David Miller wrote:
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Date: Tue, 7 Jan 2020 16:04:41 +0300
> 
>> The "drive->dn" value is a u8 and it is controlled by root only, but
>> it could be out of bounds here so let's check.

drive->dn should not be root controllable, please point me where it
happens as this may need fixing instead of cmd64x driver.

[ IDE core makes sure that drive->dn is never > 3 and a lot of code
  assumes it. ]

>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Applied. 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
