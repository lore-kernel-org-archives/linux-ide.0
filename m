From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata vs ATAPI
Date: Tue, 12 Oct 2004 17:22:25 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041012212225.GA2625@havoc.gtf.org>
References: <58cb370e04101213215ce9a23c@mail.gmail.com> <416C438C.4010902@pobox.com> <58cb370e0410121417591ecff0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.28.190.101]:52678 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267840AbUJLVW1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2004 17:22:27 -0400
Content-Disposition: inline
In-Reply-To: <58cb370e0410121417591ecff0@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>

On Tue, Oct 12, 2004 at 11:17:38PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Tue, 12 Oct 2004 16:50:20 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > > Hi Jeff,
> > >
> > > Is libata currently supposed to work with ATAPI
> > > (I know about lack of REQUEST_SENSE support)?
> > >
> > > With ATA_ENABLE_ATAPI defined INQUIRY seems to succeed for my
> > > TOSHIBA ODD-DVD SD-R6372 but empty info is printed by SCSI layer.
> > 
> > I get this too
> 
> OTOH ide-scsi gets correct INQUIRY output

I spoke incorrect, I meant to say the exact opposite...!

I get correct INQUIRY output.


> > libata enables DMA at the maximum level supported by both the device and
> > host controller.  I definitely want to do this by default.
> 
> Me too but I suppose that there are many devices which don't like it
> (otherwise restrictions in ide-cd and ide-scsi make no sense).
> 
> Jens?

The IDE layer currently figures that all my test CD-ROMs support DMA, so
I would like libata to do that too ;-)


> > > Unfortunately it doesn't help because atapi_pio_sector() assumes
> > > transfer length to be % SECTOR_SIZE and transfer length for INQUIRY
> > > is mere 36 bytes so this fails.
> > 
> > Yes, you are welcome to fix this assumption.  :)
> 
> Another bug in this area: bcount is set to 64 * 1024 (0xFFFF) but
> ATA/ATAPI spec defines max bcount as 0xFFFE and there must
> be some reason why ide-scsi limits it to 63 * 1024 and ide-cd to
> 32 * 1024.

bcount should be set to 8K (one SATA FIS) for PIO,
and 0xFFFF for DMA.  It's not used for DMA.

Where is this code in libata?

	Jeff



