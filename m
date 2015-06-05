From: Robert Richter <rric@kernel.org>
Subject: [PATCH v5 1/2] ahci: Add generic MSI-X support for single interrupts to SATA PCI driver
Date: Fri,  5 Jun 2015 19:49:25 +0200
Message-ID: <1433526566-21136-2-git-send-email-rric@kernel.org>
References: <1433526566-21136-1-git-send-email-rric@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38889 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbbFERte (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Jun 2015 13:49:34 -0400
In-Reply-To: <1433526566-21136-1-git-send-email-rric@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Richter <rrichter@cavium.com>

From: Robert Richter <rrichter@cavium.com>

This patch adds generic MSI-X support for single interrupts to the
SATA PCI driver. MSI-X support is needed for host controller that only
have MSI-X support implemented, but no MSI or intx. This patch only
adds support for single interrupts, multiple per-port MSI-X interrupts
are not yet implemented.

The new implementation still initializes MSIs first. Only if that
fails, the code tries to enable MSI-X. If that fails too, setup is
continued with intx interrupts.

To not break other chips by this generic code change, there are the
following precautions:

 * Interrupt ranges are not enabled at all.

 * Only single interrupt mode is enabled for msix cap devices. Thus,
   only one interrupt will be setup.

 * During the discussion with Tejun we agreed to change the init
   sequence from msix-msi-intx to msi-msix-intx. Thus, if a device
   offers msi and init does not fail, the msix init code will not be
   executed. This is equivalent to current code.

With this, the code only setups single mode msix as a last resort if
msi fails. No interrupt range is enabled at all. Only one interrupt
will be enabled.

Changes of the patch series:

v5:
 * updated patch subject that the patch only implements single IRQ
 * moved Cavium specific code to a separate patch
 * detect Cavium ThunderX device with PCI_CLASS_STORAGE_SATA_AHCI
   instead of vendor/dev id
 * added more comments to the code
 * enable single msix support for all kind of devices (removing strict
   check)
 * rebased onto update libata/for-4.2 with patch 1, 2 applied

v4:
 * removed implementation of ahci_init_intx()
 * improved patch descriptions
 * rebased onto libata/for-4.2

v3:
 * store irq number in struct ahci_host_priv
 * change initialization order from msix-msi-intx to msi-msix-intx
 * improve comments in ahci_init_msix()
 * improve error message in ahci_init_msix()
 * do not enable MSI-X if MSI is actively disabled for the device

v2:
 * determine irq vector from pci_dev->msi_list

Based on a patch from Sunil Goutham <sgoutham@cavium.com>.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/ata/ahci.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a3c66c3bb76e..f300aa583678 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -42,6 +42,7 @@
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/gfp.h>
+#include <linux/msi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
@@ -1201,6 +1202,71 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
 {}
 #endif
 
+static struct msi_desc *msix_get_desc(struct pci_dev *dev, u16 entry)
+{
+	struct msi_desc *desc;
+
+	list_for_each_entry(desc, &dev->msi_list, list) {
+		if (desc->msi_attrib.entry_nr == entry)
+			return desc;
+	}
+
+	return NULL;
+}
+
+/*
+ * MSI-X support is needed for host controller that only have MSI-X
+ * support implemented, but no MSI or intx. For now, function
+ * ahci_init_msix() only implements single MSI-X support, but not
+ * multiple MSI-X per-port interrupts.
+ */
+static int ahci_init_msix(struct pci_dev *pdev, unsigned int n_ports,
+			  struct ahci_host_priv *hpriv)
+{
+	struct msi_desc *desc;
+	int rc, nvec;
+	struct msix_entry entry = {};
+
+	/* Do not init MSI-X if MSI is disabled for the device */
+	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
+		return -ENODEV;
+
+	nvec = pci_msix_vec_count(pdev);
+	if (nvec < 0)
+		return nvec;
+
+	if (!nvec) {
+		rc = -ENODEV;
+		goto fail;
+	}
+
+	/*
+	 * There can exist more than one vector (e.g. for error
+	 * detection or hdd hotplug). Then the first vector is used,
+	 * all others are ignored. Only enable the first entry here
+	 * (entry.entry = 0).
+	 */
+	rc = pci_enable_msix_exact(pdev, &entry, 1);
+	if (rc < 0)
+		goto fail;
+
+	desc = msix_get_desc(pdev, 0);	/* first entry */
+	if (!desc) {
+		rc = -EINVAL;
+		goto fail;
+	}
+
+	hpriv->irq = desc->irq;
+
+	return 1;
+fail:
+	dev_err(&pdev->dev,
+		"failed to enable MSI-X with error %d, # of vectors: %d\n",
+		rc, nvec);
+
+	return rc;
+}
+
 static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 			struct ahci_host_priv *hpriv)
 {
@@ -1260,6 +1326,17 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 	if (nvec >= 0)
 		return nvec;
 
+	/*
+	 * Only setup single mode MSI-X as a last resort if MSI fails:
+	 * Initialize MSI-X after MSI and only if that fails, continue
+	 * with intx interrupts on failure. Thus, MSI-X code is not
+	 * executed if a device offers MSI and its initialization does
+	 * not fail.
+	 */
+	nvec = ahci_init_msix(pdev, n_ports, hpriv);
+	if (nvec >= 0)
+		return nvec;
+
 	/* lagacy intx interrupts */
 	pci_intx(pdev, 1);
 	hpriv->irq = pdev->irq;
-- 
2.1.1

