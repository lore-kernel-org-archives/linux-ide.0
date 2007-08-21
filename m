From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] pdc202xx_new: fix PCI refcounting
Date: Tue, 21 Aug 2007 22:01:36 +0200
Message-ID: <200708212201.36591.bzolnier@gmail.com>
References: <200708182246.48109.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:40889 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbXHUUke convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2007 16:40:34 -0400
Received: by nf-out-0910.google.com with SMTP id g13so970232nfb
        for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 13:40:33 -0700 (PDT)
In-Reply-To: <200708182246.48109.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 18 August 2007, Sergei Shtylyov wrote:
> The driver erroneously "lets go" the mate IDE chip in init_setup_pdc2=
0270()
> when ide_setup_pci_devices() call succeeds -- fix this, and drop a co=
uple of
> useless assignments in this function while at it...
>=20
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied but

> ---
> This patch is against the current Linus' tree, it has only been compi=
le tested
> since I do not have PDC2027x chips (and even less so behind DC21150 b=
ridge :-).
>=20
>  drivers/ide/pci/pdc202xx_new.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
>=20
> Index: linux-2.6/drivers/ide/pci/pdc202xx_new.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/ide/pci/pdc202xx_new.c
> +++ linux-2.6/drivers/ide/pci/pdc202xx_new.c
> @@ -9,7 +9,7 @@
>   *  Split from:
>   *  linux/drivers/ide/pdc202xx.c	Version 0.35	Mar. 30, 2002
>   *  Copyright (C) 1998-2002		Andre Hedrick <andre@linux-ide.org>
> - *  Copyright (C) 2005-2006		MontaVista Software, Inc.
> + *  Copyright (C) 2005-2007		MontaVista Software, Inc.
>   *  Portions Copyright (C) 1999 Promise Technology, Inc.
>   *  Author: Frank Tiernan (frankt@promise.com)
>   *  Released under terms of General Public License
> @@ -521,7 +521,7 @@ static int __devinit init_setup_pdcnew(s
>  static int __devinit init_setup_pdc20270(struct pci_dev *dev,
>  					 ide_pci_device_t *d)
>  {
> -	struct pci_dev *findev =3D NULL;
> +	struct pci_dev *findev;

drivers/ide/pci/pdc202xx_new.c: In function =E2=80=98init_setup_pdc2027=
0=E2=80=99:
drivers/ide/pci/pdc202xx_new.c:530: warning: =E2=80=98findev=E2=80=99 m=
ay be used uninitialized in this function

with gcc version 4.1.2 20070626 (Red Hat 4.1.2-13)

Seems to be gcc problem but I reverted this chunk.

Update: after applying patch #2/2 and fixing the reject caused by the a=
bove change
warning disappears (patch #2/2 besides renaming "findev" to "dev2" move=
s the code
around making it easier for gcc to deduce what is going on :).

>  	int ret;
> =20
>  	if ((dev->bus->self &&
> @@ -529,7 +529,7 @@ static int __devinit init_setup_pdc20270
>  	    (dev->bus->self->device =3D=3D PCI_DEVICE_ID_DEC_21150)) {
>  		if (PCI_SLOT(dev->devfn) & 2)
>  			return -ENODEV;
> -		d->extra =3D 0;
> +
>  		while ((findev =3D pci_get_device(PCI_ANY_ID, PCI_ANY_ID, findev))=
 !=3D NULL) {
>  			if ((findev->vendor =3D=3D dev->vendor) &&
>  			    (findev->device =3D=3D dev->device) &&
> @@ -538,7 +538,8 @@ static int __devinit init_setup_pdc20270
>  					findev->irq =3D dev->irq;
>  				}
>  				ret =3D ide_setup_pci_devices(dev, findev, d);
> -				pci_dev_put(findev);
> +				if (ret < 0)
> +					pci_dev_put(findev);
>  				return ret;
>  			}
>  		}
