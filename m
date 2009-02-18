From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [PATCH 2/3 v3] ide: add at91_ide driver
Date: Wed, 18 Feb 2009 11:06:53 +0100
Message-ID: <200902181106.54260.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:59359 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbZBRKHI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Feb 2009 05:07:08 -0500
Received: from ebg226.internetdsl.tpnet.pl (HELO staszek-desktop.local) (stf_xl@wp.pl@[83.14.136.226])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-ide@vger.kernel.org>; 18 Feb 2009 11:06:59 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk

This is IDE host driver for AT91 (SAM9, CAP9, AT572D940HF) Static Memory
Controller with Compact Flash True IDE Mode logic.

Driver have to switch 8/16 bit bus width when accessing Task Tile or Data
Register. Moreover some extra things need to be done when setting PIO mode.
Only PIO mode is used, hardware have no DMA support. If interrupt line is
connected through GPIO extra quirk is needed to cope with fake interrupts.

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 arch/arm/mach-at91/include/mach/board.h |    3 +
 drivers/ide/Kconfig                     |    5 +
 drivers/ide/Makefile                    |    1 +
 drivers/ide/at91_ide.c                  |  467 +++++++++++++++++++++++++++++++
 4 files changed, 476 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ide/at91_ide.c

diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index fb51f0e..2bc35a8 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -56,6 +56,9 @@ struct at91_cf_data {
 	u8	vcc_pin;		/* power switching */
 	u8	rst_pin;		/* card reset */
 	u8	chipselect;		/* EBI Chip Select number */
+	u8	flags;
+#define AT91_CF_TRUE_IDE	0x01
+#define AT91_IDE_SWAP_A0_A2	0x02
 };
 extern void __init at91_add_device_cf(struct at91_cf_data *data);
 
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 3dad229..df2817b 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -721,6 +721,11 @@ config BLK_DEV_IDE_TX4939
 	depends on SOC_TX4939
 	select BLK_DEV_IDEDMA_SFF
 
+config BLK_DEV_IDE_AT91
+	tristate "Atmel AT91 (SAM9, CAP9, AT572D940HF) IDE support"
+	depends on ARM && ARCH_AT91 && !ARCH_AT91RM9200 && !ARCH_AT91X40
+	select IDE_TIMINGS
+
 config IDE_ARM
 	tristate "ARM IDE support"
 	depends on ARM && (ARCH_RPC || ARCH_SHARK)
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index d0e3d7d..1c326d9 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -116,3 +116,4 @@ obj-$(CONFIG_BLK_DEV_IDE_AU1XXX)	+= au1xxx-ide.o
 
 obj-$(CONFIG_BLK_DEV_IDE_TX4938)	+= tx4938ide.o
 obj-$(CONFIG_BLK_DEV_IDE_TX4939)	+= tx4939ide.o
+obj-$(CONFIG_BLK_DEV_IDE_AT91)		+= at91_ide.o
diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
new file mode 100644
index 0000000..1bb50f4
--- /dev/null
+++ b/drivers/ide/at91_ide.c
@@ -0,0 +1,467 @@
+/*
+ * IDE host driver for AT91 (SAM9, CAP9, AT572D940HF) Static Memory Controller
+ * with Compact Flash True IDE logic
+ *
+ * Copyright (c) 2008, 2009 Kelvatek Ltd.
+ *
+ *  This program is free software; you can redistribute it and/or modify
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
+ *
+ */
+
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/ide.h>
+#include <linux/platform_device.h>
+
+#include <mach/board.h>
+#include <mach/gpio.h>
+#include <mach/at91sam9263.h>
+#include <mach/at91sam9_smc.h>
+#include <mach/at91sam9263_matrix.h>
+
+#define DRV_NAME "at91_ide"
+
+#define perr(fmt, args...) pr_err(DRV_NAME ": " fmt, ##args)
+#define pdbg(fmt, args...) pr_debug("%s " fmt, __func__, ##args)
+
+/*
+ * Access to IDE device is possible through EBI Static Memory Controller
+ * with Compact Flash logic. For details see EBI and SMC datasheet sections
+ * of any microcontroller from AT91SAM9 family.
+ *
+ * Within SMC chip select address space, lines A[23:21] distinguish Compact
+ * Flash modes (I/O, common memory, attribute memory, True IDE). IDE modes are:
+ *   0x00c0000 - True IDE
+ *   0x00e0000 - Alternate True IDE (Alt Status Register)
+ *
+ * On True IDE mode Task File and Data Register are mapped at the same address.
+ * To distinguish access between these two different bus data width is used:
+ * 8Bit for Task File, 16Bit for Data I/O.
+ *
+ * After initialization we do 8/16 bit flipping (changes in SMC MODE register)
+ * only inside IDE callback routines which are serialized by IDE layer,
+ * so no additional locking needed.
+ */
+
+#define TASK_FILE	0x00c00000
+#define ALT_MODE	0x00e00000
+#define REGS_SIZE	8
+
+#define enter_16bit(cs, mode) do {					\
+	mode = at91_sys_read(AT91_SMC_MODE(cs));			\
+	at91_sys_write(AT91_SMC_MODE(cs), mode | AT91_SMC_DBW_16);	\
+} while (0)
+
+#define leave_16bit(cs, mode) at91_sys_write(AT91_SMC_MODE(cs), mode);
+
+static void set_smc_timings(const u8 chipselect, const u16 cycle,
+			    const u16 setup, const u16 pulse,
+			    const u16 data_float, int use_iordy)
+{
+	unsigned long mode = AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
+			     AT91_SMC_BAT_SELECT;
+
+	/* disable or enable waiting for IORDY signal */
+	if (use_iordy)
+		mode |= AT91_SMC_EXNWMODE_READY;
+
+	/* add data float cycles if needed */
+	if (data_float)
+		mode |= AT91_SMC_TDF_(data_float);
+
+	at91_sys_write(AT91_SMC_MODE(chipselect), mode);
+
+	/* setup timings in SMC */
+	at91_sys_write(AT91_SMC_SETUP(chipselect), AT91_SMC_NWESETUP_(setup) |
+						   AT91_SMC_NCS_WRSETUP_(0) |
+						   AT91_SMC_NRDSETUP_(setup) |
+						   AT91_SMC_NCS_RDSETUP_(0));
+	at91_sys_write(AT91_SMC_PULSE(chipselect), AT91_SMC_NWEPULSE_(pulse) |
+						   AT91_SMC_NCS_WRPULSE_(cycle) |
+						   AT91_SMC_NRDPULSE_(pulse) |
+						   AT91_SMC_NCS_RDPULSE_(cycle));
+	at91_sys_write(AT91_SMC_CYCLE(chipselect), AT91_SMC_NWECYCLE_(cycle) |
+						   AT91_SMC_NRDCYCLE_(cycle));
+}
+
+static unsigned int calc_mck_cycles(unsigned int ns, unsigned int mck_hz)
+{
+	u64 tmp = ns;
+
+	tmp *= mck_hz;
+	tmp += 1000*1000*1000 - 1; /* round up */
+	do_div(tmp, 1000*1000*1000);
+	return (unsigned int) tmp;
+}
+
+static void apply_timings(const u8 chipselect, const u8 pio,
+			  const struct ide_timing *timing, int use_iordy)
+{
+	unsigned int t0, t1, t2, t6z;
+	unsigned int cycle, setup, pulse, data_float;
+	unsigned int mck_hz;
+	struct clk *mck;
+
+	/* see table 22 of Compact Flash standard 4.1 for the meaning,
+	 * we do not stretch active (t2) time, so setup (t1) + hold time (th)
+	 * assure at least minimal recovery (t2i) time */
+	t0 = timing->cyc8b;
+	t1 = timing->setup;
+	t2 = timing->act8b;
+	t6z = (pio < 5) ? 30 : 20;
+
+	pdbg("t0=%u t1=%u t2=%u t6z=%u\n", t0, t1, t2, t6z);
+
+	mck = clk_get(NULL, "mck");
+	BUG_ON(IS_ERR(mck));
+	mck_hz = clk_get_rate(mck);
+	pdbg("mck_hz=%u\n", mck_hz);
+
+	cycle = calc_mck_cycles(t0, mck_hz);
+	setup = calc_mck_cycles(t1, mck_hz);
+	pulse = calc_mck_cycles(t2, mck_hz);
+	data_float = calc_mck_cycles(t6z, mck_hz);
+
+	pdbg("cycle=%u setup=%u pulse=%u data_float=%u\n",
+	     cycle, setup, pulse, data_float);
+
+	set_smc_timings(chipselect, cycle, setup, pulse, data_float, use_iordy);
+}
+
+static void at91_ide_input_data(ide_drive_t *drive, struct request *rq,
+				void *buf, unsigned int len)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	u8 chipselect = hwif->select_data;
+	unsigned long mode;
+
+	pdbg("cs %u buf %p len %d\n", chipselect, buf, len);
+
+	len++;
+
+	enter_16bit(chipselect, mode);
+	__ide_mm_insw((void __iomem *) io_ports->data_addr, buf, len / 2);
+	leave_16bit(chipselect, mode);
+}
+
+static void at91_ide_output_data(ide_drive_t *drive, struct request *rq,
+				 void *buf, unsigned int len)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	u8 chipselect = hwif->select_data;
+	unsigned long mode;
+
+	pdbg("cs %u buf %p len %d\n", chipselect,  buf, len);
+
+	enter_16bit(chipselect, mode);
+	__ide_mm_outsw((void __iomem *) io_ports->data_addr, buf, len / 2);
+	leave_16bit(chipselect, mode);
+}
+
+static u8 ide_mm_inb(unsigned long port)
+{
+	return readb((void __iomem *) port);
+}
+
+static void ide_mm_outb(u8 value, unsigned long port)
+{
+	writeb(value, (void __iomem *) port);
+}
+
+static void at91_ide_tf_load(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_taskfile *tf = &task->tf;
+	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
+
+	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+		HIHI = 0xFF;
+
+	if (task->tf_flags & IDE_TFLAG_OUT_DATA) {
+		u16 data = (tf->hob_data << 8) | tf->data;
+
+		at91_ide_output_data(drive, NULL, &data, 2);
+	}
+
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
+		ide_mm_outb(tf->hob_feature, io_ports->feature_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
+		ide_mm_outb(tf->hob_nsect, io_ports->nsect_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
+		ide_mm_outb(tf->hob_lbal, io_ports->lbal_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
+		ide_mm_outb(tf->hob_lbam, io_ports->lbam_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
+		ide_mm_outb(tf->hob_lbah, io_ports->lbah_addr);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_FEATURE)
+		ide_mm_outb(tf->feature, io_ports->feature_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_NSECT)
+		ide_mm_outb(tf->nsect, io_ports->nsect_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAL)
+		ide_mm_outb(tf->lbal, io_ports->lbal_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAM)
+		ide_mm_outb(tf->lbam, io_ports->lbam_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAH)
+		ide_mm_outb(tf->lbah, io_ports->lbah_addr);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE)
+		ide_mm_outb((tf->device & HIHI) | drive->select, io_ports->device_addr);
+}
+
+static void at91_ide_tf_read(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_taskfile *tf = &task->tf;
+
+	if (task->tf_flags & IDE_TFLAG_IN_DATA) {
+		u16 data;
+
+		at91_ide_input_data(drive, NULL, &data, 2);
+		tf->data = data & 0xff;
+		tf->hob_data = (data >> 8) & 0xff;
+	}
+
+	/* be sure we're looking at the low order bits */
+	ide_mm_outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
+
+	if (task->tf_flags & IDE_TFLAG_IN_FEATURE)
+		tf->feature = ide_mm_inb(io_ports->feature_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_NSECT)
+		tf->nsect  = ide_mm_inb(io_ports->nsect_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAL)
+		tf->lbal   = ide_mm_inb(io_ports->lbal_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAM)
+		tf->lbam   = ide_mm_inb(io_ports->lbam_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAH)
+		tf->lbah   = ide_mm_inb(io_ports->lbah_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_DEVICE)
+		tf->device = ide_mm_inb(io_ports->device_addr);
+
+	if (task->tf_flags & IDE_TFLAG_LBA48) {
+		ide_mm_outb(ATA_DEVCTL_OBS | 0x80, io_ports->ctl_addr);
+
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
+			tf->hob_feature = ide_mm_inb(io_ports->feature_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
+			tf->hob_nsect   = ide_mm_inb(io_ports->nsect_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
+			tf->hob_lbal    = ide_mm_inb(io_ports->lbal_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
+			tf->hob_lbam    = ide_mm_inb(io_ports->lbam_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
+			tf->hob_lbah    = ide_mm_inb(io_ports->lbah_addr);
+	}
+}
+
+static void at91_ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
+{
+	struct ide_timing *timing;
+	u8 chipselect = drive->hwif->select_data;
+	int use_iordy = 0;
+
+	pdbg("chipselect %u pio %u\n", chipselect, pio);
+
+	timing = ide_timing_find_mode(XFER_PIO_0 + pio);
+	BUG_ON(!timing);
+
+	if ((pio > 2 || ata_id_has_iordy(drive->id)) &&
+	    !(ata_id_is_cfa(drive->id) && pio > 4))
+		use_iordy = 1;
+
+	apply_timings(chipselect, pio, timing, use_iordy);
+}
+
+static const struct ide_tp_ops at91_ide_tp_ops = {
+	.exec_command	= ide_exec_command,
+	.read_status	= ide_read_status,
+	.read_altstatus	= ide_read_altstatus,
+	.set_irq	= ide_set_irq,
+
+	.tf_load	= at91_ide_tf_load,
+	.tf_read	= at91_ide_tf_read,
+
+	.input_data	= at91_ide_input_data,
+	.output_data	= at91_ide_output_data,
+};
+
+static const struct ide_port_ops at91_ide_port_ops = {
+	.set_pio_mode	= at91_ide_set_pio_mode,
+};
+
+static const struct ide_port_info at91_ide_port_info __initdata = {
+	.port_ops	= &at91_ide_port_ops,
+	.tp_ops		= &at91_ide_tp_ops,
+	.host_flags 	= IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA | IDE_HFLAG_SINGLE |
+			  IDE_HFLAG_NO_IO_32BIT | IDE_HFLAG_UNMASK_IRQS,
+	.pio_mask 	= ATA_PIO5,
+};
+
+/*
+ * If interrupt is delivered through GPIO, IRQ are triggered on falling
+ * and rising edge of signal. Whereas IDE device request interrupt on high
+ * level (rising edge in our case). This mean we have fake interrupts, so
+ * we need to check interrupt pin and exit instantly from ISR when line
+ * is on low level.
+ */
+
+irqreturn_t at91_irq_handler(int irq, void *dev_id)
+{
+	int ntries = 8;
+	int pin_val1, pin_val2;
+
+	/* additional deglitch, line can be noisy in badly designed PCB */
+	do {
+		pin_val1 = at91_get_gpio_value(irq);
+		pin_val2 = at91_get_gpio_value(irq);
+	} while (pin_val1 != pin_val2 && --ntries > 0);
+
+	if (pin_val1 == 0 || ntries <= 0)
+		return IRQ_HANDLED;
+
+	return ide_intr(irq, dev_id);
+}
+
+static int __init at91_ide_probe(struct platform_device *pdev)
+{
+	int ret;
+	hw_regs_t hw;
+	hw_regs_t *hws[] = { &hw, NULL, NULL, NULL };
+	struct ide_host *host;
+	struct resource *res;
+	unsigned long tf_base = 0, ctl_base = 0;
+	struct at91_cf_data *board = pdev->dev.platform_data;
+
+	if (!board)
+		return -ENODEV;
+
+	if (board->det_pin && at91_get_gpio_value(board->det_pin) != 0) {
+		perr("no device detected\n");
+		return -ENODEV;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		perr("can't get memory resource\n");
+		return -ENODEV;
+	}
+
+	if (!devm_request_mem_region(&pdev->dev, res->start + TASK_FILE,
+				     REGS_SIZE, "ide") ||
+	    !devm_request_mem_region(&pdev->dev, res->start + ALT_MODE,
+				     REGS_SIZE, "alt")) {
+		perr("memory resources in use\n");
+		return -EBUSY;
+	}
+
+	pdbg("chipselect %u irq %u res %08lx\n", board->chipselect,
+	     board->irq_pin, (unsigned long) res->start);
+
+	tf_base = (unsigned long) devm_ioremap(&pdev->dev, res->start + TASK_FILE,
+					       REGS_SIZE);
+	ctl_base = (unsigned long) devm_ioremap(&pdev->dev, res->start + ALT_MODE,
+						REGS_SIZE);
+	if (!tf_base || !ctl_base) {
+		perr("can't map memory regions\n");
+		return -EBUSY;
+	}
+
+	memset(&hw, 0, sizeof(hw));
+
+	if (board->flags & AT91_IDE_SWAP_A0_A2) {
+		/* workaround for stupid hardware bug */
+		hw.io_ports.data_addr	= tf_base + 0;
+		hw.io_ports.error_addr	= tf_base + 4;
+		hw.io_ports.nsect_addr	= tf_base + 2;
+		hw.io_ports.lbal_addr	= tf_base + 6;
+		hw.io_ports.lbam_addr	= tf_base + 1;
+		hw.io_ports.lbah_addr	= tf_base + 5;
+		hw.io_ports.device_addr = tf_base + 3;
+		hw.io_ports.command_addr = tf_base + 7;
+		hw.io_ports.ctl_addr	= ctl_base + 3;
+	} else
+		ide_std_init_ports(&hw, tf_base, ctl_base + 6);
+
+	hw.irq = board->irq_pin;
+	hw.chipset = ide_generic;
+	hw.dev = &pdev->dev;
+
+	host = ide_host_alloc(&at91_ide_port_info, hws);
+	if (!host) {
+		perr("failed to allocate ide host\n");
+		return -ENOMEM;
+	}
+
+	/* setup Static Memory Controller - PIO 0 as default */
+	apply_timings(board->chipselect, 0, ide_timing_find_mode(XFER_PIO_0), 0);
+
+	/* with GPIO interrupt we have to do quirks in handler */
+	if (board->irq_pin >= PIN_BASE)
+		host->irq_handler = at91_irq_handler;
+
+	host->ports[0]->select_data = board->chipselect;
+
+	ret = ide_host_register(host, &at91_ide_port_info, hws);
+	if (ret) {
+		perr("failed to register ide host\n");
+		goto err_free_host;
+	}
+	platform_set_drvdata(pdev, host);
+	return 0;
+
+err_free_host:
+	ide_host_free(host);
+	return ret;
+}
+
+static int __exit at91_ide_remove(struct platform_device *pdev)
+{
+	struct ide_host *host = platform_get_drvdata(pdev);
+
+	ide_host_remove(host);
+	return 0;
+}
+
+static struct platform_driver at91_ide_driver = {
+	.driver	= {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.remove	= __exit_p(at91_ide_remove),
+};
+
+static int __init at91_ide_init(void)
+{
+	return platform_driver_probe(&at91_ide_driver, at91_ide_probe);
+}
+
+static void __exit at91_ide_exit(void)
+{
+	platform_driver_unregister(&at91_ide_driver);
+}
+
+module_init(at91_ide_init);
+module_exit(at91_ide_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Stanislaw Gruszka <stf_xl@wp.pl>");
+
-- 
1.5.2.5

