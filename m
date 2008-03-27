From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCHSET #upstream] libata: improve FLUSH error handling
Date: Thu, 27 Mar 2008 10:35:11 -0400
Message-ID: <47EBB09F.9070607@rtr.ca>
References: <12066128663306-git-send-email-htejun@gmail.com> <47EBAE2B.8070102@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2286 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759874AbYC0OfM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Mar 2008 10:35:12 -0400
In-Reply-To: <47EBAE2B.8070102@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Mark Lord wrote:
..
> Absolute theoretical worst case for a drive with a buffer 4X the largest
> current size:  328 seconds.  Not taking into account having bad-sector
> retries for each of those I/O blocks, but *nobody* is going to wait
> that long anyway.  They'll have long since pulled the power cord or 
> reached for the BIG RED BUTTON.
..

Speaking of which.. these are all WRITEs.

In 18 years of IDE/ATA development,
I have *never* seen a hard disk drive report a WRITE error.

Which makes sense, if you think about it -- it's rewriting the sector
with new ECC info, so it *should* succeed.  The only case where it won't,
is if the sector has been marked as "bad" internally, and the drive is
too dumb to try anyways after it runs out of remap space.

In which case we've already lost data, and taking more than a hundred
and twenty seconds isn't going to make a serious difference.

Mmm.. anyone got a spare modern-ish drive to risk destroying?
Say, one of the few still-functioning DeathStars, or an buggy-NCQ Maxtor ?

If so, it might be fun to try and produce a no-more-remaps scenario on it.
One could use "hdparm --make-bad-sector" to corrupt a few hundred/thousand
sectors in a row (sequentially numbered).

Then loop and attempt to read from them individually with "hdparm --read-sector"
(should fail on all, but it might force the drive to remap them).

Then finally try and write back to them with "hdparm --write-sector",
and see if a WRITE ERROR is ever reported.  Maybe time the individual WRITEs
to see if any of them take more than a few milliseconds.

Perhaps try this whole thing with/without the write cache enabled.

Mmm...

Cheers
