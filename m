From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 04/24] ide-tape: remove pipeline-specific code from idetape_chrdev_write
Date: Mon, 3 Mar 2008 00:17:19 +0100
Message-ID: <200803030017.19503.bzolnier@gmail.com>
References: <1204361928-30229-1-git-send-email-petkovbb@gmail.com> <200803021941.28401.bzolnier@gmail.com> <20080302213126.GF4836@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:2024 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224AbYCBXDe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Mar 2008 18:03:34 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1641846ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 02 Mar 2008 15:03:32 -0800 (PST)
In-Reply-To: <20080302213126.GF4836@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sunday 02 March 2008, Borislav Petkov wrote:
> On Sun, Mar 02, 2008 at 07:41:28PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 01 March 2008, Borislav Petkov wrote:
> > > Also, remove unused stage-parameter from idetape_copy_stage_from_user()
> > 
> > Changes like this one are the best to put into separate patches
> > at the very beginning of the patch series.
> > 
> > > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > > ---
> > >  drivers/ide/ide-tape.c |   15 ++++-----------
> > >  1 files changed, 4 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> > > index e919d41..4a064c1 100644
> > > --- a/drivers/ide/ide-tape.c
> > > +++ b/drivers/ide/ide-tape.c
> > > @@ -1700,7 +1700,7 @@ static idetape_stage_t *idetape_kmalloc_stage(idetape_tape_t *tape)
> > >  }
> > >  
> > >  static int idetape_copy_stage_from_user(idetape_tape_t *tape,
> > > -		idetape_stage_t *stage, const char __user *buf, int n)
> > > +					const char __user *buf, int n)
> > >  {
> > >  	struct idetape_bh *bh = tape->bh;
> > >  	int count;
> > > @@ -2696,8 +2696,6 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
> > >  
> > >  	/* Initialize write operation */
> > >  	if (tape->chrdev_dir != IDETAPE_DIR_WRITE) {
> > > -		if (tape->chrdev_dir == IDETAPE_DIR_READ)
> > > -			idetape_discard_read_pipeline(drive, 1);
> > 
> > Why this is OK thing to do?
> > 
> > Are you sure that there are no hidden side-effects?
> > 
> > >  		if (tape->merge_stage || tape->merge_stage_size) {
> > >  			printk(KERN_ERR "ide-tape: merge_stage_size "
> > >  				"should be 0 now\n");
> > > @@ -2729,8 +2727,6 @@ static ssize_t idetape_chrdev_write(struct file *file, const char __user *buf,
> > >  	}
> > >  	if (count == 0)
> > >  		return (0);
> > > -	if (tape->restart_speed_control_req)
> > > -		idetape_restart_speed_control(drive);
> > 
> > ditto
> > 
> > tape->restart_speed_control_req can still be non-zero.
> 
> Same as above: my main focus was ease of review and not keeping pipelining
> functional at all times.

The review is _not_ easied by introducing new & not completely defined
states of the operation...

[ i.e. the speed control feedback loop should be either left alone or
  removed altogether in some pre/post-patch instead of subtle changes
  in the intermediate patches. ]

Could please recast the patches?

Thanks,
Bart
