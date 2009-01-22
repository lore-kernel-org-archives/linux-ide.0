From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Thu, 22 Jan 2009 12:12:55 +0100
Message-ID: <200901221212.55528.stf_xl@wp.pl>
References: <200901141345.42583.stf_xl@wp.pl> <4975B065.6030705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:64582 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753983AbZAVLNB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2009 06:13:01 -0500
In-Reply-To: <4975B065.6030705@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Tuesday 20 January 2009 12:07:17 Sergei Shtylyov napisa=C5=82(a):
> >  arch/arm/mach-at91/at91sam9263_devices.c |   96 +++++++
> >  arch/arm/mach-at91/board-sam9263ek.c     |   11 +
> >  arch/arm/mach-at91/include/mach/board.h  |    9 +
> >  =20
>=20
>    This should probably go thru the ARM tree... though the maintainer=
=20
> will decide.
I will submit patches to linux-ide and ARM things separately (ARM when =
I=20
finally test with Atmel Evaluation Kit) . Against which tree IDE patche=
s
should be submitted, against Bart's kernel?

> > +/* Proper CS address space will be added */
> > +#define AT91_IDE_TASK_FILE	0x00c00000
> > +#define AT91_IDE_CTRL_REG	0x00e00000
> >  =20
>=20
>    Er, are you sure? Address lines should be 110 to address the devic=
e=20
> control and alternate status registers, do they get asserted properly=
?
Hmm, you may have right, because I can see warning=20

hda: probing with STATUS(0x50) instead of ALTSTATUS(0x00)

but I don't understand this issue, I'm going to investigate.

> > + * IDE host driver for AT91 Static Memory Controler
> >  =20
>=20
>   I'm afraid you're being too generic here: e.g. AT91RM9200 has=20
> incompatible SMC.
Well, we could add #ifdef with diffrent implementation of init_smc_mode=
(),=20
set_8bit_mode(), etc...=20

> > +	at91_sys_write(AT91_SMC_MODE(chipselect), AT91_SMC_READMODE |
> > +						  AT91_SMC_WRITEMODE |
> > +						  AT91_SMC_BAT_SELECT |
> > +						  AT91_SMC_TDF_(2));=20
>=20
>    I'm not sure why you're fixing the data float timing to 2 cycles -=
-=20
> it correponds to the t6z timing which is 30 ns for ATA modes and 20 n=
s=20
> for CF specific ones...
Right, TDF it's not needed as long as recover time is longer than t6z a=
nd such
is in our case.

> > +	tmp *=3D mck_hz;
> > +	tmp +=3D 1000*1000*1000 + 1; /* round up */
>=20
>     You probably mean -1 if you intend to just round up (so tmp +=3D=20
> 999999999).
Opps.
=20
> > +		if (t9 < t2i - t1)
> > +			t9 =3D t2i - t1;
> >  =20
>=20
>    It  more sense to calculate such things *after* quantizing the=20
> timings with calc_mck_cycles()...
Why?=20

> > +	mck =3D clk_get(NULL, "mck");
> > +	BUG_ON(IS_ERR(mck));
> > +	mck_hz =3D clk_get_rate(mck);
> >  =20
>=20
>    Why not call clk_get[_rate]() only once, at startup? It can change=
=20
> dynamically?
No. But it's like a global variable with some fancy interface. I don't =
like to=20
have own copy global copy of mck_hz.

> > +	t2i =3D calc_mck_cycles(t2i, mck_hz);
> >  =20
>=20
>    If you're not using t2i, why quantize it?
Just for debug, will be removed.
=20
> > +	t9 =3D calc_mck_cycles(t9, mck_hz);
> > +	pdbg("t0=3D%u t1=3D%u t2=3D%u t2i=3D%u t9=3D%u\n", t0, t1, t2, t2=
i, t9);
> >  =20
>=20
>    Besides, we have ide_timing_compute() doing the same thing.
I don't like results of ide_timing_compute(), I will use ide_timing_fin=
d_mode() and quantize
by my own. This also is needed at startup when we need to program SMC a=
nd have no
drive structure to pass to ide_timing_compute().

>=20
> > +	/* values are rounded up so we need to assure cycle is larger tha=
n pulse */
> > +	if (t0 < t1 + t2 + t9)
> > +		t0 =3D t1 + t2 + t9;
> > +
> > +	/* setup calculated timings */
> > +	at91_sys_write(AT91_SMC_SETUP(chipselect), AT91_SMC_NWESETUP_(t1)=
 |
> > +						   AT91_SMC_NCS_WRSETUP_(0) |
> > +						   AT91_SMC_NRDSETUP_(t1) |
> > +						   AT91_SMC_NCS_RDSETUP_(0));
> > +	at91_sys_write(AT91_SMC_PULSE(chipselect), AT91_SMC_NWEPULSE_(t2)=
 |
> > +						   AT91_SMC_NCS_WRPULSE_(t1 + t2 + t9) |
> >  =20
>=20
>   With zero address to CS setup time it's the same as t0.
Not true for slower PIO modes. But CS pulse can be t0. Write data is dr=
iver on
NWR signal (WRITE_MODE =3D 1) in at91_ide,  in opposite to pata_at32 wh=
ere=20
there is need to non zero CS setup or recovery time.
=20
> > +	/* disable or enable waiting for IORDY signal */
> > +	mode =3D at91_sys_read(AT91_SMC_MODE(chipselect));
> > +	mode &=3D ~AT91_SMC_EXNWMODE;
> > +	if (pio <=3D 4)
> >  =20
>=20
>    The IORDY loigic is not as simple -- you'd better use=20
> ata_id_has_iordy() for PIO modes < 5.
Hmm. Really IDE host should behave like this? Must IDENTYFY
DEVICE and then disable IORDY if device not use it. Maybe
this is simpler, host have to react on IORDY signal but device
just not assert it.=20

I would like to remove this code and have allways NWAIT
READY mode to make flipping 8/16 simpler. But I don't think we=20
have guarantees that PIO5 and 6 devices not assert IORDY.

> > +	else=20
> > +		mode |=3D AT91_SMC_EXNWMODE_DISABLE;
> >  =20
>=20
>    This constant is 0, so else branch can be skipped.
Do you think this make code more readable? Compiler optimize this.

>    Why not pass it normally, via the platform device's resource?
Irq pin is board specific. When use resource I will need in processor=20
code modify resource. I think this is not necessary code. Anyway
I need to have access to board data to get chipselect number.

> > +#ifdef AT91_GPIO_IRQ_HACK
> > +#define NR_TRIES 10
> > +	int ntries =3D 0;
> > +	int pin_val1, pin_val2;=09
> > +	do {
> > +		pin_val1 =3D at91_get_gpio_value(AT91_PIN_PB20);
> > +		pin_val2 =3D at91_get_gpio_value(AT91_PIN_PB20);
> > +	} while (pin_val1 !=3D pin_val2 && ntries++ < NR_TRIES);
> >  =20
>=20
>    You need manual pin debouncing even after calling=20
> at91_set_deglitch()? :-O
I'll check. Maybe the delay is enough for us.

> MBR, Sergei

Thanks very much
Stanislaw Gruszka
