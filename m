From: Harry Zhang <harry.zhang@amd.com>
Subject: [PATCH v3] ahci: add "em_buffer" attribute for AHCI hosts
Date: Fri, 16 Apr 2010 12:38:46 +0800
Message-ID: <1271392726.3967.7.camel@zm-desktop>
References: <1268131075.2000.6.camel@harry-desktop>
	 <1270539831.1963.29.camel@harry-desktop>
	 <1270800011.1942.8.camel@harry-desktop> <4BBEFDEC.7020506@kernel.org>
	 <1793EC4BDC456040AA0FC17136E1732B207127@sshaexmb1.amd.com>
	 <4BBFD965.8020603@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:26544
	"EHLO VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751637Ab0DPEjD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Apr 2010 00:39:03 -0400
In-Reply-To: <4BBFD965.8020603@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: tj@kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>, "Zhang, Harry" <Harry.Zhang@amd.com>

Add "em_buffer" attribute for SATA AHCI hosts to provide a way for
userland to access AHCI EM (enclosure management) buffer directly if the
host supports EM.

AHCI driver should support SGPIO EM messages. However the SATA/AHCI
specs did not define the SGPIO message format filled in EM buffer.
Different HW vendors may have different definitions. The mainly purpose
of this attribute is to solve this issue by allowing HW vendors to
provide userland drivers and tools for their SGPIO initiators.

Signed-off-by: Harry Zhang <harry.zhang@amd.com>
---
v2: rebase this patch on the new upstream branch of linux-next.git

v3: do not use "ahci_em_messages" module parameter as EM message type
    control, instead by detecting supported types at initialization.
    Remove EM message structure shared with userland, insteady by
    simply writing the raw message into the buffer.
    Move write function for this attribute from libata-scsi.c to
    libachi.c.
    Add read function.
    Add necessary definitions for EM in ahci.h.

 drivers/ata/ahci.c    |    2 +-
 drivers/ata/ahci.h    |   16 ++++---
 drivers/ata/libahci.c |  115 +++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 112 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c44d112..8ca16f5 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1185,7 +1185,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		/* set enclosure management message type */
 		if (ap->flags & ATA_FLAG_EM)
-			ap->em_message_type = ahci_em_messages;
+			ap->em_message_type = hpriv->em_msg_type;
 
 
 		/* disabled/not-implemented port */
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 733def2..6605b03 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -220,13 +220,16 @@ enum {
 	ICH_MAP				= 0x90, /* ICH MAP register */
 
 	/* em constants */
-	EM_MAX_SLOTS			= 8,
-	EM_MAX_RETRY			= 5,
+	EM_MAX_SLOTS		= 8,
+	EM_MAX_RETRY		= 5,
 
 	/* em_ctl bits */
-	EM_CTL_RST			= (1 << 9), /* Reset */
-	EM_CTL_TM			= (1 << 8), /* Transmit Message */
-	EM_CTL_ALHD			= (1 << 26), /* Activity LED */
+	EM_CTL_RST		= (1 << 9), /* Reset */
+	EM_CTL_TM		= (1 << 8), /* Transmit Message */
+	EM_CTL_MR		= (1 << 0), /* Message Recieved */
+	EM_CTL_ALHD		= (1 << 26), /* Activity LED */
+	EM_CTL_XMT		= (1 << 25), /* Transmit Only */
+	EM_CTL_SMB		= (1 << 24), /* Single Message Buffer */
 };
 
 struct ahci_cmd_hdr {
@@ -282,9 +285,10 @@ struct ahci_host_priv {
 	u32			saved_cap2;	/* saved initial cap2 */
 	u32			saved_port_map;	/* saved initial port_map */
 	u32 			em_loc; /* enclosure management location */
+	u32			em_buf_sz;	/* EM buffer size in byte*/
+	u32			em_msg_type;	/* EM message type */
 };
 
-extern int ahci_em_messages;
 extern int ahci_ignore_sss;
 
 extern struct scsi_host_template ahci_sht;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 34fc57d..5002254 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -108,11 +108,18 @@ static ssize_t ahci_show_host_version(struct device *dev,
 				      struct device_attribute *attr, char *buf);
 static ssize_t ahci_show_port_cmd(struct device *dev,
 				  struct device_attribute *attr, char *buf);
+static ssize_t ahci_read_em_buffer(struct device *dev,
+				   struct device_attribute *attr, char *buf);
+static ssize_t ahci_store_em_buffer(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size);
 
 static DEVICE_ATTR(ahci_host_caps, S_IRUGO, ahci_show_host_caps, NULL);
 static DEVICE_ATTR(ahci_host_cap2, S_IRUGO, ahci_show_host_cap2, NULL);
 static DEVICE_ATTR(ahci_host_version, S_IRUGO, ahci_show_host_version, NULL);
 static DEVICE_ATTR(ahci_port_cmd, S_IRUGO, ahci_show_port_cmd, NULL);
+static DEVICE_ATTR(em_buffer, S_IWUSR | S_IRUGO,
+		   ahci_read_em_buffer, ahci_store_em_buffer);
 
 static struct device_attribute *ahci_shost_attrs[] = {
 	&dev_attr_link_power_management_policy,
@@ -122,6 +129,7 @@ static struct device_attribute *ahci_shost_attrs[] = {
 	&dev_attr_ahci_host_cap2,
 	&dev_attr_ahci_host_version,
 	&dev_attr_ahci_port_cmd,
+	&dev_attr_em_buffer,
 	NULL
 };
 
@@ -184,7 +192,7 @@ EXPORT_SYMBOL_GPL(ahci_em_messages);
 module_param(ahci_em_messages, int, 0444);
 /* add other LED protocol types when they become supported */
 MODULE_PARM_DESC(ahci_em_messages,
-	"Set AHCI Enclosure Management Message type (0 = disabled, 1 = LED");
+	"AHCI Enclosure Management Message control (0 = off, 1 = on)");
 
 static void ahci_enable_ahci(void __iomem *mmio)
 {
@@ -252,6 +260,83 @@ static ssize_t ahci_show_port_cmd(struct device *dev,
 	return sprintf(buf, "%x\n", readl(port_mmio + PORT_CMD));
 }
 
+static ssize_t ahci_read_em_buffer(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = hpriv->mmio;
+	void __iomem *em_mmio = mmio + hpriv->em_loc;
+	u32 em_ctl, msg;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	em_ctl = readl(mmio + HOST_EM_CTL);
+	if (!(ap->flags & ATA_FLAG_EM) || em_ctl & EM_CTL_XMT ||
+					!(em_ctl & EM_CTL_MR)) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return -EINVAL;
+	}
+
+	if (!(em_ctl & EM_CTL_SMB))
+		em_mmio += hpriv->em_buf_sz;
+
+	for (i = 0; i < hpriv->em_buf_sz; i += 4) {
+		msg = readl(em_mmio + i);
+		buf[i] = msg & 0xff;
+		buf[i + 1] = (msg >> 8) & 0xff;
+		buf[i + 2] = (msg >> 16) & 0xff;
+		buf[i + 3] = (msg >> 24) & 0xff;
+	}
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	return i;Add "em_buffer" attribute for SATA AHCI hosts to provide a way for
userland to access AHCI EM (enclosure management) buffer directly if the
host supports EM.

AHCI driver should support SGPIO EM messages. However the SATA/AHCI
specs did not define the SGPIO message format filled in EM buffer.
Different HW vendors may have different definitions. The mainly purpose
of this attribute is to solve this issue by allowing HW vendors to
provide userland drivers and tools for their SGPIO initiators.

Signed-off-by: Harry Zhang <harry.zhang@am
+}
+
+static ssize_t ahci_store_em_buffer(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct ata_port *ap = ata_shost_to_port(shost);
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *mmio = hpriv->mmio;
+	void __iomem *em_mmio = mmio + hpriv->em_loc;
+	u32 em_ctl, msg;
+	unsigned long flags;
+	int i;
+
+	/* check size validity */
+	if (!(ap->flags & ATA_FLAG_EM) || size % 4 ||
+					  size > hpriv->em_buf_sz) {
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	em_ctl = readl(mmio + HOST_EM_CTL);
+	if (em_ctl & EM_CTL_TM) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return -EBUSY;
+	}
+
+	for (i = 0; i < size; i += 4) {
+		msg = buf[i] | buf[i + 1] << 8 | buf[i + 2] << 16 |
+						 buf[i + 3] << 24;
+		writel(msg, em_mmio + i);
+	}
+
+	writel(em_ctl | EM_CTL_TM, mmio + HOST_EM_CTL);
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	return size;
+}
+
 /**
  *	ahci_save_initial_config - Save and fixup initial config values
  *	@dev: target AHCI device
@@ -931,18 +1016,20 @@ static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 		return -EBUSY;
 	}
 
-	/*
-	 * create message header - this is all zero except for
-	 * the message size, which is 4 bytes.
-	 */
-	message[0] |= (4 << 8);
+	if (hpriv->em_msg_type & 0x01) {
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
@@ -2088,16 +2175,16 @@ void ahci_set_em_messages(struct ahci_host_priv *hpriv,
 	void __iomem *mmio = hpriv->mmio;
 	u32 em_loc = readl(mmio + HOST_EM_LOC);
 	u32 em_ctl = readl(mmio + HOST_EM_CTL);
-
 	if (!ahci_em_messages || !(hpriv->cap & HOST_CAP_EMS))Add "em_buffer" attribute for SATA AHCI hosts to provide a way for
userland to access AHCI EM (enclosure management) buffer directly if the
host supports EM.

AHCI driver should support SGPIO EM messages. However the SATA/AHCI
specs did not define the SGPIO message format filled in EM buffer.
Different HW vendors may have different definitions. The mainly purpose
of this attribute is to solve this issue by allowing HW vendors to
provide userland drivers and tools for their SGPIO initiators.

Signed-off-by: Harry Zhang <harry.zhang@am
 		return;
 
 	messages = (em_ctl & EM_CTRL_MSG_TYPE) >> 16;
 
-	/* we only support LED message type right now */
-	if ((messages & 0x01) && (ahci_em_messages == 1)) {
+	if (messages) {
 		/* store em_loc */
 		hpriv->em_loc = ((em_loc >> 16) * 4);
+		hpriv->em_buf_sz = ((em_loc & 0xff) * 4);
+		hpriv->em_msg_type = messages;
 		pi->flags |= ATA_FLAG_EM;
 		if (!(em_ctl & EM_CTL_ALHD))
 			pi->flags |= ATA_FLAG_SW_ACTIVITY;

