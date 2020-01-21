Return-Path: <SRS0=H5qQ=3K=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58604C2D0CE
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 12:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EA224653
	for <linux-ide@archiver.kernel.org>; Tue, 21 Jan 2020 12:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nXc4RAcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgAUMiW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:38:22 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59621 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgAUMiW (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jan 2020 07:38:22 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200121123820euoutp022ec46a24c1886f20db0e994acf45d573~r5zLkSzdE1562515625euoutp022
        for <linux-ide@vger.kernel.org>; Tue, 21 Jan 2020 12:38:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200121123820euoutp022ec46a24c1886f20db0e994acf45d573~r5zLkSzdE1562515625euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579610300;
        bh=xICQcTnLcwdxKXEbOp8NFjGBBasnC0HWI2BTeILdE2Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nXc4RAcHvM9vLUn9DZLAy/Es1+hpZcir+050mZ3wyEdg/omK5nfpDsPJnnY0+KI+h
         RBlPV/05bWVnI5qYJ7Knozr3Li3wsVlg6TET9vSbRdow28YSAk4cz6fUnUilomjhTr
         Y3a4NQGG2i+uEk+ILAO5tmLoIK3fAoaI2ddy9jMw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200121123819eucas1p287800929e1f47ce10676c1a73dee3779~r5zLdhL213088830888eucas1p2H;
        Tue, 21 Jan 2020 12:38:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7D.A5.61286.BB0F62E5; Tue, 21
        Jan 2020 12:38:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200121123819eucas1p280efcc72a1c27e5ed42e8c73d24c19dd~r5zLIdnHS3143231432eucas1p2D;
        Tue, 21 Jan 2020 12:38:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200121123819eusmtrp14a12486df848c6fd465851425a46cc88~r5zLH5VOk0094200942eusmtrp1i;
        Tue, 21 Jan 2020 12:38:19 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-48-5e26f0bb4ca2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9C.C4.07950.BB0F62E5; Tue, 21
        Jan 2020 12:38:19 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200121123819eusmtip1d8b0937340657e0b0a5e5aea4c754d53~r5zK1rkG92316223162eusmtip1C;
        Tue, 21 Jan 2020 12:38:19 +0000 (GMT)
Subject: Re: [PATCH 1/2] cmd64x: potential buffer overflow in
 cmd64x_program_timings()
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Message-ID: <89d856ef-7c00-a2b7-bfcc-483c78092d20@samsung.com>
Date:   Tue, 21 Jan 2020 13:38:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <02ea0fe7-fedd-66ac-ac60-0cdcb8802076@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduzned3dH9TiDGb3W1i8/jedxWLO+RYW
        i623pC2O7XjE5MDisWXlTSaPj09vsXh83iQXwBzFZZOSmpNZllqkb5fAlTH/cEDBUe6K+/f3
        MzUw/uXoYuTkkBAwkfh2ZRETiC0ksIJR4tOC1C5GLiD7C6PE7NmrmCGcz4wSd57dYOti5ADr
        6H2ZCxFfziix7/NlRgjnLaNE0+037CCjhAUiJGZd2M0GYrMJWElMbF/FCGKLCOhIXO78AVbD
        LJAiMfHGNFYQm1fATuLKl1Z2kAUsAqoSJ6dbgoRFgcZ8enAYqkRQ4uTMJywgNqeAvUTbrw5G
        iDHiEreezGeCsOUltr+dA3a0hEA3u8T301eYId50kbjStokNwhaWeHV8CzuELSNxenIPC0TD
        OkaJvx0voLq3M0osn/wPqsNa4s65X2DvMwtoSqzfpQ8RdpQ49uMICyRU+CRuvBWEOIJPYtK2
        6cwQYV6JjjYhiGo1iQ3LNrDBrO3auZJ5AqPSLCSvzULyziwk78xC2LuAkWUVo3hqaXFuemqx
        YV5quV5xYm5xaV66XnJ+7iZGYCo5/e/4px2MXy8lHWIU4GBU4uHNeKoWJ8SaWFZcmXuIUYKD
        WUmEd0GTapwQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFIN
        jMsnfpiU/PDejMhe/xWSZ1fwMcQxWU9k3VSzbOG2eQsdDaUfyz27FpFqcd/tFs+bHbNYZlT8
        6ss3nLZMYsIaX6OlcTcNthxSq0v4MHPN66z+RenZaYdX/v8gaJ88b3Lee1fb358+eTues56q
        9rH949N795hj522xST+VOs8uo9T4jk+Jwr41ir1KLMUZiYZazEXFiQA+yvlIIQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7q7P6jFGTy/I2/x+t90Fos551tY
        LLbekrY4tuMRkwOLx5aVN5k8Pj69xeLxeZNcAHOUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6R
        iaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsb8wwEFR7kr7t/fz9TA+Jeji5GDQ0LARKL3ZW4X
        IxeHkMBSRonr1/6wQsRlJI6vL+ti5AQyhSX+XOtig6h5zSjxbftZdpCEsECExKwLu9lAbDYB
        K4mJ7asYQWwRAR2Jy50/wGqYBVIkpl2eC1YjJHCVSWLpaVsQm1fATuLKl1Z2kF0sAqoSJ6db
        goRFgUYe3jGLEaJEUOLkzCcsIDangL1E268ORoiR6hJ/5l1ihrDFJW49mc8EYctLbH87h3kC
        o9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGRs+3Yzy07GLve
        BR9iFOBgVOLhzXiqFifEmlhWXJl7iFGCg1lJhHdBk2qcEG9KYmVValF+fFFpTmrxIUZToN8m
        MkuJJucDozqvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFqEUwfEwenVANjFcsK
        lV7229E7e9UTC72brx/d+9IsbZXrrr1WPClflq2XEty/UeK27O69r9bKSGnWTHNIF7yU5hCi
        nyuXsWfyglXOPikf+/9/azlnGGAqk1Bzl9MruUD1bZWrZPnfWYYzk0W8YkVdqm9Vdn3n1zP2
        XazxwDjpZ7N31+PbyfULdKbHXayN2qDEUpyRaKjFXFScCACyjvr4sgIAAA==
X-CMS-MailID: 20200121123819eucas1p280efcc72a1c27e5ed42e8c73d24c19dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200121111555eucas1p2d26b5230ab428f40ee3fc76d687e601f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200121111555eucas1p2d26b5230ab428f40ee3fc76d687e601f
References: <20200107130441.y3owvcnxdljailt5@kili.mountain>
        <20200120.144042.1810086369376110530.davem@davemloft.net>
        <CGME20200121111555eucas1p2d26b5230ab428f40ee3fc76d687e601f@eucas1p2.samsung.com>
        <faf4b367-29b3-474c-73bc-400f6ab36758@samsung.com>
        <20200121114835.GB1847@kadam>
        <02ea0fe7-fedd-66ac-ac60-0cdcb8802076@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/21/20 1:21 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> On 1/21/20 12:48 PM, Dan Carpenter wrote:
>> On Tue, Jan 21, 2020 at 12:15:54PM +0100, Bartlomiej Zolnierkiewicz wrote:
>>>
>>> Hi,
>>>
>>> On 1/20/20 2:40 PM, David Miller wrote:
>>>> From: Dan Carpenter <dan.carpenter@oracle.com>
>>>> Date: Tue, 7 Jan 2020 16:04:41 +0300
>>>>
>>>>> The "drive->dn" value is a u8 and it is controlled by root only, but
>>>>> it could be out of bounds here so let's check.
>>>
>>> drive->dn should not be root controllable, please point me where it
>>> happens as this may need fixing instead of cmd64x driver.
>>>
>>> [ IDE core makes sure that drive->dn is never > 3 and a lot of code
>>>   assumes it. ]
>>>
>>
>> It's a marked as a setable field in ide-proc.c
>>
>> drivers/ide/ide-proc.c
>>    206  ide_devset_rw(current_speed, xfer_rate);
>>    207  ide_devset_rw_field(init_speed, init_speed);
>>    208  ide_devset_rw_flag(nice1, IDE_DFLAG_NICE1);
>>    209  ide_devset_rw_field(number, dn);
>>                             ^^^^^^^^^^
>> Sets ->dn
> 
> It is a bug.

PS The rationale for fixing it is:

- IDE core always sets ->dn correctly (changing it is never required)

- setting different value than assigned by IDE core is very likely to
  result in data corruption (due to wrong transfer timings being set on
  the controller etc.)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
