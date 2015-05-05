From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 2/4] libata: Expose TRIM capability in sysfs
Date: Mon,  4 May 2015 21:54:19 -0400
Message-ID: <1430790861-30066-2-git-send-email-martin.petersen@oracle.com>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:48433 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932726AbbEEByf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 21:54:35 -0400
In-Reply-To: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: hare@suse.de, linux-ide@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>

Create a sysfs "trim" attribute for each ata_device that displays
whether DSM TRIM is "unsupported", "unqueued", "forced_unqueued"
(blacklisted) or "queued".

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 Documentation/ABI/testing/sysfs-ata | 11 +++++++++++
 drivers/ata/libata-transport.c      | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-ata b/Documentation/ABI/testing/sysfs-ata
index 0a932155cbba..9231daef3813 100644
--- a/Documentation/ABI/testing/sysfs-ata
+++ b/Documentation/ABI/testing/sysfs-ata
@@ -90,6 +90,17 @@ gscr
 	130:	SATA_PMP_GSCR_SII_GPIO
 	Only valid if the device is a PM.
 
+trim
+
+	Shows the DSM TRIM mode currently used by the device. Valid
+	values are:
+	unsupported:		Drive does not support DSM TRIM
+	unqueued:		Drive supports unqueued DSM TRIM only
+	queued:			Drive supports queued DSM TRIM
+	forced_unqueued:	Drive's unqueued DSM support is known to be
+				buggy and only unqueued TRIM commands
+				are sent
+
 spdn_cnt
 
 	Number of time libata decided to lower the speed of link due to errors.
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 3227b7c8a05f..d6c37bcd416d 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -560,6 +560,27 @@ show_ata_dev_gscr(struct device *dev,
 
 static DEVICE_ATTR(gscr, S_IRUGO, show_ata_dev_gscr, NULL);
 
+static ssize_t
+show_ata_dev_trim(struct device *dev,
+		  struct device_attribute *attr, char *buf)
+{
+	struct ata_device *ata_dev = transport_class_to_dev(dev);
+	unsigned char *mode;
+
+	if (!ata_id_has_trim(ata_dev->id))
+		mode = "unsupported";
+	else if (ata_dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM)
+			mode = "forced_unqueued";
+	else if (ata_fpdma_dsm_supported(ata_dev))
+		mode = "queued";
+	else
+		mode = "unqueued";
+
+	return snprintf(buf, 20, "%s\n", mode);
+}
+
+static DEVICE_ATTR(trim, S_IRUGO, show_ata_dev_trim, NULL);
+
 static DECLARE_TRANSPORT_CLASS(ata_dev_class,
 			       "ata_device", NULL, NULL, NULL);
 
@@ -733,6 +754,7 @@ struct scsi_transport_template *ata_attach_transport(void)
 	SETUP_DEV_ATTRIBUTE(ering);
 	SETUP_DEV_ATTRIBUTE(id);
 	SETUP_DEV_ATTRIBUTE(gscr);
+	SETUP_DEV_ATTRIBUTE(trim);
 	BUG_ON(count > ATA_DEV_ATTRS);
 	i->dev_attrs[count] = NULL;
 
-- 
1.9.3

