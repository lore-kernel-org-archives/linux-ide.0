From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: [RESEND PATCH 06/10] ide-floppy: report DMA handling in
	idefloppy_pc_intr() properly
Date: Sat, 5 Jan 2008 22:45:19 +0100
Message-ID: <20080105214519.GA4470@gollum.tnic>
References: <1199366409-26016-1-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-6-git-send-email-bbpetkov@yahoo.de> <1199366409-26016-7-git-send-email-bbpetkov@yahoo.de> <200801051646.05131.bzolnier@gmail.com>
Reply-To: bbpetkov@yahoo.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp113.plus.mail.re1.yahoo.com ([69.147.102.76]:35638 "HELO
	smtp113.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750961AbYAFFkB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2008 00:40:01 -0500
Content-Disposition: inline
In-Reply-To: <200801051646.05131.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jan 05, 2008 at 04:46:05PM +0100, Bartlomiej Zolnierkiewicz wro=
te:
> Hmm, no.  The driver is called ide-floppy (ide_floppy) and it is more
> readable this way.
>=20
> >  {
> >  	idefloppy_t *floppy =3D drive->driver_data;
> >  	struct gendisk *g =3D floppy->disk;
> > @@ -1479,7 +1450,7 @@ static ide_proc_entry_t idefloppy_proc[] =3D =
{
> >  };
> >  #endif	/* CONFIG_IDE_PROC_FS */
> > =20
> > -static int ide_floppy_probe(ide_drive_t *);
> > +static int idefloppy_probe(ide_drive_t *);
>=20
> ditto
> =20
> [...]
>=20
> > @@ -1733,7 +1704,7 @@ static struct block_device_operations ideflop=
py_ops =3D {
> >  	.revalidate_disk=3D idefloppy_revalidate_disk
> >  };
> > =20
> > -static int ide_floppy_probe(ide_drive_t *drive)
> > +static int idefloppy_probe(ide_drive_t *drive)
>=20
> ditto
Shouldn't those also conform to the driver function format idefloppy_bl=
a() -
after all, those function names are unambiguous for the whole file...?

--=20
Regards/Gru=DF,
    Boris.
