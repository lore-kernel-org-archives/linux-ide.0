From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] sata_dwc_460ex: move to generic DMA driver
Date: Mon, 23 Nov 2015 12:10:41 +0200
Message-ID: <1448273441.31665.186.camel@linux.intel.com>
References: <1425415282-3750-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1425415282-3750-2-git-send-email-andriy.shevchenko@linux.intel.com>
	 <yw1xwptab2zs.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:42332 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbbKWKKf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Nov 2015 05:10:35 -0500
In-Reply-To: <yw1xwptab2zs.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, rsarmah@amcc.com, Alexey Brodkin <Alexey.Brodkin@synopsys.com>

On Sun, 2015-11-22 at 13:03 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>=20
> > The SATA implementation based on two actually different devices,
> > i.e. SATA and
> > DMA controllers.
> >=20
> > For Synopsys DesignWare DMA we have already a generic
> > implementation of the
> > driver. Thus, the patch converts the code to use DMAEngine
> > framework and
> > dw_dmac driver.
> >=20
> > In future it will be better to split the devices inside DTS as well
> > like it's
> > done on other platforms.


> > @@ -1721,16 +1227,16 @@ static int sata_dwc_probe(struct
> > platform_device *ofdev)
> > =C2=A0		=C2=A0=C2=A0=C2=A0idr, ver[0], ver[1], ver[2]);
> >=20
> > =C2=A0	/* Get SATA DMA interrupt number */
> > -	irq =3D irq_of_parse_and_map(np, 1);
> > -	if (irq =3D=3D NO_IRQ) {
> > +	hsdev->dma->irq =3D irq_of_parse_and_map(np, 1);
>=20
> This doesn't look like it has been more than compile-tested.

Yes, that's true, my question [1] was a crying in the wilderness.

> =C2=A0=C2=A0Nothing
> ever allocates hsdev->dma, so it can't possibly work.

You are right.

>=20
> Also, has anyone given any thought to getting rid of the dependency
> on
> the DW DMA controller?

How? Before it was even more harder link to it (embedded routines).

On the other hand you may introduce dma_ops and use them like it's
done, for example, in spi-dw*.c

> =C2=A0=C2=A0Presumably support for old device trees would
> need to be retained for compatibility.=C2=A0=C2=A0Maybe checking for =
a "dmas"
> property and falling back on the current behaviour if it's missing.=C2=
=A0=C2=A0

I didn't get how DT is related to DW or any other DMAC used with this
SATA controller.

> My
> goal is to get this driver working with another chip using the same
> SATA
> controller but a different DMA engine.

It would be nice to eventually bring this working with generic DMA
Engine API. Please, keep me in Cc list regarding this driver.

[1]=C2=A0https://lkml.org/lkml/2014/12/12/547

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

