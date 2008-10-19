From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v4)
Date: Sun, 19 Oct 2008 16:42:15 +0400
Message-ID: <48FB2B27.3090906@ru.mvista.com>
References: <20081017.230825.95059872.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20081017.230825.95059872.anemo@mba.ocn.ne.jp>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org
List-Id: linux-ide@vger.kernel.org

Hello.

Atsushi Nemoto wrote:

> This is the driver for the Toshiba TX4939 SoC ATA controller.
>
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/tp_ops routines and build_dmatable=
=2E
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>  =20

   Again, mostly ACK but there are some things that I haven't noticed=20
before...

> diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
> index 6c6dd2f..c23ff28 100644
> --- a/drivers/ide/Kconfig
> +++ b/drivers/ide/Kconfig
> @@ -746,6 +746,12 @@ config BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
>         default "128"
>         depends on BLK_DEV_IDE_AU1XXX
> =20
> +config BLK_DEV_IDE_TX4939
> +	tristate "TX4939 internal IDE support"
> +	depends on SOC_TX4939
> +	select BLK_DEV_IDEDMA_SFF
> +	select IDE_TIMINGS
>  =20

   BTW, are you really using anything from ide-timings.c?

> diff --git a/drivers/ide/mips/tx4939ide.c b/drivers/ide/mips/tx4939id=
e.c
> new file mode 100644
> index 0000000..f8be25a
> --- /dev/null
> +++ b/drivers/ide/mips/tx4939ide.c
> @@ -0,0 +1,755 @@
>  =20
[...]
> +/* ATA Shadow Registers (8-bit except for DATA which is 16-bit) */
> +#define TX4939IDE_DATA			0x000
>  =20

   Speaking about cnsistency, "data" is not an acronym. :-)

> +static void tx4939ide_set_dma_mode(ide_drive_t *drive, const u8 mode=
)
> +{
> +	ide_hwif_t *hwif =3D drive->hwif;
> +	u32 mask, val;
> +
> +	/* Update Data Transfer Mode for this drive. */
> +	if (mode >=3D XFER_UDMA_0)
> +		val =3D mode - XFER_UDMA_0 + 8;
> +	else {
> +		BUG_ON(mode < XFER_MW_DMA_0);
>  =20

   Should be no need for that as it's filtered out at the higher level.=
=2E.

> +static int tx4939ide_dma_setup(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif =3D drive->hwif;
> +	void __iomem *base =3D TX4939IDE_BASE(hwif);
> +	struct request *rq =3D hwif->hwgroup->rq;
> +	unsigned int reading;
>  =20

   BTW, shoudn't it be of type 'u8'?

> +	int nent;
> +
> +	if (rq_data_dir(rq))
> +		reading =3D 0;
> +	else
> +		reading =3D 1 << 3;
>  =20

   I think it's time to start using ATA_DMA_WR instead of the bare=20
number; maybe I'll submit a patch to do this for ide-dma-sff.c...

> +static int tx4939ide_dma_end(ide_drive_t *drive)
> +{
>  =20
[...]
> +	tx4939ide_writeb(dma_cmd & ~1, base, TX4939IDE_DMA_Cmd);
>  =20

   Suggesting s/1/ATA_DMA_START/...
   OTOH, might be addressed by a followup patch converting every=20
SFF-8038i compatible driver, if I (or Bart) ever get to it...

> +/* returns 1 if dma irq issued, 0 otherwise */
>  =20

   OTOH, DMA and IRQ are acronyms... :-)

> +static int tx4939ide_dma_test_irq(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif =3D drive->hwif;
> +	void __iomem *base =3D TX4939IDE_BASE(hwif);
> +	u16 ctl;
> +	u8 dma_stat, stat;
> +	u16 ide_int;
> +	int found =3D 0;
> +
> +	ctl =3D tx4939ide_check_error_ints(hwif);
> +	ide_int =3D ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST);
> +	switch (ide_int) {
> +	case TX4939IDE_INT_HOST:
> +		/* On error, XFEREND might not be asserted. */
> +		stat =3D tx4939ide_readb(base, TX4939IDE_AltStat_DevCtl);
> +		if ((stat & (ATA_BUSY|ATA_DRQ|ATA_ERR)) =3D=3D ATA_ERR)
>  =20

   Er, need spaces around | for consistency...

> +			found =3D 1;
> +		else
> +			/* Wait for XFEREND (Mask HOST and unmask XFEREND) */
> +			ctl &=3D ~TX4939IDE_INT_XFEREND << 8;
> +		ctl |=3D ide_int << 8;
> +		break;
> +	case TX4939IDE_INT_HOST | TX4939IDE_INT_XFEREND:
> +		dma_stat =3D tx4939ide_readb(base, TX4939IDE_DMA_Stat);
> +		if (!(dma_stat & 4))
>  =20

   s/4/ATA_DMA_INTR/?

> +static void tx4939ide_init_hwif(ide_hwif_t *hwif)
> +{
> +	void __iomem *base =3D TX4939IDE_BASE(hwif);
> +
> +	/* Soft Reset */
> +	tx4939ide_writew(0x8000, base, TX4939IDE_Sys_Ctl);
> +	mmiowb();
> +	/* at least 20 UPSCLK (typ. 100ns @ GBUS200MHz, max 450ns) */
>  =20

   Not 20 GBUSCLK?

> +static int tx4939ide_init_dma(ide_hwif_t *hwif, const struct ide_por=
t_info *d)
> +{
> +	hwif->dma_base =3D (unsigned long)TX4939IDE_BASE(hwif) +
>  =20

   Hum, casting 'hwif->extra_base' to 'void __iomem *' and then back to=
=20
'unsigned long' is too much, don't you think?
=20
> +#ifdef __BIG_ENDIAN
> +
> +static u8 tx4939ide_read_sff_dma_status(ide_hwif_t *hwif)
> +{
> +	void __iomem *base =3D TX4939IDE_BASE(hwif);
>  =20

   No new line after declaration...

> +	return tx4939ide_readb(base, TX4939IDE_DMA_Stat);
> +}
> +
> +/* custom iops (independent from SWAP_IO_SPACE) */
> +static u8 tx4939ide_inb(unsigned long port)
> +{
> +	return (u8)__raw_readb((void __iomem *)port);
>  =20

   Doesn't __raw_readb() return 'u8'?

> +static void tx4939ide_tf_load(ide_drive_t *drive, ide_task_t *task)
> +{
>  =20
[...]
> +	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE)
> +		tx4939ide_outb((tf->device & HIHI) | drive->select,
> +			       io_ports->device_addr);
> +
> +	tx4939ide_tf_load_fixup(drive, task);
>  =20

   Might be worth calling tx4939ide_tf_load_fixup() under the preceding=
=20
*if* and removing the corresponding *if* from that function...

> +static void tx4939ide_tf_load(ide_drive_t *drive, ide_task_t *task)
> +{
> +	ide_tf_load(drive, task);
> +	tx4939ide_tf_load_fixup(drive, task);
>  =20

   ... and adding *if* here.

> +static int __init tx4939ide_probe(struct platform_device *pdev)
> +{
> +	hw_regs_t hw;
> +	hw_regs_t *hws[] =3D { &hw, NULL, NULL, NULL };
> +	struct ide_host *host;
> +	struct resource *res;
> +	int irq;
> +	unsigned long mapbase;
> +	int ret;
>  =20

   Variables '=EDrq' and 'ret' could be on the same line...

> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -ENODEV;
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	mapbase =3D (unsigned long)devm_ioremap(&pdev->dev, res->start,
> +					      res->end - res->start + 1);
>  =20

   Looks like you've forgotten to call request_mem_region()...

MBR, Sergei
