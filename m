Return-Path: <SRS0=yvY0=3C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA67C33CAD
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jan 2020 11:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D0E2084D
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jan 2020 11:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hq/oCqka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAMLcB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:32:01 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:60176 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMLcA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jan 2020 06:32:00 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200113113158euoutp016c1ca258748df8c707269e1cc93f4574~pbu9ngJHc3011730117euoutp01e
        for <linux-ide@vger.kernel.org>; Mon, 13 Jan 2020 11:31:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200113113158euoutp016c1ca258748df8c707269e1cc93f4574~pbu9ngJHc3011730117euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578915118;
        bh=exgPqVTwXgFdwKUjR2Can4eR2gu2HfhSQsazOhSA6R4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hq/oCqkaE8LDSQnoXKTVEnvRJMqlmJR8BnPxXMHcVd9dMUIf5I0eE8SJ4LMwgZJuw
         2ya4VkU/m7pCxcoKL8YJVzh3l2YDWxZrqBzvUDgv8Fy5mZJ4EBdUNGEJr3Zs5qPxRB
         QBDfwcrR67znKdFoWuDRwkkqEF4e+UIdK1gTZ7+A=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200113113158eucas1p1818c5a9befeb0f2ab1436902635a7540~pbu9Z3YIR2462524625eucas1p13;
        Mon, 13 Jan 2020 11:31:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4B.94.60679.E255C1E5; Mon, 13
        Jan 2020 11:31:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200113113158eucas1p137efd45f6aa77d8509e2389c23e0a8e7~pbu9Es8A50246402464eucas1p1n;
        Mon, 13 Jan 2020 11:31:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200113113158eusmtrp1ce5186092b2a23d2a4542ed1ef04ee90~pbu9EFbmh2049020490eusmtrp1G;
        Mon, 13 Jan 2020 11:31:58 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-a5-5e1c552e7aad
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A0.5D.07950.E255C1E5; Mon, 13
        Jan 2020 11:31:58 +0000 (GMT)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200113113157eusmtip29dcc79ff0aa535ed43386cae0054529d~pbu8RIhNj1745017450eusmtip2W;
        Mon, 13 Jan 2020 11:31:57 +0000 (GMT)
Subject: Re: [PATCH] ata: pata_arasam_cf: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, vireshk@kernel.org,
        axboe@kernel.dk, vkoul@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <b171c3c0-d924-e2e6-0c4d-196c7e6c2325@samsung.com>
Date:   Mon, 13 Jan 2020 12:31:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191217111950.vzuww3ov4ub45ros@vireshk-i7>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTcRTG+e/e3d3NNq7T8KBmMGqg5LQUmq8lWIygiCywyNnK6wu6TTbn
        1ChEw9TMVn4oh8wI0pykNkXnKrAtpmVpoYjawiUWJRiZZi+m5naV/PZ7zgvPeeCQmNDMDiRz
        VAW0RqXIExE8vNv5eyhccipYHtn+TSxtfX+DkDqt0yzpiK2BkBrnf7Glj37IpJ1uJyHtdQ1g
        Bzmykdc6mcVcRchcY08IWf94D0u2YAk5zj7Di8+g83IKaU1E4jlednmZC8+vFxQ1tvSxStFb
        n2rEJYGKBnvDGrsa8Ugh9QDBS8erDbGIwOWaxhixgKDsw1dic2XZZEJMoxnB1BU3wYg5BH3D
        Y5hnyo/KBPcgw/5UGEyOTXg3MMqEoLZy1tsgqFi4edWMPMynEmHG7fZa4NRucAx3eXk7lQrf
        3Q42M+MLL+pncA9zqRhYqVjmeBijAmByppHF8E7omWvAmFMtHFjuDmE4Ge70vkEM+8FsfxeH
        4WAYrKvBPccB1YZgpfIzxogeBM11qxuh48A19GedyXWHUGi3RTDlJHh3v5ztKQMlgPE5X+YG
        Adzqvo0xZT5UVgiZaTF0NHUQm7bVvS2YAYmMW5IZt6Qxbklj/O97F+FmFEDrtMosWrtPResl
        WoVSq1NlSS6olRa0/kGDq/2LVmT7e96OKBKJtvH7SoLkQraiUFustCMgMZE/3zIUKBfyMxTF
        JbRGna7R5dFaOwoicVEAP+relzQhlaUooHNpOp/WbHZZJDewFInvCg9ltD5LlhnicB+HjzM0
        6ScdfQ2LtNrcz/cc23+4MyF1eHL+aP0OddHTk8HptVKDzTGqFti5SvGoQE+cTtDzlw60jeUS
        a/HzS/pww9m6iY+77J9S5LFHMvll6VPWtDZJ3sWalEvBJ1ZjqvAoMuR6rGiyyVSYVPyQejxw
        WYRrsxV7wzCNVvEP+9LwmD0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsVy+t/xe7p6oTJxBjde81usvtvPZnFsxyMm
        i8u75rBZzPr4g9Vi41cPi80PjrFZ7LxzgtmB3ePy2VKPTas62TzuXNvD5nH8xnYmj8+b5AJY
        o/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQympvu
        sBTM5KuYv/IAUwPjRe4uRk4OCQETid/z5jF2MXJxCAksZZTo27mKqYuRAyghI3F8fRlEjbDE
        n2tdbCC2kMBrRomzM4VBbGGBNIkHp68xg9giAloSt67dZASxmQXmMUq8+aEEMXMvo8T6h6/B
        itgErCQmtq8CK+IVsJN48uAB2FAWAVWJw+e3gNmiAhESh3fMgqoRlDg58wkLiM0pYCnxt+03
        O8QCdYk/8y4xQ9jiEreezGeCsOUltr+dwzyBUWgWkvZZSFpmIWmZhaRlASPLKkaR1NLi3PTc
        YiO94sTc4tK8dL3k/NxNjMB423bs55YdjF3vgg8xCnAwKvHwHqiSjhNiTSwrrsw9xCjBwawk
        wrvpnFScEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucDU0FeSbyhqaG5haWhubG5sZmFkjhv
        h8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQbG85OYeOs1uPNPs/TI75/67nCb+CKPR9f+ik7pnntJ
        9oO8jcmRhb4V63kt2FRKv3uuyQn7FC24SGRxxtIQk+8vHr7uTriuWdtx3L3i4ZLJDDeuxvzi
        Kd3su/rQ0rTYTVKn59pumH769sGgKH0rTbkDnVlvphcELM3bss1l1zOx1pBz75v9epcHKbEU
        ZyQaajEXFScCAPw6lZLNAgAA
X-CMS-MailID: 20200113113158eucas1p137efd45f6aa77d8509e2389c23e0a8e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191217111956epcas5p36d2e10fa2ba3c2e8dd0cc661c8de7dd0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191217111956epcas5p36d2e10fa2ba3c2e8dd0cc661c8de7dd0
References: <20191217105048.25327-1-peter.ujfalusi@ti.com>
        <CGME20191217111956epcas5p36d2e10fa2ba3c2e8dd0cc661c8de7dd0@epcas5p3.samsung.com>
        <20191217111950.vzuww3ov4ub45ros@vireshk-i7>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


On 12/17/19 12:19 PM, Viresh Kumar wrote:
> On 17-12-19, 12:50, Peter Ujfalusi wrote:
>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>> eating up the error code.
>>
>> By using dma_request_chan() directly the driver can support deferred
>> probing against DMA.

It doesn't seem to be the case as DMA channel is requested at the start
of the data transfer (which happens after the driver has been successfully
probed).

PS there is a typo in the patch summary (it should "pata_arasan_cf").

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/ata/pata_arasan_cf.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
>> index 135173c8d138..69b555d83f68 100644
>> --- a/drivers/ata/pata_arasan_cf.c
>> +++ b/drivers/ata/pata_arasan_cf.c
>> @@ -526,9 +526,10 @@ static void data_xfer(struct work_struct *work)
>>  
>>  	/* request dma channels */
>>  	/* dma_request_channel may sleep, so calling from process context */
>> -	acdev->dma_chan = dma_request_slave_channel(acdev->host->dev, "data");
>> -	if (!acdev->dma_chan) {
>> +	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
>> +	if (IS_ERR(acdev->dma_chan)) {
>>  		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
>> +		acdev->dma_chan = NULL;
>>  		goto chan_request_fail;
>>  	}
>>  
>> @@ -539,6 +540,7 @@ static void data_xfer(struct work_struct *work)
>>  	}
>>  
>>  	dma_release_channel(acdev->dma_chan);
>> +	acdev->dma_chan = NULL;
>>  
>>  	/* data xferred successfully */
>>  	if (!ret) {
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

