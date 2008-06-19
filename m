From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 02/02] sata_mv: warn on PIO with multiple DRQs
Date: Wed, 18 Jun 2008 21:44:02 -0400
Message-ID: <4859B9E2.4060909@rtr.ca>
References: <485933A4.3010409@rtr.ca> <4859340E.60203@rtr.ca> <4859A886.8000509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1444 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbYFSBoG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 21:44:06 -0400
In-Reply-To: <4859A886.8000509@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Chip errata sometimes prevents reliable use of PIO commands which involve
>> more than a single DRQ (data request).  In normal operation, libata 
>> should
>> not generate such PIO commands (uses DMA instead), but they could be sent
>> in via SG_IO from userspace.
>>
>> A full workaround might be to break up such commands into sequences
>> of single DRQ ones, but that's just way too complex for something
>> that doesn't normally happen in real life.
>>
>> So, allow the attempt (it often works, despite the errata),
>> but log the event for reference when somebody screams.
>>
>> Signed-off-by: Mark Lord <mlord@pobox.com>
> 
> 
> applied patches 1-2
> 
> 
> 
>> Tejun/Alan/Jeff:
>>
>> We may also want a patch to prevent libata-eh from downshifting
>> all the way to PIO on these chipsets, but I am not sure how to
>> accomplish that from inside sata_mv.  Any suggestions?
> 
> Do we really want that?  Seems to me we need that for older bridged PATA 
> devices attached to a SATA bridge.
..

Just about everything can do some form of DMA nowadays,
but regardless of that the sata_mv chipsets have errata
for PIO of anything more than a single sector.

In practice, I haven't managed to trigger the issue here,
but the errata descriptions indicate that it should be a major
issue for any volume of multi-sector PIO commands.

Cheers
