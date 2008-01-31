From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 09/13] sata_mv ncq Use DMA memory pools for hardware memory
 tables
Date: Thu, 31 Jan 2008 12:23:20 +0900
Message-ID: <47A13F28.7050001@gmail.com>
References: <479BC217.60709@rtr.ca> <479BC31D.1050206@rtr.ca> <479F5E1F.8030508@pobox.com> <479F6F40.7040401@rtr.ca> <47A04954.7010306@pobox.com> <47A0A875.1070203@rtr.ca> <47A0AF1F.1070609@pobox.com> <47A0B18C.1060300@rtr.ca> <47A0B7B4.9080502@pobox.com> <47A0C8AB.9050505@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.238]:59514 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753544AbYAaDX2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 22:23:28 -0500
Received: by qb-out-0506.google.com with SMTP id o24so1731562qba.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 19:23:27 -0800 (PST)
In-Reply-To: <47A0C8AB.9050505@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
>> So, I'm not sure its worth the latency penalty...  at least as turned
>> on by default.
> ..
> 
> I agree.  It should default to off, and perhaps have some /sys/ attributes
> to enable/tune it.  Or something like that.

Eeeek.. :-)

> The theoretical value is apparently for situations like writing to RAID1.
> The write isn't really "complete" until all drives ACK it,
> so with IRQ coalescing it may behave more like NAPI than one I/O per IRQ.
> And NAPI is apparently a win under heavy load for network, so.. we'll see.
> 
> The vendor wants it in the driver, and I think it will be good to have it
> there so we can play with and tune it -- to find out for real whether it
> has
> worthwhile value or not.  But yes, the default should be "off", I think.

I'm skeptical about the benefit of IRQ coalescing on storage
controllers.  Coalescing improves performance when there are many small
requests to complete and if you put a lot of small non-consecutive
requests to a disk, it gets really really really slow and IRQ coalescing
just doesn't matter at all.  The only way to achieve high number of
completions is to issue small commands to consecutive addresses which is
just silly.  In storage, high volume transfer is achieved through
request coalescing not completion coalescing and this is true for even SDDs.

>>>  -- Target Mode support (interfaces yet to be defined)
>>
>> I would assume this would be along the lines of the SCSI target mode
>> stuff.
> ..
> 
> Ah, now there's a starting point.  Thanks.

It would be great if we can make a cheap SATA analyzer out of it.

>>>  -- TCQ support: would be good in general for libata on smart hosts,
>>>      but I'm not sure of the impact on libata EH processing.
>>
>> Agreed, it would be nice to support host queueing controllers.
>>
>> However, specifically for TCQ, it was rather poorly conceived.  For
>> most controllers (mv, broadcom/svw, others) an error will stop the DMA
>> engine, and you perform recovery in software.  All well and good, but
>> figuring out all the states possible during recovery is non-trivial (I
>> looked into it years ago).  Its just messy.
> ..
> 
> So is NCQ EH, but we manage it.  I wonder how similar (or not) the two are?

How many devices with working TCQ support are out there?  Early raptors?
 If the controller handles all that releasing and state transitions, I
think is shouldn't be too difficult.  You'll probably need to add TCQ
support to ata_eh_autopsy or roll your own autopsy function but that
should be about it for EH.  Heck, just freezing on any sign of problem
and let EH reset the drive and retry should work for most of the cases
although things like media errors won't be reported properly.

> I've done host-based TCQ several times now, and EH can be as simple as:
> 
> "when something goes wrong, just reset everything, and then re-issue the
> commands one at a time, doing per-command EH normally.  Then resume TCQ."
> 
> That's dumb, but works extremely reliably.

Oh, you were thinking the same thing. :-) It can be made more reliable
by simply falling back to non-TCQ if error repeats itself.  e.g. Media
error -> TCQ freeze -> reset -> media error -> TCQ freeze -> reset and
turn off TCQ -> media error gets handled and reported.  It isn't pretty
but should work for initial implementation.

Thanks.

-- 
tejun
