From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: libata FUA revisited
Date: Mon, 19 Feb 2007 13:46:03 -0600
Message-ID: <45D9FE7B.60909@shaw.ca>
References: <fa.S80SRyQbD/hm4SxliPUKU88BaCo@ifi.uio.no>
 <fa.Q/csgyCHkAsD84yi+bN78H1WNNM@ifi.uio.no> <45D104F3.7040602@shaw.ca>
 <45D1D72D.9020509@gmail.com> <45D252CD.5010303@shaw.ca>
 <45D25CF2.5030508@gmail.com> <20070215180023.GA4438@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:29018 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbXBSTqc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Feb 2007 14:46:32 -0500
In-reply-to: <20070215180023.GA4438@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, edmudama@gmail.com, Nicolas.Mailhot@LaPoste.net, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Mark Lord <mlord@pobox.com>

Jens Axboe wrote:
> But we can't really change that, since you need the cache flushed before
> issuing the FUA write. I've been advocating for an ordered bit for
> years, so that we could just do:
> 
> 3. w/FUA+ORDERED
> 
> normal operation -> barrier issued -> write barrier FUA+ORDERED
>  -> normal operation resumes
> 
> So we don't have to serialize everything both at the block and device
> level. I would have made FUA imply this already, but apparently it's not
> what MS wanted FUA for, so... The current implementations take the FUA
> bit (or WRITE FUA) as a hint to boost it to head of queue, so you are
> almost certainly going to jump ahead of already queued writes. Which we
> of course really do not.

I think that FUA was designed for a different use case than what Linux 
is using barriers for currently. The advantage with FUA is when you have 
"before barrier", "after barrier" and "don't care" sets, where only the 
specific things you care about ordering are in the before/after barrier 
sets. Then you can do this:

Issue all before barrier requests with FUA bit set
Wait for all those to complete
Issue all after barrier requests with FUA bit set
Wait for all those to complete

Meanwhile a bunch of "don't care" requests could be going through on the 
device in the background. If we could do this, then I think there would 
be an advantage. Right now, it just saves a command to the drive when 
we're flushing on the post-barrier writes.

This would only be efficient with NCQ FUA, because regular FUA forces 
the requests to complete serially, whereas in this case we don't really 
care what order the individual requests finish, we just care about the 
ordering of the pre vs. post barrier requests.

> I'm not too nervous about the FUA write commands, I hope we can safely
> assume that if you set the FUA supported bit in the id AND the write fua
> command doesn't get aborted, that FUA must work. Anything else would
> just be an immensely stupid implementation. NCQ+FUA is more tricky, I
> agree that it being just a command bit does make it more likely that it
> could be ignored. And that is indeed a danger. Given state of NCQ in
> early firmware drives, I would not at all be surprised if the drive
> vendors screwed that up too.
> 
> But, since we don't have the ordered bit for NCQ/FUA anyway, we do need
> to drain the drive queue before issuing the WRITE/FUA. And at that point
> we may as well not use the NCQ command, just go for the regular non-NCQ
> FUA write. I think that should be safe.

Aside from the issue above, as I mentioned elsewhere, lots of NCQ drives 
don't support non-NCQ FUA writes..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

