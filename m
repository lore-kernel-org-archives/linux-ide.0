From: Holger Macht <hmacht@suse.de>
Subject: [PATCH] libata: Register for dock events when the drive is inside
	a dock station
Date: Thu, 14 Feb 2008 13:40:48 +0100
Message-ID: <20080214124048.GB9708@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45208 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760606AbYBNMj4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 07:39:56 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>

If a device/bay is inside a docking station, we need to register for dock
events additionally to bay events. If a dock event occurs, the dock driver
will call the appropriate handler (ata_acpi_ap_notify() or
ata_acpi_dev_notify()) for us.

Signed-off-by: Holger Macht <hmacht@suse.de>
---

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 9e8ec19..fbe7b34 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -191,20 +191,29 @@ void ata_acpi_associate(struct ata_host *host)
 		else
 			ata_acpi_associate_ide_port(ap);
 
-		if (ap->acpi_handle)
+		if (ap->acpi_handle) {
 			acpi_install_notify_handler (ap->acpi_handle,
 						     ACPI_SYSTEM_NOTIFY,
 						     ata_acpi_ap_notify,
 						     ap);
+			/* we might be on a docking station */
+			register_hotplug_dock_device(ap->acpi_handle,
+						     ata_acpi_ap_notify, ap);
+		}
 
 		for (j = 0; j < ata_link_max_devices(&ap->link); j++) {
 			struct ata_device *dev = &ap->link.device[j];
 
-			if (dev->acpi_handle)
+			if (dev->acpi_handle) {
 				acpi_install_notify_handler (dev->acpi_handle,
 							     ACPI_SYSTEM_NOTIFY,
 							     ata_acpi_dev_notify,
 							     dev);
+				/* we might be on a docking station */
+				register_hotplug_dock_device(ap->acpi_handle,
+							     ata_acpi_dev_notify,
+							     ap);
+			}
 		}
 	}
 }
