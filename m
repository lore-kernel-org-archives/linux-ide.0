From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Fri, 16 Jan 2009 16:03:03 +0100
Message-ID: <200901161603.03699.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <20090114131727.5b0e5193@lxorguk.ukuu.org.uk> <49708C55.1020204@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:64723 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755785AbZAPPDS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2009 10:03:18 -0500
In-Reply-To: <49708C55.1020204@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ddaney@caviumnetworks.com

=46riday 16 January 2009 14:32:05 Sergei Shtylyov napisa=C5=82(a):
> > You really don't want to put special board specific code in generic
> > locations. In the libata case you don't need to and I think in the =
ide
> > case you can avoid it too by wrapping the IRQ handler.
>=20
>    Unfortunately, it seems you can't wrap ide_intr(), at least with t=
he=20
> current code.
Perhaps only EXPORT_SYMBOL is missed. There is some ide_intr lock funct=
ion,
but it is only used for m68k.
=20
> > Libata also supports polled mode.
> >  =20
>=20
>    Yeah. Stanslaw, I'd (have to) advise going the libata way in this=20
> case -- in case you want to avoid the additional trouble of porting t=
his=20
> broken-minded IRQ implementation to the IDE core...=20
I think, I will try to add AT91 stuff for pata_at91 to have this hardwa=
re
support in mineline. I will also finish at91_ide for my company usage w=
ith
older kernel.
=20
>    Stanislaw's patch is adding the DIOx- to address hold time (t9) to=
=20
> the existing ones. While there's has been already a patch by David Da=
ney=20
> adding this timing to libata (however, the author have ditched this i=
dea=20
> finally), the table in ide-timings.c still misses it, as well as the =
PIO=20
> mode 6 timings...
I use t9 for calculating memory controller settings, but maybe it is un=
needed,
pata_at91 don't use this value.

Cheers
Stanislaw Gruszka
