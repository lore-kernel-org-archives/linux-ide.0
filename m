From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 4/6] PalmLD IDE
Date: Tue, 21 Apr 2009 19:44:08 +0200
Message-ID: <200904211944.08970.marek.vasut@gmail.com>
References: <200904210205.59971.marek.vasut@gmail.com> <200904211652.34576.marek.vasut@gmail.com> <20090421161933.334bc5a2@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:49730 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753597AbZDURoG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Apr 2009 13:44:06 -0400
Received: by mu-out-0910.google.com with SMTP id g7so961679muf.1
        for <linux-ide@vger.kernel.org>; Tue, 21 Apr 2009 10:44:03 -0700 (PDT)
In-Reply-To: <20090421161933.334bc5a2@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.arm.linux.org.uk, Eric Miao <eric.y.miao@gmail.com>, linux-ide@vger.kernel.org

On Tuesday 21 of April 2009 17:19:33 Alan Cox wrote:
> > http://www.palm.com/us/support/contact/environment/disassem_inst_Lifedriv
> >e.pdf , see slide 10 and 15 for yourself, I think noone would want to
> > solder anything into that device ;-)
>
> Agreed but if the hardware can do it you don't need the flag. Obviously
> not very important in this case.

OK, we can remove that, I'll resend the patch.
>
> > > +	/* we'd better wait for drive's ready signal here
> > > +	  (if we knew where it will come from) */
> > > +	msleep(300);
> > >
> > > Our probe code should already be waiting for ready signals  ?
> >
> > The drive asserts some GPIO when it becomes ready, dunno which one though
> > so we just wait here.
>
> Ok so the ATA bus side ready isn't sufficient for your hardware ?

I can retry without the delay, but I'm quite afraid I ran into problems 
without it. Btw. I rewrote that driver more than half year ago, so I don't 
really recall the details, sorry, I don't want to misinform you here.
>
> > > The only other question is a general architectural one as to whether it
> > > would be better to set up the GPIO etc and create a pata_platform
> > > platform device (possibly tweaking pata_platform flags to allow the
> > > caller to indicate generic pio with mode setting by set features
> > > command)
> >
> > I already explained this to Eric, there isn't any other obscure hardware
> > I think. Or if this is concerning something else, I'll recheck later.


