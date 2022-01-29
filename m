Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E46FC433FE
	for <linux-ide@archiver.kernel.org>; Sat, 29 Jan 2022 00:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351904AbiA2AMY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Jan 2022 19:12:24 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49573 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351902AbiA2AMY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2022 19:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643415144; x=1674951144;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jX0SJEJxHH33mFla3gUrnK/YmkEJHLnV/h7s0s+viSs=;
  b=EHZlKLLnQKgHoCnVrbBNsViuA6tOkiFhiW2WOhYS0J9rJvc1lR7xMe94
   usbhhgJ6ISXRRkL9Fum3Lwio5+wEGKYRM57DS21xt3jgBaQbWE6mQZCoV
   r8GE99lGjEcBkgMO3rRd1y3EiPjV/sVZyg+KjLRTgLJWmxl1qBOCfO+ad
   JgkcHKGetdzsFxWL+Qg7VUqsfqG7ue4SxlxA8A6dXT+mS2wb8urUN2zea
   MeKL4aaU1n1yZtmJnh3XKF2T827maC6V0EMlIux5iorsXLqV8G+GjzYPu
   YiI6e7PtaIqymmCcZmbcmL8R+C2OAgEv2ktK3XKTu/1HOSPmctgzyle+F
   g==;
X-IronPort-AV: E=Sophos;i="5.88,325,1635177600"; 
   d="scan'208";a="190622522"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2022 08:12:23 +0800
IronPort-SDR: EuT1R8495eHmHOdwMnngZOkRGf0+70recjgnIWLUcKdP470vKMJKoAgiANaQ63DP3J0/NakVBd
 qAbssw0+wyN5NtPehx0m8SoEQLW7SBS2kYtkQmLMr2INv1Qh2WbUWGurH/abblqXgnR6DrhPm1
 pk69/NM0+4hVHBEytsCSaAP7hTsIZZ7wYWhSTrcAxO6iiBTf+IW3HTla17l2C8tbrHN39Ab/ey
 j/0blAqHXY23SMYlXs/r1awPUXulcMcFIH98HkGWEVmCRc+SWy+Ne4oCmQp4pQL1yNgPo8x6lB
 NH0gYnqSJEb62rymaMjUpM+7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:44:25 -0800
IronPort-SDR: 69GomvtFkM+K9p5PEDNwJqa1X8zw8vlcCf35SoWyz3e6qKqnF9jFk3heWG/K2Rq+MvgciOJJ7W
 v5ko21ypUgRmjNoZmGY119COhXyjYI2wtbdXHhOkAz+tTGj/58RLXi8yTUTbT0azK9grMZAcKA
 hoSvYWaGPYLbtbNAfqRcejLB7GigxtkZXaDvBqogp+tbSp53J1jYsxWS/6QysblNtzgG3Fv5cX
 PD3iCojkiU8J02W3wcWbySNZpzgCS6Scs2EGAp3uFD9Y7hy0QIwCWeNDThaJMZ6ooi00beKgsf
 AeI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 16:12:23 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JlvsM3HRRz1SVp0
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 16:12:23 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1643415142; x=1646007143; bh=jX0SJEJxHH33mFla3gUrnK/YmkEJHLnV/h7
        s0s+viSs=; b=bvOZarxJP0Tm0X/as66S9VQZadGS9z18P2svcnWTOcIORxDpdvL
        1sjZVZ9KOzoUvOD7GSGA9UmDtNyB6ntV8cbyw4II2Sxor2VPpfEyoPMvClasuoDA
        OQnpx3vAwmfr6OoHO8cYlbcjBuc2TL8Dqio/6850wvvfEpwC9mYrWVWk+aCAJRiq
        aJk/8pQU2lceETEJW13zqO4Z44kU0HYxErbSPe2zIVTGyFif6R+5TnLyWHa86q3Z
        uo2GCYX98h6vSkvXvpdehQsC0pdCA7MuOSUs1SJj53oylivB6i4RlDqdHPO7u8v4
        1PlcekdqOqYS+x34YnRK+9DbzLuO0bjd+tg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pq9onnr66y4P for <linux-ide@vger.kernel.org>;
        Fri, 28 Jan 2022 16:12:22 -0800 (PST)
Received: from [10.225.163.60] (unknown [10.225.163.60])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JlvsJ5c2Rz1RvlN;
        Fri, 28 Jan 2022 16:12:20 -0800 (PST)
Message-ID: <45efc552-999b-c57b-5da1-0818893c031d@opensource.wdc.com>
Date:   Sat, 29 Jan 2022 09:12:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ata: pata_platform: Fix a NULL pointer dereference in
 __pata_platform_probe()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhou Qingyang <zhou1615@umn.edu>, kjlu@umn.edu,
        Alexander Shiyan <shc_work@mail.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220124164525.53068-1-zhou1615@umn.edu>
 <YfPBb4gHDkr76xPT@kroah.com>
 <3621c7db-0b73-d7eb-f987-45ec59a6c738@opensource.wdc.com>
 <YfQSdJgi4x5hN3Ee@kroah.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YfQSdJgi4x5hN3Ee@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 1/29/22 00:57, Greg KH wrote:
> On Fri, Jan 28, 2022 at 08:50:04PM +0900, Damien Le Moal wrote:
>> On 1/28/22 19:11, Greg KH wrote:
>>> On Tue, Jan 25, 2022 at 12:45:25AM +0800, Zhou Qingyang wrote:
>>>> In __pata_platform_probe(), devm_kzalloc() is assigned to ap->ops and
>>>> there is a dereference of it right after that, which could introduce a
>>>> NULL pointer dereference bug.
>>>>
>>>> Fix this by adding a NULL check of ap->ops.
>>>>
>>>> This bug was found by a static analyzer.
>>>>
>>>> Builds with 'make allyesconfig' show no new warnings,
>>>> and our static analyzer no longer warns about this code.
>>>>
>>>> Fixes: f3d5e4f18dba ("ata: pata_of_platform: Allow to use 16-bit wide data transfer")
>>>> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
>>>> ---
>>>
>>> As stated in the past, please do not make contributions to the Linux
>>> kernel until umn.edu has properly resolved its development issues.
>>
>> Aouch. My apologies. I forgot about this. Thank you for the reminder.
>>
>>>
>>>> The analysis employs differential checking to identify inconsistent 
>>>> security operations (e.g., checks or kfrees) between two code paths 
>>>> and confirms that the inconsistent operations are not recovered in the
>>>> current function or the callers, so they constitute bugs. 
>>>>
>>>> Note that, as a bug found by static analysis, it can be a false
>>>> positive or hard to trigger. Multiple researchers have cross-reviewed
>>>> the bug.
>>>>
>>>>  drivers/ata/pata_platform.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
>>>> index 028329428b75..021ef9cbcbc1 100644
>>>> --- a/drivers/ata/pata_platform.c
>>>> +++ b/drivers/ata/pata_platform.c
>>>> @@ -128,6 +128,8 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
>>>>  	ap = host->ports[0];
>>>>  
>>>>  	ap->ops = devm_kzalloc(dev, sizeof(*ap->ops), GFP_KERNEL);
>>>> +	if (ap->ops)
>>>> +		return -ENOMEM;
>>>
>>> This change seems to leak memory.  Damien, please revert it.
>>
>> I fixed the patch when applying, so there is no leak.
> 
> Really?  What happened to the memory that ata_host_alloc() created above
> this call?  How is that freed?
> 
>> This is a genuine (potential) bug fix.
> 
> As I tell others, how can kmalloc() ever fail here, so odd of this being
> a real bugfix are so low it's not funny.  So take these types of
> cleanups as a last-resort only after you have strongly validated that
> they are correct.  The current group of people trying to do these fixes
> have a horrible track-record and are getting things wrong way more than
> they should be.  And so it is worse having code that "looks" correct vs.
> something that is "obviously we need to handle this some day".

I completely agree that this is not fixing any real bug reported in the
field. And as you say, an error here is more than unlikely. I accepted
the patch only on the ground of code correctness.

> 
>> Must I revert ?
> 
> If it's buggy you should, see my above question about ata_host_alloc(),
> is there a cleanup path somewhere that I am missing?

The resources allocated by ata_host_alloc() are attached to the device
(devres and drv_data) so they will be freed by ata_devres_release() when
the dev is dropped due to the probe error. I think the return that the
patch introduces is fine as is.

If I am misunderstanding the devres handling, please let me know.

In any case, I will make sure to ignore patches from umn.edu for now.
Thanks.

-- 
Damien Le Moal
Western Digital Research
