From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/8] SATA Sil: Blacklist system that spins off disks during ACPI power off
Date: Mon,  3 Nov 2008 19:01:06 +0900
Message-ID: <1225706469-27870-6-git-send-email-tj@kernel.org>
References: <1225706469-27870-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34653 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754883AbYKCKBh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 05:01:37 -0500
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

Blacklist HP nx6325 that uses the sata_sil driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/sata_sil.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 031d7b7..f1dd478 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -603,11 +603,38 @@ static void sil_init_controller(struct ata_host *host)
 	}
 }
 
+static bool sil_broken_system_poweroff(struct pci_dev *pdev)
+{
+	static const struct dmi_system_id broken_systems[] = {
+		{
+			.ident = "HP Compaq nx6325",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq nx6325"),
+			},
+			/* PCI slot number of the controller */
+			.driver_data = (void *)0x12UL,
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
 static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
 	int board_id = ent->driver_data;
-	const struct ata_port_info *ppi[] = { &sil_port_info[board_id], NULL };
+	struct ata_port_info pi = sil_port_info[board_id];
+	const struct ata_port_info *ppi[] = { &pi, NULL };
 	struct ata_host *host;
 	void __iomem *mmio_base;
 	int n_ports, rc;
@@ -621,6 +648,13 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (board_id == sil_3114)
 		n_ports = 4;
 
+	if (sil_broken_system_poweroff(pdev)) {
+		pi.flags |= ATA_FLAG_NO_POWEROFF_SPINDOWN |
+					ATA_FLAG_NO_HIBERNATE_SPINDOWN;
+		dev_info(&pdev->dev, "quirky BIOS, skipping spindown "
+				"on poweroff and hibernation\n");
+	}
+
 	host = ata_host_alloc_pinfo(&pdev->dev, ppi, n_ports);
 	if (!host)
 		return -ENOMEM;
-- 
1.5.4.5

