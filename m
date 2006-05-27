From: Jeff Garzik <jeff@garzik.org>
Subject: Re: jgarzik and max-sectors: out of memory
Date: Sat, 27 May 2006 16:02:06 -0400
Message-ID: <4478B03E.9060202@garzik.org>
References: <4478AA6C.5070305@garzik.org> <4478AD4B.5090404@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35983 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964931AbWE0UCK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 16:02:10 -0400
In-Reply-To: <4478AD4B.5090404@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>, Hannes Reinecke <hare@suse.de>

Mark Lord wrote:
> Jeff Garzik wrote:
> ..
>> Further -- someone with a long ATA memory correct me -- I think that 
>> we can increase ATA_MAX_PRD beyond 256.  Most DMA engines should just 
>> keep chugging along, provided that we continue to respect the 64k IDE 
>> DMA boundaries.
> 
> MAX_PRD used to be equal to MAX_SECTORS, as that's the worst case scenario.

Not for lba48, which has a larger max-sectors but is still clamped to 
the same 256 PRD entries...


> The only real gotcha I remember from the original IDE driver,
> was that some (very few) controllers were buggy with handing
> of a sector_count of zero (256), so setting the limit to a slightly
> lower value prevented that from ever being a problem.

Yeah, a couple of Alan's PATA drivers are fixed at 255.


> That was in the days before the block layer could limit the segment count.

Ahhhhh, useful to know.

	Jeff


