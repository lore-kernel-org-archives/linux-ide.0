From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RESEND PATCH 06/10] ide-floppy: report DMA handling in idefloppy_pc_intr() properly
Date: Sun, 6 Jan 2008 16:21:53 +0100
Message-ID: <200801061621.53436.bzolnier@gmail.com>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de> <200801051646.05131.bzolnier@gmail.com> <20080105214519.GA4470@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:41390 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291AbYAFPK3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2008 10:10:29 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3027262ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jan 2008 07:10:26 -0800 (PST)
In-Reply-To: <20080105214519.GA4470@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbpetkov@yahoo.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Saturday 05 January 2008, Borislav Petkov wrote:
> On Sat, Jan 05, 2008 at 04:46:05PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > Hmm, no.  The driver is called ide-floppy (ide_floppy) and it is more
> > readable this way.
> > 
> > >  {
> > >  	idefloppy_t *floppy = drive->driver_data;
> > >  	struct gendisk *g = floppy->disk;
> > > @@ -1479,7 +1450,7 @@ static ide_proc_entry_t idefloppy_proc[] = {
> > >  };
> > >  #endif	/* CONFIG_IDE_PROC_FS */
> > >  
> > > -static int ide_floppy_probe(ide_drive_t *);
> > > +static int idefloppy_probe(ide_drive_t *);
> > 
> > ditto
> >  
> > [...]
> > 
> > > @@ -1733,7 +1704,7 @@ static struct block_device_operations idefloppy_ops = {
> > >  	.revalidate_disk= idefloppy_revalidate_disk
> > >  };
> > >  
> > > -static int ide_floppy_probe(ide_drive_t *drive)
> > > +static int idefloppy_probe(ide_drive_t *drive)
> > 
> > ditto
> Shouldn't those also conform to the driver function format idefloppy_bla() -
> after all, those function names are unambiguous for the whole file...?

Why conform to something sub-optimal instead of changing it?

+ I was using ide_floppy_* in the new code to tag the areas that were
rewritten. Currently it doesn't look that optimistic since there are five
ide_floppy_* functions and fifty idefloppy_* ones but I'm hoping that this
statistics will improve after your patches. :)

Thanks,
Bart
