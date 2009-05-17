From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Sun, 17 May 2009 18:16:43 +0200
Message-ID: <200905171816.44069.bzolnier@gmail.com>
References: <49CCD7C4.8000207@inov.pt> <200905142144.14279.bzolnier@gmail.com> <4A0D9FD7.5050608@inov.pt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:43961 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbZEQQNV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 May 2009 12:13:21 -0400
Received: by ewy24 with SMTP id 24so3551742ewy.37
        for <linux-ide@vger.kernel.org>; Sun, 17 May 2009 09:13:21 -0700 (PDT)
In-Reply-To: <4A0D9FD7.5050608@inov.pt>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-15?q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Friday 15 May 2009 19:01:11 Jo=E3o Ramos wrote:

[...]

> > +/*
> > + * readl/writel helpers to access internal registers using
> > + * an ioremapped cookie and the specified IDE register offset
> > + */
> > +
> > +static inline u32 ep93xx_readl(unsigned long base, u8 offset)
> > +{
> > +	return readl((void __iomem *)(base + offset));
> > +}
> > +
> > +static inline void ep93xx_writel(u32 value, unsigned long base, u8=
 offset)
> > +{
> > +	writel(value, (void __iomem *)(base + offset));
> > +}
> >
> > Hmm, what do we need these wrappers for exactly?
> >
> > Please remove them.
> >  =20
> I just added those to increase code readability, so that I wouldn't h=
ave=20
> to do a '(void __iomem *)(base + offset)' in every readl/writel call.
> But I can remove it, no problem.

If readability is harmed by such casts you can always add a local varia=
ble
to alleviate for it, i.e.:

	void __iomem *base =3D (unsigned long)__base;

However I don't think a lot of such tricks would be needed after fixing=
 function
arguments to pass 'void __iomem *base' around and not 'unsigned long ba=
se'

> > +/*
> > + * Check whether IORDY is asserted or not.
> > + */
> > +static inline int ep93xx_ide_check_iordy(unsigned long base)

like here

> > +{
> > +	u32	reg	=3D ep93xx_readl(base, IDECTRL);
> > +
> > +	return (reg & IDECTRL_IORDY) ? 1 : 0;
> > +}

[...]

> > +	/*
> > +	 * fill in ide_io_ports structure.
> > +	 * we use magic numbers 0x10 for io_addr and 0x0E for ctl_addr,
> > +	 * hence the lowest 3 bits will give us the real address (ranging=
 from
> > +	 * 0 to 7) and the subsequent 2 bits will give us the CS1n and CS=
0n
> > +	 * values:
> > +	 *   CS1n  CS0n   A2   A1   A0
> > +	 *     1    0      x    x    x   -> IO_ADDR (base 0x10)
> > +	 *     0    1      x    x    x   -> CTL_ADDR (base 0x0E)
> > +	 */
> > +	ide_std_init_ports(&hw, 0x10, 0x0E);
> >
> > Why not just setup the real addresses here instead of using
> > ide_std_init_ports()?
> >  =20
>=20
> The IDE register's address are specified through bitfields in the EP9=
3xx=20
> IDECTRL register, as described in the above comment.
> The 'workaround' in the addresses is just to ease manipulation of tho=
se=20
> bitfields while writing the register.

Ok, so there is really no reason to use ide_std_init_ports().

> I suppose I could write the register's address in the hw->io_ports so=
=20
> that the value would be directly ORed to the IDECTRL register, if tha=
t=20
> is what you suggest.

Please try it.

> > It seems that it would make driver simpler and get rid of >config_d=
ata use.
> >  =20
>=20
> No. The config_data is used to store the ioremapped cookie of the IDE=
=20
> registers base address. I need that address to access the CPUs IDE=20
> registers.

Please note that ep93xx_ide_{read,write}() are always passed
hwif->config_data as 'unsigned long base' argument so the first
argument should become 'ide_hwif_t *hwif' with:

	unsigned long base =3D hwif->config_data

inside ep93xx_ide_{read,write}().

Also how's about using host->priv_data instead of hwif->config_data?

[ By using ide_host_alloc()+ide_host_register() instead of ide_host_add=
()
  and later obtaining host->priv_data through hwif->host->priv_data. ]

> There's no connection between this address (which maps to CPU's inter=
nal=20
> memory, allowing to acess the IDE registers) and the actual IDE=20
> addresses, which are defined through bitfields in the IDE control reg=
ister.
> Yeah, I know, weird IDE host controller... :-)

Indeed. :)
