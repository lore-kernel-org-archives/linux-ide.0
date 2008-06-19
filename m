From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 02/02] sata_mv: warn on PIO with multiple DRQs
Date: Wed, 18 Jun 2008 22:00:29 -0400
Message-ID: <4859BDBD.8000007@rtr.ca>
References: <485933A4.3010409@rtr.ca> <4859340E.60203@rtr.ca> <4859A886.8000509@pobox.com> <4859B9E2.4060909@rtr.ca> <4859BCE8.4060408@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3494 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbYFSCAa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jun 2008 22:00:30 -0400
In-Reply-To: <4859BCE8.4060408@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Just about everything can do some form of DMA nowadays,
>> but regardless of that the sata_mv chipsets have errata
>> for PIO of anything more than a single sector.
>>
>> In practice, I haven't managed to trigger the issue here,
>> but the errata descriptions indicate that it should be a major
>> issue for any volume of multi-sector PIO commands.
> 
> 
> I need to review the state of PIO-multi, but IIRC it's not used by default.
> 
> We should be able to handle this errata without banning all PIO...
..

I'm not really all that worried about it.
But it affects *non multi* PIO as well -- anything that can generate
more than a single DRQ per command-issue.

So a READ_SECTORS or WRITE_SECTORS (pio) for anything more than
a single sector could do it, in theory.

If we *really* care, then I'll dig into it deeper in the next kernel.
It can be worked around in the IRQ handler, by taking great care in
the exact sequence of IRQ-arrival and DRQ-status checks.

Heck.. we might even have it right (by accident) today.

Cheers
