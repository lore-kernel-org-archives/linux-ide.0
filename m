From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] libata: new EH, NCQ, hotplug and PM patches against
 stable kernel
Date: Sat, 13 May 2006 07:02:32 +0900
Message-ID: <446505F8.7020909@gmail.com>
References: <20060512132437.GB4219@htj.dyndns.org> <20060512122116.152fbe80.rdunlap@xenotime.net> <4464E079.1070307@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.199]:46203 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932254AbWELWC5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 12 May 2006 18:02:57 -0400
Received: by nz-out-0102.google.com with SMTP id 13so567738nzn
        for <linux-ide@vger.kernel.org>; Fri, 12 May 2006 15:02:56 -0700 (PDT)
In-Reply-To: <4464E079.1070307@stesmi.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Stefan Smietanowski wrote:
> Randy.Dunlap wrote:
>>> * New error handling
>>> * IRQ driven PIO (from Albert Lee)
>>> * SATA NCQ support
>>> * Hotplug support
>>> * Port Multiplier support
>>
>> BTW, we often use PM to mean Power Management.
>> Could we find a different acronym for Port Multiplier support,
>> such as PMS or PX or PXS?
> 
> Ok, maybe not PMS ?
> 
> Can you imagine a bug report from someone that "has problem with PMS"?
> :)
> 

Would be fun though.  :)

I thought about using another acronym for port multiplier too.  But the 
spec uses that acronym all over the place, PM, PMP (Port Multiplier 
Portnumber), which reminds me of USB full/high speed fiasco.

Urghh... I thought we could use power for power management inside libata 
but that might be a bad idea.  So, PMS?

-- 
tejun
