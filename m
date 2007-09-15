From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug
Date: Sat, 15 Sep 2007 04:01:54 +0100
Message-ID: <20070915030154.GA17655@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
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

I've tested this on the Dell I have here - the removal is a bit chatty 
(and it spends several seconds attempting to revalidate), but it 
destroys the device happily enough and handles reinsertion without 
complaining.

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index c059f78..bc6bea6 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -66,6 +66,17 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
 	}
 }
 
+static void ata_acpi_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct ata_port *ap = data;
+	struct ata_eh_info *ehi = &ap->eh_info;
+
+	ata_ehi_clear_desc(ehi);
+	ata_ehi_push_desc(ehi, "ACPI event");
+	ata_ehi_hotplugged(ehi);
+	ata_port_freeze(ap);
+}
+
 /**
  * ata_acpi_associate - associate ATA host with ACPI objects
  * @host: target ATA host
@@ -97,6 +108,12 @@ void ata_acpi_associate(struct ata_host *host)
 			ata_acpi_associate_sata_port(ap);
 		else
 			ata_acpi_associate_ide_port(ap);
+
+		if (ap->device->acpi_handle)
+			acpi_install_notify_handler (ap->device->acpi_handle,
+						     ACPI_SYSTEM_NOTIFY,
+						     ata_acpi_notify,
+						     ap);
 	}
 }
 
-- 
Matthew Garrett | mjg59@srcf.ucam.org
