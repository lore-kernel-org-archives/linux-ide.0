From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ahci: enable GHC.AE bit before set GHC.HR
Date: Fri, 21 Sep 2007 12:27:36 +0100
Message-ID: <20070921122736.68335e17@the-village.bc.nu>
References: <200709211327569648280@gmail.com>
	<20070921103120.GK2367@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48558 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750705AbXIULUy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Sep 2007 07:20:54 -0400
In-Reply-To: <20070921103120.GK2367@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Peer Chen <peerchen@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, jeff <jeff@garzik.org>, akpm <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

On Fri, 21 Sep 2007 12:31:20 +0200
Jens Axboe <jens.axboe@oracle.com> wrote:

> On Fri, Sep 21 2007, Peer Chen wrote:
> > According to the description of section 5.2.2.1 and 10.1.2 of AHCI =
specification rev1_1/rev1_2, GHC.HR shall only be set to =C2=A1=C2=AE1=C2=
=A1=C2=AF
> > by software when GHC.AE is set to =C2=A1=C2=AE1=C2=A1=C2=AF.
> >=20
> > Signed-off-by: Peer Chen <peerchen@gmail.com>
> > ---
> > --- linux-2.6.23-rc7/drivers/ata/ahci.c.orig	2007-09-20 11:01:55.00=
0000000 -0400
> > +++ linux-2.6.23-rc7/drivers/ata/ahci.c	2007-09-20 11:07:31.0000000=
00 -0400
> > @@ -834,6 +834,10 @@ static int ahci_reset_controller(struct=20
> >  	void __iomem *mmio =3D host->iomap[AHCI_PCI_BAR];
> >  	u32 tmp;
> > =20
> > +        /* turn on AHCI mode before controller reset*/
> > +        writel(HOST_AHCI_EN, mmio + HOST_CTL);
> > +        (void) readl(mmio + HOST_CTL);  /* flush */
> > +
> >  	/* global controller reset */
> >  	tmp =3D readl(mmio + HOST_CTL);
> >  	if ((tmp & HOST_RESET) =3D=3D 0) {
>=20
> I appreciate the readl() flushes, but in this particular case we end =
up
> reading the exact offset again below.

The code above is wrong btw - it is an iomap so both the new and existi=
ng
code should be using ioread* not readl

Alan
