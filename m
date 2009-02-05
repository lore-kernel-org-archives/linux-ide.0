From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Thu, 5 Feb 2009 16:01:50 +0100
Message-ID: <200902051601.50822.stf_xl@wp.pl>
References: <200902031147.22827.stf_xl@wp.pl> <200902041547.44149.stf_xl@wp.pl> <4989BC8B.4010105@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:53567 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757284AbZBEPGX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Feb 2009 10:06:23 -0500
In-Reply-To: <4989BC8B.4010105@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Wednesday 04 February 2009 17:04:27 Sergei Shtylyov napisa=C5=82(a):
> >>> extern void __init at91_add_device_cf(struct at91_cf_data *data);
> >>>=20
> >>>+ /* Compact Flash True IDE mode */
> >>>+struct at91_ide_data {
> >>>+	u8	irq_pin;		/* the same meaning as for CF */
>=20
> >>  I again have to express my dislike about not passing IRQ the usua=
l=20
> >>way. Also, see my comments to the platform code.
>=20
> > Yes, I know, I don't like to argue. Only reasoning to use platform =
irq resource
> > seams to be: "because other drivers do". However we have exception =
- at91_cf
> > also use board->irq_pin, so maybe this driver could also do ?
>=20
>     Then why have the memory resource when we can calculate it from t=
he chip=20
> select? =20
Great idea, I very like it :) But memory is a platform (cpu) resource, =
however
board dependend.

> (I'm not asking you to do that, since the platfrom device resources  =
=20
> are user-visible thru /proc/iomem -- even if the driver is not enable=
d.)
Let's distinguish platform (cpu) resources and board resources.

If you take a look at arch/arm/mach-at91/*_devices.c files,=20
IORESOURCE_IRQ are used for interrupts from devices that are integrated
on the chip. Board specific irq pins (like in at91_cf, at91_ether) are =
not
passed to platform driver via platform_resource but via board data.

> >>>diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
> >>>new file mode 100644
> >>>index 0000000..3a1f7e0
> >>>--- /dev/null
> >>>+++ b/drivers/ide/at91_ide.c
> >>>@@ -0,0 +1,496 @@
> >>>+/*
> >>>+ * IDE host driver for AT91SAM9 Static Memory Controller
>=20
> >>   Why not call the driver 'at91sam9_ide'?
>=20
> >>>+/*
> >>>+ * AT91 Static Memory Controller
>=20
> >>  AT91SAM9.
>=20
> > Ok, currently only SAM9 can be used with driver. However I think ad=
ding
> > support to AT91RM9200 to this driver will be not much effort.
>=20
>     Can you answer the simple question: why we should try to support =
two=20
> incompatible chips with a single driver? Because the driver name will=
 be=20
> shorter? :-)
Very funny. I think patch adding RM9200 support to this driver will hav=
e less
than 50 lines changeset, whereas writing new driver would be about 500
lines.

> > I don't think
> > someone will want to write new driver for RM9200 insted using this =
one.
>=20
>     You're right, nobody will want that... because AT91RM9200 as is h=
as *no=20
> support for True IDE mode*. ;-)
Atmel documents are confusing. AT91RM9200 datasheet tells there is no
True IDE support, but RM9200 hard drive application note (which I send =
you
a link before) tell it is.

> >>   Frankly speaking, I don't see why you're reading this register b=
ack=20
> >>if you already know what needs to be set there -- as you've done it=
 in=20
> >>init_smc_mode().
>=20
> > This function is not only used at initialization. It is also used w=
hen PIO mode
> > is changed.
>=20
>     So what? You can just write the fixed mode bits into the register=
 every=20
> time without readback.

Ok, I see now.

Cheers
Stanislaw Gruszka
