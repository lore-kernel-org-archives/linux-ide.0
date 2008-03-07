From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: Commit 9f10d9ee breaks CD mounting/burning
Date: Fri, 7 Mar 2008 22:49:34 +0100
Message-ID: <20080307214934.GB19778@gollum.tnic>
References: <200803062235.00396.bzolnier@gmail.com> <20080307054825.GA19778@gollum.tnic> <200803072139.43167.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:30181 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762544AbYCGVtl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Mar 2008 16:49:41 -0500
Received: by ug-out-1314.google.com with SMTP id z38so4489863ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 07 Mar 2008 13:49:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200803072139.43167.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: walt <w41ter@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 07, 2008 at 09:39:43PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Friday 07 March 2008, Borislav Petkov wrote:
> > On Thu, Mar 06, 2008 at 10:35:00PM +0100, Bartlomiej Zolnierkiewicz=
 wrote:
> > >=20
> > > On Thursday 06 March 2008, walt wrote:
> > > > Hi Bartolmiej,
> > > >=20
> > > > For me, this commit causes the problem it's intended to fix:
> > > >=20
> > > > commit 9f10d9ee0ac6d79d7bc8b9a158bf4a29322d84d3
> > > > Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > > Date:   Tue Feb 26 21:50:35 2008 +0100
> > > >=20
> > > >      ide-cd: fix 'ireason' handling for REQ_TYPE_ATA_PC request=
s
> > > >=20
> > > >      This fixes some hangs caused by not finishing the transfer=
 before ending
> > > >      the request and also makes use of 'ireason =3D=3D 1' quirk=
 for spurious IRQs.
> > > >=20
> > > > When I mount a CD there is a long delay, and I see this error m=
essage:
> > > >=20
> > > > hdc: ide_cd_check_ireason: wrong transfer direction!
> > > > cdrom: failed setting lba address space
> > > > hdc: status error: status=3D0x58 { DriveReady SeekComplete Data=
Request }
> > > > ide: failed opcode was: unknown
> > > > hdc: drive not ready for command
> > > > <repeated many times>
> > > >=20
> > > > When I revert this commit everything works properly again, incl=
uding
> > > > CD burning.
> > > >=20
> > > > Here is the drive info:
> > > >=20
> > > > hdc: TSSTcorpCD/DVDW SH-S182M, ATAPI CD/DVD-ROM drive
> > > > hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> > > > hdc: UDMA/33 mode selected
> > > > hdc: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
> > > > Uniform CD-ROM driver Revision: 3.20
> > > > hdc: UDMA/33 mode selected
> > > >=20
> > > > I'm happy to try patches or supply more info, just let me know
> > > > what you need.
> > >=20
> > > Does the following patch help?
> > >=20
> > > [ Borislav, please take a look and double check that it is OK. ]
> > >=20
> > > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > Subject: [PATCH] ide-cd: mark REQ_TYPE_ATA_PC write requests with=
 REQ_RW flag
> > >=20
> > > On Thursday 06 March 2008, walt wrote:
> > >=20
> > > > For me, this commit causes the problem it's intended to fix:
> > > >=20
> > > > commit 9f10d9ee0ac6d79d7bc8b9a158bf4a29322d84d3
> > > > Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > > Date:   Tue Feb 26 21:50:35 2008 +0100
> > > >=20
> > > >      ide-cd: fix 'ireason' handling for REQ_TYPE_ATA_PC request=
s
> > > >=20
> > > >      This fixes some hangs caused by not finishing the transfer=
 before ending
> > > >      the request and also makes use of 'ireason =3D=3D 1' quirk=
 for spurious IRQs.
> > > >=20
> > > > When I mount a CD there is a long delay, and I see this error m=
essage:
> > > >=20
> > > > hdc: ide_cd_check_ireason: wrong transfer direction!
> > > > cdrom: failed setting lba address space
> > > > hdc: status error: status=3D0x58 { DriveReady SeekComplete Data=
Request }
> > > > ide: failed opcode was: unknown
> > > > hdc: drive not ready for command
> > > > <repeated many times>
> > > >=20
> > > > When I revert this commit everything works properly again, incl=
uding
> > > > CD burning.
> > >=20
> > > It turned out that REQ_TYPE_ATA_PC write requests were not marked=
 as such
> > > (the previous commit assumed them to be).
> > >=20
> > > Reported-by: walt <w41ter@gmail.com>
> > > Cc: Borislav Petkov <petkovbb@googlemail.com>
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > ---
> > >  drivers/ide/ide-cd_ioctl.c |    4 ++++
> > >  1 file changed, 4 insertions(+)
> > >=20
> > > Index: b/drivers/ide/ide-cd_ioctl.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- a/drivers/ide/ide-cd_ioctl.c
> > > +++ b/drivers/ide/ide-cd_ioctl.c
> > > @@ -457,6 +457,10 @@ int ide_cdrom_packet(struct cdrom_device
> > >  	   layer. the packet must be complete, as we do not
> > >  	   touch it at all. */
> > >  	ide_cd_init_rq(drive, &req);
> > > +
> > > +	if (cgc->data_direction =3D=3D CGC_DATA_WRITE)
> > > +		req.cmd_flags |=3D REQ_RW;
> > > +
> > >  	memcpy(req.cmd, cgc->cmd, CDROM_PACKET_SIZE);
> > >  	if (cgc->sense)
> > >  		memset(cgc->sense, 0, sizeof(struct request_sense));
> >=20
> > Here's how i understand it (and correct me if i'm wrong):
> >=20
> > req.cmd_flags & 0x1 (i.e. the least sig. bit) was remaining unset f=
or write requests
> > and that's why the ireason check in the interrupt handler was faili=
ng loudly.
> > This sets it correctly so that rq_data_dir(rq) evaluates to the cor=
rect data
> > direction of the request, no?
>=20
> Yep.
>=20
> Thanks for checking it, I'll push the patch to Linus.

Cool, can we close http://bugzilla.kernel.org/show_bug.cgi?id=3D10185 n=
ow?

--=20
Regards/Gru=DF,
    Boris.
