From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] hpt366: add hpt3xx_disable_fast_irq() helper
Date: Wed, 15 Oct 2008 20:11:18 +0200
Message-ID: <200810152011.18478.bzolnier@gmail.com>
References: <200808021915.03424.bzolnier@gmail.com> <48F50649.9080507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:49973 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbYJOTuK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 15:50:10 -0400
Received: by yw-out-2324.google.com with SMTP id 9so658966ywe.1
        for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 12:50:09 -0700 (PDT)
In-Reply-To: <48F50649.9080507@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 14 October 2008, Sergei Shtylyov wrote:
> Hello.
>=20
> Bartlomiej Zolnierkiewicz wrote:
>=20
> > * Factor out disabling of "fast interrupt" prediction from
> >   init_hwif_hpt366() to hpt3xx_disable_fast_irq() helper.
>=20
> > * Use hpt3xx_disable_fast_irq() in ->init_chipset instead of
> >   ->init_hwif method.
>=20
> >   This is a preparation for adding proper PCI PM support.
>=20
> > While at it:
>=20
> > * Cache chip type in chip_type variable in hpt3xx_disable_fast_irq(=
).
>=20
> > There should be no functional changes caused by this patch.
>=20
>     Except a warning. ;-)

Sorry for that but... shit happens. ;)

> > Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>=20
> > Index: b/drivers/ide/pci/hpt366.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- a/drivers/ide/pci/hpt366.c
> > +++ b/drivers/ide/pci/hpt366.c
> > @@ -1265,7 +1297,6 @@ static void __devinit init_hwif_hpt366(i
> >  	struct hpt_info *info	=3D host->host_priv + (hwif->dev =3D=3D hos=
t->dev[1]);
> >  	int serialize		=3D HPT_SERIALIZE_IO;
> >  	u8  chip_type		=3D info->chip_type;
> > -	u8  new_mcr, old_mcr	=3D 0;
> > =20
> >  	/* Cache the channel's MISC. control registers' offset */
> >  	hwif->select_data	=3D hwif->channel ? 0x54 : 0x50;
> > @@ -1288,29 +1319,6 @@ static void __devinit init_hwif_hpt366(i
> >  	/* Serialize access to this device if needed */
> >  	if (serialize && hwif->mate)
> >  		hwif->serialized =3D hwif->mate->serialized =3D 1;
> > -
> > -	/*
> > -	 * Disable the "fast interrupt" prediction.  Don't hold off
> > -	 * on interrupts. (=3D=3D 0x01 despite what the docs say)
> > -	 */
> > -	pci_read_config_byte(dev, hwif->select_data + 1, &old_mcr);
> > -
> > -	if (info->chip_type >=3D HPT374)
> > -		new_mcr =3D old_mcr & ~0x07;
> > -	else if (info->chip_type >=3D HPT370) {
> > -		new_mcr =3D old_mcr;
> > -		new_mcr &=3D ~0x02;
> > -
> > -#ifdef HPT_DELAY_INTERRUPT
> > -		new_mcr &=3D ~0x01;
> > -#else
> > -		new_mcr |=3D  0x01;
> > -#endif
> > -	} else					/* HPT366 and HPT368  */
> > -		new_mcr =3D old_mcr & ~0x80;
> > -
> > -	if (new_mcr !=3D old_mcr)
> > -		pci_write_config_byte(dev, hwif->select_data + 1, new_mcr);
> >  }
>=20
>    CC      drivers/ide/pci/hpt366.o
> drivers/ide/pci/hpt366.c: In function `init_hwif_hpt366':
> drivers/ide/pci/hpt366.c:1290: warning: unused variable `dev'
>=20
>     You've removed the users of that variable but left the variable i=
tself...=20
> alas, it's too late to fix the patch. :-/

Not such a big deal, we just have to make an another one...

=46rom: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] hpt366: fix compile warning

=46ixup for commit 1785192b5310ee25165768f5bb80f13146788e3e
("hpt366: add hpt3xx_disable_fast_irq() helper"):

=A0 =A0CC =A0 =A0 =A0drivers/ide/pci/hpt366.o
drivers/ide/pci/hpt366.c: In function `init_hwif_hpt366':
drivers/ide/pci/hpt366.c:1290: warning: unused variable `dev'

Reported-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/hpt366.c |    1 -
 1 file changed, 1 deletion(-)

Index: b/drivers/ide/pci/hpt366.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -1289,7 +1289,6 @@ static u8 hpt3xx_cable_detect(ide_hwif_t
=20
 static void __devinit init_hwif_hpt366(ide_hwif_t *hwif)
 {
-	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	struct hpt_info *info	=3D hpt3xx_get_info(hwif->dev);
 	int serialize		=3D HPT_SERIALIZE_IO;
 	u8  chip_type		=3D info->chip_type;
