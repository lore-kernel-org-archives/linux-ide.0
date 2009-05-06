From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Wed, 06 May 2009 15:17:08 +0100
Message-ID: <4A019BE4.9020903@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <49CFDD8F.1030306@bluewatersys.com>	<BD79186B4FD85F4B8E60E381CAEE1909014E2E09@mi8nycmail19.Mi8.com> <49D0CAE4.9090306@inov.pt> <49D0E687.4040101@ru.mvista.com> <49FED069.9080501@inov.pt> <4A002B56.1000802@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090001090408030206050809"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:39083 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755353AbZEFOTZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 May 2009 10:19:25 -0400
In-Reply-To: <4A002B56.1000802@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, H Hartley Sweeten <hartleys@visionengravers.com>, Ryan Mallon <ryan@bluewatersys.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------090001090408030206050809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi.

So here is the revised patch, according to yours comments, to add 
support for the IDE host controller in the Cirrus Logic's EP93xx CPUs.
This patch is made against kernel 2.6.30-rc4 (latest release candidate 
in Linus's tree).

I've preferred to attach the patch instead of inlining it in this mail, 
as my mailer seems to deform the patch output.

Please confirm if the patch is ok.

Sergei: I've added the delays you suggested in the read/write 
procedures, accordingly to the delays specified in the processor's user 
manual for PIO Mode 4.
These delays really introduce quite a performance loss. Although the 
driver is working, these delays make file transfers quite slow; do we 
really need to enforce manually these delays?
I mean, on a 200MHz CPU (5ns instruction cycle), can't we assume that 
instructions and branches that occur between C code instructions will 
suffice to some of these delays (the delays are 25ns + 70ns + 25ns), or 
yet, can't we reduce some of these delays assuming some instruction 
cycle time is already spent on branches and instructions between reads 
and writes to the IDE control registers?

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


--------------090001090408030206050809
Content-Type: text/plain;
 name="linux-2.6.30-rc4-ep93xx-ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.30-rc4-ep93xx-ide.patch"

Add IDE host controller support for Cirrus Logic's EP93xx CPUs.
This driver currently supports only PIO-4 transfer mode.

Signed-off-by: Joao Ramos <joao.ramos@inov.pt>

---

diff -urN linux-2.6.30-rc4.orig/arch/arm/mach-ep93xx/core.c linux-2.6.30-rc4/arch/arm/mach-ep93xx/core.c
--- linux-2.6.30-rc4.orig/arch/arm/mach-ep93xx/core.c	2009-04-30 05:48:16.000000000 +0100
+++ linux-2.6.30-rc4/arch/arm/mach-ep93xx/core.c	2009-05-06 13:57:56.000000000 +0100
@@ -537,6 +537,49 @@
 	platform_device_register(&ep93xx_i2c_device);
 }
 
+static struct resource ep93xx_ide_resources[] = {
+	{
+		.start	= EP93XX_IDE_PHYS_BASE,
+		.end	= EP93XX_IDE_PHYS_BASE + 0x37,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_EP93XX_EXT3,
+		.end	= IRQ_EP93XX_EXT3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ep93xx_ide_device = {
+	.name		= "ep93xx-ide",
+	.id			= -1,
+	.num_resources	= ARRAY_SIZE(ep93xx_ide_resources),
+	.resource	= ep93xx_ide_resources,
+};
+
+void __init ep93xx_register_ide(void)
+{
+	platform_device_register(&ep93xx_ide_device);
+}
+
+void ep93xx_ide_on_gpio(int enable)
+{
+	u32	reg;
+
+	reg = __raw_readl(EP93XX_SYSCON_DEVICE_CONFIG);
+	if (enable) {
+		reg &= ~(EP93XX_SYSCON_DEVICE_CONFIG_EONIDE |
+			EP93XX_SYSCON_DEVICE_CONFIG_GONIDE |
+			EP93XX_SYSCON_DEVICE_CONFIG_HONIDE);
+	} else {
+		reg |= (EP93XX_SYSCON_DEVICE_CONFIG_EONIDE |
+			EP93XX_SYSCON_DEVICE_CONFIG_GONIDE |
+			EP93XX_SYSCON_DEVICE_CONFIG_HONIDE);
+	}
+	__raw_writel(0xaa, EP93XX_SYSCON_SWLOCK);
+	__raw_writel(reg, EP93XX_SYSCON_DEVICE_CONFIG);
+}
+
 extern void ep93xx_gpio_init(void);
 
 void __init ep93xx_init_devices(void)
@@ -553,6 +596,8 @@
 
 	ep93xx_gpio_init();
 
+	ep93xx_ide_on_gpio(0);
+
 	amba_device_register(&uart1_device, &iomem_resource);
 	amba_device_register(&uart2_device, &iomem_resource);
 	amba_device_register(&uart3_device, &iomem_resource);
diff -urN linux-2.6.30-rc4.orig/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h linux-2.6.30-rc4/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
--- linux-2.6.30-rc4.orig/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h	2009-04-30 05:48:16.000000000 +0100
+++ linux-2.6.30-rc4/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h	2009-05-06 13:57:56.000000000 +0100
@@ -78,6 +78,7 @@
 #define EP93XX_BOOT_ROM_BASE		(EP93XX_AHB_VIRT_BASE + 0x00090000)
 
 #define EP93XX_IDE_BASE			(EP93XX_AHB_VIRT_BASE + 0x000a0000)
+#define EP93XX_IDE_PHYS_BASE	(EP93XX_AHB_PHYS_BASE + 0x000a0000)
 
 #define EP93XX_VIC1_BASE		(EP93XX_AHB_VIRT_BASE + 0x000b0000)
 
@@ -159,6 +160,9 @@
 #define EP93XX_SYSCON_CLOCK_SET1	EP93XX_SYSCON_REG(0x20)
 #define EP93XX_SYSCON_CLOCK_SET2	EP93XX_SYSCON_REG(0x24)
 #define EP93XX_SYSCON_DEVICE_CONFIG	EP93XX_SYSCON_REG(0x80)
+#define EP93XX_SYSCON_DEVICE_CONFIG_EONIDE	0x00000100
+#define EP93XX_SYSCON_DEVICE_CONFIG_GONIDE	0x00000400
+#define EP93XX_SYSCON_DEVICE_CONFIG_HONIDE	0x00000800
 #define EP93XX_SYSCON_DEVICE_CONFIG_CRUNCH_ENABLE	0x00800000
 #define EP93XX_SYSCON_SWLOCK		EP93XX_SYSCON_REG(0xc0)
 
diff -urN linux-2.6.30-rc4.orig/arch/arm/mach-ep93xx/include/mach/platform.h linux-2.6.30-rc4/arch/arm/mach-ep93xx/include/mach/platform.h
--- linux-2.6.30-rc4.orig/arch/arm/mach-ep93xx/include/mach/platform.h	2009-04-30 05:48:16.000000000 +0100
+++ linux-2.6.30-rc4/arch/arm/mach-ep93xx/include/mach/platform.h	2009-05-06 13:57:56.000000000 +0100
@@ -17,6 +17,8 @@
 void ep93xx_init_time(unsigned long);
 void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
 void ep93xx_register_i2c(struct i2c_board_info *devices, int num);
+void ep93xx_register_ide(void);
+void ep93xx_ide_on_gpio(int enable);
 void ep93xx_init_devices(void);
 extern struct sys_timer ep93xx_timer;
 
diff -urN linux-2.6.30-rc4.orig/drivers/ide/ep93xx-ide.c linux-2.6.30-rc4/drivers/ide/ep93xx-ide.c
--- linux-2.6.30-rc4.orig/drivers/ide/ep93xx-ide.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.30-rc4/drivers/ide/ep93xx-ide.c	2009-05-06 14:48:17.000000000 +0100
@@ -0,0 +1,530 @@
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
+#define	OFFSET_IDECTRL			0x00
+#define	OFFSET_IDECFG			0x04
+#define	OFFSET_IDEMDMAOP		0x08
+#define	OFFSET_IDEUDMAOP		0x0C
+#define	OFFSET_IDEDATAOUT		0x10
+#define	OFFSET_IDEDATAIN		0x14
+#define	OFFSET_IDEMDMADATAOUT	0x18
+#define	OFFSET_IDEMDMADATAIN	0x1C
+#define	OFFSET_IDEUDMADATAOUT	0x20
+#define	OFFSET_IDEUDMADATAIN	0x24
+#define	OFFSET_IDEUDMASTS		0x28
+#define	OFFSET_IDEUDMADEBUG		0x2C
+#define	OFFSET_IDEUDMAWRBUFSTS	0x30
+#define	OFFSET_IDEUDMARDBUFSTS	0x34
+
+/*
+ * Macro for acessing registers using base address
+ * and specified offsets
+ */
+#define	IDE_REGISTER(_offset)	\
+		((void __iomem *)(base + OFFSET_##_offset))
+
+/* Macro for checking -IORDY line state */
+#define	ep93xx_ide_check_iordy() ({	\
+	u32 _reg = readl(IDE_REGISTER(IDECTRL));	\
+	(_reg & IDECTRL_IORDY) ? 1 : 0;	\
+})
+
+/*
+ * IDE Control Register bit fields
+ */
+#define	IDECTRL_CS0N			0x00000001
+#define	IDECTRL_CS1N			0x00000002
+#define	IDECTRL_DA				0x0000001C
+#define	IDECTRL_DIORN			0x00000020
+#define	IDECTRL_DIOWN			0x00000040
+#define	IDECTRL_DASPN			0x00000080
+#define	IDECTRL_DMARQ			0x00000100
+#define	IDECTRL_INTRQ			0x00000200
+#define	IDECTRL_IORDY			0x00000400
+
+/*
+ * IDE Configuration Register bit fields
+ */
+#define	IDECFG_IDEEN			0x00000001
+#define	IDECFG_PIO				0x00000002
+#define	IDECFG_MDMA				0x00000004
+#define	IDECFG_UDMA				0x00000008
+#define	IDECFG_PIO_MODE_0		0x00000000
+#define	IDECFG_PIO_MODE_1		0x00000010
+#define	IDECFG_PIO_MODE_2		0x00000020
+#define	IDECFG_PIO_MODE_3		0x00000030
+#define	IDECFG_PIO_MODE_4		0x00000040
+#define	IDECFG_MDMA_MODE_0		0x00000000
+#define	IDECFG_MDMA_MODE_1		0x00000010
+#define	IDECFG_MDMA_MODE_2		0x00000020
+#define	IDECFG_UDMA_MODE_0		0x00000000
+#define	IDECFG_UDMA_MODE_1		0x00000010
+#define	IDECFG_UDMA_MODE_2		0x00000020
+#define	IDECFG_UDMA_MODE_3		0x00000030
+#define	IDECFG_UDMA_MODE_4		0x00000040
+#define	IDECFG_WST				0x00000300
+
+/*
+ * IDE Interface register map default state
+ * (shutdown)
+ */
+static void ep93xx_ide_clean_regs(unsigned long base)
+{
+	/* disable IDE interface initially */
+	writel((IDECTRL_CS0N | IDECTRL_CS1N | IDECTRL_DIORN |
+			IDECTRL_DIOWN), IDE_REGISTER(IDECTRL));
+
+	/* clear IDE registers */
+	writel(0, IDE_REGISTER(IDECFG));
+	writel(0, IDE_REGISTER(IDEMDMAOP));
+	writel(0, IDE_REGISTER(IDEUDMAOP));
+	writel(0, IDE_REGISTER(IDEDATAOUT));
+	writel(0, IDE_REGISTER(IDEDATAIN));
+	writel(0, IDE_REGISTER(IDEMDMADATAOUT));
+	writel(0, IDE_REGISTER(IDEMDMADATAIN));
+	writel(0, IDE_REGISTER(IDEUDMADATAOUT));
+	writel(0, IDE_REGISTER(IDEUDMADATAIN));
+	writel(0, IDE_REGISTER(IDEUDMADEBUG));
+}
+
+/*
+ * EP93xx IDE PIO low-level hardware initialization routine
+ */
+static void ep93xx_ide_init_hwif(ide_hwif_t *hwif)
+{
+	unsigned long base = hwif->config_data;
+
+	/* enforce reset state */
+	ep93xx_ide_clean_regs(base);
+
+	/* set gpio port E, G and H for IDE */
+	ep93xx_ide_on_gpio(1);
+
+	/*
+	 * configure IDE interface:
+	 *   - IDE Master Enable
+	 *   - Polled IO Operation
+	 *   - PIO Mode 4 (16.67 MBps)
+	 *   - 1 Wait State (10 ns)
+	 */
+	writel(IDECFG_IDEEN | IDECFG_PIO | IDECFG_PIO_MODE_4 |
+	       ((1 << 8) & IDECFG_WST), IDE_REGISTER(IDECFG));
+}
+
+static u8 ep93xx_ide_readb(unsigned long base, unsigned long addr)
+{
+	u32 reg;
+
+	reg = ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DIORN |
+	    IDECTRL_DIOWN;
+	writel(reg, IDE_REGISTER(IDECTRL));
+	ndelay(25);
+
+	reg &= ~IDECTRL_DIORN;
+	writel(reg, IDE_REGISTER(IDECTRL));
+	ndelay(70);
+
+	while (!ep93xx_ide_check_iordy())
+		cpu_relax();
+
+	reg |= IDECTRL_DIORN;
+	writel(reg, IDE_REGISTER(IDECTRL));
+	ndelay(25);
+
+	return readl(IDE_REGISTER(IDEDATAIN));
+}
+
+static void
+ep93xx_ide_writeb(unsigned long base, u8 value, unsigned long addr)
+{
+	u32 reg;
+
+	reg = ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DIORN |
+	    IDECTRL_DIOWN;
+	writel(reg, IDE_REGISTER(IDECTRL));
+	ndelay(25);
+
+	writel(value, IDE_REGISTER(IDEDATAOUT));
+
+	reg &= ~IDECTRL_DIOWN;
+	writel(reg, IDE_REGISTER(IDECTRL));
+	ndelay(70);
+
+	while (!ep93xx_ide_check_iordy())
+		cpu_relax();
+
+	reg |= IDECTRL_DIOWN;
+	writel(reg, IDE_REGISTER(IDECTRL));
+	ndelay(25);
+}
+
+static u16 ep93xx_ide_readw(unsigned long base, unsigned long addr)
+{
+	u32 reg;
+
+	reg = ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DIORN |
+	    IDECTRL_DIOWN;
+	writel(reg, IDE_REGISTER(IDECTRL));
+	ndelay(25);
+
+	reg &= ~IDECTRL_DIORN;
+	writel(reg, IDE_REGISTER(IDECTRL));
+	ndelay(70);
+
+	while (!ep93xx_ide_check_iordy())
+		cpu_relax();
+
+	reg |= IDECTRL_DIORN;
+	writel(reg, IDE_REGISTER(IDECTRL));
+	ndelay(25);
+
+	return readl(IDE_REGISTER(IDEDATAIN));
+}
+
+static void
+ep93xx_ide_writew(unsigned long base, u16 value, unsigned long addr)
+{
+	u32 reg;
+
+	reg = ((addr & 0x07) << 2) | ((addr >> 3) & 0x03) | IDECTRL_DIORN |
+	    IDECTRL_DIOWN;
+	writel(reg, IDE_REGISTER(IDECTRL));
+	ndelay(25);
+
+	writel(value, IDE_REGISTER(IDEDATAOUT));
+
+	reg &= ~IDECTRL_DIOWN;
+	writel(reg, IDE_REGISTER(IDECTRL));
+	ndelay(70);
+
+	while (!ep93xx_ide_check_iordy())
+		cpu_relax();
+
+	reg |= IDECTRL_DIOWN;
+	writel(reg, IDE_REGISTER(IDECTRL));
+	ndelay(25);
+}
+
+static void
+ep93xx_ide_readsw(unsigned long base, unsigned long addr, void *buf,
+		      unsigned int len)
+{
+	u16 *data = (u16 *) buf;
+
+	for (; len; len--)
+		*data++ = cpu_to_le16(ep93xx_ide_readw(base, addr));
+}
+
+static void
+ep93xx_ide_writesw(unsigned long base, unsigned long addr, void *buf,
+		       unsigned int len)
+{
+	u16 *data = (u16 *) buf;
+
+	for (; len; len--)
+		ep93xx_ide_writew(base, le16_to_cpu(*data++), addr);
+}
+
+/*
+ * EP93xx IDE PIO Transport Operations
+ */
+
+static void ep93xx_ide_exec_command(struct hwif_s *hwif, u8 cmd)
+{
+	ep93xx_ide_writeb(hwif->config_data, cmd,
+			      hwif->io_ports.command_addr);
+}
+
+static u8 ep93xx_ide_read_status(ide_hwif_t *hwif)
+{
+	return ep93xx_ide_readb(hwif->config_data,
+				    hwif->io_ports.status_addr);
+}
+
+static u8 ep93xx_ide_read_altstatus(ide_hwif_t *hwif)
+{
+	return ep93xx_ide_readb(hwif->config_data, hwif->io_ports.ctl_addr);
+}
+
+static void ep93xx_ide_write_devctl(ide_hwif_t *hwif, u8 ctl)
+{
+	ep93xx_ide_writeb(hwif->config_data, ctl, hwif->io_ports.ctl_addr);
+}
+
+static void ep93xx_ide_dev_select(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u8 select = drive->select | ATA_DEVICE_OBS;
+
+	ep93xx_ide_writeb(hwif->config_data, select,
+			      hwif->io_ports.device_addr);
+}
+
+static void
+ep93xx_ide_tf_load(ide_drive_t *drive, struct ide_taskfile *tf, u8 valid)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+
+	if (valid & IDE_VALID_FEATURE)
+		ep93xx_ide_writeb(hwif->config_data, tf->feature,
+				      io_ports->feature_addr);
+	if (valid & IDE_VALID_NSECT)
+		ep93xx_ide_writeb(hwif->config_data, tf->nsect,
+				      io_ports->nsect_addr);
+	if (valid & IDE_VALID_LBAL)
+		ep93xx_ide_writeb(hwif->config_data, tf->lbal,
+				      io_ports->lbal_addr);
+	if (valid & IDE_VALID_LBAM)
+		ep93xx_ide_writeb(hwif->config_data, tf->lbam,
+				      io_ports->lbam_addr);
+	if (valid & IDE_VALID_LBAH)
+		ep93xx_ide_writeb(hwif->config_data, tf->lbah,
+				      io_ports->lbah_addr);
+	if (valid & IDE_VALID_DEVICE)
+		ep93xx_ide_writeb(hwif->config_data, tf->device,
+				      io_ports->device_addr);
+}
+
+static void
+ep93xx_ide_tf_read(ide_drive_t *drive, struct ide_taskfile *tf, u8 valid)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+
+	if (valid & IDE_VALID_ERROR)
+		tf->error =
+		    ep93xx_ide_readb(hwif->config_data,
+					 io_ports->feature_addr);
+	if (valid & IDE_VALID_NSECT)
+		tf->nsect =
+		    ep93xx_ide_readb(hwif->config_data,
+					 io_ports->nsect_addr);
+	if (valid & IDE_VALID_LBAL)
+		tf->lbal =
+		    ep93xx_ide_readb(hwif->config_data,
+					 io_ports->lbal_addr);
+	if (valid & IDE_VALID_LBAM)
+		tf->lbam =
+		    ep93xx_ide_readb(hwif->config_data,
+					 io_ports->lbam_addr);
+	if (valid & IDE_VALID_LBAH)
+		tf->lbah =
+		    ep93xx_ide_readb(hwif->config_data,
+					 io_ports->lbah_addr);
+	if (valid & IDE_VALID_DEVICE)
+		tf->device =
+		    ep93xx_ide_readb(hwif->config_data,
+					 io_ports->device_addr);
+}
+
+static void
+ep93xx_ide_input_data(ide_drive_t *drive, struct ide_cmd *cmd, void *buf,
+			  unsigned int len)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	unsigned int words = (len + 1) >> 1;
+
+	ep93xx_ide_readsw(hwif->config_data, io_ports->data_addr, buf,
+			      words);
+}
+
+static void
+ep93xx_ide_output_data(ide_drive_t *drive, struct ide_cmd *cmd, void *buf,
+			   unsigned int len)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	unsigned int words = (len + 1) >> 1;
+
+	ep93xx_ide_writesw(hwif->config_data, io_ports->data_addr, buf,
+			       words);
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
+static struct ide_port_info ep93xx_ide_port_info = {
+	.name = MODULE_NAME,
+	.init_hwif = ep93xx_ide_init_hwif,
+	.tp_ops = &ep93xx_ide_tp_ops,
+	.host_flags = IDE_HFLAG_SINGLE | IDE_HFLAG_NO_DMA | IDE_HFLAG_MMIO |
+	    IDE_HFLAG_NO_IO_32BIT | IDE_HFLAG_NO_UNMASK_IRQS,
+	.pio_mask = ATA_PIO4,
+};
+
+static int __devinit ep93xx_ide_probe(struct platform_device *pdev)
+{
+	int retval;
+	int	irq;
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
+	retval = ide_host_add(&ep93xx_ide_port_info, hws, &host);
+	if (retval) {
+		dev_err(&pdev->dev,
+			"unable to add EP93xx IDE host controller!\n");
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
+	/* IDE interface reset state */
+	ep93xx_ide_clean_regs(host->ports[0]->config_data);
+
+	/* restore back GPIO port E, G and H for GPIO use */
+	ep93xx_ide_on_gpio(0);
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
+	.probe = ep93xx_ide_probe,
+	.remove = __exit_p(ep93xx_ide_remove),
+	.driver = {
+		   .name = MODULE_NAME,
+		   .owner = THIS_MODULE,
+	},
+};
+
+static int __init ep93xx_ide_init(void)
+{
+	return platform_driver_register(&ep93xx_ide_driver);
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
+++ linux-2.6.30-rc4/drivers/ide/Kconfig	2009-05-06 13:57:56.000000000 +0100
@@ -732,6 +732,18 @@
 	depends on ARM && ARCH_AT91 && !ARCH_AT91RM9200 && !ARCH_AT91X40
 	select IDE_TIMINGS
 
+config BLK_DEV_IDE_EP93XX
+	tristate "Cirrus Logic EPxx (EP9312, EP9315) IDE support"
+	depends on ARM && ARCH_EP93XX
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
+++ linux-2.6.30-rc4/drivers/ide/Makefile	2009-05-06 13:57:56.000000000 +0100
@@ -117,3 +117,4 @@
 obj-$(CONFIG_BLK_DEV_IDE_TX4938)	+= tx4938ide.o
 obj-$(CONFIG_BLK_DEV_IDE_TX4939)	+= tx4939ide.o
 obj-$(CONFIG_BLK_DEV_IDE_AT91)		+= at91_ide.o
+obj-$(CONFIG_BLK_DEV_IDE_EP93XX)	+= ep93xx-ide.o


--------------090001090408030206050809--
