From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 02/24] ide-tape: remove pipeline-specific code from idetape_add_chrdev_write_request
Date: Mon, 3 Mar 2008 23:32:10 +0100
Message-ID: <200803032332.10182.bzolnier@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com> <200803030016.30122.bzolnier@gmail.com> <20080303064339.GG4836@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:52403 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbYCCWXm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 17:23:42 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2294536ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 03 Mar 2008 14:23:40 -0800 (PST)
In-Reply-To: <20080303064339.GG4836@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 03 March 2008, Borislav Petkov wrote:
> On Mon, Mar 03, 2008 at 12:16:29AM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > On Sunday 02 March 2008, Borislav Petkov wrote:
> > > On Sun, Mar 02, 2008 at 07:33:05PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > > On Saturday 01 March 2008, Borislav Petkov wrote:
> > > > > Instead of plugging the request into the pipeline, queue it straight on the
> > > > > device's request queue through idetape_queue_rw_tail().
> > > > > 
> > > > > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > > > > ---
> > > > >  drivers/ide/ide-tape.c |   81 ++---------------------------------------------
> > > > >  1 files changed, 4 insertions(+), 77 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> > > > > index 792c76e..abf3efa 100644
> > > > > --- a/drivers/ide/ide-tape.c
> > > > > +++ b/drivers/ide/ide-tape.c
> > > > > @@ -2123,12 +2123,6 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks,
> > > > >  
> > > > >  	debug_log(DBG_SENSE, "%s: cmd=%d\n", __func__, cmd);
> > > > >  
> > > > > -	if (test_bit(IDETAPE_FLAG_PIPELINE_ACTIVE, &tape->flags)) {
> > > > > -		printk(KERN_ERR "ide-tape: bug: the pipeline is active in %s\n",
> > > > > -				__func__);
> > > > > -		return (0);
> > > > > -	}
> > > > > -
> > > > >  	idetape_init_rq(&rq, cmd);
> > > > >  	rq.rq_disk = tape->disk;
> > > > >  	rq.special = (void *)bh;
> > > > > @@ -2140,10 +2134,9 @@ static int idetape_queue_rw_tail(ide_drive_t *drive, int cmd, int blocks,
> > > > >  	if ((cmd & (REQ_IDETAPE_READ | REQ_IDETAPE_WRITE)) == 0)
> > > > >  		return 0;
> > > > >  
> > > > > -	if (tape->merge_stage)
> > > > > -		idetape_init_merge_stage(tape);
> > > > >  	if (rq.errors == IDETAPE_ERROR_GENERAL)
> > > > >  		return -EIO;
> > > > > +
> > > > >  	return (tape->blk_size * (blocks-rq.current_nr_sectors));
> > > > >  }
> > > > 
> > > > These two changes to idetape_queue_rw_tail() don't look correct
> > > > as the pipeline mode is still used by read requests.
> > > 
> > > Wrt first hunk read rq pipeline functionality is removed in the following
> > > patch. Would it then be better to merge the two patches? Actually, do we need
> > 
> > Merging patches together would cause increased complexity.
> > 
> > The best solution would be to move this hunk to the patch which removes
> > IDETAPE_FLAG_PIPELINE_ACTIVE flag.
> > 
> > > to keep the driver functional in between the patches of those series for
> > > the purposes of git bisection or only compile-testing it is enough? Cause
> > 
> > We want to keep the driver functional in between the patches, especially
> > given that it shouldn't be much more difficult to do so.
> > 
> > > after applying the whole series you get pipelined mode ripped out anyway and
> > > intermittent states with partially functional pipeline are of no importance, no?
> > 
> > We always want fully bisectable patches:
> > 
> > - if the patch series accidentaly completely breaks the code we want to be
> >   able narrow it down to the guilty change
> > 
> > - if the patch series causes some regressions (ie. worse performance) we
> >   also want to see which exact change caused it
> > 
> > [ Nothing changes here and removal of pipeline functionality can't be an
> >   excuse for not sticking to the standard procedure. ]
> 
> Ok this changes the approach vector :). Will redo the patches from this angle
> and send them in small b(i|y)tes :) in order to review them easier/faster.

Thanks.  I'll be waiting with review/merge for the re-done patch series then.

Bart
