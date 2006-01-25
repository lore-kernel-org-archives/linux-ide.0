From: Jens Axboe <axboe@suse.de>
Subject: Re: PATCH convert libata-core to the new debugging scheme
Date: Wed, 25 Jan 2006 16:13:44 +0100
Message-ID: <20060125151343.GE4212@suse.de>
References: <20060124194343.GB25402@gollum.tnic> <20060124194741.GG23269@havoc.gtf.org> <58cb370e0601250704v4aa89fc2n5f7194bbacd4a278@mail.gmail.com> <20060125150646.GC14225@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:9032 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751225AbWAYPL7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Jan 2006 10:11:59 -0500
Content-Disposition: inline
In-Reply-To: <20060125150646.GC14225@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Borislav Petkov <bbpetkov@yahoo.de>, linux-ide@vger.kernel.org, htejun@gmail.com, randy_d_dunlap@linux.intel.com

On Wed, Jan 25 2006, Jeff Garzik wrote:
> On Wed, Jan 25, 2006 at 04:04:04PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On 1/24/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> > > On Tue, Jan 24, 2006 at 08:43:43PM +0100, Borislav Petkov wrote:
> > > > for the debugging macros which to me _is_ kinda too much. In addition, the
> > > > ata_msg_xxx() macros are going to be pretty useless if we wrap them one more
> > > > time into other macros but this is only my opinion.
> > >
> > > Yes, I like the current stuff, and am not really interested in further
> > > macros.
> > 
> > What about using Randy's suggestion the other way around:
> > embedding printk-s into ata_msg_* macros?
> > 
> > This way we would get rid of all these if-s in the code
> > without adding more macros.
> > 
> > i.e. we would have
> > 
> > +       ata_msg_ctl(ap, "ata%u: cmd 0x%X\n", ap->id, tf->command);
> > 
> > instead of
> > 
> > +       if (ata_msg_ctl(ap))
> > +                       printk(KERN_DEBUG "%s: ata%u: cmd 0x%X\n",
> > +                               __FUNCTION__, ap->id, tf->command);
> 
> Those are the further macros that I was objecting to...
> 
> The current ata_msg_ctl() style macros are in the kernel, and thus
> accepted.

It looks cleaner, though. printk() lines are usually the worst to keep
from wrapping, saving a tab indentation there seems like it would be
worth it imho.

-- 
Jens Axboe

