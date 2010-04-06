From: Harry Zhang <harry.zhang@amd.com>
Subject: [PATCH UPDATED] ahci: add "em_buffer" attribute for AHCI hosts
Date: Tue, 6 Apr 2010 15:43:51 +0800
Message-ID: <1270539831.1963.29.camel@harry-desktop>
References: <1268131075.2000.6.camel@harry-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.15]:18165
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755661Ab0DFHpJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Apr 2010 03:45:09 -0400
In-Reply-To: <1268131075.2000.6.camel@harry-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org, "Huang, Shane" <Shane.Huang@amd.com>, "Zhang, Harry" <Harry.Zhang@amd.com>

>From 3d4fbc75cc42220bda3a5b96bc2e19a38a533ffa Mon Sep 17 00:00:00 2001
From: Harry Zhang <harry.zhang@amd.com>
Date: Fri, 23 Oct 2009 08:04:51 +0800
Subject: [PATCH] ahci: add "em_buffer" attribute for AHCI hosts

Add "em_buffer" attribute for SATA AHCI hosts to allow users accessing
AHCI EM (enclosure management buffer) in user space if the host supports
EM.

AHCI driver should support SGPIO EM message. But the spec does not
define the SGPIO message format filled in EM buffer. HW vendors may have
different definitions. The mainly purpose of "em_buffer" attribute is to
enable SGPIO initiator control in user space rather than in kernel.

Signed-off-by: Harry Zhang <harry.zhang@amd.com>
---
Rebase the patch on the new upstream branch of linux-next.git, in which
ahci.c has been divided.

 drivers/ata/ahci.h        |   12 +++++++
 drivers/ata/libahci.c     |   81
++++++++++++++++++++++++++++++++++++--------
 drivers/ata/libata-scsi.c |   14 ++++++++
 include/linux/libata.h    |    3 ++
 4 files changed, 95 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 733def2..9b671c4 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -227,6 +227,10 @@ enum {
 	EM_CTL_RST			= (1 << 9), /* Reset */
 	EM_CTL_TM			= (1 << 8), /* Transmit Message */
 	EM_CTL_ALHD			= (1 << 26), /* Activity LED */
+
+	/* EM buffer message flags */
+	EM_BUF_MSG_RST			= 1,	    /* reset */
+	EM_BUF_MSG_TM			= (1 << 1), /* transmit message */
 };
 
 struct ahci_cmd_hdr {
@@ -252,6 +256,13 @@ struct ahci_em_priv {
 	unsigned long led_state;
 };
 
+struct ahci_em_buf_msg {
+	u32			flags;	/* message flags */
+	u16			start;	/* start offset in EM buffer to r/w */
+	u16			len;	/* data length in 32-bit */
+	u32			buf[0];	/* message data buffer */
+};
+
 struct ahci_port_priv {
 	struct ata_link		*active_link;
 	struct ahci_cmd_hdr	*cmd_slot;
@@ -282,6 +293,7 @@ struct ahci_host_priv {
 	u32			saved_cap2;	/* saved initial cap2 */
 	u32			saved_port_map;	/* saved initial port_map */
 	u32 			em_loc; /* enclosure management location */
+	u32			em_buf_sz;	/* EM buffer size*/
 };
 
 extern int ahci_em_messages;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 34fc57d..a78042e 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -99,6 +99,8 @@ static ssize_t ahci_activity_show(struct ata_device
*dev, char *buf);
 static ssize_t ahci_activity_store(struct ata_device *dev,
 				   enum sw_activity val);
 static void ahci_init_sw_activity(struct ata_link *link);
+static ssize_t ahci_em_buffer_store(struct ata_port *ap,
+				    const char *buf, size_t size);
 
 static ssize_t ahci_show_host_caps(struct device *dev,
 				   struct device_attribute *attr, char *buf);
@@ -118,6 +120,7 @@ static struct device_attribute *ahci_shost_attrs[] =
{
 	&dev_attr_link_power_management_policy,
 	&dev_attr_em_message_type,
 	&dev_attr_em_message,
+	&dev_attr_em_buffer,
 	&dev_attr_ahci_host_caps,
 	&dev_attr_ahci_host_cap2,
 	&dev_attr_ahci_host_version,
@@ -170,6 +173,7 @@ struct ata_port_operations ahci_ops = {
 	.em_store		= ahci_led_store,
 	.sw_activity_show	= ahci_activity_show,
 	.sw_activity_store	= ahci_activity_store,
+	.em_buffer_store	= ahci_em_buffer_store,
 #ifdef CONFIG_PM
 	.port_suspend		= ahci_port_suspend,
 	.port_resume		= ahci_port_resume,
@@ -179,12 +183,14 @@ struct ata_port_operations ahci_ops = {
 };
 EXPORT_SYMBOL_GPL(ahci_ops);
 
-int ahci_em_messages = 1;
+int ahci_em_messages = 0x09;
 EXPORT_SYMBOL_GPL(ahci_em_messages);
 module_param(ahci_em_messages, int, 0444);
 /* add other LED protocol types when they become supported */
 MODULE_PARM_DESC(ahci_em_messages,
-	"Set AHCI Enclosure Management Message type (0 = disabled, 1 = LED");
+	"AHCI Enclosure Management Message type on-off bit mask. \
+	bit 0 to 3 control LED, SAF-TE, SES-2, and SGPIO respectively \
+	(0 to disable, 1 to enable)");
 
 static void ahci_enable_ahci(void __iomem *mmio)
 {
@@ -931,18 +937,20 @@ static ssize_t ahci_transmit_led_message(struct
ata_port *ap, u32 state,
 		return -EBUSY;
 	}
 
-	/*
-	 * create message header - this is all zero except for
-	 * the message size, which is 4 bytes.
-	 */
-	message[0] |= (4 << 8);
+	if (ahci_em_messages & 0x01) {
+		/*
+		 * create message header - this is all zero except for
+		 * the message size, which is 4 bytes.
+		 */
+		message[0] |= (4 << 8);
 
-	/* ignore 0:4 of byte zero, fill in port info yourself */
-	message[1] = ((state & ~EM_MSG_LED_HBA_PORT) | ap->port_no);
+		/* ignore 0:4 of byte zero, fill in port info yourself */
+		message[1] = ((state & ~EM_MSG_LED_HBA_PORT) | ap->port_no);
 
-	/* write message to EM_LOC */
-	writel(message[0], mmio + hpriv->em_loc);
-	writel(message[1], mmio + hpriv->em_loc+4);
+		/* write message to EM_LOC */
+		writel(message[0], mmio + hpriv->em_loc);
+		writel(message[1], mmio + hpriv->em_loc+4);
+	}
 
 	/* save off new led state for port/slot */
 	emp->led_state = state;
@@ -1041,6 +1049,48 @@ static ssize_t ahci_activity_show(struct
ata_device *dev, char *buf)
 	return sprintf(buf, "%d\n", emp->blink_policy);
 }
 
+static ssize_t ahci_em_buffer_store(struct ata_port *ap,
+				    const char *buf, size_t size)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = hpriv->mmio;
+	void __iomem *em_mmio = mmio + hpriv->em_loc;
+	struct ahci_em_buf_msg *msg = (struct ahci_em_buf_msg *)buf;
+	u32 em_ctl;
+	unsigned long flags;
+	int i, tmp;
+
+	/* check message validity */
+	tmp = sizeof(struct ahci_em_buf_msg);
+	if (size % 4 || size < tmp || size > tmp + msg->len * 4 ||
+			msg->start + msg->len > hpriv->em_buf_sz / 4) {
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
+		tmp = (msg->start + i) * 4;
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
 static void ahci_port_init(struct device *dev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
@@ -2088,16 +2138,17 @@ void ahci_set_em_messages(struct ahci_host_priv
*hpriv,
 	void __iomem *mmio = hpriv->mmio;
 	u32 em_loc = readl(mmio + HOST_EM_LOC);
 	u32 em_ctl = readl(mmio + HOST_EM_CTL);
-
 	if (!ahci_em_messages || !(hpriv->cap & HOST_CAP_EMS))
 		return;
 
 	messages = (em_ctl & EM_CTRL_MSG_TYPE) >> 16;
 
-	/* we only support LED message type right now */
-	if ((messages & 0x01) && (ahci_em_messages == 1)) {
+	/* only LED and SGPIO EM messages are enabled as default */
+	ahci_em_messages &= messages;
+	if (ahci_em_messages) {
 		/* store em_loc */
 		hpriv->em_loc = ((em_loc >> 16) * 4);
+		hpriv->em_buf_sz = ((em_loc & 0xff) * 4);
 		pi->flags |= ATA_FLAG_EM;
 		if (!(em_ctl & EM_CTL_ALHD))
 			pi->flags |= ATA_FLAG_SW_ACTIVITY;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0088cde..f8a3ae2 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -371,6 +371,20 @@ DEVICE_ATTR(sw_activity, S_IWUSR | S_IRUGO,
ata_scsi_activity_show,
 			ata_scsi_activity_store);
 EXPORT_SYMBOL_GPL(dev_attr_sw_activity);
 
+static ssize_t
+ata_scsi_em_buffer_store(struct device *dev, struct device_attribute
*attr,
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
@@ -495,6 +495,7 @@ extern struct device_attribute
dev_attr_unload_heads;
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
-- 



