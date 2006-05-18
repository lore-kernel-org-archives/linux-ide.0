From: Jens Axboe <axboe@suse.de>
Subject: Re: [RFT] major libata update
Date: Thu, 18 May 2006 15:37:22 +0200
Message-ID: <20060518133722.GQ4197@suse.de>
References: <446AAA33.5010800@gmail.com> <446B8F25.3040907@pobox.com> <446B8FC6.5040009@garzik.org> <446B9AA7.4000305@gmail.com> <446B9C1A.1060106@rtr.ca> <446BEB11.4030703@emc.com> <446BE97A.2080303@gmail.com> <446C6163.7010002@emc.com> <446C6DF7.6030202@pobox.com> <446C751A.20000@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:18734 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751034AbWERNhm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 May 2006 09:37:42 -0400
Content-Disposition: inline
In-Reply-To: <446C751A.20000@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: Mark Lord <mlord@pobox.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Thu, May 18 2006, Ric Wheeler wrote:
> 
> Mark Lord wrote:
> >>
> >>A different discussion is what we should do or log when we detect this 
> >>- i.e., write cache enabled and barrier ops not supported (disable 
> >>write cache?  log a scarier message? ignore it?).  Today's behavior is 
> >>probably what most home users want (run as fast as I can, absolute 
> >>data integrity over power failures not a big deal) but not the right 
> >>behavior for critical data (i.e., forget performance, make sure my 
> >>data is always safe ). 
> >
> >Yes, 99.99% of Linux users would really complain like mad
> >if the *kernel* took over the *policy* decision of disabling
> >write-caching.  The long-term kernel rule has always been,
> >leave *policy* to user-space.
> >
> >Cheers
> 
> Agreed - I think that only challenge is for us to make sure that the 
> messages in the upstream kernel are informative enough to let people know 
> what this means and some level of their exposure.
> 
> Maybe the "enterprise" distro install programs would want to treat write 
> barrier like we do support for 3D video card acceleration with a good 
>  overview & let the user configure the system as best suits their needs.  I 
> think that it is still quite difficult to get right today for most casual 
> users...

Yep certainly something needs to be done, it's currently far too
unlikely that:

a) the user even sees the barrier message from the file system, telling
   them that the fs turned it off

and

b) he/she knows the implications of such a message.

This is data integrity after all, we probably should be a little more
careful.

-- 
Jens Axboe

