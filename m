From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] libata: Integrate ACPI-based PATA/SATA hotplug - version 2
Date: Sat, 15 Sep 2007 18:06:53 +0100
Message-ID: <20070915170652.GA25504@srcf.ucam.org>
References: <20070915030154.GA17655@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070915030154.GA17655@srcf.ucam.org>
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

Testing on an HP with the hotplug device as the slave on a PATA channel 
flagged a bug - the notification needs to be tied to the channel handle 
as well as the device ones. With this version, I can happily hotswap the 
HP device. It ends up sitting for a few seconds while failing to 
revalidate, but then recovers with everything working fine.

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index c059f78..99f3179 100644
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
@@ -81,7 +92,7 @@ static void ata_acpi_associate_ide_port(struct ata_port *ap)
  */
 void ata_acpi_associate(struct ata_host *host)
 {
-	int i;
+	int i, j;
 
 	if (!is_pci_dev(host->dev) || libata_noacpi)
 		return;
@@ -97,6 +108,22 @@ void ata_acpi_associate(struct ata_host *host)
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
+		for (j = 0; j < ATA_MAX_DEVICES; j++) {
+			struct ata_device *dev = &ap->device[j];
+
+			if (dev->acpi_handle)
+				acpi_install_notify_handler (ap->device->acpi_handle,
+							     ACPI_SYSTEM_NOTIFY,
+							     ata_acpi_notify,
+							     ap);
+		}
 	}
 }
  
-- 
Matthew Garrett | mjg59@srcf.ucam.org
