From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ide-taskfile.c fixups/cleanups part #2 [1/9]
Date: Fri, 2 Jul 2004 21:20:04 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040702192003.GA10138@elf.ucw.cz>
References: <200406301724.05862.bzolnier@elka.pw.edu.pl> <20040702122004.GC12889@elf.ucw.cz> <200407021843.08976.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs214-65.eurotel.cz ([160.218.214.65]:22669 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264902AbUGBTUT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jul 2004 15:20:19 -0400
Content-Disposition: inline
In-Reply-To: <200407021843.08976.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi!

> > > diff -puN drivers/ide/ide-taskfile.c~ide_tf_pio_out_fixes
> > > drivers/ide/ide-taskfile.c ---
> > > linux-2.6.7-bk11/drivers/ide/ide-taskfile.c~ide_tf_pio_out_fixes	2004-06-
> > >28 21:15:54.030210376 +0200 +++
> > > linux-2.6.7-bk11-bzolnier/drivers/ide/ide-taskfile.c	2004-06-28
> > > 21:15:54.035209616 +0200 @@ -409,6 +409,10 @@ ide_startstop_t
> > > task_out_intr (ide_drive
> > >  	if (!OK_STAT(stat = hwif->INB(IDE_STATUS_REG), DRIVE_READY,
> > > drive->bad_wstat)) { return DRIVER(drive)->error(drive, "task_out_intr",
> > > stat);
> > >  	}
> > > +
> > > +	if (((stat & DRQ_STAT) == 0) ^ !rq->current_nr_sectors)
> > > +		return DRIVER(drive)->error(drive, __FUNCTION__, stat);
> > > +
> >
> > Looks pretty close to obfuscated c code contents... Can't you use !=
> 
> wrrr...
> 
> > or kill ! in second clause and use == or something?
> > 								Pavel
> 
> is
> 
> 	if (((stat & DRQ_STAT) != 0) ^ (rq->current_nr_sectors != 0))
> 
> better?

Not much... maybe its just me but I find bitwise xor hard to read in
logical expression. Perhaps

 	if (!(stat & DRQ_STAT) != !rq->current_nr_sectors)
?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
