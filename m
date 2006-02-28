From: Jens Axboe <axboe@suse.de>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Tue, 28 Feb 2006 09:03:10 +0100
Message-ID: <20060228080310.GP24981@suse.de>
References: <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <Pine.LNX.4.64.0602271744470.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:54586 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750704AbWB1IEG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 03:04:06 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602271744470.22647@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <lkml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, David Greaves <david@dgreaves.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com

On Mon, Feb 27 2006, Linus Torvalds wrote:
> 
> 
> On Tue, 28 Feb 2006, Tejun Heo wrote:
> 
> > Hello, Mark.
> > 
> > Mark Lord wrote:
> > > 
> > > .. hold off on 2.6.16 because of this or not?
> > > 
> > 
> > It certainly is dangerous. I guess we should turn off FUA for the
> > time being.  Barrier auto-fallback was once implemented but it
> > didn't seem like a good idea as it was too complex and hides low
> > level bug from higher level. The concensus seems to be developing
> > blacklist of drives which lie about FUA support (currently only one
> > drive). Official kernel doesn't seem to be the correct place to grow
> > the blacklist, Maybe we should do it from -mm?
> 
> For 2.6.16, the only sane solution for now is to just turn it off.
> 
> Somebody want to send me a patch that does that, along with an ack from 
> Mark (and whoever else sees this) that it fixes his/their problems?

That's the best solution right now. I guess there's no way around a
blacklist for FUA support and we need time to grow that :-(
And proper fallback to non-FUA writes with disabling FUA based barriers
as well.

Mark, what drive model+firmware are you using?

-- 
Jens Axboe

