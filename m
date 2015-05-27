From: Robert Richter <rric@kernel.org>
Subject: [PATCH v3 3/3] AHCI: Add generic MSI-X interrupt support to SATA PCI driver
Date: Wed, 27 May 2015 10:01:33 +0200
Message-ID: <1432713693-4282-4-git-send-email-rric@kernel.org>
References: <1432713693-4282-1-git-send-email-rric@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432713693-4282-1-git-send-email-rric@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Sunil Goutham <sgoutham@cavium.com>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Robert Richter <rrichter@cavium.com>
List-Id: linux-ide@vger.kernel.org

From: Robert Richter <rrichter@cavium.com>

This patch adds generic support for MSI-X interrupts to the SATA PCI
driver. MSI-X support is needed for host controller that only have
MSI-X support implemented, such as the controller on Cavium's ThunderX
SoC. Only support for single interrupts is added, multiple per-port
MSI-X interrupts are not yet implemented.

The new implementation still initializes MSIs first. Only if that
fails, the code tries to enable MSI-X. If that fails too, setup is
continued with intx interrupts.

To not break other chips by this generic code change, there are the
following precautions:

 * Interrupt ranges are not enabled at all.

 * Only single interrupt mode is enabled for msix cap devices. These
   devices require a single port only or a total number of int entries
   less than the total number of ports. In this case only one
   interrupt will be enabled.

 * During the discussion with Tejun we agreed to change the init
   sequence from msix-msi-intx to msi-msix-intx. Thus, if a device
   offers msi and init does not fail, the msix init code will not be
   executed. This is equivalent to current code.

With this, the code only setups single mode msix as a last resort if
msi fails. No interrupt range is enabled at all. Only one interrupt
will be enabled.

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
 drivers/ata/ahci.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8cdc9ebbbc43..8245f75be6b6 100644
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
@@ -52,6 +53,7 @@
 
 enum {
 	AHCI_PCI_BAR_STA2X11	= 0,
+	AHCI_PCI_BAR_CAVIUM	= 0,
 	AHCI_PCI_BAR_ENMOTUS	= 2,
 	AHCI_PCI_BAR_STANDARD	= 5,
 };
@@ -499,6 +501,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Enmotus */
 	{ PCI_DEVICE(0x1c44, 0x8000), board_ahci },
 
+	/* Cavium */
+	{ PCI_DEVICE(0x177d, 0xa01c), .driver_data = board_ahci },
+
 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },
@@ -1201,6 +1206,80 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
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
+	 * Per-port msix interrupts are not supported. Assume single
+	 * port interrupts for:
+	 *
+	 *  n_ports == 1, or
+	 *  nvec < n_ports.
+	 *
+	 * We also need to check for n_ports != 0 which is implicitly
+	 * covered here since nvec > 0.
+	 */
+	if (n_ports != 1 && nvec >= n_ports) {
+		rc = -ENOSYS;
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
@@ -1269,6 +1348,10 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 	if (nvec >= 0)
 		return nvec;
 
+	nvec = ahci_init_msix(pdev, n_ports, hpriv);
+	if (nvec >= 0)
+		return nvec;
+
 	return ahci_init_intx(pdev, n_ports, hpriv);
 }
 
@@ -1307,11 +1390,13 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_info(&pdev->dev,
 			 "PDC42819 can only drive SATA devices with this driver\n");
 
-	/* Both Connext and Enmotus devices use non-standard BARs */
+	/* Some devices use non-standard BARs */
 	if (pdev->vendor == PCI_VENDOR_ID_STMICRO && pdev->device == 0xCC06)
 		ahci_pci_bar = AHCI_PCI_BAR_STA2X11;
 	else if (pdev->vendor == 0x1c44 && pdev->device == 0x8000)
 		ahci_pci_bar = AHCI_PCI_BAR_ENMOTUS;
+	else if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
+		ahci_pci_bar = AHCI_PCI_BAR_CAVIUM;
 
 	/*
 	 * The JMicron chip 361/363 contains one SATA controller and one
-- 
2.1.1
