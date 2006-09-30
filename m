From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] libata: turn off NCQ if queue depth is adjusted to  1
Date: Sat, 30 Sep 2006 22:26:28 +0200
Message-ID: <20060930202628.GF5670@kernel.dk>
References: <20060930104439.GP25800@htj.dyndns.org> <20060930104500.GQ25800@htj.dyndns.org> <20060930180359.GP4163@kernel.dk> <1159649460.13029.145.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from brick.kernel.dk ([62.242.22.158]:31288 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751932AbWI3U1H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Sep 2006 16:27:07 -0400
Content-Disposition: inline
In-Reply-To: <1159649460.13029.145.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, ric@emc.com

On Sat, Sep 30 2006, Alan Cox wrote:
> Ar Sad, 2006-09-30 am 20:04 +0200, ysgrifennodd Jens Axboe:
> > On Sat, Sep 30 2006, Tejun Heo wrote:
> > > Turn off NCQ if queue depth is adjusted to 1.
> > 
> > I had thought of that too but discarded it - it would be nicer to have
> > an independent way of turning off NCQ. Say you are debugging a weird FIS
> > issue, NCQ depth 1 is still a different beast to non-NCQ. I see Jeff
> > already applied the patches, but just thought I'd voice my opinion.
> 
> I've got a blacklist for NCQ in my work tree but really we need the
> vendors to help fill it. So far it has some raptors in it but I am sure
> there are more, and I am sure there are cases we should be advising
> newer firmware or just tweaking our queue sizes etc.

Lots of the older Maxtors are pretty crappy for NCQ, so those too. Queue
size tweaks fixed them for me (as low as 4, and I can't say for sure if
it fixes all crashes).

-- 
Jens Axboe

