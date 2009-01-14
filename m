From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [RFC][PATCH] at91_ide driver
Date: Wed, 14 Jan 2009 13:45:42 +0100
Message-ID: <200901141345.42583.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:41219 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756439AbZANMpu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jan 2009 07:45:50 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Hi

I'm writting IDE host driver for AT91 Static Memory Controller with Compact Flash
True IDE logic. My company - Kelvatek wants to add driver into the mainline,
we think it can be usesfull for others and including driver will be also beneficial
for us obviously.

Driver is not finished, it is submitted just for review. At least tests
for sam9263ek board should be done and ide_intr() quirk rewritten
more cleanly (see below).

Driver is divided into tree parts: generic IDE, processor specific 
(currently only AT91SAM9263 is supported) and board specific.

Some issues with driver:

* Why not platform driver
Generic pata/ide_platform driver will not work with AT91 as we need to 
do special things before access Task File and Data Register (functions 
set_8bit_mode() and set_16bit_mode()). Also extra things needs to be
done when changing PIO mode.

* Tests
We tested with our custom board which is slightly diffrent than
Atmel Evaluation Kit. Pins settings in the patch are from Kelvatek's board,
to run driver on sam9263ek board settings shall be changed. We did
not tests on Atmel sam9263ek board, because we have no proper connector
for 1,8'' HDD. If someone could do tests for these board, I will be very gracefull. 

* GPIO interrupt
This is the most problem with the driver/hardware. Interrupt from device is
delivered through GPIO. In AT91 GPIO interrupts are triggered on falling
and raising edge of signal (this behaviour is not configured IIRC). Whereas
IDE device request interrupt on high level (raising edge in our case). This
mean we have fake interrupts requests on cpu, which broke IDE layer. 
Problem can be solved in hardware: when device INTRQ line is connected
to CPU through AIC controlled IRQ0 or IRQ1 lines with proper level configured.
We probably do such things in our board, but it's is rather impossible
for Atmel Evaluation Kit. Also there is workaround in software: check interrupt
pin value and exit instantly from ISR when line is on low level. Such thing
is done in the patch (AT91_GPIO_IRQ_HACK in drivers/ide/ide-io.c), but
this is dirty hack and should implemented differently (I hope someone
could give my good idea how).

* Performance
Driver works only in PIO mode, we have no hardware for DMA mode. 
Probably  hardware support could be done using another Chip Select
with Static Memory Controller and extra external logic. Maybe Atmel
people could tell someting more about this issue?  On PIO4 mode 
I achieve 4,5MB/s transfer with 100% CPU usage (CPU is clocked with 200MHz).

* Maintenance
After inclusion, when I finish the driver, I hope someone from Atmel: 
Nicolas or Haavard could take maintenance of it.

Regards
Stanislaw Gruszka

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

---
 arch/arm/mach-at91/at91sam9263_devices.c |   96 +++++++
 arch/arm/mach-at91/board-sam9263ek.c     |   11 +
 arch/arm/mach-at91/include/mach/board.h  |    9 +
 drivers/ide/Kconfig                      |    4 +
 drivers/ide/Makefile                     |    1 +
 drivers/ide/at91_ide.c                   |  459 ++++++++++++++++++++++++++++++
 drivers/ide/ide-io.c                     |   22 ++-
 7 files changed, 601 insertions(+), 1 deletions(-)
 create mode 100644 drivers/ide/at91_ide.c

diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 8b88408..976e228 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -347,6 +347,102 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  IDE
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE_AT91_MODULE)
+
+/* Proper CS address space will be added */
+#define AT91_IDE_TASK_FILE	0x00c00000
+#define AT91_IDE_CTRL_REG	0x00e00000
+
+static struct resource ide_resources[] = {
+	[0] = {
+		.start	= AT91_IDE_TASK_FILE,
+		.end	= AT91_IDE_TASK_FILE + 8 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91_IDE_CTRL_REG,
+		.end	= AT91_IDE_CTRL_REG, /* 1 byte */
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct at91_ide_data ide_data;
+
+static struct platform_device at91_ide_device = {
+	.name	= "at91_ide",
+	.id 	= -1,
+	.dev	= {
+		.platform_data = &ide_data,
+	},
+	.resource = ide_resources,
+	.num_resources = ARRAY_SIZE(ide_resources),
+};
+
+void __init at91_add_device_ide(struct at91_ide_data *data)
+{
+	unsigned long ebi0_csa, addr_space;
+	u8 chipselect = data->chipselect;
+
+	/* enable PIO controlled pins, inputs with pull ups */
+	if (data->rst_pin)
+		at91_set_gpio_output(data->rst_pin, 0); /* reset card */
+
+	at91_set_gpio_input(data->irq_pin, 1);
+	at91_set_deglitch(data->irq_pin, 1);
+
+	if (data->det_pin) {
+		at91_set_gpio_input(data->det_pin, 1);
+		at91_set_deglitch(data->det_pin, 1);
+	}
+
+	/* enable EBI SMC controlled pins */
+	at91_set_A_periph(AT91_PIN_PC5, 1);  /* nWAIT */
+	at91_set_A_periph(AT91_PIN_PD6, 0);  /* CFCS0 */
+	at91_set_A_periph(AT91_PIN_PD8, 0);  /* CFCE1 */
+	at91_set_A_periph(AT91_PIN_PD9, 0);  /* CFCE2 */
+	at91_set_A_periph(AT91_PIN_PD14, 0); /* CFNRW */
+
+	/* assign CS4/5 to SMC with Compact Flash logic support
+	 * and fix resources addresses */
+	ebi0_csa = at91_sys_read(AT91_MATRIX_EBI0CSA);
+	switch (chipselect) {
+	case 4:
+		ebi0_csa |= AT91_MATRIX_EBI0_CS4A_SMC_CF1;
+		addr_space = AT91_CHIPSELECT_4;
+		break;
+	case 5:
+		ebi0_csa |= AT91_MATRIX_EBI0_CS5A_SMC_CF2;
+		addr_space = AT91_CHIPSELECT_5;
+		break;
+	default:
+		printk(KERN_ERR "at91_ide: bad chip select %u\n", chipselect);
+		return;
+	}
+	at91_sys_write(AT91_MATRIX_EBI0CSA, ebi0_csa);
+	ide_resources[0].start += addr_space;
+	ide_resources[0].end += addr_space;
+	ide_resources[1].start += addr_space;
+	ide_resources[1].end += addr_space;
+
+	/* turn on the card if reset pin is GPIO */
+	if (data->rst_pin)
+		at91_set_gpio_value(data->rst_pin, 1);
+
+	if (data->det_pin && at91_get_gpio_value(data->det_pin) != 0) {
+		printk(KERN_ERR "at91_ide: no Compact Flash card detected\n");
+		return ;
+	}
+
+	ide_data = *data;
+	platform_device_register(&at91_ide_device);
+}
+#else
+void __init at91_add_device_ide(struct at91_ide_data *data) {}
+#endif
 
 /* --------------------------------------------------------------------
  *  NAND / SmartMedia
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 8354015..3884abf 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -366,6 +366,15 @@ static struct gpio_led ek_pwm_led[] = {
 	}
 };
 
+/*
+ * IDE
+ */
+static struct at91_ide_data ek_ide_data = {
+	.irq_pin	= AT91_PIN_PB20,
+	.det_pin	= AT91_PIN_PB22,
+	.rst_pin	= AT91_PIN_PB19,
+	.chipselect	= 4,
+};
 
 static void __init ek_board_init(void)
 {
@@ -397,6 +406,8 @@ static void __init ek_board_init(void)
 	/* LEDs */
 	at91_gpio_leds(ek_leds, ARRAY_SIZE(ek_leds));
 	at91_pwm_leds(ek_pwm_led, ARRAY_SIZE(ek_pwm_led));
+	/* IDE */
+	at91_add_device_ide(&ek_ide_data);
 }
 
 MACHINE_START(AT91SAM9263EK, "Atmel AT91SAM9263-EK")
diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index fb51f0e..a2fbcfa 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -59,6 +59,15 @@ struct at91_cf_data {
 };
 extern void __init at91_add_device_cf(struct at91_cf_data *data);
 
+ /* Compact Flash True IDE mode */
+struct at91_ide_data {
+	u8	irq_pin;		/* the same meaning as for CF */
+	u8	det_pin;
+	u8	rst_pin;
+	u8	chipselect;
+};
+extern void __init at91_add_device_ide(struct at91_ide_data *data);
+
  /* MMC / SD */
 struct at91_mmc_data {
 	u8		det_pin;	/* card detect IRQ */
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index e6857e0..89b990a 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -722,6 +722,10 @@ config BLK_DEV_IDE_TX4939
 	depends on SOC_TX4939
 	select BLK_DEV_IDEDMA_SFF
 
+config BLK_DEV_IDE_AT91
+	tristate "Atmel AT91 IDE support"
+	depends on ARM && ARCH_AT91
+
 config IDE_ARM
 	tristate "ARM IDE support"
 	depends on ARM && (ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
diff --git a/drivers/ide/Makefile b/drivers/ide/Makefile
index 7818d40..8d60b34 100644
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -113,3 +113,4 @@ obj-$(CONFIG_BLK_DEV_IDE_AU1XXX)	+= au1xxx-ide.o
 
 obj-$(CONFIG_BLK_DEV_IDE_TX4938)	+= tx4938ide.o
 obj-$(CONFIG_BLK_DEV_IDE_TX4939)	+= tx4939ide.o
+obj-$(CONFIG_BLK_DEV_IDE_AT91)		+= at91_ide.o
diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
new file mode 100644
index 0000000..f82ecb9
--- /dev/null
+++ b/drivers/ide/at91_ide.c
@@ -0,0 +1,459 @@
+/*
+ * IDE host driver for AT91 Static Memory Controler
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
+#include <linux/delay.h>
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
+#define DEBUG 1
+#define DRV_NAME "at91_ide"
+
+#define perr(fmt, args...) printk(KERN_ERR DRV_NAME ": " fmt, ##args)
+
+#ifdef DEBUG
+#define pdbg(fmt, args...) printk(KERN_DEBUG "%s " fmt, __func__, ##args)
+#else
+#define pdbg(fmt, args...)
+#endif
+
+/* 
+ * AT91 Static Memory Controller maps Task File and Data Register
+ * at the same address. To distinguish access between these two
+ * different bus data width is used: 8Bit for Task File, 16Bit for Data I/O
+ */
+
+static void init_smc_mode(const u8 chipselect)
+{
+	at91_sys_write(AT91_SMC_MODE(chipselect), AT91_SMC_READMODE |
+						  AT91_SMC_WRITEMODE |
+						  AT91_SMC_BAT_SELECT |
+						  AT91_SMC_TDF_(2));
+}
+
+static inline void set_8bit_mode(const u8 chipselect)
+{
+	unsigned long mode = at91_sys_read(AT91_SMC_MODE(chipselect));
+	mode &= ~AT91_SMC_DBW;
+	mode |= AT91_SMC_DBW_8;
+	at91_sys_write(AT91_SMC_MODE(chipselect), mode);
+	pdbg("%u %08lx\n", chipselect, mode);
+}
+
+static inline void set_16bit_mode(const u8 chipselect)
+{	
+	unsigned long mode = at91_sys_read(AT91_SMC_MODE(chipselect));
+	mode &= ~AT91_SMC_DBW;
+	mode |= AT91_SMC_DBW_16;
+	at91_sys_write(AT91_SMC_MODE(chipselect), mode);
+	pdbg("%u %08lx\n", chipselect, mode);
+}
+
+static unsigned int calc_mck_cycles(unsigned int ns, unsigned int mck_hz)
+{
+	u64 tmp = ns;
+	tmp *= mck_hz;
+	tmp += 1000*1000*1000 + 1; /* round up */
+	do_div(tmp, 1000*1000*1000);
+	return (unsigned int) tmp;
+}
+
+static void set_ebi_timings(const u8 chipselect, const u8 pio)
+{
+	/* Compact Flash True IDE mode timings, all values in nano seconds,
+	 * see table 22 of standard 4.1 */
+	const struct { unsigned int t0, t1, t2, t2i, t9; } timings[7] = {
+		{ .t0 = 600, .t1 = 70, .t2 = 290, .t2i =  0, .t9 = 20 }, /* PIO 0 */
+		{ .t0 = 383, .t1 = 50, .t2 = 290, .t2i =  0, .t9 = 15 }, /* PIO 1 */
+		{ .t0 = 240, .t1 = 30, .t2 = 290, .t2i =  0, .t9 = 10 }, /* PIO 2 */
+		{ .t0 = 180, .t1 = 30, .t2 =  80, .t2i = 70, .t9 = 10 }, /* PIO 3 */
+		{ .t0 = 120, .t1 = 25, .t2 =  70, .t2i = 25, .t9 = 10 }, /* PIO 4 */
+		{ .t0 = 100, .t1 = 15, .t2 =  65, .t2i = 25, .t9 = 10 }, /* PIO 5 */
+		{ .t0 =  80, .t1 = 10, .t2 =  55, .t2i = 20, .t9 = 10 }, /* PIO 6 */
+	};
+	unsigned int t0, t1, t2, t2i, t9;
+	unsigned int mck_hz;
+	struct clk *mck;
+	unsigned long mode;
+
+	BUG_ON(pio > 6);
+
+	t0 = timings[pio].t0;
+	t1 = timings[pio].t1;
+	t2 = timings[pio].t2;
+	t2i = timings[pio].t2i;
+	t9 = timings[pio].t9;
+
+	if (t2i > 0) {
+		/* t1 is the part of t2i, let's t9 be the rest of t2i */
+		WARN_ON(t2i < t1);
+		if (t9 < t2i - t1)
+			t9 = t2i - t1;
+	}
+
+	mck = clk_get(NULL, "mck");
+	BUG_ON(IS_ERR(mck));
+	mck_hz = clk_get_rate(mck);
+	pdbg("mck_hz=%u\n", mck_hz);
+
+	t0 = calc_mck_cycles(t0, mck_hz);
+	t1 = calc_mck_cycles(t1, mck_hz);
+	t2 = calc_mck_cycles(t2, mck_hz);
+	t2i = calc_mck_cycles(t2i, mck_hz);
+	t9 = calc_mck_cycles(t9, mck_hz);
+	pdbg("t0=%u t1=%u t2=%u t2i=%u t9=%u\n", t0, t1, t2, t2i, t9);
+
+	clk_put(mck);
+
+	/* values are rounded up so we need to assure cycle is larger than pulse */
+	if (t0 < t1 + t2 + t9)
+		t0 = t1 + t2 + t9;
+
+	/* setup calculated timings */
+	at91_sys_write(AT91_SMC_SETUP(chipselect), AT91_SMC_NWESETUP_(t1) |
+						   AT91_SMC_NCS_WRSETUP_(0) |
+						   AT91_SMC_NRDSETUP_(t1) |
+						   AT91_SMC_NCS_RDSETUP_(0));
+	at91_sys_write(AT91_SMC_PULSE(chipselect), AT91_SMC_NWEPULSE_(t2) |
+						   AT91_SMC_NCS_WRPULSE_(t1 + t2 + t9) |
+						   AT91_SMC_NRDPULSE_(t2) |
+						   AT91_SMC_NCS_RDPULSE_(t1 + t2 + t9));
+	at91_sys_write(AT91_SMC_CYCLE(chipselect), AT91_SMC_NWECYCLE_(t0) |
+						   AT91_SMC_NRDCYCLE_(t0));
+
+	/* disable or enable waiting for IORDY signal */
+	mode = at91_sys_read(AT91_SMC_MODE(chipselect));
+	mode &= ~AT91_SMC_EXNWMODE;
+	if (pio <= 4)
+		mode |= AT91_SMC_EXNWMODE_FROZEN;
+	else 
+		mode |= AT91_SMC_EXNWMODE_DISABLE;
+	at91_sys_write(AT91_SMC_MODE(chipselect), mode);
+}
+
+static u8 ide_mm_inb(unsigned long port)
+{
+	return (u8) readb((void __iomem *) port);
+}
+
+static void ide_mm_outb(u8 value, unsigned long port)
+{
+	writeb(value, (void __iomem *) port);
+}
+
+void at91_ide_tf_load(ide_drive_t *drive, ide_task_t *task)
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
+		u8 chipselect = hwif->extra_base;
+
+		set_16bit_mode(chipselect);
+		writew(data, (void __iomem *) io_ports->data_addr);
+		set_8bit_mode(chipselect);
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
+void at91_ide_tf_read(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_taskfile *tf = &task->tf;
+
+	if (task->tf_flags & IDE_TFLAG_IN_DATA) {
+		u8 chipselect = hwif->extra_base;
+		u16 data;
+
+		set_16bit_mode(chipselect);
+		data = readw((void __iomem *) io_ports->data_addr);
+		set_8bit_mode(chipselect);
+
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
+void at91_ide_input_data(ide_drive_t *drive, struct request *rq, void *buf, unsigned int len)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	u8 chipselect = hwif->extra_base;
+
+	pdbg("cs %u buf %p len %d\n", chipselect,  buf, len);
+
+	len++;
+
+	set_16bit_mode(chipselect);
+	__ide_mm_insw((void __iomem *) io_ports->data_addr, buf, len / 2);
+	set_8bit_mode(chipselect);
+}
+
+void at91_ide_output_data(ide_drive_t *drive, struct request *rq, void *buf, unsigned int len)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	u8 chipselect = hwif->extra_base;
+
+	pdbg("cs %u buf %p len %d\n", chipselect,  buf, len);
+
+	set_16bit_mode(chipselect);
+	__ide_mm_outsw((void __iomem *) io_ports->data_addr, buf, len / 2);
+	set_8bit_mode(chipselect);
+}
+
+static const struct ide_tp_ops at91_ide_tp_ops = {
+	.exec_command = ide_exec_command,
+	.read_status = ide_read_status,
+	.read_altstatus = ide_read_altstatus,
+	.set_irq = ide_set_irq,
+
+	.tf_load = at91_ide_tf_load,
+	.tf_read = at91_ide_tf_read,
+
+	.input_data = at91_ide_input_data,
+	.output_data = at91_ide_output_data,
+};
+
+static void at91_ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
+{
+	u8 chipselect = drive->hwif->extra_base;
+
+	pdbg("pio %u\n", pio);
+
+	if (pio > 6) {
+		perr("can't set PIO %d mode\n", pio);
+		return;
+	}
+	set_ebi_timings(chipselect, pio);
+}
+
+static const struct ide_port_ops at91_ide_port_ops = {
+	.set_pio_mode = at91_ide_set_pio_mode,
+};
+
+static const struct ide_port_info at91_ide_port_info __initdata = {
+	.port_ops = &at91_ide_port_ops,
+	.tp_ops = &at91_ide_tp_ops,
+	.host_flags = IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA | IDE_HFLAG_SINGLE,
+	.pio_mask = ATA_PIO6,
+};
+
+static int __init at91_ide_probe(struct platform_device *pdev)
+{
+	int ret = -ENOMEM;
+	hw_regs_t hw;
+	hw_regs_t *hws[] = { &hw, NULL, NULL, NULL };
+	struct resource *tf_res, *ctl_res;
+	unsigned long tf_base = 0, ctl_base = 0;
+	struct at91_ide_data *board = pdev->dev.platform_data;
+	struct ide_host *host;
+
+	tf_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ctl_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!ctl_res || !tf_res) {
+		perr("can't get memory resources\n");
+		goto err;
+	}
+
+	pdbg("chipselect %u irq %u tf %lu ctl %lu\n", board->chipselect,
+	     board->irq_pin, tf_res->start, ctl_res->start);
+
+	tf_base = (unsigned long) devm_ioremap(&pdev->dev, tf_res->start,
+					       tf_res->end - tf_res->start + 1);
+	ctl_base = (unsigned long) devm_ioremap(&pdev->dev, ctl_res->start,
+						ctl_res->end - ctl_res->start + 1);
+	if (!tf_base || !ctl_base) {
+		perr("can't map memory regions\n");
+		goto err_unmap;
+	}
+
+	memset(&hw, 0, sizeof(hw));
+#if 0
+	/* In 12-0275-01 version of the PCB address
+	 * lines CF_A0 and CF_A2 are swapped */
+	hw.io_ports.data_addr =	tf_base + 0;
+	hw.io_ports.error_addr = tf_base + 4;
+	hw.io_ports.nsect_addr = tf_base + 2;
+	hw.io_ports.lbal_addr = tf_base + 6;
+	hw.io_ports.lbam_addr = tf_base + 1;
+	hw.io_ports.lbah_addr = tf_base + 5;
+	hw.io_ports.device_addr = tf_base + 3;
+	hw.io_ports.command_addr = tf_base + 7;
+#else
+	/* Proper lines addresses */
+	hw.io_ports.data_addr = tf_base + 0;
+	hw.io_ports.error_addr = tf_base + 1;
+	hw.io_ports.nsect_addr = tf_base + 2;
+	hw.io_ports.lbal_addr = tf_base + 3;
+	hw.io_ports.lbam_addr = tf_base + 4;
+	hw.io_ports.lbah_addr =	tf_base + 5;
+	hw.io_ports.device_addr = tf_base + 6;
+	hw.io_ports.command_addr = tf_base + 7;
+#endif
+	hw.io_ports.ctl_addr = ctl_base;
+	hw.irq = board->irq_pin;
+	hw.chipset = ide_generic;
+	hw.dev = &pdev->dev;
+
+	host = ide_host_alloc(&at91_ide_port_info, hws);
+	if (!host) {
+		perr("failed to allocate ide host\n");
+		goto err_unmap;
+	}
+
+	/* setup Static Memory Controller - PIO 0 as default */
+	init_smc_mode(board->chipselect);
+	set_ebi_timings(board->chipselect, 0);
+
+	host->ports[0]->extra_base = board->chipselect;
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
+err_unmap:
+	if (ctl_base)
+		devm_iounmap(&pdev->dev, (void __iomem *) ctl_base);
+	if (tf_base)
+		devm_iounmap(&pdev->dev, (void __iomem *) tf_base);
+err:
+	return ret;
+}
+
+static int __exit at91_ide_remove(struct platform_device *pdev)
+{
+	struct ide_host *host = platform_get_drvdata(pdev);
+	ide_hwif_t *hwif = host->ports[0];
+	unsigned long data_addr = hwif->io_ports.data_addr;
+	unsigned long ctl_addr = hwif->io_ports.ctl_addr;
+
+	ide_host_remove(host);
+	devm_iounmap(&pdev->dev, (void __iomem *) data_addr);
+	devm_iounmap(&pdev->dev, (void __iomem *) ctl_addr);
+
+	return 0;
+}
+
+static struct platform_driver at91_ide_driver = {
+	.driver	= {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+	},
+	.probe	= at91_ide_probe,
+	.remove	= __exit_p(at91_ide_remove),
+};
+
+static int __init at91_ide_init(void)
+{
+	return platform_driver_register(&at91_ide_driver);
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
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index cc35d6d..6dba1fc 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1354,7 +1354,12 @@ static void unexpected_intr (int irq, ide_hwgroup_t *hwgroup)
  *	request completed. At this point we issue the next request
  *	on the hwgroup and the process begins again.
  */
- 
+#define AT91_GPIO_IRQ_HACK
+
+#ifdef AT91_GPIO_IRQ_HACK
+#include <mach/gpio.h>
+#endif 
+
 irqreturn_t ide_intr (int irq, void *dev_id)
 {
 	unsigned long flags;
@@ -1364,6 +1369,21 @@ irqreturn_t ide_intr (int irq, void *dev_id)
 	ide_handler_t *handler;
 	ide_startstop_t startstop;
 
+#ifdef AT91_GPIO_IRQ_HACK
+#define NR_TRIES 10
+	int ntries = 0;
+	int pin_val1, pin_val2;	
+	do {
+		pin_val1 = at91_get_gpio_value(AT91_PIN_PB20);
+		pin_val2 = at91_get_gpio_value(AT91_PIN_PB20);
+	} while (pin_val1 != pin_val2 && ntries++ < NR_TRIES);
+
+	udelay(20); // XXX: this need to be here otherwise IDE layer losts interrups, don't know why !!!
+	if (pin_val1 == 0 || ntries > NR_TRIES)
+		return IRQ_HANDLED;
+#undef NR_TIRES
+#endif
+ 
 	spin_lock_irqsave(&ide_lock, flags);
 	hwif = hwgroup->hwif;
 
-- 
1.5.2.5
