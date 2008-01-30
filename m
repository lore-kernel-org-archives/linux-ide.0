From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 09/13] sata_mv ncq Use DMA memory pools for hardware memory
 tables
Date: Wed, 30 Jan 2008 12:45:24 -0500
Message-ID: <47A0B7B4.9080502@pobox.com>
References: <479BC217.60709@rtr.ca> <479BC31D.1050206@rtr.ca> <479F5E1F.8030508@pobox.com> <479F6F40.7040401@rtr.ca> <47A04954.7010306@pobox.com> <47A0A875.1070203@rtr.ca> <47A0AF1F.1070609@pobox.com> <47A0B18C.1060300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43959 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759439AbYA3Rp2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jan 2008 12:45:28 -0500
In-Reply-To: <47A0B18C.1060300@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Mark Lord wrote:
>>> Meanwhile, no further action required here.
>>
>> ACK :)
>>
>> And thanks for rounding out the NCQ work.  sata_mv has needed love and 
>> attention for a while (well, really, its entire life).
> ..
> 
> Well, it's going to be getting plenty of TLC over the next few months.
> 
> In the short term, my plan is to submit further small patches to fix
> the IRQ and error-handling in sata_mv, as bug fixes for 2.6.25.
> 
> Note that hot plug/unplug will begin to work correctly once the IRQ/EH
> code gets fixed (it sort of works already, but sometimes kills the 
> machine).
> 
> There are also some errata that need to be addressed in the 2.6.25 
> timeframe.
> 
> In particular, there's an NCQ EH errata for the 60x1 chips,
> and a tricky issue about HOB access not working correctly on
> most versions of the chips.
> 
> Bigger stuff that I'm deferring for 2.6.26:
> 
>  -- Port multiplier support (though this does look rather simple..)
>  -- power management support
>  -- ATAPI

I'm interested to see this :)

>  -- IRQ Coalescing

Most "modern" SATA has some form of this, but I've yet to see any 
benefit.  I've dealt with interrupt (packet) rates of well over 500k/sec 
in network land, and IMO the overhead in storage, even with tiny 
operations, is really small in comparison.

So, I'm not sure its worth the latency penalty...  at least as turned on 
by default.


>  -- Target Mode support (interfaces yet to be defined)

I would assume this would be along the lines of the SCSI target mode stuff.


>  -- TCQ support: would be good in general for libata on smart hosts,
>      but I'm not sure of the impact on libata EH processing.

Agreed, it would be nice to support host queueing controllers.

However, specifically for TCQ, it was rather poorly conceived.  For most 
controllers (mv, broadcom/svw, others) an error will stop the DMA 
engine, and you perform recovery in software.  All well and good, but 
figuring out all the states possible during recovery is non-trivial (I 
looked into it years ago).  Its just messy.

	Jeff


