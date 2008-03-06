From: Mark Lord <liml@rtr.ca>
Subject: Re: Correct use of  ap->lock  versus  ap->host->lock ?
Date: Thu, 06 Mar 2008 13:20:06 -0500
Message-ID: <47D035D6.1060604@rtr.ca>
References: <47D01232.1000106@rtr.ca> <47D01D4B.8000506@pobox.com> <47D02642.8040907@rtr.ca> <47D029BF.8040000@pobox.com> <47D02BB2.9000609@rtr.ca> <47D03080.8070405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1541 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758AbYCFSUH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Mar 2008 13:20:07 -0500
In-Reply-To: <47D03080.8070405@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> There are definitely other fish to fry elsewhere,
>> but don't discount the effect of "a couple register writes",
>> which are frequently done with readbacks to flush them,
>> at a cost equivalent to several thousand CPU cycles per readback.
> 
> Those numbers are for slower PIO, not MMIO as found on new SATA 
> controllers...
> 
> 
>> This prevents new command issue from overlapping interrupt handling
>> for any ports of the same host.  Again, not a biggie today,
>> but tomorrow perhaps..
>>
>> And still probably not worth the fuss on any hardware that has
>> registers shared across multiple ports (eg. Marvell controllers).
> 
> 
> Remember, I come from the land of networking, where we already see over 
> 500k packets per second.  None of this is new stuff.
> 
> In networking you lock both TX submission (analogy: scsi queuecommand) 
> and TX completion (analogy: completion via irq handler), and we don't 
> see any such problems on multi-port controllers.
> 
> It is not worth the fuss on new SATA controllers, which look just like 
> NIC hardware has looked for a decade -- DMA rings, with a single MMIO 
> write (or write+read) to indicate software has new packets for hardware. 
>  Even at exponentially higher FIS rates, locking doesn't become an issue.
..

The big difference here, is that a single SATA controller in a system
can have up to eight quasi-independent ports.  So when we lock, we block
activity on all 8 interfaces, rather than just the one we care about.

At LSF'08 there was much discussion about the coming 100000 ops/second SSDs,
which exist in the marketplace already.  At some point, this stuff will
matter as much for SATA as it did/does for networking.

Cheers
