From: Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH] libata: add ledtrig support
Date: Fri, 12 Dec 2014 18:30:43 +0100
Message-ID: <20141212173008.GA32396@makrotopia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fudo.makrotopia.org ([5.135.190.93]:52406 "EHLO
	fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031011AbaLLRuA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Dec 2014 12:50:00 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: blogic@openwrt.org

This adds a LED trigger for each ATA port indicating disk activity.

As this is needed only on specific platforms (NAS SoCs and such),
these platforms should define ARCH_WANTS_LIBATA_LEDS if there
are boards with LED(s) intended to indicate ATA disk activity and
need the OS to take care of that.
In that way, if not selected, LED trigger support not will be
included in libata-core and both, codepaths and structures remain
untouched.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/ata/Kconfig       | 15 +++++++++++++++
 drivers/ata/libata-core.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  9 +++++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cd4cccb..3a92107 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -46,6 +46,21 @@ config ATA_VERBOSE_ERROR
 
 	  If unsure, say Y.
 
+config ARCH_WANT_LIBATA_LEDS
+	bool
+
+config ATA_LEDS
+	bool "support ATA port LED triggers"
+	depends on ARCH_WANT_LIBATA_LEDS
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LEDS_TRIGGERS
+	default y
+	help
+	  This option adds a LED trigger for each registered ATA port.
+	  It is used to drive disk activity leds connected via GPIO.
+
+
 config ATA_ACPI
 	bool "ATA ACPI Support"
 	depends on ACPI && PCI
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5c84fb5..4d5ec5a 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -725,6 +725,18 @@ u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev)
 	return block;
 }
 
+#if IS_ENABLED(CONFIG_ATA_LEDS)
+#define LIBATA_BLINK_DELAY 20 /* ms */
+static inline void ata_led_act(struct ata_port *ap)
+{
+	unsigned long led_delay = LIBATA_BLINK_DELAY;
+
+	if (likely(!ap->ledtrig))
+		return;
+	led_trigger_blink_oneshot(ap->ledtrig, &led_delay, &led_delay, 0);
+}
+#endif
+
 /**
  *	ata_build_rw_tf - Build ATA taskfile for given read/write request
  *	@tf: Target ATA taskfile
@@ -4761,6 +4773,9 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 			break;
 		}
 	}
+#if IS_ENABLED(CONFIG_ATA_LEDS)
+	ata_led_act(ap);
+#endif
 
 	return qc;
 }
@@ -5671,6 +5686,9 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->stats.unhandled_irq = 1;
 	ap->stats.idle_irq = 1;
 #endif
+#if IS_ENABLED(CONFIG_ATA_LEDS)
+	ap->ledtrig = kzalloc(sizeof(struct led_trigger), GFP_KERNEL);
+#endif
 	ata_sff_port_init(ap);
 
 	return ap;
@@ -5692,6 +5710,12 @@ static void ata_host_release(struct device *gendev, void *res)
 
 		kfree(ap->pmp_link);
 		kfree(ap->slave_link);
+#if IS_ENABLED(CONFIG_ATA_LEDS)
+		if (ap->ledtrig) {
+			led_trigger_unregister(ap->ledtrig);
+			kfree(ap->ledtrig);
+		};
+#endif
 		kfree(ap);
 		host->ports[i] = NULL;
 	}
@@ -6138,7 +6162,23 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 		host->ports[i]->print_id = atomic_inc_return(&ata_print_id);
 		host->ports[i]->local_port_no = i + 1;
 	}
+#if IS_ENABLED(CONFIG_ATA_LEDS)
+	for (i = 0; i < host->n_ports; i++) {
+		if (unlikely(!host->ports[i]->ledtrig))
+			continue;
+
+		snprintf(host->ports[i]->ledtrig_name,
+			sizeof(host->ports[i]->ledtrig_name), "ata%u",
+			host->ports[i]->print_id);
 
+		host->ports[i]->ledtrig->name = host->ports[i]->ledtrig_name;
+
+		if (led_trigger_register(host->ports[i]->ledtrig)) {
+			kfree(host->ports[i]->ledtrig);
+			host->ports[i]->ledtrig = NULL;
+		}
+	}
+#endif
 	/* Create associated sysfs transport objects  */
 	for (i = 0; i < host->n_ports; i++) {
 		rc = ata_tport_add(host->dev,host->ports[i]);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 2d18241..aea611c 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -38,6 +38,9 @@
 #include <linux/acpi.h>
 #include <linux/cdrom.h>
 #include <linux/sched.h>
+#if IS_ENABLED(CONFIG_ATA_LEDS)
+#include <linux/leds.h>
+#endif
 
 /*
  * Define if arch has non-standard setup.  This is a _PCI_ standard
@@ -862,6 +865,12 @@ struct ata_port {
 #ifdef CONFIG_ATA_ACPI
 	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
+
+#if IS_ENABLED(CONFIG_ATA_LEDS)
+	struct led_trigger	*ledtrig;
+	char			ledtrig_name[8];
+#endif
+
 	/* owned by EH */
 	u8			sector_buf[ATA_SECT_SIZE] ____cacheline_aligned;
 };
-- 
2.1.3

