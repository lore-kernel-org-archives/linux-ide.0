From: Holger Macht <hmacht@suse.de>
Subject: Re: 2.6.25 semantic change in bay handling?
Date: Tue, 6 May 2008 11:29:35 +0200
Message-ID: <20080506092935.GC4378@homac>
References: <20080505223357.GA2839@srcf.ucam.org> <20080506081347.GA8688@homac> <20080506082110.GA10355@srcf.ucam.org> <48201987.4020009@gmail.com> <20080506084625.GA10817@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:36939 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765573AbYEFJ10 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 05:27:26 -0400
Content-Disposition: inline
In-Reply-To: <20080506084625.GA10817@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Di 06. Mai - 09:46:25, Matthew Garrett wrote:
> On Tue, May 06, 2008 at 05:40:39PM +0900, Tejun Heo wrote:
> > >>On Mo 05. Mai - 23:33:57, Matthew Garrett wrote:
> > >>>48feb3c419508487becfb9ea3afcc54c3eac6d80 appears to flag a device as 
> > 
> > That should be 233f112042d0b50170212dbff99c3b34b8773cd3, right?
> 
> Yeah, my mistake.
> 
> > The original change was from Holder Macht and IIRC it was to avoid 
> > machine hard lock up on certain laptops which happens when libata EH 
> > goes out to find out what happened when it receives bus/device check 
> > after removal.  Maybe what should be done instead is that eject request 
> > doesn't do anything but tells acpid to unmount and delete the block 
> > device by echoing 1 to sysfs delete node.
> 
> From my point of view that's fine, but I'd be more interested to know 
> about the case Holger was having trouble with. For internal bays, at 
> least, we can't guarantee that we'll get an eject request before the 
> device is removed - if that leads to hangs, we probably need to work out 
> a way of being more robust here.

Right, so you never can rely on receiving a BAY_EVENT. Why not just
disregard this case and looking for a common solution?

Regards,
	Holger

> > Hmmm... It would be perfect if we can tell whether DEVICE/BUS CHECK is 
> > in which direction (device coming or going away).
> 
> Yeah, but I can't see an easy way of doing that. It's not enough to keep 
> track of the current state and assume that it's either an insertion or 
> removal as a result - some machines fire bus checks on resume, even if 
> the bay device hasn't been changed.

