From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 0/7] ide: locking improvements
Date: Thu, 9 Oct 2008 10:40:20 +0200
Message-ID: <20081009084020.GB19428@kernel.dk>
References: <20081008202930.19112.90371.sendpatchset@localhost.localdomain> <20081009065141.GV19428@kernel.dk> <58cb370e0810090136t327734cerf6eb933422b9791c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:45136 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753168AbYJIIkx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Oct 2008 04:40:53 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e0810090136t327734cerf6eb933422b9791c@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 09 2008, Bartlomiej Zolnierkiewicz wrote:
> On Thu, Oct 9, 2008 at 8:51 AM, Jens Axboe <jens.axboe@oracle.com> wrote:
> > On Wed, Oct 08 2008, Bartlomiej Zolnierkiewicz wrote:
> >>
> >> Locking improvements in preparation for replacing the global ide_lock
> >> spinlock by per-hwgroup spinlocks [1].
> >>
> >> [1] patch (which is partially based on 2005 patch from Scalex86) for this
> >> is also ready but it needs some more audit and testing
> >>
> >> diffstat:
> >>  drivers/ide/ide-cd.c     |   38 ++++++-------
> >>  drivers/ide/ide-io.c     |  129 ++++++++++++++++++++---------------------------
> >>  drivers/ide/ide-ioctls.c |    3 -
> >>  drivers/ide/ide-lib.c    |    7 --
> >>  drivers/ide/ide-proc.c   |   25 +--------
> >>  drivers/ide/ide.c        |    7 --
> >>  6 files changed, 80 insertions(+), 129 deletions(-)
> >
> > Sorry, but I just have to ask 'why'? IDE is seeing a whole lot of churn
> > for something that should essentially be a stable code base in
> > maintenance mode, and now scalability improvements?
> 
> It is the stable code but being in "maintenance only mode" has never
> been true and as long as there are active users & developers there is
> really no reason to change it.

Well, maybe then it's just me who thinks that it definitely SHOULD be in
deep maintenance mode...

> > Just doesn't make ANY sense to me, sorry. We may end up with a cleaner
> > code base, but likely also a buggier one. It's not like hardware
> > coverage testing is all that great, considering some of the ancient
> > stuff it supports :-)
> 
> The changes above are relatively safe/simple and are not hardware specific.
> 
> Thanks for worring about IDE but we should be fine. :)
> 
> Bart

-- 
Jens Axboe

