From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version 3
Date: Tue, 25 Sep 2007 00:14:36 +0100
Message-ID: <20070924231436.GA32119@srcf.ucam.org>
References: <20070915170652.GA25504@srcf.ucam.org> <46F2EE66.9060207@garzik.org> <20070920222138.GA3740@srcf.ucam.org> <46F32DD9.7010509@gmail.com> <20070921024214.GA6317@srcf.ucam.org> <46F3322D.5090407@gmail.com> <20070921025734.GA6434@srcf.ucam.org> <46F33597.1000307@gmail.com> <20070921031245.GA6628@srcf.ucam.org> <46F33824.6000707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:53557 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbXIXXO7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 19:14:59 -0400
Content-Disposition: inline
In-Reply-To: <46F33824.6000707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, kristen.c.accardi@intel.com

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

This makes two changes to the previous patch:

1) It implements the locking suggested by Tejun
2) It sends a uevent on the device kobject. I've implemented this 
because grabbing the notification handler means that the bay driver can 
no longer do it, so it's necessary to generate compatible events. If the 
event type is 3, it indicates that the user has merely requested an 
eject - the drive hasn't gone at this point. Sending the notification 
allows userspace to attempt to unmount the filesystems before sending a 
command to initiate the eject. 

I'm not especially happy about the chain used to get the scsi device 
kobject. Is there a cleaner way to do that? Other than that, I've now 
tested this on multiple systems (a 965-based Thinkpad, a 915-era Dell 
and even an HP with no SATA whatsoever) without any obvious breakage.

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index c059f78..68bb7fa 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/libata.h>
 #include <linux/pci.h>
+#include <scsi/scsi_device.h>
 #include "libata.h"
 
 #include <acpi/acpi_bus.h>
@@ -66,6 +67,41 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
 	}
 }
 
+static void ata_acpi_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct ata_port *ap = data;
+	struct ata_eh_info *ehi = &ap->eh_info;
+	char event_string[12];
+	char *envp[] = { event_string, NULL };
+	struct kobject *kobj = NULL;
+	int i;
+
+	if (ap->acpi_handle && handle == ap->acpi_handle)
+	        kobj = &ap->dev->kobj;
+	else {
+		for (i = 0; i < ata_port_max_devices(ap); i++) {
+			struct ata_device *dev = &ap->device[i];
+			if (dev->acpi_handle && handle == dev->acpi_handle) 
+			        kobj = &dev->sdev->sdev_gendev.kobj;
+		}
+	}
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
+	        sprintf(event_string, "BAY_EVENT=%d\n", event);
+		kobject_uevent_env(kobj, KOBJ_CHANGE, envp);
+	}
+}
+
 /**
  * ata_acpi_associate - associate ATA host with ACPI objects
  * @host: target ATA host
@@ -81,7 +117,7 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
  */
 void ata_acpi_associate(struct ata_host *host)
 {
-	int i;
+	int i, j;
 
 	if (!is_pci_dev(host->dev) || libata_noacpi)
 		return;
@@ -97,6 +133,22 @@ void ata_acpi_associate(struct ata_host *host)
 			ata_acpi_associate_sata_port(ap);
 		else
 			ata_acpi_associate_ide_port(ap);
+
+		if (ap->acpi_handle)
+			acpi_install_notify_handler (ap->acpi_handle,
+						     ACPI_SYSTEM_NOTIFY,
+						     ata_acpi_notify,
+						     ap);
+
+		for (j = 0; j < ata_port_max_devices(ap); j++) {
+			struct ata_device *dev = &ap->device[j];
+
+			if (dev->acpi_handle)
+				acpi_install_notify_handler (dev->acpi_handle,
+							     ACPI_SYSTEM_NOTIFY,
+							     ata_acpi_notify,
+							     ap);
+		}
 	}
 }
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
