From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 03/10] ide-atapi: teach ide atapi about
	drive->waiting_for_dma
Date: Wed, 17 Sep 2008 12:05:12 +0200
Message-ID: <20080917100512.GA28378@gollum.tnic>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com> <1221392158-3848-4-git-send-email-petkovbb@gmail.com> <200809152015.51684.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:59643 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbYIQKFV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Sep 2008 06:05:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1974681fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 03:05:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200809152015.51684.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi,

On Mon, Sep 15, 2008 at 08:15:51PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 14 September 2008 13:35:51 Borislav Petkov wrote:
> > This is in preparation for converting ide-cd to generic code. The actual
> > rewiring will be done later after the issue_pc/transfer_pc code knows all about
> > ide-cd.
> > 
> > There should be no functional change resulting from this patch.
> > 
> > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > ---
> >  drivers/ide/ide-atapi.c |   16 +++++++++++++---
> >  1 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
> > index d557841..763acd7 100644
> > --- a/drivers/ide/ide-atapi.c
> > +++ b/drivers/ide/ide-atapi.c
> > @@ -487,7 +487,13 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
> >  	ide_startstop_t startstop;
> >  	u8 ireason;
> >  
> > -	if (ide_wait_stat(&startstop, drive, ATA_DRQ, ATA_BUSY, WAIT_READY)) {
> > +	if ((drive->media == ide_cdrom || drive->media == ide_optical) &&
> > +	    (drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT)) {
> > +		if (drive->dma)
> > +			drive->waiting_for_dma = 1;
> > +	}
> 
> We really want to do this for all ATAPI devices (as a bugfix).
> 
> > +	else if (ide_wait_stat(&startstop, drive, ATA_DRQ, ATA_BUSY,
> > +			       WAIT_READY)) {
> 
> IIRC similar check was removed from ide-cd so maybe this one
> is also unnecessary?

Well, according to SFF8020, this chunk is for drives which don't support the
"Accelerated DRQ" command packet DRQ type and those drives can set the DRQ bit
as late as 10ms after receiving the PACKET command and I guess those are really
old. I don't know whether it will be completely safe to remove it - for that
decision i'm too early in the game :). Anyways, a quick google scan returns
several bug reports in the past hitting that with ide-scsi, ide-floppy and
ide-tape but those are either _really_ old or hint at hardware problems with the
device...

-- 
Regards/Gruss,
    Boris.
