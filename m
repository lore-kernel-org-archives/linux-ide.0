From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [PATCH 3/3] AT91: initialize IDE driver on AT91SAM9263 cpu
Date: Tue, 3 Feb 2009 11:47:41 +0100
Message-ID: <200902031147.41822.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:63314 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936AbZBCKrq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Feb 2009 05:47:46 -0500
Received: from ebg226.internetdsl.tpnet.pl (HELO staszek-desktop.local) (stf_xl@wp.pl@[83.14.136.226])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-ide@vger.kernel.org>; 3 Feb 2009 11:47:41 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>
Cc: linux-arm-kernel@lists.arm.linux.org.uk

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

---
 arch/arm/mach-at91/at91sam9263_devices.c |   97 ++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index b753cb8..503651a 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -347,6 +347,103 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
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
+		.end	= AT91_IDE_TASK_FILE + 16 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91_IDE_CTRL_REG,
+		.end	= AT91_IDE_CTRL_REG + 16 - 1,
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
+	at91_set_A_periph(AT91_PIN_PD5, 1);  /* NWAIT */
+	at91_set_A_periph(AT91_PIN_PD8, 0);  /* CFCE1 */
+	at91_set_A_periph(AT91_PIN_PD9, 0);  /* CFCE2 */
+	at91_set_A_periph(AT91_PIN_PD14, 0); /* CFNRW */
+
+	/* assign CS4/5 to SMC with Compact Flash logic support
+	 * and fix resources addresses */
+	ebi0_csa = at91_sys_read(AT91_MATRIX_EBI0CSA);
+	switch (chipselect) {
+	case 4:
+		at91_set_A_periph(AT91_PIN_PD6, 0);  /* EBI0_NCS4/CFCS0 */
+		ebi0_csa |= AT91_MATRIX_EBI0_CS4A_SMC_CF1;
+		addr_space = AT91_CHIPSELECT_4;
+		break;
+	case 5:
+		at91_set_A_periph(AT91_PIN_PD7, 0);  /* EBI0_NCS5/CFCS1 */
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
+		return;
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
-- 
1.5.2.5
