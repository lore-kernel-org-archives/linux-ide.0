From: =?ISO-8859-15?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Mon, 18 May 2009 14:49:15 +0100
Message-ID: <4A11675B.9050704@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <200905142144.14279.bzolnier@gmail.com> <4A0D9FD7.5050608@inov.pt> <200905171816.44069.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080208070401040408020801"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:41139 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbZERNt7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 May 2009 09:49:59 -0400
In-Reply-To: <200905171816.44069.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080208070401040408020801
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Here is the revised patch according to Bart's suggestions in previous 
emails.
The patch is against linux-2.6.30-rc6.

Best regards,
João Ramos

-- 
************************************************************************

    João Ramos        <joao.ramos@inov.pt>

    INOV INESC Inovação - ESTG Leiria
    Escola Superior de Tecnologia e Gestão de Leiria
    Edíficio C1, Campus 2
    Morro do Lena, Alto do Vieiro
    Leiria
    2411-901 Leiria
    Portugal

    Tel: +351244843424
    Fax: +351244843424

************************************************************************


--------------080208070401040408020801
Content-Type: text/x-patch;
 name="ep93xx-ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ep93xx-ide.patch"

Add IDE host controller support for Cirrus Logic's EP93xx CPUs.

Signed-off-by: Joao Ramos <joao.ramos@inov.pt>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.montavista.com>

---

diff -urN linux-2.6.30-rc6.orig/drivers/ide/ep93xx-ide.c linux-2.6.30-rc6/drivers/ide/ep93xx-ide.c
--- linux-2.6.30-rc6.orig/drivers/ide/ep93xx-ide.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.30-rc6/drivers/ide/ep93xx-ide.c	2009-05-18 14:40:58.000000000 +0100
@@ -0,0 +1,524 @@
+/*
+ * Support for Cirrus Logic's EP93xx (EP9312, EP9315) CPUs
+ * IDE host controller driver.
+ *
+ * Copyright (c) 2009, Joao Ramos <joao.ramos@inov.pt>
+ *                     INESC Inovacao (INOV)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/ide.h>
+#include <linux/delay.h>
+
+#define	MODULE_NAME	"ep93xx-ide"
+
+/*
+ * Configuration and usage of the IDE device is made through the
+ * IDE Interface Register Map (EP93xx User's Guide, Section 27).
+ *
+ * This section holds common registers and flag definitions for
+ * that interface.
+ */
+
+/*
+ * IDE Register offset
+ */
+#define	IDECTRL			0x00
+#define	IDECFG			0x04
+#define	IDEMDMAOP		0x08
+#define	IDEUDMAOP		0x0C
+#define	IDEDATAOUT		0x10
+#define	IDEDATAIN		0x14
+#define	IDEMDMADATAOUT		0x18
+#define	IDEMDMADATAIN		0x1C
+#define	IDEUDMADATAOUT		0x20
+#define	IDEUDMADATAIN		0x24
+#define	IDEUDMASTS		0x28
+#define	IDEUDMADEBUG		0x2C
+#define	IDEUDMAWRBUFSTS		0x30
+#define	IDEUDMARDBUFSTS		0x34
+
+/*
+ * IDE Control Register bit fields
+ */
+#define	IDECTRL_CS0N		0x00000001
+#define	IDECTRL_CS1N		0x00000002
+#define	IDECTRL_DA		0x0000001C
+#define	IDECTRL_DIORN		0x00000020
+#define	IDECTRL_DIOWN		0x00000040
+#define	IDECTRL_DASPN		0x00000080
+#define	IDECTRL_DMARQ		0x00000100
+#define	IDECTRL_INTRQ		0x00000200
+#define	IDECTRL_IORDY		0x00000400
+
+/*
+ * IDE Configuration Register bit fields
+ */
+#define	IDECFG_IDEEN		0x00000001
+#define	IDECFG_PIO		0x00000002
+#define	IDECFG_MDMA		0x00000004
+#define	IDECFG_UDMA		0x00000008
+#define	IDECFG_PIO_MODE_0	0x00000000
+#define	IDECFG_PIO_MODE_1	0x00000010
+#define	IDECFG_PIO_MODE_2	0x00000020
+#define	IDECFG_PIO_MODE_3	0x00000030
+#define	IDECFG_PIO_MODE_4	0x00000040
+#define	IDECFG_MDMA_MODE_0	0x00000000
+#define	IDECFG_MDMA_MODE_1	0x00000010
+#define	IDECFG_MDMA_MODE_2	0x00000020
+#define	IDECFG_UDMA_MODE_0	0x00000000
+#define	IDECFG_UDMA_MODE_1	0x00000010
+#define	IDECFG_UDMA_MODE_2	0x00000020
+#define	IDECFG_UDMA_MODE_3	0x00000030
+#define	IDECFG_UDMA_MODE_4	0x00000040
+#define	IDECFG_WST		0x00000300
+
+/*
+ * Check whether IORDY is asserted or not.
+ */
+static inline int ep93xx_ide_check_iordy(void __iomem *base)
+{
+	u32 reg = readl(base + IDECTRL);
+
+	return (reg & IDECTRL_IORDY) ? 1 : 0;
+}
+
+/*
+ * IDE Interface register map default state
+ * (shutdown)
+ */
+static void ep93xx_ide_clean_regs(void __iomem *base)
+{
+	/* disable IDE interface initially */
+	writel(IDECTRL_CS0N | IDECTRL_CS1N | IDECTRL_DIORN |
+		IDECTRL_DIOWN, base + IDECTRL);
+
+	/* clear IDE registers */
+	writel(0, base + IDECFG);
+	writel(0, base + IDEMDMAOP);
+	writel(0, base + IDEUDMAOP);
+	writel(0, base + IDEDATAOUT);
+	writel(0, base + IDEDATAIN);
+	writel(0, base + IDEMDMADATAOUT);
+	writel(0, base + IDEMDMADATAIN);
+	writel(0, base + IDEUDMADATAOUT);
+	writel(0, base + IDEUDMADATAIN);
+	writel(0, base + IDEUDMADEBUG);
+}
+
+static u16 ep93xx_ide_read(void __iomem *base, unsigned long addr,
+		struct ide_timing *timing)
+{
+	u32 reg;
+
+	reg = addr | IDECTRL_DIORN | IDECTRL_DIOWN;
+	writel(reg, base + IDECTRL);
+	ndelay(timing->setup);
+
+	reg &= ~IDECTRL_DIORN;
+	writel(reg, base + IDECTRL);
+	ndelay(timing->active);
+
+	while (!ep93xx_ide_check_iordy(base))
+		cpu_relax();
+
+	reg |= IDECTRL_DIORN;
+	writel(reg, base + IDECTRL);
+	ndelay(timing->recover);
+
+	return readl(base + IDEDATAIN);
+}
+
+static void ep93xx_ide_write(void __iomem *base, u16 value,
+		unsigned long addr, struct ide_timing *timing)
+{
+	u32 reg;
+
+	reg = addr | IDECTRL_DIORN | IDECTRL_DIOWN;
+	writel(reg, base + IDECTRL);
+	ndelay(timing->setup);
+
+	writel(value, base + IDEDATAOUT);
+
+	reg &= ~IDECTRL_DIOWN;
+	writel(reg, base + IDECTRL);
+	ndelay(timing->active);
+
+	while (!ep93xx_ide_check_iordy(base))
+		cpu_relax();
+
+	reg |= IDECTRL_DIOWN;
+	writel(reg, base + IDECTRL);
+	ndelay(timing->recover);
+}
+
+/*
+ * EP93xx IDE PIO Transport Operations
+ */
+
+static void ep93xx_ide_exec_command(struct hwif_s *hwif, u8 cmd)
+{
+	void __iomem *base = hwif->host->host_priv;
+	struct ide_timing *t = (struct ide_timing *)ide_get_hwifdata(hwif);
+
+	ep93xx_ide_write(base, cmd, hwif->io_ports.command_addr, t);
+}
+
+static u8 ep93xx_ide_read_status(ide_hwif_t *hwif)
+{
+	void __iomem *base = hwif->host->host_priv;
+	struct ide_timing *t = (struct ide_timing *)ide_get_hwifdata(hwif);
+
+	return ep93xx_ide_read(base, hwif->io_ports.status_addr, t);
+}
+
+static u8 ep93xx_ide_read_altstatus(ide_hwif_t *hwif)
+{
+	void __iomem *base = hwif->host->host_priv;
+	struct ide_timing *t = (struct ide_timing *)ide_get_hwifdata(hwif);
+
+	return ep93xx_ide_read(base, hwif->io_ports.ctl_addr, t);
+}
+
+static void ep93xx_ide_write_devctl(ide_hwif_t *hwif, u8 ctl)
+{
+	void __iomem *base = hwif->host->host_priv;
+	struct ide_timing *t = (struct ide_timing *)ide_get_hwifdata(hwif);
+
+	ep93xx_ide_write(base, ctl, hwif->io_ports.ctl_addr, t);
+}
+
+static void ep93xx_ide_dev_select(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	void __iomem *base = hwif->host->host_priv;
+	u8 select = drive->select | ATA_DEVICE_OBS;
+	struct ide_timing *t = (struct ide_timing *)ide_get_hwifdata(hwif);
+
+	ep93xx_ide_write(base, select, hwif->io_ports.device_addr, t);
+}
+
+static void ep93xx_ide_tf_load(ide_drive_t *drive, struct ide_taskfile *tf,
+		u8 valid)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	void __iomem *base = hwif->host->host_priv;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_timing *t = (struct ide_timing *)ide_get_hwifdata(hwif);
+
+	if (valid & IDE_VALID_FEATURE)
+		ep93xx_ide_write(base, tf->feature, io_ports->feature_addr, t);
+	if (valid & IDE_VALID_NSECT)
+		ep93xx_ide_write(base, tf->nsect, io_ports->nsect_addr, t);
+	if (valid & IDE_VALID_LBAL)
+		ep93xx_ide_write(base, tf->lbal, io_ports->lbal_addr, t);
+	if (valid & IDE_VALID_LBAM)
+		ep93xx_ide_write(base, tf->lbam, io_ports->lbam_addr, t);
+	if (valid & IDE_VALID_LBAH)
+		ep93xx_ide_write(base, tf->lbah, io_ports->lbah_addr, t);
+	if (valid & IDE_VALID_DEVICE)
+		ep93xx_ide_write(base, tf->device, io_ports->device_addr, t);
+}
+
+static void ep93xx_ide_tf_read(ide_drive_t *drive, struct ide_taskfile *tf,
+		u8 valid)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	void __iomem *base = hwif->host->host_priv;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_timing *t = (struct ide_timing *)ide_get_hwifdata(hwif);
+
+	if (valid & IDE_VALID_ERROR)
+		tf->error = ep93xx_ide_read(base, io_ports->feature_addr, t);
+	if (valid & IDE_VALID_NSECT)
+		tf->nsect = ep93xx_ide_read(base, io_ports->nsect_addr, t);
+	if (valid & IDE_VALID_LBAL)
+		tf->lbal = ep93xx_ide_read(base, io_ports->lbal_addr, t);
+	if (valid & IDE_VALID_LBAM)
+		tf->lbam = ep93xx_ide_read(base, io_ports->lbam_addr, t);
+	if (valid & IDE_VALID_LBAH)
+		tf->lbah = ep93xx_ide_read(base, io_ports->lbah_addr, t);
+	if (valid & IDE_VALID_DEVICE)
+		tf->device = ep93xx_ide_read(base, io_ports->device_addr, t);
+}
+
+static void ep93xx_ide_input_data(ide_drive_t *drive, struct ide_cmd *cmd,
+		void *buf, unsigned int len)
+{
+	u16 *data = (u16 *)buf;
+	ide_hwif_t *hwif = drive->hwif;
+	void __iomem *base = hwif->host->host_priv;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	unsigned int words = (len + 1) >> 1;
+	struct ide_timing *t = (struct ide_timing *)ide_get_hwifdata(hwif);
+
+	while (words--)
+		*data++ = cpu_to_le16(ep93xx_ide_read(base,
+					io_ports->data_addr, t));
+}
+
+static void ep93xx_ide_output_data(ide_drive_t *drive, struct ide_cmd *cmd,
+		void *buf, unsigned int len)
+{
+	u16 *data = (u16 *)buf;
+	ide_hwif_t *hwif = drive->hwif;
+	void __iomem *base = hwif->host->host_priv;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	unsigned int words = (len + 1) >> 1;
+	struct ide_timing *t = (struct ide_timing *)ide_get_hwifdata(hwif);
+
+	while (words--)
+		ep93xx_ide_write(base, le16_to_cpu(*data++),
+			io_ports->data_addr, t);
+}
+
+static struct ide_tp_ops ep93xx_ide_tp_ops = {
+	.exec_command	= ep93xx_ide_exec_command,
+	.read_status	= ep93xx_ide_read_status,
+	.read_altstatus = ep93xx_ide_read_altstatus,
+	.write_devctl	= ep93xx_ide_write_devctl,
+	.dev_select	= ep93xx_ide_dev_select,
+	.tf_load	= ep93xx_ide_tf_load,
+	.tf_read	= ep93xx_ide_tf_read,
+	.input_data 	= ep93xx_ide_input_data,
+	.output_data	= ep93xx_ide_output_data,
+};
+
+static void ep93xx_ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
+{
+	ide_drive_t *pair = ide_get_pair_dev(drive);
+	struct ide_timing *t = ide_timing_find_mode(XFER_PIO_0 + pio);
+	struct ide_timing *cmd_t = t;
+	u32 reg = IDECFG_IDEEN | IDECFG_PIO;
+	void __iomem *base = drive->hwif->host->host_priv;
+
+	if (pair) {
+		struct ide_timing *pair_t = ide_get_drivedata(pair);
+
+		if (pair_t && pair_t->mode < t->mode)
+			cmd_t = pair_t;
+	}
+
+	/*
+	 * store the adequate PIO mode timings, to be used later
+	 * by ep93xx_ide_{read,write}
+	 */
+	ide_set_drivedata(drive, (void *)t);
+	ide_set_hwifdata(drive->hwif, (void *)cmd_t);
+
+	/* reconfigure IDE controller according to PIO mode */
+	switch (pio) {
+	case 4:
+		reg |= IDECFG_PIO_MODE_4 | ((1 << 8) & IDECFG_WST);
+		break;
+	case 3:
+		reg |= IDECFG_PIO_MODE_3 | ((1 << 8) & IDECFG_WST);
+		break;
+	case 2:
+		reg |= IDECFG_PIO_MODE_2 | ((2 << 8) & IDECFG_WST);
+		break;
+	case 1:
+		reg |= IDECFG_PIO_MODE_1 | ((2 << 8) & IDECFG_WST);
+		break;
+	case 0:
+	default:
+		reg |= IDECFG_PIO_MODE_0 | ((3 << 8) & IDECFG_WST);
+		break;
+	}
+	writel(reg, base + IDECFG);
+}
+
+static struct ide_port_ops ep93xx_ide_port_ops = {
+	.set_pio_mode = ep93xx_ide_set_pio_mode,
+};
+
+static struct ide_port_info ep93xx_ide_port_info = {
+	.name		= MODULE_NAME,
+	.tp_ops 	= &ep93xx_ide_tp_ops,
+	.port_ops 	= &ep93xx_ide_port_ops,
+	.host_flags 	= IDE_HFLAG_SINGLE | IDE_HFLAG_POST_SET_MODE |
+			  IDE_HFLAG_NO_DMA | IDE_HFLAG_MMIO |
+			  IDE_HFLAG_NO_IO_32BIT | IDE_HFLAG_NO_UNMASK_IRQS,
+	.pio_mask 	= ATA_PIO4,
+};
+
+static int __init ep93xx_ide_probe(struct platform_device *pdev)
+{
+	int retval;
+	int irq;
+	void __iomem *ide_base;
+	struct resource *mem_res;
+	hw_regs_t hw;
+	hw_regs_t *hws[] = { &hw, NULL, NULL, NULL };
+	struct ide_host *host;
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem_res) {
+		dev_err(&pdev->dev,
+			"could not retrieve device memory resources!\n");
+		return -ENXIO;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev,
+			"could not retrieve device IRQ resource!\n");
+		return -ENXIO;
+	}
+
+	if (!request_mem_region
+	    (mem_res->start, mem_res->end - mem_res->start + 1, MODULE_NAME)) {
+		dev_err(&pdev->dev, "could not request memory resources!\n");
+		return -EBUSY;
+	}
+
+	ide_base = ioremap(mem_res->start, mem_res->end - mem_res->start + 1);
+	if (!ide_base) {
+		dev_err(&pdev->dev, "could not map memory resources!\n");
+		retval = -ENOMEM;
+		goto fail_release_mem;
+	}
+
+	memset(&hw, 0, sizeof(hw));
+
+	/*
+	 * fill in ide_io_ports structure.
+	 * the device IDE register to be accessed is selected through
+	 * IDECTRL register's specific bitfields 'DA', 'CS1n' and 'CS0n':
+	 *   b4   b3   b2    b1     b0
+	 *   A2   A1   A0   CS1n   CS0n
+	 * the values filled in this structure allows the value to be directly
+	 * ORed to the IDECTRL register, hence giving directly the A[2:0] and
+	 * CS1n/CS0n values for each IDE register.
+	 * The values correspond to the transformation:
+	 *   ((real IDE address) << 2) | CS1n value << 1 | CS0n value
+	 */
+	hw.io_ports.data_addr = 0x02;
+	hw.io_ports.error_addr = 0x06;
+	hw.io_ports.nsect_addr = 0x0A;
+	hw.io_ports.lbal_addr = 0x0E;
+	hw.io_ports.lbam_addr = 0x12;
+	hw.io_ports.lbah_addr = 0x16;
+	hw.io_ports.device_addr = 0x1A;
+	hw.io_ports.command_addr = 0x1E;
+	hw.io_ports.ctl_addr = 0x01;
+
+	hw.irq = irq;
+	hw.chipset = ide_generic;
+	hw.dev = &pdev->dev;
+
+	/* enforce EP93xx IDE controller reset state */
+	ep93xx_ide_clean_regs(ide_base);
+
+	/* set gpio port E, G and H for IDE */
+	ep93xx_ide_aquire_gpios();
+
+	/*
+	 * configure IDE interface:
+	 *   - IDE Master Enable
+	 *   - Polled IO Operation
+	 *   - PIO Mode 0 -> 3.33 MBps
+	 *   - 3 Wait States -> 30 ns
+	 */
+	writel(IDECFG_IDEEN | IDECFG_PIO | IDECFG_PIO_MODE_0 |
+		((3 << 8) & IDECFG_WST), ide_base + IDECFG);
+
+	host = ide_host_alloc(&ep93xx_ide_port_info, hws);
+	if (!host) {
+		dev_err(&pdev->dev,
+			"failed to allocate memory for EP93xx IDE host!\n");
+		retval = -ENOMEM;
+		goto fail_unmap;
+	}
+
+	host->host_priv = ide_base;
+
+	retval = ide_host_register(host, &ep93xx_ide_port_info, hws);
+	if (retval) {
+		dev_err(&pdev->dev,
+			"unable to register EP93xx IDE driver!\n");
+		goto fail_free_host;
+	}
+
+	platform_set_drvdata(pdev, host);
+
+	dev_info(&pdev->dev, "EP93xx IDE host controller driver initialized\n");
+
+	return 0;
+
+fail_free_host:
+	ide_host_free(host);
+fail_unmap:
+	iounmap(ide_base);
+fail_release_mem:
+	release_mem_region(mem_res->start, mem_res->end - mem_res->start + 1);
+	return retval;
+}
+
+static int __devexit ep93xx_ide_remove(struct platform_device *pdev)
+{
+	struct resource *mem_res;
+	struct ide_host *host = pdev->dev.driver_data;
+	void __iomem *base = host->host_priv;
+
+	/* reset state */
+	ep93xx_ide_clean_regs(host->host_priv);
+
+	/* restore back GPIO port E, G and H for GPIO use */
+	ep93xx_ide_release_gpios();
+
+	ide_host_remove(host);
+
+	iounmap(base);
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(mem_res->start, mem_res->end - mem_res->start + 1);
+
+	return 0;
+}
+
+static struct platform_driver ep93xx_ide_driver = {
+	.remove = __exit_p(ep93xx_ide_remove),
+	.driver = {
+		.name	= MODULE_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init ep93xx_ide_init(void)
+{
+	return platform_driver_probe(&ep93xx_ide_driver, ep93xx_ide_probe);
+}
+module_init(ep93xx_ide_init);
+
+static void __exit ep93xx_ide_exit(void)
+{
+	platform_driver_unregister(&ep93xx_ide_driver);
+}
+module_exit(ep93xx_ide_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Joao Ramos <joao.ramos@inov.pt>");
+MODULE_DESCRIPTION("EP93xx IDE host controller driver");
+MODULE_VERSION("1.0");
+MODULE_ALIAS("platform:ep93xx-ide");
diff -urN linux-2.6.30-rc6.orig/drivers/ide/Kconfig linux-2.6.30-rc6/drivers/ide/Kconfig
--- linux-2.6.30-rc6.orig/drivers/ide/Kconfig	2009-05-16 05:12:57.000000000 +0100
+++ linux-2.6.30-rc6/drivers/ide/Kconfig	2009-05-18 14:40:16.000000000 +0100
@@ -732,6 +732,19 @@
 	depends on ARM && ARCH_AT91 && !ARCH_AT91RM9200 && !ARCH_AT91X40
 	select IDE_TIMINGS
 
+config BLK_DEV_IDE_EP93XX
+	tristate "Cirrus Logic EPxx (EP9312, EP9315) IDE support"
+	depends on ARM && ARCH_EP93XX
+	select IDE_TIMINGS
+	help
+	  This is a host controller driver for IDE hardware included in
+	  Cirrus Logic's EP9312 and EP9315 CPUs.
+	  Say Y here if you want to enable the IDE host controller support
+	  for your machine.
+
+	  Choose 'M' to compile this driver as a module; the module will be
+	  called 'ep93xx-ide'.
+
 config BLK_DEV_IDE_ICSIDE
 	tristate "ICS IDE interface support"
 	depends on ARM && ARCH_ACORN
diff -urN linux-2.6.30-rc6.orig/drivers/ide/Makefile linux-2.6.30-rc6/drivers/ide/Makefile
--- linux-2.6.30-rc6.orig/drivers/ide/Makefile	2009-05-16 05:12:57.000000000 +0100
+++ linux-2.6.30-rc6/drivers/ide/Makefile	2009-05-18 14:40:16.000000000 +0100
@@ -117,3 +117,4 @@
 obj-$(CONFIG_BLK_DEV_IDE_TX4938)	+= tx4938ide.o
 obj-$(CONFIG_BLK_DEV_IDE_TX4939)	+= tx4939ide.o
 obj-$(CONFIG_BLK_DEV_IDE_AT91)		+= at91_ide.o
+obj-$(CONFIG_BLK_DEV_IDE_EP93XX)	+= ep93xx-ide.o

--------------080208070401040408020801--
