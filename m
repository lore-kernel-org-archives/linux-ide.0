From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 03/12] sata_mv wait for empty+idle
Date: Fri, 02 May 2008 16:09:10 -0400
Message-ID: <481B74E6.9020908@rtr.ca>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca>	 <481AAFE0.9090101@rtr.ca> <481AB00A.3000206@rtr.ca>	 <da824cf30805020942q27466cbbk5c7877d6caa6c3d1@mail.gmail.com>	 <481B5334.7030200@rtr.ca> <da824cf30805021139p1e859419u38d7b808e4f8a06e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1433 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764829AbYEBUJM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 May 2008 16:09:12 -0400
In-Reply-To: <da824cf30805021139p1e859419u38d7b808e4f8a06e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Grant Grundler wrote:
> On Fri, May 2, 2008 at 10:45 AM, Mark Lord <liml@rtr.ca> wrote:
>> Grant Grundler wrote:
>..
>>> BTW, I have no idea when EDMA stops on it's own or if we could
>>> safely get EDMA to stop "prematurely" (e.g. disable PCI Bus Master).
..
>>  I don't know what you're talking about there.
> 
> I don't either. :)
..

Well, when we hit the disable bit, it stops fairly quickly.
The (existing) code still polls it there, but generally
it does stop without much fuss.

Another way to stop it is to just go and hit EDMA_RESET (ATA_RST),
which immediately kills everything.  The datasheet recommends against it,
but doesn't say why (disruption to packets in flight and possibly messing
up drive write cache and the like).

But the current code now tries for a more graceful shutdown,
with firm time limits.

I particularly like the new NCQ error-handling for FBS,
which allows activity on the non-failed links to quiesce
before beginning the EH/reset/recovery sequence.
Much less disruptive to the non-failing drives that way.

There's still an errata or two with some of the chips
that may prevent the full EH from working there sometimes.
The READ_LOG_EXT_10H may fail, meaning we might not report
the failed LBA number back up the stack.  With a bit of luck,
we'll tack that down once we learn the workaround.

Cheers
