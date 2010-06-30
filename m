From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v5] libata: pata_samsung: Add Samsung PATA controller driver
Date: Wed, 30 Jun 2010 19:39:25 +0900
Message-ID: <016f01cb1840$850c4ae0$8f24e0a0$%kim@samsung.com>
References: <1277809518-1122-1-git-send-email-kgene.kim@samsung.com>
 <4C2A3C62.4090101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:18718 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab0F3KjY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jun 2010 06:39:24 -0400
In-reply-to: <4C2A3C62.4090101@gmail.com>
Content-language: ko
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Maurus Cuelenaere' <mcuelenaere@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, ben-linux@fluff.org, jgarzik@redhat.com, sshtylyov@mvista.com, 'Abhilash Kesavan' <a.kesavan@samsung.com>

Maurus Cuelenaere wrote:
> 
Hi Maurus :-)

>  Op 29-06-10 13:05, Kukjin Kim schreef:
> > From: Abhilash Kesavan <a.kesavan@samsung.com>
> >
> > Adds support for the Samsung PATA controller. This driver is based on the
> > Libata subsystem and references the earlier patches sent for IDE subsystem.
> >
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: Ben Dooks <ben-linux@fluff.org>
> > ---
> >  drivers/ata/Kconfig           |    9 +
> >  drivers/ata/Makefile          |    1 +
> >  drivers/ata/pata_samsung_cf.c |  728
> +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 738 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/ata/pata_samsung_cf.c
> >
> > diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> > index 73f8833..51e28e7 100644
> > --- a/drivers/ata/Kconfig
> > +++ b/drivers/ata/Kconfig
> > @@ -796,6 +796,15 @@ config PATA_RZ1000
> >
> >  	  If unsure, say N.
> >
> > +config PATA_SAMSUNG_CF
> > +	tristate "Samsung SoC PATA support"
> > +	depends on SAMSUNG_DEV_IDE
> > +	help
> > +	  This option enables basic support for Samsung's S3C/S5P board
> > +	  PATA controllers via the new ATA layer
> > +
> > +	  If unsure, say N.
> > +
> >  config PATA_WINBOND_VLB
> >  	tristate "Winbond W83759A VLB PATA support (Experimental)"
> >  	depends on ISA && EXPERIMENTAL
> > diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
> > index 7ef89d7..9576776 100644
> > --- a/drivers/ata/Makefile
> > +++ b/drivers/ata/Makefile
> > @@ -87,6 +87,7 @@ obj-$(CONFIG_PATA_OF_PLATFORM)	+=
> pata_of_platform.o
> >  obj-$(CONFIG_PATA_QDI)		+= pata_qdi.o
> >  obj-$(CONFIG_PATA_RB532)	+= pata_rb532_cf.o
> >  obj-$(CONFIG_PATA_RZ1000)	+= pata_rz1000.o
> > +obj-$(CONFIG_PATA_SAMSUNG_CF)	+= pata_samsung_cf.o
> >  obj-$(CONFIG_PATA_WINBOND_VLB)	+= pata_winbond.o
> >
> >  # Should be last but two libata driver
> > diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
> > new file mode 100644
> > index 0000000..26b96c3
> > --- /dev/null
> > +++ b/drivers/ata/pata_samsung_cf.c
> > @@ -0,0 +1,728 @@
> > +/*
> > + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com
> > + *
> > + * PATA driver for Samsung SoCs.
> > + * Supports CF Interface in True IDE mode. Currently only PIO mode has been
> > + * implemented; UDMA support has to be added.
> > + *
> > + * Based on:
> > + *	PATA driver for AT91SAM9260 Static Memory Controller
> > + *	PATA driver for Toshiba SCC controller
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
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
> > +#define DRV_NAME "pata_samsung_cf"
> > +#define DRV_VERSION "0.1"
> > +
> > +enum s3c_cpu_type {
> > +	TYPE_S3C64XX,
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
> > +static void pata_s3c_set_endian(void __iomem *s3c_ide_regbase, u8 mode)
> > +{
> > +	u32 reg = readl(s3c_ide_regbase + S3C_ATA_CFG);
> > +	reg = mode ? (reg & ~S3C_ATA_CFG_SWAP) : (reg |
> S3C_ATA_CFG_SWAP);
> > +	writel(reg, s3c_ide_regbase + S3C_ATA_CFG);
> > +}
> > +
> > +static void pata_s3c_cfg_mode(void __iomem *s3c_ide_sfrbase)
> > +{
> > +	/* Select true-ide as the internal operating mode */
> > +	writel(readl(s3c_ide_sfrbase + S3C_CFATA_MUX) |
> S3C_CFATA_MUX_TRUEIDE,
> > +		s3c_ide_sfrbase + S3C_CFATA_MUX);
> > +}
> > +
> > +static unsigned long
> > +pata_s3c_setup_timing(struct s3c_ide_info *info, const struct ata_timing *ata)
> > +{
> > +	int t1 = ata->setup;
> > +	int t2 = ata->act8b;
> > +	int t2i = ata->rec8b;
> > +	ulong piotime;
> > +
> > +	piotime = ((t2i & 0xff) << 12) | ((t2 & 0xff) << 4) | (t1 & 0xf);
> > +
> > +	return piotime;
> > +}
> > +
> > +static void pata_s3c_set_piomode(struct ata_port *ap, struct ata_device *adev)
> > +{
> > +	struct s3c_ide_info *info = ap->host->private_data;
> > +	struct ata_timing timing;
> > +	int cycle_time;
> > +	ulong ata_cfg = readl(info->ide_addr + S3C_ATA_CFG);
> > +	ulong piotime;
> > +
> > +	/* Enables IORDY if mode requires it */
> > +	if (ata_pio_need_iordy(adev))
> > +		ata_cfg |= S3C_ATA_CFG_IORDYEN;
> > +	else
> > +		ata_cfg &= ~S3C_ATA_CFG_IORDYEN;
> > +
> > +	cycle_time = (int)(1000000000UL / clk_get_rate(info->clk));
> > +
> > +	ata_timing_compute(adev, adev->pio_mode, &timing,
> > +					cycle_time * 1000, 0);
> > +
> > +	piotime = pata_s3c_setup_timing(info, &timing);
> > +
> > +	writel(ata_cfg, info->ide_addr + S3C_ATA_CFG);
> > +	writel(piotime, info->ide_addr + S3C_ATA_PIO_TIME);
> > +}
> > +
> > +/*
> > + * Waits until the IDE controller is able to perform next read/write
> > + * operation to the disk. Needed for 64XX series boards only.
> > + */
> > +static int wait_for_host_ready(struct s3c_ide_info *info)
> > +{
> > +	ulong timeout;
> > +	void __iomem *fifo_reg = info->ide_addr + info->fifo_status_reg;
> > +
> 
> Shouldn't this have an if (type != S3C64XX) return 0; ?
> 
Actually, wait_for_host_ready() is called only by pata_s3c_port_ops methods which applies specifically to s3c64xx.

> > +	/* wait for maximum of 20 msec */
> > +	timeout = jiffies + msecs_to_jiffies(20);
> > +	while (time_before(jiffies, timeout)) {
> > +		if ((readl(fifo_reg) >> 28) == 0)
> > +			return 0;
> > +	}
> > +	return -EBUSY;
> > +}
> 
> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

