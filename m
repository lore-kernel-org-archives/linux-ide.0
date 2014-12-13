From: Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v2] libata: add ledtrig support
Date: Sat, 13 Dec 2014 01:07:20 +0100
Message-ID: <20141213000714.GA24441@makrotopia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fudo.makrotopia.org ([5.135.190.93]:60625 "EHLO
	fudo.makrotopia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185AbaLMAG1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Dec 2014 19:06:27 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Dave Miller <davem@davemloft.net>

This adds a LED trigger for each ATA port indicating disk activity.

As this is needed only on specific platforms (NAS SoCs and such),
these platforms should define ARCH_WANTS_LIBATA_LEDS if there
are boards with LED(s) intended to indicate ATA disk activity and
need the OS to take care of that.
In that way, if not selected, LED trigger support not will be
included in libata-core and both, codepaths and structures remain
untouched.

I'm currently deploying this for the oxnas target in OpenWrt
https://dev.openwrt.org/changeset/43675/

v2: rebased to kernel/git/tj/libata.git
    plus small corrections and comments added

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---

If there is anything fundamentally wrong with that approach, I'd be
glad for some advise on how to do it better.
I conciously choose an #ifdev approach to make sure performance will
not be affected for non-users of that code.

Thanks

Daniel

---
 drivers/ata/Kconfig       | 16 ++++++++++++++
 drivers/ata/libata-core.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  7 ++++++
 3 files changed, 79 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cd4cccb..7a085ec 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -46,6 +46,22 @@ config ATA_VERBOSE_ERROR
 
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
+	  If unsure, say N.
+
 config ATA_ACPI
 	bool "ATA ACPI Support"
 	depends on ACPI && PCI
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c5ba15a..615d11c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -725,6 +725,7 @@ u64 ata_tf_read_block(struct ata_taskfile *tf, struct ata_device *dev)
 	return block;
 }
 
+
 /**
  *	ata_build_rw_tf - Build ATA taskfile for given read/write request
  *	@tf: Target ATA taskfile
@@ -4718,6 +4719,30 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 }
 
 /**
+ *	ata_led_act - Trigger port activity LED
+ *	@ap: indicating port
+ *
+ *	Blinks any LEDs registered to the trigger.
+ *	Commonly used with leds-gpio on NAS systems with disk activity
+ *	indicator LEDs.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static inline void ata_led_act(struct ata_port *ap)
+{
+#if CONFIG_ATA_LEDS
+#define LIBATA_BLINK_DELAY 20 /* ms */
+	unsigned long led_delay = LIBATA_BLINK_DELAY;
+
+	if (unlikely(!ap->ledtrig))
+		return;
+
+	led_trigger_blink_oneshot(ap->ledtrig, &led_delay, &led_delay, 0);
+#endif /* CONFIG_ATA_LEDS */
+}
+
+/**
  *	ata_qc_new - Request an available ATA command, for queueing
  *	@ap: target port
  *
@@ -4753,6 +4778,9 @@ static struct ata_queued_cmd *ata_qc_new(struct ata_port *ap)
 			break;
 		}
 	}
+#if CONFIG_ATA_LEDS
+	ata_led_act(ap);
+#endif
 
 	return qc;
 }
@@ -5663,6 +5691,9 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->stats.unhandled_irq = 1;
 	ap->stats.idle_irq = 1;
 #endif
+#if CONFIG_ATA_LEDS
+	ap->ledtrig = kzalloc(sizeof(struct led_trigger), GFP_KERNEL);
+#endif
 	ata_sff_port_init(ap);
 
 	return ap;
@@ -5684,6 +5715,12 @@ static void ata_host_release(struct device *gendev, void *res)
 
 		kfree(ap->pmp_link);
 		kfree(ap->slave_link);
+#if CONFIG_ATA_LEDS
+		if (ap->ledtrig) {
+			led_trigger_unregister(ap->ledtrig);
+			kfree(ap->ledtrig);
+		};
+#endif
 		kfree(ap);
 		host->ports[i] = NULL;
 	}
@@ -6131,6 +6168,25 @@ int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 		host->ports[i]->local_port_no = i + 1;
 	}
 
+#if CONFIG_ATA_LEDS
+	/* register LED triggers for all ports */
+	for (i = 0; i < host->n_ports; i++) {
+		if (unlikely(!host->ports[i]->ledtrig))
+			continue;
+
+		snprintf(host->ports[i]->ledtrig_name,
+			sizeof(host->ports[i]->ledtrig_name), "ata%u",
+			host->ports[i]->print_id);
+
+		host->ports[i]->ledtrig->name = host->ports[i]->ledtrig_name;
+
+		if (led_trigger_register(host->ports[i]->ledtrig)) {
+			kfree(host->ports[i]->ledtrig);
+			host->ports[i]->ledtrig = NULL;
+		}
+	}
+#endif
+
 	/* Create associated sysfs transport objects  */
 	for (i = 0; i < host->n_ports; i++) {
 		rc = ata_tport_add(host->dev,host->ports[i]);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bfbc817..4f9c918 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -38,6 +38,7 @@
 #include <linux/acpi.h>
 #include <linux/cdrom.h>
 #include <linux/sched.h>
+#include <linux/leds.h>
 
 /*
  * Define if arch has non-standard setup.  This is a _PCI_ standard
@@ -861,6 +862,12 @@ struct ata_port {
 #ifdef CONFIG_ATA_ACPI
 	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
 #endif
+
+#ifdef CONFIG_ATA_LEDS
+	struct led_trigger	*ledtrig;
+	char			ledtrig_name[8];
+#endif
+
 	/* owned by EH */
 	u8			sector_buf[ATA_SECT_SIZE] ____cacheline_aligned;
 };
-- 
2.1.3

