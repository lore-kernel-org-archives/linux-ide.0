From: Mark Lord <lkml@rtr.ca>
Subject: Re: SATA: Marvell 88SE6141 support?
Date: Thu, 15 Jun 2006 14:38:06 -0400
Message-ID: <4491A90E.8010702@rtr.ca>
References: <A6F7DE24-36C7-4FDB-AB2A-2C63478F0D0A@smarttech.com> <44916C5B.5000402@rtr.ca> <44917BFE.1070604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:42682 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1031053AbWFOSiJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Jun 2006 14:38:09 -0400
In-Reply-To: <44917BFE.1070604@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Gord Peters <GordPeters@smarttech.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Gord Peters wrote:
>>> Hi,
>>>
>>> I was just wondering what the status of development is in regard to 
>>> support for the Marvell 88SE6141 (ie. mv61xx) SATA-II controller is?  
>>> This particular controller is included on the Asus P5WD2-E Premium 
>>> motherboard.
>>
>> First I've heard of it.  Can you find docs for it?
>> If so, post a link to them, and we'll have a look to see what is 
>> different from the 60xx series.
> 
> I would be willing to bet that it's either GEN-IIE or something that 
> sata_mv doesn't cover at all (like AHCI).

Yeah, could be.

Except I'd expect a more major change in their numbering scheme for that,
but, hey, who can predict what the marketing folks would do!

The motherboard description says something about it being Marvell's latest
chipset, with four SATA plus one PATA ports.  That'll be interesting..

Cheers  
