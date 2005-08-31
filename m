From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: add ATAPI module option
Date: Tue, 30 Aug 2005 21:52:36 -0400
Message-ID: <43150D64.1060208@pobox.com>
References: <20050830215234.GA6991@havoc.gtf.org> <4314F1C8.8040706@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:41676 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932330AbVHaBwv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2005 21:52:51 -0400
In-Reply-To: <4314F1C8.8040706@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Mark Lord wrote:
> Jeff Garzik wrote:
> 
>>
>> -#ifndef ATA_ENABLE_ATAPI
>> -    if (unlikely(dev->class == ATA_DEV_ATAPI))
>> -        return NULL;
>> -#endif
>> +    if (atapi_enabled) {
>> +        if (unlikely(dev->class == ATA_DEV_ATAPI))
>> +            return NULL;
>> +    }
> 
> ..
> 
> Is that if-stmt the right way around?
> At first glance, I'd expect it to read:
> 
>      if (!atapi_enabled) {
>      ...
> 
> Cheers!

Indeed, thanks, fixed.

	Jeff



