Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28479C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 28 Mar 2022 09:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239700AbiC1JPU (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Mar 2022 05:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239699AbiC1JPT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Mar 2022 05:15:19 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38847650
        for <linux-ide@vger.kernel.org>; Mon, 28 Mar 2022 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648458818; x=1679994818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MSADlhf9FypNOi6/37lXJq3c3Nr24VCQabsKjn/k8hA=;
  b=OCbVezTWGxm4hHgEhPJMhMVLP2oTZHfyiKE+NNFE23tTj62mqPfX/uzP
   mFM8+OacGLwnD/6u4aPvopLD1tTvcYqbbZdFB+9o6aZAqJ7+FddaQsaSF
   igjzV3uHDQvB93nSFY2H5JVOHpaGYeTct+Y/U7qzUtWwCW/tjoAHcM13W
   c6AqJ2S96w6I1uZw3cRilK55u9EWuds5WFQW9ktr7DiArhgC9VCzRSdPT
   dQcD3riykZNCMIfMiRVTjtzdKfzW9khmcBd7NmF6mVhqH9wy1ZfWV4F8Y
   klbd5fKVWfI2f7jqBeLGEEWvCbgGrqrQXa8/kQ+Ftb/YDrxerMZrHMI4r
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,217,1643644800"; 
   d="scan'208";a="195321147"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 17:13:37 +0800
IronPort-SDR: UZ9tKSkN8oNA0CRn9sKbX1Go04evALZIStzvlWYn3fpOxvz+iva0p8dleGamZ/gBpXrVLB+sJ6
 aMj7YxZsAnRFbCLY5oNiGEDIg2WjkuzKv4XDRw3NJyualk7cHFurBtNauvEpkklOQWvE8hsX/c
 j13w+V16YmbSNUhqgeiTmLLCYAqlnKKH4K8xX0RnWykb/y8cKmwTlIiFTmIdyTf23DCdlMRA+R
 CgVY/8jybKUw5u87uigSkf+qUFU2DX0vpnaJru80HyLE9MIFjcgySLMKmRD3gaSKvAe56UX41v
 gYp0yH0rhvZgqKVq3JNsmdHa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2022 01:44:30 -0700
IronPort-SDR: FaQYjSwNnOSinEF3g8BdgZo8W3ogUqEsA0eUT71RIkUo/OcPflsPzvdQa7l6XtZ7EkHImuh6m/
 aGDPtOrsB5TzY9KdCVGEt1fUTy9cYTHXzk7JiIQMrbrFuousm5zatB06xHm/nOYTPdRrC7cWal
 frPA1Wk00OGfY08OkVH/ThERW8JEWCbfpbjfJsZfLSSiGfyudB41QmmhR/F2cYtLAk1yjeyERW
 S7froh3yvcD0miFmWBMRylNYuVjCz2y/vkVurHQPfEpc1OaU2zPjl1h/l4aJxER4GYKQAFrruZ
 5zg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Mar 2022 02:13:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KRn751VS7z1SHwl
        for <linux-ide@vger.kernel.org>; Mon, 28 Mar 2022 02:13:37 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1648458816; x=1651050817; bh=MSADlhf9FypNOi6/37lXJq3c3Nr24VCQabs
        Kjn/k8hA=; b=T262hznvenJzETUeSi/SWeECNQslcmiGzglDeKVJd1VFmJ2rfu6
        1XhRisdch3yt70nBZT2Wmaw50Uc74n98IVEY5u7iN9AzwsGDmWtluJ/22BFrKcL3
        Qjr0FtyRNUHI7JMxsFvkFOgyX/CRqgXIsLajLDHRGchQ2lIT/UJ6DeiDyp5oquOp
        hzwKdSzS39vSGwchDe+BEbxB8NJjPNG3tg93Fow9b2bkRUAb2v1H3eJgjbF6JUFf
        nPHwaSDvqVZ+Ng76XkuZJUqmCVtvcjRWQqzBkds6R4gkQl7bwR6lCl4fgkQ28LmI
        wqwy5HXnC+ll1SRuoS7Tm1rkubi/GWQqGng==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iL-i1Orv5Gs5 for <linux-ide@vger.kernel.org>;
        Mon, 28 Mar 2022 02:13:36 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KRn742w29z1Rvlx;
        Mon, 28 Mar 2022 02:13:36 -0700 (PDT)
Message-ID: <61cd9ee6-86f2-a04a-f831-bb13ab208ecb@opensource.wdc.com>
Date:   Mon, 28 Mar 2022 18:13:34 +0900
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
 <890cac19-a94f-cfc7-7eaa-c05b74f69669@opensource.wdc.com>
 <8c09cd9f-f0b2-5887-d0ad-54b71fcd4734@molgen.mpg.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8c09cd9f-f0b2-5887-d0ad-54b71fcd4734@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/28/22 16:41, Paul Menzel wrote:
> Dear Damien,
> 
> 
> Am 28.03.22 um 09:19 schrieb Damien Le Moal:
>> On 3/25/22 18:10, Paul Menzel wrote:
> 
>>> Am 23.03.22 um 09:17 schrieb Damien Le Moal:
>>>> sata_link_debounce() polls the SStatus register DET field to ensure that
>>>> a stable value is provided, to reliably detect device presence and PHY
>>>> readiness. Polling is done for at least timing->duration if there is no
>>>> device detected. For the device detected case, polling last up to
>>>
>>> last*s*
>>>
>>>> deadline to ensure that the PHY becomes ready.
>>>>
>>>> However, the PHY ready state is actually never checked, leading to the
>>>> poll loop duration always reaching the maximum duration.
>>>>
>>>> For adapters that do not require a debounce delay (link flag
>>>> ATA_LFLAG_DEBOUNCE_DELAY no set), add a check to test if DET indicates
>>>
>>> no*t*?
>>>
>>>> device present *and* PHY ready and bail out of the polling loop if it
>>>> does.
>>>>
>>>> While at it, add comments to clarify the various checks in
>>>> sata_link_debounce() polling loop.
>>>
>>> Were you able to verify that the check now terminates the loop on your
>>> devices earlier?
>>
>> Yes it does for me. The function goes from taking about 100ms to taking
>> only one iteration of the loop, which has only one 5ms sleep.
>>
>>>
>>> Are below the right lines to compare? On the Dell OptiPlex 5055 (AMD FCH
>>> SATA Controller [AHCI mode] [1022:7901]) I see:
>>>
>>> Before (this very patch)
>>>
>>>       [    0.428015] ata1: hard resetting link
>>>       [    0.696316] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>>
>>> After:
>>>
>>>       [    0.428907] ata1: hard resetting link
>>>       [    0.648092] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>>
>>> So a decrease of (268 - 219 = 49) ms. Nice.
>>
>> For a regular boot, sata_deb_timing_normal duration is used. So the save
>> is 100ms almost (there is still one iteration of the loop needed, which
>> takes interval = 5ms).
>>
>> Together with the long 200ms sleep in sata_link_resume, the gain overall
>> should be about 300ms.
> 
> To my knowledge this was a regular boot (`systemctl reboot`). So where 
> did the 50 ms go? ;-)

Not sure. But I do see variations. And I did add meesages around all the
debouncing in sata_link_resume() to get a better idea of the gains.

Working on a new version now, so I will be rechecking everything.

> 
> 
> Kind regards,
> 
> Paul
> 
> 
>>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>>> ---
>>>>    drivers/ata/libata-sata.c | 24 ++++++++++++++++++++++--
>>>>    1 file changed, 22 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
>>>> index 87ad03c2e49f..15423723c9dd 100644
>>>> --- a/drivers/ata/libata-sata.c
>>>> +++ b/drivers/ata/libata-sata.c
>>>> @@ -276,8 +276,27 @@ int sata_link_debounce(struct ata_link *link,
>>>>    
>>>>    		/* DET stable? */
>>>>    		if (cur == last) {
>>>> +			/*
>>>> +			 * If the device presence was detected but PHY
>>>> +			 * communication is not yet established, wait until
>>>> +			 * deadline.
>>>> +			 */
>>>>    			if (cur == 1 && time_before(jiffies, deadline))
>>>>    				continue;
>>>> +
>>>> +			/*
>>>> +			 * If PHY is ready and the device is present, and the
>>>> +			 * driver did not request debounce delay, bail out early
>>>> +			 * assuming that the link is stable.
>>>> +			 */
>>>> +			if (cur == 3 &&
>>>> +			    !(link->flags & ATA_LFLAG_DEBOUNCE_DELAY))
>>>> +				return 0;
>>>> +
>>>> +			/*
>>>> +			 * If DET value has remained stable for
>>>> +			 * timing->duration, bail out.
>>>> +			 */
>>>>    			if (time_after(jiffies,
>>>>    				ata_deadline(last_jiffies, timing->duration)))
>>>>    				return 0;
>>>> @@ -288,8 +307,9 @@ int sata_link_debounce(struct ata_link *link,
>>>>    		last = cur;
>>>>    		last_jiffies = jiffies;
>>>>    
>>>> -		/* Check deadline.  If debouncing failed, return
>>>> -		 * -EPIPE to tell upper layer to lower link speed.
>>>> +		/*
>>>> +		 * If debouncing has not succeeded before dealine, return
>>>
>>> dea*d*line
>>>
>>>> +		 * -EPIPE to tell the upper layer to lower the link speed.
>>>>    		 */
>>>>    		if (time_after(jiffies, deadline))
>>>>    			return -EPIPE;
>>>
>>> One separate for the new check would have been nice, but looks good to
>>> me overall.
>>>
>>>
>>> Kind regards,
>>>
>>> Paul


-- 
Damien Le Moal
Western Digital Research
