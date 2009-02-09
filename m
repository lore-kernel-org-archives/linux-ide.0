From: Stanislaw Gruszka <stf_xl@wp.pl>
Subject: [PATCH 3/3 v3] AT91: initialize Compact Flash on AT91SAM9263 cpu
Date: Mon, 9 Feb 2009 11:45:11 +0100
Message-ID: <200902091145.11266.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.wp.pl ([212.77.101.5]:45824 "EHLO mx1.wp.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941AbZBIKpS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Feb 2009 05:45:18 -0500
Received: from ebg226.internetdsl.tpnet.pl (HELO staszek-desktop.local) (stf_xl@wp.pl@[83.14.136.226])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <linux-ide@vger.kernel.org>; 9 Feb 2009 11:45:11 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Andrew Victor <avictor.za@gmail.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk

Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 arch/arm/mach-at91/at91sam9263_devices.c |  104 ++++++++++++++++++++++++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index b753cb8..8e46abe 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/i2c-gpio.h>
+#include <linux/delay.h>
 
 #include <linux/fb.h>
 #include <video/atmel_lcdc.h>
@@ -347,6 +348,109 @@ void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data)
 void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  Compact Flash (PCMCIA or IDE)
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_AT91_CF) || defined(CONFIG_AT91_CF_MODULE) || \
+    defined(CONFIG_BLK_DEV_IDE_AT91) || defined(CONFIG_BLK_DEV_IDE_AT91_MODULE)
+
+static struct resource cf_resources[] = {
+	[0] = {
+		.start	= 0,
+		.end	= 0,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct at91_cf_data cf_data;
+
+static struct platform_device at91_cf_device = {
+	.id 	= -1,
+	.dev	= {
+		.platform_data = &cf_data,
+	},
+	.resource = cf_resources,
+	.num_resources = ARRAY_SIZE(cf_resources),
+};
+
+void __init at91_add_device_cf(struct at91_cf_data *data)
+{
+	unsigned long ebi0_csa, addr_space;
+
+	if (!data)
+		return;
+
+	/*
+	 * assign CS4 or CS5 to SMC with Compact Flash logic support,
+	 * we assume SMC timings are configured by board code,
+	 * except True IDE where timings are controlled by driver
+	 */
+	ebi0_csa = at91_sys_read(AT91_MATRIX_EBI0CSA);
+	switch (data->chipselect) {
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
+		printk(KERN_ERR "AT91 CF: bad chip-select requested (%u)\n",
+		       data->chipselect);
+		return;
+	}
+	at91_sys_write(AT91_MATRIX_EBI0CSA, ebi0_csa);
+
+	cf_resources[0].start = addr_space;
+	cf_resources[0].end = addr_space + SZ_256M - 1;
+
+	if (data->det_pin) {
+		at91_set_gpio_input(data->det_pin, 1);
+		at91_set_deglitch(data->det_pin, 1);
+	}
+
+	if (data->irq_pin) {
+		at91_set_gpio_input(data->irq_pin, 1);
+		at91_set_deglitch(data->irq_pin, 1);
+	}
+
+	if (data->vcc_pin)
+		/* initially off */
+		at91_set_gpio_output(data->vcc_pin, 0);
+
+	/* enable EBI controlled pins */
+	at91_set_A_periph(AT91_PIN_PD5, 1);  /* NWAIT */
+	at91_set_A_periph(AT91_PIN_PD8, 0);  /* CFCE1 */
+	at91_set_A_periph(AT91_PIN_PD9, 0);  /* CFCE2 */
+	at91_set_A_periph(AT91_PIN_PD14, 0); /* CFNRW */
+
+	if (data->flags & AT91_CF_TRUE_IDE) {
+		/* check if device is present */
+		if (data->det_pin && at91_get_gpio_value(data->det_pin) != 0) {
+			printk(KERN_ERR "AT91 CF True IDE: no device detected\n");
+			return;
+		}
+		if (data->rst_pin) {
+			/* reset the card */
+			at91_set_gpio_output(data->rst_pin, 0);
+			/* wait as defined in ATA7 vol2 (rev 4a) figure 36 */
+			udelay(25);
+			at91_set_gpio_output(data->rst_pin, 1);
+		}
+		at91_cf_device.name = "at91_ide";
+	} else
+		at91_cf_device.name = "at91_cf";
+
+	cf_data = *data;
+	platform_device_register(&at91_cf_device);
+}
+#else
+void __init at91_add_device_cf(struct at91_cf_data *data) {}
+#endif
 
 /* --------------------------------------------------------------------
  *  NAND / SmartMedia
-- 
1.5.2.5

