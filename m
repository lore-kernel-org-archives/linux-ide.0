From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] libata: Power off empty ports
Date: Fri,  4 Mar 2011 10:24:11 -0800
Message-ID: <1299263051-3739-1-git-send-email-kristen@linux.intel.com>
References: <20110304090644.GC20499@htj.dyndns.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18736 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095Ab1CDSWD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Mar 2011 13:22:03 -0500
In-Reply-To: <20110304090644.GC20499@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>

Give users the option of completely powering off unoccupied
SATA ports using the existing min_power link_power_management_policy
option.  When the use selects this option on an empty port, we
will power the port off by setting DET to off.  For occupied ports,
behavior is unchanged.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 drivers/ata/libata-core.c |   10 ++++++++--
 drivers/ata/libata-eh.c   |    2 +-
 include/linux/libata.h    |    1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d4e52e2..a650bef 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3619,8 +3619,14 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		scontrol |= (0x2 << 8);
 		break;
 	case ATA_LPM_MIN_POWER:
-		/* no restrictions on LPM transitions */
-		scontrol &= ~(0x3 << 8);
+		if (ata_link_nr_enabled(link) > 0)
+			/* no restrictions on LPM transitions */
+			scontrol &= ~(0x3 << 8);
+		else {
+			/* empty port, power off */
+			scontrol &= ~0xf;
+			scontrol |= (0x1 << 2);
+		}
 		break;
 	default:
 		WARN_ON(1);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 17a6378..f0a31b7 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3381,7 +3381,7 @@ fail:
 	return rc;
 }
 
-static int ata_link_nr_enabled(struct ata_link *link)
+int ata_link_nr_enabled(struct ata_link *link)
 {
 	struct ata_device *dev;
 	int cnt = 0;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c9c5d7a..8e78052 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1155,6 +1155,7 @@ extern void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 		      ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 		      ata_postreset_fn_t postreset);
 extern void ata_std_error_handler(struct ata_port *ap);
+extern int ata_link_nr_enabled(struct ata_link *link);
 
 /*
  * Base operations to inherit from and initializers for sht
-- 
1.7.3.1

