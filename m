From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-floppy: merge callbacks
Date: Thu, 14 Feb 2008 13:28:17 +0100
Message-ID: <200802141328.17922.bzolnier@gmail.com>
References: <20080213205733.GC13446@gollum.tnic> <200802132304.24126.bzolnier@gmail.com> <20080214062759.GF13446@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:14652 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760010AbYBNMPB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 07:15:01 -0500
Received: by nf-out-0910.google.com with SMTP id g13so210355nfb.21
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 04:15:00 -0800 (PST)
In-Reply-To: <20080214062759.GF13446@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 14 February 2008, Borislav Petkov wrote:
> On Wed, Feb 13, 2008 at 11:04:23PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday 13 February 2008, Borislav Petkov wrote:
> > > commit d1f1f84f413ab00cb2fec48170d022fcd900e214
> > > Author: Borislav Petkov <petkovbb@gmail.com>
> > > Date:   Wed Feb 13 20:26:56 2008 +0100
> > > 
> > >     ide-floppy: merge callbacks
> > >     
> > >     The appropriate functionality of the callback is established through querying
> > >     the ATAPI packet command in pc->c[0].
> > >     
> > >     While at it, simplify if (floppy->failed_pc)-branch to be found in the original
> > >     idefloppy_request_sense_callback().
> > >     
> > >     Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > > 
> > > diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> > > index 5f133df..1365310 100644
> > > --- a/drivers/ide/ide-floppy.c
> > > +++ b/drivers/ide/ide-floppy.c
> > > @@ -313,50 +313,39 @@ static struct request *idefloppy_next_rq_storage(ide_drive_t *drive)
> > >  	return (&floppy->rq_stack[floppy->rq_stack_index++]);
> > >  }
> > >  
> > > -static void idefloppy_request_sense_callback(ide_drive_t *drive)
> > > +static void ide_floppy_callback(ide_drive_t *drive)
> > >  {
> > >  	idefloppy_floppy_t *floppy = drive->driver_data;
> > > -	u8 *buf = floppy->pc->buf;
> > >  
> > >  	debug_log("Reached %s\n", __func__);
> > >  
> > > -	if (!floppy->pc->error) {
> > > -		floppy->sense_key = buf[2] & 0x0F;
> > > -		floppy->asc = buf[12];
> > > -		floppy->ascq = buf[13];
> > > -		floppy->progress_indication = buf[15] & 0x80 ?
> > > -			(u16)get_unaligned((u16 *)&buf[16]) : 0x10000;
> > > +	if (floppy->pc->c[0] == GPCMD_REQUEST_SENSE) {
> > > +		u8 *buf = floppy->pc->buf;
> > >  
> > > -		if (floppy->failed_pc)
> > > -			debug_log("pc = %x, sense key = %x, asc = %x,"
> > > -					" ascq = %x\n",
> > > -					floppy->failed_pc->c[0],
> > > -					floppy->sense_key,
> > > -					floppy->asc,
> > > -					floppy->ascq);
> > > -		else
> > > -			debug_log("sense key = %x, asc = %x, ascq = %x\n",
> > > -					floppy->sense_key,
> > > -					floppy->asc,
> > > -					floppy->ascq);
> > > -
> > > -
> > > -		idefloppy_end_request(drive, 1, 0);
> > > -	} else {
> > > -		printk(KERN_ERR "Error in REQUEST SENSE itself - Aborting"
> > > -				" request!\n");
> > > -		idefloppy_end_request(drive, 0, 0);
> > > -	}
> > > -}
> > > +		if (!floppy->pc->error) {
> > > +			floppy->sense_key = buf[2] & 0x0F;
> > > +			floppy->asc = buf[12];
> > > +			floppy->ascq = buf[13];
> > > +			floppy->progress_indication = buf[15] & 0x80 ?
> > > +				(u16)get_unaligned((u16 *)&buf[16]) : 0x10000;
> > >  
> > > -/* General packet command callback function. */
> > > -static void idefloppy_pc_callback(ide_drive_t *drive)
> > > -{
> > > -	idefloppy_floppy_t *floppy = drive->driver_data;
> > > +			if (floppy->failed_pc)
> > > +				debug_log("pc = %x, ", floppy->failed_pc->c[0]);
> > >  
> > > -	debug_log("Reached %s\n", __func__);
> > > +			debug_log("sense key = %x, asc = %x, ascq = %x\n",
> > > +				floppy->sense_key, floppy->asc,	floppy->ascq);
> > >  
> > > -	idefloppy_end_request(drive, floppy->pc->error ? 0 : 1, 0);
> > > +			idefloppy_end_request(drive, 1, 0);
> > > +		} else {
> > > +			printk(KERN_ERR "Error in REQUEST SENSE itself - "
> > > +					"Aborting request!\n");
> > > +			idefloppy_end_request(drive, 0, 0);
> > > +		}
> > > +	} else if (floppy->pc->c[0] == GPCMD_READ_10 ||
> > > +		floppy->pc->c[0] == GPCMD_WRITE_10)
> > > +		idefloppy_end_request(drive, 1, 0);
> > > +	else
> > > +		idefloppy_end_request(drive, floppy->pc->error ? 0 : 1, 0);
> > >  }
> > >  
> > >  static void idefloppy_init_pc(struct ide_atapi_pc *pc)
> > > @@ -367,7 +356,7 @@ static void idefloppy_init_pc(struct ide_atapi_pc *pc)
> > >  	pc->req_xfer = 0;
> > >  	pc->buf = pc->pc_buf;
> > >  	pc->buf_size = IDEFLOPPY_PC_BUFFER_SIZE;
> > > -	pc->idefloppy_callback = &idefloppy_pc_callback;
> > > +	pc->idefloppy_callback = &ide_floppy_callback;
> > >  }
> > >  
> > >  static void idefloppy_create_request_sense_cmd(struct ide_atapi_pc *pc)
> > > @@ -376,7 +365,6 @@ static void idefloppy_create_request_sense_cmd(struct ide_atapi_pc *pc)
> > >  	pc->c[0] = GPCMD_REQUEST_SENSE;
> > >  	pc->c[4] = 255;
> > >  	pc->req_xfer = 18;
> > > -	pc->idefloppy_callback = &idefloppy_request_sense_callback;
> > >  }
> > >  
> > >  /*
> > > @@ -697,14 +685,6 @@ static ide_startstop_t idefloppy_issue_pc(ide_drive_t *drive,
> > >  	}
> > >  }
> > >  
> > > -static void idefloppy_rw_callback(ide_drive_t *drive)
> > > -{
> > > -	debug_log("Reached %s\n", __func__);
> > > -
> > > -	idefloppy_end_request(drive, 1, 0);
> > > -	return;
> > > -}
> > > -
> > >  static void idefloppy_create_prevent_cmd(struct ide_atapi_pc *pc, int prevent)
> > >  {
> > >  	debug_log("creating prevent removal command, prevent = %d\n", prevent);
> > > @@ -799,7 +779,6 @@ static void idefloppy_create_rw_cmd(idefloppy_floppy_t *floppy,
> > >  	put_unaligned(cpu_to_be16(blocks), (unsigned short *)&pc->c[7]);
> > >  	put_unaligned(cpu_to_be32(block), (unsigned int *) &pc->c[2]);
> > >  
> > > -	pc->idefloppy_callback = &idefloppy_rw_callback;
> > >  	pc->rq = rq;
> > >  	pc->b_count = cmd == READ ? 0 : rq->bio->bi_size;
> > >  	if (rq->cmd_flags & REQ_RW)
> > > @@ -813,7 +792,6 @@ static void idefloppy_blockpc_cmd(idefloppy_floppy_t *floppy,
> > >  		struct ide_atapi_pc *pc, struct request *rq)
> > >  {
> > >  	idefloppy_init_pc(pc);
> > > -	pc->idefloppy_callback = &idefloppy_rw_callback;
> > 
> > For unknown reasons blk_pc_request() requests were overriding the default
> > *_pc_callback and using *_rw_callback instead - the patch changes this
> > behavior silently.
> > 
> > [ When I suggest some changes I can be wrong as well (just like in this case
> >   because after closer look merging callbacks is not as simple as checking
> >   only pc->c[0]) so do not trust me automatically :) + please always try to
> >   fully read and understand the underlying code. ]
> 
> I did actually _read_ the code but probably the assumption i made was wrong (i
> tend to do that off and on.. :)), and didn't elaborate on that in my original
> mail. First of all, the *_pc_callback is overridden with in the *_rw_callback in
> *_blockpc_cmd() not only for pc requests but also for fs requests in *_create_rw_cmd
> in *_do_request(). The pc->c member is only memcopied in *_blockpc_cmd() from
> rq->cmd and i thought the command in pc->c[0] would be the sole criteria to
> decide upon how to end the request. And this is actually what it boils down
> to, the *_rw_callback() ends the request without error checking (i.e. calls
> idefloppy_end_request(?, 1, ?) with the second arg uptodate = 1 which turns off
> the error local var in *_end_request, while the *_pc_callback() checks for errors.
> 
> But shouldn't we do error checking for pc requests too? ide-cd does turn off
> error checking for fs requests but not for pc requests, so what do we want to do
> here?

We probably should check for errors but again I don't know for sure
and if you are going to change it you should audit the code that the
change is correct change...

Thanks,
Bart
