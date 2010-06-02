From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 4/4] pata_samsung: Add Samsung PATA controller driver
Date: Wed, 02 Jun 2010 11:37:15 +0900
Message-ID: <002901cb01fc$85bbb9d0$91332d70$%kim@samsung.com>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
 <1274948524-2970-5-git-send-email-kgene.kim@samsung.com>
 <20100527084332.GI4720@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20100527084332.GI4720@trinity.fluff.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Ben Dooks' <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 'Abhilash Kesavan' <a.kesavan@samsung.com>
List-Id: linux-ide@vger.kernel.org

Ben Dooks wrote:
> 
> On Thu, May 27, 2010 at 05:22:04PM +0900, Kukjin Kim wrote:
> > From: Abhilash Kesavan <a.kesavan@samsung.com>
> >
> > Adds support for the Samsung PATA controller. This driver is based on the
> > Libata subsystem and references the earlier patches sent for IDE
subsystem.
> >
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  drivers/ata/Kconfig        |    9 +
> >  drivers/ata/Makefile       |    1 +
> >  drivers/ata/pata_samsung.c |  591
> ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 601 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/ata/pata_samsung.c
> >
> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > index e68541f..ce40f66 100644
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -640,6 +640,15 @@ config PATA_RZ1000
> >
> >  	  If unsure, say N.
> >
> > +config PATA_SAMSUNG
> > +	tristate "Samsung SoC PATA support"
> > +	depends on S3C_DEV_IDE
> > +	help
> > +	  This option enables basic support for Samsung's S3C/S5P board
> > +	  PATA controllers via the new ATA layer
> > +
> > +	  If unsure, say N.
> > +
> >  config PATA_SC1200
> >  	tristate "SC1200 PATA support"
> >  	depends on PCI
> > diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> > index d0a93c4..0b6d29a 100644
> > --- a/drivers/ata/Makefile
> > +++ b/drivers/ata/Makefile
> > @@ -62,6 +62,7 @@ obj-$(CONFIG_PATA_RADISYS)	+= pata_radisys.o
> >  obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
> >  obj-$(CONFIG_PATA_RDC)		+= pata_rdc.o
> >  obj-$(CONFIG_PATA_RZ1000)	+= pata_rz1000.o
> > +obj-$(CONFIG_PATA_SAMSUNG)	+= pata_samsung.o
> do you want to call it pata_samsung_soc.o instead, in case samsung make
> otehr types of pata controller?

Will change the name to pata_samsung_cf.

> >  obj-$(CONFIG_PATA_SC1200)	+= pata_sc1200.o
> >  obj-$(CONFIG_PATA_SERVERWORKS)	+= pata_serverworks.o
> >  obj-$(CONFIG_PATA_SIL680)	+= pata_sil680.o
> > diff --git a/drivers/ata/pata_samsung.c b/drivers/ata/pata_samsung.c
> > new file mode 100644
> > index 0000000..14381e4
> > --- /dev/null
> > +++ b/drivers/ata/pata_samsung.c
> > @@ -0,0 +1,591 @@
> > +/* linux/drivers/ata/pata_samsung.c
> > + *
> > + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com
> > + *
> > + * PATA driver for Samsung SoC's.
> SoCs.

OK

> > + * Supports CF Interface in True IDE mode. Currently only PIO mode has
been
> > + * implemented; UDMA support has to be added.
> > + *
> > + * Based on:
> > + *	PATA driver for AT91SAM9260 Static Memory Controller
> > + *	PATA driver for Toshiba SCC controller
> > + *
> > + * This program is free software; you can redistribute it and/or modify
it
> > + * under the terms of the GNU General Public License version 2
> > + * as published by the Free Software Foundation.
> > +*/
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/clk.h>
> > +#include <linux/libata.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/slab.h>
> > +
> > +#include <plat/ata.h>
> > +#include <plat/regs-ata.h>
> > +
> > +#define DRV_NAME "pata_samsung"
> > +#define DRV_VERSION "0.1"
> > +
> > +enum s3c_cpu_type {
> > +	TYPE_S3C6400,
> > +	TYPE_S5PC100,
> > +	TYPE_S5PV210,
> > +};
> > +
> > +/*
> > + * struct s3c_ide_info - S3C PATA instance.
> > + * @clk: The clock resource for this controller.
> > + * @ide_addr: The area mapped for the hardware registers.
> > + * @sfr_addr: The area mapped for the special function registers.
> > + * @irq: The IRQ number we are using.
> > + * @cpu_type: The exact type of this controller.
> > + * @fifo_status_reg: The ATA_FIFO_STATUS register offset.
> > + */
> > +struct s3c_ide_info {
> > +	struct clk *clk;
> > +	void __iomem *ide_addr;
> > +	void __iomem *sfr_addr;
> > +	unsigned int irq;
> > +	enum s3c_cpu_type cpu_type;
> > +	unsigned int fifo_status_reg;
> > +};
> > +
> > +static unsigned long piotime[5];
> > +
> > +static void pata_s3c_set_endian(void *s3c_ide_regbase, u8 mode)
> > +{
> > +	u32 reg = readl(s3c_ide_regbase + S3C_ATA_CFG);
> > +	reg = mode ? (reg & ~S3C_ATA_CFG_SWAP) : (reg |
> S3C_ATA_CFG_SWAP);
> > +	writel(reg, s3c_ide_regbase + S3C_ATA_CFG);
> > +}
> > +
> > +static void pata_s3c_tune_chipset(struct s3c_ide_info *info, u8
ide_mode)
> > +{
> > +	ulong ata_cfg = readl(info->ide_addr + S3C_ATA_CFG);
> > +
> > +	/* IORDY is enabled for modes > PIO2 */
> > +	if (XFER_PIO_0 <= ide_mode && ide_mode <= XFER_PIO_4) {
> > +
> > +		switch (ide_mode) {
> > +		case XFER_PIO_0:
> > +		case XFER_PIO_1:
> > +		case XFER_PIO_2:
> > +			ata_cfg &= (~S3C_ATA_CFG_IORDYEN);
> > +			break;
> > +		case XFER_PIO_3:
> > +		case XFER_PIO_4:
> > +			ata_cfg |= S3C_ATA_CFG_IORDYEN;
> > +			break;
> > +		}
> > +
> > +		writel(ata_cfg, info->ide_addr + S3C_ATA_CFG);
> > +		writel(piotime[ide_mode - XFER_PIO_0],
> > +			info->ide_addr + S3C_ATA_PIO_TIME);
> > +	} else {
> > +		/* Default to PIO0 */
> > +		ata_cfg &= (~S3C_ATA_CFG_IORDYEN);
> technically no need to ().

OK

> > +		writel(ata_cfg, info->ide_addr + S3C_ATA_CFG);
> > +		writel(piotime[0], info->ide_addr + S3C_ATA_PIO_TIME);
> > +	}
> > +}
> > +
> > +static void
> > +pata_s3c_set_piomode(struct ata_port *ap, struct ata_device *adev)
> > +{
> > +	struct s3c_ide_info *info = ap->host->private_data;
> > +
> > +	/* Configure IORDY based on PIO mode and also set the timing value */
> > +	pata_s3c_tune_chipset(info, adev->pio_mode);
> > +}
> > +
> > +/*
> > + * Waits until the IDE controller is able to perform next read/write
> > + * operation to the disk. Needed for 64XX series boards only.
> > + */
> > +static int wait_for_host_ready(struct s3c_ide_info *info)
> > +{
> > +	ulong timeout;
> > +
> > +	/* wait for maximum of 20 msec */
> > +	timeout = jiffies + msecs_to_jiffies(20);
> > +	while (time_before(jiffies, timeout)) {
> > +		if ((readl(info->ide_addr + info->fifo_status_reg) >> 28) ==
0)
> > +			return 0;
> > +	}
> > +	return -EBUSY;
> > +}
> > +
> > +/*
> > + * Writes to one of the task file registers.
> > + */
> > +static void ata_outb(struct ata_host *host, u8 addr, void __iomem *reg)
> > +{
> > +	struct s3c_ide_info *info = host->private_data;
> > +
> > +	wait_for_host_ready(info);
> > +	__raw_writeb(addr, reg);
> > +}
> 
> probably want writeb() here. you've used the non __raw versions elsewhere.
> 

OK

> > +/*
> > + * Reads from one of the task file registers.
> > + */
> > +static u8 ata_inb(struct ata_host *host, void __iomem *reg)
> > +{
> > +	struct s3c_ide_info *info = host->private_data;
> > +	u8 temp;
> > +
> > +	wait_for_host_ready(info);
> > +	temp = __raw_readb(reg);
> > +	wait_for_host_ready(info);
> > +	temp = __raw_readb(info->ide_addr + S3C_ATA_PIO_RDATA);
> > +	return temp;
> > +}
> > +
> > +/*
> > + * pata_s3c_tf_load - send taskfile registers to host controller
> > + */
> > +static void pata_s3c_tf_load(struct ata_port *ap,
> > +				const struct ata_taskfile *tf)
> > +{
> > +	struct ata_ioports *ioaddr = &ap->ioaddr;
> > +	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
> > +
> > +	if (tf->ctl != ap->last_ctl) {
> > +		if (ioaddr->ctl_addr)
> > +			ata_outb(ap->host, tf->ctl, ioaddr->ctl_addr);
> > +		ap->last_ctl = tf->ctl;
> > +		ata_wait_idle(ap);
> > +	}
> > +
> > +	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
> > +		WARN_ON_ONCE(!ioaddr->ctl_addr);
> > +		ata_outb(ap->host, tf->hob_feature, ioaddr->feature_addr);
> > +		ata_outb(ap->host, tf->hob_nsect, ioaddr->nsect_addr);
> > +		ata_outb(ap->host, tf->hob_lbal, ioaddr->lbal_addr);
> > +		ata_outb(ap->host, tf->hob_lbam, ioaddr->lbam_addr);
> > +		ata_outb(ap->host, tf->hob_lbah, ioaddr->lbah_addr);
> > +	}
> > +
> > +	if (is_addr) {
> > +		ata_outb(ap->host, tf->feature, ioaddr->feature_addr);
> > +		ata_outb(ap->host, tf->nsect, ioaddr->nsect_addr);
> > +		ata_outb(ap->host, tf->lbal, ioaddr->lbal_addr);
> > +		ata_outb(ap->host, tf->lbam, ioaddr->lbam_addr);
> > +		ata_outb(ap->host, tf->lbah, ioaddr->lbah_addr);
> > +	}
> > +
> > +	if (tf->flags & ATA_TFLAG_DEVICE)
> > +		ata_outb(ap->host, tf->device, ioaddr->device_addr);
> > +
> > +	ata_wait_idle(ap);
> > +}
> > +
> > +/*
> > + * pata_s3c_tf_read - input device's ATA taskfile shadow registers
> > + */
> > +static void pata_s3c_tf_read(struct ata_port *ap, struct ata_taskfile
*tf)
> > +{
> > +	struct ata_ioports *ioaddr = &ap->ioaddr;
> > +
> > +	tf->command = ata_sff_check_status(ap);
> > +	tf->feature = ata_inb(ap->host, ioaddr->error_addr);
> > +	tf->nsect = ata_inb(ap->host, ioaddr->nsect_addr);
> > +	tf->lbal = ata_inb(ap->host, ioaddr->lbal_addr);
> > +	tf->lbam = ata_inb(ap->host, ioaddr->lbam_addr);
> > +	tf->lbah = ata_inb(ap->host, ioaddr->lbah_addr);
> > +	tf->device = ata_inb(ap->host, ioaddr->device_addr);
> > +
> > +	if (tf->flags & ATA_TFLAG_LBA48) {
> > +		if (likely(ioaddr->ctl_addr)) {
> > +			iowrite8(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
> > +			tf->hob_feature = ata_inb(ap->host,
ioaddr->error_addr);
> > +			tf->hob_nsect = ata_inb(ap->host,
ioaddr->nsect_addr);
> > +			tf->hob_lbal = ata_inb(ap->host, ioaddr->lbal_addr);
> > +			tf->hob_lbam = ata_inb(ap->host, ioaddr->lbam_addr);
> > +			tf->hob_lbah = ata_inb(ap->host, ioaddr->lbah_addr);
> > +			iowrite8(tf->ctl, ioaddr->ctl_addr);
> > +			ap->last_ctl = tf->ctl;
> > +		} else
> > +			WARN_ON_ONCE(1);
> > +	}
> > +}
> > +
> > +/*
> > + * pata_s3c_exec_command - issue ATA command to host controller
> > + */
> > +static void pata_s3c_exec_command(struct ata_port *ap,
> > +				const struct ata_taskfile *tf)
> > +{
> > +	ata_outb(ap->host, tf->command, ap->ioaddr.command_addr);
> > +	ata_sff_pause(ap);
> > +}
> > +
> > +/*
> > + * pata_s3c_check_status - Read device status register
> > + */
> > +static u8 pata_s3c_check_status(struct ata_port *ap)
> > +{
> > +	return ata_inb(ap->host, ap->ioaddr.status_addr);
> > +}
> > +
> > +/*
> > + * pata_s3c_data_xfer - Transfer data by PIO
> > + */
> > +unsigned int pata_s3c_data_xfer(struct ata_device *dev, unsigned char
*buf,
> > +				unsigned int buflen, int rw)
> > +{
> > +	struct ata_port *ap = dev->link->ap;
> > +	struct s3c_ide_info *info = ap->host->private_data;
> > +	void __iomem *data_addr = ap->ioaddr.data_addr;
> > +	unsigned int words = buflen >> 1, i;
> > +	u16 *temp_addr = (u16 *)buf;
> 
> hmm, how about calling it data_ptr instead of temp_addr?
> 

OK

> > +	if (rw == READ) {
> > +		for (i = 0; i < words; i++, temp_addr++) {
> > +			wait_for_host_ready(info);
> > +			*temp_addr = __raw_readw(data_addr);
> > +			wait_for_host_ready(info);
> > +			*temp_addr = __raw_readw(info->ide_addr
> > +					+ S3C_ATA_PIO_RDATA)
> 
> think you want readw() here, please ensure consitency.
> 
> this also look a bit weird, you are writing to *temp_addr twice,
> could you simply dicscard the first read?
> 
> note, you say s3c64xx only needs wait_for_host_ready() but you
> always call it?
> 

wait_for_host_ready is called via pata_s3c_port_ops which is only for 64xx.

> > +		}
> > +	} else {
> > +		for (i = 0; i < words; i++, temp_addr++) {
> > +			wait_for_host_ready(info);
> > +			writel(*temp_addr, data_addr);
> > +		}
> > +	}
> > +
> > +	return words << 1;
> > +}
> > +
> > +static struct scsi_host_template pata_s3c_sht = {
> > +	ATA_PIO_SHT(DRV_NAME),
> > +};
> > +
> > +static struct ata_port_operations pata_s3c_port_ops = {
> > +	.inherits		= &ata_sff_port_ops,
> > +	.sff_check_status	= pata_s3c_check_status,
> > +	.sff_tf_load		= pata_s3c_tf_load,
> > +	.sff_tf_read		= pata_s3c_tf_read,
> > +	.sff_data_xfer		= pata_s3c_data_xfer,
> > +	.sff_exec_command	= pata_s3c_exec_command,
> > +	.qc_prep		= ata_noop_qc_prep,
> > +	.set_piomode		= pata_s3c_set_piomode,
> > +};
> > +
> > +static struct ata_port_operations pata_s5p_port_ops = {
> > +	.inherits		= &ata_sff_port_ops,
> > +	.qc_prep		= ata_noop_qc_prep,
> > +	.set_piomode		= pata_s3c_set_piomode,
> > +};
> > +
> > +static void pata_s3c_enable(void *s3c_ide_regbase, u8 state)
> > +{
> > +	u32 temp = readl(s3c_ide_regbase + S3C_ATA_CTRL);
> > +	temp = state ? temp | 1 : temp & ~1;
> you might want ()around the temp |1 and temp & ~1

OK

> > +	writel(temp, s3c_ide_regbase + S3C_ATA_CTRL);
> > +}
> > +
> > +static irqreturn_t pata_s3c_irq(int irq, void *dev_instance)
> > +{
> > +	struct ata_host *host = dev_instance;
> > +	struct s3c_ide_info *info = host->private_data;
> > +	u32 reg;
> > +
> > +	reg = readl(info->ide_addr + S3C_ATA_IRQ);
> > +	writel(reg, info->ide_addr + S3C_ATA_IRQ);
> > +
> > +	return ata_sff_interrupt(irq, dev_instance);
> > +}
> > +
> > +static void pata_s3c_setup_timing(struct s3c_ide_info *info)
> > +{
> > +	uint t1, t2, teoc, i;
> > +
> > +	uint pio_t1[5] = { 70, 50, 30, 30, 25 };
> > +	uint pio_t2[5] = { 290, 290, 290, 80, 70 };
> > +	uint pio_teoc[5] = { 240, 43, 10, 70, 25 };
> > +
> > +	ulong cycle_time = (uint) (1000000000 / clk_get_rate(info->clk));
> 
> ulong and uinit? surely pick one. you might want to keep UL and cajhnge
> 1000000000 to 1000000000UL
> 

OK

> > +	for (i = 0; i < 5; i++) {
> > +		t1 = (pio_t1[i] / cycle_time) & 0x0f;
> > +		t2 = (pio_t2[i] / cycle_time) & 0xff;
> > +		teoc = (pio_teoc[i] / cycle_time) & 0xff;
> > +		piotime[i] = (teoc << 12) | (t2 << 4) | t1;
> > +	}
> > +}
> > +
> > +static void pata_s3c_hwinit(struct s3c_ide_info *info,
> > +				struct s3c_ide_platdata *pdata)
> > +{
> > +	/* Select true-ide as the internal operating mode*/
> > +	if (pdata && (pdata->cfg_mode))
> > +		pdata->cfg_mode(info->sfr_addr);
> > +
> > +	switch (info->cpu_type) {
> > +	case TYPE_S3C6400:
> > +		/* Configure as big endian and enable the i/f*/
> > +		pata_s3c_set_endian(info->ide_addr, 1);
> > +		pata_s3c_enable(info->ide_addr, 1);
> > +		mdelay(100);
> > +
> > +		/* Remove IRQ Status */
> > +		writel(0x1f, info->ide_addr + S3C_ATA_IRQ);
> > +		writel(0x1b, info->ide_addr + S3C_ATA_IRQ_MSK);
> > +	break;
> > +
> > +	case TYPE_S5PV210:
> > +	case TYPE_S5PC100:
> > +		/* Configure as little endian and enable the i/f */
> > +		pata_s3c_set_endian(info->ide_addr, 0);
> > +		pata_s3c_enable(info->ide_addr, 1);
> > +		mdelay(100);
> > +
> > +		/* Remove IRQ Status */
> > +		writel(0x3f, info->ide_addr + S3C_ATA_IRQ);
> > +		writel(0x3f, info->ide_addr + S3C_ATA_IRQ_MSK);
> > +	break;
> > +
> > +	default:
> > +		BUG();
> > +	}
> > +}
> > +
> > +static int __devinit pata_s3c_probe(struct platform_device *pdev)
> > +{
> > +	struct s3c_ide_platdata *pdata = pdev->dev.platform_data;
> > +	struct device *dev = &pdev->dev;
> > +	struct s3c_ide_info *info;
> > +	struct resource *res;
> > +	struct ata_port *ap;
> > +	struct ata_host *host;
> > +	enum s3c_cpu_type cpu_type;
> > +	int ret;
> > +
> > +	cpu_type = platform_get_device_id(pdev)->driver_data;
> > +
> > +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> > +	if (!info) {
> > +		dev_err(dev, "failed to allocate memory for device data\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	info->irq = platform_get_irq(pdev, 0);
> > +	if (info->irq < 0) {
> > +		dev_err(dev, "could not obtain irq number\n");
> > +		ret = -ENODEV;
> > +		goto release_device_mem;
> > +	}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (res == NULL) {
> > +		dev_err(dev, "failed to get mem resource\n");
> > +		ret = -ENODEV;
> 
> if i remeber correctly, you don't want to be returning -ENODEV as
> it will be ignored by the uper layers.
> 

Will replace with EINVAL.

> > +		goto release_device_mem;
> > +	}
> > +
> > +	info->ide_addr = devm_ioremap(dev,
> > +				res->start, res->end - res->start + 1);
> 
> resource_size() is your friend here.
> 

OK

> > +	if (!info->ide_addr) {
> > +		dev_err(dev, "failed to map IO base address\n");
> > +		ret = -ENOMEM;
> > +		goto release_mem;
> > +	}
> > +
> > +	info->clk = clk_get(&pdev->dev, "cfcon");
> 
> need to do something about using explicit names here, should be clk_get(,
NULL)
> 

OK

> > +	if (IS_ERR(info->clk)) {
> > +		dev_err(dev, "failed to get access to cf controller
clock\n");
> > +		ret = PTR_ERR(info->clk);
> > +		info->clk = NULL;
> > +		goto unmap;
> > +	}
> > +
> > +	if (clk_enable(info->clk)) {
> > +		dev_err(dev, "failed to enable clock source.\n");
> > +		goto clkerr;
> > +	}
> > +
> > +	/* init ata host */
> > +	host = ata_host_alloc(dev, 1);
> > +	if (!host) {
> > +		dev_err(dev, "failed to allocate ide host\n");
> > +		ret = -ENOMEM;
> > +		goto stop_clk;
> > +	}
> > +
> > +	ap = host->ports[0];
> > +	ap->flags |= ATA_FLAG_MMIO;
> > +	ap->pio_mask = ATA_PIO4;
> > +
> > +	if (cpu_type == TYPE_S3C6400) {
> > +		ap->ops = &pata_s3c_port_ops;
> > +		info->sfr_addr = info->ide_addr + 0x1800;
> > +		info->ide_addr = info->ide_addr + 0x1900;
> > +		info->fifo_status_reg = 0x94;
> > +	} else if (cpu_type == TYPE_S5PC100) {
> > +		ap->ops = &pata_s5p_port_ops;
> > +		info->sfr_addr = info->ide_addr + 0x1800;
> > +		info->ide_addr = info->ide_addr + 0x1900;
> > +		info->fifo_status_reg = 0x84;
> > +	} else {
> > +		ap->ops = &pata_s5p_port_ops;
> > +		info->fifo_status_reg = 0x84;
> > +	}
> > +
> > +	info->cpu_type = cpu_type;
> > +
> > +	if (!(info->irq)) {
> > +		ap->flags |= ATA_FLAG_PIO_POLLING;
> > +		ata_port_desc(ap, "no IRQ, using PIO polling\n");
> > +	}
> > +
> > +	ap->ioaddr.cmd_addr =  info->ide_addr + S3C_ATA_CMD;
> > +	ap->ioaddr.data_addr = info->ide_addr + S3C_ATA_PIO_DTR;
> > +	ap->ioaddr.error_addr = info->ide_addr + S3C_ATA_PIO_FED;
> > +	ap->ioaddr.feature_addr = info->ide_addr + S3C_ATA_PIO_FED;
> > +	ap->ioaddr.nsect_addr = info->ide_addr + S3C_ATA_PIO_SCR;
> > +	ap->ioaddr.lbal_addr = info->ide_addr + S3C_ATA_PIO_LLR;
> > +	ap->ioaddr.lbam_addr = info->ide_addr + S3C_ATA_PIO_LMR;
> > +	ap->ioaddr.lbah_addr = info->ide_addr + S3C_ATA_PIO_LHR;
> > +	ap->ioaddr.device_addr = info->ide_addr + S3C_ATA_PIO_DVR;
> > +	ap->ioaddr.status_addr = info->ide_addr + S3C_ATA_PIO_CSD;
> > +	ap->ioaddr.command_addr = info->ide_addr + S3C_ATA_PIO_CSD;
> > +	ap->ioaddr.altstatus_addr = info->ide_addr + S3C_ATA_PIO_DAD;
> > +	ap->ioaddr.ctl_addr = info->ide_addr + S3C_ATA_PIO_DAD;
> > +
> > +
> > +	ata_port_desc(ap, "mmio cmd 0x%llx ",
> > +			(unsigned long long)res->start);
> > +
> > +	host->private_data = info;
> > +
> > +	/* Calculates timing parameters for PIO mode */
> > +	pata_s3c_setup_timing(info);
> > +
> > +	if (pdata && (pdata->setup_gpio))
> no need for () around the pdata->setup_gpio

OK

> > +		pdata->setup_gpio();
> > +
> > +	/* Set endianness and enable the interface */
> > +	pata_s3c_hwinit(info, pdata);
> > +
> > +	return ata_host_activate(host, info->irq ? info->irq : 0,
> > +			info->irq ? pata_s3c_irq : NULL,
> > +			IRQF_DISABLED, &pata_s3c_sht);
> 
> do you really need to run with IRQs disabled?
> 

No.. will correct it

> > +	dev_set_drvdata(&pdev->dev, host);
> > +
> > +stop_clk:
> > +	clk_disable(info->clk);
> > +clkerr:
> > +	clk_put(info->clk);
> > +unmap:
> > +	devm_iounmap(dev, info->ide_addr);
> > +release_mem:
> > +	release_mem_region(res->start, res->end - res->start + 1);
> > +release_device_mem:
> > +	kfree(info);
> > +return ret;
> > +}
> > +
> > +static int __devexit pata_s3c_remove(struct platform_device *pdev)
> > +{
> > +	struct ata_host *host = dev_get_drvdata(&pdev->dev);
> > +	struct s3c_ide_info *info;
> > +	struct resource *res;
> > +
> > +	if (!host)
> > +		return 0;
> > +	info = host->private_data;
> > +
> > +	ata_host_detach(host);
> > +
> > +	devm_iounmap(&pdev->dev, info->ide_addr);
> > +	clk_disable(info->clk);
> > +	clk_put(info->clk);
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	release_mem_region(res->start, res->end - res->start + 1);
> > +	kfree(info);
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int pata_s3c_suspend(struct platform_device *pdev, pm_message_t
state)
> > +{
> > +	struct ata_host *host = dev_get_drvdata(&pdev->dev);
> > +	if (host)
> > +		return ata_host_suspend(host, state);
> > +	else
> > +		return 0;
> > +}
> > +
> > +static int pata_s3c_resume(struct platform_device *pdev)
> > +{
> > +	struct ata_host *host = dev_get_drvdata(&pdev->dev);
> > +	struct s3c_ide_platdata *pdata = pdev->dev.platform_data;
> > +	struct s3c_ide_info *info;
> > +
> > +	info = host->private_data;
> > +
> > +	if (host) {
> > +		pata_s3c_hwinit(info, pdata);
> > +		ata_host_resume(host);
> > +	}
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> > +/* driver device registration */
> > +static struct platform_device_id pata_s3c_driver_ids[] = {
> > +	{
> > +		.name		= "s3c6400-pata",
> > +		.driver_data	= TYPE_S3C6400,
> > +	}, {
> > +		.name		= "s5pc100-pata",
> > +		.driver_data	= TYPE_S5PC100,
> > +	}, {
> > +		.name		= "s5pv210-pata",
> > +		.driver_data	= TYPE_S5PV210,
> > +	},
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(platform, pata_s3c_driver_ids);
> > +
> > +static struct platform_driver pata_s3c_driver = {
> > +	.probe		= pata_s3c_probe,
> > +	.remove		= __devexit_p(pata_s3c_remove),
> > +	.id_table	= pata_s3c_driver_ids,
> > +	.driver		= {
> > +		.name		= DRV_NAME,
> > +		.owner		= THIS_MODULE,
> > +	},
> > +#ifdef CONFIG_PM
> > +	.suspend	= pata_s3c_suspend,
> > +	.resume		= pata_s3c_resume,
> > +#endif
> please look at using the new pm_ops.
> 

Will use dev_pm_ops.

> > +};
> > +
> > +static int __init pata_s3c_init(void)
> > +{
> > +	return platform_driver_register(&pata_s3c_driver);
> > +}
> > +
> > +static void __exit pata_s3c_exit(void)
> > +{
> > +	platform_driver_unregister(&pata_s3c_driver);
> > +}
> > +
> > +module_init(pata_s3c_init);
> > +module_exit(pata_s3c_exit);
> > +
> > +MODULE_AUTHOR("Abhilash Kesavan, <a.kesavan@samsung.com>");
> > +MODULE_DESCRIPTION("low-level driver for Samsung PATA controller");
> > +MODULE_LICENSE("GPL");
> > +MODULE_VERSION(DRV_VERSION);
> > --
> > 1.6.2.5
> 
> not bad, needs some cleanup.
> 


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
