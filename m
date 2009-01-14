From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Wed, 14 Jan 2009 15:35:12 +0100
Message-ID: <200901141535.13189.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <20090114131727.5b0e5193@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:28154 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755041AbZANOfR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 09:35:17 -0500
In-Reply-To: <20090114131727.5b0e5193@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Wednesday 14 January 2009 14:17:27 Alan Cox napisa=C5=82(a):
> > +#ifdef AT91_GPIO_IRQ_HACK
> > +#define NR_TRIES 10
> > +	int ntries =3D 0;
> > +	int pin_val1, pin_val2;=09
> > +	do {
> > +		pin_val1 =3D at91_get_gpio_value(AT91_PIN_PB20);
> > +		pin_val2 =3D at91_get_gpio_value(AT91_PIN_PB20);
> > +	} while (pin_val1 !=3D pin_val2 && ntries++ < NR_TRIES);
>=20
> You really don't want to put special board specific code in generic
> locations. In the libata case you don't need to and I think in the id=
e
> case you can avoid it too by wrapping the IRQ handler. Libata also
> supports polled mode.
I was thinking about that and don't know why I refused idea of=20
wrapping irq handler.

> Now one other question - you use the 8/16bit set to flip between regi=
ster
> write sizes. Can you explain exactly what guarantees you don't take a=
n
> IRQ between setting the size and a write and having the IRQ handler o=
r a
> timer run in the middle, call other IDE routines and mess up because =
of
> this.
> I see nothing guaranteeing atomicity here and I suspect you either ne=
ed
> locks or (for single processor only) some carefully arranged scheme t=
o
> 'stack' the 8/16bit select status.
I thought ide_port callbacks are serialized by IDE layer. I will use lo=
cks, I think.

Thanks
Stanislaw Gruszka
