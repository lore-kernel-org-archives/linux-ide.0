From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Thu, 11 Sep 2008 03:02:05 +0400
Message-ID: <48C851ED.4090607@ru.mvista.com>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:24985 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754369AbYIJXCM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Sep 2008 19:02:12 -0400
In-Reply-To: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org

Hello.

Atsushi Nemoto wrote:

> This is the driver for the Toshiba TX4939 SoC ATA controller.
>
> This controller has standard ATA taskfile registers and DMA
> command/status registers, but the register layout is swapped on big
> endian.  There are some other endian issue and some special registers
> which requires many custom dma_ops/port_ops routines.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>  

[...]

> diff --git a/drivers/ide/mips/Makefile b/drivers/ide/mips/Makefile
> index 677c7b2..1e0ad98 100644
> --- a/drivers/ide/mips/Makefile
> +++ b/drivers/ide/mips/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+= swarm.o
>  obj-$(CONFIG_BLK_DEV_IDE_AU1XXX)	+= au1xxx-ide.o
> +obj-$(CONFIG_BLK_DEV_IDE_TX4939)	+= tx4939ide.o
>  
>  EXTRA_CFLAGS    := -Idrivers/ide
> diff --git a/drivers/ide/mips/tx4939ide.c b/drivers/ide/mips/tx4939ide.c
> new file mode 100644
> index 0000000..ba9776d
> --- /dev/null
> +++ b/drivers/ide/mips/tx4939ide.c
> @@ -0,0 +1,762 @@
> +#ifdef __BIG_ENDIAN
> +#define TX4939IDE_REG32(reg)	(TX4939IDE_##reg ^ 4)
> +#define TX4939IDE_REG16(reg)	(TX4939IDE_##reg ^ 6)
> +#define TX4939IDE_REG8(reg)	(TX4939IDE_##reg ^ 7)
> +#else
> +#define TX4939IDE_REG32(reg)	(TX4939IDE_##reg)
> +#define TX4939IDE_REG16(reg)	(TX4939IDE_##reg)
> +#define TX4939IDE_REG8(reg)	(TX4939IDE_##reg)
> +#endif
> +
> +#define TX4939IDE_readl(base, reg) \
> +	__raw_readl((void __iomem *)((base) + TX4939IDE_REG32(reg)))
> +#define TX4939IDE_readw(base, reg) \
> +	__raw_readw((void __iomem *)((base) + TX4939IDE_REG16(reg)))
> +#define TX4939IDE_readb(base, reg) \
> +	__raw_readb((void __iomem *)((base) + TX4939IDE_REG8(reg)))
> +#define TX4939IDE_writel(val, base, reg) \
> +	__raw_writel(val, (void __iomem *)((base) + TX4939IDE_REG32(reg)))
> +#define TX4939IDE_writew(val, base, reg) \
> +	__raw_writew(val, (void __iomem *)((base) + TX4939IDE_REG16(reg)))
> +#define TX4939IDE_writeb(val, base, reg) \
> +	__raw_writeb(val, (void __iomem *)((base) + TX4939IDE_REG8(reg)))
>   

   Why dont you #define __swizzle_addr_[bwlq]() in 
include/asm/mach/magle-port.h?
Or you never use read[bwlq]() accessorts for the SoC registers?

> +static void tx4939ide_check_error_ints(ide_hwif_t *hwif, u16 stat)
> +{
> +	if (stat & TX4939IDE_INT_BUSERR) {
> +		unsigned long base = TX4939IDE_BASE(hwif);
> +		/* reset FIFO */
> +		TX4939IDE_writew(TX4939IDE_readw(base, Sys_Ctl) |
> +				 0x4000,
> +				 base, Sys_Ctl);
>   

   Are you sure bit 14 is self-clearing? The datashhet doesn't seem to 
say that...

> +static void tx4939ide_clear_irq(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif;
> +	unsigned long base;
> +	u16 ctl;
> +
> +	/*
> +	 * tx4939ide_dma_test_irq() and tx4939ide_dma_end() do all
> +	 * jobs for DMA case.
> +	 */
> +	if (drive->waiting_for_dma)
> +		return;
> +	hwif = HWIF(drive);
> +	base = TX4939IDE_BASE(hwif);
>   

   I think you might cache the base address in hwif->extra_base to avoid 
masking with ~0xfff every time...

> +static u8 tx4939ide_cable_detect(ide_hwif_t *hwif)
> +{
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +
> +	return (TX4939IDE_readw(base, Sys_Ctl) & 0x2000)
> +		? ATA_CBL_PATA40 : ATA_CBL_PATA80;
>   

   Could you keep ? on the same line as the 1st operand?

> +static int __tx4939ide_dma_setup(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct request *rq = HWGROUP(drive)->rq;
> +	unsigned int reading;
> +	u8 dma_stat;
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +
> +	if (rq_data_dir(rq))
> +		reading = 0;
> +	else
> +		reading = 1 << 3;
> +
> +	/* fall back to pio! */
> +	if (!ide_build_dmatable(drive, rq)) {
> +		ide_map_sg(drive, rq);
> +		return 1;
> +	}
> +#ifdef __BIG_ENDIAN
> +	{
> +		unsigned int *table = hwif->dmatable_cpu;
> +		while (1) {
> +			cpu_to_le64s((u64 *)table);
> +			if (*table & 0x80000000)
> +				break;
> +			table += 2;
> +		}
> +	}
> +#endif
>   

   Ugh...

> +static int tx4939ide_dma_setup(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = HWIF(drive);
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +	int is_slave = drive->dn & 1;
> +	unsigned int nframes;
> +	int rc, i;
> +	unsigned int sect_size = queue_hardsect_size(drive->queue);
> +	u16 select_data;
> +
> +	select_data = (hwif->select_data >> (is_slave ? 16 : 0)) & 0xffff;
> +	TX4939IDE_writew(select_data, base, Sys_Ctl);
> +	if (is_slave)
> +		TX4939IDE_writew(sect_size / 2, base, Xfer_Cnt_2);
> +	else
> +		TX4939IDE_writew(sect_size / 2, base, Xfer_Cnt_1);
>   

	TX4939IDE_writew(sect_size / 2, base, is_slave ? Xfer_Cnt_2 : Xfer_Cnt_1);

> +	rc = __tx4939ide_dma_setup(drive);
> +	if (rc == 0) {
> +		/* Number of sectors to transfer. */
> +		nframes = 0;
> +		for (i = 0; i < hwif->sg_nents; i++)
> +			nframes += sg_dma_len(&hwif->sg_table[i]);
> +		BUG_ON(nframes % sect_size != 0);
> +		nframes /= sect_size;
> +		BUG_ON(nframes == 0);
> +		TX4939IDE_writew(nframes, base, Sec_Cnt);
>   

   Ugh, it looks much easier in my TC86C001 driver... doesn't 
hwgroup->rq->nr_sectors give you a number of 512 sectors?
Why bother with other (multiple of 512) sizes when you can always 
program transfer in 512-byte sectors? Or was I wrong there?

> +static int tx4939ide_dma_end(ide_drive_t *drive)
> +{
> +	if ((dma_stat & 7) == 0 &&
> +	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
> +	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
> +		/* INT_IDE lost... bug? */
> +		return 0;
>   

   You shouldn't fake the BMDMA interrupt. If it's not there, it's not 
there. Or does this actually happen?

> +	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;
> +}
> +
> +/* returns 1 if dma irq issued, 0 otherwise */
> +static int tx4939ide_dma_test_irq(ide_drive_t *drive)
> +{
> +	ide_hwif_t *hwif = HWIF(drive);
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +	u16 ctl = TX4939IDE_readw(base, int_ctl);
> +	u8 dma_stat, stat;
> +	u16 ide_int;
> +	int found = 0;
> +
> +	tx4939ide_check_error_ints(hwif, ctl);
> +	ide_int = ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST);
> +	switch (ide_int) {
> +	case TX4939IDE_INT_HOST:
> +		/* On error, XFEREND might not be asserted. */
> +		stat = TX4939IDE_readb(base, Alt_DevCtl);
> +		if ((stat & (ATA_BUSY|ATA_DRQ|ATA_ERR)) == ATA_ERR) {
> +			pr_err("%s: detect error %x in %s\n",
> +			       drive->name, stat, __func__);
> +			found = 1;
> +		}

   Again, you shouldn't fake the BMDMA interrupt... this is not needed.

> +		/* FALLTHRU */
> +	case TX4939IDE_INT_XFEREND:
> +		/*
> +		 * If only one of XFERINT and HOST was asserted, mask
> +		 * this interrupt and wait for an another one.  Note
>   

   This comment somewhat contradicts the code which returns 1 if only 
HOST interupt is asserted if ERR is set.

> +		 * that write to bit2 of DMA_stat will clear all
> +		 * mask bits.
> +		 */
> +		ctl |= ide_int << 8;
> +		break;
> +	case TX4939IDE_INT_HOST | TX4939IDE_INT_XFEREND:
> +		dma_stat = TX4939IDE_readb(base, DMA_stat);
> +		if (!(dma_stat & 4))
> +			pr_debug("%s: weired interrupt status. "
>   

   Weird.

> +				 "DMA_stat %#02x int_ctl %#04x\n",
> +				 hwif->name, dma_stat, ctl);
> +		found = 1;
>   

   No fakes -- unless that really happens. :-)

> +static void tx4939ide_hwif_init(ide_hwif_t *hwif)
> +{
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +	int timeout;
> +
> +	/* Soft Reset */
> +	TX4939IDE_writew(0x8000, base, Sys_Ctl);
> +	mmiowb();
> +	udelay(1);	/* at least 20 UPSCLK (100ns for 200MHz GBUSCLK) */
> +	/* ATA Hard Reset */
> +	TX4939IDE_writew(0x0800, base, Sys_Ctl);
> +	timeout = 1000;
> +	while (TX4939IDE_readw(base, Sys_Ctl) & 0x0800) {
> +		if (timeout--)
> +			break;
> +		udelay(1);
> +	}
>   

   Don't do this -- there's nothing gained from the ATA hard reset but 
an extra delay; I removed such stuff from the TC86C001 driver. The IDE 
core will soft-reset the bus if needed...

> #ifdef __BIG_ENDIAN
> +/* custom iops (independent from SWAP_IO_SPACE) */
>   
> +static u8 mm_inb(unsigned long port)
> +{
> +	return (u8)readb((void __iomem *)port);
> +}
> +static void mm_outb(u8 value, unsigned long port)
> +{
> +	writeb(value, (void __iomem *)port);
> +}
> +static void mm_tf_load(ide_drive_t *drive, ide_task_t *task)
> +{
>   
[...]
> +	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE) {
> +		unsigned long base = TX4939IDE_BASE(hwif);
> +		mm_outb((tf->device & HIHI) | drive->select,
> +			 io_ports->device_addr);
>   

   I'm seeing no sense in re-defining so far...

> +		/* Fix ATA100 CORE System Control Register */
> +		TX4939IDE_writew(TX4939IDE_readw(base, Sys_Ctl) & 0x07f0,
> +				 base, Sys_Ctl);
>   

   Ah... you're doing it here (but not in LE mode?). I think to avoid 
duplicating ide_tf_load() you need ot use selectproc().

> +	}
> +}
> +static void mm_tf_read(ide_drive_t *drive, ide_task_t *task)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct ide_io_ports *io_ports = &hwif->io_ports;
> +	struct ide_taskfile *tf = &task->tf;
> +
> +	if (task->tf_flags & IDE_TFLAG_IN_DATA) {
>   

   I wish there was no such flag...

> +		u16 data;
> +
> +		data = __raw_readw((void __iomem *)io_ports->data_addr);
>   

    Ugh...

> +static void mm_insw_swap(unsigned long port, void *addr, u32 count)
> +{
> +	unsigned short *ptr = addr;
> +	unsigned long size = count * 2;
> +	port &= ~1;
> +	while (count--)
> +		*ptr++ = le16_to_cpu(__raw_readw((void __iomem *)port));
> +	__ide_flush_dcache_range((unsigned long)addr, size);
>   

   Why is this needed BTW?

> +static const struct ide_tp_ops tx4939ide_tp_ops = {
> +	.exec_command		= ide_exec_command,
> +	.read_status		= ide_read_status,
> +	.read_altstatus		= ide_read_altstatus,
> +	.read_sff_dma_status	= tx4939ide_read_sff_dma_status,
>   

   Hum, it should be re-defined in both LE and BE mode (but actually not 
called anyway).

> +
> +	.set_irq		= ide_set_irq,
> +
> +	.tf_load		= mm_tf_load,
> +	.tf_read		= mm_tf_read,
> +
> +	.input_data		= mmio_input_data_swap,
> +	.output_data		= mmio_output_data_swap,
> +};
> +#endif	/* __BIG_ENDIAN */
> +
> +static const struct ide_port_info tx4939ide_port_info __initdata = {
> +	.init_hwif = tx4939ide_hwif_init,
> +	.init_dma = tx4939ide_init_dma,
> +	.port_ops = &tx4939ide_port_ops,
> +	.dma_ops = &tx4939ide_dma_ops,
> +#ifdef __BIG_ENDIAN
> +	.tp_ops = &tx4939ide_tp_ops,
> +#endif
> +	.host_flags = IDE_HFLAG_MMIO,
> +	.pio_mask = ATA_PIO4,
> +	.mwdma_mask = ATA_MWDMA2,
> +	.swdma_mask = ATA_SWDMA2,
>   

   No, SWDMA isn't supported.

> +	.udma_mask = ATA_UDMA5,
> +};
> +
> +static int __init tx4939ide_probe(struct platform_device *pdev)
> +{
> +	hw_regs_t hw;
> +	hw_regs_t *hws[] = { &hw, NULL, NULL, NULL };
> +	struct ide_host *host;
> +	struct resource *res;
> +	int irq;
> +	unsigned long mapbase;
> +	int ret;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -ENODEV;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	mapbase = (unsigned long)devm_ioremap(&pdev->dev, res->start,
> +					      res->end - res->start + 1);
> +	if (!mapbase)
> +		return -EBUSY;
> +	memset(&hw, 0, sizeof(hw));
> +	hw.io_ports.data_addr = mapbase + TX4939IDE_REG8(DATA);
>   

   Wrong, should be TX4939IDE_REG16(). I wonder how it manages to work 
in BE mode with this...

> +#ifdef CONFIG_PM
> +static int tx4939ide_resume(struct platform_device *dev)
> +{
> +	struct ide_host *host = platform_get_drvdata(dev);
> +	ide_hwif_t *hwif = host->ports[0];
> +	unsigned long base = TX4939IDE_BASE(hwif);
> +
> +	tx4939ide_hwif_init(hwif);
>   

   ATA hard reset when coming out of suspend? Nice... :-)

MBR, Sergei


