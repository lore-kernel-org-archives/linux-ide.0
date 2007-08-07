From: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
Subject: [PATCH 1/1] AVR32 PATA driver
Date: Tue, 7 Aug 2007 11:27:09 +0200
Message-ID: <200708071127.09751.kngregertsen@norway.atmel.com>
References: <200708071126.08735.kngregertsen@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:60914 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754709AbXHGJ2q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 7 Aug 2007 05:28:46 -0400
In-Reply-To: <200708071126.08735.kngregertsen@norway.atmel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: gregerts@stud.ntnu.no

This patch adds support for PATA devices on the AVR32 using the CompactFlash
controller in 'True IDE mode'. DMA is currently not supported due to lack of
DMACK pins on the current AP7000 series.

Tested on AP7000 / STK1000.

Signed-off-by: Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>
---
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 4ad8675..7de15e6 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -199,6 +199,15 @@ config PATA_ARTOP
 
 	  If unsure, say N.
 
+config PATA_AT32
+	tristate "Atmel AVR32 PATA support (Very Experimental)"
+	depends on AVR32 && PLATFORM_AT32AP && EXPERIMENTAL
+	help
+	  This option enables support for the IDE devices on the
+	  Atmel AT32AP platform.
+
+	  If unsure, say N.
+
 config PATA_ATIIXP
 	tristate "ATI PATA support (Experimental)"
 	depends on PCI && EXPERIMENTAL
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 8149c68..7c5e319 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_PDC_ADMA)		+= pdc_adma.o
 obj-$(CONFIG_PATA_ALI)		+= pata_ali.o
 obj-$(CONFIG_PATA_AMD)		+= pata_amd.o
 obj-$(CONFIG_PATA_ARTOP)	+= pata_artop.o
+obj-$(CONFIG_PATA_AT32)		+= pata_at32.o
 obj-$(CONFIG_PATA_ATIIXP)	+= pata_atiixp.o
 obj-$(CONFIG_PATA_CMD640_PCI)	+= pata_cmd640.o
 obj-$(CONFIG_PATA_CMD64X)	+= pata_cmd64x.o
diff --git a/drivers/ata/pata_at32.c b/drivers/ata/pata_at32.c
new file mode 100644
index 0000000..3f57624
--- /dev/null
+++ b/drivers/ata/pata_at32.c
@@ -0,0 +1,569 @@
+/*
+ * AVR32 SMC/CFC PATA Driver
+ *
+ * Copyright (C) 2007 Atmel Norway
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ */
+#define DEBUG
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <scsi/scsi_host.h>
+#include <linux/ata.h>
+#include <linux/libata.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include <asm/gpio.h>
+#include <asm/arch/board.h>
+#include <asm/arch/smc.h>
+
+#define DRV_NAME "pata_at32"
+#define DRV_VERSION "0.0.2"
+
+/*
+ * CompactFlash controller memory layout relative to the base address:
+ *
+ *	Attribute memory:  0000 0000 -> 003f ffff
+ *	Common memory:	   0040 0000 -> 007f ffff
+ *	I/O memory:	   0080 0000 -> 00bf ffff
+ *	True IDE Mode:	   00c0 0000 -> 00df ffff
+ *	Alt IDE Mode:	   00e0 0000 -> 00ff ffff
+ *
+ * Only True IDE and Alt True IDE mode are needed for this driver.
+ *
+ *	True IDE mode	  => CS0 = 0, CS1 = 1 (cmd, error, stat, etc)
+ *	Alt True IDE mode => CS0 = 1, CS1 = 0 (ctl, alt_stat)
+ */
+#define CF_IDE_OFFSET	  0x00c00000
+#define CF_ALT_IDE_OFFSET 0x00e00000
+#define CF_RES_SIZE	  2048
+
+/*
+ * Define DEBUG_BUS if you are doing debugging of your own EBI -> PATA
+ * adaptor with a logic analyzer or similar.
+ */
+#undef DEBUG_BUS
+
+/*
+ * ATA PIO modes
+ *
+ *	Name	| Mb/s	| Min cycle time | Mask
+ *	--------+-------+----------------+--------
+ *	Mode 0	| 3.3	| 600 ns	 | 0x01
+ *	Mode 1	| 5.2	| 383 ns	 | 0x03
+ *	Mode 2	| 8.3	| 240 ns	 | 0x07
+ *	Mode 3	| 11.1	| 180 ns	 | 0x0f
+ *	Mode 4	| 16.7	| 120 ns	 | 0x1f
+ *
+ * This parameter allows users to set max PIO mode.
+ */
+static int max_pio = 4;
+module_param(max_pio, int, 0444);
+MODULE_PARM_DESC(max_pio, "Max PIO mode, range 0..4, default 4");
+
+/*
+ * Return PIO mask as given by parameter max_pio.
+ */
+static int pata_at32_get_pio_mask(void)
+{
+	switch (max_pio) {
+	case 0:
+		return 0x01;
+	case 1:
+		return 0x03;
+	case 2:
+		return 0x07;
+	case 3:
+		return 0x0f;
+	case 4:
+		return 0x1f;
+	default:
+		return 0x01;
+	}
+}
+
+/*
+ * Struct containing private information about device.
+ */
+struct at32_ide_info {
+	unsigned int		irq;
+	struct resource		res_ide;
+	struct resource		res_alt;
+	void __iomem		*ide_addr;
+	void __iomem		*alt_addr;
+	unsigned int		cs;
+	struct smc_config	smc_8;
+	struct smc_config	smc_16;
+	int			smc_pio_mode;
+};
+
+/*
+ * Computes SMC timing for the given ATA timing and bus width.
+ */
+static void pata_at32_compute_smc_timing(struct device *dev,
+					 struct smc_config *smc,
+					 const struct ata_timing *timing,
+					 int bus_width)
+{
+	/* These two values are found through testing */
+	const int min_recover = 50;
+	const int ncs_hold    = 20;
+
+	int read_active;
+	int read_recover;
+	int write_active;
+	int write_recover;
+
+	/* Compute SMC timings given data or register transfer */
+	if (bus_width == 2) {
+		/* Data transfer total cycle time */
+		smc->read_cycle	 = timing->cycle;
+		smc->write_cycle = timing->cycle;
+
+		/* Data transfer DIOR <= CFIOR timings */
+		smc->nrd_setup = timing->setup;
+		smc->nrd_pulse = timing->active;
+
+		/* Data transfer DIOW <= CFIOW timings */
+		smc->nwe_setup = timing->setup;
+		smc->nwe_pulse = timing->active;
+	} else {
+		/* Register transfer total cycle time */
+		smc->read_cycle	 = timing->cyc8b;
+		smc->write_cycle = timing->cyc8b;
+
+		/* Register transfer DIOR <= CFIOR timings */
+		smc->nrd_setup = timing->setup;
+		smc->nrd_pulse = timing->act8b;
+
+		/* Register transfer DIOW <= CFIOW timings */
+		smc->nwe_setup = timing->setup;
+		smc->nwe_pulse = timing->act8b;
+	}
+
+	/* Compute read recover, extend total cycle if needed */
+	read_active  = smc->nrd_setup + smc->nrd_pulse;
+	read_recover = smc->read_cycle - read_active;
+
+	if (read_recover < min_recover) {
+		smc->read_cycle = read_active + min_recover;
+		read_recover = min_recover;
+	}
+
+	/* Compute write recover, extend total cycle if needed */
+	write_active  = smc->nwe_setup + smc->nwe_pulse;
+	write_recover = smc->write_cycle - write_active;
+
+	if (write_recover < min_recover) {
+		smc->write_cycle = write_active + min_recover;
+		write_recover = min_recover;
+	}
+
+	/* (CS0, CS1, DIR, OE) <= (CFCE1, CFCE2, CFRNW, NCSX) timings */
+	smc->ncs_read_setup  = 0;
+	smc->ncs_read_pulse  = read_active + ncs_hold;
+	smc->ncs_write_setup = 0;
+	smc->ncs_write_pulse = write_active + ncs_hold;
+
+	/* Compute number of TDF cycles */
+	smc->tdf_cycles = smc_get_clock_cycles(ncs_hold) + 1;
+
+	/* Do some debugging output */
+	dev_dbg(dev, "SMC_%s READ : C=%d S=%d P=%d R=%d "
+		"NCSS=%d NCSP=%d NCSR=%d\n",
+		bus_width == 2 ? "16" : "8",
+		smc->read_cycle, smc->nrd_setup,
+		smc->nrd_pulse, read_recover,
+		smc->ncs_read_setup, smc->ncs_read_pulse,
+		smc->read_cycle - smc->ncs_read_pulse);
+
+	dev_dbg(dev, "SMC_%s WRITE: C=%d S=%d P=%d R=%d "
+		"NCSS=%d NCSP=%d NCSR=%d\n",
+		bus_width == 2 ? "16" : "8",
+		smc->write_cycle, smc->nwe_setup,
+		smc->nwe_pulse, write_recover,
+		smc->ncs_write_setup, smc->ncs_write_pulse,
+		smc->write_cycle - smc->ncs_write_pulse);
+
+	dev_dbg(dev, "SMC_%s TDF: %s MODE %d CYCLES\n",
+		bus_width == 2 ? "16" : "8",
+		smc->tdf_mode ? "OPTIMIZED" : "NORMAL",
+		smc->tdf_cycles);
+}
+
+/*
+ * Setup SMC for the given ATA timing.
+ */
+static int pata_at32_setup_timing(struct device *dev,
+				  struct at32_ide_info *info,
+				  const struct ata_timing *timing)
+{
+	int ret;
+
+	/* Compute SMC timings for register and data transfers */
+	pata_at32_compute_smc_timing(dev, &info->smc_8,	 timing, 1);
+	pata_at32_compute_smc_timing(dev, &info->smc_16, timing, 2);
+
+	/*
+	 * Configure the SMC for data transfers first. The purpose is
+	 * to validate the configuration and compute the register
+	 * contents so they can be restored later (see procedure
+	 * pata_at32_data_xfer).
+	 */
+	ret = smc_set_configuration(info->cs, &info->smc_16);
+	if (ret)
+		return ret;
+
+	/* Then configure the SMC for register transfers */
+	return smc_set_configuration(info->cs, &info->smc_8);
+}
+
+/*
+ * Procedures for libATA.
+ */
+static void pata_at32_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct ata_timing timing;
+	struct at32_ide_info *info = ap->host->private_data;
+
+	int pio_mode = adev->pio_mode - XFER_PIO_0;
+	int ret;
+
+	/* Exit if the SMC is already configured for this PIO mode */
+	if (pio_mode == info->smc_pio_mode)
+		return;
+
+	/* Compute ATA timing */
+	ret = ata_timing_compute(adev, adev->pio_mode, &timing, 1000, 0);
+	if (ret) {
+		dev_warn(ap->dev, "Failed to compute ATA timing %d\n", ret);
+		return;
+	}
+
+	/* Setup SMC to ATA timing */
+	ret = pata_at32_setup_timing(ap->dev, info, &timing);
+	if (ret) {
+		dev_warn(ap->dev, "Failed to setup ATA timing %d\n", ret);
+		return;
+	}
+
+	info->smc_pio_mode = pio_mode;
+}
+
+static void pata_at32_irq_clear(struct ata_port *ap)
+{
+}
+
+static void pata_at32_data_xfer(struct ata_device *adev, unsigned char *buf,
+				unsigned int buflen, int write_data)
+{
+	struct at32_ide_info *info = adev->ap->host->private_data;
+
+	/* Set SMC to data transfer speed */
+	if (info->smc_pio_mode < 3)
+		smc_restore_registers(info->cs, &info->smc_16.reg);
+
+	/* Transfer data */
+	ata_data_xfer(adev, buf, buflen, write_data);
+
+	/* Set SMC back to register transfer speed */
+	if (info->smc_pio_mode < 3)
+		smc_restore_registers(info->cs, &info->smc_8.reg);
+}
+
+static struct scsi_host_template at32_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= LIBATA_MAX_PRD,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
+	.bios_param		= ata_std_bios_param,
+};
+
+static struct ata_port_operations at32_port_ops = {
+	.port_disable		= ata_port_disable,
+	.set_piomode		= pata_at32_set_piomode,
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.exec_command		= ata_exec_command,
+	.check_status		= ata_check_status,
+	.dev_select		= ata_std_dev_select,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= ata_bmdma_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+	.cable_detect		= ata_cable_40wire,
+
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
+	.data_xfer		= pata_at32_data_xfer,
+
+	.irq_clear		= pata_at32_irq_clear,
+	.irq_on			= ata_irq_on,
+	.irq_ack		= ata_irq_ack,
+
+	.port_start		= ata_sff_port_start,
+};
+
+static int pata_at32_init_one(struct device *dev, struct at32_ide_info *info)
+{
+	struct ata_host *host;
+	struct ata_port *ap;
+
+	host = ata_host_alloc(dev, 1);
+	if (!host)
+		return -ENOMEM;
+
+	ap = host->ports[0];
+
+	/* Setup ATA bindings */
+	ap->ops	     = &at32_port_ops;
+	ap->pio_mask = pata_at32_get_pio_mask();
+	ap->flags    = ATA_FLAG_MMIO
+		| ATA_FLAG_SLAVE_POSS | ATA_FLAG_PIO_POLLING;
+
+	/*
+	 * Since all 8-bit taskfile transfers has to go on the lower
+	 * byte of the data bus and there is a bug in the SMC that
+	 * makes it impossible to alter the bus width during runtime,
+	 * we need to hardwire the address signals as follows:
+	 *
+	 *	A_IDE(2:0) <= A_EBI(3:1)
+	 *
+	 * This makes all addresses on the EBI even, thus all data
+	 * will be on the lower byte of the data bus.  All addresses
+	 * used by libATA need to be altered according to this.
+	 */
+	ap->ioaddr.altstatus_addr = info->alt_addr + (0x06 << 1);
+	ap->ioaddr.ctl_addr	  = info->alt_addr + (0x06 << 1);
+
+	ap->ioaddr.data_addr	  = info->ide_addr + (ATA_REG_DATA << 1);
+	ap->ioaddr.error_addr	  = info->ide_addr + (ATA_REG_ERR << 1);
+	ap->ioaddr.feature_addr	  = info->ide_addr + (ATA_REG_FEATURE << 1);
+	ap->ioaddr.nsect_addr	  = info->ide_addr + (ATA_REG_NSECT << 1);
+	ap->ioaddr.lbal_addr	  = info->ide_addr + (ATA_REG_LBAL << 1);
+	ap->ioaddr.lbam_addr	  = info->ide_addr + (ATA_REG_LBAM << 1);
+	ap->ioaddr.lbah_addr	  = info->ide_addr + (ATA_REG_LBAH << 1);
+	ap->ioaddr.device_addr	  = info->ide_addr + (ATA_REG_DEVICE << 1);
+	ap->ioaddr.status_addr	  = info->ide_addr + (ATA_REG_STATUS << 1);
+	ap->ioaddr.command_addr	  = info->ide_addr + (ATA_REG_CMD << 1);
+
+	/* Set info as private data of ATA host */
+	host->private_data = info;
+
+	/* Register ATA device and return */
+	return ata_host_activate(host, info->irq, ata_interrupt,
+				 IRQF_SHARED | IRQF_TRIGGER_RISING,
+				 &at32_sht);
+}
+
+/*
+ * This function may come in handy for people analyzing their own
+ * EBI -> PATA adaptors.
+ */
+#ifdef DEBUG_BUS
+
+static void __init pata_at32_debug_bus(struct device *dev,
+				       struct at32_ide_info *info)
+{
+	const int d1 = 0xff;
+	const int d2 = 0x00;
+
+	int i, ctld;
+	int iod[8];
+
+	iowrite8(d1, info->alt_addr + (0x06 << 1));
+	iowrite8(d2, info->alt_addr + (0x06 << 1));
+
+	for (i = 0; i < 8; i++) {
+		iowrite8(d1, info->ide_addr + (i << 1));
+		iowrite8(d2, info->ide_addr + (i << 1));
+	}
+
+	ctld = ioread8(info->alt_addr + (0x06 << 1));
+
+	for (i = 0; i < 8; i++)
+		iod[i] = ioread8(info->ide_addr + (i << 1));
+
+	iowrite16(d1,	   info->ide_addr);
+	iowrite16(d1 << 8, info->ide_addr);
+
+	iowrite16(d1,	   info->ide_addr);
+	iowrite16(d1 << 8, info->ide_addr);
+
+	dev_dbg(dev, "CTL = %x\n", ctld);
+
+	for (i = 0; i < 8; i++)
+		dev_dbg(dev, "IO%d = %x\n", i, iod[i]);
+}
+
+#endif
+
+static int __init pata_at32_probe(struct platform_device *pdev)
+{
+	const struct ata_timing initial_timing =
+		{XFER_PIO_0, 70, 290, 240, 600, 165, 150, 600, 0};
+
+	struct device		 *dev = &pdev->dev;
+	struct at32_ide_info	 *info;
+	struct ide_platform_data *board = pdev->dev.platform_data;
+	struct resource		 *res;
+
+	int irq;
+	int ret;
+
+	if (!board)
+		return -ENXIO;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENXIO;
+
+	/* Retrive IRQ */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	/* Setup struct containing private infomation */
+	info = kzalloc(sizeof(struct at32_ide_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	memset(info, 0, sizeof(struct at32_ide_info));
+
+	info->cs = board->cs;
+	info->smc_pio_mode = 0;
+	info->irq = irq;
+
+	/* Request memory resources */
+	info->res_ide.start = res->start + CF_IDE_OFFSET;
+	info->res_ide.end   = info->res_ide.start + CF_RES_SIZE - 1;
+	info->res_ide.name  = "ide";
+	info->res_ide.flags = IORESOURCE_MEM;
+
+	ret = request_resource(res, &info->res_ide);
+	if (ret)
+		goto err_req_res_ide;
+
+	info->res_alt.start = res->start + CF_ALT_IDE_OFFSET;
+	info->res_alt.end   = info->res_alt.start + CF_RES_SIZE - 1;
+	info->res_alt.name  = "alt";
+	info->res_alt.flags = IORESOURCE_MEM;
+
+	ret = request_resource(res, &info->res_alt);
+	if (ret)
+		goto err_req_res_alt;
+
+	/* Setup SMC, see Atmel AVR32 AP7000 datasheet chapter 27 */
+	info->smc_8.bus_width	   = 2; /* 16 bit data bus */
+	info->smc_8.nrd_controlled = 1; /* Sample data on rising edge of NRD */
+	info->smc_8.nwe_controlled = 0; /* Drive data on falling edge of NCS */
+	info->smc_8.nwait_mode	   = 3; /* NWAIT is in READY mode */
+	info->smc_8.byte_write	   = 0; /* Byte select access type */
+	info->smc_8.tdf_mode	   = 1; /* TDF optimization enabled */
+
+	info->smc_16 = info->smc_8;
+
+	/* Setup ATA timing */
+	ret = pata_at32_setup_timing(dev, info, &initial_timing);
+	if (ret)
+		goto err_setup_timing;
+
+	/* Setup ATA addresses */
+	ret = -ENOMEM;
+	info->ide_addr = devm_ioremap(dev, info->res_ide.start, 16);
+	info->alt_addr = devm_ioremap(dev, info->res_alt.start, 16);
+	if (!info->ide_addr || !info->alt_addr)
+		goto err_ioremap;
+
+#ifdef DEBUG_BUS
+	pata_at32_debug_bus(dev, info);
+#endif
+
+	/* Register ATA device */
+	ret = pata_at32_init_one(dev, info);
+	if (ret)
+		goto err_ata_device;
+
+	return 0;
+
+ err_ata_device:
+ err_ioremap:
+ err_setup_timing:
+	release_resource(&info->res_alt);
+ err_req_res_alt:
+	release_resource(&info->res_ide);
+ err_req_res_ide:
+	kfree(info);
+
+	return ret;
+}
+
+static int __exit pata_at32_remove(struct platform_device *pdev)
+{
+	struct ata_host *host = platform_get_drvdata(pdev);
+	struct at32_ide_info *info;
+
+	if (!host)
+		return 0;
+
+	info = host->private_data;
+	ata_host_detach(host);
+
+	if (!info)
+		return 0;
+
+	release_resource(&info->res_ide);
+	release_resource(&info->res_alt);
+
+	kfree(info);
+
+	return 0;
+}
+
+static struct platform_driver pata_at32_driver = {
+	.remove	       = __exit_p(pata_at32_remove),
+	.driver	       = {
+		.name  = "at32_ide",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init pata_at32_init(void)
+{
+	return platform_driver_probe(&pata_at32_driver, pata_at32_probe);
+}
+
+static void __exit pata_at32_exit(void)
+{
+	platform_driver_unregister(&pata_at32_driver);
+}
+
+module_init(pata_at32_init);
+module_exit(pata_at32_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("AVR32 SMC/CFC PATA Driver");
+MODULE_AUTHOR("Kristoffer Nyborg Gregertsen <kngregertsen@norway.atmel.com>");
+MODULE_VERSION(DRV_VERSION);
