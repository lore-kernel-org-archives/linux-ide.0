From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/2] libata: add power_off policy for unoccupied ports
Date: Thu,  3 Mar 2011 10:21:17 -0800
Message-ID: <1299176478-2999-2-git-send-email-kristen@linux.intel.com>
References: <1299176478-2999-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32825 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758620Ab1CCSS5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Mar 2011 13:18:57 -0500
In-Reply-To: <1299176478-2999-1-git-send-email-kristen@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>


Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 drivers/ata/libata-core.c |    4 ++++
 drivers/ata/libata-eh.c   |    5 +++++
 drivers/ata/libata-scsi.c |    1 +
 include/linux/libata.h    |    1 +
 4 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d4e52e2..c795466 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3622,6 +3622,10 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		/* no restrictions on LPM transitions */
 		scontrol &= ~(0x3 << 8);
 		break;
+	case ATA_LPM_POWER_OFF:
+		scontrol &= ~0xf;
+		scontrol |= (0x1 << 2);
+		break;
 	default:
 		WARN_ON(1);
 	}
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 17a6378..cfac236 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3754,6 +3754,11 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	config_lpm:
 		/* configure link power saving */
 		if (link->lpm_policy != ap->target_lpm_policy) {
+			/* refuse to power off occupied port */
+			if (ap->target_lpm_policy == ATA_LPM_POWER_OFF &&
+					(ata_link_nr_enabled(link) > 0))
+				goto out;
+
 			rc = ata_eh_set_lpm(link, ap->target_lpm_policy, &dev);
 			if (rc)
 				goto rest_fail;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 600f635..70f1c66 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -108,6 +108,7 @@ static const char *ata_lpm_policy_names[] = {
 	[ATA_LPM_MAX_POWER]	= "max_performance",
 	[ATA_LPM_MED_POWER]	= "medium_power",
 	[ATA_LPM_MIN_POWER]	= "min_power",
+	[ATA_LPM_POWER_OFF]	= "power_off",
 };
 
 static ssize_t ata_scsi_lpm_store(struct device *dev,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c9c5d7a..1ad44dd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -473,6 +473,7 @@ enum ata_lpm_policy {
 	ATA_LPM_MAX_POWER,
 	ATA_LPM_MED_POWER,
 	ATA_LPM_MIN_POWER,
+	ATA_LPM_POWER_OFF,
 };
 
 enum ata_lpm_hints {
-- 
1.7.3.1

