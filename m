From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 11/22] ide: add ide_set_media_lock() helper
Date: Tue, 12 Aug 2008 11:05:49 +0200
Message-ID: <200808121105.49645.bzolnier@gmail.com>
References: <20080810153527.16255.2504.sendpatchset@localhost.localdomain> <20080810153645.16255.80542.sendpatchset@localhost.localdomain> <20080811060232.GA15436@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:56379 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbYHLJbb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 05:31:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1293998fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 12 Aug 2008 02:31:30 -0700 (PDT)
In-Reply-To: <20080811060232.GA15436@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 11 August 2008, Borislav Petkov wrote:
> Hi,
> 
> On Sun, Aug 10, 2008 at 05:36:45PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > * Set IDE_AFLAG_NO_DOORLOCK in idetape_get_mode_sense_result(), check it
> >   in ide_tape_set_media_lock() and cleanup idetape_create_prevent_cmd().
> > 
> > * Set IDE_AFLAG_NO_DOORLOCK in ide_floppy_create_read_capacity_cmd() and
> >   check it instead of IDE_AFLAG_CLIK_DRIVE in ide_floppy_set_media_lock().
> > 
> > * Add ide_set_media_lock() helper and convert ide-{floppy,tape}.c to use it.
> > 
> > * Remove no longer used ide*_create_prevent_cmd()/ide*_set_media_lock().
> > 
> > * Update comment in <linux/ide.h> accordingly.
> > 
> > Cc: Borislav Petkov <petkovbb@gmail.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/ide-atapi.c  |   15 +++++++++++++++
> >  drivers/ide/ide-floppy.c |   32 +++++++-------------------------
> >  drivers/ide/ide-tape.c   |   41 ++++++++++-------------------------------
> >  include/linux/ide.h      |    6 ++++--
> >  4 files changed, 36 insertions(+), 58 deletions(-)
> > 
> > Index: b/drivers/ide/ide-atapi.c
> > ===================================================================
> > --- a/drivers/ide/ide-atapi.c
> > +++ b/drivers/ide/ide-atapi.c
> > @@ -162,6 +162,21 @@ int ide_queue_pc_tail(ide_drive_t *drive
> >  }
> >  EXPORT_SYMBOL_GPL(ide_queue_pc_tail);
> >  
> > +int ide_set_media_lock(ide_drive_t *drive, struct gendisk *disk, int on)
> > +{
> > +	struct ide_atapi_pc pc;
> > +
> > +	if (drive->atapi_flags & IDE_AFLAG_NO_DOORLOCK)
> > +		return 0;
> > +
> > +	ide_init_pc(&pc);
> > +	pc.c[0] = ALLOW_MEDIUM_REMOVAL;
> 
> Are we switching to SCSI opcodes? What about the generic packet commands in
> <include/linux/cdrom.h>?

I prefer to use them when possible but there is no strict policy.

[ SCSI defines are shorter, one of the drivers was using them already
  and it also makes easier for comparing code with SCSI. ]
