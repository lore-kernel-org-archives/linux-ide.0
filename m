From: Matthew Frost <artusemrys@sbcglobal.net>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
Date: Fri, 12 May 2006 20:38:35 -0500
Message-ID: <4465389B.3070606@sbcglobal.net>
References: <20060512132437.GB4219@htj.dyndns.org> <20060512122116.152fbe80.rdunlap@xenotime.net> <4464E079.1070307@stesmi.com> <446505F8.7020909@gmail.com> <4465264D.6050608@stesmi.com>
Reply-To: artusemrys@sbcglobal.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:21601 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751315AbWEMBhc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 May 2006 21:37:32 -0400
In-Reply-To: <4465264D.6050608@stesmi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Tejun Heo <htejun@gmail.com>, "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Stefan Smietanowski wrote:
> Tejun Heo wrote:
>> Stefan Smietanowski wrote:
>>
>>> Randy.Dunlap wrote:
>>>
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
>> Would be fun though.  :)
>>
>> I thought about using another acronym for port multiplier too.  But the
>> spec uses that acronym all over the place, PM, PMP (Port Multiplier
>> Portnumber), which reminds me of USB full/high speed fiasco.
>>
>> Urghh... I thought we could use power for power management inside libata
>> but that might be a bad idea.  So, PMS?
> 
> Actually, pmup?
> 
> Sort of describes what it is at the same time. (Alot easier to figure
> out what pmup is than what pms is (in a computer :))
> 

Or PMUL?  MUL is in common usage for the arithmetic multiply sense; 
wouldn't it make sense in the Port Multiplier sense?  Would it get too 
confused with FPMUL?  Too much like an arithmetic operator?

> // Stefan

Matt
