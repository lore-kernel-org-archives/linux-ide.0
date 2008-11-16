From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: sata_mv, io stucks
Date: Sun, 16 Nov 2008 04:13:28 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0811160412080.27319@p34.internal.lan>
References: <48F88449.1000704@ngs.ru> <49003B9C.1010303@ngs.ru> <4900A12F.3030307@rtr.ca> <491EE84B.1010600@gmail.com> <491F4096.9090701@rtr.ca> <491F5E42.8010906@gmail.com> <491FA4D8.1010708@rtr.ca> <491FA8C0.2090804@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:53705 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbYKPJNa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 04:13:30 -0500
In-Reply-To: <491FA8C0.2090804@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Harri Olin <harri.olin@gmail.com>, linux-ide@vger.kernel.org, Artem Bokhan <aptem@ngs.ru>



On Sat, 15 Nov 2008, Mark Lord wrote:

> Mark Lord wrote:
>> 
>> Yeah, I see what I was missing earlier:   "(timeout)".
>> So it's "none of" the driver paths.
>> 
>> This could very well be due to one/several of the as-yet un-addressed
>> chipset errata for the 6081.  Someday we'll have software workarounds
>> for those, but I'm (still) waiting on Marvell for stuff.
>> 
>> I will look and see if this makes sense based on the errata info
>> that I have already though (under NDA).
>> 
>> Harri / Artem:  what type/speed of slots are your 6081 controllers in?
>> PCI, or PCI-X?   Bus speed?
> ..
>
> Mmm.. Harri at least previously said: 
>> Contoller is Supermicro AOC-SAT2-MV8, connected to 133MHz PCI-X slot on one 
>> computer,
>> 66MHz 64bit PCI slot on the second machine and to normal 32bit PCI slot on 
>> third computer.
> ..
>
> And Artem said:
>> The controller is AOC-SAT2-MV8 too.
> ..

As I mentioned earlier, it happens on all of my drives, 4 of 12 disks are 
connected to a Marvell controller, in my case:

01:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)

It is in the x16 slot.

Justin.

