From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Palmchip BK3710 IDE driver
Date: Thu, 24 Jan 2008 22:18:22 +0300
Message-ID: <4798E47E.3060701@ru.mvista.com>
References: <200801241801.08201.asalnikov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:28575 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753852AbYAXTRc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 14:17:32 -0500
In-Reply-To: <200801241801.08201.asalnikov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Salnikov <asalnikov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

Anton Salnikov wrote:

> This is Palmchip BK3710 IDE controller support for kernel version 2.6.24-rc8.
> The IDE controller logic supports PIO, multiword DMA and ultra-DMA modes.
> Supports interface to compact Flash (CF) configured in True-IDE mode.

> Signed-off-by: Anton Salnikov <asalnikov@ru.mvista.com>
> ---

> Index: 2.6.24-rc8.ide/drivers/ide/arm/palm_bk3710.c
> ===================================================================
> --- /dev/null
> +++ 2.6.24-rc8.ide/drivers/ide/arm/palm_bk3710.c
> @@ -0,0 +1,428 @@
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

    Hm, I don't see why you need those accessors but well...

> +static void palm_bk3710_setudmamode(u32 base, unsigned int dev,
> +				    unsigned int mode)
> +{
> +	u8 tenv, trp, t0;
> +	u32 val32;
> +	u16 val16;
> +
> +	/* DMA Data Setup */
> +	t0 = (palm_bk3710_udmatimings[mode].cycletime + ide_palm_clk - 1)
> +			/ ide_palm_clk - 1;
> +	tenv = (20 + ide_palm_clk - 1) / ide_palm_clk - 1;
> +	trp = (palm_bk3710_udmatimings[mode].rptime + ide_palm_clk - 1)
> +			/ ide_palm_clk - 1;
> +
> +	/* udmatim Register */
> +	val16 = hwif_read16(base, BK3710_UDMATIM) & (dev ? 0xFF0F : 0xFFF0);
> +	val16 |= (mode << ((!dev) ? 0 : 4));

    Why not (dev ? 4 : 0) like the rest?

> +	hwif_write16(base, val16, BK3710_UDMATIM);
> +
> +	/* udmastb Ultra DMA Access Strobe Width */
> +	val32 = hwif_read32(base, BK3710_UDMASTB) & (0xFF << (dev ? 0 : 8));
> +	val32 |= (t0 << (dev ? 8 : 0));
> +	hwif_write32(base, val32, BK3710_UDMASTB);
> +
> +	/* udmatrp Ultra DMA Ready to Pause Time */
> +	val32 = hwif_read32(base, BK3710_UDMATRP) & (0xFF << (dev ? 0 : 8));
> +	val32 |= (trp << (dev ? 8 : 0));
> +	hwif_write32(base, val32, BK3710_UDMATRP);
> +
> +	/* udmaenv Ultra DMA envelop Time */
> +	val32 = hwif_read32(base, BK3710_UDMAENV) & (0xFF << (dev ? 0 : 8));
> +	val32 |= (tenv << (dev ? 8 : 0));
> +	hwif_write32(base, val32, BK3710_UDMAENV);
> +
> +	/* Enable UDMA for Device */
> +	val16 = hwif_read16(base, BK3710_UDMACTL) | (1 << dev);
> +	hwif_write16(base, val16, BK3710_UDMACTL);
> +}
> +
> +static void palm_bk3710_setdmamode(u32 base, unsigned int dev,
> +				   unsigned short min_cycle,
> +				   unsigned int mode)
> +{
> +	u8 td, tkw, t0;
> +	u32 val32;
> +	u16 val16;
> +
> +	unsigned cycletime = max_t(int, ide_timing_find_mode(mode)->cycle,
> +				   min_cycle);

    Hm, why integer comparison and then unsigned maximum?

> +
> +	/* DMA Data Setup */
> +	t0 = (cycletime + ide_palm_clk - 1) / ide_palm_clk;
> +	td = (ide_timing_find_mode(mode)->active + ide_palm_clk - 1)
> +			/ ide_palm_clk;

    Couldn't you call ide_timing_find_mode() only once?

[...]

> +static int __devinit palm_bk3710_probe(struct platform_device *pdev)
> +{
> +	hw_regs_t ide_ctlr_info;
> +	int index = 0;
> +	int pribase;
> +	struct clk *clkp;
> +	struct resource *mem, *irq;
> +	ide_hwif_t *hwif;
> +	u32 base;
> +	int ret;
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

    This deserves KERN_ERR, not KERN_INFO.

> +		return -ENODEV;
> +	}
> +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (irq == NULL) {
> +		printk(KERN_INFO "failed to get IRQ resource\n");

    This too...

> +		return -ENODEV;
> +	}
> +
> +	base = mem->start;
> +
> +	/* Configure the Palm Chip controller */
> +	palm_bk3710_chipinit(base);
> +
> +	pribase = mem->start + IDE_PALM_ATA_PRI_REG_OFFSET;
> +	for (index = 0; index < IDE_NR_PORTS - 2; index++)
> +		ide_ctlr_info.io_ports[index] = pribase + index;
> +	ide_ctlr_info.io_ports[IDE_CONTROL_OFFSET] = mem->start +
> +			IDE_PALM_ATA_PRI_CTL_OFFSET;
> +	ide_ctlr_info.irq = irq->start;
> +	ide_ctlr_info.chipset = ide_palm3710;
> +
> +	if (!request_mem_region(mem->start, 8, "palm_bk3710")) {
> +		printk(KERN_ERR "Error, memory region in use.\n");
> +		return -EBUSY;
> +	}

    Well, you either have to also register sub-resources for the IDE 
command/control register blocks since with hwif->mmiops == 1 the IDE core 
won't do this for you, or don't register any sub-resources at all, being 
content with what platform_device_add() did for us. BTW, don't forget extend 
the platform resource to account for IDE command/control register blocks.

> +	if (ide_register_hw(&ide_ctlr_info, NULL, 0, &hwif) < 0) {
> +		printk(KERN_WARNING "Palm Chip BK3710 IDE Register Fail\n");
> +		return -ENODEV;
> +	}
> +
> +	hwif->set_pio_mode = &palm_bk3710_set_pio_mode;
> +	hwif->set_dma_mode = &palm_bk3710_set_dma_mode;
> +	hwif->mmio = 1;

    Well, dealing with a memory-mapped IDE device, the driver lack 
default_hwif_mmiops() call...

MBR, Sergei
