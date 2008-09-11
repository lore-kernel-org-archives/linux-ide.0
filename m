From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/2] ide: Add tx4939ide driver
Date: Fri, 12 Sep 2008 00:52:43 +0900 (JST)
Message-ID: <20080912.005243.48535230.anemo@mba.ocn.ne.jp>
References: <20080910.010824.07456636.anemo@mba.ocn.ne.jp>
	<48C851ED.4090607@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:65360 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbYIKPwg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Sep 2008 11:52:36 -0400
In-Reply-To: <48C851ED.4090607@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: linux-mips@linux-mips.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, ralf@linux-mips.org

On Thu, 11 Sep 2008 03:02:05 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > +#define TX4939IDE_readl(base, reg) \
> > +	__raw_readl((void __iomem *)((base) + TX4939IDE_REG32(reg)))
> > +#define TX4939IDE_readw(base, reg) \
> > +	__raw_readw((void __iomem *)((base) + TX4939IDE_REG16(reg)))
> > +#define TX4939IDE_readb(base, reg) \
> > +	__raw_readb((void __iomem *)((base) + TX4939IDE_REG8(reg)))
> > +#define TX4939IDE_writel(val, base, reg) \
> > +	__raw_writel(val, (void __iomem *)((base) + TX4939IDE_REG32(reg)))
> > +#define TX4939IDE_writew(val, base, reg) \
> > +	__raw_writew(val, (void __iomem *)((base) + TX4939IDE_REG16(reg)))
> > +#define TX4939IDE_writeb(val, base, reg) \
> > +	__raw_writeb(val, (void __iomem *)((base) + TX4939IDE_REG8(reg)))
> >   
> 
>    Why dont you #define __swizzle_addr_[bwlq]() in 
> include/asm/mach/magle-port.h?
> Or you never use read[bwlq]() accessorts for the SoC registers?

Because __swizzle_addr_[bwlq]() affects _all_ device including PCI
devices.  I hope all PCI driver works as is, so put all dirty things
in platform specific driver ;-)

> > +static void tx4939ide_check_error_ints(ide_hwif_t *hwif, u16 stat)
> > +{
> > +	if (stat & TX4939IDE_INT_BUSERR) {
> > +		unsigned long base = TX4939IDE_BASE(hwif);
> > +		/* reset FIFO */
> > +		TX4939IDE_writew(TX4939IDE_readw(base, Sys_Ctl) |
> > +				 0x4000,
> > +				 base, Sys_Ctl);
> >   
> 
>    Are you sure bit 14 is self-clearing? The datashhet doesn't seem to 
> say that...

Well, I cannot remember...  I thought I checked that bit cleard by
reading it, but actually the bit is write-only.  Maybe clearing
explicitly would be a safe bet.

> > +	hwif = HWIF(drive);
> > +	base = TX4939IDE_BASE(hwif);
> >   
> 
>    I think you might cache the base address in hwif->extra_base to avoid 
> masking with ~0xfff every time...

OK, I will try it.

> > +static u8 tx4939ide_cable_detect(ide_hwif_t *hwif)
> > +{
> > +	unsigned long base = TX4939IDE_BASE(hwif);
> > +
> > +	return (TX4939IDE_readw(base, Sys_Ctl) & 0x2000)
> > +		? ATA_CBL_PATA40 : ATA_CBL_PATA80;
> >   
> 
>    Could you keep ? on the same line as the 1st operand?

OK.

> > +	select_data = (hwif->select_data >> (is_slave ? 16 : 0)) & 0xffff;
> > +	TX4939IDE_writew(select_data, base, Sys_Ctl);
> > +	if (is_slave)
> > +		TX4939IDE_writew(sect_size / 2, base, Xfer_Cnt_2);
> > +	else
> > +		TX4939IDE_writew(sect_size / 2, base, Xfer_Cnt_1);
> >   
> 
> 	TX4939IDE_writew(sect_size / 2, base, is_slave ? Xfer_Cnt_2 : Xfer_Cnt_1);

OK.

> > +	rc = __tx4939ide_dma_setup(drive);
> > +	if (rc == 0) {
> > +		/* Number of sectors to transfer. */
> > +		nframes = 0;
> > +		for (i = 0; i < hwif->sg_nents; i++)
> > +			nframes += sg_dma_len(&hwif->sg_table[i]);
> > +		BUG_ON(nframes % sect_size != 0);
> > +		nframes /= sect_size;
> > +		BUG_ON(nframes == 0);
> > +		TX4939IDE_writew(nframes, base, Sec_Cnt);
> >   
> 
>    Ugh, it looks much easier in my TC86C001 driver... doesn't 
> hwgroup->rq->nr_sectors give you a number of 512 sectors?
> Why bother with other (multiple of 512) sizes when you can always 
> program transfer in 512-byte sectors? Or was I wrong there?

Hmm.  Good idea.  I will try it.

> > +static int tx4939ide_dma_end(ide_drive_t *drive)
> > +{
> > +	if ((dma_stat & 7) == 0 &&
> > +	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
> > +	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
> > +		/* INT_IDE lost... bug? */
> > +		return 0;
> >   
> 
>    You shouldn't fake the BMDMA interrupt. If it's not there, it's not 
> there. Or does this actually happen?

IIRC, Yes.

> > +		/*
> > +		 * If only one of XFERINT and HOST was asserted, mask
> > +		 * this interrupt and wait for an another one.  Note
> >   
> 
>    This comment somewhat contradicts the code which returns 1 if only 
> HOST interupt is asserted if ERR is set.

Indeed.  I will make the comment more precise.

> > +	case TX4939IDE_INT_HOST | TX4939IDE_INT_XFEREND:
> > +		dma_stat = TX4939IDE_readb(base, DMA_stat);
> > +		if (!(dma_stat & 4))
> > +			pr_debug("%s: weired interrupt status. "
> >   
> 
>    Weird.

Sure.  But it can happen IIRC...

> > +static void tx4939ide_hwif_init(ide_hwif_t *hwif)
> > +{
> > +	unsigned long base = TX4939IDE_BASE(hwif);
> > +	int timeout;
> > +
> > +	/* Soft Reset */
> > +	TX4939IDE_writew(0x8000, base, Sys_Ctl);
> > +	mmiowb();
> > +	udelay(1);	/* at least 20 UPSCLK (100ns for 200MHz GBUSCLK) */
> > +	/* ATA Hard Reset */
> > +	TX4939IDE_writew(0x0800, base, Sys_Ctl);
> > +	timeout = 1000;
> > +	while (TX4939IDE_readw(base, Sys_Ctl) & 0x0800) {
> > +		if (timeout--)
> > +			break;
> > +		udelay(1);
> > +	}
> 
>    Don't do this -- there's nothing gained from the ATA hard reset but 
> an extra delay; I removed such stuff from the TC86C001 driver. The IDE 
> core will soft-reset the bus if needed...

OK.

> > #ifdef __BIG_ENDIAN
> > +/* custom iops (independent from SWAP_IO_SPACE) */
> >   
> > +static u8 mm_inb(unsigned long port)
> > +{
> > +	return (u8)readb((void __iomem *)port);
> > +}
> > +static void mm_outb(u8 value, unsigned long port)
> > +{
> > +	writeb(value, (void __iomem *)port);
> > +}
> > +static void mm_tf_load(ide_drive_t *drive, ide_task_t *task)
> > +{
> >   
> [...]
> > +	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE) {
> > +		unsigned long base = TX4939IDE_BASE(hwif);
> > +		mm_outb((tf->device & HIHI) | drive->select,
> > +			 io_ports->device_addr);
> >   
> 
>    I'm seeing no sense in re-defining so far...
> 
> > +		/* Fix ATA100 CORE System Control Register */
> > +		TX4939IDE_writew(TX4939IDE_readw(base, Sys_Ctl) & 0x07f0,
> > +				 base, Sys_Ctl);
> >   
> 
>    Ah... you're doing it here (but not in LE mode?). I think to avoid 
> duplicating ide_tf_load() you need ot use selectproc().

Oh, my fault.  LE mode also needs this fix.  I still need ide_tf_load
on BE mode to support IDE_TFLAG_OUT_DATA.

> > +static void mm_insw_swap(unsigned long port, void *addr, u32 count)
> > +{
> > +	unsigned short *ptr = addr;
> > +	unsigned long size = count * 2;
> > +	port &= ~1;
> > +	while (count--)
> > +		*ptr++ = le16_to_cpu(__raw_readw((void __iomem *)port));
> > +	__ide_flush_dcache_range((unsigned long)addr, size);
> >   
> 
>    Why is this needed BTW?

Do you mean __ide_flush_dcache_range?  This is needed to avoid cache
inconsistency on PIO drive.  PIO transfer only writes to cache but
upper layers expects the data is in main memory.

> > +static const struct ide_tp_ops tx4939ide_tp_ops = {
> > +	.exec_command		= ide_exec_command,
> > +	.read_status		= ide_read_status,
> > +	.read_altstatus		= ide_read_altstatus,
> > +	.read_sff_dma_status	= tx4939ide_read_sff_dma_status,
> >   
> 
>    Hum, it should be re-defined in both LE and BE mode (but actually not 
> called anyway).

What do you mean?  Please elaborate?

> > +	.host_flags = IDE_HFLAG_MMIO,
> > +	.pio_mask = ATA_PIO4,
> > +	.mwdma_mask = ATA_MWDMA2,
> > +	.swdma_mask = ATA_SWDMA2,
> >   
> 
>    No, SWDMA isn't supported.

Oh, indeed.

> > +	mapbase = (unsigned long)devm_ioremap(&pdev->dev, res->start,
> > +					      res->end - res->start + 1);
> > +	if (!mapbase)
> > +		return -EBUSY;
> > +	memset(&hw, 0, sizeof(hw));
> > +	hw.io_ports.data_addr = mapbase + TX4939IDE_REG8(DATA);
> >   
> 
>    Wrong, should be TX4939IDE_REG16(). I wonder how it manages to work 
> in BE mode with this...

Well, "port &= ~1" in mm_insw_swap() and mm_outsw_swap do the trick.

> > +#ifdef CONFIG_PM
> > +static int tx4939ide_resume(struct platform_device *dev)
> > +{
> > +	struct ide_host *host = platform_get_drvdata(dev);
> > +	ide_hwif_t *hwif = host->ports[0];
> > +	unsigned long base = TX4939IDE_BASE(hwif);
> > +
> > +	tx4939ide_hwif_init(hwif);
> >   
> 
>    ATA hard reset when coming out of suspend? Nice... :-)

Will be fixed in tx4939ide_hwif_init().


Thanks!

---
Atsushi Nemoto
