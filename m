From: Harry Zhang <harry.zhang@amd.com>
Subject: [PATCH] ahci: add "em_buffer" attribute for AHCI hosts
Date: Tue, 9 Mar 2010 18:37:55 +0800
Message-ID: <1268131075.2000.6.camel@harry-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:36269 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab0CIKiK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Mar 2010 05:38:10 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org, "Huang, Shane" <Shane.Huang@amd.com>, "Zhang, Harry" <Harry.Zhang@amd.com>

Add "em_buffer" attribute for SATA AHCI hosts to enable user access AHCI EM
(enclosure management) buffer in user space if the host support EM.

AHCI driver should support SGPIO EM message. However the SATA/AHCI spec does no
define the SGPIO message format filled in EM buffer. Different HW vendors may 
have different definitions. The mainly purpose of "em_buffer" attribute is to
solve this issue by allowing HW vendors to provide user space SGPIO drivers and
tools.

Signed-off-by: Harry Zhang <harry.zhang@amd.com>
---
 drivers/ata/ahci.c        |   73 +++++++++++++++++++++++++++++++++++++++++---
 drivers/ata/libata-scsi.c |   14 ++++++++
 include/linux/libata.h    |    3 ++
 3 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6bd930b..a6b9059 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -268,6 +268,10 @@ enum {
 	EM_CTL_RST			= (1 << 9), /* Reset */
 	EM_CTL_TM			= (1 << 8), /* Transmit Message */
 	EM_CTL_ALHD			= (1 << 26), /* Activity LED */
+
+	/* EM buffer message flags */
+	EM_BUF_MSG_RST			= 1,	    /* reset */
+	EM_BUF_MSG_TM			= (1 << 1), /* transmit message */
 };
 
 struct ahci_cmd_hdr {
@@ -293,6 +297,13 @@ struct ahci_em_priv {
 	unsigned long led_state;
 };
 
+struct ahci_em_buf_msg {
+	u32			flags;	/* message flags */
+	u16			offset;	/* DWORD offset in EM buffer to r/w */
+	u16			len;	/* data length in DWORD */
+	u32			buf[0];	/* message data buffer */
+};
+
 struct ahci_host_priv {
 	unsigned int		flags;		/* AHCI_HFLAG_* */
 	u32			cap;		/* cap to use */
@@ -302,6 +313,7 @@ struct ahci_host_priv {
 	u32			saved_cap2;	/* saved initial cap2 */
 	u32			saved_port_map;	/* saved initial port_map */
 	u32 			em_loc; /* enclosure management location */
+	u32			em_buf_sz;	/* EM buffer size*/
 };
 
 struct ahci_port_priv {
@@ -365,6 +377,8 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf);
 static ssize_t ahci_activity_store(struct ata_device *dev,
 				   enum sw_activity val);
 static void ahci_init_sw_activity(struct ata_link *link);
+static ssize_t ahci_em_buffer_store(struct ata_port *ap,
+				    const char *buf, size_t size);
 
 static ssize_t ahci_show_host_caps(struct device *dev,
 				   struct device_attribute *attr, char *buf);
@@ -384,6 +398,7 @@ static struct device_attribute *ahci_shost_attrs[] = {
 	&dev_attr_link_power_management_policy,
 	&dev_attr_em_message_type,
 	&dev_attr_em_message,
+	&dev_attr_em_buffer,
 	&dev_attr_ahci_host_caps,
 	&dev_attr_ahci_host_cap2,
 	&dev_attr_ahci_host_version,
@@ -435,6 +450,7 @@ static struct ata_port_operations ahci_ops = {
 	.em_store		= ahci_led_store,
 	.sw_activity_show	= ahci_activity_show,
 	.sw_activity_store	= ahci_activity_store,
+	.em_buffer_store	= ahci_em_buffer_store,
 #ifdef CONFIG_PM
 	.port_suspend		= ahci_port_suspend,
 	.port_resume		= ahci_port_resume,
@@ -721,11 +737,13 @@ static struct pci_driver ahci_pci_driver = {
 #endif
 };
 
-static int ahci_em_messages = 1;
+static int ahci_em_messages = 0x09;
 module_param(ahci_em_messages, int, 0444);
 /* add other LED protocol types when they become supported */
 MODULE_PARM_DESC(ahci_em_messages,
-	"Set AHCI Enclosure Management Message type (0 = disabled, 1 = LED");
+	"AHCI Enclosure Management Message type on-off bit mask. \
+	bit 0 to 3 control LED, SAF-TE, SES-2, and SGPIO respectively \
+	(0 to disable, 1 to enable)");
 
 #if defined(CONFIG_PATA_MARVELL) || defined(CONFIG_PATA_MARVELL_MODULE)
 static int marvell_enable;
@@ -1608,6 +1626,48 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
 	return sprintf(buf, "%d\n", emp->blink_policy);
 }
 
+static ssize_t ahci_em_buffer_store(struct ata_port *ap,
+				    const char *buf, size_t size)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = ap->host->iomap[AHCI_PCI_BAR];
+	void __iomem *em_mmio = mmio + hpriv->em_loc;
+	struct ahci_em_buf_msg *msg = (struct ahci_em_buf_msg *)buf;
+	u32 em_ctl;
+	unsigned long flags;
+	int i, tmp;
+
+	/* check message validity */
+	tmp = sizeof(struct ahci_em_buf_msg);
+	if (size % 4 || size < tmp || size > tmp + msg->len * 4 ||
+			msg->offset + msg->len > hpriv->em_buf_sz / 4) {
+		return -EINVAL;
+	}
+
+	if (msg->flags & EM_BUF_MSG_RST)
+		ahci_reset_em(ap->host);
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	em_ctl = readl(mmio + HOST_EM_CTL);
+	if (em_ctl & EM_CTL_TM) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return -EBUSY;
+	}
+
+	for (i = 0; i < msg->len; ++i) {
+		tmp = (msg->offset + i) * 4;
+		writel(msg->buf[i], em_mmio + tmp);
+	}
+
+	if (msg->flags & EM_BUF_MSG_TM)
+		writel(em_ctl | EM_CTL_TM, mmio + HOST_EM_CTL);
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	return size;
+}
+
 static void ahci_port_init(struct pci_dev *pdev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
@@ -3295,12 +3355,15 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		messages = (em_ctl & EM_CTRL_MSG_TYPE) >> 16;
 
-		/* we only support LED message type right now */
-		if ((messages & 0x01) && (ahci_em_messages == 1)) {
+		/* only LED and SGPIO EM messages are enabled as default */
+		ahci_em_messages &= messages;
+		if (ahci_em_messages) {
 			/* store em_loc */
 			hpriv->em_loc = ((em_loc >> 16) * 4);
+			hpriv->em_buf_sz = ((em_loc & 0xff) * 4);
 			pi.flags |= ATA_FLAG_EM;
-			if (!(em_ctl & EM_CTL_ALHD))
+			if (!(em_ctl & EM_CTL_ALHD) &&
+			     (ahci_em_messages == 1))
 				pi.flags |= ATA_FLAG_SW_ACTIVITY;
 		}
 	}
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bea003a..b1a2379 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -370,6 +370,20 @@ DEVICE_ATTR(sw_activity, S_IWUSR | S_IRUGO, ata_scsi_activity_show,
 			ata_scsi_activity_store);
 EXPORT_SYMBOL_GPL(dev_attr_sw_activity);
 
+static ssize_t
+ata_scsi_em_buffer_store(struct device *dev, struct device_attribute *attr,
+	const char *buf, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+
+	if (ap->ops->em_buffer_store && (ap->flags & ATA_FLAG_EM))
+		return ap->ops->em_buffer_store(ap, buf, count);
+	return -EINVAL;
+}
+DEVICE_ATTR(em_buffer, S_IWUSR, NULL, ata_scsi_em_buffer_store);
+EXPORT_SYMBOL_GPL(dev_attr_em_buffer);
+
 struct device_attribute *ata_common_sdev_attrs[] = {
 	&dev_attr_unload_heads,
 	NULL
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f8ea71e..a26fd0e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -495,6 +495,7 @@ extern struct device_attribute dev_attr_unload_heads;
 extern struct device_attribute dev_attr_em_message_type;
 extern struct device_attribute dev_attr_em_message;
 extern struct device_attribute dev_attr_sw_activity;
+extern struct device_attribute dev_attr_em_buffer;
 
 enum sw_activity {
 	OFF,
@@ -874,6 +875,8 @@ struct ata_port_operations {
 	ssize_t (*sw_activity_show)(struct ata_device *dev, char *buf);
 	ssize_t (*sw_activity_store)(struct ata_device *dev,
 				     enum sw_activity val);
+	ssize_t (*em_buffer_store)(struct ata_port *ap,
+				  const char *buf, size_t size);
 	/*
 	 * Obsolete
 	 */




