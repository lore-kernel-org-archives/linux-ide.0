From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH] block: export SSD/non-rotational queue flag through sysfs
Date: Mon, 5 Jan 2009 20:08:54 +0100
Message-ID: <20090105190853.GT32491@kernel.dk>
References: <200901051952.58029.bzolnier@gmail.com> <20090105185428.GS32491@kernel.dk> <200901052002.15984.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([93.163.65.50]:28385 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754183AbZAETJ6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jan 2009 14:09:58 -0500
Content-Disposition: inline
In-Reply-To: <200901052002.15984.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Mon, Jan 05 2009, Bartlomiej Zolnierkiewicz wrote:
> On Monday 05 January 2009, Jens Axboe wrote:
> > On Mon, Jan 05 2009, Bartlomiej Zolnierkiewicz wrote:
> > > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Subject: [PATCH] block: export SSD/non-rotational queue flag through sysfs
> > > 
> > > For some devices (i.e. CFA ATA) we can't reliably detect whether
> > > the device is of rotational or non-rotational type so we need to
> > > leave the final decision about this setting to the user-space.
> > 
> > I agree with that, was actually planning on doing that myself.
> > 
> > > @@ -146,8 +167,8 @@ static ssize_t queue_nomerges_store(stru
> > >  		queue_flag_set(QUEUE_FLAG_NOMERGES, q);
> > >  	else
> > >  		queue_flag_clear(QUEUE_FLAG_NOMERGES, q);
> > > -
> > >  	spin_unlock_irq(q->queue_lock);
> > > +
> > >  	return ret;
> > >  }
> > >  
> > 
> > Hmm?
> 
> This is just a "bonus". :)

I typically prefer a line in-between, but apparently blk-sysfs uses the
other style, so it's good to at least be consistent locally :-)

I've applied the updated patch, thanks!

-- 
Jens Axboe

