From: Mark Lord <liml@rtr.ca>
Subject: Re: Correct use of  ap->lock  versus  ap->host->lock ?
Date: Thu, 06 Mar 2008 12:24:21 -0500
Message-ID: <47D028C5.9070509@rtr.ca>
References: <47D01232.1000106@rtr.ca> <47D01D4B.8000506@pobox.com> <47D02642.8040907@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4244 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755514AbYCFRYX (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Mar 2008 12:24:23 -0500
In-Reply-To: <47D02642.8040907@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Mark Lord wrote:
>>> Jeff / Tejun / Alan,
>>>
>>> I'm trying to sort out the spinlocks in sata_mv.
>>>
>>> In some places, the existing code uses ap->lock.
>>> But in others, notably the interrupt handling, it uses ap->host->lock.
>>>
>>> This looks buggy to me, and I'm wondering how to make it bulletproof.
>>
>> Look closely, there is only one lock.  ata_port does not have a 
>> spinlock, just a pointer...
> ..
> 
> Ahh.. in ata_port_alloc().  Thanks.
..

Okay.  Does the LLD even need to bother with this lock
in the various pre/soft/hard reset routines ?

I don't think so, but sata_mv currently tries to lock there.

???
