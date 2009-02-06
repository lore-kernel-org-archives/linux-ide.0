From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 3/3 v2] AT91: initialize Compact Flash on AT91SAM9263 cpu
Date: Fri, 6 Feb 2009 14:32:19 +0100
Message-ID: <200902061432.20291.stf_xl@wp.pl>
References: <200902061214.19789.stf_xl@wp.pl> <498C272A.5070101@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:27040 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512AbZBFNc2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Feb 2009 08:32:28 -0500
In-Reply-To: <498C272A.5070101@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

=46riday 06 February 2009 13:03:54 Sergei Shtylyov napisa=C5=82(a):
> > +/* ---------------------------------------------------------------=
-----
> > + *  Compact Flash (PCMCIA or IDE)
> > + * ---------------------------------------------------------------=
----- */
> > +
> > +#if defined(CONFIG_AT91_CF) || defined(CONFIG_AT91_CF_MODULE) || \
> > +    defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE=
_AT91_MODULE)
> >  =20
>=20
>    Ugh... what are trying to achieve with this, marginal memory save?
Some memory save. There are users which count every byte.=20

> > +	cf_resources[0].start =3D addr_space;
> > +	cf_resources[0].end =3D addr_space + SZ_256M - 1;
> >  =20
>=20
>    In the datasheet the CF mode address space is just 0x1000000, i.e.=
 16=20
> MB, not 256. Moreover, address lines above A22 are not connected to C=
=46=20
> at all.
We take here all particular chip select address space=20
CS5: 0x50000000 - 0x5fffffff
CS6: 0x60000000 - 0x6fffffff=20

> > +	if (data->det_pin) {
> > +		/* check if device is present */
> > +		at91_set_gpio_input(data->det_pin, 1);
> > +		at91_set_deglitch(data->det_pin, 1);
> > +		if (at91_get_gpio_value(data->det_pin) !=3D 0) {
> > +			printk(KERN_ERR "AT91: no CF card detected\n");
> > +			return;
> > +		}
> > +	}
> >  =20
>=20
>    Bart, I'm not sure: don't we support warm-plug now? Or it won't av=
ail=20
> us with CF?
Uhh, this code is wrong at least for PCMCIA as we hotplug there. I don'=
t think
hotplug is supported for ATA devices.

> > +	if (data->rst_pin) {
> > +		/* reset the card */
> > +		int reset =3D (data->flags & AT91_CF_TRUE_IDE) ? 0 : 1;
> > +
> > +		at91_set_gpio_output(data->rst_pin, reset);
> > +		udelay(25); /* taken from ATA docs, CFA not specify it ? */
> > +		at91_set_gpio_output(data->rst_pin, !reset);
> > +	}
> >  =20
>=20
>    Is there really a need to hard reset CF on every reboot?
I think this have sense for ATA devices.
=20
> > +	if (data->vcc_pin)
> > +		/* initially off */
> > +		at91_set_gpio_output(data->vcc_pin, 0);
> >  =20
>=20
>    Why? Moreover, resetting CF without power applied (or cutting off=20
> power afterwards) just doesn't make sense...
Right.

Stanislaw Gruszka
