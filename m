From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH v3] libata: pata_samsung_cf: Add Samsung PATA
	controller driver
Date: Fri, 11 Jun 2010 03:24:10 +0100
Message-ID: <20100611022410.GD14272@trinity.fluff.org>
References: <1276156241-28804-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:34228 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499Ab0FKCYL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jun 2010 22:24:11 -0400
Content-Disposition: inline
In-Reply-To: <1276156241-28804-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, jgarzik@pobox.com, Abhilash Kesavan <a.kesavan@samsung.com>

On Thu, Jun 10, 2010 at 04:50:41PM +0900, Kukjin Kim wrote:
> From: Abhilash Kesavan <a.kesavan@samsung.com>
> 
> Adds support for the Samsung PATA controller. This driver is based on the
> Libata subsystem and references the earlier patches sent for IDE subsystem.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

a few more comments, you may or may not want to fix before first
submission.

> ---
> 
> Changes since v2:
> - Changed the DRV_NAME to pata_samsung_cf
> - Used msleep instead of mdelay
> 
>  drivers/ata/Makefile          |    1 +
>  drivers/ata/pata_samsung_cf.c |  608 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 618 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/ata/pata_samsung_cf.c
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index aa85a98..1b5facf 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -796,6 +796,15 @@ config PATA_RZ1000
>  
>  	  If unsure, say N.
>  
> +config PATA_SAMSUNG_CF
> +	tristate "Samsung SoC PATA support"
> +	depends on SAMSUNG_DEV_IDE
> +	help
> +	  This option enables basic support for Samsung's S3C/S5P board
> +	  PATA controllers via the new ATA layer
> +
> +	  If unsure, say N.
> +
>  config PATA_WINBOND_VLB
>  	tristate "Winbond W83759A VLB PATA support (Experimental)"
>  	depends on ISA && EXPERIMENTAL
> diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> index 7ef89d7..9576776 100644
> --- a/drivers/ata/Makefile
> +++ b/drivers/ata/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
>  obj-$(CONFIG_PATA_QDI)		+= pata_qdi.o
>  obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
>  obj-$(CONFIG_PATA_RZ1000)	+= pata_rz1000.o
> +obj-$(CONFIG_PATA_SAMSUNG_CF)	+= pata_samsung_cf.o
>  obj-$(CONFIG_PATA_WINBOND_VLB)	+= pata_winbond.o
>  
>  # Should be last but two libata driver
> diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
> new file mode 100644
> index 0000000..fef5515
> --- /dev/null
> +++ b/drivers/ata/pata_samsung_cf.c
> @@ -0,0 +1,608 @@
> +/* linux/drivers/ata/pata_samsung_cf.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * PATA driver for Samsung SoCs.
> + * Supports CF Interface in True IDE mode. Currently only PIO mode has been
> + * implemented; UDMA support has to be added.
> + *
> + * Based on:
> + *	PATA driver for AT91SAM9260 Static Memory Controller
> + *	PATA driver for Toshiba SCC controller
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/libata.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <plat/ata.h>
> +#include <plat/regs-ata.h>
> +
> +#define DRV_NAME "pata_samsung_cf"
> +#define DRV_VERSION "0.1"
> +
> +enum s3c_cpu_type {
> +	TYPE_S3C64XX,
> +	TYPE_S5PC100,
> +	TYPE_S5PV210,
> +};
> +
> +/*
> + * struct s3c_ide_info - S3C PATA instance.
> + * @clk: The clock resource for this controller.
> + * @ide_addr: The area mapped for the hardware registers.
> + * @sfr_addr: The area mapped for the special function registers.
> + * @irq: The IRQ number we are using.
> + * @cpu_type: The exact type of this controller.
> + * @fifo_status_reg: The ATA_FIFO_STATUS register offset.
> + */
> +struct s3c_ide_info {
> +	struct clk *clk;
> +	void __iomem *ide_addr;
> +	void __iomem *sfr_addr;
> +	unsigned int irq;
> +	enum s3c_cpu_type cpu_type;
> +	unsigned int fifo_status_reg;
> +};
> +
> +static void pata_s3c_set_endian(void *s3c_ide_regbase, u8 mode)
> +{
should be void __iomem.

> +static void pata_s3c_set_piomode(struct ata_port *ap, struct ata_device *adev)
> +{
> +	int mode = adev->pio_mode - XFER_PIO_0;
> +	struct s3c_ide_info *info = ap->host->private_data;
> +	ulong ata_cfg = readl(info->ide_addr + S3C_ATA_CFG);
> +	ulong piotime;
> +
> +	/* Calculates timing parameters for PIO mode */
> +	piotime = pata_s3c_setup_timing(info, adev);
> +
> +	/* Enables IORDY if mode requires it */
> +	if (ata_pio_need_iordy(adev))
> +		ata_cfg |= S3C_ATA_CFG_IORDYEN;
> +	else
> +		ata_cfg &= ~S3C_ATA_CFG_IORDYEN;
> +
> +	/* Host controller supports upto PIO4 only */
> +	if (mode >= 0 && mode <= 4) {

if this code was to stay in, it would have been better to either
WARN_ON() or print some form of error messagee instead of just silently
ignoring it... also, you should have probably set the minumum acceptable
ATA mode to ensure any further actions would not cause problems with
trying to run the b us too fast.

> +/*
> + * Waits until the IDE controller is able to perform next read/write
> + * operation to the disk. Needed for 64XX series boards only.
> + */

if it is needed only for s3c64xx series, why don't we bail if the
info->type != 64xx?

> +static int wait_for_host_ready(struct s3c_ide_info *info)
> +{
> +	ulong timeout;
> +
> +	/* wait for maximum of 20 msec */
> +	timeout = jiffies + msecs_to_jiffies(20);
> +	while (time_before(jiffies, timeout)) {
> +		if ((readl(info->ide_addr + info->fifo_status_reg) >> 28) == 0)

would be neater to have 
      void __iomem *fifo_reg = info->ide_addr + info->fifo_status_reg
      ...

      while(...) {
      		 if (readl(fifo_reg) >> 28) == 0)
	 ...

> +			return 0;
> +	}
> +	return -EBUSY;
> +}

[snip]

> +/*
> + * pata_s3c_data_xfer - Transfer data by PIO
> + */
> +unsigned int pata_s3c_data_xfer(struct ata_device *dev, unsigned char *buf,
> +				unsigned int buflen, int rw)
> +{
> +	struct ata_port *ap = dev->link->ap;
> +	struct s3c_ide_info *info = ap->host->private_data;
> +	void __iomem *data_addr = ap->ioaddr.data_addr;
> +	unsigned int words = buflen >> 1, i;
> +	u16 *data_ptr = (u16 *)buf;

note, is there any chance of being passed a number of bytes? if so
should we at least WARN_ON(buflen & 1) and return an error?

> +	if (rw == READ)
> +		for (i = 0; i < words; i++, data_ptr++) {
> +			wait_for_host_ready(info);
> +			*data_ptr = readw(data_addr);
> +			wait_for_host_ready(info);
> +			*data_ptr = readw(info->ide_addr
> +					+ S3C_ATA_PIO_RDATA);
> +		}
> +	else
> +		for (i = 0; i < words; i++, data_ptr++) {
> +			wait_for_host_ready(info);
> +			writel(*data_ptr, data_addr);
> +		}
> +
> +	return words << 1;
> +}
> +
> +/*
> + * pata_s3c_dev_select - Select device on ATA bus
> + */
> +static void pata_s3c_dev_select(struct ata_port *ap, unsigned int device)
> +{
> +	u8 tmp;
> +
> +	if (device == 0)
> +		tmp = ATA_DEVICE_OBS;
> +	else
> +		tmp = ATA_DEVICE_OBS | ATA_DEV1;

you could have done
    u8 tmp = ATA_DEVICE_OBS;

    if (device != 0)
	tmp |= ATA_DEV1

> +	ata_outb(ap->host, tmp, ap->ioaddr.device_addr);
> +	ata_sff_pause(ap);
> +}
> +

[snip]

> +static void pata_s3c_enable(void *s3c_ide_regbase, u8 state)
  state would be better as a bool or a natural int.
> +{
> +	u32 temp = readl(s3c_ide_regbase + S3C_ATA_CTRL);
> +	temp = state ? (temp | 1) : (temp & ~1);
> +	writel(temp, s3c_ide_regbase + S3C_ATA_CTRL);
> +}
> +
> +static irqreturn_t pata_s3c_irq(int irq, void *dev_instance)
> +{
> +	struct ata_host *host = dev_instance;
> +	struct s3c_ide_info *info = host->private_data;
> +	u32 reg;
> +
> +	reg = readl(info->ide_addr + S3C_ATA_IRQ);
> +	writel(reg, info->ide_addr + S3C_ATA_IRQ);

no decoding of the interrupt cause?

> +	return ata_sff_interrupt(irq, dev_instance);
> +}

> +static int __devexit pata_s3c_remove(struct platform_device *pdev)
> +{
> +	struct ata_host *host = platform_get_drvdata(pdev);
> +	struct s3c_ide_info *info;
> +	struct resource *res;

> +
> +	if (!host)
> +		return 0;

don't think this check is really necessary.

> +	info = host->private_data;
> +
> +	ata_host_detach(host);
> +
> +	clk_disable(info->clk);
> +	clk_put(info->clk);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(res->start, resource_size(res));
> +	kfree(info);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int pata_s3c_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ata_host *host = platform_get_drvdata(pdev);
> +	pm_message_t state = PMSG_SUSPEND;
> +
> +	if (host)
> +		return ata_host_suspend(host, state);

again, don't think you'l lget called here if you didn't sucessfully bind.

> +	else
> +		return 0;
> +}
> +
> +static int pata_s3c_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ata_host *host = platform_get_drvdata(pdev);
> +	struct s3c_ide_platdata *pdata = pdev->dev.platform_data;
> +	struct s3c_ide_info *info;
> +
> +	info = host->private_data;
> +
> +	if (host) {
> +		pata_s3c_hwinit(info, pdata);
> +		ata_host_resume(host);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops pata_s3c_pm_ops = {
> +	.suspend	= pata_s3c_suspend,
> +	.resume		= pata_s3c_resume,
> +};

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

