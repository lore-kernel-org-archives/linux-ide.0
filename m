From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Fri, 6 Feb 2009 10:35:16 +0100
Message-ID: <200902061035.16309.stf_xl@wp.pl>
References: <200902031147.22827.stf_xl@wp.pl> <200902051601.50822.stf_xl@wp.pl> <498B0F22.3090403@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:49422 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754437AbZBFJfU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Feb 2009 04:35:20 -0500
In-Reply-To: <498B0F22.3090403@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Thursday 05 February 2009 17:09:06 Sergei Shtylyov napisa=C5=82(a):
> > If you take a look at arch/arm/mach-at91/*_devices.c files,=20
> > IORESOURCE_IRQ are used for interrupts from devices that are integr=
ated
> > on the chip. Board specific irq pins (like in at91_cf, at91_ether) =
are not
> > passed to platform driver via platform_resource but via board data.
>=20
>     I don't care what the particular broken ARM platfrom code does. I=
f it=20
> can't pass resources in a normal way, it should be fixed, and not fol=
lowed as=20
> a good example.
So fix these divers, then I will have no bad examples. I'll stay with b=
oard->irq_pin
for now, moving to platform_resource could be done in separate patch (m=
aybe
with at91_cf and at91_ether).

Cheers
Stanislaw Gruszka
