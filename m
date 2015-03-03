From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] ide_tape: convert jiffies with jiffies_to_msecs
Date: Tue, 3 Mar 2015 11:57:01 +0100
Message-ID: <20150303105701.GA30191@opentech.at>
References: <1425378228-6095-1-git-send-email-hofrat@osadl.org> <1425379047.17273.11.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425379047.17273.11.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 03 Mar 2015, Joe Perches wrote:

> On Tue, 2015-03-03 at 05:23 -0500, Nicholas Mc Guire wrote:
> > Use jiffies_to_msecs for converting jiffies as it handles all of the corner
> > cases reliably and also helps readability. The printk format is fixed up 
> > as jiffies_to_msecs returns unsigned int not unsigned long.
> 
> Then ideally you'd use %u not %d.
>

ok - was not clear about that as there are very many cases wher u32 
is printed with %d and compilers seem to be happy with this -
gcc (Debian 4.7.2-5) 4.7.2 in my case.
will fix that up and repost.
 
> > Note that this patch will give a checkpatch warning due to "quoted string 
> > split across lines" but thats not related to this change - not sure if this
> > should be fixed - looks intentional to me.
> 
> It's not.  It'd be better coalesced.

well it did seem quite systematic in this file, aside from it also needing
to move over the pr_* so thats going to need a few seperate cleanups.

> 
> > diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> []
> > @@ -1793,11 +1793,11 @@ static void idetape_setup(ide_drive_t *drive, idetape_tape_t *tape, int minor)
> >  	tape->best_dsc_rw_freq = clamp_t(unsigned long, t, IDETAPE_DSC_RW_MIN,
> >  					 IDETAPE_DSC_RW_MAX);
> >  	printk(KERN_INFO "ide-tape: %s <-> %s: %dKBps, %d*%dkB buffer, "
> > -		"%lums tDSC%s\n",
> > +		"%dms tDSC%s\n",
> >  		drive->name, tape->name, *(u16 *)&tape->caps[14],
> >  		(*(u16 *)&tape->caps[16] * 512) / tape->buffer_size,
> >  		tape->buffer_size / 1024,
> > -		tape->best_dsc_rw_freq * 1000 / HZ,
> > +		jiffies_to_msecs(tape->best_dsc_rw_freq),
> >  		(drive->dev_flags & IDE_DFLAG_USING_DMA) ? ", DMA" : "");
> 
>
thanks for the review notes!

thx!
hofrat 
