From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 2/3 v2] ide: add at91_ide driver
Date: Tue, 17 Feb 2009 15:15:44 +0100
Message-ID: <200902171515.44756.stf_xl@wp.pl>
References: <200902061213.12216.stf_xl@wp.pl> <499850E9.80802@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:42092 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881AbZBQOP6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Feb 2009 09:15:58 -0500
In-Reply-To: <499850E9.80802@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

Sunday 15 February 2009 18:29:13 Sergei Shtylyov napisa=C5=82(a):

> > +#define REGS_SIZE	16
>=20
>     Why? There are only 8 registers in each block.

I did such because pata_at32 have 16, but it should be 8.

> > +#define enter_16bit(cs, mode) do {					\
> > +	mode =3D at91_sys_read(AT91_SMC_MODE(cs));			\
> > +	at91_sys_write(AT91_SMC_MODE(cs), mode | AT91_SMC_DBW_16);	\
> > +} while (0)
> > +
> > +#define leave_16bit(cs, mode) at91_sys_write(AT91_SMC_MODE(cs), mo=
de);
>=20
>    Inline functions are preferrable.

I know. Here is semantics like in spin_lock_irqsave() so I think this
could stay in #define way.

> > +static const struct ide_port_info at91_ide_port_info __initdata =3D=
 {
> > +	.port_ops	=3D &at91_ide_port_ops,
> > +	.tp_ops		=3D &at91_ide_tp_ops,
> > +	.host_flags 	=3D IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA | IDE_HFLAG_SI=
NGLE |
> > +			  IDE_HFLAG_NO_IO_32BIT | IDE_HFLAG_UNMASK_IRQS,
> > +	.pio_mask 	=3D ATA_PIO5,
>=20
>     You *can* use ATA_PIO6 here.  It just won't be actually selected =
by the=20
> IDE core -- until CF specific mode support patch gets merged (I'm exp=
ecting=20
> this to happen in the 2.6.30-rc1 merge window).

With change to ATA_PIO6 command "hdparm -p 6 /dev/hda" call function
at91_ide_set_pio_mode() and OOPS happens because ide_timing_find_mode()
returns NULL. This could be a separate patch after PIO6 changes merged.

Cheers
Stanislaw Gruszka
