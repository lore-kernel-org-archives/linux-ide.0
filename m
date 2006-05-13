From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
Date: Sat, 13 May 2006 00:13:39 -0400
Message-ID: <44655CF3.5010101@garzik.org>
References: <20060512132437.GB4219@htj.dyndns.org> <20060512122116.152fbe80.rdunlap@xenotime.net> <4464E079.1070307@stesmi.com> <446505F8.7020909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:26338 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932323AbWEMENn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 May 2006 00:13:43 -0400
In-Reply-To: <446505F8.7020909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Stefan Smietanowski wrote:
>> Randy.Dunlap wrote:
>>>> * New error handling
>>>> * IRQ driven PIO (from Albert Lee)
>>>> * SATA NCQ support
>>>> * Hotplug support
>>>> * Port Multiplier support
>>>
>>> BTW, we often use PM to mean Power Management.
>>> Could we find a different acronym for Port Multiplier support,
>>> such as PMS or PX or PXS?
>>
>> Ok, maybe not PMS ?
>>
>> Can you imagine a bug report from someone that "has problem with PMS"?
>> :)
>>
> 
> Would be fun though.  :)
> 
> I thought about using another acronym for port multiplier too.  But the 
> spec uses that acronym all over the place, PM, PMP (Port Multiplier 
> Portnumber), which reminds me of USB full/high speed fiasco.
> 
> Urghh... I thought we could use power for power management inside libata 
> but that might be a bad idea.  So, PMS?

PMS is fine.  I encouraged the use of "UFO" for "UDP Fragmentation 
Offload" in network driver land, and it stuck.

This is Linux, we like to have fun around here :)

	Jeff



