Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90BCC35242
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02C822B48
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fJIp/5Hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgBGORg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:17:36 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46064 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGORf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:17:35 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207141733euoutp02c8f54b71a4ea7a56b4fc33594c79d12e~xJHqwtjDv2053620536euoutp02I
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:17:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207141733euoutp02c8f54b71a4ea7a56b4fc33594c79d12e~xJHqwtjDv2053620536euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085053;
        bh=e8WdKKhJ2i8/+GLjpi5AnAPMFbHzxInwd5dWaOD1DCM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fJIp/5HkWsAUM4/bJt75nIQeARQhBCaEvxN3NlnL46rkliEcFZ6y/S/okgpLKedyT
         wYtslVKYgX6EZ76JBxgzAGkT5snZPOg8kAmFsahtzPJ/y/ZUtFfHA7yJaQ7XG8coqJ
         rnvhUJNTJjoT6qR/LtaGaSuEQDcSIXsph5IWC648=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200207141733eucas1p28d99ca78fd429d23c5263b16ffbc2f05~xJHqgLc9J1710517105eucas1p2B;
        Fri,  7 Feb 2020 14:17:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A6.87.60698.D717D3E5; Fri,  7
        Feb 2020 14:17:33 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207141732eucas1p25eb18ed5b364fc6c363cb1df1c3ab9fc~xJHqFI_ye0702707027eucas1p26;
        Fri,  7 Feb 2020 14:17:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207141732eusmtrp271786500106b14d97d5143d29a3d424c~xJHqEjeVy0573605736eusmtrp2D;
        Fri,  7 Feb 2020 14:17:32 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-cf-5e3d717df9e5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 26.94.07950.C717D3E5; Fri,  7
        Feb 2020 14:17:32 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207141732eusmtip29756a676fbba1627309bfb1b3e58125c~xJHpu975w2407724077eusmtip2i;
        Fri,  7 Feb 2020 14:17:32 +0000 (GMT)
Subject: Re: [PATCH 06/28] ata: use COMMAND_LINE_SIZE for
 ata_force_param_buf[] size
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <3cfa8b05-2ffa-b12f-92a6-7554fcb1297e@samsung.com>
Date:   Fri, 7 Feb 2020 15:17:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200129171819.GB12616@infradead.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7q1hbZxBpOeclmsvtvPZvHs1l4m
        i9MTFjFZHNvxiMni8q45bBZzW6ezO7B57Jx1l91j8wotj8tnSz0OHe5g9Pi8SS6ANYrLJiU1
        J7MstUjfLoEr40DbKraCBq6KB1MuszcwfmbvYuTkkBAwkVgz4wFbFyMXh5DACkaJ9h0zmSGc
        L4wSe3Y9Z4RwPgM5b2fCtfTveAHVspxR4uL9SVBVbxklrk98wwJSJSwQJrFsxhwwW0RAU+LW
        8nawucwCGxglPk/awgiSYBOwkpjYvgrM5hWwk7jRtgKsgUVARWLqhYnMILaoQITEpweHWSFq
        BCVOznwCVsMpYCyx685tsF5mAXGJW0/mM0HY8hLb384BWyYhsIxd4tjME4wQd7tIzLz9FcoW
        lnh1fAvUPzIS/3eCNIM0rGOU+NvxAqp7O6PE8sn/2CCqrCXunPsFZHMArdCUWL9LHyLsKHFp
        Psh1HEA2n8SNt4IQR/BJTNo2nRkizCvR0SYEUa0msWHZBjaYtV07VzJPYFSaheS1WUjemYXk
        nVkIexcwsqxiFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITD2n/x3/uoNx35+kQ4wCHIxK
        PLwJjjZxQqyJZcWVuYcYJTiYlUR4+1Rt44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSsk
        kJ5YkpqdmlqQWgSTZeLglGpgbHnxbOeDO+FF235mhH37teuJ12HJLXHJBxX4fR7IMWavVjuc
        KLSIl2PjJR/2TOHui6kJbEKBnK2isiwPUj6qu0YoeL1uN7ivE3G4d+pap4ciujNZ9Pv290qm
        bEs9+U344jfz4D7h7RzNK1e6Mu/Rn1v0l9WlQ1fh3u+MSz83edQdfR3IqrJdiaU4I9FQi7mo
        OBEAxzyWjjkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7o1hbZxBpN+6VisvtvPZvHs1l4m
        i9MTFjFZHNvxiMni8q45bBZzW6ezO7B57Jx1l91j8wotj8tnSz0OHe5g9Pi8SS6ANUrPpii/
        tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv40DbKraCBq6K
        B1MuszcwfmbvYuTkkBAwkejf8YKti5GLQ0hgKaPE7ZVtLF2MHEAJGYnj68sgaoQl/lzrgqp5
        zShxb8IGRpCEsECYxLIZc1hAbBEBTYlby9uZQWxmgQ2MEte/CEI0vGOU6H65lBUkwSZgJTGx
        fRVYM6+AncSNthVgzSwCKhJTL0wEaxYViJA4vGMWVI2gxMmZT8BqOAWMJXbduc0IsUBd4s+8
        S1DLxCVuPZnPBGHLS2x/O4d5AqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJucWl
        eel6yfm5mxiBcbbt2M8tOxi73gUfYhTgYFTi4U1wtIkTYk0sK67MPcQowcGsJMLbp2obJ8Sb
        klhZlVqUH19UmpNafIjRFOi5icxSosn5wBSQVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2x
        JDU7NbUgtQimj4mDU6qBkeW8Zqr5t0OqGmcvid/YWHWnkGdJygOmedpXu16Ec7xymLiY5fji
        ldIfrgnwzV/pdKB/02NHLYuDLb071xmrc7y48jNoa4d8h2faI2YNnd4fWu9zPS1FT3MenVr3
        +q2AUs312Yvr+wLqLJhnas/nVTOsD797zva+bv+K0g33Jd4VRr7K05sjqsRSnJFoqMVcVJwI
        ACZl1b7JAgAA
X-CMS-MailID: 20200207141732eucas1p25eb18ed5b364fc6c363cb1df1c3ab9fc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133412eucas1p2e5e3e29ea554bf57c1f2cc05b3d2d3a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133412eucas1p2e5e3e29ea554bf57c1f2cc05b3d2d3a8
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133412eucas1p2e5e3e29ea554bf57c1f2cc05b3d2d3a8@eucas1p2.samsung.com>
        <20200128133343.29905-7-b.zolnierkie@samsung.com>
        <20200129171819.GB12616@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 1/29/20 6:18 PM, Christoph Hellwig wrote:
> On Tue, Jan 28, 2020 at 02:33:21PM +0100, Bartlomiej Zolnierkiewicz wrote:
>> Use COMMAND_LINE_SIZE instead PAGE_SIZE for ata_force_param_buf[]
>> size as libata parameters buffer doesn't need to be bigger than
>> the command line buffer.
>>
>> For many architectures this results in decreased libata-core.o
>> size (COMMAND_LINE_SIZE varies from 256 to 4096 while the minimum
>> PAGE_SIZE is 4096).
>>
>> Code size savings on m68k arch using atari_defconfig:
>>
>>    text    data     bss     dec     hex filename
>> before:
>>   41064    4413      40   45517    b1cd drivers/ata/libata-core.o
>> after:
>>   41064     573      40   41677    a2cd drivers/ata/libata-core.o
>>
>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> This looks like a good start, so:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks.

> But evne COMMAND_LINE_SIZE is quite a lot of overhead.  Can we maybe add
> a new Kconfig option to optionally disable the libata.force= entirely?

I've added patch making "libata.force=" optional in v2
(disabling "libata.force=" saves us additional 3kB).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
