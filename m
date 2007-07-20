From: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
Subject: Re: PATA driver for Atmel AVR32
Date: Fri, 20 Jul 2007 11:12:12 +0200
Message-ID: <200707201112.12444.kngregertsen@norway.atmel.com>
References: <200707201108.19174.kngregertsen@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:52090 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755421AbXGTJMt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 05:12:49 -0400
In-Reply-To: <200707201108.19174.kngregertsen@norway.atmel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: kernel@avr32linux.org, gregerts@stud.ntnu.no, kngregertsen@norway.atmel.com

Here is the code, tips and reviews would be appriciated too :)

/*
 * AVR32 SMC/CFC PATA Driver
 *
 * Copyright (C) 2007 Atmel Norway
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */
#define DEBUG

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/device.h>
#include <linux/platform_device.h>
#include <linux/delay.h>
#include <linux/interrupt.h>
#include <linux/irq.h>
#include <scsi/scsi_host.h>
#include <linux/ata.h>
#include <linux/libata.h>
#include <linux/err.h>
#include <linux/io.h>

#include <asm/gpio.h>
#include <asm/arch/board.h>
#include <asm/arch/smc.h>

#define DRV_NAME "pata_at32"
#define DRV_VERSION "0.0.2"

/*
 * CompactFlash controller memory layout relative to the base address:
 *
 * 	Attribute memory:  0000 0000 -> 003f ffff
 * 	Common memory:     0040 0000 -> 007f ffff
 * 	I/O memory:        0080 0000 -> 00bf ffff
 * 	True IDE Mode:     00c0 0000 -> 00df ffff
 * 	Alt IDE Mode:      00e0 0000 -> 00ff ffff
 *
 * Only True IDE and Alt True IDE mode are needed for this driver.
 *
 * 	True IDE mode     => CS0 = 0, CS1 = 1 (cmd, error, stat, etc)
 * 	Alt True IDE mode => CS0 = 1, CS1 = 0 (ctl, alt_stat)
 */
#define CF_IDE_OFFSET     0x00c00000
#define CF_ALT_IDE_OFFSET 0x00e00000
#define CF_RES_SIZE       2048

/*
 * The CompactFlash controller in the current AP7000 series has a bug
 * that makes 8-bit data being put on both upper and lower byte on the
 * 16-bit bus. It should only be put on the lower byte.
 */
#define CF_BUGGY_IDE_MODE

/*
 * ATA PIO modes
 *
 *	Name	| Mb/s	| Min cycle time
 *	--------+-------+---------------
 * 	Mode 0	| 3.3	| 600 ns
 * 	Mode 1	| 5.2	| 383 ns
 * 	Mode 2	| 8.3	| 240 ns
 * 	Mode 3	| 11.1	| 180 ns
 * 	Mode 4	| 16.7	| 120 ns
 *
 * Only PIO modes 0 is supported in version 0.0.2.
 */
#define DEFAULT_PIO_MODE (0)

/*
 * PIO mask for maximal PIO mode
 *
 * 	Mode 0 => 0x01
 * 	Mode 1 => 0x03
 * 	Mode 2 => 0x07
 * 	Mode 3 => 0x0f
 * 	Mode 4 => 0x1f
 */
#define PIO_MASK (0x01)

/*
 * Define DEBUG_BUS if you are doing debugging of your own
 * EBI->PATA adaptor with an logic analyzer or similar.
 */
#undef DEBUG_BUS

/*
 * SMC timings to match ATAPI-4 PIO timing specs (given in ns)
 * See Figure 20 and Table 29 on pages 262-263 in T13/1153D revision 18
 */
static const int smc_tot_cycle[5] = {600, 390, 350, 190, 135}; /* >= t0 */
static const int smc_nrd_setup[5] = {100,  60,  40,  40,  35}; /* >= t1 */
static const int smc_nrd_pulse[5] = {400, 300, 290,  80,  70}; /* >= t2 */

/*
 * Setup SMC timings for the given PIO mode
 */
static int pata_at32_compute_timings(struct smc_config *smc, int pio_mode)
{
	const int ring_time = 100;

	if ((pio_mode < 0) || (4 < pio_mode))
		return -EINVAL;

	/* Total cycle time */
	smc->read_cycle  = smc_tot_cycle[pio_mode] + ring_time;
	smc->write_cycle = smc_tot_cycle[pio_mode] + ring_time;

	/* CFCE1 => CS0 and CFCE2 => CS1 timings */
	smc->ncs_read_setup  = 0;
	smc->ncs_read_pulse  = smc->read_cycle;
	smc->ncs_write_setup = 0;
	smc->ncs_write_pulse = smc->write_cycle;

	/* CFIOR => DIOR and CFIOW => DIOW timings */
	smc->nrd_setup = smc_nrd_setup[pio_mode] + ring_time;
	smc->nrd_pulse = smc_nrd_pulse[pio_mode];
	smc->nwe_setup = smc_nrd_setup[pio_mode] + ring_time;
	smc->nwe_pulse = smc_nrd_pulse[pio_mode];

	return 0;
}

/*
 * Struct containing private information about device
 */
struct at32_ide_info {
	unsigned int		irq;
	struct resource		res_ide;
	struct resource		res_alt;
	void __iomem 		*ide_addr;
	void __iomem 		*alt_addr;
	int                     reset_pin;
	int                     dmarq_pin;
	int                     dmack_pin;
	unsigned int		cs;
	struct smc_config 	smc;
	int			smc_pio_mode;
};

static int pata_at32_hard_reset(struct device *dev, struct at32_ide_info *info)
{
	if (info->reset_pin < 0)
		return -EINVAL;

	/* Set RESET low for at least 25 us */
	gpio_set_value(info->reset_pin, 0);
	udelay(30);
	gpio_set_value(info->reset_pin, 1);

	/* The device needs time to stabilize after reset */
	udelay(10);

	return 0;
}

/*
 * Functions for libATA
 */
static void pata_at32_set_piomode(struct ata_port *ap, struct ata_device *adev)
{
	struct at32_ide_info *info = ap->host->private_data;
	int pio_mode = adev->pio_mode - XFER_PIO_0;
	int ret;

	/* Exit if the SMC is already configured for this PIO mode */
	if (pio_mode == info->smc_pio_mode)
		return;

	ret = pata_at32_compute_timings(&info->smc,  pio_mode);
	if (ret) {
		dev_warn(ap->dev, "Invalid PIO mode %d\n", pio_mode);
		return;
	}

	/* Only use IORDY/NWAIT for PIO mode 3 and 4 */
	if (pio_mode < 3)
		info->smc.nwait_mode = 0;
	else
		info->smc.nwait_mode = 3;

	ret = smc_set_configuration(info->cs, &info->smc);
	if (ret) {
		dev_warn(ap->dev, "Failed to setup SMC %d\n", ret);
		return;
	}

	info->smc_pio_mode = pio_mode;
}

static void pata_at32_phy_reset(struct ata_port *ap)
{
	pata_at32_hard_reset(ap->dev, ap->host->private_data);
}

static void pata_at32_irq_clear(struct ata_port *ap)
{
	; /* Todo: Need to clear interrupt? */
}

static irqreturn_t pata_at32_interrupt(int irq, void *dev_instance)
{
	struct ata_host *host = dev_instance;
	irqreturn_t irq_ret = ata_interrupt(irq, dev_instance);

	/* We are the only ones listening for our IRQ */
	if (irq_ret == IRQ_NONE)
		dev_dbg(host->dev, "IRQ NOT HANDLED\n");

	return IRQ_HANDLED;
}

static struct scsi_host_template at32_sht = {
	.module			= THIS_MODULE,
	.name			= DRV_NAME,
	.ioctl			= ata_scsi_ioctl,
	.queuecommand		= ata_scsi_queuecmd,
	.can_queue		= ATA_DEF_QUEUE,
	.this_id		= ATA_SHT_THIS_ID,
	.sg_tablesize		= LIBATA_MAX_PRD,
	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
	.emulated		= ATA_SHT_EMULATED,
	.use_clustering		= ATA_SHT_USE_CLUSTERING,
	.proc_name		= DRV_NAME,
	.dma_boundary		= ATA_DMA_BOUNDARY,
	.slave_configure	= ata_scsi_slave_config,
	.slave_destroy		= ata_scsi_slave_destroy,
	.bios_param		= ata_std_bios_param,
};

static struct ata_port_operations at32_port_ops = {
	.port_disable		= ata_port_disable,
	.set_piomode		= pata_at32_set_piomode,
	.tf_load		= ata_tf_load,
	.tf_read		= ata_tf_read,
	.exec_command		= ata_exec_command,
	.check_status		= ata_check_status,
	.dev_select		= ata_std_dev_select,
	.phy_reset		= pata_at32_phy_reset,
	.cable_detect		= ata_cable_40wire,
	.freeze			= ata_bmdma_freeze,
	.thaw			= ata_bmdma_thaw,
	.error_handler		= ata_bmdma_error_handler,
	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
	.qc_prep		= ata_qc_prep,
	.qc_issue		= ata_qc_issue_prot,
	.data_xfer		= ata_data_xfer,
	.irq_handler		= pata_at32_interrupt,
	.irq_clear		= pata_at32_irq_clear,
	.irq_on			= ata_irq_on,
	.irq_ack		= ata_irq_ack,
	.port_start		= ata_port_start,
};

static int pata_at32_init_one(struct device *dev, struct at32_ide_info *info)
{
	struct ata_host *host;
	struct ata_port *ap;

	host = ata_host_alloc(dev, 1);
	if (!host)
		return -ENOMEM;

	ap = host->ports[0];

	/* Setup ATA bindings */
	ap->ops	     = &at32_port_ops;
	ap->pio_mask = PIO_MASK;
	ap->flags   |= ATA_FLAG_MMIO;

	/* Run in polling mode if no irq has been assigned */
	if (!info->irq)
		ap->flags |= ATA_FLAG_PIO_POLLING;

	/*
	 * Since all 8-bit taskfile transfers has to go on the lower byte
	 * of the data bus and there is a bug in the SMC that makes it
	 * impossible to alter the bus width during runtime, we need to
	 * hardwire the address signals as follows:
	 *
	 *	A_IDE(2:0) <= A_EBI(3:1)
	 *
	 * This makes all addresses on the EBI even, thus all data will be
	 * on the lower byte of the data bus.  All addresses used by libATA
	 * need to be altered according to this, the offsets need to be
	 * shifted on step up.
	 *
	 * A later version of the CompactFlash controller might fix this
	 * issue. In that case the standard addresses may be used.
	 */
#ifdef CF_BUGGY_IDE_MODE
	ap->ioaddr.cmd_addr	  = info->ide_addr;
	ap->ioaddr.altstatus_addr = info->alt_addr + (0x06 << 1);
	ap->ioaddr.ctl_addr	  = info->alt_addr + (0x06 << 1);

	ap->ioaddr.data_addr	  = info->ide_addr + (ATA_REG_DATA << 1);
	ap->ioaddr.error_addr	  = info->ide_addr + (ATA_REG_ERR << 1);
	ap->ioaddr.feature_addr	  = info->ide_addr + (ATA_REG_FEATURE << 1);
	ap->ioaddr.nsect_addr	  = info->ide_addr + (ATA_REG_NSECT << 1);
	ap->ioaddr.lbal_addr	  = info->ide_addr + (ATA_REG_LBAL << 1);
	ap->ioaddr.lbam_addr	  = info->ide_addr + (ATA_REG_LBAM << 1);
	ap->ioaddr.lbah_addr	  = info->ide_addr + (ATA_REG_LBAH << 1);
	ap->ioaddr.device_addr	  = info->ide_addr + (ATA_REG_DEVICE << 1);
	ap->ioaddr.status_addr	  = info->ide_addr + (ATA_REG_STATUS << 1);
	ap->ioaddr.command_addr	  = info->ide_addr + (ATA_REG_CMD << 1);
#else
	ap->ioaddr.cmd_addr	  = info->ide_addr;
	ap->ioaddr.altstatus_addr = info->alt_addr + 0x06;
	ap->ioaddr.ctl_addr	  = info->alt_addr + 0x06;

	ata_std_ports(&ap->ioaddr);
#endif

	/* Set info as private data of ATA host */
	host->private_data = info;

	/* Register ATA device and return */
	return ata_host_activate(host, info->irq, pata_at32_interrupt,
				 IRQF_TRIGGER_HIGH, &at32_sht);
}

/*
 * The following two debugging functions might come in handy for
 * people analyzing their own EBI -> PATA adaptors.
 */
#ifdef DEBUG_BUS

static void __init pata_at32_debug_bus(struct device *dev,
				       struct at32_ide_info *info)
{
	const int d1 = 0xff;
	const int d2 = 0x00;

	int i, ctld;
	int iod[8];

	iowrite8(d1, info->alt_addr + (0x06 << 1));
	iowrite8(d2, info->alt_addr + (0x06 << 1));

	for (i = 0; i < 8; i++) {
		iowrite8(d1, info->ide_addr + (i << 1));
		iowrite8(d2, info->ide_addr + (i << 1));
	}

	ctld = ioread8(info->alt_addr + (0x06 << 1));

	for (i = 0; i < 8; i++)
		iod[i] = ioread8(info->ide_addr + (i << 1));

	iowrite16(d1,      info->ide_addr);
	iowrite16(d1 << 8, info->ide_addr);

	iowrite16(d1,      info->ide_addr);
	iowrite16(d1 << 8, info->ide_addr);

	dev_dbg(dev, "CTL = %x\n", ctld);

	for (i = 0; i < 8; i++)
		dev_dbg(dev, "IO%d = %x\n", i, iod[i]);

	pata_at32_hard_reset(dev, info);
}

static void __init pata_at32_debug_disk(struct device *dev,
					struct at32_ide_info *info)
{
	void __iomem *nsect_addr
		= info->ide_addr + (ATA_REG_NSECT << 1);
	void __iomem *lbal_addr
		= info->ide_addr + (ATA_REG_LBAL << 1);
	void __iomem *status_addr
		= info->ide_addr + (ATA_REG_STATUS << 1);
	void __iomem *device_addr
		= info->ide_addr + (ATA_REG_DEVICE << 1);

	int i, status, nsect, lbal;

	pata_at32_hard_reset(dev, info);

	iowrite8(~0x10, device_addr);

	i = 0;
	do {
		status = ioread8(status_addr);
		i++;
	} while (status & 0x80);

	iowrite8(~0x10, device_addr);

	do {
		status = ioread8(status_addr);
		i--;
	} while (status & 0x80);

	iowrite8(0x55, nsect_addr);
	iowrite8(0xaa, lbal_addr);

	iowrite8(0x55, nsect_addr);
	iowrite8(0xaa, lbal_addr);

	iowrite8(0x55, nsect_addr);
	iowrite8(0xaa, lbal_addr);

	nsect = ioread8(nsect_addr);
	lbal  = ioread8(lbal_addr);

	dev_dbg(dev, "STATUS(%d) = %x, NSECT = %x, LBAL = %x\n",
		i, status, nsect, lbal);
}

#endif

static int __init pata_at32_probe(struct platform_device *pdev)
{
	struct at32_ide_info     *info;
	struct ide_platform_data *board = pdev->dev.platform_data;
	struct resource	         *res;

	int irq;
	int ret;

	if (!board)
		return -ENXIO;

	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
	if (!res)
		return -ENXIO;

	/* Retrive IRQ */
	irq = platform_get_irq(pdev, 0);
	if (irq < 0)
		return irq;

	/* Setup struct containg private infomation */
	info = kzalloc(sizeof(struct at32_ide_info), GFP_KERNEL);
	if (!info)
		return -ENOMEM;

	memset(info, 0, sizeof(struct at32_ide_info));

	info->irq = irq;
	info->cs = board->cs;

	info->reset_pin = -1;
	info->dmarq_pin = -1;
	info->dmack_pin = -1;

	/* Request reset pin */
	if (board->reset_pin) {
		ret = gpio_request(board->reset_pin, "reset");
		if (ret)
			goto err_req_gpio;
		info->reset_pin = board->reset_pin;
	}

	/* Request DMA request pin */
	if (board->dmarq_pin) {
		ret = gpio_request(board->dmarq_pin, "dmarq");
		if (ret)
			goto err_req_gpio;
		info->dmarq_pin = board->dmarq_pin;
	}

	/* Request DMA ack pin */
	if (board->dmack_pin) {
		ret = gpio_request(board->dmack_pin, "dmack");
		if (ret)
			goto err_req_gpio;
		info->dmack_pin = board->dmack_pin;
	}

	dev_dbg(&pdev->dev, "RESET: %d DMARQ: %d DMACK: %d\n",
		info->reset_pin, info->dmarq_pin, info->dmack_pin);

	/* Request memory resources */
	dev_info(&pdev->dev, "Memory setup on CS%d\n", info->cs);

	info->res_ide.start = res->start + CF_IDE_OFFSET;
	info->res_ide.end   = info->res_ide.start + CF_RES_SIZE - 1;
	info->res_ide.name  = "ide";
	info->res_ide.flags = IORESOURCE_MEM;

	ret = request_resource(res, &info->res_ide);
	if (ret)
		goto err_req_res_ide;

	dev_dbg(&pdev->dev, "RESOURCE: %s: %x to %x flags %x\n",
		info->res_ide.name, (int) info->res_ide.start,
		(int) info->res_ide.end, (int) info->res_ide.flags);

	info->res_alt.start = res->start + CF_ALT_IDE_OFFSET;
	info->res_alt.end   = info->res_alt.start + CF_RES_SIZE - 1;
	info->res_alt.name  = "alt";
	info->res_alt.flags = IORESOURCE_MEM;

	ret = request_resource(res, &info->res_alt);
	if (ret)
		goto err_req_res_alt;

	dev_dbg(&pdev->dev, "RESOURCE: %s: %x to %x flags %x\n",
		info->res_alt.name, (int) info->res_alt.start,
		(int) info->res_alt.end, (int) info->res_alt.flags);

	/* Setup SMC, see Atmel AVR32 AP7000 datasheet chapter 27 */
	info->smc.bus_width	  = 2; /* 16 bit data bus */
	info->smc.nrd_controlled  = 1; /* Sample data on rising edge of NRD */
	info->smc.nwe_controlled  = 0; /* Drive data on falling edge of NCS */
	info->smc.nwait_mode      = 0; /* NWAIT is only used for PIO 3 and 4 */
	info->smc.byte_write      = 0; /* Byte select access type */
	info->smc.tdf_mode        = 0; /* TDF optimization disabled */
	info->smc.tdf_cycles      = 0; /* 0 cycles before data is released */

	ret = pata_at32_compute_timings(&info->smc, DEFAULT_PIO_MODE);
	if (ret)
		goto err_smc_config;

	ret = smc_set_configuration(info->cs, &info->smc);
	if (ret)
		goto err_smc_config;

	info->smc_pio_mode = DEFAULT_PIO_MODE;

	/* Setup ATA addresses */
	ret = -ENOMEM;
	info->ide_addr = devm_ioport_map(&pdev->dev, info->res_ide.start, 16);
	info->alt_addr = devm_ioport_map(&pdev->dev, info->res_alt.start, 16);
	if (!info->ide_addr || !info->alt_addr)
		goto err_iomap;

	/* Call functions to debug EBI->PATA adaptor with logic analyzer */
#ifdef DEBUG_BUS
	pata_at32_debug_bus(&pdev->dev, info);
	pata_at32_debug_disk(&pdev->dev, info);
#endif

	/* Reset ATA device */
	pata_at32_hard_reset(&pdev->dev, info);

	/* Register ATA device */
	ret = pata_at32_init_one(&pdev->dev, info);
	if (ret)
		goto err_ata_device;

	return 0;

 err_ata_device:
 err_iomap:
 err_smc_config:
	release_resource(&info->res_alt);
 err_req_res_alt:
	release_resource(&info->res_ide);
 err_req_res_ide:
 err_req_gpio:
	if (info->reset_pin >= 0)
		gpio_free(info->reset_pin);
	if (info->dmarq_pin >= 0)
		gpio_free(info->dmarq_pin);
	if (info->dmack_pin >= 0)
		gpio_free(info->dmack_pin);

	kfree(info);

	return ret;
}

static int __exit pata_at32_remove(struct platform_device *pdev)
{
	struct ata_host *host = platform_get_drvdata(pdev);
	struct at32_ide_info *info;

	if (!host)
		return 0;

	info = host->private_data;
	ata_host_detach(host);

	if (!info)
		return 0;

	pata_at32_hard_reset(&pdev->dev, info);

	release_resource(&info->res_ide);
	release_resource(&info->res_alt);

	if (info->reset_pin >= 0)
		gpio_free(info->reset_pin);
	if (info->dmarq_pin >= 0)
		gpio_free(info->dmarq_pin);
	if (info->dmack_pin >= 0)
		gpio_free(info->dmack_pin);

	kfree(info);

	return 0;
}

static struct platform_driver pata_at32_driver = {
	.remove        = __exit_p(pata_at32_remove),
	.driver        = {
		.name  = "at32_ide",
		.owner = THIS_MODULE,
	},
};

static int __init pata_at32_init(void)
{
	return platform_driver_probe(&pata_at32_driver, pata_at32_probe);
}

static void __exit pata_at32_exit(void)
{
	platform_driver_unregister(&pata_at32_driver);
}

module_init(pata_at32_init);
module_exit(pata_at32_exit);

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("AVR32 SMC IDE Driver");
MODULE_AUTHOR("Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>");
MODULE_VERSION(DRV_VERSION);
