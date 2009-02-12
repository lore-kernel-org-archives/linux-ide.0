From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 3/3 v3] AT91: initialize Compact Flash on AT91SAM9263 cpu
Date: Thu, 12 Feb 2009 10:05:46 +0100
Message-ID: <200902121005.46772.stf_xl@wp.pl>
References: <200902091145.11266.stf_xl@wp.pl> <4992D9A4.30205@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:57687 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757330AbZBLJFx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Feb 2009 04:05:53 -0500
In-Reply-To: <4992D9A4.30205@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

Hi.

Wednesday 11 February 2009 14:59:00 Sergei Shtylyov napisa=C5=82(a):
> [...]
> > +	if (data->flags & AT91_CF_TRUE_IDE) {
> > +		/* check if device is present */
> > +		if (data->det_pin && at91_get_gpio_value(data->det_pin) !=3D 0) =
{
> > +			printk(KERN_ERR "AT91 CF True IDE: no device detected\n");
> > +			return;
> > +		}
> > +		if (data->rst_pin) {
> > +			/* reset the card */
> > +			at91_set_gpio_output(data->rst_pin, 0);
> > +			/* wait as defined in ATA7 vol2 (rev 4a) figure 36 */
> > +			udelay(25);
> > +			at91_set_gpio_output(data->rst_pin, 1);
> >  =20
>=20
>    I'm still not sure why this is needed. Do you think thta power-on=20
> reset is not enough?

HW reset is not needed when board is powered-on. But situation is
diffrent when we have reboot due to board reset booton press.
There are configuration where signal from reset button is connected
to CF card (or disk), in some cases device reset signal is connected to
GPIO with assumption to be asserted by software.

I don't know if we can remove this. In hw reset case system/driver will
run with undefined device state, in example device can generate=20
interrupts.

Stanislaw Gruszka
