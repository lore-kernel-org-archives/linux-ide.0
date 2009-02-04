From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: Re: [PATCH 2/3] ide: add at91_ide driver
Date: Wed, 4 Feb 2009 15:47:43 +0100
Message-ID: <200902041547.44149.stf_xl@wp.pl>
References: <200902031147.22827.stf_xl@wp.pl> <498987E6.7040909@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:29767 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbZBDOrs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Feb 2009 09:47:48 -0500
In-Reply-To: <498987E6.7040909@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.arm.linux.org.uk

Wednesday 04 February 2009 13:19:50 Sergei Shtylyov napisa=C5=82(a):
> > diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mac=
h-at91/include/mach/board.h
> > index fb51f0e..6674b9b 100644
> > --- a/arch/arm/mach-at91/include/mach/board.h
> > +++ b/arch/arm/mach-at91/include/mach/board.h
> > @@ -59,6 +59,18 @@ struct at91_cf_data {
> >  };
> >  extern void __init at91_add_device_cf(struct at91_cf_data *data);
> > =20
> > + /* Compact Flash True IDE mode */
> > +struct at91_ide_data {
> > +	u8	irq_pin;		/* the same meaning as for CF */
> >  =20
>=20
>   I again have to express my dislike about not passing IRQ the usual=20
> way. Also, see my comments to the platform code.

Yes, I know, I don't like to argue. Only reasoning to use platform irq =
resource
seams to be: "because other drivers do". However we have exception - at=
91_cf
also use board->irq_pin, so maybe this driver could also do ?

> > +	u8	det_pin;
> > +	u8	rst_pin;
> > +	u8	chipselect;
> > +	u8	flags;
> > +#define AT91_IDE_SWAP_A0_A2 0x01
> > +};
> > +
> > +extern void __init at91_add_device_ide(struct at91_ide_data *data)=
;
> > +
> >   /* MMC / SD */
> >  struct at91_mmc_data {
> >  	u8		det_pin;	/* card detect IRQ */
> > diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
> > index 3dad229..b11da5b 100644
> > --- a/drivers/ide/Kconfig
> > +++ b/drivers/ide/Kconfig
> > @@ -721,6 +721,11 @@ config BLK_DEV_IDE_TX4939
> >  	depends on SOC_TX4939
> >  	select BLK_DEV_IDEDMA_SFF
> > =20
> > +config BLK_DEV_IDE_AT91
> > +	tristate "Atmel AT91 IDE support"
> >  =20
>=20
>    Please be more specific -- you can't drive AT91RM9200 SMC.

Ok.

>=20
> > +	depends on ARM && ARCH_AT91
> >  =20
>=20
>    Please add "&& !ARCH_AT91RM9200". And maybe "&& !ARCH_AT91X40" too=
=2E..

Ok.
=20
> > diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
> > new file mode 100644
> > index 0000000..3a1f7e0
> > --- /dev/null
> > +++ b/drivers/ide/at91_ide.c
> > @@ -0,0 +1,496 @@
> > +/*
> > + * IDE host driver for AT91SAM9 Static Memory Controller
> >  =20
>=20
>    Why not call the driver 'at91sam9_ide'?
>=20
> > +/*
> > + * AT91 Static Memory Controller
>=20
>   AT91SAM9.

Ok, currently only SAM9 can be used with driver. However I think adding
support to AT91RM9200 to this driver will be not much effort. I don't t=
hink
someone will want to write new driver for RM9200 insted using this one.

IMHO, current name is short and sweet and not miss the true so much -
most of the AT91s which can work with True IDE logic are supported.=20
I would like to stay with current name.

> > maps Task File and Data Register
> >  =20
> > + * at the same address. To distinguish access between these two
>=20
>    It would have been strange if it did it otherwise...
>=20
> > + * different bus data width is used: 8Bit for Task File, 16Bit for=
 Data I/O
> > + *
> > + * After initialization we do 8/16 bit flipping (changes in SMC MO=
DE register)
> > + * only inside IDE callback routines which are serialized by IDE l=
ayer,
> > + * so no additional locking needed.
> > + */
> > +
> > +static void init_smc_mode(const u8 chipselect)
> > +{
> > +	at91_sys_write(AT91_SMC_MODE(chipselect), AT91_SMC_READMODE |
> > +						  AT91_SMC_WRITEMODE |
> > +						  AT91_SMC_BAT_SELECT |
> > +						  AT91_SMC_TDF_(0));
> >  =20
>=20
>    I'm not sure why are you fixing the dataflow timing again, this ti=
me=20
> to 0...

Not necessary code, will be removed.

> > +}
> > +
> > +static inline void set_8bit_mode(const u8 chipselect)
> > +{
> > +	unsigned long mode =3D at91_sys_read(AT91_SMC_MODE(chipselect));
> > +	mode &=3D ~AT91_SMC_DBW;
> > +	mode |=3D AT91_SMC_DBW_8;
> > +	at91_sys_write(AT91_SMC_MODE(chipselect), mode);
> > +	pdbg("%u %08lx\n", chipselect, mode);
> > +}
> > +
> > +static inline void set_16bit_mode(const u8 chipselect)
> > +{
> > +	unsigned long mode =3D at91_sys_read(AT91_SMC_MODE(chipselect));
> > +	mode &=3D ~AT91_SMC_DBW;
> > +	mode |=3D AT91_SMC_DBW_16;
> > +	at91_sys_write(AT91_SMC_MODE(chipselect), mode);
> > +	pdbg("%u %08lx\n", chipselect, mode);
> > +}
> >  =20
>=20
>   I'd advice to make this single function because it looks like a cod=
e=20
> duplication too much.

Uh well.

> > +static void set_smc_timings(const u8 chipselect, const u16 cycle,
> > +			    const u16 setup, const u16 pulse,
> > +			    const u16 data_float, int use_iordy)
> >  =20
>=20
>    Have you considered using already present sam9_smc_configure()=20
> instead to avoid the code duplication (it needs to be exported though=
)?

I think, it need to be exported, I'll check.

> > +{
> > +	unsigned long mode;
> > +
> > +	/* setup timings in SMC */
> > +	at91_sys_write(AT91_SMC_SETUP(chipselect), AT91_SMC_NWESETUP_(set=
up) |
> > +						   AT91_SMC_NCS_WRSETUP_(0) |
> > +						   AT91_SMC_NRDSETUP_(setup) |
> > +						   AT91_SMC_NCS_RDSETUP_(0));
> > +	at91_sys_write(AT91_SMC_PULSE(chipselect), AT91_SMC_NWEPULSE_(pul=
se) |
> > +						   AT91_SMC_NCS_WRPULSE_(cycle) |
> > +						   AT91_SMC_NRDPULSE_(pulse) |
> > +						   AT91_SMC_NCS_RDPULSE_(cycle));
> > +	at91_sys_write(AT91_SMC_CYCLE(chipselect), AT91_SMC_NWECYCLE_(cyc=
le) |
> > +						   AT91_SMC_NRDCYCLE_(cycle));
> > +
> > +	mode =3D at91_sys_read(AT91_SMC_MODE(chipselect));
> >  =20
>=20
>    Frankly speaking, I don't see why you're reading this register bac=
k=20
> if you already know what needs to be set there -- as you've done it i=
n=20
> init_smc_mode().

This function is not only used at initialization. It is also used when =
PIO mode
is changed.

> > +static unsigned int calc_mck_cycles(unsigned int ns, unsigned int =
mck_hz)
> > +{
> > +	u64 tmp =3D ns;
> > +
> > +	tmp *=3D mck_hz;
> > +	tmp +=3D 1000*1000*1000 - 1; /* round up */
> > +	do_div(tmp, 1000*1000*1000);
> > +	return (unsigned int) tmp;
> > +}
> > +
> > +static void apply_timings(const u8 chipselect, const u8 pio,
> > +			  const struct ide_timing *timing, const u16 *ata_id)
> > +{
> > +	unsigned int t0, t1, t2, t6z, th;
> > +	unsigned int cycle, setup, pulse, data_float;
> > +	unsigned int mck_hz;
> > +	struct clk *mck;
> > +	int use_iordy;
> >  =20
> [...]
> > +
> > +	use_iordy =3D 0;
> >  =20
>=20
>    Can be done in initializer...

But here is more readable, I think.

> > +	if (ata_id) {
> > +		if (ata_id_is_cfa(ata_id)) {
> > +			if (pio =3D=3D 3 || pio =3D=3D 4)
> > +				use_iordy =3D 1;
> >  =20
> > +		} else if (pio >=3D 3 || ata_id_has_iordy(ata_id))
> > +			use_iordy =3D 1;
> >  =20
>=20
>=20
>    No, you should check for IORDY regardless of CFA and using IORDY=20
> shouldn't be limeited to modes 3 and 4:

Hmm, I take as example ata_pio_need_iordy(), it is also wrong or maybe
I don't follow the logic properly.

=20
>         if (ata_id_has_iordy(ata_id) && !(ata_id_is_cfa(ata_id) && pi=
o > 4))
>            use_iodry =3D 1;
>=20
> > +static u8 ide_mm_inb(unsigned long port)
> > +{
> > +	return (u8) readb((void __iomem *) port);
> >  =20
>=20
>   Explict cast not needed here.

Ok.

> > +irqreturn_t at91_irq_handler(int irq, void *dev_id)
> > +{
> > +	int ntries =3D 8;
> > +	int pin_val1, pin_val2;
> > +
> > +	/* additional deglitch, line can be noisy in badly designed PCB *=
/
> > +	do {
> > +		pin_val1 =3D at91_get_gpio_value(irq);
> > +		pin_val2 =3D at91_get_gpio_value(irq);
> > +	} while (pin_val1 !=3D pin_val2 && --ntries > 0);
> >  =20
>   I suggest a shorter code:
>=20
> 	do {
> 		pin_val =3D at91_get_gpio_value(irq);
> 	} while (pin_val !=3D at91_get_gpio_value(irq) && --ntries > 0);

=46or me your form is less readable.

> > +static int __init at91_ide_probe(struct platform_device *pdev)
> > +{
> >  =20
> [...]
> > +	host->ports[0]->extra_base =3D board->chipselect;
> >  =20
>=20
>    BTW, we have 2 fields in the struct hwif_s that fit this case bett=
er:=20
> config_data and select_data. It's a bit stange that you've selected=20
> extra_base...

Ok.

Regards
Stanislaw Gruszka
