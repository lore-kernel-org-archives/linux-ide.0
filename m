From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: [PATCH] Export ahci eSATA attribute
Date: Sat, 13 Nov 2010 00:23:27 -0500
Message-ID: <4CDE20CF.3010708@cfl.rr.com>
References: <4CDB63E7.1040106@cfl.rr.com> <4CDB79CA.6000606@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070707030407060505010909"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:55431 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab0KMFX3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Nov 2010 00:23:29 -0500
In-Reply-To: <4CDB79CA.6000606@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070707030407060505010909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

How about this one?

--------------070707030407060505010909
Content-Type: text/x-patch;
 name="0001-PATCH-Export-ahci-eSATA-attribute.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-PATCH-Export-ahci-eSATA-attribute.patch"

>From d5636730ab4fa52d64c7e530518bf25c68a590de Mon Sep 17 00:00:00 2001
From: Phillip Susi <psusi@faldara.(none)>
Date: Sat, 13 Nov 2010 00:20:53 -0500
Subject: [PATCH] [PATCH] Export ahci eSATA attribute

The AHCI standard defines a port bit that indicates that port
is an eSATA external port.  Detect and export this bit as a
sysfs attribute named ahci_port_external.  It is intended that
this information be used by udisks to auto mount external eSATA
drives when they are hot plugged.
---
 drivers/ata/ahci.h    |    1 +
 drivers/ata/libahci.c |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 329cbbb..421c523 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -172,6 +172,7 @@ enum {
 	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
 	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
+	PORT_CMD_ESP 		= (1 << 21), /* eSATA Port */
 	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index ebc08d6..c5b71ad 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -43,6 +43,7 @@
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
 #include <linux/libata.h>
 #include "ahci.h"
 
@@ -107,6 +108,8 @@ static ssize_t ahci_show_host_version(struct device *dev,
 				      struct device_attribute *attr, char *buf);
 static ssize_t ahci_show_port_cmd(struct device *dev,
 				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_show_port_external(struct device *dev,
+			  struct device_attribute *attr, char *buf);
 static ssize_t ahci_read_em_buffer(struct device *dev,
 				   struct device_attribute *attr, char *buf);
 static ssize_t ahci_store_em_buffer(struct device *dev,
@@ -117,6 +120,7 @@ static DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
 static DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
 static DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
 static DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
+static DEVICE_ATTR(ahci_port_external, S_IRUGO, ahci_show_port_external, NULL);
 static DEVICE_ATTR(em_buffer, S_IWUSR | S_IRUGO,
 		   ahci_read_em_buffer, ahci_store_em_buffer);
 
@@ -136,6 +140,7 @@ EXPORT_SYMBOL_GPL(ahci_shost_attrs);
 struct device_attribute *ahci_sdev_attrs[] = {
 	&dev_attr_sw_activity,
 	&dev_attr_unload_heads,
+	&dev_attr_ahci_port_external,
 	NULL
 };
 EXPORT_SYMBOL_GPL(ahci_sdev_attrs);
@@ -250,6 +255,16 @@ static ssize_t ahci_show_port_cmd(struct device *dev,
 	return sprintf(buf, "%x\n", readl(port_mmio + PORT_CMD));
 }
 
+static ssize_t ahci_show_port_external(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	void __iomem *port_mmio = ahci_port_base(ap);
+
+	return sprintf(buf, "%x\n", readl(port_mmio + PORT_CMD) & PORT_CMD_ESP ? 1 : 0);
+}
+
 static ssize_t ahci_read_em_buffer(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-- 
1.7.1


--------------070707030407060505010909--
