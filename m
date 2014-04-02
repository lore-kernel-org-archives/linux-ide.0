From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 1/2] libata: Expose trim capability in sysfs
Date: Tue,  1 Apr 2014 20:42:36 -0400
Message-ID: <1396399357-28388-1-git-send-email-martin.petersen@oracle.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:32820 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbaDBAm7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2014 20:42:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>, Chris Samuel <chris@csamuel.org>, Marc MERLIN <marc@merlins.org>

From: "Martin K. Petersen" <martin.petersen@oracle.com>

Now that drives with support for queued trim are starting to appear, it
would be helpful to expose the chosen trim mode to userland. Create a
sysfs "trim" attribute for each ata_device that displays whether trim is
"unsupported", "unqueued" or "queued".

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Chris Samuel <chris@csamuel.org>
Cc: Marc MERLIN <marc@merlins.org>
---
 drivers/ata/libata-transport.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index e37413228228..a9a1a9055a3a 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -559,6 +559,37 @@ show_ata_dev_gscr(struct device *dev,
 
 static DEVICE_ATTR(gscr, S_IRUGO, show_ata_dev_gscr, NULL);
 
+enum {
+	ATA_TRIM_UNSUPPORTED = 0,
+	ATA_TRIM_UNQUEUED = 1,
+	ATA_TRIM_QUEUED = 2,
+};
+
+static const char *trim_mode[] = {
+	[ATA_TRIM_UNSUPPORTED] = "unsupported",
+	[ATA_TRIM_UNQUEUED] = "unqueued",
+	[ATA_TRIM_QUEUED] = "queued",
+};
+
+static ssize_t
+show_ata_dev_trim(struct device *dev,
+		  struct device_attribute *attr, char *buf)
+{
+	struct ata_device *ata_dev = transport_class_to_dev(dev);
+	unsigned int mode;
+
+	if (!ata_id_has_trim(ata_dev->id))
+		mode = ATA_TRIM_UNSUPPORTED;
+	else if (ata_fpdma_dsm_supported(ata_dev))
+		mode = ATA_TRIM_QUEUED;
+	else
+		mode = ATA_TRIM_UNQUEUED;
+
+	return snprintf(buf, 20, "%s\n", trim_mode[mode]);
+}
+
+static DEVICE_ATTR(trim, S_IRUGO, show_ata_dev_trim, NULL);
+
 static DECLARE_TRANSPORT_CLASS(ata_dev_class,
 			       "ata_device", NULL, NULL, NULL);
 
@@ -732,6 +763,7 @@ struct scsi_transport_template *ata_attach_transport(void)
 	SETUP_DEV_ATTRIBUTE(ering);
 	SETUP_DEV_ATTRIBUTE(id);
 	SETUP_DEV_ATTRIBUTE(gscr);
+	SETUP_DEV_ATTRIBUTE(trim);
 	BUG_ON(count > ATA_DEV_ATTRS);
 	i->dev_attrs[count] = NULL;
 
-- 
1.8.3.1

