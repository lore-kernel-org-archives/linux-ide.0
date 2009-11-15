From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: Add ALPM power state accounting to the AHCI driver
Date: Sun, 15 Nov 2009 03:27:33 -0500
Message-ID: <4AFFBB75.7050601@pobox.com>
References: <20091113192429.4dfc9c39@infradead.org> <4AFFB65F.3020201@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49037 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751656AbZKOI1n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Nov 2009 03:27:43 -0500
In-Reply-To: <4AFFB65F.3020201@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

On 11/15/2009 03:05 AM, Tejun Heo wrote:
> 11/14/2009 12:24 PM, Arjan van de Ven wrote:
>>  From f62ff8c98080b4a9e66f82f793145b863b4e183a Mon Sep 17 00:00:00 2001
>> From: Arjan van de Ven<arjan@linux.intel.com>
>> Date: Fri, 13 Nov 2009 16:54:37 -0800
>> Subject: [PATCH] libata: Add ALPM power state accounting to the AHCI driver
>>
>> PowerTOP wants to show the user how effective the ALPM link
>> power management is for the user. ALPM is worth around 0.5W on a quiet
>> link; PowerTOP wants to be able to find and expose cases where the "quiet link"
>> isn't actually quiet.
>>
>> This patch adds state accounting functionality to the AHCI driver for
>> PowerTOP to use.
>> The parts of the patch are
>> 1) the sysfs logic of exposing the stats for each state in sysfs
>> 2) the basic accounting logic that gets update on link change interrupts
>>     (or when the user accesses the info from sysfs)
>> 3) a "accounting enable" flag; in order to get the accounting to work,
>>     the driver needs to get phyrdy interrupts on link status changes.
>>     Normally and currently this is disabled by the driver when ALPM is
>>     on (to reduce overhead); when PowerTOP is running this will need
>>     to be on to get usable statistics... hence the sysfs tunable.
>>
>> The PowerTOP output currently looks like this:
>>
>> Recent SATA AHCI link activity statistics
>> Active	Partial	Slumber	Device name
>>    0.5%	 99.5%	  0.0%	host0
>>
>> (work to resolve "host0" to a more human readable name is in progress in PowerTOP)
>
> Most of logic seems to belong to libata generic part rather than in
> ahci itself.  Wouldn't it be better to implement the thing as generic
> libata feature which ahci uses?

I had pretty much the same comment, on IRC.  The accounting variables 
should probably live in struct ata_link, or a subsidiary (struct 
ata_link_accounting ?).

What little there is of driver-specific behavior can be handled from 
existing callbacks (->enable_pm) or by creating a driver-specific 
function that calls a generic function (eg. ahci_alpm_set_accounting 
could call ata_alpm_set_accounting, before twiddling AHCI's PORT_IRQ_MASK).

	Jeff


