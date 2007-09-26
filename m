From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: enable GHC.AE bit before set GHC.HR
Date: Wed, 26 Sep 2007 07:41:59 -0400
Message-ID: <46FA4587.4070105@garzik.org>
References: <200709211327569648280@gmail.com>	<46F9DA07.4080201@garzik.org> <20070926122332.39351382@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44967 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbXIZLmG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Sep 2007 07:42:06 -0400
In-Reply-To: <20070926122332.39351382@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peer Chen <peerchen@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Wed, 26 Sep 2007 00:03:19 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
>=20
>> Peer Chen wrote:
>>> According to the description of section 5.2.2.1 and 10.1.2 of AHCI =
specification rev1_1/rev1_2, GHC.HR shall only be set to =C2=A1=C2=AE1=C2=
=A1=C2=AF
>>> by software when GHC.AE is set to =C2=A1=C2=AE1=C2=A1=C2=AF.
>>>
>>> Signed-off-by: Peer Chen <peerchen@gmail.com>
>>> ---
>>> --- linux-2.6.23-rc7/drivers/ata/ahci.c.orig	2007-09-20 11:01:55.00=
0000000 -0400
>>> +++ linux-2.6.23-rc7/drivers/ata/ahci.c	2007-09-20 11:07:31.0000000=
00 -0400
>>> @@ -834,6 +834,10 @@ static int ahci_reset_controller(struct=20
>>>  	void __iomem *mmio =3D host->iomap[AHCI_PCI_BAR];
>>>  	u32 tmp;
>>> =20
>>> +        /* turn on AHCI mode before controller reset*/
>>> +        writel(HOST_AHCI_EN, mmio + HOST_CTL);
>>> +        (void) readl(mmio + HOST_CTL);  /* flush */
>> applied the attached patch, inspired by yours.
>=20
>=20
> NAK - mmio is an iomap so writel and readl are the wrong things to us=
e

The patch is consistent with the rest of the driver.

You are welcome to submit a patch to convert ahci to using ioremap.

	Jeff



