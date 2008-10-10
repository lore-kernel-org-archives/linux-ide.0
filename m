From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/7] ide: ide_hwgroup_t.rq doesn't need an ide_lock held
Date: Fri, 10 Oct 2008 18:20:18 +0200
Message-ID: <200810101820.18641.bzolnier@gmail.com>
References: <20081008202930.19112.90371.sendpatchset@localhost.localdomain> <20081008203002.19112.519.sendpatchset@localhost.localdomain> <87abdcg86j.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:52701 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758428AbYJJQXE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 12:23:04 -0400
Received: by gxk9 with SMTP id 9so864954gxk.13
        for <linux-ide@vger.kernel.org>; Fri, 10 Oct 2008 09:23:02 -0700 (PDT)
In-Reply-To: <87abdcg86j.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 10 October 2008, Elias Oltmanns wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: ide_hwgroup_t.rq doesn't need an ide_lock held
> >
> > While at it:
> > - no need to check for hwgroup presence in ide_dump_opcode()
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> [...]
> > Index: b/drivers/ide/ide-io.c
> > ===================================================================
> > --- a/drivers/ide/ide-io.c
> > +++ b/drivers/ide/ide-io.c
> [...]
> > @@ -274,7 +269,11 @@ static void ide_complete_pm_request (ide
> >  		drive->dev_flags &= ~IDE_DFLAG_BLOCKED;
> >  		blk_start_queue(drive->queue);
> >  	}
> > -	HWGROUP(drive)->rq = NULL;
> > +	spin_unlock_irqrestore(&ide_lock, flags);
> > +
> > +	drive->hwif->hwgroup->rq = NULL;
> > +
> > +	spin_lock_irqsave(&ide_lock, flags);
> >  	if (__blk_end_request(rq, 0, 0))
> >  		BUG();
> >  	spin_unlock_irqrestore(&ide_lock, flags);
> 
> Is it really an improvement to release the lock here?

Yes since it is a preparation for using the right lock here
(drive->queue->queue_lock instead of ide_lock) which is done
in patch #6/7:

@@ -263,10 +260,8 @@ static void ide_complete_pm_request (ide
 
 	drive->hwif->hwgroup->rq = NULL;
 
-	spin_lock_irqsave(&ide_lock, flags);
-	if (__blk_end_request(rq, 0, 0))
+	if (blk_end_request(rq, 0, 0))
 		BUG();
-	spin_unlock_irqrestore(&ide_lock, flags);
 }

[ ide_lock and drive->queue->queue_lock are the same lock at the moment
  (which is wrong since they are meant to protect completely different
  things) but after this patchset it should be quite easy to address  ]

Also ide_complete_pm_request() above is used only for completion of
PM suspend/resume requests and is not really performance critical.

Thanks,
Bart
