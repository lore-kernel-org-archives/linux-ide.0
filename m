From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Fri, 18 Jan 2008 23:19:41 +0100
Message-ID: <200801182319.41354.bzolnier@gmail.com>
References: <200801172150.57059.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:47361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762896AbYARWIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 17:08:34 -0500
Received: by ug-out-1314.google.com with SMTP id z38so536788ugc.16
        for <linux-ide@vger.kernel.org>; Fri, 18 Jan 2008 14:08:31 -0800 (PST)
In-Reply-To: <200801172150.57059.asalnikov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>


Hi,

On Thursday 17 January 2008, Anton Salnikov wrote:
> This is Palmchip BK3710 IDE controller support for kernel version 2.6=
=2E24-rc8.
> The IDE controller logic supports PIO, multiword DMA and ultra-DMA mo=
des.
> Supports interface to compact Flash (CF) configured in True-IDE mode.

Thanks, overall it looks good but the way in which controller registers=
 are
accessed needs to be reworked according to Alan's comments before this =
driver
can be accepted in the mainline.

> I had to export two functions (ide_dma_exec_cmd and __ide_dma_test_ir=
q) from=20
> driver/ide/ide-dma.c to get rid of copying them.

Please make the exports _GPL.

Also some minor comments below.

> Signed-off-by: Anton Salnikov <asalnikov@ru.mvista.com>
> ---
>=20
>  drivers/ide/Kconfig           |    8=20
>  drivers/ide/arm/Makefile      |    1=20
>  drivers/ide/arm/palm_bk3710.c |  486 +++++++++++++++++++++++++++++++=
+++++++++++
>  drivers/ide/ide-dma.c         |    6=20
>  drivers/ide/ide-proc.c        |    1=20
>  include/linux/ide.h           |    4=20
>  6 files changed, 503 insertions(+), 3 deletions(-)
>=20
> Index: 2.6.24-rc7.ide/drivers/ide/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- 2.6.24-rc7.ide.orig/drivers/ide/Kconfig
> +++ 2.6.24-rc7.ide/drivers/ide/Kconfig
> @@ -1008,6 +1008,14 @@ config BLK_DEV_Q40IDE
>  	  normally be on; disable it only if you are running a custom hard
>  	  drive subsystem through an expansion card.
> =20
> +config BLK_DEV_PALMCHIP_BK3710
> +	bool "Palmchip bk3710 IDE controller support"

tristate?

> +	depends on ARCH_DAVINCI
> +	select BLK_DEV_IDEDMA_PCI
> +	help
> +	  Say Y here if you want to support the onchip IDE controller on th=
e
> +	  TI DaVinci SoC

[...]

> Index: 2.6.24-rc7.ide/drivers/ide/arm/palm_bk3710.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ 2.6.24-rc7.ide/drivers/ide/arm/palm_bk3710.c
> @@ -0,0 +1,486 @@
> +/*
> + * Palmchip bk3710 IDE controller
> + *
> + * Copyright (C) 2006 Texas Instruments.
> + * Copyright (C) 2007 MontaVista Software, Inc., <source@mvista.com>

[...]

> + Modifications:
> + ver. 1.0: Oct 2005, Swaminathan S
> + -

I would prefer revision history to be removed if possible (we keep chan=
gelogs
in git tree, also the date doesn't match with Copyrights notice).

[...]

> +static ide_hwif_t *palm_bk3710_hwif;

palm_bk3710_hwif is only accessed in palm_bk3710_probe() so may be as w=
ell
moved there (+ renamed to hwif to match usual naming used by other driv=
ers)

> +static struct palm_bk3710_ideregs __iomem *palm_bk3710_base;
> +static long ide_palm_clk;
> +
> +static const struct palm_bk3710_udmatiming palm_bk3710_udmatimings[6=
] =3D {
> +	{160, 240},		/* UDMA Mode 0 */
> +	{125, 160},		/* UDMA Mode 1 */
> +	{100, 120},		/* UDMA Mode 2 */
> +	{100, 90},		/* UDMA Mode 3 */
> +	{85,  60},		/* UDMA Mode 4 */
> +	{85,  40}		/* UDMA Mode 5 */
> +};

Hmmm, but palm_bk3710_probe() limits max UDMA to UDMA4...?

> +static struct clk *ideclkp;
> +
> +static void palm_bk3710_setudmamode(unsigned int dev, unsigned int l=
evel)

'level' is a bit confusing name for UDMA mode number

> +{
> +	char ide_tenv, ide_trp, ide_t0;

- char -> u8
- "ide_" prefix may as well be dropped

> +	/* DMA Data Setup */
> +	ide_t0 =3D (palm_bk3710_udmatimings[level].cycletime + ide_palm_clk=
 - 1)
> +			/ ide_palm_clk - 1;
> +	ide_tenv =3D (20 + ide_palm_clk - 1) / ide_palm_clk - 1;
> +	ide_trp =3D (palm_bk3710_udmatimings[level].rptime + ide_palm_clk -=
 1)
> +			/ ide_palm_clk - 1;
> +
> +
> +	if (!dev) {

Since this code needs to be recasted anyway it would be a nice cleanup
to merge '!dev' and 'dev' cases.

> +		/* setup master device parameters */
> +
> +		/* udmatim Register */
> +		palm_bk3710_base->config.udmatim &=3D 0xFFF0;
> +		palm_bk3710_base->config.udmatim |=3D level;
> +		/* udmastb Ultra DMA Access Strobe Width */
> +		palm_bk3710_base->config.udmastb &=3D 0xFF00;
> +		palm_bk3710_base->config.udmastb |=3D ide_t0;
> +		/* udmatrp Ultra DMA Ready to Pause Time */
> +		palm_bk3710_base->config.udmatrp &=3D 0xFF00;
> +		palm_bk3710_base->config.udmatrp |=3D ide_trp;
> +		/* udmaenv Ultra DMA envelop Time */
> +		palm_bk3710_base->config.udmaenv &=3D 0xFF00;
> +		palm_bk3710_base->config.udmaenv |=3D ide_tenv;
> +		/* Enable UDMA for Device 0 */
> +		palm_bk3710_base->config.udmactl |=3D 1;
> +	} else {
> +		/* setup slave device parameters */
> +
> +		/* udmatim Register */
> +		palm_bk3710_base->config.udmatim &=3D 0xFF0F;
> +		palm_bk3710_base->config.udmatim |=3D (level << 4);
> +		/* udmastb Ultra DMA Access Strobe Width */
> +		palm_bk3710_base->config.udmastb &=3D 0xFF;
> +		palm_bk3710_base->config.udmastb |=3D (ide_t0 << 8);
> +		/* udmatrp Ultra DMA Ready to Pause Time */
> +		palm_bk3710_base->config.udmatrp &=3D 0xFF;
> +		palm_bk3710_base->config.udmatrp |=3D (ide_trp << 8);
> +		/* udmaenv Ultra DMA envelop Time */
> +		palm_bk3710_base->config.udmaenv &=3D 0xFF;
> +		palm_bk3710_base->config.udmaenv |=3D (ide_tenv << 8);
> +		/* Enable UDMA for Device 1 */
> +		palm_bk3710_base->config.udmactl |=3D (1 << 1);
> +	}
> +}
> +
> +static void palm_bk3710_setdmamode(unsigned int dev, unsigned int cy=
cletime,
> +				  unsigned int mode)
> +{
> +	char ide_td, ide_tkw, ide_t0;

- char -> u8
- "ide_" prefix may as well be dropped

> +	if (cycletime < ide_timing[mode].cycle)
> +		cycletime =3D ide_timing[mode].cycle;
> +
> +	/* DMA Data Setup */
> +	ide_t0 =3D (cycletime + ide_palm_clk - 1) / ide_palm_clk;
> +	ide_td =3D (ide_timing[mode].active + ide_palm_clk - 1) / ide_palm_=
clk;

once ide-timing.h gets converted to ide-timing.c (or the new modes are =
added)
the above will break, please use ide_timing_find_mode() to access ide_t=
iming[]

[ even better would be to use ide_timing_compute() so non-standard PIO/=
DMA
  timings specified by some drives are handled correctly ]

> +	ide_tkw =3D ide_t0 - ide_td - 1;
> +	ide_td -=3D 1;
> +
> +	if (!dev) {

'!dev' and 'dev' cases may be merged

> +		/* setup master device parameters */
> +		palm_bk3710_base->config.dmastb &=3D 0xFF00;
> +		palm_bk3710_base->config.dmastb |=3D ide_td;
> +		palm_bk3710_base->config.dmarcvr &=3D 0xFF00;
> +		palm_bk3710_base->config.dmarcvr |=3D ide_tkw;
> +		/* Disable UDMA for Device 0 */
> +		palm_bk3710_base->config.udmactl &=3D 0xFF02;
> +	} else {
> +		/* setup slave device parameters */
> +		palm_bk3710_base->config.dmastb &=3D 0xFF;
> +		palm_bk3710_base->config.dmastb |=3D (ide_td << 8);
> +		palm_bk3710_base->config.dmarcvr &=3D 0xFF;
> +		palm_bk3710_base->config.dmarcvr |=3D (ide_tkw << 8);
> +		/* Disable UDMA for Device 1 */
> +		palm_bk3710_base->config.udmactl &=3D 0xFF01;
> +	}
> +}
> +
> +static void palm_bk3710_setpiomode(ide_drive_t *mate, unsigned int d=
ev,
> +				  unsigned int cycletime, unsigned int mode)
> +{
> +	char ide_t2, ide_t2i, ide_t0;

- char -> u8
- "ide_" prefix may as well be dropped

> +	/* PIO Data Setup */
> +	ide_t0 =3D (cycletime + ide_palm_clk - 1) / ide_palm_clk;
> +	ide_t2 =3D (ide_timing[19 - mode].active + ide_palm_clk - 1)

ide_timing_find_mode()

> +			/ ide_palm_clk;
> +
> +	ide_t2i =3D ide_t0 - ide_t2 - 1;
> +	ide_t2 -=3D 1;
> +
> +	if (!dev) {

'!dev' and 'dev' cases may be merged

> +		/* setup master device parameters */
> +		palm_bk3710_base->config.datstb &=3D 0xFF00;
> +		palm_bk3710_base->config.datstb |=3D ide_t2;
> +		palm_bk3710_base->config.datrcvr &=3D 0xFF00;
> +		palm_bk3710_base->config.datrcvr |=3D ide_t2i;
> +	} else {
> +		/* setup slave device parameters */
> +		palm_bk3710_base->config.datstb &=3D 0xFF;
> +		palm_bk3710_base->config.datstb |=3D (ide_t2 << 8);
> +		palm_bk3710_base->config.datrcvr &=3D 0xFF;
> +		palm_bk3710_base->config.datrcvr |=3D (ide_t2i << 8);
> +	}
> +
> +	if (mate && mate->present) {
> +		u8 mode2 =3D ide_get_best_pio_mode(mate, 255, 4);
> +
> +		if (mode2 < mode)
> +			mode =3D mode2;
> +	}
> +
> +	/* TASKFILE Setup */
> +	ide_t0 =3D (ide_timing[19 - mode].cyc8b + ide_palm_clk - 1)
> +			/ ide_palm_clk;
> +	ide_t2 =3D (ide_timing[19 - mode].act8b + ide_palm_clk - 1)
> +			/ ide_palm_clk;

ide_timing_find_mode()

> +	ide_t2i =3D ide_t0 - ide_t2 - 1;
> +	ide_t2 -=3D 1;
> +
> +	if (!dev) {

'!dev' and 'dev' cases may be merged

> +		/* setup master device parameters */
> +		palm_bk3710_base->config.regstb &=3D 0xFF00;
> +		palm_bk3710_base->config.regstb |=3D ide_t2;
> +		palm_bk3710_base->config.regrcvr &=3D 0xFF00;
> +		palm_bk3710_base->config.regrcvr |=3D ide_t2i;
> +	} else {
> +		/* setup slave device parameters */
> +		palm_bk3710_base->config.regstb &=3D 0xFF;
> +		palm_bk3710_base->config.regstb |=3D (ide_t2 << 8);
> +		palm_bk3710_base->config.regrcvr &=3D 0xFF;
> +		palm_bk3710_base->config.regrcvr |=3D (ide_t2i << 8);
> +	}
> +}
> +
> +static void palm_bk3710_set_dma_mode(ide_drive_t *drive, u8 xferspee=
d)
> +{
> +	int is_slave =3D drive->dn & 1;
> +
> +	switch (xferspeed) {

it could be simplified to:

	if (xferspeed > XFER_UDMA_0)
		palm_bk3710_setudmamode(...);
	else {
		...
	}

[ upper layers take care of mode filtering ]

> +	case XFER_UDMA_4:
> +	case XFER_UDMA_3:
> +	case XFER_UDMA_2:
> +	case XFER_UDMA_1:
> +	case XFER_UDMA_0:
> +		palm_bk3710_setudmamode(is_slave, xferspeed - XFER_UDMA_0);
> +		break;
> +	case XFER_MW_DMA_2:
> +	case XFER_MW_DMA_1:
> +	case XFER_MW_DMA_0:
> +		{
> +			int nspeed =3D 10 - xferspeed + XFER_MW_DMA_0;
> +			unsigned ide_cycle =3D max(ide_timing[nspeed].cycle,
> +					     drive->id->eide_dma_min);

The above line causes following warning (at least when compiling on x86=
):

drivers/ide/arm/palm_bk3710.c: In function =E2=80=98palm_bk3710_set_dma=
_mode=E2=80=99:
drivers/ide/arm/palm_bk3710.c:274: warning: comparison of distinct poin=
ter types lacks a cast

> +			palm_bk3710_setdmamode(is_slave, ide_cycle, nspeed);
> +		}
> +		break;
> +	}
> +}
> +
> +static void palm_bk3710_set_pio_mode(ide_drive_t *drive, u8 pio)
> +{
> +	unsigned int cycle_time;
> +	int is_slave =3D drive->dn & 1;
> +	ide_drive_t *mate;
> +
> +	/*
> +	 * Get the best PIO Mode supported by the drive

but it doesn't

[ upper layers take care of it ]

> +	 * Obtain the drive PIO data for tuning the Palm Chip registers
> +	 */
> +	cycle_time =3D ide_pio_cycle_time(drive, pio);
> +	mate =3D ide_get_paired_drive(drive);
> +	palm_bk3710_setpiomode(mate, is_slave, cycle_time, pio);
> +}
> +
> +static void palm_bk3710_chipinit(void)

should be __devinit (or __init)

[...]

> +	palm_bk3710_setpiomode(NULL, 0, 0, 0);
> +	palm_bk3710_setpiomode(NULL, 1, 0, 0);

0 is passed as cycle_time so ide_t2i (PIO recovery timing) in
palm_bk3710_setpiomode() becomes negative, this may work well with
a bit of luck but needs fixing

> +}
> +
> +int palm_bk3710_probe(struct platform_device *pdev)

should be static and __devinit (or __init)

[...]

> +	pribase =3D mem->start + IDE_PALM_ATA_PRI_REG_OFFSET;
> +	for (index =3D 0; index < IDE_NR_PORTS - 2; index++)
> +		ide_ctlr_info.io_ports[index] =3D pribase + index;
> +	ide_ctlr_info.io_ports[IDE_CONTROL_OFFSET] =3D mem->start +
> +			IDE_PALM_ATA_PRI_CTL_OFFSET;
> +	ide_ctlr_info.irq =3D irq->start;
> +	ide_ctlr_info.chipset =3D ide_palm3710;
> +	if (ide_register_hw(&ide_ctlr_info, NULL, 0, &palm_bk3710_hwif) < 0=
) {
> +		printk(KERN_WARNING "Palm Chip BK3710 IDE Register Fail\n");
> +		return -ENODEV;
> +	}
> +
> +	palm_bk3710_hwif->set_pio_mode =3D &palm_bk3710_set_pio_mode;
> +	palm_bk3710_hwif->set_dma_mode =3D &palm_bk3710_set_dma_mode;
> +
> +	palm_bk3710_hwif->ultra_mask =3D 0x1f;	/* Ultra DMA Mode 4 Max
> +						(input clk 99MHz) */
> +	palm_bk3710_hwif->mwdma_mask =3D 0x7;
> +	palm_bk3710_hwif->drives[0].autotune =3D 1;
> +	palm_bk3710_hwif->drives[1].autotune =3D 1;
> +
> +	if (!request_region(mem->start, 8, palm_bk3710_hwif->name)) {
> +		printk(KERN_ERR "Error, ports in use.\n");
> +		return -EBUSY;
> +	}

resource allocation should be done _before_ ide_register_hw() call

[ while at it please use the driver name instead of palm_bk3710_hwif->n=
ame ]

> +	palm_bk3710_hwif->dmatable_cpu =3D dma_alloc_coherent(
> +				NULL,
> +				PRD_ENTRIES * PRD_BYTES,
> +				&palm_bk3710_hwif->dmatable_dma,
> +				GFP_ATOMIC);
> +
> +	if (!palm_bk3710_hwif->dmatable_cpu) {
> +		printk(KERN_ERR "Error, unable to allocate DMA table.\n");
> +		return -ENOMEM;

no need to fail the driver completely - we may still operate in PIO mod=
e just
fine given that ->{ultra,mwdma}_mask are cleared and we return 0 here

> +int palm_bk3710_init(void)

static + __devinit/__init

[...]

Please recast and resubmit.

Thanks,
Bart
