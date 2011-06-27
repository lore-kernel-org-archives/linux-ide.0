From: Marc MERLIN <marc@merlins.org>
Subject: Re: decoding PMP errors with Marvel SATA controller
Date: Sun, 26 Jun 2011 17:06:14 -0700
Message-ID: <20110627000614.GA5362@merlins.org>
References: <20110626070820.GC24867@merlins.org> <20110626090309.GA12200@mtj.dyndns.org> <4E076E9E.9080400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:43342 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981Ab1F0AGX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2011 20:06:23 -0400
Content-Disposition: inline
In-Reply-To: <4E076E9E.9080400@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Larry Li <lil@marvell.com>, hbailey@marvell.com

Speaking of which, what sata chips are recommended nowadays for PMP outside
sil24 cards?

On Sun, Jun 26, 2011 at 01:38:38PM -0400, Mark Lord wrote:
> > This sounds a lot like another recent PMP problem we had with marvell.
> > It could be that FIS-based switching doesn't work quite as well for
> > some reason.
> 
> This all *used* to work with sata_mv.
> But I also recently noticed my sata_mv cards no longer work with the
> 4-port Marvell PMP here, and that combo definitely did work when I
> finished with it all (back around 2.6.29 or so).
 
I also used it but it was back 2-3 years ago now. I think it even worked
back in 2.6.18.

> I'm rather distracted here right now with broken internet connectivity,
> and hunting for new providers etc., so not likely to dig around on it.
> 
> Perhaps Marc MERLIN could retest with an older kernel,
> say 2.6.32 or 2.6.29 even, and see what happens with those.
> Hopefully it will work there for him, and we'll have a starting
> point to bisect the issue.

So it's a bit difficult for me to get too much data on this since it's a
production system and downtime does come at somewhat of a premium.

However, if whoever may be able to work on it and see what broke (because it
almost works, I see all the drives on my PMP and I can read data somewhat, I
just get a lot of somewhat scary errors now) lets me know, if he/she has no
way to test him/herself, I'll see what I can do to help out and get to
replicate this with older kernels on either that server, or maybe another
machine I would have to build for it (trying repeatedly on production data,
even with backups, not so good :) ).

Thanks for the answer,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
