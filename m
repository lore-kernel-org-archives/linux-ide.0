From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 03/10] ide-atapi: teach ide atapi about drive->waiting_for_dma
Date: Wed, 17 Sep 2008 09:32:08 -0700
Message-ID: <200809170932.08442.bzolnier@gmail.com>
References: <1221392158-3848-1-git-send-email-petkovbb@gmail.com> <200809152015.51684.bzolnier@gmail.com> <20080917100512.GA28378@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:32371 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbYIQQcs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Sep 2008 12:32:48 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3097867wfd.4
        for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 09:32:47 -0700 (PDT)
In-Reply-To: <20080917100512.GA28378@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wednesday 17 September 2008 03:05:12 Borislav Petkov wrote:
> Hi,
> 
> On Mon, Sep 15, 2008 at 08:15:51PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Sunday 14 September 2008 13:35:51 Borislav Petkov wrote:
> > > This is in preparation for converting ide-cd to generic code. The actual
> > > rewiring will be done later after the issue_pc/transfer_pc code knows all about
> > > ide-cd.
> > > 
> > > There should be no functional change resulting from this patch.
> > > 
> > > Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> > > ---
> > >  drivers/ide/ide-atapi.c |   16 +++++++++++++---
> > >  1 files changed, 13 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/ide/ide-atapi.c b/drivers/ide/ide-atapi.c
> > > index d557841..763acd7 100644
> > > --- a/drivers/ide/ide-atapi.c
> > > +++ b/drivers/ide/ide-atapi.c
> > > @@ -487,7 +487,13 @@ static ide_startstop_t ide_transfer_pc(ide_drive_t *drive)
> > >  	ide_startstop_t startstop;
> > >  	u8 ireason;
> > >  
> > > -	if (ide_wait_stat(&startstop, drive, ATA_DRQ, ATA_BUSY, WAIT_READY)) {
> > > +	if ((drive->media == ide_cdrom || drive->media == ide_optical) &&
> > > +	    (drive->atapi_flags & IDE_AFLAG_DRQ_INTERRUPT)) {
> > > +		if (drive->dma)
> > > +			drive->waiting_for_dma = 1;
> > > +	}
> > 
> > We really want to do this for all ATAPI devices (as a bugfix).
> > 
> > > +	else if (ide_wait_stat(&startstop, drive, ATA_DRQ, ATA_BUSY,
> > > +			       WAIT_READY)) {
> > 
> > IIRC similar check was removed from ide-cd so maybe this one
> > is also unnecessary?

[ actually, I mistook it for cdrom_start_packet_command() check ]

> Well, according to SFF8020, this chunk is for drives which don't support the
> "Accelerated DRQ" command packet DRQ type and those drives can set the DRQ bit
> as late as 10ms after receiving the PACKET command and I guess those are really
> old. I don't know whether it will be completely safe to remove it - for that

In this case we may as well do the wait on ide-cd devices.

Thanks,
Bart
