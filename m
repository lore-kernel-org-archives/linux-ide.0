From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 22 Jan 2009 14:14:39 +0100
Message-ID: <200901221414.39802.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <200901221212.55528.stf_xl@wp.pl> <49786138.20809@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:63516 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbZAVNOq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 08:14:46 -0500
In-Reply-To: <49786138.20809@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Thursday 22 January 2009 13:06:16 Sergei Shtylyov napisa=C5=82(a):
> >>> +/* Proper CS address space will be added */
> >>> +#define AT91_IDE_TASK_FILE	0x00c00000
> >>> +#define AT91_IDE_CTRL_REG	0x00e00000
>=20
>    Besides, I'm not sure: these 2 address range are decoded via 1 SMC=
=20
> chip select or 2?

These are in one chip select address space.

> > Well, we could add #ifdef with diffrent implementation of init_smc_=
mode(),=20
> > set_8bit_mode(), etc...=20
> >  =20
>=20
>    No, #ifdef'ery is certainly not an option.

Why? Other option is create some header files and implement and exporti=
ng these
functions from processor specific code. This add files dependencies and=
 spread
things across sources, FWIW.

> >>> +	/* values are rounded up so we need to assure cycle is larger t=
han pulse */
> >>> +	if (t0 < t1 + t2 + t9)
> >>> +		t0 =3D t1 + t2 + t9;
> >>> +
> >>> +	/* setup calculated timings */
> >>> +	at91_sys_write(AT91_SMC_SETUP(chipselect), AT91_SMC_NWESETUP_(t=
1) |
> >>> +						   AT91_SMC_NCS_WRSETUP_(0) |
> >>> +						   AT91_SMC_NRDSETUP_(t1) |
> >>> +						   AT91_SMC_NCS_RDSETUP_(0));
> >>> +	at91_sys_write(AT91_SMC_PULSE(chipselect), AT91_SMC_NWEPULSE_(t=
2) |
> >>> +						   AT91_SMC_NCS_WRPULSE_(t1 + t2 + t9) |
> >>>  =20
> >>>      =20
> >>   With zero address to CS setup time it's the same as t0.
> >>    =20
> > Not true for slower PIO modes.
>=20
>    Well, you're right probably...
>=20
> > But CS pulse can be t0.
>=20
>    Yes, it must be no less than t0.

Pulse time can be less than t0, cycle time no.
=20
> > Write data is driver on
> > NWR signal (WRITE_MODE =3D 1) in at91_ide,  in opposite to pata_at3=
2 where=20
> > there is need to non zero CS setup or recovery time.
> >  =20
>=20
>    You're always setting CS setup to 0. Recovery time can't be 0, you=
=20
> probably mean nCS hold time?

Yes, NCS hold time of course.

=20
> > Maybe this is simpler, host have to react on IORDY signal but devic=
e
> > just not assert it.=20
> >
> > I would like to remove this code and have allways NWAIT
> > READY mode to make flipping 8/16 simpler.
>
>    I don't understand how these are connected.

Both set SMC MODE register. If I will not change NWAIT in MODE register=
,
I can write static values in set_8/16bit_mode and stop doing logical op=
eration on it.

> >>    Why not pass it normally, via the platform device's resource?
> >>    =20
> > Irq pin is board specific. When use resource I will need in process=
or=20
> > code modify resource.
>=20
>    So what? That's pretty normal and won't take much code.

I see only more memory and code usage. Let's reverse question:
Why use RESOURCE_IRQ when we have irq in board data?


Cheers
Stanislaw Gruszka
