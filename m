From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv, io stucks
Date: Sat, 15 Nov 2008 23:59:44 -0500
Message-ID: <491FA8C0.2090804@rtr.ca>
References: <48F88449.1000704@ngs.ru> <49003B9C.1010303@ngs.ru> <4900A12F.3030307@rtr.ca> <491EE84B.1010600@gmail.com> <491F4096.9090701@rtr.ca> <491F5E42.8010906@gmail.com> <491FA4D8.1010708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:53031 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbYKPE6z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Nov 2008 23:58:55 -0500
In-Reply-To: <491FA4D8.1010708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri Olin <harri.olin@gmail.com>
Cc: linux-ide@vger.kernel.org, Artem Bokhan <aptem@ngs.ru>

Mark Lord wrote:
>
> Yeah, I see what I was missing earlier:   "(timeout)".
> So it's "none of" the driver paths.
> 
> This could very well be due to one/several of the as-yet un-addressed
> chipset errata for the 6081.  Someday we'll have software workarounds
> for those, but I'm (still) waiting on Marvell for stuff.
> 
> I will look and see if this makes sense based on the errata info
> that I have already though (under NDA).
> 
> Harri / Artem:  what type/speed of slots are your 6081 controllers in?
> PCI, or PCI-X?   Bus speed?
..

Mmm.. Harri at least previously said: 
> Contoller is Supermicro AOC-SAT2-MV8, connected to 133MHz PCI-X slot on one computer,
> 66MHz 64bit PCI slot on the second machine and to normal 32bit PCI slot on third computer.
..

And Artem said:
> The controller is AOC-SAT2-MV8 too.
..

So I guess I need to know if Artem is using PCI-X, and the bus width + speed.

Cheers
