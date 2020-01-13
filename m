Return-Path: <SRS0=yvY0=3C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED40C33CAD
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jan 2020 14:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20CA2073D
	for <linux-ide@archiver.kernel.org>; Mon, 13 Jan 2020 14:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GgP1dsRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAMOck (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:32:40 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45144 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgAMOck (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Jan 2020 09:32:40 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00DEWYNO030177;
        Mon, 13 Jan 2020 08:32:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578925954;
        bh=PlwkQQKc/7i94fyMo4aS3t567+ZveMCiSE48aEv0T8o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GgP1dsRKb7lSzALt6c1o9j6Z6mBrC2uHpucVt/yj36XKuSL+9XOWptBw+HNbTWQfd
         qyEn2EGSsk90Z1VRaHYqoJlX64+i6dMK2rOpk2JjakOU7XqhNp7h0PtOV2hYURASsd
         EqYGyjezVNgD02KmDHNnwkef3Gi0bmJtmUDhdQHE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00DEWYPi040632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jan 2020 08:32:34 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 13
 Jan 2020 08:32:27 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 13 Jan 2020 08:32:26 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00DEWPgn004504;
        Mon, 13 Jan 2020 08:32:25 -0600
Subject: Re: [PATCH] ata: pata_arasam_cf: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Viresh Kumar <viresh.kumar@linaro.org>, <vireshk@kernel.org>,
        <axboe@kernel.dk>, <vkoul@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20191217105048.25327-1-peter.ujfalusi@ti.com>
 <CGME20191217111956epcas5p36d2e10fa2ba3c2e8dd0cc661c8de7dd0@epcas5p3.samsung.com>
 <20191217111950.vzuww3ov4ub45ros@vireshk-i7>
 <b171c3c0-d924-e2e6-0c4d-196c7e6c2325@samsung.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <7cb96956-806e-4120-692c-dfd0afd49738@ti.com>
Date:   Mon, 13 Jan 2020 16:33:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b171c3c0-d924-e2e6-0c4d-196c7e6c2325@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org



On 13/01/2020 13.31, Bartlomiej Zolnierkiewicz wrote:
> 
> On 12/17/19 12:19 PM, Viresh Kumar wrote:
>> On 17-12-19, 12:50, Peter Ujfalusi wrote:
>>> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
>>> eating up the error code.
>>>
>>> By using dma_request_chan() directly the driver can support deferred
>>> probing against DMA.
> 
> It doesn't seem to be the case as DMA channel is requested at the start
> of the data transfer (which happens after the driver has been successfully
> probed).

True, I have updated the commit message to remove the reference to
deferred probing.
If the DMA is requested upfront (at probe time, device open time?) the
driver would save quite a bit of time by not allocating and freeing the
DMA resources repeatedly for each transfer, thus most likely giving a
boost to throughput...

> PS there is a typo in the patch summary (it should "pata_arasan_cf").

Ah, fixed this as well in v2.

Thanks for catching them,
- Péter

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>>  drivers/ata/pata_arasan_cf.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
>>> index 135173c8d138..69b555d83f68 100644
>>> --- a/drivers/ata/pata_arasan_cf.c
>>> +++ b/drivers/ata/pata_arasan_cf.c
>>> @@ -526,9 +526,10 @@ static void data_xfer(struct work_struct *work)
>>>  
>>>  	/* request dma channels */
>>>  	/* dma_request_channel may sleep, so calling from process context */
>>> -	acdev->dma_chan = dma_request_slave_channel(acdev->host->dev, "data");
>>> -	if (!acdev->dma_chan) {
>>> +	acdev->dma_chan = dma_request_chan(acdev->host->dev, "data");
>>> +	if (IS_ERR(acdev->dma_chan)) {
>>>  		dev_err(acdev->host->dev, "Unable to get dma_chan\n");
>>> +		acdev->dma_chan = NULL;
>>>  		goto chan_request_fail;
>>>  	}
>>>  
>>> @@ -539,6 +540,7 @@ static void data_xfer(struct work_struct *work)
>>>  	}
>>>  
>>>  	dma_release_channel(acdev->dma_chan);
>>> +	acdev->dma_chan = NULL;
>>>  
>>>  	/* data xferred successfully */
>>>  	if (!ret) {
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
