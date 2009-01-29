From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 8/8] libata: implement HORKAGE_1_5_GBPS and apply it to WD My Book
Date: Thu, 29 Jan 2009 20:31:36 +0900
Message-ID: <1233228696-10562-9-git-send-email-tj@kernel.org>
References: <1233228696-10562-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34097 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553AbZA2LcB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jan 2009 06:32:01 -0500
In-Reply-To: <1233228696-10562-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

3Gbps is often much more prone to transmission failures.  It's usually
okay to let EH handle speed down after transmission failures but some
WD My Book drives completely shutdown after certain transmission
failures and after it only power cycling can revive them.  Combined
with the fact that external drives often end up with cable assembly
which is longer than usual and more likely to have intervening gender,
this makes these drives very likely to shutdown under certain
configurations virtually rendering them unusable.

This patch implements HOARKGE_1_5_GBPS and applies it to WD My Book
such that 1.5Gbps is forced once the device is identified.

Please take a look at the following bz for related reports.

  http://bugzilla.kernel.org/show_bug.cgi?id=9913

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |   41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |    1 +
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0cc0d8f..4394861 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2232,6 +2232,40 @@ retry:
 	return rc;
 }
 
+static int ata_do_link_spd_horkage(struct ata_device *dev)
+{
+	struct ata_link *plink = ata_dev_phys_link(dev);
+	u32 target, target_limit;
+
+	if (!sata_scr_valid(plink))
+		return 0;
+
+	if (dev->horkage & ATA_HORKAGE_1_5_GBPS)
+		target = 1;
+	else
+		return 0;
+
+	target_limit = (1 << target) - 1;
+
+	/* if already on stricter limit, no need to push further */
+	if (plink->sata_spd_limit <= target_limit)
+		return 0;
+
+	plink->sata_spd_limit = target_limit;
+
+	/* Request another EH round by returning -EAGAIN if link is
+	 * going faster than the target speed.  Forward progress is
+	 * guaranteed by setting sata_spd_limit to target_limit above.
+	 */
+	if (plink->sata_spd > target) {
+		ata_dev_printk(dev, KERN_INFO,
+			       "applying link speed limit horkage to %s\n",
+			       sata_spd_string(target));
+		return -EAGAIN;
+	}
+	return 0;
+}
+
 static inline u8 ata_dev_knobble(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
@@ -2322,6 +2356,10 @@ int ata_dev_configure(struct ata_device *dev)
 		return 0;
 	}
 
+	rc = ata_do_link_spd_horkage(dev);
+	if (rc)
+		return rc;
+
 	/* let ACPI work its magic */
 	rc = ata_acpi_on_devcfg(dev);
 	if (rc)
@@ -4221,6 +4259,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	/* Devices that do not need bridging limits applied */
 	{ "MTRON MSP-SATA*",		NULL,	ATA_HORKAGE_BRIDGE_OK, },
 
+	/* Devices which aren't very happy with higher link speeds */
+	{ "WD My Book",			NULL,	ATA_HORKAGE_1_5_GBPS, },
+
 	/* End Marker */
 	{ }
 };
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7d7bc11..31ce91d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -378,6 +378,7 @@ enum {
 	ATA_HORKAGE_ATAPI_MOD16_DMA = (1 << 11), /* use ATAPI DMA for commands
 						    not multiple of 16 bytes */
 	ATA_HORKAGE_FIRMWARE_WARN = (1 << 12),	/* firwmare update warning */
+	ATA_HORKAGE_1_5_GBPS	= (1 << 13),	/* force 1.5 Gbps */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
1.6.0.2

