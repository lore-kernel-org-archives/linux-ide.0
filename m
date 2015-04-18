From: Matthew Garrett <mjg59@coreos.com>
Subject: [PATCH 3/3] libata: Change medium_power LPM policy to match Intel recommendations
Date: Sat, 18 Apr 2015 08:26:36 -0700
Message-ID: <1429370796-5881-4-git-send-email-mjg59@coreos.com>
References: <1429370796-5881-1-git-send-email-mjg59@coreos.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:37142 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbbDRP10 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Apr 2015 11:27:26 -0400
In-Reply-To: <1429370796-5881-1-git-send-email-mjg59@coreos.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kristen@linux.intel.com, Matthew Garrett <mjg59@coreos.com>

Intel publish a document on designing energy efficient SATA devices at
http://www.intel.com/content/dam/doc/reference-guide/sata-devices-implementation-recommendations.pdf
which recommends that ALPE be set, ASPE be cleared and that DIPM be enabled
on the device. Right now we have no policy that matches that - medium_power
does not enable DIPM and min_power sets ASPE. Change medium_power to
implement these recommendations, with the addition of devslp state being
inherited from the initial configuration. With luck this will provide
reasonable power savings without causing the device breakages we
occasionally see with the min_power policy.

Signed-off-by: Matthew Garrett <mjg59@coreos.com>
---
 drivers/ata/libahci.c     |  1 +
 drivers/ata/libata-core.c |  4 ----
 drivers/ata/libata-eh.c   | 10 ++++------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index fabcff4..8efacb9 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -738,6 +738,7 @@ static int ahci_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			ahci_set_aggressive_devslp(ap, true);
 			break;
 		case ATA_LPM_FIRMWARE_DEFAULTS:
+		case ATA_LPM_MED_POWER:
 			ahci_set_aggressive_devslp(ap, ppriv->init_devslp);
 			break;
 		default:
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0a78f01..99a7b8f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3687,10 +3687,6 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		}
 		break;
 	case ATA_LPM_MED_POWER:
-		/* allow LPM to PARTIAL */
-		scontrol &= ~(0x1 << 8);
-		scontrol |= (0x6 << 8);
-		break;
 	case ATA_LPM_MIN_POWER:
 		if (ata_link_nr_enabled(link) > 0)
 			/* no restrictions on LPM transitions */
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index c36fa56..25d5f37 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3519,8 +3519,6 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		return 0;
 
 	/*
-	 * DIPM is enabled only for MIN_POWER and FIRMWARE_DEFAULT as some
-	 * devices misbehave when the host NACKs transition to SLUMBER.
 	 * Order device and link configurations such that the host always
 	 * allows DIPM requests.
 	 */
@@ -3540,7 +3538,7 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			hints &= ~ATA_LPM_HIPM;
 
 		/* disable DIPM before changing link config */
-		if (policy != ATA_LPM_MIN_POWER && dipm) {
+		if (policy < ATA_LPM_MED_POWER && dipm) {
 			err_mask = ata_dev_set_feature(dev,
 					SETFEATURES_SATA_DISABLE, SATA_DIPM);
 			if (err_mask && err_mask != AC_ERR_DEV) {
@@ -3581,11 +3579,11 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	if (ap && ap->slave_link)
 		ap->slave_link->lpm_policy = policy;
 
-	/* host config updated, enable DIPM if transitioning to MIN_POWER or
-	 * FIRMWARE_DEFAULT when enabled by firmware
+	/* host config updated, enable DIPM if transitioning to MED_POWER,
+	 * MIN_POWER or FIRMWARE_DEFAULT when enabled by firmware
 	 */
 	ata_for_each_dev(dev, link, ENABLED) {
-		if ((policy == ATA_LPM_MIN_POWER && !no_dipm &&
+		if ((policy >= ATA_LPM_MED_POWER && !no_dipm &&
 		     ata_id_has_dipm(dev->id)) ||
 		    (policy == ATA_LPM_FIRMWARE_DEFAULTS && dev->init_dipm)) {
 			err_mask = ata_dev_set_feature(dev,
-- 
2.3.5

