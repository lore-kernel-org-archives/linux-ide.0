From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Tue, 22 Jan 2008 23:30:39 +0300
Message-ID: <4796526F.1090103@ru.mvista.com>
References: <200801212144.29511.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:60930 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751255AbYAVU3t (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jan 2008 15:29:49 -0500
In-Reply-To: <200801212144.29511.asalnikov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Hello.

Anton Salnikov wrote:

> This is Palmchip BK3710 IDE controller support for kernel version 2.6.24-rc8.
> The IDE controller logic supports PIO, multiword DMA and ultra-DMA modes.
> Supports interface to compact Flash (CF) configured in True-IDE mode.

> Use ide_setup_dma() since BLK_DEV_PALMCHIP_BK3710 selects BLK_DEV_IDEDMA_PCI
> So I deleted exports from ide-dma.c

> Signed-off-by: Anton Salnikov <asalnikov@ru.mvista.com>

> Index: 2.6.24-rc8.ide/drivers/ide/arm/palm_bk3710.c
> ===================================================================
> --- /dev/null
> +++ 2.6.24-rc8.ide/drivers/ide/arm/palm_bk3710.c
> @@ -0,0 +1,434 @@

> +static long ide_palm_clk;
> +static u32 base;

    This base will be in hwif->dma_master, so you can aslo use it this way if 
you make your 'hwif' pointer static instead. Although as this

> +
> +static const struct palm_bk3710_udmatiming palm_bk3710_udmatimings[6] = {
> +	{160, 240},		/* UDMA Mode 0 */
> +	{125, 160},		/* UDMA Mode 1 */
> +	{100, 120},		/* UDMA Mode 2 */
> +	{100, 90},		/* UDMA Mode 3 */
> +	{85,  60},		/* UDMA Mode 4 */
> +};
> +
> +static struct clk *ideclkp;
> +
> +static inline u32 ioread(u32 reg)
> +{
> +	return ioread32(base + reg);
> +}
> +
> +static inline void iowrite(u32 val, u32 reg)
> +{
> +	iowrite32(val, base + reg);
> +}

    Why you chose to use ioread32() and iowrite32() if your device is strictly 
memory mapped? Those functions add some overhead, and boil down to readl() and 
writel() anyway.  IIRC, they should only be used if you have a hardware 
registers accessible from both I/O and memory space and driver supports both 
types of mapping (e.g., I/O mapped for the older hardware, memory mapped for 
the newer one)...

> +static void palm_bk3710_setudmamode(unsigned int dev, unsigned int mode)
> +{
> +	u8 tenv, trp, t0;
> +	u32 val;
> +
> +	/* DMA Data Setup */
> +	t0 = (palm_bk3710_udmatimings[mode].cycletime + ide_palm_clk - 1)
> +			/ ide_palm_clk - 1;
> +	tenv = (20 + ide_palm_clk - 1) / ide_palm_clk - 1;
> +	trp = (palm_bk3710_udmatimings[mode].rptime + ide_palm_clk - 1)
> +			/ ide_palm_clk - 1;
> +
> +	/* udmatim Register */
> +	val = ioread(BK3710_UDMATIM) & ((!dev) ? 0xFFF0 : 0xFF0F);

    Hm, isn't it shorter:

	val = ioread(BK3710_UDMATIM) & (dev ? 0xFF0F : 0xFFF0);

> +	iowrite(val, BK3710_UDMATIM);

    Why not skip intermediate write and re-read?  Does hardware require 
clearing the fields before setting new values by some weird chance?

> +	val = ioread(BK3710_UDMATIM) | (mode << ((!dev) ? 0 : 4));

    You actually need to shift left by 0 or 8, so shift count should be 3, not 
4 since 1 << 4 == 16!  I'm suggesting:

	val = ioread(BK3710_UDMATIM) | (mode << (dev ? 3 : 0));

> +	iowrite(val, BK3710_UDMATIM);
> +
> +	/* udmastb Ultra DMA Access Strobe Width */
> +	val = ioread(BK3710_UDMASTB) & (0xFF << ((!dev) << 4));

    I'm suggesting:

	val = ioread(BK3710_UDMASTB) & (0xFF00 >> (dev << 3));

> +	iowrite(val, BK3710_UDMASTB);
> +	val = ioread(BK3710_UDMASTB) | (t0 << (dev << 4));
> +	iowrite(val, BK3710_UDMASTB);
> +
> +	/* udmatrp Ultra DMA Ready to Pause Time */
> +	val = ioread(BK3710_UDMATRP) & (0xFF << ((!dev) << 4));
> +	iowrite(val, BK3710_UDMATRP);
> +	val = ioread(BK3710_UDMATRP) | (trp << (dev << 4));
> +	iowrite(val, BK3710_UDMATRP);
> +
> +	/* udmaenv Ultra DMA envelop Time */
> +	val = ioread(BK3710_UDMAENV) & (0xFF << ((!dev) << 4));
> +	iowrite(val, BK3710_UDMAENV);
> +	val = ioread(BK3710_UDMAENV) | (tenv << (dev << 4));
> +	iowrite(val, BK3710_UDMAENV);

    << 3 ISO << 4 everywhere...

> +
> +	/* Enable UDMA for Device */
> +	val = ioread(BK3710_UDMACTL) | (1 << dev);
> +	iowrite(val, BK3710_UDMACTL);
> +}
> +
> +static void palm_bk3710_setdmamode(unsigned int dev, unsigned int cycletime,
> +				  unsigned int mode)
> +{
> +	u8 td, tkw, t0;
> +	u32 val;
> +
> +	if (cycletime < ide_timing[mode].cycle)
> +		cycletime = ide_timing[mode].cycle;

    I don't think this check is necessary as you're passing either 
ide_timing[mode].cycle or drive->id->eide_dma_min -- whichever is greater...

> +
> +	/* DMA Data Setup */
> +	t0 = (cycletime + ide_palm_clk - 1) / ide_palm_clk;
> +	td = (ide_timing_find_mode(mode)->active + ide_palm_clk - 1)

    You're not passing a mode suitable to ide_timing_find_mode() here, but 
index into ide_timing[] table -- almost the same thing that this call is 
supposed to yield... :-/

> +			/ ide_palm_clk;
> +	tkw = t0 - td - 1;
> +	td -= 1;
> +
> +	val = ioread(BK3710_DMASTB) & (0xFF << ((!dev) << 4));
> +	iowrite(val, BK3710_DMASTB);
> +	val = ioread(BK3710_DMASTB) | (td << (dev << 4));
> +	iowrite(val, BK3710_DMASTB);
> +
> +	val = ioread(BK3710_DMARCVR) & (0xFF << ((!dev) << 4));
> +	iowrite(val, BK3710_DMARCVR);
> +	val = ioread(BK3710_DMARCVR) | (tkw << (dev << 4));
> +	iowrite(val, BK3710_DMARCVR);
> +
> +	/* Disable UDMA for Device */
> +	val = ioread(BK3710_UDMACTL) & (0xFF00 | (1 << (!dev)));

    I think it should be just like above:

	val = ioread(BK3710_UDMACTL) & ~(1 << dev);

> +	iowrite(val, BK3710_UDMACTL);
> +}

    Same comments as above...

> +static void palm_bk3710_setpiomode(ide_drive_t *mate, unsigned int dev,
> +				  unsigned int cycletime, unsigned int mode)
> +{
> +	u8 t2, t2i, t0;
> +	u32 val;
> +	struct ide_timing *t;
> +
> +	/* PIO Data Setup */
> +	t0 = (cycletime + ide_palm_clk - 1) / ide_palm_clk;
> +	t2 = (ide_timing_find_mode(XFER_PIO_0 + mode)->active + ide_palm_clk - 1)
> +			/ ide_palm_clk;
> +
> +	t2i = t0 - t2 - 1;
> +	t2 -= 1;
> +
> +	val = ioread(BK3710_DATSTB) & (0xFF << ((!dev) << 4));
> +	iowrite(val, BK3710_DATSTB);
> +	val = ioread(BK3710_DATSTB) | (t2 << (dev << 4));
> +	iowrite(val, BK3710_DATSTB);
> +
> +	val = ioread(BK3710_DATRCVR) & (0xFF << ((!dev) << 4));
> +	iowrite(val, BK3710_DATRCVR);
> +	val = ioread(BK3710_DATRCVR) | (t2i << (dev << 4));
> +	iowrite(val, BK3710_DATRCVR);
> +
> +	if (mate && mate->present) {
> +		u8 mode2 = ide_get_best_pio_mode(mate, 255, 4);
> +
> +		if (mode2 < mode)
> +			mode = mode2;
> +	}
> +
> +	/* TASKFILE Setup */
> +	t = ide_timing_find_mode(XFER_PIO_0 + mode);
> +	t0 = (t->cyc8b + ide_palm_clk - 1)
> +			/ ide_palm_clk;
> +	t2 = (t->act8b + ide_palm_clk - 1)
> +			/ ide_palm_clk;

    Please make the two above assignments take 2 lines ISO 4...

> +
> +	t2i = t0 - t2 - 1;
> +	t2 -= 1;
> +
> +	val = ioread(BK3710_REGSTB) & (0xFF << ((!dev) << 4));
> +	iowrite(val, BK3710_REGSTB);
> +	val = ioread(BK3710_REGSTB) | (t2 << (dev << 4));
> +	iowrite(val, BK3710_REGSTB);
> +
> +	val = ioread(BK3710_REGRCVR) & (0xFF << ((!dev) << 4));
> +	iowrite(val, BK3710_REGRCVR);
> +	val = ioread(BK3710_REGRCVR) | (t2i << (dev << 4));
> +	iowrite(val, BK3710_REGRCVR);

    Same mistakes as the above functions...

> +}
> +
> +static void palm_bk3710_set_dma_mode(ide_drive_t *drive, u8 xferspeed)
> +{
> +	int is_slave = drive->dn & 1;
> +
> +	if (xferspeed >= XFER_UDMA_0) {
> +		palm_bk3710_setudmamode(is_slave, xferspeed - XFER_UDMA_0);
> +	} else {
> +		int nspeed = 10 - xferspeed + XFER_MW_DMA_0;
> +		unsigned ide_cycle = max_t(int, ide_timing[nspeed].cycle,
> +					   drive->id->eide_dma_min);

    It's probably better to move this part into palm_bk3710_setdmamode()...

> +
> +		palm_bk3710_setdmamode(is_slave, ide_cycle, nspeed);

    You should pass xferspeed here, not nspeed...

> +static int __devinit palm_bk3710_probe(struct platform_device *pdev)
> +{
> +	hw_regs_t ide_ctlr_info;
> +	int index = 0;
> +	int pribase;
> +	struct clk *clkp;
> +	struct resource *mem, *irq;
> +	ide_hwif_t *hwif;
> +
> +	clkp = clk_get(NULL, "IDECLK");
> +	if (IS_ERR(clkp))
> +		return -ENODEV;
> +
> +	ideclkp = clkp;
> +	clk_enable(ideclkp);
> +	ide_palm_clk = clk_get_rate(ideclkp)/100000;
> +	ide_palm_clk = (10000/ide_palm_clk) + 1;
> +	/* Register the IDE interface with Linux ATA Interface */
> +	memset(&ide_ctlr_info, 0, sizeof(ide_ctlr_info));
> +
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (mem == NULL) {
> +		printk(KERN_INFO "failed to get memory region resource\n");
> +		return -ENODEV;
> +	}
> +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (irq == NULL) {
> +		printk(KERN_INFO "failed to get IRQ resource\n");
> +		return -ENODEV;
> +	}
> +
> +	base = mem->start;
> +	/* Configure the Palm Chip controller */
> +	palm_bk3710_chipinit();
> +
> +	pribase = mem->start + IDE_PALM_ATA_PRI_REG_OFFSET;
> +	for (index = 0; index < IDE_NR_PORTS - 2; index++)
> +		ide_ctlr_info.io_ports[index] = pribase + index;
> +	ide_ctlr_info.io_ports[IDE_CONTROL_OFFSET] = mem->start +
> +			IDE_PALM_ATA_PRI_CTL_OFFSET;
> +	ide_ctlr_info.irq = irq->start;
> +	ide_ctlr_info.chipset = ide_palm3710;
> +
> +	if (!request_region(mem->start, 8, "palm_bk3710")) {

    It should be request_mem_region() since the chip is memory mapped. I've 
managed to overlook this so far. :-<
    BTW, shouldn't you call request_mem_region() for the entire controller 
register region (0x400 in size if I don't mistake)?

> +		printk(KERN_ERR "Error, ports in use.\n");
> +		return -EBUSY;
> +	}
> +
> +	if (ide_register_hw(&ide_ctlr_info, NULL, 0, &hwif) < 0) {
> +		printk(KERN_WARNING "Palm Chip BK3710 IDE Register Fail\n");
> +		return -ENODEV;
> +	}
> +
> +	hwif->set_pio_mode = &palm_bk3710_set_pio_mode;
> +	hwif->set_dma_mode = &palm_bk3710_set_dma_mode;
> +	hwif->mmio = 1;
> +	hwif->ultra_mask = 0x1f;	/* Ultra DMA Mode 4 Max
> +						(input clk 99MHz) */
> +	hwif->mwdma_mask = 0x7;
> +	hwif->drives[0].autotune = 1;
> +	hwif->drives[1].autotune = 1;
> +
> +	hwif->dmatable_cpu = dma_alloc_coherent(
> +				NULL,
> +				PRD_ENTRIES * PRD_BYTES,
> +				&hwif->dmatable_dma,
> +				GFP_ATOMIC);
> +
> +	if (!hwif->dmatable_cpu) {
> +		printk(KERN_ERR "Error, unable to allocate DMA table.\n");
> +		hwif->ultra_mask = 0;
> +		hwif->mwdma_mask = 0;
> +		return 0;
> +	}
> +

    You don't need to allocate PRD table -- ide_setup_dma() will do it for you 
anyway, although using pci_alloc_consistent().

> +	hwif->dma_base = mem->start;
> +
> +	hwif->dma_master = mem->start;
> +
> +	hwif->dma_command = mem->start;
> +	hwif->dma_status = mem->start + 2;
> +	hwif->dma_prdtable = mem->start + 4;

    You don't need 5 above assignments - ide_setup_dma() will do this for you.

> +	ide_setup_dma(hwif, mem->start, 8);
> +
> +	return 0;
> +}

MBR, Sergei
