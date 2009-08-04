From: Tejun Heo <teheo@novell.com>
Subject: [PATCH 4/4 #upstream-fixes] ahci: filter FPDMA non-zero offset enable
 for Aspire 3810T
Date: Tue, 04 Aug 2009 17:57:37 +0900
Message-ID: <4A77F801.6080908@novell.com>
References: <4A77F6B8.4000000@kernel.org> <4A77F6E4.6070800@novell.com> <4A77F718.7040703@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:46114 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932417AbZHDI5x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 04:57:53 -0400
In-Reply-To: <4A77F718.7040703@novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>, meissner@novell.com

Curiously, Aspire 3810T issues many SATA feature enable commands via
_GTF, of which one is invalid and another is not supported by the
drive.  In the process, it also enables FPDMA non-zero offset.
However, the feature also needs to be supported and enabled from the
controller and it's wrong to enable it from _GTF unless the controller
can do it by default.

Currently, this ends up enabling FPDMA non-zero offset only on the
drive side leading to NCQ command failures and eventual disabling of
NCQ.  This patch makes libata filter out FPDMA non-zero offset enable
for the machine.

This was reported by Marcus Meissner in bnc#522790.

  https://bugzilla.novell.com/show_bug.cgi?id=522790

Reported-by: Marcus Meissner <meissner@novell.com>
---
This concludes the four patches to work around a device configuration
issue caused by strange _GTF.  This looks a bit pervasive for
#upstream-fixes but the changes should only affect the problematic
machine and be fairly safe.

Thanks.

 drivers/ata/ahci.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 958c1fa..c84f9c9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2726,6 +2726,50 @@ static bool ahci_broken_suspend(struct pci_dev *pdev)
 	return !ver || strcmp(ver, dmi->driver_data) < 0;
 }
 
+static void ahci_gtf_filter_workaround(struct ata_host *host)
+{
+	static const struct dmi_system_id sysids[] = {
+		/*
+		 * Aspire 3810T issues a bunch of SATA enable commands
+		 * via _GTF including an invalid one and one which is
+		 * rejected by the device.  Among the successful ones
+		 * is FPDMA non-zero offset enable which when enabled
+		 * only on the drive side leads to NCQ command
+		 * failures.  Filter it out.
+		 */
+		{
+			.ident = "Aspire 3810T",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 3810T"),
+			},
+			.driver_data = (void *)ATA_ACPI_FILTER_FPDMA_OFFSET,
+		},
+		{ }
+	};
+	const struct dmi_system_id *dmi = dmi_first_match(sysids);
+	unsigned int filter;
+	int i;
+
+	if (!dmi)
+		return;
+
+	filter = (unsigned long)dmi->driver_data;
+	dev_printk(KERN_INFO, host->dev,
+		   "applying extra ACPI _GTF filter 0x%x for %s\n",
+		   filter, dmi->ident);
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		struct ata_link *link;
+		struct ata_device *dev;
+
+		ata_for_each_link(link, ap, EDGE)
+			ata_for_each_dev(dev, link, ALL)
+				dev->gtf_filter |= filter;
+	}
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
@@ -2885,6 +2929,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* apply workaround for ASUS P5W DH Deluxe mainboard */
 	ahci_p5wdh_workaround(host);
 
+	/* apply gtf filter quirk */
+	ahci_gtf_filter_workaround(host);
+
 	/* initialize adapter */
 	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
 	if (rc)
-- 
1.6.0.2

