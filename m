From: Ric Wheeler <ric@emc.com>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Thu, 27 Mar 2008 14:01:11 -0400
Message-ID: <47EBE0E7.9070205@emc.com>
References: <12066128663306-git-send-email-htejun@gmail.com> <47EBAE2B.8070102@rtr.ca> <47EBB09F.9070607@rtr.ca>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:44489 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015AbYC0SLp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 14:11:45 -0400
In-Reply-To: <47EBB09F.9070607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk



Mark Lord wrote:
> Mark Lord wrote:
> ..
>> Absolute theoretical worst case for a drive with a buffer 4X the largest
>> current size:  328 seconds.  Not taking into account having bad-sector
>> retries for each of those I/O blocks, but *nobody* is going to wait
>> that long anyway.  They'll have long since pulled the power cord or 
>> reached for the BIG RED BUTTON.
> ..
> 
> Speaking of which.. these are all WRITEs.
> 
> In 18 years of IDE/ATA development,
> I have *never* seen a hard disk drive report a WRITE error.

I have seen them in the wild.

> 
> Which makes sense, if you think about it -- it's rewriting the sector
> with new ECC info, so it *should* succeed.  The only case where it won't,
> is if the sector has been marked as "bad" internally, and the drive is
> too dumb to try anyways after it runs out of remap space.
> 
> In which case we've already lost data, and taking more than a hundred
> and twenty seconds isn't going to make a serious difference.

You can definitely start failing writes once your remapped sector table is 
exhausted, but to your point, that drive is usually in bad shape at this point 
in time.

That makes it more important to fail quickly so that we don't hang waiting for 
something that is most likely to be on its last legs...

> 
> Mmm.. anyone got a spare modern-ish drive to risk destroying?
> Say, one of the few still-functioning DeathStars, or an buggy-NCQ Maxtor ?
> 
> If so, it might be fun to try and produce a no-more-remaps scenario on it.
> One could use "hdparm --make-bad-sector" to corrupt a few hundred/thousand
> sectors in a row (sequentially numbered).

I don't think that this will do it. What happens with our sector corruption, I 
believe, is that we corrupt the data integrity bits around the sector. Once we 
write, that original sector is repaired since the drive overwrites the junk bits 
we gave it.  The remapped sector count should not be growing (but it is worth 
checking to verify my theory ;-)).

You have my blessing to be mean to a drive that you got from me if that helps ;-)

> 
> Then loop and attempt to read from them individually with "hdparm 
> --read-sector"
> (should fail on all, but it might force the drive to remap them).

Again, I don't think that reads will ever force a remap.

> 
> Then finally try and write back to them with "hdparm --write-sector",
> and see if a WRITE ERROR is ever reported.  Maybe time the individual 
> WRITEs
> to see if any of them take more than a few milliseconds.
> 
> Perhaps try this whole thing with/without the write cache enabled.
> 
> Mmm...
> 
> Cheers

ric

