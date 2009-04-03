From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 2/3] ide-cd: cleanup cdrom_decode_status
Date: Fri, 3 Apr 2009 06:58:03 +0200
Message-ID: <20090403045803.GA3732@liondog.tnic>
References: <1238655519-10074-2-git-send-email-petkovbb@gmail.com> <200904030108.39927.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756885AbZDCE61@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200904030108.39927.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,

On Fri, Apr 03, 2009 at 01:08:39AM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 02 April 2009, Borislav Petkov wrote:
> > - have (almost) equal handling of commands based solely on sense_key
> 
> I'm having a VERY hard time trying to review this patch because at
> the same time that codepaths were merged if()s were replaced by switch()
> which in turn resulted in change of intendation... on top of that
> the patch description is very vague about this part of the changes...

I completely and exactly understand what you are saying :), I thought so
too when I looked at the diffs yesterday. Well, if it's any consolation, the
patches've been tested so they seem to work :). Anyway, split version coming
up...

> We're dealing with tricky error recovery code here and it is very easy
> for subtle bugs to slip in => it is very important to have the changes
> easily reviewable by as many people as possible.

..

> > @@ -614,14 +589,15 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
> >  	struct request *rq = hwif->rq;
> >  	ide_expiry_t *expiry = NULL;
> >  	int dma_error = 0, dma, thislen, uptodate = 0;
> > -	int write = (rq_data_dir(rq) == WRITE) ? 1 : 0, rc, nsectors;
> > +	int write, uninitialized_var(rc), nsectors;
> 
> Why is uninitialized_var() here now?

because gcc is whining that it might be uninitialized although I've
doublechecked all codepaths returning a valid error. It is there to shut
up this warning, actually.

> >  	int sense = blk_sense_request(rq);
> >  	unsigned int timeout;
> >  	u16 len;
> >  	u8 ireason, stat;
> >  
> > -	ide_debug_log(IDE_DBG_PC, "cmd[0]: 0x%x, write: 0x%x",
> > -				  rq->cmd[0], write);
> > +	write = (rq_data_dir(rq) == WRITE) ? 1 : 0;
> > 
> > +	ide_debug_log(IDE_DBG_PC, "cmd: 0x%x, write: 0x%x", rq->cmd[0], write);
> >  
> >  	/* check for errors */
> >  	dma = drive->dma;

-- 
Regards/Gruss,
    Boris.
