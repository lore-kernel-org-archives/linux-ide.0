From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [PATCH 18/21] ide-floppy: fix error handling in
	idefloppy_probe()
Date: Sat, 12 Jan 2008 22:12:36 +0100
Message-ID: <20080112211236.GC31954@gollum.tnic>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-18-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-19-git-send-email-bbpetkov@yahoo.de> <200801122118.01949.bzolnier@gmail.com>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp112.plus.mail.re1.yahoo.com ([69.147.102.75]:34296 "HELO
	smtp112.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757421AbYALVQH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 16:16:07 -0500
Content-Disposition: inline
In-Reply-To: <200801122118.01949.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, Jan 12, 2008 at 09:18:01PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> On Friday 11 January 2008, Borislav Petkov wrote:
> > Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> > ---
> >  drivers/ide/ide-floppy.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
> > index 89b26ea..0729df5 100644
> > --- a/drivers/ide/ide-floppy.c
> > +++ b/drivers/ide/ide-floppy.c
> > @@ -1737,7 +1737,8 @@ static int ide_floppy_probe(ide_drive_t *driv=
e)
> >  				" emulation.\n", drive->name);
> >  		goto failed;
> >  	}
> > -	if ((floppy =3D kzalloc(sizeof (idefloppy_floppy_t), GFP_KERNEL))=
 =3D=3D NULL) {
> > +	floppy =3D kzalloc(sizeof(idefloppy_floppy_t), GFP_KERNEL);
> > +	if (!floppy) {
> >  		printk(KERN_ERR "ide-floppy: %s: Can't allocate a floppy"
> >  				" structure\n", drive->name);
> >  		goto failed;
>=20
> I'm unable to see any problem with error handling here?

I changed it simply because checkpatch.pl complains so:

ERROR: do not use assignment in if condition (+ if ((floppy =3D kzalloc=
(sizeof(idefloppy_floppy_t), GFP_KERNEL)) =3D=3D NULL))
#1740: FILE: home/boris/tmp/ide-floppy.c:1740:
+       if ((floppy =3D kzalloc(sizeof (idefloppy_floppy_t), GFP_KERNEL=
)) =3D=3D NULL)
{

> This change should be combined with the rest of checkpatch.pl fixes.
ok.

--=20
Regards/Gru=DF,
    Boris.
