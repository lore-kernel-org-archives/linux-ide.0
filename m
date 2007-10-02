From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version 4
Date: Tue, 2 Oct 2007 19:49:58 +0100
Message-ID: <20071002184958.GC31251@srcf.ucam.org>
References: <20070920222138.GA3740@srcf.ucam.org> <46F32DD9.7010509@gmail.com> <20070921024214.GA6317@srcf.ucam.org> <46F3322D.5090407@gmail.com> <20070921025734.GA6434@srcf.ucam.org> <46F33597.1000307@gmail.com> <20070921031245.GA6628@srcf.ucam.org> <46F33824.6000707@gmail.com> <20070924231436.GA32119@srcf.ucam.org> <47025E09.1030803@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47025E09.1030803@garzik.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kristen.c.accardi@intel.com
List-Id: linux-ide@vger.kernel.org

Modern laptops with hotswap bays still tend to utilise a PATA interface 
on a SATA bridge, generally with the host controller in some legacy 
emulation mode rather than AHCI. This means that the existing hotplug 
code in libata is unable to work. The ACPI specification states that 
these devices can send notifications when hotswapped, which avoids the 
need to obtain notification from the controller. This patch uses the 
existing libata-acpi code and simply registers a notification in order 
to trigger a rescan whenever the firmware signals an event.
                                                                                                                                                                                                        
Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>                        

---

This incorporates Jeff's feedback. sdev is checked for NULL, and 
different notifications are registered for ap-level and dev-level 
handlers. The core code is split out into a helper function called by 
both of these. The other change is the removal of the extraneous newline 
from the end of the notification event, to match the upstream change in 
the bay driver.

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index c059f78..4d8f1ba 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/libata.h>
 #include <linux/pci.h>
+#include <scsi/scsi_device.h>
 #include "libata.h"
 
 #include <acpi/acpi_bus.h>
@@ -66,6 +67,47 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
 	}
 }
 
+static void ata_acpi_handle_hotplug (struct ata_port *ap, struct kobject *kobj,
+				     u32 event)
+{
+	char event_string[12];
+	char *envp[] = { event_string, NULL };
+	struct ata_eh_info *ehi = &ap->eh_info;
+
+	if (event == 0 || event == 1) {
+	       unsigned long flags;
+	       spin_lock_irqsave(ap->lock, flags);
+	       ata_ehi_clear_desc(ehi);
+	       ata_ehi_push_desc(ehi, "ACPI event");
+	       ata_ehi_hotplugged(ehi);
+	       ata_port_freeze(ap);
+	       spin_unlock_irqrestore(ap->lock, flags);
+	}
+
+	if (kobj) {
+	        sprintf(event_string, "BAY_EVENT=%d", event);
+		kobject_uevent_env(kobj, KOBJ_CHANGE, envp);
+	}
+}
+
+static void ata_acpi_dev_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct ata_device *dev = data;
+	struct kobject *kobj = NULL;
+
+	if (dev->sdev)
+		kobj = &dev->sdev->sdev_gendev.kobj;
+
+	ata_acpi_handle_hotplug (dev->ap, kobj, event);
+}
+
+static void ata_acpi_ap_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct ata_port *ap = data;
+
+	ata_acpi_handle_hotplug (ap, &ap->dev->kobj, event);
+}
+
 /**
  * ata_acpi_associate - associate ATA host with ACPI objects
  * @host: target ATA host
@@ -81,7 +123,7 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
  */
 void ata_acpi_associate(struct ata_host *host)
 {
-	int i;
+	int i, j;
 
 	if (!is_pci_dev(host->dev) || libata_noacpi)
 		return;
@@ -97,6 +139,22 @@ void ata_acpi_associate(struct ata_host *host)
 			ata_acpi_associate_sata_port(ap);
 		else
 			ata_acpi_associate_ide_port(ap);
+
+		if (ap->acpi_handle)
+			acpi_install_notify_handler (ap->acpi_handle,
+						     ACPI_SYSTEM_NOTIFY,
+						     ata_acpi_ap_notify,
+						     ap);
+
+		for (j = 0; j < ata_port_max_devices(ap); j++) {
+			struct ata_device *dev = &ap->device[j];
+
+			if (dev->acpi_handle)
+				acpi_install_notify_handler (dev->acpi_handle,
+							     ACPI_SYSTEM_NOTIFY,
+							     ata_acpi_dev_notify,
+							     dev);
+		}
 	}
 }
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
