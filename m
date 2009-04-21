From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/6] PalmLD IDE
Date: Tue, 21 Apr 2009 16:19:33 +0100
Message-ID: <20090421161933.334bc5a2@lxorguk.ukuu.org.uk>
References: <200904210205.59971.marek.vasut@gmail.com>
	<20090421152735.39486f55@lxorguk.ukuu.org.uk>
	<200904211652.34576.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51235 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752277AbZDUPSp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Apr 2009 11:18:45 -0400
In-Reply-To: <200904211652.34576.marek.vasut@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.arm.linux.org.uk, Eric Miao <eric.y.miao@gmail.com>, linux-ide@vger.kernel.org

> http://www.palm.com/us/support/contact/environment/disassem_inst_Lifedrive.pdf , 
> see slide 10 and 15 for yourself, I think noone would want to solder anything 
> into that device ;-)

Agreed but if the hardware can do it you don't need the flag. Obviously
not very important in this case.

> >
> > +	/* we'd better wait for drive's ready signal here
> > +	  (if we knew where it will come from) */
> > +	msleep(300);
> >
> > Our probe code should already be waiting for ready signals  ?
> 
> The drive asserts some GPIO when it becomes ready, dunno which one though so 
> we just wait here.

Ok so the ATA bus side ready isn't sufficient for your hardware ?

> > The only other question is a general architectural one as to whether it
> > would be better to set up the GPIO etc and create a pata_platform
> > platform device (possibly tweaking pata_platform flags to allow the
> > caller to indicate generic pio with mode setting by set features command)
> 
> I already explained this to Eric, there isn't any other obscure hardware I 
> think. Or if this is concerning something else, I'll recheck later.

