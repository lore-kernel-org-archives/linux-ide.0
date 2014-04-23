From: Antoine =?iso-8859-1?Q?T=E9nart?=
	<antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 1/6] ata: ahci: add AHCI support for Berlin SoCs
Date: Wed, 23 Apr 2014 10:33:26 +0200
Message-ID: <20140423083326.GD24355@kwain>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
 <CAL_JsqKE_Z3kBhS1VaQADV5ob8x6AKHhbHaQEGoVSwkwdd50zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55185 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750755AbaDWIdb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2014 04:33:31 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqKE_Z3kBhS1VaQADV5ob8x6AKHhbHaQEGoVSwkwdd50zA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tejun Heo <tj@kernel.org>, zmxu@marvell.com, Jisheng Zhang <jszhang@marvell.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Rob,

On Tue, Apr 22, 2014 at 01:47:43PM -0500, Rob Herring wrote:
> On Tue, Apr 22, 2014 at 10:38 AM, Antoine T=C3=A9nart
> <antoine.tenart@free-electrons.com> wrote:

[=E2=80=A6]

> > +static inline void ahci_berlin_reg_clear_set(void __iomem *reg, u3=
2 clear_val,
> > +                                            u32 set_val)
> > +{
> > +       u32 regval;
> > +
> > +       regval =3D readl(reg);
> > +       regval &=3D ~(clear_val);
> > +       regval |=3D set_val;
> > +       writel(regval, reg);
> > +}
> > +
> > +static void ahci_berlin_init(void __iomem *mmio)
>=20
> I don't really see the point of a function to do 2 register writes of
> magic values especially when the function name doesn't provide any
> indication of what you are doing really.
>=20
> > +{
> > +       /* interface select */
> > +       ahci_berlin_reg_set(mmio + HOST_VSA_ADDR, BIT(2));
> > +       ahci_berlin_reg_set(mmio + HOST_VSA_ADDR,
>=20
> 2 writes to the same reg? Is this supposed to be the VSA_DATA registe=
r?

You're right it's VSA_DATA.

>=20
> > +                           BIT(21) | BIT(18) | BIT(5) | BIT(4) | B=
IT(2));
>=20
> Use of BIT is only helpful to people that don't understand hex. Can
> you define what these bits are. Otherwise, just use 0x00240034 and
> note that it is magic value which you have no idea what the bits are.

This is magic. I'll update and add a comment.

> > +static void ahci_berlin_port_init(void __iomem *mmio, unsigned int=
 ports)
> > +{
> > +       int p;
> > +
> > +       /* power down pll */
> > +       ahci_berlin_reg_set(mmio + HOST_VSA_ADDR, 0x0);
> > +       ahci_berlin_reg_setbits(mmio + HOST_VSA_DATA, BIT(6));
> > +
> > +       for (p =3D 0; p < ports; p++) {
> > +               /* port control register */
> > +               void __iomem *ctrl_reg =3D mmio + 0x100 + (p * 0x80=
);
> > +
> > +               /* set PHY mode to SATA, ref freq to 25 MHz */
> > +               ahci_berlin_reg_set(ctrl_reg + PORT_VSR_ADDR, 0x201=
);
> > +               ahci_berlin_reg_clear_set(ctrl_reg + PORT_VSR_DATA,
> > +                                         0xff, BIT(0));
>=20
> So you have registers hidden behind an address and data register.
> Perhaps a read and write function to provide that access rather than
> all these set/clear bit functions.

I'd like to do so if I could name 0x201, 0x225 ...
I can also merge the two functions if you think it's better for
readability.

Thanks!

Antoine


--=20
Antoine T=C3=A9nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
