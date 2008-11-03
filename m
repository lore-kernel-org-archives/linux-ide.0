From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/8] SATA PIIX: Blacklist system that spins off disks during ACPI power off
Date: Mon,  3 Nov 2008 19:01:07 +0900
Message-ID: <1225706469-27870-7-git-send-email-tj@kernel.org>
References: <1225706469-27870-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60511 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754736AbYKCKBf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 05:01:35 -0500
In-Reply-To: <1225706469-27870-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Tejun Heo <tj@kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Some notebooks from HP have the problem that their BIOSes attempt to
spin down hard drives before entering ACPI system states S4 and S5.
This leads to a yo-yo effect during system power-off shutdown and the
last phase of hibernation when the disk is first spun down by the
kernel and then almost immediately turned on and off by the BIOS.
This, in turn, may result in shortening the disk's life times.

To prevent this from happening we can blacklist the affected systems
using DMI information.

Blacklist HP 2510p that uses the ata_piix driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/ata_piix.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index 8e37be1..f5fff92 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1370,6 +1370,32 @@ static void piix_iocfg_bit18_quirk(struct pci_dev *pdev)
 	}
 }
 
+static bool piix_broken_system_poweroff(struct pci_dev *pdev)
+{
+	static const struct dmi_system_id broken_systems[] = {
+		{
+			.ident = "HP Compaq 2510p",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq 2510p"),
+			},
+			/* PCI slot number of the controller */
+			.driver_data = (void *)0x1FUL,
+		},
+
+		{ }	/* terminate list */
+	};
+	const struct dmi_system_id *dmi = dmi_first_match(broken_systems);
+
+	if (dmi) {
+		unsigned long slot = (unsigned long)dmi->driver_data;
+		/* apply the quirk only to on-board controllers */
+		return slot == PCI_SLOT(pdev->devfn);
+	}
+
+	return false;
+}
+
 /**
  *	piix_init_one - Register PIIX ATA PCI device with kernel services
  *	@pdev: PCI device to register
@@ -1405,6 +1431,14 @@ static int __devinit piix_init_one(struct pci_dev *pdev,
 	if (!in_module_init)
 		return -ENODEV;
 
+	if (piix_broken_system_poweroff(pdev)) {
+		piix_port_info[ent->driver_data].flags |=
+				ATA_FLAG_NO_POWEROFF_SPINDOWN |
+					ATA_FLAG_NO_HIBERNATE_SPINDOWN;
+		dev_info(&pdev->dev, "quirky BIOS, skipping spindown "
+				"on poweroff and hibernation\n");
+	}
+
 	port_info[0] = piix_port_info[ent->driver_data];
 	port_info[1] = piix_port_info[ent->driver_data];
 
-- 
1.5.4.5

