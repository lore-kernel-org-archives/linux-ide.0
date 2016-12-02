From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] ahci: warn about remapped NVMe devices
Date: Fri,  2 Dec 2016 19:31:03 +0100
Message-ID: <1480703463-17489-4-git-send-email-hch@lst.de>
References: <1480703463-17489-1-git-send-email-hch@lst.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:35191 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755170AbcLBSbV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 2 Dec 2016 13:31:21 -0500
In-Reply-To: <1480703463-17489-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: dan.j.williams@intel.com, linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org

Some Intel ahci implementations have a completely broken remapping mode
where they hide one or more NVMe devices behind the bar of an AHCI device.

Intel refuses to let the OS reprogram the BIOS to switch out of this
mode at runtime, and so far we're not come up with another good way
to undo the mess that the Chipset people created.  So for now the only
thing we can do is to alert users about this situation and switch to the
faster and much saner so called "AHCI" mode insted of the RAID mode in
the BIOS so that the BIOS does not hide the NVMe devices from us.

The sitation is even worse as at least one vendor (thanks a lot Lenovo..)
has started hardcoding their BIOS into the "RAID" mode even for laptops
that don't use AHCI _at all_ and just have a single NVMe device.  For now
there is an unspported Linux-only BIOS that undoes this braindamage,
but we'll have to see if things are getting better or worse from here.

Based on an earlier patch from Dan Williams <dan.j.williams@intel.com>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/ahci.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ba5f11c..516a689 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -46,6 +46,8 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
+#include <linux/ahci-remap.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include "ahci.h"
 
 #define DRV_NAME	"ahci"
@@ -1400,6 +1402,40 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 }
 #endif
 
+static void ahci_remap_check(struct pci_dev *pdev, int bar,
+		struct ahci_host_priv *hpriv)
+{
+	int i, count = 0;
+	u32 cap;
+
+	/*
+	 * Check if this device might have remapped nvme devices.
+	 */
+	if (pdev->vendor != PCI_VENDOR_ID_INTEL ||
+	    pci_resource_len(pdev, bar) < SZ_512K ||
+	    bar != AHCI_PCI_BAR_STANDARD ||
+	    !(readl(hpriv->mmio + AHCI_VSCAP) & 1))
+		return;
+
+	cap = readq(hpriv->mmio + AHCI_REMAP_CAP);
+	for (i = 0; i < AHCI_MAX_REMAP; i++) {
+		if ((cap & (1 << i)) == 0)
+			continue;
+		if (readl(hpriv->mmio + ahci_remap_dcc(i))
+				!= PCI_CLASS_STORAGE_EXPRESS)
+			continue;
+
+		/* We've found a remapped device */
+		count++;
+	}
+
+	if (!count)
+		return;
+
+	dev_warn(&pdev->dev, "Found %d remapped NVMe devices.\n", count);
+	dev_warn(&pdev->dev, "Switch your BIOS from RAID to AHCI mode to use them.\n");
+}
+
 static int ahci_get_irq_vector(struct ata_host *host, int port)
 {
 	return pci_irq_vector(to_pci_dev(host->dev), port);
@@ -1545,6 +1581,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
 
+	/* detect remapped nvme devices */
+	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
+
 	/* must set flag prior to save config in order to take effect */
 	if (ahci_broken_devslp(pdev))
 		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
-- 
2.1.4

