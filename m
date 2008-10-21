From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: Add tx4939ide driver (v5)
Date: Tue, 21 Oct 2008 20:08:41 +0400
Message-ID: <48FDFE89.5030501@ru.mvista.com>
References: <20081020.212701.59651580.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20081020.212701.59651580.anemo@mba.ocn.ne.jp>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org
List-Id: linux-ide@vger.kernel.org

Atsushi Nemoto wrote:

> This is the driver for the Toshiba TX4939 SoC ATA controller.

> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/tp_ops routines and build_dmatable.

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

    I'm inclined to ACK the driver (besides, TX49xx patches are holding up my 
own series of patches since it needs to modify both these drivers) but I'm not 
sure about the error cleanup path now that I looked at it again -- probably' 
devres' handles all that automagically but peering into the sources didn't 
enlignten me on how it does it, so I would like to be explicitly assured. :-)
    There are also some nits, mostly ignorable...

> diff --git a/drivers/ide/mips/tx4939ide.c b/drivers/ide/mips/tx4939ide.c
> new file mode 100644
> index 0000000..9a42f83
> --- /dev/null
> +++ b/drivers/ide/mips/tx4939ide.c
> @@ -0,0 +1,756 @@
[...]
> +static void tx4939ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	int is_slave = drive->dn & 1;

    Here and elsewhere ANDing drive->dn with 1 seems superfluous since TX4939 
IDE controllers are single channel and therefore drive->dn should be 0 or 1...

> +static u16 tx4939ide_check_error_ints(ide_hwif_t *hwif)
> +{
> +	void __iomem *base = TX4939IDE_BASE(hwif);
> +	u16 ctl = tx4939ide_readw(base, TX4939IDE_Int_Ctl);
> +
> +	if (ctl & TX4939IDE_INT_BUSERR) {
> +		/* reset FIFO */
> +		u16 sysctl = tx4939ide_readw(base, TX4939IDE_Sys_Ctl);

    Missed a missing newline here too. :-)

> +		pr_err("%s: Error interrupt %#x (%s%s%s )\n",
> +		       hwif->name, ctl,
> +		       (ctl & TX4939IDE_INT_ADDRERR) ?
> +		       " Address-Error" : "",
> +		       (ctl & TX4939IDE_INT_DEVTIMING) ?
> +		       " DEV-Timing" : "",
> +		       (ctl & TX4939IDE_INT_BUSERR) ?

    Parens around & shouldn't be needed...

> +static u8 tx4939ide_cable_detect(ide_hwif_t *hwif)
> +{
> +	void __iomem *base = TX4939IDE_BASE(hwif);
> +
> +	return (tx4939ide_readw(base, TX4939IDE_Sys_Ctl) & 0x2000) ?

    Here as well...

> +static u8 tx4939ide_clear_dma_status(void __iomem *base)
> +{
> +	u8 dma_stat;
> +
> +	/* read DMA status for INTR & ERROR flags */
> +	dma_stat = tx4939ide_readb(base, TX4939IDE_DMA_Stat);
> +	/* clear INTR & ERROR flags */
> +	tx4939ide_writeb(dma_stat | 6, base, TX4939IDE_DMA_Stat);

    Should replace 6 with ATA_DMA_INTR | ATA_DMA_ERR to be consistent with 
other changes...

> +#ifdef __BIG_ENDIAN
> +/* custom ide_build_dmatable to handle swapped layout */
> +static int tx4939ide_build_dmatable(ide_drive_t *drive, struct request *rq)
> +{
[...]
> +		/*
> +		 * Fill in the dma table, without crossing any 64kB boundaries.

    s/dma/DMA/

> +static int tx4939ide_dma_setup(ide_drive_t *drive)
> +{
[...]
> +	/* fall back to pio! */

    s/pio/PIO/

> +	tx4939ide_writew(SECTOR_SIZE / 2, base, (drive->dn & 1) ?

    Parens around & unneeded?

> +/* returns 1 if DMA IRQ issued, 0 otherwise */
> +static int tx4939ide_dma_test_irq(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	void __iomem *base = TX4939IDE_BASE(hwif);
> +	u16 ctl;
> +	u8 dma_stat, stat;
> +	u16 ide_int;

    Could be on the same line with 'ctl'...

> +static void tx4939ide_init_hwif(ide_hwif_t *hwif)
> +{

[...]

> +	tx4939ide_writew(0x0008, base, TX4939IDE_Lo_Burst_Cnt);
> +	tx4939ide_writew(0, base, TX4939IDE_Up_Burst_Cnt);

    I think that these fit better to tx4939ide_init_dma().

> +}
> +
> +static int tx4939ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
> +{
> +	hwif->dma_base = hwif->extra_base +
> +		tx4939ide_swizzleb(TX4939IDE_DMA_Cmd);

    Doesn't it fit on the same line now?

> +	/*
> +	 * Note that we cannot use ATA_DMA_TABLE_OFS,ATA_DMA_STATUS

    No space after comma...

> +static int __init tx4939ide_probe(struct platform_device *pdev)
> +{
[...]
> +	if (!devm_request_mem_region(&pdev->dev, res->start,
> +				     res->end - res->start + 1, "tx4938ide"))
> +		return -EBUSY;
> +	mapbase = (unsigned long)devm_ioremap(&pdev->dev, res->start,
> +					      res->end - res->start + 1);
> +	if (!mapbase)
> +		return -EBUSY;

    Do you mean that on devm_ioremap() failure the memory region will be 
auto-released?

> +	host = ide_host_alloc(&tx4939ide_port_info, hws);
> +	if (!host)
> +		return -ENOMEM;
> +	/* use extra_base for base address of the all registers */
> +	host->ports[0]->extra_base = mapbase;
> +	ret = ide_host_register(host, &tx4939ide_port_info, hws);
> +	if (ret) {
> +		ide_host_free(host);
> +		return ret;
> +	}

    Same question about the error cleanup here -- will the acquired resources 
be auto-released? If so, then:

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
