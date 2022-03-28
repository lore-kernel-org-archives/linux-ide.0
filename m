Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33726C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 28 Mar 2022 07:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238877AbiC1HnD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 28 Mar 2022 03:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbiC1Hmz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 28 Mar 2022 03:42:55 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEF352E16
        for <linux-ide@vger.kernel.org>; Mon, 28 Mar 2022 00:41:14 -0700 (PDT)
Received: from [192.168.0.3] (ip5f5aef5a.dynamic.kabel-deutschland.de [95.90.239.90])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 837E961EA1927;
        Mon, 28 Mar 2022 09:41:13 +0200 (CEST)
Message-ID: <8c09cd9f-f0b2-5887-d0ad-54b71fcd4734@molgen.mpg.de>
Date:   Mon, 28 Mar 2022 09:41:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/4] ata: libata-sata: Improve sata_link_debounce()
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
 <20220323081740.540006-5-damien.lemoal@opensource.wdc.com>
 <8933f892-aa56-cd21-8acc-744d9a89f66e@molgen.mpg.de>
 <890cac19-a94f-cfc7-7eaa-c05b74f69669@opensource.wdc.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <890cac19-a94f-cfc7-7eaa-c05b74f69669@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear Damien,


Am 28.03.22 um 09:19 schrieb Damien Le Moal:
> On 3/25/22 18:10, Paul Menzel wrote:

>> Am 23.03.22 um 09:17 schrieb Damien Le Moal:
>>> sata_link_debounce() polls the SStatus register DET field to ensure that
>>> a stable value is provided, to reliably detect device presence and PHY
>>> readiness. Polling is done for at least timing->duration if there is no
>>> device detected. For the device detected case, polling last up to
>>
>> last*s*
>>
>>> deadline to ensure that the PHY becomes ready.
>>>
>>> However, the PHY ready state is actually never checked, leading to the
>>> poll loop duration always reaching the maximum duration.
>>>
>>> For adapters that do not require a debounce delay (link flag
>>> ATA_LFLAG_DEBOUNCE_DELAY no set), add a check to test if DET indicates
>>
>> no*t*?
>>
>>> device present *and* PHY ready and bail out of the polling loop if it
>>> does.
>>>
>>> While at it, add comments to clarify the various checks in
>>> sata_link_debounce() polling loop.
>>
>> Were you able to verify that the check now terminates the loop on your
>> devices earlier?
> 
> Yes it does for me. The function goes from taking about 100ms to taking
> only one iteration of the loop, which has only one 5ms sleep.
> 
>>
>> Are below the right lines to compare? On the Dell OptiPlex 5055 (AMD FCH
>> SATA Controller [AHCI mode] [1022:7901]) I see:
>>
>> Before (this very patch)
>>
>>       [    0.428015] ata1: hard resetting link
>>       [    0.696316] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>
>> After:
>>
>>       [    0.428907] ata1: hard resetting link
>>       [    0.648092] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>>
>> So a decrease of (268 - 219 = 49) ms. Nice.
> 
> For a regular boot, sata_deb_timing_normal duration is used. So the save
> is 100ms almost (there is still one iteration of the loop needed, which
> takes interval = 5ms).
> 
> Together with the long 200ms sleep in sata_link_resume, the gain overall
> should be about 300ms.

To my knowledge this was a regular boot (`systemctl reboot`). So where 
did the 50 ms go? ;-)


Kind regards,

Paul


>>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>> ---
>>>    drivers/ata/libata-sata.c | 24 ++++++++++++++++++++++--
>>>    1 file changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
>>> index 87ad03c2e49f..15423723c9dd 100644
>>> --- a/drivers/ata/libata-sata.c
>>> +++ b/drivers/ata/libata-sata.c
>>> @@ -276,8 +276,27 @@ int sata_link_debounce(struct ata_link *link,
>>>    
>>>    		/* DET stable? */
>>>    		if (cur == last) {
>>> +			/*
>>> +			 * If the device presence was detected but PHY
>>> +			 * communication is not yet established, wait until
>>> +			 * deadline.
>>> +			 */
>>>    			if (cur == 1 && time_before(jiffies, deadline))
>>>    				continue;
>>> +
>>> +			/*
>>> +			 * If PHY is ready and the device is present, and the
>>> +			 * driver did not request debounce delay, bail out early
>>> +			 * assuming that the link is stable.
>>> +			 */
>>> +			if (cur == 3 &&
>>> +			    !(link->flags & ATA_LFLAG_DEBOUNCE_DELAY))
>>> +				return 0;
>>> +
>>> +			/*
>>> +			 * If DET value has remained stable for
>>> +			 * timing->duration, bail out.
>>> +			 */
>>>    			if (time_after(jiffies,
>>>    				ata_deadline(last_jiffies, timing->duration)))
>>>    				return 0;
>>> @@ -288,8 +307,9 @@ int sata_link_debounce(struct ata_link *link,
>>>    		last = cur;
>>>    		last_jiffies = jiffies;
>>>    
>>> -		/* Check deadline.  If debouncing failed, return
>>> -		 * -EPIPE to tell upper layer to lower link speed.
>>> +		/*
>>> +		 * If debouncing has not succeeded before dealine, return
>>
>> dea*d*line
>>
>>> +		 * -EPIPE to tell the upper layer to lower the link speed.
>>>    		 */
>>>    		if (time_after(jiffies, deadline))
>>>    			return -EPIPE;
>>
>> One separate for the new check would have been nice, but looks good to
>> me overall.
>>
>>
>> Kind regards,
>>
>> Paul
