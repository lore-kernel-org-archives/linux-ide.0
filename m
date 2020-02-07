Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799E9C04EB5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43F8C20838
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PduEZpEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgBGOVa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:21:30 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57373 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGOVa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:21:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142129euoutp01f8531d75b57a787bd5faa9ff14ef3356~xJLGbWLPR1730617306euoutp01E
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:21:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142129euoutp01f8531d75b57a787bd5faa9ff14ef3356~xJLGbWLPR1730617306euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085289;
        bh=EnJEtZyNOFHiW35dRxMNQmjkCjnLNZvFid1b0iCza6s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PduEZpEeZmvvPm15//ZyNhqO+shnDIYCT6m6Tmd0Va9tyy6BBBMEqzQU29cuk+awB
         8wFx5XIZNZ3txfNV0v1AarIlAd8C6onIbYcjiYDNSGrp8HPqMwkkv/xiwBn6SWl39V
         bEMBdZCcGZX5BdaMspRpo65IVjJi7JC1G0slL0ZY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200207142129eucas1p2ba78b67b24ef0385b2272cd8b549f732~xJLGU6fMi2048520485eucas1p26;
        Fri,  7 Feb 2020 14:21:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 80.8C.60679.9627D3E5; Fri,  7
        Feb 2020 14:21:29 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142128eucas1p147ab30d027bc9d8d7dc4d159bce05aea~xJLF-FmAo2389623896eucas1p1X;
        Fri,  7 Feb 2020 14:21:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142128eusmtrp12e7441b903b1ec4104e32295e7777eb5~xJLF82WxD0130001300eusmtrp1C;
        Fri,  7 Feb 2020 14:21:28 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-f0-5e3d726932e7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.15.07950.8627D3E5; Fri,  7
        Feb 2020 14:21:28 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142128eusmtip1130333c9814acd74c78a421124f81d86~xJLFmfEO23001330013eusmtip1H;
        Fri,  7 Feb 2020 14:21:28 +0000 (GMT)
Subject: Re: [PATCH 11/28] ata: add CONFIG_SATA_HOST=n version of
 ata_ncq_enabled()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <03266d04-a35e-e407-98e0-463ebacdd40b@samsung.com>
Date:   Fri, 7 Feb 2020 15:21:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200129172448.GG12616@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djPc7qZRbZxBu/+cFusvtvPZvHs1l4m
        i9MTFjFZHNvxiMni8q45bBZzW6ezO7B57Jx1l91j8wotj8tnSz0OHe5g9Pi8SS6ANYrLJiU1
        J7MstUjfLoErY/2hVqaCftaK/cvfsTQw/mXuYuTkkBAwkTixYRJTFyMXh5DACkaJJzuesIAk
        hAS+MEqsWcsOkfjMKLHpwCPGLkYOsI7Ll1kg4ssZJfo7HzNCOG8ZJbZNWg42VlggVGLlhPts
        ILaIgKbEreXtzCBFzAIbGCU+T9rCCJJgE7CSmNi+CszmFbCTeLrhGCuIzSKgItF5eRmYLSoQ
        IfHpwWFWiBpBiZMzIc7jFDCWWHHnHJjNLCAucevJfCYIW15i+9s5YMskBFaxS8x83MIG8aiL
        xK3WHhYIW1ji1fEt7BC2jMTpyT0sEA3rGCX+dryA6t7OKLF88j+obmuJO+d+sYECgBnon/W7
        9CHCjhL9m/qZIeHCJ3HjrSDEEXwSk7ZNhwrzSnS0CUFUq0lsWLaBDWZt186VzBMYlWYheW0W
        kndmIXlnFsLeBYwsqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQLTzul/x7/sYNz1J+kQ
        owAHoxIPb4KjTZwQa2JZcWXuIUYJDmYlEd4+Vds4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzG
        i17GCgmkJ5akZqemFqQWwWSZODilGhjjrHjM7dX4MxwOWM+5k+aoz3EqgG0r0/3zC0uqLkev
        vnHKwIXBnpnlyqK41A02Fc5Lu4IPL1mc5VP/WHxF+7YrHTKLVq/vdVEMfHTypdpMrr/Lfhzc
        0BftENe0dZ7wv2tVNrPnbMk2j1i4Tu5BXOXbDu2Lic/YGVy/fFzeeuRE9fWbNQFeVrpKLMUZ
        iYZazEXFiQAwQflxNwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7oZRbZxBg2vTS1W3+1ns3h2ay+T
        xekJi5gsju14xGRxedccNou5rdPZHdg8ds66y+6xeYWWx+WzpR6HDncwenzeJBfAGqVnU5Rf
        WpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXsf5QK1NBP2vF
        /uXvWBoY/zJ3MXJwSAiYSFy+zNLFyMUhJLCUUeLVsp3sEHEZiePry7oYOYFMYYk/17rYIGpe
        M0osO/SBHSQhLBAqsXLCfTYQW0RAU+LW8nZmEJtZYAOjxPUvghAN7xklti/8CVbEJmAlMbF9
        FSOIzStgJ/F0wzFWEJtFQEWi8/IyMFtUIELi8I5ZUDWCEidnPmEBsTkFjCVW3DnHArFAXeLP
        vEtQy8Qlbj2ZzwRhy0tsfzuHeQKj0Cwk7bOQtMxC0jILScsCRpZVjCKppcW56bnFRnrFibnF
        pXnpesn5uZsYgVG27djPLTsYu94FH2IU4GBU4uFNcLSJE2JNLCuuzD3EKMHBrCTC26dqGyfE
        m5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cAEkFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
        sSQ1OzW1ILUIpo+Jg1OqgTHUq2jS+7I3L9SzhTS0X/5cccD8l3negvNXv/5lO2NZOK3X3Gdq
        Yap6hPEe3po/c6f+Y3rhkK+ZcXXFPufIpf+8OqqX/bRyOF6XvX7mw1XaJ+bv/eG5qMJHzjdv
        gb55aOlh8Z92bkq92bvsrrGYvCmQaTq4ZH3GjRv3N7RWzlI6/zDfp77Ork6JpTgj0VCLuag4
        EQBPU7TcyAIAAA==
X-CMS-MailID: 20200207142128eucas1p147ab30d027bc9d8d7dc4d159bce05aea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133414eucas1p1c69ee66d4799a5aea22561b42ab73e11
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133414eucas1p1c69ee66d4799a5aea22561b42ab73e11
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133414eucas1p1c69ee66d4799a5aea22561b42ab73e11@eucas1p1.samsung.com>
        <20200128133343.29905-12-b.zolnierkie@samsung.com>
        <20200129172448.GG12616@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/29/20 6:24 PM, Christoph Hellwig wrote:
>>  static inline int ata_ncq_enabled(struct ata_device *dev)
>>  {
>> +#ifdef CONFIG_SATA_HOST
>>  	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
>>  			      ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ;
>> +#else
>> +	return 0;
>> +#endif
> 
> I think this is a prime candidate for IS_ENABLED:
> 
> 	if (!IS_ENABLED(CONFIG_SATA_HOST))
> 		return 0;
>  	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
>   			      ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ;
> 

Fully agreed, fixed in v2.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
