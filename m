Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EE1C433F5
	for <linux-ide@archiver.kernel.org>; Thu, 20 Jan 2022 00:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiATAOh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 19 Jan 2022 19:14:37 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39812 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiATAOh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jan 2022 19:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642637676; x=1674173676;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h85rcV74lzSikTSf9mxsDUK2SGHcfNwqEA50B40/Vqw=;
  b=p64hcxdJJKHDNQyQkw+ccaWqhmW6jxvOxHgCxxJgghOSumLxEBT+S/wN
   ETKeUu0ZQVlYQMkrEbhTMQzbHY9z24BwdlNbf0s/G/WaHNYE7T9d9eos2
   v0ajRO1+HlGeX9QraxLCScODaiA8pwNVLFhV8hy8kmyuskN8qhKxjGZ/N
   B9G2zLUOsTbAM6Q3A97ESUrXsWOAs2N3tmDew6ipyQSisRmJ8ChMLIKQ6
   TOzkKqldDT19XNVEgx/efW8uEBNYQ03Ek6d/8fy7a3x3X9qa1wjXVrq8k
   amUJ5RVl3G1j7jhO/W87fupyxaKK41setXO3qPm174SREp5kYYCY8jpsJ
   g==;
X-IronPort-AV: E=Sophos;i="5.88,300,1635177600"; 
   d="scan'208";a="294954326"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2022 08:14:36 +0800
IronPort-SDR: PHdaGdwNhHxS/T8KC+pOoZZtcQUK3Sm4+xenuWz2d3m0fEX8IgfCTYsqNDqL3t2a9rEPexUuDD
 EPe/jQdX7azjoC8NDzaJ5pVQb+70gnLRs84K5WQlcsZ/LRtrMVsNGvQdbJJfkatNguvw6zOtsM
 HAbGv31GZxEL/BOPjFWUT7nl61iJOQDrMJCGpi/iH1wNGLR/dhlW3Mj2HWPPlBq4WE1UAcrwbq
 cXHfKrW7CGQKxkcJQnAFEk5nUF3AkGDD57nChsdd+bROsWWlCxlbaYqVMgNNzDB1dLeQ4srZ1G
 wMOrM+cIrk+wSQsDk2Wod+w/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 15:48:06 -0800
IronPort-SDR: 48cZdRw28hV7Hnr3OLLlbdUfWxhLd8cFDZzQlGOQfaKWdeKJ8pMboMakbTau7H//7dy3FMzoQO
 X7pqjofHIIw56ERMGnfH3HzPfVoosVBiLNHVuhg+Gy5Ha3G3eWXprlJGuudrT7Uxam97lAU/cE
 eOJ9aKT+kisq5XhTCYX/rNR+NI3idl/R7/INPkrVDbfI/9k74bDWDA7mCSRwv/7SmgZvKjUklx
 xDU2NR7M6qV3ZDvypbAgNI2OTM4BumXDdfAmrh7j+enfJquMNqwuKIw5ppyoJtuyK5CYB5/sJs
 7hA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 16:14:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JfNL42cvlz1SVp1
        for <linux-ide@vger.kernel.org>; Wed, 19 Jan 2022 16:14:36 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1642637675; x=1645229676; bh=h85rcV74lzSikTSf9mxsDUK2SGHcfNwqEA5
        0B40/Vqw=; b=jEL2AKKJTmew/6V9UgjsXKQmmn3MT8ocqBMOog25KqM2/CWQp0l
        TMUr9o5fbZvAjN8vyQMSi2odTJAK4wAX8VAmcCFpXT8PSaxGXO5z2jp5cFk496OQ
        379u8X8ZjaaP+CwQOpqJYNV6DGYOPfcDbz6vwimSgwdm3A+/nmrk6SuUIA7Ldmeu
        34xSXGShXxeQrZ7LyQBqvRYxXCklvui4EbSPynfXWhxpRUEokz6aBHxTny76Ou57
        47lKUTICmFF5BxSMH+puiA4HT4TNP/grk6CP4jFGJCmR1cZ+BVzApOOR2bvCX5aI
        sxkcS8DyYutHAgYH47EP6ZpwoA7LYpKSgHg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IoDH4IGbfzXt for <linux-ide@vger.kernel.org>;
        Wed, 19 Jan 2022 16:14:35 -0800 (PST)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JfNL31Rsrz1Rwrw;
        Wed, 19 Jan 2022 16:14:34 -0800 (PST)
Message-ID: <5cc9bb8d-e228-c11f-feef-5cfba631057a@opensource.wdc.com>
Date:   Thu, 20 Jan 2022 09:14:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 0/2][RFC] Make delay before debouncing configurable
Content-Language: en-US
To:     "Robin H. Johnson" <robbat2@gentoo.org>, linux-ide@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>
References: <20220113154635.17581-1-pmenzel@molgen.mpg.de>
 <85153d62-15b6-e055-00aa-74b728bb0195@opensource.wdc.com>
 <robbat2-20220119T172913-356389698Z@orbis-terrarum.net>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <robbat2-20220119T172913-356389698Z@orbis-terrarum.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 2022/01/20 2:57, Robin H. Johnson wrote:
> Hi, not originally in the thread, but I've run into hardware where the
> delay was bumpy before, when I did early porting around SATA PMP code
> (https://dev.gentoo.org/~robbat2/patches/libata-development/ if you want
> to see really old patches from 2006)
> 
> This series esp of a code approach that didn't get merged might be
> interesting, that implements hotplug by polling:
> https://dev.gentoo.org/~robbat2/patches/libata-development/2007/00-hp-poll/
> 
> On Fri, Jan 14, 2022 at 06:23:26PM +0900, Damien Le Moal wrote:
>> On 1/14/22 00:46, Paul Menzel wrote:
>>> The 200 ms delay before debouncing the PHY was introduced for some buggy
>>> old controllers. To decrease the boot time to come closer do instant
>>> boot, add a parameter so users can override that delay.
>>>
>>> The current implementation has several drawbacks, and is just a proof of
>>> concept, which some experienced Linux kernel developer can probably
>>> implement in a better way.
>> I do not think that a libata module parameter is not the way to go with
>> this: libata is used by all drivers, so for a system that has multiple
>> adapters, different delays cannot be specified easily.
> I think this is a key thing here; and I like that your patch moves to a
> flag.
> 
>> I am really thinking that the way to go about this is to remove the
>> 200ms delay by default and add it only for drivers that request it with
>> a link flag. That is, ATA_LFLAG_NO_DEBOUNCE_DELAY needs to become
>> ATA_LFLAG_DEBOUNCE_DELAY.
> I agree that removing it by default is right, but I'd like to make one
> additional request here:
> Please add a libata.force= flag that lets users enable/disable the delay
> per adapter/link.
> 
> I think this would be valuable to rule out issues where the debounce
> delay is needed on the drive side more than the controller side, esp. in
> cases of poorly implemented port multipliers as Tejun & I found back in
> 2006.
> 
> Maybe libata.force=X.Y:no_debounce_delay & libata.force=X.Y:force_debounce_delay
> 
> The ata_parse_force_one function as it stands can't handle a parameter
> to the value, so you cannot get libata.force=X.Y:debounce_delay=N
> without also improving ata_parse_force_one.

Good point. I will look into adding this.

> 
>> The other large delay is the link stability check in
>> sata_link_debounce(). 100ms is added (more for hotplug case) to ensure
>> that the SStatus register DET field provides a stable value. But I
>> cannot find any text in the AHCI and SATA IO specs that mandate such
>> large delay.
> Nice find!
> 
>> There are differences between the many HDDs & SSDs I have connected
>> though. There is a lot of scheduling side effects at play, so the gains
>> are variable in my case. A system with a single disk attached should be
>> used for proper evaluation.
> That gets likely single-disk worst/best case, but I'm still worried
> about port multipliers (sadly I don't have the worst-implemented ones
> anymore, I sold them to some Windows users)

:)

I have a e-sata port-multiplier box in the lab. But I need to hook it up to my
test box, which means that I have to get out of home for once and go to the
office :) Will do that. Port-multiplier tests are also needed to complete Hannes
series renaming sysfs fields to match the debug messages.


-- 
Damien Le Moal
Western Digital Research
