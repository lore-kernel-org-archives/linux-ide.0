From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream-fixes] libata-acpi: improve dock event
 handling
Date: Wed, 12 Mar 2008 14:24:43 +0900
Message-ID: <47D7691B.3080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.226]:17413 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbYCLFYv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Mar 2008 01:24:51 -0400
Received: by qb-out-0506.google.com with SMTP id e11so2762595qbe.15
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 22:24:50 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hmacht@suse.de, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Improve ACPI hotplug handling such that dock event is handled properly.

* Register handlers for dock events.

* Directly detach device on EJECT_REQUEST instead of signaling hotplug
  event.  This prevents libata from accessing severed controller
  and/or device.

* While at it, use named constants for ACPI events and move uevent
  signaling inside host lock.

Original patch and testing by Holger Macht.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Holger Macht <hmacht@suse.de>
---
 drivers/ata/libata-acpi.c |   96 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 27 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 0770cb7..bf98a56 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -118,45 +118,77 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
 		ap->pflags |= ATA_PFLAG_INIT_GTM_VALID;
 }
 
-static void ata_acpi_handle_hotplug(struct ata_port *ap, struct kobject *kobj,
+static void ata_acpi_handle_hotplug(struct ata_port *ap, struct ata_device *dev,
 				    u32 event)
 {
 	char event_string[12];
 	char *envp[] = { event_string, NULL };
-	struct ata_eh_info *ehi = &ap->link.eh_info;
-
-	if (event == 0 || event == 1) {
-	       unsigned long flags;
-	       spin_lock_irqsave(ap->lock, flags);
-	       ata_ehi_clear_desc(ehi);
-	       ata_ehi_push_desc(ehi, "ACPI event");
-	       ata_ehi_hotplugged(ehi);
-	       ata_port_freeze(ap);
-	       spin_unlock_irqrestore(ap->lock, flags);
+	struct ata_eh_info *ehi;
+	struct kobject *kobj = NULL;
+	int wait = 0;
+	unsigned long flags;
+
+	if (!ap)
+		ap = dev->link->ap;
+	ehi = &ap->link.eh_info;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	switch (event) {
+	case ACPI_NOTIFY_BUS_CHECK:
+	case ACPI_NOTIFY_DEVICE_CHECK:
+		ata_ehi_push_desc(ehi, "ACPI event");
+		ata_ehi_hotplugged(ehi);
+		ata_port_freeze(ap);
+		break;
+
+	case ACPI_NOTIFY_EJECT_REQUEST:
+		ata_ehi_push_desc(ehi, "ACPI event");
+		if (dev)
+			dev->flags |= ATA_DFLAG_DETACH;
+		else {
+			struct ata_link *tlink;
+			struct ata_device *tdev;
+
+			ata_port_for_each_link(tlink, ap)
+				ata_link_for_each_dev(tdev, tlink)
+					tdev->flags |= ATA_DFLAG_DETACH;
+		}
+
+		ata_port_schedule_eh(ap);
+		wait = 1;
+		break;
 	}
 
+	if (dev) {
+		if (dev->sdev)
+			kobj = &dev->sdev->sdev_gendev.kobj;
+	} else
+		kobj = &ap->dev->kobj;
+
 	if (kobj) {
 		sprintf(event_string, "BAY_EVENT=%d", event);
 		kobject_uevent_env(kobj, KOBJ_CHANGE, envp);
 	}
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	if (wait)
+		ata_port_wait_eh(ap);
 }
 
 static void ata_acpi_dev_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct ata_device *dev = data;
-	struct kobject *kobj = NULL;
 
-	if (dev->sdev)
-		kobj = &dev->sdev->sdev_gendev.kobj;
-
-	ata_acpi_handle_hotplug(dev->link->ap, kobj, event);
+	ata_acpi_handle_hotplug(NULL, dev, event);
 }
 
 static void ata_acpi_ap_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct ata_port *ap = data;
 
-	ata_acpi_handle_hotplug(ap, &ap->dev->kobj, event);
+	ata_acpi_handle_hotplug(ap, NULL, event);
 }
 
 /**
@@ -191,20 +223,30 @@ void ata_acpi_associate(struct ata_host *host)
 		else
 			ata_acpi_associate_ide_port(ap);
 
-		if (ap->acpi_handle)
-			acpi_install_notify_handler (ap->acpi_handle,
-						     ACPI_SYSTEM_NOTIFY,
-						     ata_acpi_ap_notify,
-						     ap);
+		if (ap->acpi_handle) {
+			acpi_install_notify_handler(ap->acpi_handle,
+						    ACPI_SYSTEM_NOTIFY,
+						    ata_acpi_ap_notify, ap);
+#if defined(CONFIG_ACPI_DOCK) || defined(CONFIG_ACPI_DOCK_MODULE)
+			/* we might be on a docking station */
+			register_hotplug_dock_device(ap->acpi_handle,
+						     ata_acpi_ap_notify, ap);
+#endif
+		}
 
 		for (j = 0; j < ata_link_max_devices(&ap->link); j++) {
 			struct ata_device *dev = &ap->link.device[j];
 
-			if (dev->acpi_handle)
-				acpi_install_notify_handler (dev->acpi_handle,
-							     ACPI_SYSTEM_NOTIFY,
-							     ata_acpi_dev_notify,
-							     dev);
+			if (dev->acpi_handle) {
+				acpi_install_notify_handler(dev->acpi_handle,
+						ACPI_SYSTEM_NOTIFY,
+						ata_acpi_dev_notify, dev);
+#if defined(CONFIG_ACPI_DOCK) || defined(CONFIG_ACPI_DOCK_MODULE)
+				/* we might be on a docking station */
+				register_hotplug_dock_device(dev->acpi_handle,
+						ata_acpi_dev_notify, dev);
+#endif
+			}
 		}
 	}
 }
