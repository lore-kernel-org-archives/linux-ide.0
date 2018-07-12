From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH v2 2/2] ata: ahci: Enable DEVSLP by default on x86 with SLP_S0
Date: Thu, 12 Jul 2018 15:27:12 -0700
Message-ID: <20180712222712.65310-3-srinivas.pandruvada@linux.intel.com>
References: <20180712222712.65310-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712222712.65310-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan.cox@intel.com, Mario.Limonciello@dell.com, rjw@rjwysocki.net, Srinivas <srinivas.pandruvada@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

From: Srinivas <srinivas.pandruvada@linux.intel.com>

One of the requirement for modern x86 system to enter lowest power mode
(SLP_S0) is SATA IP block to be off. This is true even during when
platform is suspended to idle and not only in opportunistic (runtime)
suspend.

Several of these system don't have traditional ACPI S3, so it is
important that they enter SLP_S0 state, to avoid draining battery even
during suspend. So it is important that out of the box Linux installation
reach this state.

SATA IP block doesn't get turned off till SATA is in DEVSLP mode. Here
user has to either use scsi-host sysfs or tools like powertop to set
the sata-host link_power_management_policy to min_power.

This change sets by default link power management policy to min_power
with partial (preferred) or slumber support on idle for some platforms.
To avoid regressions, the following conditions are used:
- The kernel config is already set to use med_power_with_dipm or deeper
- System is a SLP_S0 capable using ACPI low power idle flag
This combination will make sure that systems are fairly recent and
since getting shipped with SLP_S0 support, the DEVSLP function
is already validated.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/ata/ahci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index b2b9eba1d214..e8d425823f9b 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1604,6 +1604,19 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
 	return pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
 }
 
+static void ahci_update_mobile_policy(struct ahci_host_priv *hpriv)
+{
+#ifdef CONFIG_ACPI
+	if (mobile_lpm_policy > ATA_LPM_MED_POWER &&
+	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
+		if (hpriv->cap & HOST_CAP_PART)
+			mobile_lpm_policy = ATA_LPM_MIN_POWER_WITH_ASP;
+		else if (hpriv->cap & HOST_CAP_SSC)
+			mobile_lpm_policy = ATA_LPM_MIN_POWER;
+	}
+#endif
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1796,6 +1809,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (pi.flags & ATA_FLAG_EM)
 		ahci_reset_em(host);
 
+	ahci_update_mobile_policy(hpriv);
+
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
-- 
2.17.1
