Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5FBC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 28 Mar 2022 07:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiC1HVP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Mar 2022 03:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbiC1HVM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Mar 2022 03:21:12 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E9B2D1C8
        for <linux-ide@vger.kernel.org>; Mon, 28 Mar 2022 00:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648451971; x=1679987971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YVZ9qAsEG1yYRa0m3JjRgEw2zISjcNo0EsHsZaQ26bk=;
  b=EmQEjJ5KAerVqv77s4RsX3KZR8t/nlFS06709+K3mXrUjdSpguQL15lF
   sdqy2eIpgkcq3ZBPEKHM4FVH7HXsDHM6UG7oLg091ECVPwHQHDSz7hXRJ
   VI0NCHevmm6lVy8JRpUX4MZgV67+OVBYYAvUlDNckfR7pd3JM99qHLLlp
   i3cO9wWpW2AexIwn7oXBUOrAOMx1SsJA30NfhaqDvQK9+zdNB4QYPKPrj
   y7mcb8lV287xBVMf++xjGXVS33LuhFrBUMWtpDZLGW7bez5RgY3x4SO0v
   jtT21tWan8b52Zc7gDNdxhsaVWX+QYSHoPHHuDO4iae7A+Fzxs/9O87vJ
   g==;
X-IronPort-AV: E=Sophos;i="5.90,216,1643644800"; 
   d="scan'208";a="196426361"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 15:19:30 +0800
IronPort-SDR: uMsQgtlJCRiUqBxNMtMtH7X0s/LC6p3AnA5iagy4PbpxOhmSH2tsFaDk424kZ79YTcOaALe4bk
 sJRI9e4sFnNXEIkPBKR4WxCdKgzTbpEF0RhjIgACnGpF9uaswNCTP5THzj+pL15BGCo2Nu39/y
 VYvMjKl4O2ZJ7t64/or9rpwSrGxD72cBm2MA3WcENx2gl8gcCoOTZfglBEXdJ3Zjtu1krg82ai
 dyIjCQnA4/UudaH+pvjKcDWD7AfvUBdyby6uyvEj+6d7ivfaG6Ubr3Z5BH0WkTMQcGUc1K9kic
 WKXGSnARPtCfGwcMLzZbazrZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Mar 2022 23:51:17 -0700
IronPort-SDR: UT0KK7PxJyetfJVaj35+tDazA1aChMI6klvWfUD3ZZXCV8rJcdAFDdmk5BZX3uJIWqbleDX+Ou
 tRcbxBHu3QWHLYnvjC5sUPkwzRlpO8z+fZAH4XBe3+uFG0vjqiaq6SV+AIvu+eEsr9/TeTE4SC
 cYefB9O9wUNU+KvTXB9uNf4EdMYtPRfKuU/FdKFXQ48fBA/jtJGMNIz8RVBcwgg2ddTu2EaQ5l
 J2/EM4TJf8sAIBQ1QL9jGYM4mEO8049oodAVAyesbLWjSa8kd64r/W0dMIGaiIXQqJodYw+7t1
 Zf8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2022 00:19:32 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KRkbR6CQxz1SHwl
        for <linux-ide@vger.kernel.org>; Mon, 28 Mar 2022 00:19:31 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648451971; x=1651043972; bh=YVZ9qAsEG1yYRa0m3JjRgEw2zISjcNo0EsH
        sZaQ26bk=; b=mO9/OuIl5VfnD955yzRnijIIAy7RqStB2ugocZ9a2y2sznS+mir
        mCQEe3ge0paatMaqURaVsYs/C62mhnDNzC7aBjCb3+3TBJqHgSZCfj7EGj+zQYbh
        GuHLJsdUek9KNUogTj11/hngbi7oictA6FY5GBOcg12xbEgXd+pHYDR6f6GTj0yu
        8uRNcNCjwDqZB+4J8UHguwXIsLAuk3Tbd7uXUJcmtRaFeaobZ+UyRe8jPD1RitSh
        IO5oSkZItXJQgde4OCqxT4Q5ZRNTyjCtkl89x3m+emmldsuBitt3mLt1MSlwpXgI
        FWX1d3M1xXunQoEz54TIoTEXF7NytzxWkBQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CiEQnRpGbfud for <linux-ide@vger.kernel.org>;
        Mon, 28 Mar 2022 00:19:31 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KRkbR0jkhz1Rvlx;
        Mon, 28 Mar 2022 00:19:30 -0700 (PDT)
Message-ID: <890cac19-a94f-cfc7-7eaa-c05b74f69669@opensource.wdc.com>
Date:   Mon, 28 Mar 2022 16:19:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] ata: libata-sata: Improve sata_link_debounce()
Content-Language: en-US
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-ide@vger.kernel.org
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
 <20220323081740.540006-5-damien.lemoal@opensource.wdc.com>
 <8933f892-aa56-cd21-8acc-744d9a89f66e@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8933f892-aa56-cd21-8acc-744d9a89f66e@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/25/22 18:10, Paul Menzel wrote:
> Dear Damien,
> 
> 
> Am 23.03.22 um 09:17 schrieb Damien Le Moal:
>> sata_link_debounce() polls the SStatus register DET field to ensure that
>> a stable value is provided, to reliably detect device presence and PHY
>> readiness. Polling is done for at least timing->duration if there is no
>> device detected. For the device detected case, polling last up to
> 
> last*s*
> 
>> deadline to ensure that the PHY becomes ready.
>>
>> However, the PHY ready state is actually never checked, leading to the
>> poll loop duration always reaching the maximum duration.
>>
>> For adapters that do not require a debounce delay (link flag
>> ATA_LFLAG_DEBOUNCE_DELAY no set), add a check to test if DET indicates
> 
> no*t*?
> 
>> device present *and* PHY ready and bail out of the polling loop if it
>> does.
>>
>> While at it, add comments to clarify the various checks in
>> sata_link_debounce() polling loop.
> 
> Were you able to verify that the check now terminates the loop on your 
> devices earlier?

Yes it does for me. The function goes from taking about 100ms to taking
only one iteration of the loop, which has only one 5ms sleep.

> 
> Are below the right lines to compare? On the Dell OptiPlex 5055 (AMD FCH 
> SATA Controller [AHCI mode] [1022:7901]) I see:
> 
> Before (this very patch)
> 
>      [    0.428015] ata1: hard resetting link
>      [    0.696316] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 
> After:
> 
>      [    0.428907] ata1: hard resetting link
>      [    0.648092] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> 
> So a decrease of (268 - 219 = 49) ms. Nice.

For a regular boot, sata_deb_timing_normal duration is used. So the save
is 100ms almost (there is still one iteration of the loop needed, which
takes interval = 5ms).

Together with the long 200ms sleep in sata_link_resume, the gain overall
should be about 300ms.

> 
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>   drivers/ata/libata-sata.c | 24 ++++++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
>> index 87ad03c2e49f..15423723c9dd 100644
>> --- a/drivers/ata/libata-sata.c
>> +++ b/drivers/ata/libata-sata.c
>> @@ -276,8 +276,27 @@ int sata_link_debounce(struct ata_link *link,
>>   
>>   		/* DET stable? */
>>   		if (cur == last) {
>> +			/*
>> +			 * If the device presence was detected but PHY
>> +			 * communication is not yet established, wait until
>> +			 * deadline.
>> +			 */
>>   			if (cur == 1 && time_before(jiffies, deadline))
>>   				continue;
>> +
>> +			/*
>> +			 * If PHY is ready and the device is present, and the
>> +			 * driver did not request debounce delay, bail out early
>> +			 * assuming that the link is stable.
>> +			 */
>> +			if (cur == 3 &&
>> +			    !(link->flags & ATA_LFLAG_DEBOUNCE_DELAY))
>> +				return 0;
>> +
>> +			/*
>> +			 * If DET value has remained stable for
>> +			 * timing->duration, bail out.
>> +			 */
>>   			if (time_after(jiffies,
>>   				ata_deadline(last_jiffies, timing->duration)))
>>   				return 0;
>> @@ -288,8 +307,9 @@ int sata_link_debounce(struct ata_link *link,
>>   		last = cur;
>>   		last_jiffies = jiffies;
>>   
>> -		/* Check deadline.  If debouncing failed, return
>> -		 * -EPIPE to tell upper layer to lower link speed.
>> +		/*
>> +		 * If debouncing has not succeeded before dealine, return
> 
> dea*d*line
> 
>> +		 * -EPIPE to tell the upper layer to lower the link speed.
>>   		 */
>>   		if (time_after(jiffies, deadline))
>>   			return -EPIPE;
> 
> One separate for the new check would have been nice, but looks good to 
> me overall.
> 
> 
> Kind regards,
> 
> Paul


-- 
Damien Le Moal
Western Digital Research
