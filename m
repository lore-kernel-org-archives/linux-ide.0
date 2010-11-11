From: Phillip Susi <psusi@cfl.rr.com>
Subject: [PATCH] Export ahci eSATA attribute
Date: Wed, 10 Nov 2010 22:32:55 -0500
Message-ID: <4CDB63E7.1040106@cfl.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050206090301030807010000"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:58916 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104Ab0KKDd6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Nov 2010 22:33:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050206090301030807010000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Not subscribed, please CC.


--------------050206090301030807010000
Content-Type: text/x-patch;
 name="0001-Export-ahci-eSATA-attribute.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Export-ahci-eSATA-attribute.patch"

>From 8b079f9f7111a21251df110db81bd2540ec73058 Mon Sep 17 00:00:00 2001
From: Phillip Susi <psusi@faldara.(none)>
Date: Wed, 10 Nov 2010 22:01:35 -0500
Subject: [PATCH] Export ahci eSATA attribute

The AHCI standard defines a port bit that indicates that port
is an eSATA external port.  Detect and export this bit as a
sysfs attribute named ahci_port_external.  It is intended that
this information be used by udisks to auto mount external eSATA
drives when they are hot plugged.
---
 drivers/ata/ahci.h     |    1 +
 drivers/ata/libahci.c  |   16 ++++++++++++++++
 include/linux/libata.h |    1 +
 3 files changed, 18 insertions(+), 0 deletions(-)

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
index ebc08d6..8e4a363 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -107,6 +107,8 @@ static ssize_t ahci_show_host_version(struct device *dev,
 				      struct device_attribute *attr, char *buf);
 static ssize_t ahci_show_port_cmd(struct device *dev,
 				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_show_port_external(struct device *dev,
+				  struct device_attribute *attr, char *buf);
 static ssize_t ahci_read_em_buffer(struct device *dev,
 				   struct device_attribute *attr, char *buf);
 static ssize_t ahci_store_em_buffer(struct device *dev,
@@ -117,6 +119,7 @@ static DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
 static DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
 static DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
 static DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
+static DEVICE_ATTR(ahci_port_external, S_IRUGO, ahci_show_port_external, NULL);
 static DEVICE_ATTR(em_buffer, S_IWUSR | S_IRUGO,
 		   ahci_read_em_buffer, ahci_store_em_buffer);
 
@@ -128,6 +131,7 @@ struct device_attribute *ahci_shost_attrs[] = {
 	&dev_attr_ahci_host_cap2,
 	&dev_attr_ahci_host_version,
 	&dev_attr_ahci_port_cmd,
+	&dev_attr_ahci_port_external,
 	&dev_attr_em_buffer,
 	NULL
 };
@@ -250,6 +254,15 @@ static ssize_t ahci_show_port_cmd(struct device *dev,
 	return sprintf(buf, "%x\n", readl(port_mmio + PORT_CMD));
 }
 
+static ssize_t ahci_show_port_external(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+
+	return sprintf(buf, "%x\n", ap->flags & ATA_FLAG_EXTERN ? 1 : 0);
+}
+
 static ssize_t ahci_read_em_buffer(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -1079,6 +1092,9 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 		writel(tmp, port_mmio + PORT_IRQ_STAT);
 
 	writel(1 << port_no, mmio + HOST_IRQ_STAT);
+	tmp = readl(port_mmio + PORT_CMD);
+	if (tmp & PORT_CMD_ESP)
+		ap->flags |= ATA_FLAG_EXTERN;
 }
 
 void ahci_init_controller(struct ata_host *host)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 15b77b8..1c5ffa7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -203,6 +203,7 @@ enum {
 					      * management */
 	ATA_FLAG_SW_ACTIVITY	= (1 << 22), /* driver supports sw activity
 					      * led */
+	ATA_FLAG_EXTERN		= (1 << 23), /* eSATA external port */
 
 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
-- 
1.7.1


--------------050206090301030807010000--
