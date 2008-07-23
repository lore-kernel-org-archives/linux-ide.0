From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-floppy fix
Date: Wed, 23 Jul 2008 08:32:24 +0200
Message-ID: <20080723063224.GB17724@gollum.tnic>
References: <20080715053356.GA18628@gollum.tnic> <200807212103.36804.bzolnier@gmail.com> <20080722052735.GA16054@gollum.tnic> <200807222149.19939.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:33242 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbYGWGcO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 02:32:14 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1049980fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2008 23:32:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807222149.19939.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stable@kernel.org

On Tue, Jul 22, 2008 at 09:49:19PM +0200, Bartlomiej Zolnierkiewicz wro=
te:
>=20
> Hi,
>=20
> On Tuesday 22 July 2008, Borislav Petkov wrote:
>=20
> [...]
>=20
> > [    5.879917] ide_generic: please use "probe_mask=3D0x3f" module p=
arameter for probing all legacy ISA IDE ports
> > [    5.879997] probe_mask=3D0x3, i=3D0x0, io_addr=3D0x1f0
> > [    5.880057] ide_generic: I/O resource 0x1F0-0x1F7 not free.
> > [    5.880115] probe_mask=3D0x3, i=3D0x1, io_addr=3D0x170
> > [    5.880173] ide_generic: I/O resource 0x170-0x177 not free.
> > [    5.880246] ide_host_register: loop0: i=3D0, hwif=3D00000000
> > [    5.880299] ide_host_register: loop0: i=3D1, hwif=3D00000000
> > [    5.880357] ide_host_register: loop0: i=3D2, hwif=3D00000000
> >=20
> > and then it goes KABOOM!
> >=20
> >=20
> >=20
> > I tested both with BLK_DEV_GENERIC on and off and the
> > error happens only when it is on:
> >=20
> > --- config.ok   2008-07-22 06:58:48.000000000 +0200
> > +++ config.b0rked       2008-07-22 06:59:31.000000000 +0200
> > @@ -1,7 +1,7 @@
> >  #
> >  # Automatically generated make config: don't edit
> >  # Linux kernel version: 2.6.26
> > -# Tue Jul 22 06:58:28 2008
> > +# Tue Jul 22 06:59:24 2008
> >  #
> >  # CONFIG_64BIT is not set
> >  CONFIG_X86_32=3Dy
> > @@ -600,7 +600,7 @@ CONFIG_IDE_PROC_FS=3Dy
> >  #
> >  # IDE chipset support/bugfixes
> >  #
> > -# CONFIG_IDE_GENERIC is not set
> > +CONFIG_IDE_GENERIC=3Dy
> >  # CONFIG_BLK_DEV_PLATFORM is not set
> >  # CONFIG_BLK_DEV_CMD640 is not set
> >  # CONFIG_BLK_DEV_IDEPNP is not set
> >=20
> > I've also attached the .config that breaks the machine. Please take=
 a look in
> > case i'm missing something.
>=20
> Thanks, with this config I can reproduce the problem.
>=20
> > > [ Besides it shouldn't result in phantom hde & hdf devices
> > >   and ide_generic blowing up on failure. ]
> > >=20
> > > Have you tried the memset() fix that I proposed
> > > (pata tree contains the revised patch now)?
> >=20
> > yep, test runs ontop of your tree from Sunday which already has the=
 fix.
>=20
> *sigh*
>=20
> The previous fix was garbage and contained brown-paper-bag bug:
>=20
> diff -u b/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
> --- b/drivers/ide/ide-generic.c
> +++ b/drivers/ide/ide-generic.c
> @@ -114,7 +114,7 @@
>  	printk(KERN_INFO DRV_NAME ": please use \"probe_mask=3D0x3f\" modul=
e "
>  			 "parameter for probing all legacy ISA IDE ports\n");
> =20
> -	memset(hws, 0, MAX_HWIFS);
> +	memset(hws, 0, sizeof(hw_regs_t *) * MAX_HWIFS);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(legacy_bases); i++) {
>  		io_addr =3D legacy_bases[i];
>=20
>=20
> Now it should be finally fixed.

True story. Works here too.

>=20
> > > > One of the possible fixes is adding
> > > >=20
> > > > depends on !BLK_DEV_GENERIC
> > > >=20
> > > > after each IDE chipset driver using the generic detection in dr=
ivers/ide/Kconfig
> > > > but it's a not-that-elegant one. Another thing would be using a=
 dummy one like
> > > > BLK_DEV_IDEDMA_PCI, but I'm not that sure. Will look into it. I=
'm pretty sure
> > > > you have a better idea...
> > >=20
> > > pata_legacy.c has a proper fix which needs porting into ide-gener=
ic.c
> > > (it should be pretty easy thing to do).
> >=20
> > (is this a hint^^? :))
>=20
> It has *HINT* written all over it. ;)

Hm, let's see whether there's time during the weekend. I already have s=
omething
stolen from pata_legacy but I'll do some more testing first. By the way=
, what
are the chances of exporting those pieces of code from drivers/ata/pata=
_legacy.c
and adding the function def into some header instead of duplicating the=
 code into
ide_generic.c?

--=20
Regards/Gru=DF,
    Boris.
