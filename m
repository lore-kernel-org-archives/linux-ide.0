From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 3/3 v3] AT91: initialize Compact Flash on AT91SAM9263 cpu
Date: Thu, 12 Feb 2009 10:33:56 +0100
Message-ID: <200902121033.57176.stf_xl@wp.pl>
References: <200902091145.11266.stf_xl@wp.pl> <cd73a99e0902111203k7670f9d8w17cc90b7dec343fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:40523 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755955AbZBLJeF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Feb 2009 04:34:05 -0500
In-Reply-To: <cd73a99e0902111203k7670f9d8w17cc90b7dec343fd@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Victor <avictor.za@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Hi

Wednesday 11 February 2009 21:03:29 Andrew Victor napisa=C5=82(a):
> > +       if (data->flags & AT91_CF_TRUE_IDE) {
> > +               /* check if device is present */
> > +               if (data->det_pin && at91_get_gpio_value(data->det_=
pin) !=3D 0) {
> > +                       printk(KERN_ERR "AT91 CF True IDE: no devic=
e detected\n");
> > +                       return;
> > +               }
> > +               if (data->rst_pin) {
> > +                       /* reset the card */
> > +                       at91_set_gpio_output(data->rst_pin, 0);
> > +                       /* wait as defined in ATA7 vol2 (rev 4a) fi=
gure 36 */
> > +                       udelay(25);
> > +                       at91_set_gpio_output(data->rst_pin, 1);
> > +               }
>=20
> Shouldn't this rather be done in the at91_ide driver?
> I don't want to duplicate it in all the different at91sam9XX_devices.=
c files.

Ok, I'll move detection stuff to the driver. Not sure about reset, see =
my=20
previous mail on this issue. Could we move the reset into driver and
risk system boot with device which possibly generate interrupts?
Or perhaps we can remove reset as whole?

> You could also define two separate "CF type" devices - one for CS4,
> another for CS5.
> That would allow for two independent "CF type" interfaces to be used
> at the same time (see at91sam9260_devices.c in maxim.org.za patches).

I saw sam9260 code before and I refused idea of doing two CF devices=20
interfaces. AFAIK there are no boards we two CF slots (or separate one
IDE and one CF slot), are they? I don't think someone really need such=20
board (I could be wrong). If there become a board with two interfaces,=20
then new patch can be done which extend the code.
=20
Cheers
Stanislaw Gruszka
