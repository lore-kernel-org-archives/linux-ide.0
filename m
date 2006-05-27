From: Mark Lord <liml@rtr.ca>
Subject: Re: jgarzik and max-sectors: out of memory
Date: Sat, 27 May 2006 15:49:31 -0400
Message-ID: <4478AD4B.5090404@rtr.ca>
References: <4478AA6C.5070305@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:39302 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751580AbWE0Ttd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 15:49:33 -0400
In-Reply-To: <4478AA6C.5070305@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>, Hannes Reinecke <hare@suse.de>

Jeff Garzik wrote:
..
> Further -- someone with a long ATA memory correct me -- I think that we 
> can increase ATA_MAX_PRD beyond 256.  Most DMA engines should just keep 
> chugging along, provided that we continue to respect the 64k IDE DMA 
> boundaries.

MAX_PRD used to be equal to MAX_SECTORS, as that's the worst case scenario.
The only real gotcha I remember from the original IDE driver,
was that some (very few) controllers were buggy with handing
of a sector_count of zero (256), so setting the limit to a slightly
lower value prevented that from ever being a problem.

That was in the days before the block layer could limit the segment count.

I don't remember which chipsets had the bug; TRM290 was one,
but that never really worked well anyway, and nobody other than
myself seemed to have one of those cards.  Mmm.. Possibly the
Pacific Digital ADMA-100 here as well.. I can look that one up
if I can find the old box full of cards/docs..

Cheers
