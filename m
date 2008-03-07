From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Commit 9f10d9ee breaks CD mounting/burning
Date: Fri, 7 Mar 2008 21:39:43 +0100
Message-ID: <200803072139.43167.bzolnier@gmail.com>
References: <200803062235.00396.bzolnier@gmail.com> <20080307054825.GA19778@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:65034 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761445AbYCGUho (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Mar 2008 15:37:44 -0500
Received: by fg-out-1718.google.com with SMTP id e21so693094fga.17
        for <linux-ide@vger.kernel.org>; Fri, 07 Mar 2008 12:37:42 -0800 (PST)
In-Reply-To: <20080307054825.GA19778@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: walt <w41ter@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 07 March 2008, Borislav Petkov wrote:
> On Thu, Mar 06, 2008 at 10:35:00PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > On Thursday 06 March 2008, walt wrote:
> > > Hi Bartolmiej,
> > > 
> > > For me, this commit causes the problem it's intended to fix:
> > > 
> > > commit 9f10d9ee0ac6d79d7bc8b9a158bf4a29322d84d3
> > > Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Date:   Tue Feb 26 21:50:35 2008 +0100
> > > 
> > >      ide-cd: fix 'ireason' handling for REQ_TYPE_ATA_PC requests
> > > 
> > >      This fixes some hangs caused by not finishing the transfer before ending
> > >      the request and also makes use of 'ireason == 1' quirk for spurious IRQs.
> > > 
> > > When I mount a CD there is a long delay, and I see this error message:
> > > 
> > > hdc: ide_cd_check_ireason: wrong transfer direction!
> > > cdrom: failed setting lba address space
> > > hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> > > ide: failed opcode was: unknown
> > > hdc: drive not ready for command
> > > <repeated many times>
> > > 
> > > When I revert this commit everything works properly again, including
> > > CD burning.
> > > 
> > > Here is the drive info:
> > > 
> > > hdc: TSSTcorpCD/DVDW SH-S182M, ATAPI CD/DVD-ROM drive
> > > hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> > > hdc: UDMA/33 mode selected
> > > hdc: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
> > > Uniform CD-ROM driver Revision: 3.20
> > > hdc: UDMA/33 mode selected
> > > 
> > > I'm happy to try patches or supply more info, just let me know
> > > what you need.
> > 
> > Does the following patch help?
> > 
> > [ Borislav, please take a look and double check that it is OK. ]
> > 
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide-cd: mark REQ_TYPE_ATA_PC write requests with REQ_RW flag
> > 
> > On Thursday 06 March 2008, walt wrote:
> > 
> > > For me, this commit causes the problem it's intended to fix:
> > > 
> > > commit 9f10d9ee0ac6d79d7bc8b9a158bf4a29322d84d3
> > > Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Date:   Tue Feb 26 21:50:35 2008 +0100
> > > 
> > >      ide-cd: fix 'ireason' handling for REQ_TYPE_ATA_PC requests
> > > 
> > >      This fixes some hangs caused by not finishing the transfer before ending
> > >      the request and also makes use of 'ireason == 1' quirk for spurious IRQs.
> > > 
> > > When I mount a CD there is a long delay, and I see this error message:
> > > 
> > > hdc: ide_cd_check_ireason: wrong transfer direction!
> > > cdrom: failed setting lba address space
> > > hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> > > ide: failed opcode was: unknown
> > > hdc: drive not ready for command
> > > <repeated many times>
> > > 
> > > When I revert this commit everything works properly again, including
> > > CD burning.
> > 
> > It turned out that REQ_TYPE_ATA_PC write requests were not marked as such
> > (the previous commit assumed them to be).
> > 
> > Reported-by: walt <w41ter@gmail.com>
> > Cc: Borislav Petkov <petkovbb@googlemail.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > ---
> >  drivers/ide/ide-cd_ioctl.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > Index: b/drivers/ide/ide-cd_ioctl.c
> > ===================================================================
> > --- a/drivers/ide/ide-cd_ioctl.c
> > +++ b/drivers/ide/ide-cd_ioctl.c
> > @@ -457,6 +457,10 @@ int ide_cdrom_packet(struct cdrom_device
> >  	   layer. the packet must be complete, as we do not
> >  	   touch it at all. */
> >  	ide_cd_init_rq(drive, &req);
> > +
> > +	if (cgc->data_direction == CGC_DATA_WRITE)
> > +		req.cmd_flags |= REQ_RW;
> > +
> >  	memcpy(req.cmd, cgc->cmd, CDROM_PACKET_SIZE);
> >  	if (cgc->sense)
> >  		memset(cgc->sense, 0, sizeof(struct request_sense));
> 
> Here's how i understand it (and correct me if i'm wrong):
> 
> req.cmd_flags & 0x1 (i.e. the least sig. bit) was remaining unset for write requests
> and that's why the ireason check in the interrupt handler was failing loudly.
> This sets it correctly so that rq_data_dir(rq) evaluates to the correct data
> direction of the request, no?

Yep.

Thanks for checking it, I'll push the patch to Linus.
