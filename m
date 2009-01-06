From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: can't use SSD/non-rotational queue flag for all CFA devices
Date: Tue, 6 Jan 2009 18:04:15 +0100
Message-ID: <200901061804.15343.bzolnier@gmail.com>
References: <200901051951.29692.bzolnier@gmail.com> <496279B6.5080802@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:45705 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbZAFROy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2009 12:14:54 -0500
In-Reply-To: <496279B6.5080802@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Monday 05 January 2009, Sergei Shtylyov wrote:
> Hello.
>=20
> Bartlomiej Zolnierkiewicz wrote:
>=20
> > Some rotating disks also present themselves as CFA devices.
> >
> > Reported-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> >  =20
>=20
> Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
>=20
> > Index: b/drivers/ide/ide-disk.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/drivers/ide/ide-disk.c
> > +++ b/drivers/ide/ide-disk.c
> > @@ -633,7 +633,7 @@ static void ide_disk_setup(ide_drive_t *
> >  	printk(KERN_INFO "%s: max request size: %dKiB\n", drive->name,
> >  		q->max_sectors / 2);
> > =20
> > -	if (ata_id_is_ssd(id) || ata_id_is_cfa(id))
> > +	if (ata_id_is_ssd(id))
> >  		queue_flag_set_unlocked(QUEUE_FLAG_NONROT, q);
> > =20
> >  	/* calculate drive capacity, and select LBA if possible */
> > N=E2=80=B9=C2=A7=C2=B2=C3=A6=C3=ACr=C2=B8=E2=80=BAy=C3=BA=C3=A8=C5=A1=
=C3=98b=C2=B2X=C2=AC=C2=B6=C3=87=C2=A7v=C3=98^=E2=80=93)=C3=9E=C2=BA{.n=
=C3=87+=E2=80=B0=C2=B7=C2=A5=C5=A0{=C2=B1=E2=80=B0=C3=97=C2=A2=C5=BE=C3=
=98^n=E2=80=A1r=C2=A1=C3=B6=C2=A6z=C3=8B=1A=EF=BF=BD=C3=ABh=E2=84=A2=C2=
=A8=C3=A8=C2=AD=C3=9A&=C2=A2=C3=B8=1E=C2=AEG=C2=AB=EF=BF=BD=C3=A9h=C2=AE=
=03(=C2=AD=C3=A9=C5=A1=C5=BD=C5=A0=C3=9D=C2=A2j"=EF=BF=BD=C3=BA=1A=C2=B6=
=1Bm=C2=A7=C3=BF=C3=AF=EF=BF=BD=C3=AA=C3=A4z=C2=B9=C3=9E=E2=80=93=C5=A0=
=C3=A0=C3=BEf=C2=A3=C2=A2=C2=B7h=C5=A1=CB=86=C2=A7~=CB=86mml=3D=3D
>=20
> Hm, why your Kmail base64-encodes plain English messages and adds thi=
s=20
> kind of binary crap?

Huh?  Haven't you heard about the latest trend of inserting hidden data
into your mails?  All the cool dudes are doing it nowadays... 8-)

Now seriously... I would love to know the answer to your question mysel=
f.

[ After distro upgrade I noticed that new KMail's version started addin=
g
  a non-ascii character at the end of inserted file (when composing mes=
sage
  and using "Message" -> "Insert File").  The workaround is to remove t=
he
  character manually but I sometimes forget about it... ]

Thanks,
Bart
