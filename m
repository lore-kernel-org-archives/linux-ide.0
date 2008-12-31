From: Mark Lord <liml@rtr.ca>
Subject: Re: PIO with SSDs: needs a long DRQ-after-command timeout for WRITEs
Date: Wed, 31 Dec 2008 11:29:17 -0500
Message-ID: <495B9DDD.2020109@rtr.ca>
References: <495A27E3.50801@rtr.ca> <20081230135902.560267dc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:51176 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754923AbYLaQ1r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Dec 2008 11:27:47 -0500
In-Reply-To: <20081230135902.560267dc@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> So.. how long does libata and current IDE allow for initial DRQ assertion?
>> It should probably be at least 500msec or more now.
> 
> I think we need to rewrite the PIO code paths to use disable/enable_irq
> masking first before getting into adding long delays on PIO paths.
..

Yeah, that would be a good thing to do.
But in the meanwhile, a longer timeout there doesn't affect
any currently working systems -- they'll still wait only as long
as they currently do.  And a longer timeout *will* enable these
SSDs to work where they otherwise would not.

But perhaps the timeout is already long enough?
I don't know where the current timeout is hiding in libata.  :)

Cheers

