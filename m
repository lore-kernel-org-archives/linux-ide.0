From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 3/3 v3] AT91: initialize Compact Flash on AT91SAM9263 cpu
Date: Fri, 13 Feb 2009 11:48:08 +0100
Message-ID: <200902131148.08728.stf_xl@wp.pl>
References: <200902091145.11266.stf_xl@wp.pl> <200902121005.46772.stf_xl@wp.pl> <49944F44.1080807@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:61306 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbZBMKs2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Feb 2009 05:48:28 -0500
In-Reply-To: <49944F44.1080807@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk

Hi.

Thursday 12 February 2009 17:33:08 Sergei Shtylyov napisa=C5=82(a):
> >>   I'm still not sure why this is needed. Do you think thta power-o=
n=20
> >>reset is not enough?
>=20
> > HW reset is not needed when board is powered-on. But situation is
> > diffrent when we have reboot due to board reset booton press.
> > There are configuration where signal from reset button is connected
> > to CF card (or disk), in some cases device reset signal is connecte=
d to
> > GPIO with assumption to be asserted by software.
>=20
>     OK, thanks for the explanation.
>=20
> > I don't know if we can remove this.
>=20
>     Well, seems worth keeping.
>=20
> > In hw reset case system/driver will run with undefined device state=
,
>=20
>     What do you mean by undefined? It could have not come out of rese=
t which=20
> shoiuld mean that the IDE probing code will have to wait some time be=
fore BSY=20
> clears -- see ide_port_wait_ready().
>=20
> > in example device can generate interrupts.
>=20
>     Interrupts after any kind of reset? That just shouldn't happen --=
 it's=20
> against the ATA spec at least.
I mean undefined state and interrupts where is _no_ IDE device reset
and system boots because of board button h/w reset (or watchdog reset).

Ok, IDE layer will cope with any registers state during initialization,=
 but
when not handled interrupt is generated we have spurious interrupt
which is some trouble for kernel.

Cheers
Stanislaw Gruszka
