From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Wed, 13 May 2009 15:18:39 +0100
Message-ID: <4A0AD6BF.5030300@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <4A08079A.9080803@inov.pt> <4A09A8A1.5070002@ru.mvista.com> <200905121923.08159.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070009020905020705000809"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:52439 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753296AbZEMOTN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 May 2009 10:19:13 -0400
In-Reply-To: <200905121923.08159.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070009020905020705000809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

In attachment I send the revised patch for the EP93xx CPU IDE controller 
(well, not entirely, only the IDE bit, I letf out the platform code as 
suggested), changed and fixed according to all the comments you made before.

This driver depends on the previous patches I sent (ide_drive_data patch 
and set_pio_mode patch).

Please make your suggestions.

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


--------------070009020905020705000809
Content-Type: text/plain;
 name="linux-2.6.30-rc4-ep93xx-ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.30-rc4-ep93xx-ide.patch"

diff -urN linux-2.6.30-rc4.orig/drivers/ide/ep93xx-ide.c linux-2.6.30-rc4/drivers/ide/ep93xx-ide.c
--- linux-2.6.30-rc4.orig/drivers/ide/ep93xx-ide.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.30-rc4/drivers/ide/ep93xx-ide.c	2009-05-13 14:47:02.000000000 +0100
@@ -0,0 +1,528 @@
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
+#define	IDEMDMADATAOUT	0x18
+#define	IDEMDMADATAIN	0x1C
+#define	IDEUDMADATAOUT	0x20
+#define	IDEUDMADATAIN	0x24
+#define	IDEUDMASTS		0x28
+#define	IDEUDMADEBUG	0x2C
+#define	IDEUDMAWRBUFSTS	0x30
+#define	IDEUDMARDBUFSTS	0x34
+
+/*
+ * IDE Control Register bit fields
+ */
+#define	IDECTRL_CS0N	0x00000001
+#define	IDECTRL_CS1N	0x00000002
+#define	IDECTRL_DA		0x0000001C
+#define	IDECTRL_DIORN	0x00000020
+#define	IDECTRL_DIOWN	0x00000040
+#define	IDECTRL_DASPN	0x00000080
+#define	IDECTRL_DMARQ	0x00000100
+#define	IDECTRL_INTRQ	0x00000200
+#define	IDECTRL_IORDY	0x00000400
+
+/*
+ * IDE Configuration Register bit fields
+ */
+#define	IDECFG_IDEEN		0x00000001
+#define	IDECFG_PIO			0x00000002
+#define	IDECFG_MDMA			0x00000004
+#define	IDECFG_UDMA			0x00000008
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
+#define	IDECFG_WST			0x00000300
+
+/*
+ * readl/writel helpers to access internal registers using
+ * an ioremapped cookie and the specified IDE register offset
+ */
+
+static inline u32 ep93xx_readl(unsigned long base, u8 offset)
+{
+	return readl((void __iomem *)(base + offset));
+}
+
+static inline void ep93xx_writel(u32 value, unsigned long base, u8 offset)
+{
+	writel(value, (void __iomem *)(base + offset));
+}
+
+/*
+ * Check whether IORDY is asserted or not.
+ */
+static inline int ep93xx_ide_check_iordy(unsigned long base)
+{
+	u32	reg	= ep93xx_readl(base, IDECTRL);
+
+	return (reg & IDECTRL_IORDY) ? 1 : 0;
+}
+
+/*
+ * IDE Interface register map default state
+ * (shutdown)
+ */
+static void ep93xx_ide_clean_regs(unsigned long base)
+{
+	/* disable IDE interface initially */
+	ep93xx_writel(IDECTRL_CS0N | IDECTRL_CS1N | IDECTRL_DIORN |
+			IDECTRL_DIOWN, base, IDECTRL);
+
+	/* clear IDE registers */
+	ep93xx_writel(0, base, IDECFG);
+	ep93xx_writel(0, base, IDEMDMAOP);
+	ep93xx_writel(0, base, IDEUDMAOP);
+	ep93xx_writel(0, base, IDEDATAOUT);
+	ep93xx_writel(0, base, IDEDATAIN);
+	ep93xx_writel(0, base, IDEMDMADATAOUT);
+	ep93xx_writel(0, base, IDEMDMADATAIN);
+	ep93xx_writel(0, base, IDEUDMADATAOUT);
+	ep93xx_writel(0, base, IDEUDMADATAIN);
+	ep93xx_writel(0, base, IDEUDMADEBUG);
+}
+
+static u16 ep93xx_ide_read(unsigned long base, unsigned long addr,
+				struct ide_timing *timing)
+{
+	u32 reg;
+
+	reg = ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DIORN |
+		IDECTRL_DIOWN;
+	ep93xx_writel(reg, base, IDECTRL);
+	ndelay(timing->setup);
+
+	reg &= ~IDECTRL_DIORN;
+	ep93xx_writel(reg, base, IDECTRL);
+	ndelay(timing->active);
+
+	while (!ep93xx_ide_check_iordy(base))
+		cpu_relax();
+
+	reg |= IDECTRL_DIORN;
+	ep93xx_writel(reg, base, IDECTRL);
+	ndelay(timing->recover);
+
+	return ep93xx_readl(base, IDEDATAIN);
+}
+
+static void ep93xx_ide_write(unsigned long base, u16 value,
+				unsigned long addr, struct ide_timing *timing)
+{
+	u32 reg;
+
+	reg = ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DIORN |
+	    IDECTRL_DIOWN;
+	ep93xx_writel(reg, base, IDECTRL);
+	ndelay(timing->setup);
+
+	ep93xx_writel(value, base, IDEDATAOUT);
+
+	reg &= ~IDECTRL_DIOWN;
+	ep93xx_writel(reg, base, IDECTRL);
+	ndelay(timing->active);
+
+	while (!ep93xx_ide_check_iordy(base))
+		cpu_relax();
+
+	reg |= IDECTRL_DIOWN;
+	ep93xx_writel(reg, base, IDECTRL);
+	ndelay(timing->recover);
+}
+
+static void ep93xx_ide_readsw(unsigned long base, unsigned long addr,
+				void *buf, unsigned int len, struct ide_timing *timing)
+{
+	u16 *data = (u16 *) buf;
+
+	while (len--)
+		*data++ = cpu_to_le16(ep93xx_ide_read(base, addr, timing));
+}
+
+static void ep93xx_ide_writesw(unsigned long base, unsigned long addr,
+				void *buf, unsigned int len, struct ide_timing *timing)
+{
+	u16 *data = (u16 *) buf;
+
+	while (len--)
+		ep93xx_ide_write(base, le16_to_cpu(*data++), addr, timing);
+}
+
+/*
+ * EP93xx IDE PIO Transport Operations
+ */
+
+static void ep93xx_ide_exec_command(struct hwif_s *hwif, u8 cmd)
+{
+	ide_drive_t *drive = hwif->devices[0];
+	struct ide_timing *t = (struct ide_timing *) ide_get_drivedata(drive);
+
+	ep93xx_ide_write(hwif->config_data, cmd, hwif->io_ports.command_addr, t);
+}
+
+static u8 ep93xx_ide_read_status(ide_hwif_t *hwif)
+{
+	ide_drive_t *drive = hwif->devices[0];
+	struct ide_timing *t = (struct ide_timing *) ide_get_drivedata(drive);
+
+	return ep93xx_ide_read(hwif->config_data, hwif->io_ports.status_addr, t);
+}
+
+static u8 ep93xx_ide_read_altstatus(ide_hwif_t *hwif)
+{
+	ide_drive_t *drive = hwif->devices[0];
+	struct ide_timing *t = (struct ide_timing *) ide_get_drivedata(drive);
+
+	return ep93xx_ide_read(hwif->config_data, hwif->io_ports.ctl_addr, t);
+}
+
+static void ep93xx_ide_write_devctl(ide_hwif_t *hwif, u8 ctl)
+{
+	ide_drive_t *drive = hwif->devices[0];
+	struct ide_timing *t = (struct ide_timing *) ide_get_drivedata(drive);
+
+	ep93xx_ide_write(hwif->config_data, ctl, hwif->io_ports.ctl_addr, t);
+}
+
+static void ep93xx_ide_dev_select(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u8 select = drive->select | ATA_DEVICE_OBS;
+	struct ide_timing *t = (struct ide_timing *) ide_get_drivedata(drive);
+
+	ep93xx_ide_write(hwif->config_data, select, hwif->io_ports.device_addr, t);
+}
+
+static void
+ep93xx_ide_tf_load(ide_drive_t *drive, struct ide_taskfile *tf, u8 valid)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_timing *t = (struct ide_timing *) ide_get_drivedata(drive);
+
+	if (valid & IDE_VALID_FEATURE)
+		ep93xx_ide_write(hwif->config_data, tf->feature,
+			io_ports->feature_addr, t);
+	if (valid & IDE_VALID_NSECT)
+		ep93xx_ide_write(hwif->config_data, tf->nsect,
+			io_ports->nsect_addr, t);
+	if (valid & IDE_VALID_LBAL)
+		ep93xx_ide_write(hwif->config_data, tf->lbal,
+			io_ports->lbal_addr, t);
+	if (valid & IDE_VALID_LBAM)
+		ep93xx_ide_write(hwif->config_data, tf->lbam,
+			io_ports->lbam_addr, t);
+	if (valid & IDE_VALID_LBAH)
+		ep93xx_ide_write(hwif->config_data, tf->lbah,
+			io_ports->lbah_addr, t);
+	if (valid & IDE_VALID_DEVICE)
+		ep93xx_ide_write(hwif->config_data, tf->device,
+			io_ports->device_addr, t);
+}
+
+static void ep93xx_ide_tf_read(ide_drive_t *drive, struct ide_taskfile *tf,
+				u8 valid)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_timing *t = (struct ide_timing *) ide_get_drivedata(drive);
+
+	if (valid & IDE_VALID_ERROR)
+		tf->error = ep93xx_ide_read(hwif->config_data,
+						io_ports->feature_addr, t);
+	if (valid & IDE_VALID_NSECT)
+		tf->nsect = ep93xx_ide_read(hwif->config_data,
+						io_ports->nsect_addr, t);
+	if (valid & IDE_VALID_LBAL)
+		tf->lbal = ep93xx_ide_read(hwif->config_data,
+						io_ports->lbal_addr, t);
+	if (valid & IDE_VALID_LBAM)
+		tf->lbam = ep93xx_ide_read(hwif->config_data,
+						io_ports->lbam_addr, t);
+	if (valid & IDE_VALID_LBAH)
+		tf->lbah = ep93xx_ide_read(hwif->config_data,
+						io_ports->lbah_addr, t);
+	if (valid & IDE_VALID_DEVICE)
+		tf->device = ep93xx_ide_read(hwif->config_data,
+						io_ports->device_addr, t);
+}
+
+static void ep93xx_ide_input_data(ide_drive_t *drive, struct ide_cmd *cmd,
+				void *buf, unsigned int len)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	unsigned int words = (len + 1) >> 1;
+	struct ide_timing *t = (struct ide_timing *) ide_get_drivedata(drive);
+
+	ep93xx_ide_readsw(hwif->config_data, io_ports->data_addr, buf, words, t);
+}
+
+static void ep93xx_ide_output_data(ide_drive_t *drive, struct ide_cmd *cmd,
+				void *buf, unsigned int len)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	unsigned int words = (len + 1) >> 1;
+	struct ide_timing *t = (struct ide_timing *) ide_get_drivedata(drive);
+
+	ep93xx_ide_writesw(hwif->config_data, io_ports->data_addr, buf, words, t);
+}
+
+static struct ide_tp_ops ep93xx_ide_tp_ops = {
+	.exec_command = ep93xx_ide_exec_command,
+	.read_status = ep93xx_ide_read_status,
+	.read_altstatus = ep93xx_ide_read_altstatus,
+	.write_devctl = ep93xx_ide_write_devctl,
+	.dev_select = ep93xx_ide_dev_select,
+	.tf_load = ep93xx_ide_tf_load,
+	.tf_read = ep93xx_ide_tf_read,
+	.input_data = ep93xx_ide_input_data,
+	.output_data = ep93xx_ide_output_data,
+};
+
+static void ep93xx_set_pio_mode(ide_drive_t *drive, const u8 pio)
+{
+	struct ide_timing *timing;
+	u32	reg = IDECFG_IDEEN | IDECFG_PIO;
+
+	timing = ide_timing_find_mode(XFER_PIO_0 + pio);
+	/*
+	 * store the adequate PIO mode timings in the ide_drive_t
+	 * 'drive_data' field, to be used later by ep93xx_ide_{read,write}
+	 */
+	ide_set_drivedata(drive, (void *)timing);
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
+	ep93xx_writel(reg, drive->hwif->config_data, IDECFG);
+}
+
+static struct ide_port_ops ep93xx_ide_port_ops = {
+	.set_pio_mode = ep93xx_set_pio_mode,
+};
+
+static struct ide_port_info ep93xx_ide_port_info = {
+	.name = MODULE_NAME,
+	.tp_ops = &ep93xx_ide_tp_ops,
+	.port_ops = &ep93xx_ide_port_ops,
+	.host_flags = IDE_HFLAG_SINGLE | IDE_HFLAG_POST_SET_MODE |
+		IDE_HFLAG_NO_DMA | IDE_HFLAG_MMIO | IDE_HFLAG_NO_IO_32BIT |
+		IDE_HFLAG_NO_UNMASK_IRQS,
+	.pio_mask = ATA_PIO4,
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
+	 * we use magic numbers 0x10 for io_addr and 0x0E for ctl_addr,
+	 * hence the lowest 3 bits will give us the real address (ranging from
+	 * 0 to 7) and the subsequent 2 bits will give us the CS1n and CS0n
+	 * values:
+	 *   CS1n  CS0n   A2   A1   A0
+	 *     1    0      x    x    x   -> IO_ADDR (base 0x10)
+	 *     0    1      x    x    x   -> CTL_ADDR (base 0x0E)
+	 */
+	ide_std_init_ports(&hw, 0x10, 0x0E);
+
+	hw.irq = irq;
+	hw.chipset = ide_generic;
+	hw.dev = &pdev->dev;
+	hw.config = (unsigned long)ide_base;
+
+	/* enforce EP93xx IDE controller reset state */
+	ep93xx_ide_clean_regs(hw.config);
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
+	ep93xx_writel(IDECFG_IDEEN | IDECFG_PIO | IDECFG_PIO_MODE_0 | 
+			((3 << 8) & IDECFG_WST), hw.config, IDECFG);
+
+	retval = ide_host_add(&ep93xx_ide_port_info, hws, &host);
+	if (retval) {
+		dev_err(&pdev->dev,
+			"unable to register EP93xx IDE driver!\n");
+		goto fail_unmap;
+	}
+
+	platform_set_drvdata(pdev, host);
+
+	dev_info(&pdev->dev, "EP93xx IDE host controller driver initialized\n");
+
+	return 0;
+
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
+
+	/* reset state */
+	ep93xx_ide_clean_regs(host->ports[0]->config_data);
+
+	/* restore back GPIO port E, G and H for GPIO use */
+	ep93xx_ide_release_gpios();
+
+	ide_host_remove(host);
+
+	iounmap((void __iomem *)(host->ports[0]->config_data));
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
+		   .name = MODULE_NAME,
+		   .owner = THIS_MODULE,
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
diff -urN linux-2.6.30-rc4.orig/drivers/ide/Kconfig linux-2.6.30-rc4/drivers/ide/Kconfig
--- linux-2.6.30-rc4.orig/drivers/ide/Kconfig	2009-04-30 05:48:16.000000000 +0100
+++ linux-2.6.30-rc4/drivers/ide/Kconfig	2009-05-13 14:41:39.000000000 +0100
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
diff -urN linux-2.6.30-rc4.orig/drivers/ide/Makefile linux-2.6.30-rc4/drivers/ide/Makefile
--- linux-2.6.30-rc4.orig/drivers/ide/Makefile	2009-04-30 05:48:16.000000000 +0100
+++ linux-2.6.30-rc4/drivers/ide/Makefile	2009-05-13 14:41:39.000000000 +0100
@@ -117,3 +117,4 @@
 obj-$(CONFIG_BLK_DEV_IDE_TX4938)	+= tx4938ide.o
 obj-$(CONFIG_BLK_DEV_IDE_TX4939)	+= tx4939ide.o
 obj-$(CONFIG_BLK_DEV_IDE_AT91)		+= at91_ide.o
+obj-$(CONFIG_BLK_DEV_IDE_EP93XX)	+= ep93xx-ide.o

--------------070009020905020705000809--
