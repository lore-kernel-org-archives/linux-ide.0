From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version 5
Date: Wed, 3 Oct 2007 01:24:16 +0100
Message-ID: <20071003002416.GA3906@srcf.ucam.org>
References: <46F33597.1000307@gmail.com> <20070921031245.GA6628@srcf.ucam.org> <46F33824.6000707@gmail.com> <20070924231436.GA32119@srcf.ucam.org> <47025E09.1030803@garzik.org> <20071002184958.GC31251@srcf.ucam.org> <47029423.6030605@garzik.org> <4702AC3B.2010004@garzik.org> <20071002212028.GA967@srcf.ucam.org> <4702B6C5.2070903@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:39255 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbXJCAYf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 20:24:35 -0400
Content-Disposition: inline
In-Reply-To: <4702B6C5.2070903@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kristen.c.accardi@intel.com

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

Diffed against #upstream. Fairly sure I've got it right this time...

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index a276c06..5ebbf16 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/libata.h>
 #include <linux/pci.h>
+#include <scsi/scsi_device.h>
 #include "libata.h"
 
 #include <acpi/acpi_bus.h>
@@ -95,6 +96,47 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
 	}
 }
 
+static void ata_acpi_handle_hotplug (struct ata_port *ap, struct kobject *kobj,
+				     u32 event)
+{
+	char event_string[12];
+	char *envp[] = { event_string, NULL };
+	struct ata_eh_info *ehi = &ap->link.eh_info;
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
+	ata_acpi_handle_hotplug (dev->link->ap, kobj, event);
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
@@ -110,7 +152,7 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
  */
 void ata_acpi_associate(struct ata_host *host)
 {
-	int i;
+	int i, j;
 
 	if (!is_pci_dev(host->dev) || libata_noacpi)
 		return;
@@ -126,6 +168,22 @@ void ata_acpi_associate(struct ata_host *host)
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
+		for (j = 0; j < ata_link_max_devices(&ap->link); j++) {
+			struct ata_device *dev = &ap->link.device[j];
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
