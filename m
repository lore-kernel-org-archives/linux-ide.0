From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
Date: Sat, 13 May 2006 16:29:07 +0900
Message-ID: <44658AC3.6070400@gmail.com>
References: <20060512132437.GB4219@htj.dyndns.org> <20060512122116.152fbe80.rdunlap@xenotime.net> <4464E079.1070307@stesmi.com> <446505F8.7020909@gmail.com> <44655CF3.5010101@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:61444 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932374AbWEMH3N (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 03:29:13 -0400
Received: by wr-out-0506.google.com with SMTP id i22so652578wra
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 00:29:12 -0700 (PDT)
In-Reply-To: <44655CF3.5010101@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Stefan Smietanowski wrote:
>>> Randy.Dunlap wrote:
>>>>> * New error handling
>>>>> * IRQ driven PIO (from Albert Lee)
>>>>> * SATA NCQ support
>>>>> * Hotplug support
>>>>> * Port Multiplier support
>>>>
>>>> BTW, we often use PM to mean Power Management.
>>>> Could we find a different acronym for Port Multiplier support,
>>>> such as PMS or PX or PXS?
>>>
>>> Ok, maybe not PMS ?
>>>
>>> Can you imagine a bug report from someone that "has problem with PMS"?
>>> :)
>>>
>>
>> Would be fun though.  :)
>>
>> I thought about using another acronym for port multiplier too.  But 
>> the spec uses that acronym all over the place, PM, PMP (Port 
>> Multiplier Portnumber), which reminds me of USB full/high speed fiasco.
>>
>> Urghh... I thought we could use power for power management inside 
>> libata but that might be a bad idea.  So, PMS?
> 
> PMS is fine.  I encouraged the use of "UFO" for "UDP Fragmentation 
> Offload" in network driver land, and it stuck.
> 
> This is Linux, we like to have fun around here :)
> 

Currently, the candidates are...

px	: short (good), but I don't know, not pretty
pmul	: okay but a bit too long
pml	: pretty and official
pms	: pretty and fun

I think I'll go with either pms or pml.  Man, this decision is difficult.

-- 
tejun
