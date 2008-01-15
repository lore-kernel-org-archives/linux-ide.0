From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 10/12] ide-floppy: remove atomic test_*bit macros
Date: Tue, 15 Jan 2008 08:07:35 +0100
Message-ID: <20080115070735.GA32009@gollum.tnic>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-10-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-11-git-send-email-bbpetkov@yahoo.de> <200801142250.58201.bzolnier@gmail.com>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp110.plus.mail.re1.yahoo.com ([69.147.102.73]:24148 "HELO
	smtp110.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750990AbYAOHLQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 02:11:16 -0500
Content-Disposition: inline
In-Reply-To: <200801142250.58201.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Jan 14, 2008 at 10:50:58PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Sunday 13 January 2008, Borislav Petkov wrote:
> > ..and replace them with flag enums.
> >=20
> > Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> > ---
> >  drivers/ide/ide-floppy.c |  132 +++++++++++++++++++++++++---------=
-----------
> >  1 files changed, 73 insertions(+), 59 deletions(-)
>=20
> [...]
>=20
> > @@ -506,14 +516,14 @@ static ide_startstop_t idefloppy_pc_intr(ide_=
drive_t *drive)
> > =20
> >  	debug_log("Reached %s interrupt handler\n", __FUNCTION__);
> > =20
> > -	if (test_bit(PC_DMA_IN_PROGRESS, &pc->flags)) {
> > +	if (PC_FLAG_DMA_IN_PROGRESS & pc->flags) {
>=20
> the usual kernel convention is to put flag last, i.e.
>=20
> pc->flags & PC_FLAG_DMA_IN_PROGRESS
>=20
> [...]
>=20
> > @@ -570,7 +581,7 @@ static ide_startstop_t idefloppy_pc_intr(ide_dr=
ive_t *drive)
> >  		printk(KERN_ERR "ide-floppy: CoD !=3D 0 in %s\n", __FUNCTION__);
> >  		return ide_do_reset(drive);
> >  	}
> > -	if (((ireason & IO) =3D=3D IO) =3D=3D test_bit(PC_WRITING, &pc->f=
lags)) {
> > +	if (((ireason & IO) =3D=3D IO) =3D=3D (PC_FLAG_WRITING  & pc->fla=
gs)) {
>=20
> - test_bit() returns 1 or 0 (=3D> boolean)
> - (pc->flags & PC_FLAG_WRITING) is 0x10 or 0
>=20
> so the above comparison will fail
>=20
> > @@ -607,7 +618,7 @@ static ide_startstop_t idefloppy_pc_intr(ide_dr=
ive_t *drive)
> >  		xferfunc(drive, pc->current_position, bcount);
> >  	else
> >  		ide_floppy_io_buffers(drive, pc, bcount,
> > -				test_bit(PC_WRITING, &pc->flags));
> > +				(PC_FLAG_WRITING & pc->flags));
>=20
> ditto, this may actually work but '(pc->flags & PC_FLAG_WRITING) ? 1 =
: 0'
> would be much safer from maintainability POV
Hi Bart,

i must've been sleeping while i've been doing this :) Will redo them to=
night and
resend.

Thanks.
--=20
Regards/Gru=DF,
    Boris.
