From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] updates to Vitesse SATA driver
Date: Wed, 29 Sep 2004 21:05:11 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040930040511.GA201009@sgi.com>
References: <8746466a04092114163b3c0618@mail.gmail.com> <415B34FC.8060908@pobox.com> <8746466a0409291532471417b8@mail.gmail.com> <20040930023428.GA200873@sgi.com> <415B7D53.9020101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:44231 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268695AbUI3EFZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Sep 2004 00:05:25 -0400
Content-Disposition: inline
In-Reply-To: <415B7D53.9020101@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave <dave.jiang@gmail.com>, jeremy.higdon@sgi.com, linux-ide@vger.kernel.org

On Wed, Sep 29, 2004 at 11:28:19PM -0400, Jeff Garzik wrote:
> >>On Wed, 29 Sep 2004 18:19:40 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> >>
> >>>So where did the discussion on this patch land?
> >
> >
> >The only part that made sense to me was the LED patch, which should
> >just be a single line of code.
> 
> So maybe you or Dave could be convinced to roll that into a separate 
> patch, since we have consensus on that item?

Since I'm just as happy without it, I'll let Dave do it  :-)

> >>Obviosly if it is working on IA32 or IA64, this code must be only
> >>scanning device 0 per port and not device 1. Not sure why it is only
> >>scanning 1 device on IA platforms, but both on XScale. Either way we
> >>have a corner case here that should be addressed....
> >
> >
> >Jeff, I don't remember how libata knows how many devices a port
> >can have.  Which field is it?
> 
> By default it only scans device 0, since SATA is a point-to-point 
> connection where there is no possibility for more than one device :)
> 
> However, some hardware chooses to emulate master/slave mode.  Use of 
> this, particularly on Vitesse/Intel, is highly discouraged in favor of 
> DPA mode.  I would prefer to not support master/slave mode at all.
> 
> Technically speaking, one sets the ATA_FLAG_SLAVE_POSS flag to tell the 
> libata core to scan for device 1.
> 
> If we are talking about Port Multipliers, those aren't supported at all yet.
> 
> 	Jeff

So there's something amiss with the XScale, then, it appears.  They
also were having trouble with byte writes to the interrupt mask
register.  That also seems to be a problem unique to that platform.

jeremy
