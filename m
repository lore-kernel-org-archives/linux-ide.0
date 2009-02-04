From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 3/3] AT91: initialize IDE driver on AT91SAM9263 cpu
Date: Wed, 4 Feb 2009 15:15:37 +0100
Message-ID: <200902041515.38157.stf_xl@wp.pl>
References: <200902031147.41822.stf_xl@wp.pl> <4989877D.6020401@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:45403 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbZBDOPs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Feb 2009 09:15:48 -0500
In-Reply-To: <4989877D.6020401@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Wednesday 04 February 2009 13:18:05 Sergei Shtylyov napisa=C5=82(a):
> Hello.
Hi

> Stanislaw Gruszka wrote:
> > Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> >  =20
> [...]
> > diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/ma=
ch-at91/at91sam9263_devices.c
> > index b753cb8..503651a 100644
> > --- a/arch/arm/mach-at91/at91sam9263_devices.c
> > +++ b/arch/arm/mach-at91/at91sam9263_devices.c
> > @@ -347,6 +347,103 @@ void __init at91_add_device_mmc(short mmc_id,=
 struct at91_mmc_data *data)
> >  void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data=
 *data) {}
> >  #endif
> > =20
> > +/* ---------------------------------------------------------------=
-----
> > + *  IDE
> > + * ---------------------------------------------------------------=
----- */
> > +
> > +#if defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE=
_AT91_MODULE)
> > +
> > +/* Proper CS address space will be added */
> > +#define AT91_IDE_TASK_FILE	0x00c00000
> > +#define AT91_IDE_CTRL_REG	0x00e00000
> >  =20
>=20
>    Why are you assuming that these offsets are not board specifec I=20
> wonder? Theyu clearly depend on how the -CSx were wired on the board =
--=20
> it's the same board specific data as your IRQ.
Are CPU specific. Actually all AT91(except RM9200) use the same offsets=
,
so could be moved from here to driver code, like in at91_cf driver. In =
this file
only we will have proper Chip Select address space resource.

> > +void __init at91_add_device_ide(struct at91_ide_data *data)
> > +{
> >  =20
> [...]
> > +	/* assign CS4/5 to SMC with Compact Flash logic support
> > +	 * and fix resources addresses */
> >  =20
>=20
>    It again seems like board specific configuration...
No, is not board specific.

> > +	ebi0_csa =3D at91_sys_read(AT91_MATRIX_EBI0CSA);
> > +	switch (chipselect) {
> > +	case 4:
> > +		at91_set_A_periph(AT91_PIN_PD6, 0);  /* EBI0_NCS4/CFCS0 */
> > +		ebi0_csa |=3D AT91_MATRIX_EBI0_CS4A_SMC_CF1;
> > +		addr_space =3D AT91_CHIPSELECT_4;
> > +		break;
> > +	case 5:
> > +		at91_set_A_periph(AT91_PIN_PD7, 0);  /* EBI0_NCS5/CFCS1 */
> > +		ebi0_csa |=3D AT91_MATRIX_EBI0_CS5A_SMC_CF2;
> > +		addr_space =3D AT91_CHIPSELECT_5;
> > +		break;
> > +	default:
> > +		printk(KERN_ERR "at91_ide: bad chip select %u\n", chipselect);
> >  =20
> > +		return;
> >  =20
>=20
>   Why do you consider it bad? Is there some SMC limitation or what?
Yes, Compact Flash ("full" and True IDE mode) is supported only on chip=
 select
4 or 5 for AT91SAM9263 (like for all other SAM9s).


Cheers
Stanislaw Gruszka
