From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] libata: always use polling SETXFER
Date: Sun, 3 Jun 2007 11:17:29 -0700
Message-ID: <20070603111729.8fe17e7a.akpm@linux-foundation.org>
References: <46598350.6030403@gmail.com>
	<4662E5B3.4020205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53368 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750812AbXFCSRn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Jun 2007 14:17:43 -0400
In-Reply-To: <4662E5B3.4020205@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Sun, 03 Jun 2007 12:00:51 -0400 Jeff Garzik <jeff@garzik.org> wrote:

> Tejun Heo wrote:
> > Several people have reported LITE-ON LTR-48246S detection failed
> > because SETXFER fails.  It seems the device raises IRQ too early after
> > SETXFER.  This is controller independent.  The same problem has been
> > reported for different controllers.
> > 
> > So, now we have pata_via where the controller raises IRQ before it's
> > ready after SETXFER and a device which does similar thing.  This patch
> > makes libata always execute SETXFER via polling.  As this only happens
> > during EH, performance impact is nil.  Setting ATA_TFLAG_POLLING is
> > also moved from issue hot path to ata_dev_set_xfermode() - the only
> > place where SETXFER can be issued.
> > 
> > Note that ATA_TFLAG_POLLING applies only to drivers which implement
> > SFF TF interface and use libata HSM.  More advanced controllers ignore
> > the flag.  This doesn't matter for this fix as SFF TF controllers are
> > the problematic ones.
> > 
> > Signed-off-by: Tejun Heo <htejun@gmail.com>
> > ---
> >  drivers/ata/libata-core.c |   13 ++++---------
> >  drivers/ata/pata_via.c    |   12 ++++++------
> >  include/linux/libata.h    |    1 -
> >  3 files changed, 10 insertions(+), 16 deletions(-)
> 
> To Linus and Andrew:
> 
> After discussion and a minor revision (mostly to the description), I am 
> OK with this patch.
> 
> At this point, I am only reluctant to push it for 2.6.22 since it is so 
> late in the -rc series.
> 
> If we have another -rc, I would probably be OK with pushing it for 
> 2.6.22, otherwise I would prefer to wait for 2.6.23.
> 
> Comments solicited, from all involved...
> 

I'd expect there will be two or three more -rcs - the regression list is
pretty big.

Another option would be to merge into 2.6.23, backport into 2.6.22.x later
on.

But I'd say the thing to do is to merge it immediately is we're reasonably
confident - we can always take it out again or fix it if it breaks.

