From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Sat, 2 Feb 2008 01:29:54 +0100
Message-ID: <200802020129.54329.bzolnier@gmail.com>
References: <200801251512.09836.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:20908 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbYBBASO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Feb 2008 19:18:14 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1120709fga.17
        for <linux-ide@vger.kernel.org>; Fri, 01 Feb 2008 16:18:12 -0800 (PST)
In-Reply-To: <200801251512.09836.asalnikov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>


Hi,

On Friday 25 January 2008, Anton Salnikov wrote:
> This is Palmchip BK3710 IDE controller support for kernel version 2.6=
=2E24.
> The IDE controller logic supports PIO, multiword DMA and ultra-DMA mo=
des.
> Supports interface to compact Flash (CF) configured in True-IDE mode.

Unfortunately some changes merged after 2.6.24 broke the build:

drivers/ide/arm/palm_bk3710.c: In function =E2=80=98palm_bk3710_set_dma=
_mode=E2=80=99:
drivers/ide/arm/palm_bk3710.c:243: error: =E2=80=98struct hwif_s=E2=80=99=
 has no member named =E2=80=98dma_master=E2=80=99
drivers/ide/arm/palm_bk3710.c: In function =E2=80=98palm_bk3710_set_pio=
_mode=E2=80=99:
drivers/ide/arm/palm_bk3710.c:259: error: =E2=80=98struct hwif_s=E2=80=99=
 has no member named =E2=80=98dma_master=E2=80=99

[ ->dma_master is gone, ->dma_base should be used instead ]

drivers/ide/arm/palm_bk3710.c: In function =E2=80=98palm_bk3710_probe=E2=
=80=99:
drivers/ide/arm/palm_bk3710.c:389: error: too many arguments to functio=
n =E2=80=98ide_register_hw=E2=80=99

[ 'initializing' argument is gone, just removing it is OK ]

drivers/ide/arm/palm_bk3710.c:404: error: too many arguments to functio=
n =E2=80=98ide_setup_dma=E2=80=99

[ 'num_ports' argument is gone, just removing it is OK ]


Please re-sync the patch with the current Linus' git tree.


There are also few less critical issues left...

> Signed-off-by: Anton Salnikov <asalnikov@ru.mvista.com>
> ---
>=20
>  drivers/ide/Kconfig           |    8=20
>  drivers/ide/arm/Makefile      |    1=20
>  drivers/ide/arm/palm_bk3710.c |  424 +++++++++++++++++++++++++++++++=
+++++++++++
>  drivers/ide/ide-proc.c        |    1=20
>  include/linux/ide.h           |    2=20
>  5 files changed, 435 insertions(+), 1 deletion(-)
>=20
> Index: 2.6.24.ide/drivers/ide/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- 2.6.24.ide.orig/drivers/ide/Kconfig
> +++ 2.6.24.ide/drivers/ide/Kconfig
> @@ -1008,6 +1008,14 @@ config BLK_DEV_Q40IDE
>  	  normally be on; disable it only if you are running a custom hard
>  	  drive subsystem through an expansion card.
> =20
> +config BLK_DEV_PALMCHIP_BK3710
> +	bool "Palmchip bk3710 IDE controller support"

'tristate'

> +	depends on ARCH_DAVINCI
> +	select BLK_DEV_IDEDMA_PCI
> +	help
> +	  Say Y here if you want to support the onchip IDE controller on th=
e
> +	  TI DaVinci SoC
> +
>  config BLK_DEV_MPC8xx_IDE
>  	bool "MPC8xx IDE support"
>  	depends on 8xx && (LWMON || IVMS8 || IVML24 || TQM8xxL) && IDE=3Dy =
&&=20
> BLK_DEV_IDE=3Dy && !PPC_MERGE
> Index: 2.6.24.ide/drivers/ide/arm/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- 2.6.24.ide.orig/drivers/ide/arm/Makefile
> +++ 2.6.24.ide/drivers/ide/arm/Makefile

[...]

> +static inline u8 hwif_read8(u32 base, u32 reg)
> +{
> +	return readb(base + reg);
> +}
> +
> +static inline void hwif_write8(u32 base, u8 val, u32 reg)
> +{
> +	writeb(val, base + reg);
> +}
> +
> +static inline u16 hwif_read16(u32 base, u32 reg)
> +{
> +	return readw(base + reg);
> +}
> +
> +static inline void hwif_write16(u32 base, u16 val, u32 reg)
> +{
> +	writew(val, base + reg);
> +}
> +
> +static inline u32 hwif_read32(u32 base, u32 reg)
> +{
> +	return readl(base + reg);
> +}
> +
> +static inline void hwif_write32(u32 base, u32 val, u32 reg)
> +{
> +	writel(val, base + reg);
> +}

drivers/ide/arm/palm_bk3710.c: In function =E2=80=98hwif_read8=E2=80=99=
:
drivers/ide/arm/palm_bk3710.c:93: warning: passing argument 1 of =E2=80=
=98readb=E2=80=99 makes pointer from integer without a cast
drivers/ide/arm/palm_bk3710.c: In function =E2=80=98hwif_write8=E2=80=99=
:
drivers/ide/arm/palm_bk3710.c:98: warning: passing argument 2 of =E2=80=
=98writeb=E2=80=99 makes pointer from integer without a cast
drivers/ide/arm/palm_bk3710.c: In function =E2=80=98hwif_read16=E2=80=99=
:
drivers/ide/arm/palm_bk3710.c:103: warning: passing argument 1 of =E2=80=
=98readw=E2=80=99 makes pointer from integer without a cast
drivers/ide/arm/palm_bk3710.c: In function =E2=80=98hwif_write16=E2=80=99=
:
drivers/ide/arm/palm_bk3710.c:108: warning: passing argument 2 of =E2=80=
=98writew=E2=80=99 makes pointer from integer without a cast
drivers/ide/arm/palm_bk3710.c: In function =E2=80=98hwif_read32=E2=80=99=
:
drivers/ide/arm/palm_bk3710.c:113: warning: passing argument 1 of =E2=80=
=98readl=E2=80=99 makes pointer from integer without a cast
drivers/ide/arm/palm_bk3710.c: In function =E2=80=98hwif_write32=E2=80=99=
:
drivers/ide/arm/palm_bk3710.c:118: warning: passing argument 2 of =E2=80=
=98writel=E2=80=99 makes pointer from integer without a cast

'base' should be of 'void __iomem *' type for read*/write* ops

Besides: because the driver supports multiple controllers now these wra=
ppers
doesn't provide any value and just obfuscate the code (as noticed by Al=
an).

Please remove them.

> +static void palm_bk3710_setudmamode(u32 base, unsigned int dev,

'base' should be of 'void __iomem *' type for read*/*write ops

[ casting from u32 can be done in the caller ]

> +				    unsigned int mode)
> +{
> +	u8 tenv, trp, t0;
> +	u32 val32;
> +	u16 val16;
> +
> +	/* DMA Data Setup */
> +	t0 =3D (palm_bk3710_udmatimings[mode].cycletime + ide_palm_clk - 1)
> +			/ ide_palm_clk - 1;
> +	tenv =3D (20 + ide_palm_clk - 1) / ide_palm_clk - 1;
> +	trp =3D (palm_bk3710_udmatimings[mode].rptime + ide_palm_clk - 1)
> +			/ ide_palm_clk - 1;
> +
> +	/* udmatim Register */
> +	val16 =3D hwif_read16(base, BK3710_UDMATIM) & (dev ? 0xFF0F : 0xFFF=
0);
> +	val16 |=3D (mode << (dev ? 4 : 0));
> +	hwif_write16(base, val16, BK3710_UDMATIM);
> +
> +	/* udmastb Ultra DMA Access Strobe Width */
> +	val32 =3D hwif_read32(base, BK3710_UDMASTB) & (0xFF << (dev ? 0 : 8=
));
> +	val32 |=3D (t0 << (dev ? 8 : 0));
> +	hwif_write32(base, val32, BK3710_UDMASTB);
> +
> +	/* udmatrp Ultra DMA Ready to Pause Time */
> +	val32 =3D hwif_read32(base, BK3710_UDMATRP) & (0xFF << (dev ? 0 : 8=
));
> +	val32 |=3D (trp << (dev ? 8 : 0));
> +	hwif_write32(base, val32, BK3710_UDMATRP);
> +
> +	/* udmaenv Ultra DMA envelop Time */
> +	val32 =3D hwif_read32(base, BK3710_UDMAENV) & (0xFF << (dev ? 0 : 8=
));
> +	val32 |=3D (tenv << (dev ? 8 : 0));
> +	hwif_write32(base, val32, BK3710_UDMAENV);
> +
> +	/* Enable UDMA for Device */
> +	val16 =3D hwif_read16(base, BK3710_UDMACTL) | (1 << dev);
> +	hwif_write16(base, val16, BK3710_UDMACTL);
> +}
> +
> +static void palm_bk3710_setdmamode(u32 base, unsigned int dev,

ditto

> +				   unsigned short min_cycle,
> +				   unsigned int mode)
> +{
> +	u8 td, tkw, t0;
> +	u32 val32;
> +	u16 val16;
> +	struct ide_timing *t;
> +	int cycletime;
> +
> +	t =3D ide_timing_find_mode(mode);
> +	cycletime =3D max_t(int, t->cycle, min_cycle);
> +
> +	/* DMA Data Setup */
> +	t0 =3D (cycletime + ide_palm_clk - 1) / ide_palm_clk;
> +	td =3D (t->active + ide_palm_clk - 1) / ide_palm_clk;
> +	tkw =3D t0 - td - 1;
> +	td -=3D 1;
> +
> +	val32 =3D hwif_read32(base, BK3710_DMASTB) & (0xFF << (dev ? 0 : 8)=
);
> +	val32 |=3D (td << (dev ? 8 : 0));
> +	hwif_write32(base, val32, BK3710_DMASTB);
> +
> +	val32 =3D hwif_read32(base, BK3710_DMARCVR) & (0xFF << (dev ? 0 : 8=
));
> +	val32 |=3D (tkw << (dev ? 8 : 0));
> +	hwif_write32(base, val32, BK3710_DMARCVR);
> +
> +	/* Disable UDMA for Device */
> +	val16 =3D hwif_read16(base, BK3710_UDMACTL) & ~(1 << dev);
> +	hwif_write16(base, val16, BK3710_UDMACTL);
> +}
> +
> +static void palm_bk3710_setpiomode(u32 base, ide_drive_t *mate,

ditto

> +				   unsigned int dev, unsigned int cycletime,
> +				   unsigned int mode)
> +{
> +	u8 t2, t2i, t0;
> +	u32 val32;
> +	struct ide_timing *t;
> +
> +	/* PIO Data Setup */
> +	t0 =3D (cycletime + ide_palm_clk - 1) / ide_palm_clk;
> +	t2 =3D (ide_timing_find_mode(XFER_PIO_0 + mode)->active +
> +	      ide_palm_clk - 1)	/ ide_palm_clk;
> +
> +	t2i =3D t0 - t2 - 1;
> +	t2 -=3D 1;
> +
> +	val32 =3D hwif_read32(base, BK3710_DATSTB) & (0xFF << (dev ? 0 : 8)=
);
> +	val32 |=3D (t2 << (dev ? 8 : 0));
> +	hwif_write32(base, val32, BK3710_DATSTB);
> +
> +	val32 =3D hwif_read32(base, BK3710_DATRCVR) & (0xFF << (dev ? 0 : 8=
));
> +	val32 |=3D (t2i << (dev ? 8 : 0));
> +	hwif_write32(base, val32, BK3710_DATRCVR);
> +
> +	if (mate && mate->present) {
> +		u8 mode2 =3D ide_get_best_pio_mode(mate, 255, 4);
> +
> +		if (mode2 < mode)
> +			mode =3D mode2;
> +	}
> +
> +	/* TASKFILE Setup */
> +	t =3D ide_timing_find_mode(XFER_PIO_0 + mode);
> +	t0 =3D (t->cyc8b + ide_palm_clk - 1) / ide_palm_clk;
> +	t2 =3D (t->act8b + ide_palm_clk - 1) / ide_palm_clk;
> +
> +	t2i =3D t0 - t2 - 1;
> +	t2 -=3D 1;
> +
> +	val32 =3D hwif_read32(base, BK3710_REGSTB) & (0xFF << (dev ? 0 : 8)=
);
> +	val32 |=3D (t2 << (dev ? 8 : 0));
> +	hwif_write32(base, val32, BK3710_REGSTB);
> +
> +	val32 =3D hwif_read32(base, BK3710_REGRCVR) & (0xFF << (dev ? 0 : 8=
));
> +	val32 |=3D (t2i << (dev ? 8 : 0));
> +	hwif_write32(base, val32, BK3710_REGRCVR);
> +}
> +
> +static void palm_bk3710_set_dma_mode(ide_drive_t *drive, u8 xferspee=
d)
> +{
> +	int is_slave =3D drive->dn & 1;
> +	u32 base =3D drive->hwif->dma_master;
> +
> +	if (xferspeed >=3D XFER_UDMA_0) {
> +		palm_bk3710_setudmamode(base, is_slave,
> +					xferspeed - XFER_UDMA_0);
> +	} else {
> +		palm_bk3710_setdmamode(base, is_slave, drive->id->eide_dma_min,
> +				       xferspeed);
> +	}
> +}
> +
> +static void palm_bk3710_set_pio_mode(ide_drive_t *drive, u8 pio)
> +{
> +	unsigned int cycle_time;
> +	int is_slave =3D drive->dn & 1;
> +	ide_drive_t *mate;
> +	u32 base =3D drive->hwif->dma_master;
> +
> +	/*
> +	 * Obtain the drive PIO data for tuning the Palm Chip registers
> +	 */
> +	cycle_time =3D ide_pio_cycle_time(drive, pio);
> +	mate =3D ide_get_paired_drive(drive);
> +	palm_bk3710_setpiomode(base, mate, is_slave, cycle_time, pio);
> +}
> +
> +static void __devinit palm_bk3710_chipinit(u32 base)

'u32' -> 'void __iomem *'

> +{
> +	/*
> +	 * enable the reset_en of ATA controller so that when ata signals
> +	 * are brought out, by writing into device config. at that
> +	 * time por_n signal should not be 'Z' and have a stable value.
> +	 */
> +	hwif_write32(base, 0x0300, BK3710_MISCCTL);
> +
> +	/* wait for some time and deassert the reset of ATA Device. */
> +	mdelay(100);
> +
> +	/* Deassert the Reset */
> +	hwif_write32(base, 0x0200, BK3710_MISCCTL);
> +
> +	/*
> +	 * Program the IDETIMP Register Value based on the following assump=
tions
> +	 *
> +	 * (ATA_IDETIMP_IDEEN		, ENABLE ) |
> +	 * (ATA_IDETIMP_SLVTIMEN	, DISABLE) |
> +	 * (ATA_IDETIMP_RDYSMPL		, 70NS)    |
> +	 * (ATA_IDETIMP_RDYRCVRY	, 50NS)    |
> +	 * (ATA_IDETIMP_DMAFTIM1	, PIOCOMP) |
> +	 * (ATA_IDETIMP_PREPOST1	, DISABLE) |
> +	 * (ATA_IDETIMP_RDYSEN1		, DISABLE) |
> +	 * (ATA_IDETIMP_PIOFTIM1	, DISABLE) |
> +	 * (ATA_IDETIMP_DMAFTIM0	, PIOCOMP) |
> +	 * (ATA_IDETIMP_PREPOST0	, DISABLE) |
> +	 * (ATA_IDETIMP_RDYSEN0		, DISABLE) |
> +	 * (ATA_IDETIMP_PIOFTIM0	, DISABLE)
> +	 */
> +	hwif_write16(base, 0xB388, BK3710_IDETIMP);
> +
> +	/*
> +	 * Configure  SIDETIM  Register
> +	 * (ATA_SIDETIM_RDYSMPS1	,120NS ) |
> +	 * (ATA_SIDETIM_RDYRCYS1	,120NS )
> +	 */
> +	hwif_write8(base, 0, BK3710_SIDETIM);
> +
> +	/*
> +	 * UDMACTL Ultra-ATA DMA Control
> +	 * (ATA_UDMACTL_UDMAP1	, 0 ) |
> +	 * (ATA_UDMACTL_UDMAP0	, 0 )
> +	 *
> +	 */
> +	hwif_write16(base, 0, BK3710_UDMACTL);
> +
> +	/*
> +	 * MISCCTL Miscellaneous Conrol Register
> +	 * (ATA_MISCCTL_RSTMODEP	, 1) |
> +	 * (ATA_MISCCTL_RESETP		, 0) |
> +	 * (ATA_MISCCTL_TIMORIDE	, 1)
> +	 */
> +	hwif_write32(base, 0x201, BK3710_MISCCTL);
> +
> +	/*
> +	 * IORDYTMP IORDY Timer for Primary Register
> +	 * (ATA_IORDYTMP_IORDYTMP     , 0xffff  )
> +	 */
> +	hwif_write32(base, 0xFFFF, BK3710_IORDYTMP);
> +
> +	/*
> +	 * Configure BMISP Register
> +	 * (ATA_BMISP_DMAEN1	, DISABLE )	|
> +	 * (ATA_BMISP_DMAEN0	, DISABLE )	|
> +	 * (ATA_BMISP_IORDYINT	, CLEAR)	|
> +	 * (ATA_BMISP_INTRSTAT	, CLEAR)	|
> +	 * (ATA_BMISP_DMAERROR	, CLEAR)
> +	 */
> +	hwif_write16(base, 0, BK3710_BMISP);
> +
> +	palm_bk3710_setpiomode(base, NULL, 0, 600, 0);
> +	palm_bk3710_setpiomode(base, NULL, 1, 600, 0);
> +}
> +static int __devinit palm_bk3710_probe(struct platform_device *pdev)
> +{
> +	hw_regs_t ide_ctlr_info;
> +	int index =3D 0;
> +	int pribase;
> +	struct clk *clkp;
> +	struct resource *mem, *irq;
> +	ide_hwif_t *hwif;
> +	u32 base;

ditto

> +	clkp =3D clk_get(NULL, "IDECLK");
> +	if (IS_ERR(clkp))
> +		return -ENODEV;
> +
> +	ideclkp =3D clkp;
> +	clk_enable(ideclkp);
> +	ide_palm_clk =3D clk_get_rate(ideclkp)/100000;
> +	ide_palm_clk =3D (10000/ide_palm_clk) + 1;
> +	/* Register the IDE interface with Linux ATA Interface */
> +	memset(&ide_ctlr_info, 0, sizeof(ide_ctlr_info));
> +
> +	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (mem =3D=3D NULL) {
> +		printk(KERN_ERR "failed to get memory region resource\n");
> +		return -ENODEV;
> +	}
> +	irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (irq =3D=3D NULL) {
> +		printk(KERN_ERR "failed to get IRQ resource\n");
> +		return -ENODEV;
> +	}
> +
> +	base =3D mem->start;
> +
> +	/* Configure the Palm Chip controller */
> +	palm_bk3710_chipinit(base);
> +
> +	pribase =3D mem->start + IDE_PALM_ATA_PRI_REG_OFFSET;
> +	for (index =3D 0; index < IDE_NR_PORTS - 2; index++)
> +		ide_ctlr_info.io_ports[index] =3D pribase + index;
> +	ide_ctlr_info.io_ports[IDE_CONTROL_OFFSET] =3D mem->start +
> +			IDE_PALM_ATA_PRI_CTL_OFFSET;
> +	ide_ctlr_info.irq =3D irq->start;
> +	ide_ctlr_info.chipset =3D ide_palm3710;
> +
> +	if (ide_register_hw(&ide_ctlr_info, NULL, 0, &hwif) < 0) {
> +		printk(KERN_WARNING "Palm Chip BK3710 IDE Register Fail\n");
> +		return -ENODEV;
> +	}
> +
> +	hwif->set_pio_mode =3D &palm_bk3710_set_pio_mode;
> +	hwif->set_dma_mode =3D &palm_bk3710_set_dma_mode;
> +	hwif->mmio =3D 1;
> +	default_hwif_mmiops(hwif);
> +	hwif->ultra_mask =3D 0x1f;	/* Ultra DMA Mode 4 Max
> +						(input clk 99MHz) */

I've just noticed that there is no cable detection for UDMA modes > UDM=
A2?

> +	hwif->mwdma_mask =3D 0x7;
> +	hwif->drives[0].autotune =3D 1;
> +	hwif->drives[1].autotune =3D 1;
> +
> +	ide_setup_dma(hwif, mem->start, 8);
> +
> +	return 0;
> +}

[...]

Otherwise the driver looks fine and will be merged once the above issue=
s
get addressed so please recast+resubmit it.

Thanks,
Bart
