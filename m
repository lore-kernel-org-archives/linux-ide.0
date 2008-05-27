From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 04/40] ide-scsi: fix Interrupt Reason checking in idescsi_pc_intr()
Date: Tue, 27 May 2008 20:30:48 +0200
Message-ID: <200805272030.48438.bzolnier@gmail.com>
References: <20080518185428.5636.77234.sendpatchset@localhost.localdomain> <20080518185503.5636.98141.sendpatchset@localhost.localdomain> <20080519051032.GB31130@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756402AbYEZTXZ@vger.kernel.org>
In-Reply-To: <20080519051032.GB31130@gollum.tnic>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 19 May 2008, Borislav Petkov wrote:
> On Sun, May 18, 2008 at 08:55:03PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Set PC_FLAG_WRITING pc flag in idescsi_queue() (if needed)
> > and then fix Interrupt Reason checking in idescsi_pc_intr().
> > 
> > Cc: Borislav Petkov <petkovbb@gmail.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/scsi/ide-scsi.c |   17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > Index: b/drivers/scsi/ide-scsi.c
> > ===================================================================
> > --- a/drivers/scsi/ide-scsi.c
> > +++ b/drivers/scsi/ide-scsi.c
> > @@ -427,7 +427,15 @@ static ide_startstop_t idescsi_pc_intr (
> >  		printk(KERN_ERR "ide-scsi: CoD != 0 in idescsi_pc_intr\n");
> >  		return ide_do_reset (drive);
> >  	}
> > -	if (ireason & IO) {
> > +	if (((ireason & IO) == IO) == !!(pc->flags & PC_FLAG_WRITING)) {
> > +		/* Hopefully, we will never get here */
> > +		printk(KERN_ERR "%s: We wanted to %s, but the device wants us "
> > +				"to %s!\n", drive->name,
> > +				(ireason & IO) ? "Write" : "Read",
> > +				(ireason & IO) ? "Read" : "Write");
> > +		return ide_do_reset(drive);
> > +	}
> > +	if (!(pc->flags & PC_FLAG_WRITING)) {
> >  		temp = pc->xferred + bcount;
> >  		if (temp > pc->req_xfer) {
> >  			if (temp > pc->buf_size) {
> > @@ -436,7 +444,6 @@ static ide_startstop_t idescsi_pc_intr (
> >  					"- discarding data\n");
> >  				temp = pc->buf_size - pc->xferred;
> >  				if (temp) {
> > -					pc->flags &= ~PC_FLAG_WRITING;
> >  					if (pc->sg)
> >  						idescsi_input_buffers(drive, pc,
> >  									temp);
> > @@ -457,15 +464,11 @@ static ide_startstop_t idescsi_pc_intr (
> >  			printk (KERN_NOTICE "ide-scsi: The scsi wants to send us more data than expected - allowing transfer\n");
> >  #endif /* IDESCSI_DEBUG_LOG */
> >  		}
> > -	}
> > -	if (ireason & IO) {
> > -		pc->flags &= ~PC_FLAG_WRITING;
> >  		if (pc->sg)
> >  			idescsi_input_buffers(drive, pc, bcount);
> >  		else
> >  			hwif->input_data(drive, NULL, pc->cur_pos, bcount);
> >  	} else {
> > -		pc->flags |= PC_FLAG_WRITING;
> 
> Yeah, what was the driver doing turning on/off that flag in the irq handler? Are
> those pc's getting reused in ide-scsi... I guess this is one of the bugs you
> were talking about :).

I guess that it was a left-over from the old days...

[ nowadays idescsi_queue() dynamically allocates new pc-s ]

Thanks,
Bart
