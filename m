From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_it821x: sync with IDE it821x driver
Date: Sat, 9 Jun 2007 22:09:10 +0200
Message-ID: <200706092209.10636.bzolnier@gmail.com>
References: <200706090223.20933.bzolnier@gmail.com> <466A417C.5090901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:56705 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758258AbXFIT5p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Jun 2007 15:57:45 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1192214ugf
        for <linux-ide@vger.kernel.org>; Sat, 09 Jun 2007 12:57:44 -0700 (PDT)
In-Reply-To: <466A417C.5090901@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hello,

On Saturday 09 June 2007, Tejun Heo wrote:
> Hello,
>=20
> Bartlomiej Zolnierkiewicz wrote:
> > * (partially) fix DMA in RAID mode
> >=20
> >   Code intended to check DMA status was checking DMA command regist=
er.
> >   Moreover firmware seems to "forget" to set DMA capable bit for th=
e
> >   slave device (at least in RAID mode but without ITE RAID volumes)=
 so
> >   check device ID for DMA capable bit when deciding whether to use =
DMA
> >   and remove DMA status check completely.
> >=20
> >   Thanks to Pavol =A9imo for the bugreport and testing the initial =
fix.
>=20
> Ah... This is the mysterious mwdma configuration in smart mode, right=
?

Yep.

> Thanks for fixing this.
>=20
> >   This change unfortunately still doesn't fix DMA in RAID mode (whi=
ch
> >   works fine with IDE it821x) but Alan is working on the missing pi=
eces
> >   (pata_it821x vs libata EH issues).
>=20
> This is the lbal/nsect SRST problem, right?

I think so, due to lack of time I'm not following libata discussions cl=
osely.

> > @@ -258,8 +259,14 @@ static void it821x_passthru_set_piomode(
> >  	static const u8 pio_want[]    =3D { ATA_66, ATA_66, ATA_66, ATA_6=
6, ATA_ANY };
> > =20
> >  	struct it821x_dev *itdev =3D ap->private_data;
> > +	struct ata_device *pair =3D ata_dev_pair(adev);
> >  	int unit =3D adev->devno;
> > -	int mode_wanted =3D adev->pio_mode - XFER_PIO_0;
> > +	int mode_wanted =3D adev->pio_mode;
> > +
> > +	if (pair && adev->pio_mode > pair->pio_mode)
> > +		mode_wanted =3D pair->pio_mode;
> > +
> > +	mode_wanted -=3D XFER_PIO_0;
>=20
> I think this is better done by mode_filter callback which is guarante=
ed
> to be called before any actual mode configuration is performed and in
> device order (master then slave).

I was thinking about using ->mode_filter but since all other PATA host
drivers are doing PIO filtering in ->set_piomode methods and also since=
 it
seemed that using ->mode_filter method would result in slightly more co=
mplex
code I opted for coherency / simplicity.  However if you (or somebody e=
lse)
want to make a follow-up change to this driver (and preferably other PA=
TA
host drivers ie. pata_sil680) to use ->mode_filter I'm also fine with t=
hat.

Thanks,
Bart
