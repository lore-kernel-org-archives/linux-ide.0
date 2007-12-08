From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB (v3)
Date: Sat, 08 Dec 2007 12:36:26 -0600
Message-ID: <475AE42A.9040400@shaw.ca>
References: <47463534.9010100@shaw.ca> <4755D1E4.3020601@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:54390 "EHLO
	pd4mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683AbXLHShm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Dec 2007 13:37:42 -0500
In-reply-to: <4755D1E4.3020601@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> Robert Hancock wrote:
>> This fixes some problems with ATAPI devices on nForce4 controllers in 
>> ADMA mode
>> on systems with memory located above 4GB. We need to delay setting the 
>> 64-bit
>> DMA mask until the PRD table and padding buffer are allocated so that 
>> they don't
>> get allocated above 4GB and break legacy mode (which is needed for ATAPI
>> devices).
>>
>> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
> 
> This is a bit nasty :/
> 
> I would consider setting the consistent DMA mask to 32-bit, and setting 
> the overall mask to 64-bit.
> 
> Seems like that would solve the problem?
> 
> Also, does this need to be rebased on top of what I just pushed upstream?
> 
>     Jeff

Jeff, ping on this one? This (or, one like it) really should make it 
into 2.6.24..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

