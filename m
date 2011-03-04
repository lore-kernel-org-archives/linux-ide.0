From: hare@suse.de (Hannes Reinecke)
Subject: [PATCH] ahci: EM supported message type sysfs attribute
Date: Fri, 04 Mar 2011 09:54:52 +0100
Message-ID: <20110304085452.83B5EF90E1@ochil.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50922 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237Ab1CDIo4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Mar 2011 03:44:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org


This patch adds an sysfs attribute 'em_message_supported' to the
ahci host device which prints out the supported enclosure management
message types.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/ahci.h    |    4 ++++
 drivers/ata/libahci.c |   22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 3e606c3..daf1f01 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -231,6 +231,10 @@ enum {
 	EM_CTL_ALHD		= (1 << 26), /* Activity LED */
 	EM_CTL_XMT		= (1 << 25), /* Transmit Only */
 	EM_CTL_SMB		= (1 << 24), /* Single Message Buffer */
+	EM_CTL_SGPIO		= (1 << 19), /* SGPIO messages supported */
+	EM_CTL_SES		= (1 << 18), /* SES-2 messages supported */
+	EM_CTL_SAFTE		= (1 << 17), /* SAF-TE messages supported */
+	EM_CTL_LED		= (1 << 16), /* LED messages supported */
 
 	/* em message type */
 	EM_MSG_TYPE_LED		= (1 << 0), /* LED */
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 26d4523..633159b 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -109,6 +109,8 @@ static ssize_t ahci_read_em_buffer(struct device *dev,
 static ssize_t ahci_store_em_buffer(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t size);
+static ssize_t ahci_show_em_supported(struct device *dev,
+				      struct device_attribute *attr, char *buf);
 
 static DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
 static DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
@@ -116,6 +118,7 @@ static DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
 static DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
 static DEVICE_ATTR(em_buffer, S_IWUSR | S_IRUGO,
 		   ahci_read_em_buffer, ahci_store_em_buffer);
+static DEVICE_ATTR(em_message_supported, S_IRUGO, ahci_show_em_supported, NULL);
 
 struct device_attribute *ahci_shost_attrs[] = {
 	&dev_attr_link_power_management_policy,
@@ -126,6 +129,7 @@ struct device_attribute *ahci_shost_attrs[] = {
 	&dev_attr_ahci_host_version,
 	&dev_attr_ahci_port_cmd,
 	&dev_attr_em_buffer,
+	&dev_attr_em_message_supported,
 	NULL
 };
 EXPORT_SYMBOL_GPL(ahci_shost_attrs);
@@ -343,6 +347,24 @@ static ssize_t ahci_store_em_buffer(struct device *dev,
 	return size;
 }
 
+static ssize_t ahci_show_em_supported(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = hpriv->mmio;
+	u32 em_ctl;
+
+	em_ctl = readl(mmio + HOST_EM_CTL);
+
+	return sprintf(buf, "%s%s%s%s\n",
+		       em_ctl & EM_CTL_LED ? "led " : "",
+		       em_ctl & EM_CTL_SAFTE ? "saf-te " : "",
+		       em_ctl & EM_CTL_SES ? "ses-2 " : "",
+		       em_ctl & EM_CTL_SGPIO ? "sgpio " : "");
+}
+
 /**
  *	ahci_save_initial_config - Save and fixup initial config values
  *	@dev: target AHCI device
-- 
1.6.0.2

