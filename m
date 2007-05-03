From: Mark Lord <liml@rtr.ca>
Subject: Re: [Fwd: Re: PATCH: libata: add support for ATA_16 on ATAPI]
Date: Thu, 03 May 2007 09:34:10 -0400
Message-ID: <4639E4D2.5080108@rtr.ca>
References: <46394ADA.1020400@rtr.ca> <4639D324.5090908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4989 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754180AbXECNeN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 May 2007 09:34:13 -0400
In-Reply-To: <4639D324.5090908@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Jeff?
>> This has been pending for a very long time now.
>>
>> This patch brings libata up to similar standards as Linux IDE
>> with support for things like hdparm -I (identify) and -C (check power)
>> among others on ATAPI drives.
>>
>> Andrew, can you pick this up for -mm ??
>>
>> ???
> 
> My reluctance stems mainly from the modifications to the hot path.  ATA 
> and ATAPI need wholly different command simulations, so I don't like 
> your modification of sending both ATA and ATAPI devices to the same 
> simulation function -- only to have to disambiguate with an ATA-or-ATAPI 
> test.
> 
> I would rather keep the branch in the queuecommand hook the same.  That 
> should keep the ATA device callpath unchanged, while enabling what you 
> want on the ATAPI callpath.

Sure thing.  Just elaborate a teensy bit more on what's going on inside
Jeff's mind, and I'll code something up to mimic.

Thanks.
