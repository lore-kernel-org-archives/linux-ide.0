From: Matthew Garrett <mjg59@coreos.com>
Subject: [PATCH] libata: Add an additional LPM policy to match Intel recommendations
Date: Fri, 10 Apr 2015 13:15:29 -0700
Message-ID: <1428696929-2988-1-git-send-email-mjg59@coreos.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52759 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbbDJUPu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Apr 2015 16:15:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@coreos.com>

Intel publish a document on designing energy efficient SATA devices at
http://www.intel.com/content/dam/doc/reference-guide/sata-devices-implementation-recommendations.pdf
which recommends that ALPE be set, ASPE be cleared and that DIPM be enabled
on the device. Right now we have no policy that matches that - medium_power
does not enable DIPM and min_power sets ASPE. Add a new low_power policy to
implement these recommendations. I've left devslp disabled because I'm not
yet sure what Intel do in that case. With luck this will provide reasonable
power savings without causing the device breakages we occasionally see with
the min_power policy.

Signed-off-by: Matthew Garrett <mjg59@coreos.com>
---
 Documentation/scsi/link_power_management_policy.txt | 14 ++++++++------
 drivers/ata/libahci.c                               |  3 +--
 drivers/ata/libata-core.c                           |  1 +
 drivers/ata/libata-eh.c                             | 11 +++++++----
 drivers/ata/libata-scsi.c                           |  1 +
 include/linux/libata.h                              |  1 +
 6 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/scsi/link_power_management_policy.txt b/Documentation/scsi/link_power_management_policy.txt
index d18993d..e095e03 100644
--- a/Documentation/scsi/link_power_management_policy.txt
+++ b/Documentation/scsi/link_power_management_policy.txt
@@ -1,13 +1,8 @@
 This parameter allows the user to set the link (interface) power management.
-There are 3 possible options:
+There are 4 possible options:
 
 Value			Effect
 ----------------------------------------------------------------------------
-min_power		Tell the controller to try to make the link use the
-			least possible power when possible.  This may
-			sacrifice some performance due to increased latency
-			when coming out of lower power states.
-
 max_performance		Generally, this means no power management.  Tell
 			the controller to have performance be a priority
 			over power management.
@@ -16,4 +11,11 @@ medium_power		Tell the controller to enter a lower power state
 			when possible, but do not enter the lowest power
 			state, thus improving latency over min_power setting.
 
+low_power		Tell the controller to enter a lower power state
+			when possible, also enabling power management on
+			the target device.
 
+min_power		Tell the controller to try to make the link use the
+			least possible power when possible.  This may
+			sacrifice some performance due to increased latency
+			when coming out of lower power states.
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 61a9c07..5814bef 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -701,9 +701,9 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 
 	if (hpriv->cap & HOST_CAP_ALPM) {
 		u32 cmd = readl(port_mmio + PORT_CMD);
+		cmd &= ~(PORT_CMD_ASP | PORT_CMD_ALPE);
 
 		if (policy == ATA_LPM_MAX_POWER || !(hints & ATA_LPM_HIPM)) {
-			cmd &= ~(PORT_CMD_ASP | PORT_CMD_ALPE);
 			cmd |= PORT_CMD_ICC_ACTIVE;
 
 			writel(cmd, port_mmio + PORT_CMD);
@@ -720,7 +720,6 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			writel(cmd, port_mmio + PORT_CMD);
 		}
 	}
-
 	/* set aggressive device sleep */
 	if ((hpriv->cap2 & HOST_CAP2_SDS) &&
 	    (hpriv->cap2 & HOST_CAP2_SADM) &&
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 23dac3b..39e03d5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3662,6 +3662,7 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		scontrol &= ~(0x1 << 8);
 		scontrol |= (0x6 << 8);
 		break;
+	case ATA_LPM_LOW_POWER:
 	case ATA_LPM_MIN_POWER:
 		if (ata_link_nr_enabled(link) > 0)
 			/* no restrictions on LPM transitions */
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d2029a4..d4476fa 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3411,7 +3411,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		return 0;
 
 	/*
-	 * DIPM is enabled only for MIN_POWER as some devices
+	 * DIPM is enabled only for LOW_POWER and MIN_POWER as some devices
 	 * misbehave when the host NACKs transition to SLUMBER.  Order
 	 * device and link configurations such that the host always
 	 * allows DIPM requests.
@@ -3432,7 +3432,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			hints &= ~ATA_LPM_HIPM;
 
 		/* disable DIPM before changing link config */
-		if (policy != ATA_LPM_MIN_POWER && dipm) {
+		if (policy < ATA_LPM_LOW_POWER && dipm) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_DISABLE, SATA_DIPM);
 			if (err_mask && err_mask != AC_ERR_DEV) {
@@ -3473,9 +3473,12 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	if (ap && ap->slave_link)
 		ap->slave_link->lpm_policy = policy;
 
-	/* host config updated, enable DIPM if transitioning to MIN_POWER */
+	/*
+	 * host config updated, enable DIPM if transitioning to LOW_POWER or
+	 * MIN_POWER
+	 */
 	ata_for_each_dev(dev, link, ENABLED) {
-		if (policy == ATA_LPM_MIN_POWER && !no_dipm &&
+		if (policy >= ATA_LPM_LOW_POWER && !no_dipm &&
 		    ata_id_has_dipm(dev->id)) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_ENABLE, SATA_DIPM);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b061ba2..66c6946 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -108,6 +108,7 @@ static const char *ata_lpm_policy_names[] = {
 	[ATA_LPM_UNKNOWN]	= "max_performance",
 	[ATA_LPM_MAX_POWER]	= "max_performance",
 	[ATA_LPM_MED_POWER]	= "medium_power",
+	[ATA_LPM_LOW_POWER]	= "low_power",
 	[ATA_LPM_MIN_POWER]	= "min_power",
 };
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 6b08cc1..6cf823f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -509,6 +509,7 @@ enum ata_lpm_policy {
 	ATA_LPM_UNKNOWN,
 	ATA_LPM_MAX_POWER,
 	ATA_LPM_MED_POWER,
+	ATA_LPM_LOW_POWER,
 	ATA_LPM_MIN_POWER,
 };
 
-- 
2.3.4

