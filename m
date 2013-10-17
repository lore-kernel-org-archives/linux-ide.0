From: <gregkh@linuxfoundation.org>
Subject: patch "ide: convert bus code to use dev_groups" added to driver-core tree
Date: Wed, 16 Oct 2013 18:41:18 -0700
Message-ID: <13819740783467@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38677 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760887Ab3JQBlT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Oct 2013 21:41:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: gregkh@linuxfoundation.org, davem@davemloft.net, linux-ide@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    ide: convert bus code to use dev_groups

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


>From fb3fed7926545e44ce36574e1b1c5cdeb018db5c Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 7 Oct 2013 18:27:35 -0700
Subject: ide: convert bus code to use dev_groups

The dev_attrs field of struct bus_type is going away soon, dev_groups
should be used instead.  This converts the ide bus code to use the
correct field.

Acked-by: David S. Miller <davem@davemloft.net>
Cc: <linux-ide@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ide/ide-sysfs.c | 35 ++++++++++++++++++++++++++---------
 drivers/ide/ide.c       |  2 +-
 include/linux/ide.h     |  2 +-
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/ide/ide-sysfs.c b/drivers/ide/ide-sysfs.c
index 883ffaca..84a6a9e0 100644
--- a/drivers/ide/ide-sysfs.c
+++ b/drivers/ide/ide-sysfs.c
@@ -25,6 +25,7 @@ static ssize_t media_show(struct device *dev, struct device_attribute *attr,
 	ide_drive_t *drive = to_ide_device(dev);
 	return sprintf(buf, "%s\n", ide_media_string(drive));
 }
+static DEVICE_ATTR_RO(media);
 
 static ssize_t drivename_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
@@ -32,6 +33,7 @@ static ssize_t drivename_show(struct device *dev, struct device_attribute *attr,
 	ide_drive_t *drive = to_ide_device(dev);
 	return sprintf(buf, "%s\n", drive->name);
 }
+static DEVICE_ATTR_RO(drivename);
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -39,6 +41,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 	ide_drive_t *drive = to_ide_device(dev);
 	return sprintf(buf, "ide:m-%s\n", ide_media_string(drive));
 }
+static DEVICE_ATTR_RO(modalias);
 
 static ssize_t model_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
@@ -46,6 +49,7 @@ static ssize_t model_show(struct device *dev, struct device_attribute *attr,
 	ide_drive_t *drive = to_ide_device(dev);
 	return sprintf(buf, "%s\n", (char *)&drive->id[ATA_ID_PROD]);
 }
+static DEVICE_ATTR_RO(model);
 
 static ssize_t firmware_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -53,6 +57,7 @@ static ssize_t firmware_show(struct device *dev, struct device_attribute *attr,
 	ide_drive_t *drive = to_ide_device(dev);
 	return sprintf(buf, "%s\n", (char *)&drive->id[ATA_ID_FW_REV]);
 }
+static DEVICE_ATTR_RO(firmware);
 
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
@@ -60,16 +65,28 @@ static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 	ide_drive_t *drive = to_ide_device(dev);
 	return sprintf(buf, "%s\n", (char *)&drive->id[ATA_ID_SERNO]);
 }
+static DEVICE_ATTR(serial, 0400, serial_show, NULL);
+
+static DEVICE_ATTR(unload_heads, 0644, ide_park_show, ide_park_store);
+
+static struct attribute *ide_attrs[] = {
+	&dev_attr_media.attr,
+	&dev_attr_drivename.attr,
+	&dev_attr_modalias.attr,
+	&dev_attr_model.attr,
+	&dev_attr_firmware.attr,
+	&dev_attr_serial.attr,
+	&dev_attr_unload_heads.attr,
+	NULL,
+};
+
+static const struct attribute_group ide_attr_group = {
+	.attrs = ide_attrs,
+};
 
-struct device_attribute ide_dev_attrs[] = {
-	__ATTR_RO(media),
-	__ATTR_RO(drivename),
-	__ATTR_RO(modalias),
-	__ATTR_RO(model),
-	__ATTR_RO(firmware),
-	__ATTR(serial, 0400, serial_show, NULL),
-	__ATTR(unload_heads, 0644, ide_park_show, ide_park_store),
-	__ATTR_NULL
+const struct attribute_group *ide_dev_groups[] = {
+	&ide_attr_group,
+	NULL,
 };
 
 static ssize_t store_delete_devices(struct device *portdev,
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
index fa896210..2ce6268a 100644
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -158,7 +158,7 @@ struct bus_type ide_bus_type = {
 	.probe		= generic_ide_probe,
 	.remove		= generic_ide_remove,
 	.shutdown	= generic_ide_shutdown,
-	.dev_attrs	= ide_dev_attrs,
+	.dev_groups	= ide_dev_groups,
 	.suspend	= generic_ide_suspend,
 	.resume		= generic_ide_resume,
 };
diff --git a/include/linux/ide.h b/include/linux/ide.h
index b1797491..46a14229 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1514,7 +1514,7 @@ static inline void ide_set_max_pio(ide_drive_t *drive)
 
 char *ide_media_string(ide_drive_t *);
 
-extern struct device_attribute ide_dev_attrs[];
+extern const struct attribute_group *ide_dev_groups[];
 extern struct bus_type ide_bus_type;
 extern struct class *ide_port_class;
 
-- 
1.8.4.3.gca3854a


