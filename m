From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v10 06/10] libata: handle power transition of ODD
Date: Wed, 21 Nov 2012 19:50:35 +0800
Message-ID: <1353498639-27631-7-git-send-email-aaron.lu@intel.com>
References: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1353498639-27631-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jeff Wu <jeff.wu@amd.com>, Aaron Lu <aaron.lwe@gmail.com>, linux-ide@vger.kernel.org, linux-linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

When ata port is runtime suspended, it will check if the ODD attched to
it is in zero power ready state by checking the zp_ready field. And if
this field indicates it is not ready to be powered off, NO_POWEROFF qos
flag will be set to avoid choosing ACPI_STATE_D3_COLD for it.

And on resume, it will re-gain power and go through the recovery
process. When reset for the ata port is done, the ODD is considered
functional, and post processing like eject tray if the ODD is drawer
type is done there.

For normal ODDs that do not support zero power state, NO_POWEROFF qos
flag will always be set to avoid putting it into powered off state.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-acpi.c  | 40 +++++++++++++++++++++++++--------
 drivers/ata/libata-eh.c    |  2 ++
 drivers/ata/libata-zpodd.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata.h       |  8 +++++++
 include/linux/libata.h     |  2 ++
 5 files changed, 99 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 03ee60f..3a82177 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -832,6 +832,24 @@ void ata_acpi_on_resume(struct ata_port *ap)
 	}
 }
 
+static int ata_acpi_choose_state(struct ata_device *dev)
+{
+	/* Always choose D3 for PATA devices */
+	if (!(dev->link->ap->flags & ATA_FLAG_ACPI_SATA))
+		return ACPI_STATE_D3;
+
+	if (zpodd_dev_enabled(dev)) {
+		if (zpodd_poweroff_ready(dev))
+			dev_pm_qos_update_request(&dev->pm_qos_req, 0);
+		else
+			dev_pm_qos_update_request(&dev->pm_qos_req,
+						  PM_QOS_FLAG_NO_POWER_OFF);
+	}
+
+	return acpi_pm_device_sleep_state(&dev->sdev->sdev_gendev,
+					  NULL, ACPI_STATE_D3_COLD);
+}
+
 /**
  * ata_acpi_set_state - set the port power state
  * @ap: target ATA port
@@ -858,17 +876,16 @@ void ata_acpi_set_state(struct ata_port *ap, pm_message_t state)
 			continue;
 
 		if (state.event != PM_EVENT_ON) {
-			acpi_state = acpi_pm_device_sleep_state(
-				&dev->sdev->sdev_gendev, NULL, ACPI_STATE_D3);
-			if (acpi_state > 0)
+			acpi_state = ata_acpi_choose_state(dev);
+			if (acpi_state > 0) {
 				acpi_bus_set_power(handle, acpi_state);
-			/* TBD: need to check if it's runtime pm request */
-			acpi_pm_device_run_wake(
-				&dev->sdev->sdev_gendev, true);
+				if (zpodd_dev_enabled(dev) &&
+				    acpi_state == ACPI_STATE_D3_COLD)
+					zpodd_post_poweroff(dev);
+			}
 		} else {
-			/* Ditto */
-			acpi_pm_device_run_wake(
-				&dev->sdev->sdev_gendev, false);
+			if (zpodd_dev_enabled(dev))
+				zpodd_pre_poweron(dev);
 			acpi_bus_set_power(handle, ACPI_STATE_D0);
 		}
 	}
@@ -1002,7 +1019,12 @@ static void ata_acpi_unregister_power_resource(struct ata_device *dev)
 
 void ata_acpi_bind(struct ata_device *dev)
 {
+	/* ODD can't be put to D3 cold state, unless it is zero power capable */
+	s32 value = dev->class == ATA_DEV_ATAPI ? PM_QOS_FLAG_NO_POWER_OFF : 0;
+
 	ata_acpi_register_power_resource(dev);
+	dev_pm_qos_add_request(&dev->sdev->sdev_gendev, &dev->pm_qos_req,
+			       DEV_PM_QOS_FLAGS, value);
 }
 
 void ata_acpi_unbind(struct ata_device *dev)
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b928892..9426423 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3856,6 +3856,8 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 				rc = atapi_eh_clear_ua(dev);
 				if (rc)
 					goto rest_fail;
+				if (zpodd_dev_enabled(dev))
+					zpodd_post_resume(dev);
 			}
 		}
 
diff --git a/drivers/ata/libata-zpodd.c b/drivers/ata/libata-zpodd.c
index 719b814..d4dbe42 100644
--- a/drivers/ata/libata-zpodd.c
+++ b/drivers/ata/libata-zpodd.c
@@ -14,6 +14,7 @@ struct zpodd {
 	/* The following bits are synchronized by PM core */
 	bool from_notify:1; /* resumed as a result of acpi notification */
 	bool zp_ready:1;	/* zero power ready state */
+	bool powered_off:1;	/* ODD is powered off */
 
 	unsigned long last_ready; /* last zero power ready timestamp */
 
@@ -39,6 +40,17 @@ static int run_atapi_cmd(struct ata_device *dev, const char *cdb,
 			buf ? DMA_FROM_DEVICE : DMA_NONE, buf, buf_len, 0);
 }
 
+static int eject_tray(struct ata_device *dev)
+{
+	const char cdb[] = {  GPCMD_START_STOP_UNIT,
+			      0, 0, 0,
+			      0x02,     /* LoEj */
+			      0, 0, 0, 0, 0, 0, 0,
+	};
+
+	return run_atapi_cmd(dev, cdb, sizeof(cdb), NULL, 0);
+}
+
 /*
  * Per the spec, only slot type and drawer type ODD can be supported
  *
@@ -161,6 +173,50 @@ void zpodd_on_suspend(struct ata_device *dev)
 	zpodd->zp_ready = true;
 }
 
+bool zpodd_poweroff_ready(struct ata_device *dev)
+{
+	struct zpodd *zpodd = dev->zpodd;
+	return zpodd->zp_ready;
+}
+
+void zpodd_post_poweroff(struct ata_device *dev)
+{
+	struct zpodd *zpodd = dev->zpodd;
+
+	zpodd->powered_off = true;
+	device_set_run_wake(&dev->sdev->sdev_gendev, true);
+	acpi_pm_device_run_wake(&dev->sdev->sdev_gendev, true);
+}
+
+void zpodd_pre_poweron(struct ata_device *dev)
+{
+	struct zpodd *zpodd = dev->zpodd;
+
+	if (zpodd->powered_off) {
+		acpi_pm_device_run_wake(&dev->sdev->sdev_gendev, false);
+		device_set_run_wake(&dev->sdev->sdev_gendev, false);
+	}
+}
+
+void zpodd_post_resume(struct ata_device *dev)
+{
+	struct zpodd *zpodd = dev->zpodd;
+
+	if (!zpodd->powered_off)
+		return;
+
+	zpodd->powered_off = false;
+
+	if (zpodd->from_notify) {
+		zpodd->from_notify = false;
+		if (zpodd->drawer)
+			eject_tray(dev);
+	}
+
+	zpodd->last_ready = 0;
+	zpodd->zp_ready = false;
+}
+
 static void zpodd_wake_dev(acpi_handle handle, u32 event, void *context)
 {
 	struct ata_device *ata_dev = context;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index f9235dc..07aaffb 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -242,11 +242,19 @@ static inline bool zpodd_dev_enabled(struct ata_device *dev)
 	return dev->zpodd ? true : false;
 }
 void zpodd_on_suspend(struct ata_device *dev);
+bool zpodd_poweroff_ready(struct ata_device *dev);
+void zpodd_post_poweroff(struct ata_device *dev);
+void zpodd_pre_poweron(struct ata_device *dev);
+void zpodd_post_resume(struct ata_device *dev);
 #else /* CONFIG_SATA_ZPODD */
 static inline void zpodd_init(struct ata_device *dev) {}
 static inline void zpodd_exit(struct ata_device *dev) {}
 static inline bool zpodd_dev_enabled(struct ata_device *dev) { return false; }
 static inline void zpodd_on_suspend(struct ata_device *dev) {}
+static inline bool zpodd_poweroff_ready(struct ata_device *dev) { return false; }
+static inline void zpodd_post_poweroff(struct ata_device *dev) {}
+static inline void zpodd_pre_poweron(struct ata_device *dev) {}
+static inline void zpodd_post_resume(struct ata_device *dev) {}
 #endif /* CONFIG_SATA_ZPODD */
 
 #endif /* __LIBATA_H__ */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d550423..7969e14 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -38,6 +38,7 @@
 #include <linux/acpi.h>
 #include <linux/cdrom.h>
 #include <linux/sched.h>
+#include <linux/pm_qos.h>
 
 /*
  * Define if arch has non-standard setup.  This is a _PCI_ standard
@@ -618,6 +619,7 @@ struct ata_device {
 #ifdef CONFIG_ATA_ACPI
 	union acpi_object	*gtf_cache;
 	unsigned int		gtf_filter;
+	struct dev_pm_qos_request pm_qos_req;
 #endif
 #ifdef CONFIG_SATA_ZPODD
 	void			*zpodd;
-- 
1.7.12.4

