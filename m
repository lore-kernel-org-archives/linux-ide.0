From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata vs ATAPI
Date: Tue, 12 Oct 2004 23:17:38 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e0410121417591ecff0@mail.gmail.com>
References: <58cb370e04101213215ce9a23c@mail.gmail.com>
	 <416C438C.4010902@pobox.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.200]:36069 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267826AbUJLVRj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2004 17:17:39 -0400
Received: by mproxy.gmail.com with SMTP id 77so385604rnk
        for <linux-ide@vger.kernel.org>; Tue, 12 Oct 2004 14:17:38 -0700 (PDT)
In-Reply-To: <416C438C.4010902@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>

On Tue, 12 Oct 2004 16:50:20 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Hi Jeff,
> >
> > Is libata currently supposed to work with ATAPI
> > (I know about lack of REQUEST_SENSE support)?
> >
> > With ATA_ENABLE_ATAPI defined INQUIRY seems to succeed for my
> > TOSHIBA ODD-DVD SD-R6372 but empty info is printed by SCSI layer.
> 
> I get this too

OTOH ide-scsi gets correct INQUIRY output

> > Then REPORT_LUNS errors out (dev_stat = 0x51)...
> 
> This doesn't surprise me, I bet that many ATAPI devices might not like
> REPORT LUNS

Yes, it is not defined in original ATAPI spec.

> > I've noticed that DMA is used by default for all packet commands
> > which doesn't seem to be wise thing to do so I disabled it.
> 
> DMA is _never_ used for packet commands, only for packet data.

Yep, I know.

> libata enables DMA at the maximum level supported by both the device and
> host controller.  I definitely want to do this by default.

Me too but I suppose that there are many devices which don't like it
(otherwise restrictions in ide-cd and ide-scsi make no sense).

Jens?

> > Unfortunately it doesn't help because atapi_pio_sector() assumes
> > transfer length to be % SECTOR_SIZE and transfer length for INQUIRY
> > is mere 36 bytes so this fails.
> 
> Yes, you are welcome to fix this assumption.  :)

Another bug in this area: bcount is set to 64 * 1024 (0xFFFF) but
ATA/ATAPI spec defines max bcount as 0xFFFE and there must
be some reason why ide-scsi limits it to 63 * 1024 and ide-cd to
32 * 1024.

> > Also ATAPI-SCSI emulation is still missing in libata-scsi.c.
> 
> I wish to minimize the emulation.  That means no read/write emulation,
> just modify INQUIRY to report MMC, and do auto-sense (as it is presented
> to the SCSI layer).
> 
> 
> > I'm sure you know more about what needs to be done.
> > Could you make some nice, detailed TODO? :-)
> 
> Pat LaVarre had IOmega ATAPI devices working, once he hand-hacked
> REQUEST SENSE.  As for to-do list, I think this email covers it.  Here's
> a summary...
> 
> * possibly avoid REPORT LUNS for ATAPI devices
> * when check condition occurs, automatically request sense inside
> driver, and put that data into the sense buffer
> * make INQUIRY report SCSI version MMC-3 (or later...)
> * support strange sector sizes
> 
>         Jeff
> 

Thanks,
Bartlomiej
