From: Ryan Mallon <rmallon@gmail.com>
Subject: Re: [PATCH 1/3] PATA host controller driver for ep93xx
Date: Fri, 30 Mar 2012 09:21:12 +1100
Message-ID: <4F74E058.3010607@gmail.com>
References: <4F7418E7.4060500@metasoft.pl> <4F741AB1.4000107@metasoft.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51249 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759407Ab2C2WVT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Mar 2012 18:21:19 -0400
Received: by pbcun15 with SMTP id un15so713706pbc.19
        for <linux-ide@vger.kernel.org>; Thu, 29 Mar 2012 15:21:18 -0700 (PDT)
In-Reply-To: <4F741AB1.4000107@metasoft.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rafal Prylowski <prylowski@metasoft.pl>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, hsweeten@visionengravers.com, ryan@bluewatersys.com, sshtylyov@ru.montavista.com, joao.ramos@inov.pt, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 29/03/12 19:17, Rafal Prylowski wrote:

> Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
> Cc: Joao Ramos <joao.ramos@inov.pt>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> Cc: Sergei Shtylyov <sshtylyov@ru.montavista.com>
> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Hi Rafal,

A few style comments below.

~Ryan

> ---
>  drivers/ata/Kconfig       |    9
>  drivers/ata/Makefile      |    1
>  drivers/ata/pata_ep93xx.c |  949 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 959 insertions(+)
> 
> Index: linux-2.6/drivers/ata/pata_ep93xx.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/drivers/ata/pata_ep93xx.c
> @@ -0,0 +1,949 @@
> +/*
> + * EP93XX PATA controller driver.
> + *
> + * Copyright (c) 2012, Metasoft s.c.
> + *	Rafal Prylowski <prylowski@metasoft.pl>
> + *
> + * Based on pata_scc.c, pata_icside.c and on earlier version of EP93XX
> + * PATA driver by Lennert Buytenhek and Alessandro Zummo.
> + * Read/Write timings, resource management and other improvements
> + * from driver by Joao Ramos and Bartlomiej Zolnierkiewicz.
> + * DMA engine support based on spi-ep93xx.c by Mika Westerberg.
> + *
> + * Original copyrights:
> + *
> + * Support for Cirrus Logic's EP93xx (EP9312, EP9315) CPUs
> + * PATA host controller driver.
> + *
> + * Copyright (c) 2009, Bartlomiej Zolnierkiewicz
> + *
> + * Heavily based on the ep93xx-ide.c driver:
> + *
> + * Copyright (c) 2009, Joao Ramos <joao.ramos@inov.pt>
> + *		      INESC Inovacao (INOV)
> + *
> + * EP93XX PATA controller driver.
> + * Copyright (C) 2007 Lennert Buytenhek <buytenh@wantstofly.org>
> + *
> + * An ATA driver for the Cirrus Logic EP93xx PATA controller.
> + *
> + * Based on an earlier version by Alessandro Zummo, which is:
> + *   Copyright (C) 2006 Tower Technologies
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/blkdev.h>
> +#include <scsi/scsi_host.h>
> +#include <linux/ata.h>
> +#include <linux/libata.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> +
> +#include <mach/dma.h>
> +#include <asm/mach-types.h>
> +#include <mach/ep93xx-regs.h>


ep93xx-regs.h is now deprecated for inclusion in drivers :-).

> +#include <mach/platform.h>
> +
> +#define DRV_NAME	"ep93xx-ide"
> +#define DRV_VERSION	"1.0"
> +
> +enum {
> +	/* IDE Control Register */
> +	IDECtrl				= 0x00,


Please don't use horrible camel case names.

> +	IDECtrl_CS0n			= (1 << 0),
> +	IDECtrl_CS1n			= (1 << 1),
> +	IDECtrl_DIORn			= (1 << 5),
> +	IDECtrl_DIOWn			= (1 << 6),
> +	IDECtrl_INTRQ			= (1 << 9),
> +	IDECtrl_IORDY			= (1 << 10),
> +
> +	/* IDE Configuration Register */
> +	IDECfg				= 0x04,
> +	IDECfg_IDEEN			= (1 << 0),


Why is this one enum, when you have multiple constants which define to
the same value? This probably makes more sense as a set of defines.

> +	IDECfg_PIO			= (1 << 1),
> +	IDECfg_MDMA			= (1 << 2),
> +	IDECfg_UDMA			= (1 << 3),
> +	IDECfg_MODE_SHIFT		= 4,
> +	IDECfg_MODE_MASK		= (0xf << 4),
> +	IDECfg_WST_SHIFT		= 8,
> +	IDECfg_WST_MASK			= (0x3 << 8),
> +
> +	/* MDMA Operation Register */
> +	IDEMDMAOp			= 0x08,
> +
> +	/* UDMA Operation Register */
> +	IDEUDMAOp			= 0x0c,
> +	IDEUDMAOp_UEN			= (1 << 0),
> +	IDEUDMAOp_RWOP			= (1 << 1),
> +
> +	/* PIO/MDMA/UDMA Data Registers */
> +	IDEDataOut			= 0x10,
> +	IDEDataIn			= 0x14,
> +	IDEMDMADataOut			= 0x18,
> +	IDEMDMADataIn			= 0x1c,
> +	IDEUDMADataOut			= 0x20,
> +	IDEUDMADataIn			= 0x24,
> +
> +	/* UDMA Status Register */
> +	IDEUDMASts			= 0x28,
> +	IDEUDMASts_DMAide		= (1 << 16),
> +	IDEUDMASts_INTide		= (1 << 17),
> +	IDEUDMASts_SBUSY		= (1 << 18),
> +	IDEUDMASts_NDO			= (1 << 24),
> +	IDEUDMASts_NDI			= (1 << 25),
> +	IDEUDMASts_N4X			= (1 << 26),
> +
> +	/* UDMA Debug Status Register */
> +	IDEUDMADebug			= 0x2c,
> +};
> +
> +struct ep93xx_pata_data /* private_data in ata_host */
> +{
> +	void __iomem *ide_base;
> +	const struct ata_timing *t, *cmd_t;


Nitpick: Usually each field in a structure definition is on its own line.

> +	bool iordy;
> +
> +	unsigned long udma_in_phys;
> +	unsigned long udma_out_phys;
> +
> +	struct dma_chan *dma_rx_channel;
> +	struct ep93xx_dma_data dma_rx_data;
> +	struct dma_chan *dma_tx_channel;
> +	struct ep93xx_dma_data dma_tx_data;
> +};
> +
> +static void ep93xx_pata_clear_regs(void __iomem *base)
> +{
> +	writel(IDECtrl_CS0n | IDECtrl_CS1n | IDECtrl_DIORn |
> +		IDECtrl_DIOWn, base + IDECtrl);
> +
> +	writel(0, base + IDECfg);


Might be worth having ep93xx_pata_write/read functions so you don't have
to do the base + thing everywhere. Passing struct ep93xx_pata_data to
each function would be more typical also.

> +	writel(0, base + IDEMDMAOp);
> +	writel(0, base + IDEUDMAOp);
> +	writel(0, base + IDEDataOut);
> +	writel(0, base + IDEDataIn);
> +	writel(0, base + IDEMDMADataOut);
> +	writel(0, base + IDEMDMADataIn);
> +	writel(0, base + IDEUDMADataOut);
> +	writel(0, base + IDEUDMADataIn);
> +	writel(0, base + IDEUDMADebug);
> +}
> +
> +static inline int ep93xx_pata_check_iordy(void __iomem *base)
> +{
> +	return (readl(base + IDECtrl) & IDECtrl_IORDY) ? 1 : 0;


You can use !! here rather than ? 1 : 0.

> +}
> +
> +/*
> + * According to EP93xx User's Guide, WST field of IDECfg specifies number
> + * of HCLK cycles to hold the data bus after a PIO write operation.
> + * It should be programmed to guarantee following delays:
> + *
> + * PIO Mode   [ns]
> + * 0          30
> + * 1          20
> + * 2          15
> + * 3          10
> + * 4          5
> + *
> + * Maximum possible value for HCLK is 100MHz.
> + */
> +static inline int ep93xx_pata_get_wst(int pio_mode)
> +{
> +	return (pio_mode == 0 ? 3 : pio_mode < 3 ? 2 : 1)
> +		<< IDECfg_WST_SHIFT;


Ick, thats really hard to read. What's wrong with:

  unsigned val = 1;

  if (pio_mode == 0)
  	val = 3;
  else if (pio_mode < 3)
  	val = 2;
  else
	val = 1;

  return val << IDECFG_WST_SHIFT;

> +}
> +
> +static inline void ep93xx_pata_enable_pio(void __iomem *base, int pio_mode)


Don't bother marking functions inline. The compiler will do it for you.

> +{
> +	writel(IDECfg_IDEEN | IDECfg_PIO |
> +		ep93xx_pata_get_wst(pio_mode) |
> +		(pio_mode << IDECfg_MODE_SHIFT), base + IDECfg);
> +}
> +
> +static u16 ep93xx_pata_read(struct ep93xx_pata_data *drv_data,
> +			    void *addr_io,
> +			    const struct ata_timing *t)
> +{
> +	unsigned long addr = (unsigned long) addr_io & 0x1f;
> +	void __iomem *base = drv_data->ide_base;
> +	u16 ret;
> +
> +	writel(IDECtrl_DIOWn | IDECtrl_DIORn | addr, base + IDECtrl);
> +	ndelay(t->setup);
> +	writel(IDECtrl_DIOWn | addr, base + IDECtrl);
> +	ndelay(t->act8b);
> +	if (drv_data->iordy) {
> +		/* min. 1s timeout (at cpu cycle = 5ns) */
> +		unsigned int timeout = 200000;


Probably be better to use jiffies, msecs_to_jiffies and
time_before/after rather than relying on a particular clock speed.

> +		while (!ep93xx_pata_check_iordy(base) && --timeout)
> +			cpu_relax();
> +	}
> +	/*
> +	 * The IDEDataIn register is loaded from the DD pins at the positive
> +	 * edge of the DIORn signal. (EP93xx UG p27-14)
> +	 */
> +	writel(IDECtrl_DIOWn | IDECtrl_DIORn | addr, base + IDECtrl);
> +	ret = readl(base + IDEDataIn);
> +	ndelay(t->cyc8b - t->act8b - t->setup);
> +	return ret;
> +}
> +
> +static void ep93xx_pata_write(struct ep93xx_pata_data *drv_data,
> +			      u16 value, void *addr_io,
> +			      const struct ata_timing *t)
> +{
> +	unsigned long addr = (unsigned long) addr_io & 0x1f;
> +	void __iomem *base = drv_data->ide_base;
> +
> +	writel(IDECtrl_DIOWn | IDECtrl_DIORn | addr, base + IDECtrl);
> +	ndelay(t->setup);
> +	/*
> +	 * Value from IDEDataOut register is driven onto the DD pins when
> +	 * DIOWn is low. (EP93xx UG p27-13)
> +	 */
> +	writel(value, base + IDEDataOut);
> +	writel(IDECtrl_DIORn | addr, base + IDECtrl);
> +	ndelay(t->act8b);
> +	if (drv_data->iordy) {
> +		/* min. 1s timeout */
> +		unsigned int timeout = 200000;
> +		while (!ep93xx_pata_check_iordy(base) && --timeout)
> +			cpu_relax();


This loop is used more than once. Wrap it up in a function maybe.

> +	}
> +	writel(IDECtrl_DIOWn | IDECtrl_DIORn | addr, base + IDECtrl);
> +	ndelay(t->cyc8b - t->act8b - t->setup);
> +}
> +
> +static void ep93xx_pata_set_piomode(struct ata_port *ap,
> +				    struct ata_device *adev)
> +{
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	struct ata_device *pair = ata_dev_pair(adev);
> +
> +	drv_data->t = ata_timing_find_mode(adev->pio_mode);
> +	drv_data->cmd_t = drv_data->t;
> +	drv_data->iordy = ata_pio_need_iordy(adev);
> +
> +	if (pair && pair->pio_mode < adev->pio_mode)
> +		drv_data->cmd_t = ata_timing_find_mode(pair->pio_mode);
> +
> +	ep93xx_pata_enable_pio(drv_data->ide_base,
> +			       adev->pio_mode - XFER_PIO_0);
> +}
> +
> +static u8 ep93xx_pata_check_status(struct ata_port *ap)
> +{
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	return ep93xx_pata_read(drv_data, ap->ioaddr.status_addr,
> +				drv_data->cmd_t);
> +}
> +
> +static u8 ep93xx_pata_check_altstatus(struct ata_port *ap)
> +{
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	return ep93xx_pata_read(drv_data, ap->ioaddr.altstatus_addr,
> +				drv_data->cmd_t);
> +}
> +
> +static void ep93xx_pata_tf_load(struct ata_port *ap,
> +				const struct ata_taskfile *tf)
> +{
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	const struct ata_timing *t = drv_data->cmd_t;
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
> +
> +	if (tf->ctl != ap->last_ctl) {
> +		ep93xx_pata_write(drv_data, tf->ctl, ioaddr->ctl_addr, t);
> +		ap->last_ctl = tf->ctl;
> +		ata_wait_idle(ap);
> +	}
> +
> +	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
> +		ep93xx_pata_write(drv_data, tf->hob_feature,
> +			ioaddr->feature_addr, t);
> +		ep93xx_pata_write(drv_data, tf->hob_nsect,
> +			ioaddr->nsect_addr, t);
> +		ep93xx_pata_write(drv_data, tf->hob_lbal,
> +			ioaddr->lbal_addr, t);
> +		ep93xx_pata_write(drv_data, tf->hob_lbam,
> +			ioaddr->lbam_addr, t);
> +		ep93xx_pata_write(drv_data, tf->hob_lbah,
> +			ioaddr->lbah_addr, t);
> +		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
> +			tf->hob_feature, tf->hob_nsect, tf->hob_lbal,
> +			tf->hob_lbam, tf->hob_lbah);


  dev_vdbg(ap->host->dev, ...)

? Same elsewhere.

> +	}
> +
> +	if (is_addr) {
> +		ep93xx_pata_write(drv_data, tf->feature,
> +			ioaddr->feature_addr, t);
> +		ep93xx_pata_write(drv_data, tf->nsect, ioaddr->nsect_addr, t);
> +		ep93xx_pata_write(drv_data, tf->lbal, ioaddr->lbal_addr, t);
> +		ep93xx_pata_write(drv_data, tf->lbam, ioaddr->lbam_addr, t);
> +		ep93xx_pata_write(drv_data, tf->lbah, ioaddr->lbah_addr, t);
> +		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
> +			tf->feature, tf->nsect, tf->lbal, tf->lbam, tf->lbah);
> +	}
> +
> +	if (tf->flags & ATA_TFLAG_DEVICE) {
> +		ep93xx_pata_write(drv_data, tf->device, ioaddr->device_addr, t);
> +		VPRINTK("device 0x%X\n", tf->device);
> +	}
> +
> +	ata_wait_idle(ap);
> +}
> +
> +static void ep93xx_pata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
> +{
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	const struct ata_timing *t = drv_data->cmd_t;
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +
> +	tf->command = ep93xx_pata_check_status(ap);
> +	tf->feature = ep93xx_pata_read(drv_data, ioaddr->feature_addr, t);
> +	tf->nsect = ep93xx_pata_read(drv_data, ioaddr->nsect_addr, t);
> +	tf->lbal = ep93xx_pata_read(drv_data, ioaddr->lbal_addr, t);
> +	tf->lbam = ep93xx_pata_read(drv_data, ioaddr->lbam_addr, t);
> +	tf->lbah = ep93xx_pata_read(drv_data, ioaddr->lbah_addr, t);
> +	tf->device = ep93xx_pata_read(drv_data, ioaddr->device_addr, t);
> +
> +	if (tf->flags & ATA_TFLAG_LBA48) {
> +		ep93xx_pata_write(drv_data, tf->ctl | ATA_HOB,
> +			ioaddr->ctl_addr, t);
> +		tf->hob_feature = ep93xx_pata_read(drv_data,
> +			ioaddr->feature_addr, t);
> +		tf->hob_nsect = ep93xx_pata_read(drv_data,
> +			ioaddr->nsect_addr, t);
> +		tf->hob_lbal = ep93xx_pata_read(drv_data,
> +			ioaddr->lbal_addr, t);
> +		tf->hob_lbam = ep93xx_pata_read(drv_data,
> +			ioaddr->lbam_addr, t);
> +		tf->hob_lbah = ep93xx_pata_read(drv_data,
> +			ioaddr->lbah_addr, t);
> +		ep93xx_pata_write(drv_data, tf->ctl, ioaddr->ctl_addr, t);
> +		ap->last_ctl = tf->ctl;
> +	}
> +}
> +
> +static void ep93xx_pata_exec_command(struct ata_port *ap,
> +				     const struct ata_taskfile *tf)
> +{
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);


  dev_dbg(ap->host->dev, ...);

> +
> +	ep93xx_pata_write(drv_data, tf->command,
> +			  ap->ioaddr.command_addr, drv_data->cmd_t);
> +	ata_sff_pause(ap);
> +}
> +
> +static void ep93xx_pata_dev_select(struct ata_port *ap, unsigned int device)
> +{
> +	u8 tmp;
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +
> +	if (device == 0)
> +		tmp = ATA_DEVICE_OBS;
> +	else
> +		tmp = ATA_DEVICE_OBS | ATA_DEV1;


This could be:

  u8 tmp = ATA_DEVICE_OBS;

  ...

  if (device != 0)
  	tmp |= ATA_DEV1;

> +
> +	ep93xx_pata_write(drv_data, tmp, ap->ioaddr.device_addr,
> +			  drv_data->cmd_t);
> +	ata_sff_pause(ap);	/* needed; also flushes, for mmio */
> +}
> +
> +static void ep93xx_pata_set_devctl(struct ata_port *ap, u8 ctl)
> +{
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	ep93xx_pata_write(drv_data, ctl, ap->ioaddr.ctl_addr,
> +			  drv_data->cmd_t);
> +}
> +
> +unsigned int ep93xx_pata_data_xfer(struct ata_device *adev, unsigned char *buf,
> +				   unsigned int buflen, int rw)
> +{
> +	struct ata_port *ap = adev->link->ap;
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	const struct ata_timing *t = drv_data->t;
> +	void *data_addr = ap->ioaddr.data_addr;
> +	u16 *data = (u16 *) buf;


No space after the cast.

> +	unsigned int words = buflen >> 1;
> +
> +	/* Transfer multiple of 2 bytes */
> +	if (rw == READ)
> +		while (words--)
> +			*data++ = cpu_to_le16(
> +				ep93xx_pata_read(drv_data, data_addr, t));
> +	else
> +		while (words--)
> +			ep93xx_pata_write(drv_data, le16_to_cpu(*data++),
> +				data_addr, t);


This would would be a bit simpler as:

  while (words--) {
  	if (rw == READ)
		*data++ = ...;
	else
		ep93xx_pata_write(...);
  }

> +
> +	/* Transfer trailing 1 byte, if any. */
> +	if (unlikely(buflen & 0x01)) {
> +		unsigned char pad[2] = { };

> +

> +		buf += buflen - 1;
> +
> +		if (rw == READ) {
> +			*pad = cpu_to_le16(
> +				ep93xx_pata_read(drv_data, data_addr, t));
> +			*buf = pad[0];
> +		} else {
> +			pad[0] = *buf;
> +			ep93xx_pata_write(drv_data, le16_to_cpu(*pad),
> +					  data_addr, t);
> +		}
> +		words++;
> +	}
> +
> +	return words << 1;
> +}
> +
> +static unsigned int ep93xx_pata_dev_check(struct ata_port *ap,
> +					  unsigned int device)
> +{
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	const struct ata_timing *t = drv_data->cmd_t;
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +	u8 nsect, lbal;
> +
> +	ap->ops->sff_dev_select(ap, device);
> +
> +	ep93xx_pata_write(drv_data, 0x55, ioaddr->nsect_addr, t);
> +	ep93xx_pata_write(drv_data, 0xaa, ioaddr->lbal_addr, t);
> +
> +	ep93xx_pata_write(drv_data, 0xaa, ioaddr->nsect_addr, t);
> +	ep93xx_pata_write(drv_data, 0x55, ioaddr->lbal_addr, t);
> +
> +	ep93xx_pata_write(drv_data, 0x55, ioaddr->nsect_addr, t);
> +	ep93xx_pata_write(drv_data, 0xaa, ioaddr->lbal_addr, t);
> +
> +	nsect = ep93xx_pata_read(drv_data, ioaddr->nsect_addr, t);
> +	lbal = ep93xx_pata_read(drv_data, ioaddr->lbal_addr, t);
> +
> +	if ((nsect == 0x55) && (lbal == 0xaa))
> +		return 1;	/* we found a device */
> +
> +	return 0;		/* nothing found */


This function should return a bool. Maybe also change the function name
to ep93xx_pata_device_is_present, which more accurately reflects what
this does. Then you can drop the comments above too.

> +}
> +
> +int ep93xx_pata_wait_after_reset(struct ata_link *link, unsigned int devmask,
> +				 unsigned long deadline)
> +{
> +	struct ata_port *ap = link->ap;
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	const struct ata_timing *t = drv_data->cmd_t;
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +	unsigned int dev0 = devmask & (1 << 0);
> +	unsigned int dev1 = devmask & (1 << 1);
> +	int rc, ret = 0;
> +
> +	ata_msleep(ap, ATA_WAIT_AFTER_RESET);
> +
> +	/* always check readiness of the master device */
> +	rc = ata_sff_wait_ready(link, deadline);
> +	/* -ENODEV means the odd clown forgot the D7 pulldown resistor
> +	 * and TF status is 0xff, bail out on it too.
> +	 */
> +	if (rc)
> +		return rc;
> +
> +	/* if device 1 was found in ata_devchk, wait for register
> +	 * access briefly, then wait for BSY to clear.
> +	 */


  /*
   * Mutli-line comment style
   * looks like this.
   */

> +	if (dev1) {
> +		int i;
> +
> +		ap->ops->sff_dev_select(ap, 1);
> +
> +		/* Wait for register access.  Some ATAPI devices fail
> +		 * to set nsect/lbal after reset, so don't waste too
> +		 * much time on it.  We're gonna wait for !BSY anyway.
> +		 */
> +		for (i = 0; i < 2; i++) {
> +			u8 nsect, lbal;
> +
> +			nsect = ep93xx_pata_read(drv_data,
> +				ioaddr->nsect_addr, t);
> +			lbal = ep93xx_pata_read(drv_data,
> +				ioaddr->lbal_addr, t);
> +			if (nsect == 1 && lbal == 1)
> +				break;
> +			msleep(50);	/* give drive a breather */
> +		}
> +
> +		rc = ata_sff_wait_ready(link, deadline);
> +		if (rc) {
> +			if (rc != -ENODEV)
> +				return rc;
> +			ret = rc;
> +		}
> +	}
> +	/* is all this really necessary? */
> +	ap->ops->sff_dev_select(ap, 0);
> +	if (dev1)
> +		ap->ops->sff_dev_select(ap, 1);
> +	if (dev0)
> +		ap->ops->sff_dev_select(ap, 0);
> +
> +	return ret;
> +}
> +
> +static int ep93xx_pata_bus_softreset(struct ata_port *ap, unsigned int devmask,
> +				     unsigned long deadline)
> +{
> +	struct ata_ioports *ioaddr = &ap->ioaddr;
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	const struct ata_timing *t = drv_data->cmd_t;
> +
> +	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
> +
> +	ep93xx_pata_write(drv_data, ap->ctl, ioaddr->ctl_addr, t);
> +	udelay(20);		/* FIXME: flush */
> +	ep93xx_pata_write(drv_data, ap->ctl | ATA_SRST, ioaddr->ctl_addr, t);
> +	udelay(20);		/* FIXME: flush */
> +	ep93xx_pata_write(drv_data, ap->ctl, ioaddr->ctl_addr, t);
> +	ap->last_ctl = ap->ctl;
> +
> +	return ep93xx_pata_wait_after_reset(&ap->link, devmask, deadline);
> +}
> +
> +static bool ep93xx_pata_dma_filter(struct dma_chan *chan, void *filter_param)
> +{
> +	if (ep93xx_dma_chan_is_m2p(chan))
> +		return false;
> +
> +	chan->private = filter_param;
> +	return true;
> +}
> +
> +static int ep93xx_pata_dma_init(struct ep93xx_pata_data *drv_data)
> +{
> +	dma_cap_mask_t mask;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	/*
> +	 * Request two channels for IDE. Another possibility would be
> +	 * to request only one channel, and reprogram it's direction at
> +	 * start of new transfer.
> +	 */
> +	drv_data->dma_rx_data.port = EP93XX_DMA_IDE;
> +	drv_data->dma_rx_data.direction = DMA_FROM_DEVICE;
> +	drv_data->dma_rx_data.name = "ep93xx-pata-rx";
> +	drv_data->dma_tx_data.port = EP93XX_DMA_IDE;
> +	drv_data->dma_tx_data.direction = DMA_TO_DEVICE;
> +	drv_data->dma_tx_data.name = "ep93xx-pata-tx";
> +	drv_data->dma_rx_channel = dma_request_channel(mask,
> +		ep93xx_pata_dma_filter, &drv_data->dma_rx_data);
> +	drv_data->dma_tx_channel = dma_request_channel(mask,
> +		ep93xx_pata_dma_filter, &drv_data->dma_tx_data);
> +	return drv_data->dma_rx_channel && drv_data->dma_tx_channel;
> +}
> +
> +static void ep93xx_pata_dma_start(struct ata_queued_cmd *qc)
> +{
> +	struct dma_async_tx_descriptor *txd;
> +	struct ep93xx_pata_data *drv_data = qc->ap->host->private_data;
> +	void __iomem *base = drv_data->ide_base;
> +	struct ata_device *adev = qc->dev;
> +	u32 v = qc->dma_dir == DMA_TO_DEVICE ? IDEUDMAOp_RWOP : 0;
> +	struct dma_chan *channel = qc->dma_dir == DMA_TO_DEVICE
> +		? drv_data->dma_tx_channel : drv_data->dma_rx_channel;
> +
> +	txd = channel->device->device_prep_slave_sg(channel, qc->sg,
> +		 qc->n_elem, qc->dma_dir, DMA_CTRL_ACK);
> +	if (!txd) {
> +		dev_err(qc->ap->dev, "failed to prepare slave for sg dma\n");
> +		BUG();


Don't BUG in drivers if you can possibly avoid it. Set an error state
and try to bail out gracefully.

> +	}
> +	txd->callback = NULL;
> +	txd->callback_param = NULL;
> +
> +	if (dmaengine_submit(txd) < 0) {
> +		dev_err(qc->ap->dev, "failed to submit dma transfer\n");
> +		BUG();
> +	}
> +	dma_async_issue_pending(channel);
> +
> +	/*
> +	 * When enabling UDMA operation, IDEUDMAOp register needs to be
> +	 * programmed in three step sequence:
> +	 * 1) set or clear the RWOP bit,
> +	 * 2) perform dummy read of the register,
> +	 * 3) set the UEN bit.
> +	 */
> +	writel(v, base + IDEUDMAOp);
> +	readl(base + IDEUDMAOp);
> +	writel(v | IDEUDMAOp_UEN, base + IDEUDMAOp);
> +
> +	writel(IDECfg_IDEEN | IDECfg_UDMA |
> +		((adev->xfer_mode - XFER_UDMA_0) << IDECfg_MODE_SHIFT),
> +		base + IDECfg);
> +}
> +
> +static void ep93xx_pata_dma_stop(struct ata_queued_cmd *qc)
> +{
> +	struct ep93xx_pata_data *drv_data = qc->ap->host->private_data;
> +	void __iomem *base = drv_data->ide_base;
> +
> +	/* terminate all dma transfers, if not yet finished */
> +	dmaengine_terminate_all(drv_data->dma_rx_channel);
> +	dmaengine_terminate_all(drv_data->dma_tx_channel);
> +
> +	/*
> +	 * To properly stop IDE-DMA, IDEUDMAOp register must to be cleared
> +	 * and IDECtrl register must be set to default value.
> +	 */
> +	writel(0, base + IDEUDMAOp);
> +	writel(readl(base + IDECtrl) | IDECtrl_DIOWn | IDECtrl_DIORn |
> +		IDECtrl_CS0n | IDECtrl_CS1n, base + IDECtrl);
> +
> +	ep93xx_pata_enable_pio(drv_data->ide_base,
> +		qc->dev->pio_mode - XFER_PIO_0);
> +
> +	ata_sff_dma_pause(qc->ap);
> +}
> +
> +static void ep93xx_pata_dma_setup(struct ata_queued_cmd *qc)
> +{
> +	struct dma_slave_config conf;
> +	struct ata_port *ap = qc->ap;
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	struct dma_chan *channel = qc->dma_dir == DMA_TO_DEVICE
> +		? drv_data->dma_tx_channel : drv_data->dma_rx_channel;
> +
> +	memset(&conf, 0, sizeof(conf));
> +	conf.direction = qc->dma_dir;
> +	if (qc->dma_dir == DMA_FROM_DEVICE) {
> +		conf.src_addr = drv_data->udma_in_phys;
> +		conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	} else {
> +		conf.dst_addr = drv_data->udma_out_phys;
> +		conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	}
> +	if (dmaengine_slave_config(channel, &conf)) {
> +		dev_err(qc->ap->dev, "failed to configure slave for sg dma\n");
> +		BUG();
> +	}
> +
> +	ap->ops->sff_exec_command(ap, &qc->tf);
> +}
> +
> +static u8 ep93xx_pata_dma_status(struct ata_port *ap)
> +{
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +	u32 val = readl(drv_data->ide_base + IDEUDMASts);
> +
> +	/*
> +	 * UDMA Status Register bits:
> +	 *
> +	 * DMAide - DMA request signal from UDMA state machine,
> +	 * INTide - INT line generated by UDMA because of errors in the
> +	 *          state machine,
> +	 * SBUSY - UDMA state machine busy, not in idle state,
> +	 * NDO   - error for data-out not completed,
> +	 * NDI   - error for data-in not completed,
> +	 * N4X   - error for data transferred not multiplies of four
> +	 *         32-bit words.
> +	 * (EP93xx UG p27-17)
> +	 */
> +	if (val & IDEUDMASts_NDO || val & IDEUDMASts_NDI ||
> +	    val & IDEUDMASts_N4X || val & IDEUDMASts_INTide)
> +		return ATA_DMA_ERR;
> +
> +	/* read INTRQ (INT[3]) pin input state */
> +	if (readl(drv_data->ide_base + IDECtrl) & IDECtrl_INTRQ)
> +		return ATA_DMA_INTR;
> +
> +	if (val & IDEUDMASts_SBUSY || val & IDEUDMASts_DMAide)
> +		return ATA_DMA_ACTIVE;
> +
> +	return 0;
> +}
> +
> +static int ep93xx_pata_softreset(struct ata_link *al, unsigned int *classes,
> +				 unsigned long deadline)
> +{
> +	struct ata_port *ap = al->ap;
> +	unsigned int slave_possible = ap->flags & ATA_FLAG_SLAVE_POSS;
> +	unsigned int devmask = 0;
> +	int rc;
> +	u8 err;
> +
> +	DPRINTK("ENTER\n");
> +
> +	/* determine if device 0/1 are present */
> +	if (ep93xx_pata_dev_check(ap, 0))
> +		devmask |= (1 << 0);
> +	if (slave_possible && ep93xx_pata_dev_check(ap, 1))
> +		devmask |= (1 << 1);
> +
> +	/* select device 0 again */
> +	ap->ops->sff_dev_select(al->ap, 0);
> +
> +	/* issue bus reset */
> +	DPRINTK("about to softreset, devmask=%x\n", devmask);
> +	rc = ep93xx_pata_bus_softreset(ap, devmask, deadline);
> +	/* if link is ocuppied, -ENODEV too is an error */
> +	if (rc && (rc != -ENODEV || sata_scr_valid(al))) {
> +		ata_link_printk(al, KERN_ERR, "SRST failed (errno=%d)\n",
> +				rc);
> +		return rc;
> +	}
> +
> +	/* determine by signature whether we have ATA or ATAPI devices */
> +	classes[0] = ata_sff_dev_classify(&al->device[0], devmask & (1 << 0),
> +					  &err);
> +	if (slave_possible && err != 0x81)
> +		classes[1] = ata_sff_dev_classify(&al->device[1],
> +						  devmask & (1 << 1), &err);
> +
> +	DPRINTK("EXIT, classes[0]=%u, [1]=%u\n", classes[0],
> +		classes[1]);
> +	return 0;
> +}
> +
> +void ep93xx_pata_drain_fifo(struct ata_queued_cmd *qc)
> +{
> +	int count;
> +	struct ata_port *ap;
> +	struct ep93xx_pata_data *drv_data;
> +
> +	/* We only need to flush incoming data when a command was running */
> +	if (qc == NULL || qc->dma_dir == DMA_TO_DEVICE)
> +		return;
> +
> +	ap = qc->ap;
> +	drv_data = ap->host->private_data;
> +	/* Drain up to 64K of data before we give up this recovery method */
> +	for (count = 0; (ap->ops->sff_check_status(ap) & ATA_DRQ)
> +		     && count < 65536; count += 2)
> +		ep93xx_pata_read(drv_data, ap->ioaddr.data_addr,
> +				 drv_data->cmd_t);
> +
> +	/* Can become DEBUG later */
> +	if (count)
> +		ata_port_printk(ap, KERN_DEBUG,
> +				"drained %d bytes to clear DRQ.\n", count);
> +
> +}
> +
> +static int ep93xx_pata_port_start(struct ata_port *ap)
> +{
> +	struct ep93xx_pata_data *drv_data = ap->host->private_data;
> +
> +	drv_data->cmd_t = ata_timing_find_mode(XFER_PIO_0);
> +	return 0;
> +}
> +
> +static struct scsi_host_template ep93xx_pata_sht = {
> +	ATA_BASE_SHT(DRV_NAME),
> +	/* ep93xx dma implementation limit */
> +	.sg_tablesize		= 32,
> +	/* ep93xx dma can't transfer 65536 bytes at once */
> +	.dma_boundary		= 0x7fff,
> +};
> +
> +static struct ata_port_operations ep93xx_pata_port_ops = {
> +	.inherits		= &ata_bmdma_port_ops,
> +
> +	.qc_prep		= ata_noop_qc_prep,
> +
> +	.softreset		= ep93xx_pata_softreset,
> +	.hardreset		= ATA_OP_NULL,
> +
> +	.sff_dev_select		= ep93xx_pata_dev_select,
> +	.sff_set_devctl		= ep93xx_pata_set_devctl,
> +	.sff_check_status	= ep93xx_pata_check_status,
> +	.sff_check_altstatus	= ep93xx_pata_check_altstatus,
> +	.sff_tf_load		= ep93xx_pata_tf_load,
> +	.sff_tf_read		= ep93xx_pata_tf_read,
> +	.sff_exec_command	= ep93xx_pata_exec_command,
> +	.sff_data_xfer		= ep93xx_pata_data_xfer,
> +	.sff_drain_fifo		= ep93xx_pata_drain_fifo,
> +	.sff_irq_clear		= ATA_OP_NULL,
> +
> +	.set_piomode		= ep93xx_pata_set_piomode,
> +
> +	.bmdma_setup		= ep93xx_pata_dma_setup,
> +	.bmdma_start		= ep93xx_pata_dma_start,
> +	.bmdma_stop		= ep93xx_pata_dma_stop,
> +	.bmdma_status		= ep93xx_pata_dma_status,
> +
> +	.cable_detect		= ata_cable_unknown,
> +	.port_start		= ep93xx_pata_port_start,
> +};
> +
> +static void ep93xx_pata_setup_port(struct ata_ioports *ioaddr)
> +{
> +	/*
> +	 * the device IDE register to be accessed is selected through
> +	 * IDECTRL register's specific bitfields 'DA', 'CS1n' and 'CS0n':
> +	 *   b4   b3   b2    b1     b0
> +	 *   A2   A1   A0   CS1n   CS0n
> +	 * the values filled in this structure allows the value to be directly
> +	 * ORed to the IDECTRL register, hence giving directly the A[2:0] and
> +	 * CS1n/CS0n values for each IDE register.
> +	 * The values correspond to the transformation:
> +	 *   ((real IDE address) << 2) | CS1n value << 1 | CS0n value
> +	 */
> +	ioaddr->cmd_addr	= (void __iomem *) 0 + 2; /* CS1 */
> +
> +	ioaddr->data_addr	= (void __iomem *) (ATA_REG_DATA << 2) + 2;
> +	ioaddr->error_addr	= (void __iomem *) (ATA_REG_ERR << 2) + 2;
> +	ioaddr->feature_addr	= (void __iomem *) (ATA_REG_FEATURE << 2) + 2;
> +	ioaddr->nsect_addr	= (void __iomem *) (ATA_REG_NSECT << 2) + 2;
> +	ioaddr->lbal_addr	= (void __iomem *) (ATA_REG_LBAL << 2) + 2;
> +	ioaddr->lbam_addr	= (void __iomem *) (ATA_REG_LBAM << 2) + 2;
> +	ioaddr->lbah_addr	= (void __iomem *) (ATA_REG_LBAH << 2) + 2;
> +	ioaddr->device_addr	= (void __iomem *) (ATA_REG_DEVICE << 2) + 2;
> +	ioaddr->status_addr	= (void __iomem *) (ATA_REG_STATUS << 2) + 2;
> +	ioaddr->command_addr	= (void __iomem *) (ATA_REG_CMD << 2) + 2;
> +
> +	ioaddr->altstatus_addr	= (void __iomem *) (0x06 << 2) + 1; /* CS0 */
> +	ioaddr->ctl_addr	= (void __iomem *) (0x06 << 2) + 1; /* CS0 */


Only a couple of other pata driver appears to do this horrible casting
mess. Other drivers appear to be using (devm_ioremap). Can we clean this up?

> +}
> +
> +static int __devinit ep93xx_pata_probe(struct platform_device *pdev)
> +{
> +	struct ep93xx_pata_data *drv_data;
> +	struct ata_host *host;
> +	struct ata_port *ap;
> +	unsigned int irq;
> +	struct resource *mem_res;
> +	void __iomem *ide_base;
> +
> +	/*if (readl(EP93XX_SYSCON_DEVCFG) & (EP93XX_SYSCON_DEVCFG_EONIDE
> +		| EP93XX_SYSCON_DEVCFG_GONIDE | EP93XX_SYSCON_DEVCFG_HONIDE)) {
> +		dev_err(&pdev->dev, "IDE/GPIO pin conflict\n");
> +		return -EINVAL;
> +	}*/


Fix or remove.

> +
> +	/* INT[3] (IRQ_EP93XX_EXT3) line connected as pull down */
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "IRQ allocation failed\n");
> +		return -ENXIO;
> +	}
> +
> +	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!mem_res) {
> +		dev_err(&pdev->dev, "resources allocation failed\n");
> +		return -ENXIO;
> +	}
> +
> +	ide_base = devm_request_and_ioremap(&pdev->dev, mem_res);
> +	if (!ide_base) {
> +		dev_err(&pdev->dev, "memory region request/map failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
> +	if (!drv_data) {
> +		dev_err(&pdev->dev, "unable to allocate memory\n");

> +		return -ENOMEM;

> +	}
> +
> +	platform_set_drvdata(pdev, drv_data);
> +	drv_data->ide_base = ide_base;
> +	drv_data->udma_in_phys = mem_res->start + IDEUDMADataIn;
> +	drv_data->udma_out_phys = mem_res->start + IDEUDMADataOut;
> +	ep93xx_pata_dma_init(drv_data);
> +
> +	/* allocate host */
> +	host = ata_host_alloc(&pdev->dev, 1);
> +	if (!host) {
> +		dev_err(&pdev->dev, "ata_host_alloc() failed\n");

> +		return -ENOMEM;

> +	}
> +
> +	ep93xx_pata_clear_regs(ide_base);
> +
> +	host->n_ports = 1;
> +	host->private_data = drv_data;
> +
> +	ap = host->ports[0];
> +	ap->dev = &pdev->dev;
> +	ap->ops = &ep93xx_pata_port_ops;
> +	ap->flags |= ATA_FLAG_SLAVE_POSS;
> +	ap->pio_mask = ATA_PIO4;
> +	/*
> +	 * Maximum UDMA modes:
> +	 * EP931x rev.E0 - UDMA2
> +	 * EP931x rev.E1 - UDMA3
> +	 * EP931x rev.E2 - UDMA4
> +	 *
> +	 * MWDMA support was removed from EP931x rev.E2,
> +	 * so this driver supports only UDMA modes.
> +	 */
> +	if (drv_data->dma_rx_channel && drv_data->dma_tx_channel) {
> +		int chip_rev = ep93xx_chip_revision();
> +		if (chip_rev == EP93XX_CHIP_REV_E1)
> +			ap->udma_mask = ATA_UDMA3;
> +		else if (chip_rev == EP93XX_CHIP_REV_E2)
> +			ap->udma_mask = ATA_UDMA4;
> +		else
> +			ap->udma_mask = ATA_UDMA2;
> +	}
> +
> +	ep93xx_pata_setup_port(&ap->ioaddr);
> +
> +	/* defaults, pio 0 */
> +	ep93xx_pata_enable_pio(ide_base, 0);
> +
> +	dev_info(&pdev->dev, "version " DRV_VERSION "\n");
> +
> +	/* activate host */
> +	return ata_host_activate(host, irq, ata_bmdma_interrupt, 0,
> +		&ep93xx_pata_sht);

> +}

> +
> +static int __devexit ep93xx_pata_remove(struct platform_device *pdev)
> +{
> +	struct ata_host *host = platform_get_drvdata(pdev);
> +	struct ep93xx_pata_data *drv_data = host->private_data;
> +
> +	ata_host_detach(host);
> +	if (drv_data->dma_rx_channel)
> +		dma_release_channel(drv_data->dma_rx_channel);
> +	if (drv_data->dma_tx_channel)
> +		dma_release_channel(drv_data->dma_tx_channel);
> +	ep93xx_pata_clear_regs(drv_data->ide_base);

> +	return 0;
> +}
> +
> +static struct platform_driver ep93xx_pata_platform_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = ep93xx_pata_probe,
> +	.remove = __devexit_p(ep93xx_pata_remove),
> +};
> +
> +static int __init ep93xx_pata_init(void)
> +{
> +	return platform_driver_register(&ep93xx_pata_platform_driver);
> +}
> +
> +static void __exit ep93xx_pata_exit(void)
> +{
> +	platform_driver_unregister(&ep93xx_pata_platform_driver);
> +}
> +
> +module_init(ep93xx_pata_init);
> +module_exit(ep93xx_pata_exit);
> +
> +MODULE_AUTHOR("Alessandro Zummo, Lennert Buytenhek, Joao Ramos, "
> +		"Bartlomiej Zolnierkiewicz, Rafal Prylowski");
> +MODULE_DESCRIPTION("low-level driver for cirrus ep93xx IDE controller");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
> +MODULE_ALIAS("platform:pata_ep93xx");
> Index: linux-2.6/drivers/ata/Kconfig
> ===================================================================
> --- linux-2.6.orig/drivers/ata/Kconfig
> +++ linux-2.6/drivers/ata/Kconfig
> @@ -416,6 +416,15 @@ config PATA_EFAR
>  
>  	  If unsure, say N.
>  
> +config PATA_EP93XX
> +	tristate "Cirrus Logic EP93xx PATA support"
> +	depends on ARCH_EP93XX
> +	help
> +	  This option enables support for the PATA controller in
> +	  the Cirrus Logic EP9312 and EP9315 ARM CPU.
> +
> +	  If unsure, say N.
> +
>  config PATA_HPT366
>  	tristate "HPT 366/368 PATA support"
>  	depends on PCI
> Index: linux-2.6/drivers/ata/Makefile
> ===================================================================
> --- linux-2.6.orig/drivers/ata/Makefile
> +++ linux-2.6/drivers/ata/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_PATA_CS5535)	+= pata_cs5535
>  obj-$(CONFIG_PATA_CS5536)	+= pata_cs5536.o
>  obj-$(CONFIG_PATA_CYPRESS)	+= pata_cypress.o
>  obj-$(CONFIG_PATA_EFAR)		+= pata_efar.o
> +obj-$(CONFIG_PATA_EP93XX)	+= pata_ep93xx.o
>  obj-$(CONFIG_PATA_HPT366)	+= pata_hpt366.o
>  obj-$(CONFIG_PATA_HPT37X)	+= pata_hpt37x.o
>  obj-$(CONFIG_PATA_HPT3X2N)	+= pata_hpt3x2n.o
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


