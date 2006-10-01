From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] libata: turn off NCQ if queue depth is adjusted to   1
Date: Sun, 1 Oct 2006 21:55:16 +0200
Message-ID: <20061001195516.GS5670@kernel.dk>
References: <20060930104439.GP25800@htj.dyndns.org> <20060930104500.GQ25800@htj.dyndns.org> <20060930180359.GP4163@kernel.dk> <1159649460.13029.145.camel@localhost.localdomain> <20060930202628.GF5670@kernel.dk> <451F0927.2010804@emc.com> <451F0BF7.1000200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:64782 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932251AbWJATzv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Oct 2006 15:55:51 -0400
Content-Disposition: inline
In-Reply-To: <451F0BF7.1000200@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Ric Wheeler <ric@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Sun, Oct 01 2006, Tejun Heo wrote:
> Ric Wheeler wrote:
> >Jens Axboe wrote:
> >>On Sat, Sep 30 2006, Alan Cox wrote:
> >>>Ar Sad, 2006-09-30 am 20:04 +0200, ysgrifennodd Jens Axboe:
> >>>>On Sat, Sep 30 2006, Tejun Heo wrote:
> >>>>    
> >>>>>Turn off NCQ if queue depth is adjusted to 1.
> >>>>>      
> >>>>I had thought of that too but discarded it - it would be nicer to have
> >>>>an independent way of turning off NCQ. Say you are debugging a weird 
> >>>>FIS
> >>>>issue, NCQ depth 1 is still a different beast to non-NCQ. I see Jeff
> >>>>already applied the patches, but just thought I'd voice my opinion.
> 
> Yeah, I was putting off this patch for the same reason.  0 depth would 
> have been nice but SCSI midlayer filters such input and libata still 
> doesn't have its own sysfs tree.  So, this was the middle ground.

Don't let that stop you, with good reason it could be changed (or just
allowed for some llds).

> >>>I've got a blacklist for NCQ in my work tree but really we need the
> >>>vendors to help fill it. So far it has some raptors in it but I am sure
> >>>there are more, and I am sure there are cases we should be advising
> >>>newer firmware or just tweaking our queue sizes etc.
> >>
> >>Lots of the older Maxtors are pretty crappy for NCQ, so those too. Queue
> >>size tweaks fixed them for me (as low as 4, and I can't say for sure if
> >>it fixes all crashes).
> 
> I'm gonna update EH such that NCQ is turned off after certain number of 
> errors.  That should at least eventually make the machine usable in such 
> cases, but we definitely need NCQ blacklist.

Depends on what the error is. Some drives completely lock up and need a
hard power cycle (I've seen this), there's no way the EH can recover
that.

> >We have to be careful with the blacklisting - specifically, drive model 
> >is often less critical than the version of the firmware (which gets 
> >updated as people work drives through qualification, etc).
> >Updating drive firmware for end users is pretty rare (and almost all 
> >tools are still DOS based ;-)).
> >
> >Certain drives should default to non-NCQ (based on model), but we should 
> >be able to enable it if the firmware supports it.
> >
> >Most of the newest drives are fine, but we will still need something 
> >like Tejun's fix to be able to turn it off for the odd cases that show 
> >up in certain odd applications, etc.
> 
> Ric, can you press harddisk vendors hard enough such that those model 
> and revision numbers squeeze out of them?

I'm guessing that'll be hard. We can scour the .inf files on the drivers
that enable NCQ on Windows, that's probably a good set of defaults.

-- 
Jens Axboe

