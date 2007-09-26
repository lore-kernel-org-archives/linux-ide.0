From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ahci: enable GHC.AE bit before set GHC.HR
Date: Wed, 26 Sep 2007 12:23:32 +0100
Message-ID: <20070926122332.39351382@the-village.bc.nu>
References: <200709211327569648280@gmail.com>
	<46F9DA07.4080201@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40544 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758758AbXIZLRl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Sep 2007 07:17:41 -0400
In-Reply-To: <46F9DA07.4080201@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Peer Chen <peerchen@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

On Wed, 26 Sep 2007 00:03:19 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Peer Chen wrote:
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
>=20
> applied the attached patch, inspired by yours.


NAK - mmio is an iomap so writel and readl are the wrong things to use

