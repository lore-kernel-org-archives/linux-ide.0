From: Jens Axboe <axboe@suse.de>
Subject: Re: regarding bug #5914 - fs corruption on SATA
Date: Fri, 27 Jan 2006 13:23:08 +0100
Message-ID: <20060127122308.GH4311@suse.de>
References: <20060126055050.GA4737@htj.dyndns.org> <43D8637F.5030207@gmail.com> <37416.192.54.193.25.1138266889.squirrel@rousalka.dyndns.org> <20060126092120.GP4212@suse.de> <5840.192.54.193.25.1138269692.squirrel@rousalka.dyndns.org> <1138309495.3968.3.camel@rousalka.dyndns.org> <20060127081319.GU4311@suse.de> <43DA0E3F.7000507@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:14920 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964991AbWA0M1v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jan 2006 07:27:51 -0500
Content-Disposition: inline
In-Reply-To: <43DA0E3F.7000507@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ric Wheeler <ric@emc.com>
Cc: Nicolas Mailhot <nicolas.mailhot@laposte.net>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

On Fri, Jan 27 2006, Ric Wheeler wrote:
> Jens Axboe wrote:
> 
> >On Thu, Jan 26 2006, Nicolas Mailhot wrote:
> > 
> >
> >>
> >>I applied the fua backout patch and the kernel booted beautifully.
> >>Now I guess I need to see if Maxtor released a fixed firmware right ?
> >>(is it possible to change the firmware on a running system ?)
> >>   
> >>
> >
> >If you can get an update firmware, it is usually done by booting from
> >DOS floppy and running a special flash utility from there. Can you send
> >me the hdparm -I /dev/sdX output of the problem drive? I think we should
> >just blacklist it for FUA. This bug is so obscure I think it's a better
> >solution than adding a FUA disable module parameter at this point.
> >
> > 
> >
> I am not sure that drive vendors support firmware upgrades - the 
> downside is that you can produce a nice paper weight if the firmware 
> upgrade fails ;-)

Yeah, hence most of them don't put it online. It would be nice to have,
though...

> Also, there are specific versions where I know that you cannot jump from 
> firmware version X to version X + 1. 

That's unfortunate, too.

-- 
Jens Axboe

