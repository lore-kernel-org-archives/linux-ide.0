From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 3/3 v3] AT91: initialize Compact Flash on AT91SAM9263 cpu
Date: Tue, 17 Feb 2009 11:21:02 +0100
Message-ID: <200902171121.02329.stf_xl@wp.pl>
References: <200902091145.11266.stf_xl@wp.pl> <cd73a99e0902111203k7670f9d8w17cc90b7dec343fd@mail.gmail.com> <200902121033.57176.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:30940 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbZBQKVJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Feb 2009 05:21:09 -0500
In-Reply-To: <200902121033.57176.stf_xl@wp.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Victor <avictor.za@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Thursday 12 February 2009 10:33:56 Stanislaw Gruszka napisa=C5=82(a):
> > Shouldn't this rather be done in the at91_ide driver?
> > I don't want to duplicate it in all the different at91sam9XX_device=
s.c files.
>=20
> Ok, I'll move detection stuff to the driver. Not sure about reset, se=
e my=20
> previous mail on this issue. Could we move the reset into driver and
> risk system boot with device which possibly generate interrupts?
> Or perhaps we can remove reset as whole?

I'll finally move resetting stuff into board specific file and detect c=
ode
into driver.

> > You could also define two separate "CF type" devices - one for CS4,
> > another for CS5.
> > That would allow for two independent "CF type" interfaces to be use=
d
> > at the same time (see at91sam9260_devices.c in maxim.org.za patches=
).
>=20
> I saw sam9260 code before and I refused idea of doing two CF devices=20
> interfaces. AFAIK there are no boards we two CF slots (or separate on=
e
> IDE and one CF slot), are they? I don't think someone really need suc=
h=20
> board (I could be wrong). If there become a board with two interfaces=
,=20
> then new patch can be done which extend the code.

I see no discussion here is possible :) , ok I'll revrite the code in f=
orm like=20
at91sam9260_devices.c has.

Cheers
Stanislaw Gruszka
