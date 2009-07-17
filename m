From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] libata: Export AHCI capabilities
Date: Fri, 17 Jul 2009 19:13:47 +0100
Message-ID: <1247854427-3315-1-git-send-email-mjg@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52095 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933583AbZGQSN5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Jul 2009 14:13:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, Matthew Garrett <mjg@redhat.com>

AHCI exports various capability bits that may be of interest to userspace
such as whether the BIOS claims a port is hotpluggable or eSATA. Providing
these via sysfs along with the version of the AHCI spec implemented by
the host allows userspace to make policy decisions for things like ALPM.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/ata/ahci.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 336eb1e..5a5c160 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -327,10 +327,24 @@ static ssize_t ahci_activity_store(struct ata_device *dev,
 				   enum sw_activity val);
 static void ahci_init_sw_activity(struct ata_link *link);
 
+static ssize_t ahci_show_host_caps(struct device *dev,
+				   struct device_attribute *attr, char *buf);
+static ssize_t ahci_show_host_version(struct device *dev,
+				      struct device_attribute *attr, char *buf);
+static ssize_t ahci_show_port_cmd(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+
+DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
+DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
+DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
+
 static struct device_attribute *ahci_shost_attrs[] = {
 	&dev_attr_link_power_management_policy,
 	&dev_attr_em_message_type,
 	&dev_attr_em_message,
+	&dev_attr_ahci_host_caps,
+	&dev_attr_ahci_host_version,
+	&dev_attr_ahci_port_cmd,
 	NULL
 };
 
@@ -696,6 +710,36 @@ static void ahci_enable_ahci(void __iomem *mmio)
 	WARN_ON(1);
 }
 
+static ssize_t ahci_show_host_caps(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+
+	return sprintf(buf, "%x\n", hpriv->cap);
+}
+
+static ssize_t ahci_show_host_version(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
+
+	return sprintf(buf, "%x\n", readl(mmio + HOST_VERSION));
+}
+
+static ssize_t ahci_show_port_cmd(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	void __iomem *port_mmio = ahci_port_base(ap);
+
+	return sprintf(buf, "%x\n", readl(port_mmio + PORT_CMD));
+}
+
 /**
  *	ahci_save_initial_config - Save and fixup initial config values
  *	@pdev: target PCI device
-- 
1.6.2.5

