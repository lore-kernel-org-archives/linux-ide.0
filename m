From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH v2 1/2] ata: ahci: Support state with min power and  Partial low power state
Date: Thu, 12 Jul 2018 15:27:11 -0700
Message-ID: <20180712222712.65310-2-srinivas.pandruvada@linux.intel.com>
References: <20180712222712.65310-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712222712.65310-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan.cox@intel.com, Mario.Limonciello@dell.com, rjw@rjwysocki.net, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-ide@vger.kernel.org

Currently when min_power policy is selected, the partial low power state
is not entered and link will try aggressively enter to only slumber state.
Add a new policy which still enable DEVSLP but also try to enter partial
low power state.

For information the difference between partial and slumber
Partial – PHY logic is powered up, and in a reduced power state. The link
PM exit latency to active state maximum is 10 ns.
Slumber – PHY logic is powered up, and in a reduced power state. The link
PM exit latency to active state maximum is 10 ms.
Devslp – PHY logic is powered down. The link PM exit latency from this
state to active state maximum is 20 ms, unless otherwise specified by
DETO.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/ata/libahci.c     | 6 +++++-
 drivers/ata/libata-core.c | 1 +
 drivers/ata/libata-scsi.c | 1 +
 include/linux/libata.h    | 3 ++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 511fb67f363d..8cf2cf49537d 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -799,8 +799,11 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 				return 0;
 		} else {
 			cmd |= PORT_CMD_ALPE;
+
 			if (policy == ATA_LPM_MIN_POWER)
 				cmd |= PORT_CMD_ASP;
+			else if (policy == ATA_LPM_MIN_POWER_WITH_ASP)
+				cmd &= ~PORT_CMD_ASP;
 
 			/* write out new cmd value */
 			writel(cmd, port_mmio + PORT_CMD);
@@ -811,7 +814,8 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	if ((hpriv->cap2 & HOST_CAP2_SDS) &&
 	    (hpriv->cap2 & HOST_CAP2_SADM) &&
 	    (link->device->flags & ATA_DFLAG_DEVSLP)) {
-		if (policy == ATA_LPM_MIN_POWER)
+		if (policy == ATA_LPM_MIN_POWER ||
+		    policy == ATA_LPM_MIN_POWER_WITH_ASP)
 			ahci_set_aggressive_devslp(ap, true);
 		else
 			ahci_set_aggressive_devslp(ap, false);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cc71c63df381..245a59e6cb18 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3970,6 +3970,7 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		scontrol |= (0x6 << 8);
 		break;
 	case ATA_LPM_MED_POWER_WITH_DIPM:
+	case ATA_LPM_MIN_POWER_WITH_ASP:
 	case ATA_LPM_MIN_POWER:
 		if (ata_link_nr_enabled(link) > 0)
 			/* no restrictions on LPM transitions */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index aad1b01447de..2d683db50ceb 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -110,6 +110,7 @@ static const char *ata_lpm_policy_names[] = {
 	[ATA_LPM_MAX_POWER]		= "max_performance",
 	[ATA_LPM_MED_POWER]		= "medium_power",
 	[ATA_LPM_MED_POWER_WITH_DIPM]	= "med_power_with_dipm",
+	[ATA_LPM_MIN_POWER_WITH_ASP]	= "min_power_with_asp",
 	[ATA_LPM_MIN_POWER]		= "min_power",
 };
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 32f247cb5e9e..1e154f1f7e8f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -523,7 +523,8 @@ enum ata_lpm_policy {
 	ATA_LPM_MAX_POWER,
 	ATA_LPM_MED_POWER,
 	ATA_LPM_MED_POWER_WITH_DIPM, /* Med power + DIPM as win IRST does */
-	ATA_LPM_MIN_POWER,
+	ATA_LPM_MIN_POWER_WITH_ASP, /* Min Power + partial and slumber */
+	ATA_LPM_MIN_POWER, /* Min power + no partial (slumber only) */
 };
 
 enum ata_lpm_hints {
-- 
2.17.1
