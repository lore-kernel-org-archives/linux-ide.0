From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 09/13] sata_mv ncq Use DMA memory pools for hardware memory
 tables
Date: Wed, 30 Jan 2008 13:57:47 -0500
Message-ID: <47A0C8AB.9050505@rtr.ca>
References: <479BC217.60709@rtr.ca> <479BC31D.1050206@rtr.ca> <479F5E1F.8030508@pobox.com> <479F6F40.7040401@rtr.ca> <47A04954.7010306@pobox.com> <47A0A875.1070203@rtr.ca> <47A0AF1F.1070609@pobox.com> <47A0B18C.1060300@rtr.ca> <47A0B7B4.9080502@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4739 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbYA3S5t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 30 Jan 2008 13:57:49 -0500
In-Reply-To: <47A0B7B4.9080502@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Mark Lord wrote:
>> Jeff Garzik wrote:
>>> Mark Lord wrote:
..
>> Bigger stuff that I'm deferring for 2.6.26:
>>
>>  -- Port multiplier support (though this does look rather simple..)
>>  -- power management support
>>  -- ATAPI
> 
> I'm interested to see this :)
..

Heh.. me too, actually.  :)

>>  -- IRQ Coalescing
> 
> Most "modern" SATA has some form of this, but I've yet to see any 
> benefit.  I've dealt with interrupt (packet) rates of well over 500k/sec 
> in network land, and IMO the overhead in storage, even with tiny 
> operations, is really small in comparison.
> 
> So, I'm not sure its worth the latency penalty...  at least as turned on 
> by default.
..

I agree.  It should default to off, and perhaps have some /sys/ attributes
to enable/tune it.  Or something like that.

The theoretical value is apparently for situations like writing to RAID1.
The write isn't really "complete" until all drives ACK it,
so with IRQ coalescing it may behave more like NAPI than one I/O per IRQ.
And NAPI is apparently a win under heavy load for network, so.. we'll see.

The vendor wants it in the driver, and I think it will be good to have it
there so we can play with and tune it -- to find out for real whether it has
worthwhile value or not.  But yes, the default should be "off", I think.

>>  -- Target Mode support (interfaces yet to be defined)
> 
> I would assume this would be along the lines of the SCSI target mode stuff.
..

Ah, now there's a starting point.  Thanks.

>>  -- TCQ support: would be good in general for libata on smart hosts,
>>      but I'm not sure of the impact on libata EH processing.
> 
> Agreed, it would be nice to support host queueing controllers.
> 
> However, specifically for TCQ, it was rather poorly conceived.  For most 
> controllers (mv, broadcom/svw, others) an error will stop the DMA 
> engine, and you perform recovery in software.  All well and good, but 
> figuring out all the states possible during recovery is non-trivial (I 
> looked into it years ago).  Its just messy.
..

So is NCQ EH, but we manage it.  I wonder how similar (or not) the two are?

I've done host-based TCQ several times now, and EH can be as simple as:

"when something goes wrong, just reset everything, and then re-issue the
commands one at a time, doing per-command EH normally.  Then resume TCQ."

That's dumb, but works extremely reliably.

Cheers

