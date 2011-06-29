From: Marc MERLIN <marc@merlins.org>
Subject: Re: decoding PMP errors with Marvel SATA controller
Date: Tue, 28 Jun 2011 20:41:25 -0700
Message-ID: <20110629034125.GC32153@merlins.org>
References: <20110626070820.GC24867@merlins.org> <20110626090309.GA12200@mtj.dyndns.org> <4E076E9E.9080400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:49570 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645Ab1F2Dlf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jun 2011 23:41:35 -0400
Content-Disposition: inline
In-Reply-To: <4E076E9E.9080400@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Larry Li <lil@marvell.com>, hbailey@marvell.com

On Sun, Jun 26, 2011 at 01:38:38PM -0400, Mark Lord wrote:
> This all *used* to work with sata_mv.
> But I also recently noticed my sata_mv cards no longer
> work with the 4-port Marvell PMP here, and that combo
> definitely did work when I finished with it all
> (back around 2.6.29 or so).
> 
> Since sata_mv itself hasn't changed (much) since then,
> the problem is likely in the libata core somewhere.
> I'd guess that maybe in the reset/probe code.
> 
> I'm rather distracted here right now with broken internet connectivity,
> and hunting for new providers etc., so not likely to dig around on it.
> 
> Perhaps Marc MERLIN could retest with an older kernel,

Well, I don't know what to say.

A friend lent me another sata_mv card and just to get another baseline I
tried my original card again, and it just started working.
Yet, I tried it 4 different times before, moved it from one slot to the
other one, changed the sata cables just in case, and nothing would help.

The one thing I did since last time, however, was to update the motherboard
bios.
I'm now wondering if that did not solve some subtle problem which was
causing issues with the sata_mv card and not the sata_sil24.

So it seems it was a false alarm after all, I'll report back if I have
problems again, but it looks like it's working solidly and for what it's
worth with 5 drives and software raid 5, I can both read and write files
at about 115MB/s, which isn't too shabby :)

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
