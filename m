From: Harry Zhang <harry.zhang@amd.com>
Subject: [PATCH 1/2 v4] ahci add "em_buffer" attribute for AHCI hosts
Date: Thu, 22 Apr 2010 18:15:33 +0800
Message-ID: <1271931333.3745.7.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:33596
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751967Ab0DVKPy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 06:15:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org, hane.Huang@amd.com, "Zhang, Harry" <Harry.Zhang@amd.com>

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
    Remove EM message structure shared with userland, instead by
    simply writing the raw message into the buffer.
    Move write function for this attribute from libata-scsi.c to
    libahci.c.
    Add read function.
    Add necessary definitions for EM in ahci.h.

v4: remove changes for EM message types.
    add PAGE_SIZE check for em_buffer read function.
    report EAGAIN for read function when no message in the buffer.

 drivers/ata/ahci.h    |   10 +++-
 drivers/ata/libahci.c |  103 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 733def2..e941af6 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -224,9 +224,12 @@ enum {
 	EM_MAX_RETRY			= 5,
 
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
@@ -282,6 +285,7 @@ struct ahci_host_priv {
 	u32			saved_cap2;	/* saved initial cap2 */
 	u32			saved_port_map;	/* saved initial port_map */
 	u32 			em_loc; /* enclosure management location */
+	u32			em_buf_sz;	/* EM buffer size in byte */
 };
 
 extern int ahci_em_messages;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 34fc57d..9ed38e0 100644
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
 
@@ -252,6 +260,100 @@ static ssize_t ahci_show_port_cmd(struct device *dev,
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
+	size_t count;
+	int i;
+
+	spin_lock_irqsave(ap->lock, flags);
+
+	em_ctl = readl(mmio + HOST_EM_CTL);
+	if (!(ap->flags & ATA_FLAG_EM) || em_ctl & EM_CTL_XMT) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return -EINVAL;
+	}
+
+	if (!(em_ctl & EM_CTL_MR)) {
+		spin_unlock_irqrestore(ap->lock, flags);
+		return -EAGAIN;
+	}
+
+	if (!(em_ctl & EM_CTL_SMB))
+		em_mmio += hpriv->em_buf_sz;
+
+	count = hpriv->em_buf_sz;
+
+	/* Since EM buffer is in ABAR, commonly, the buffer size should be
+	 * less than a page. Check buffer size against PAGE_SIZE in case of
+	 * some rare instance. Only transfer the first page in this case.
+	 */
+	if (count > PAGE_SIZE) {
+		dev_printk(KERN_WARNING, dev, 
+			   "EM read buffer size %u is larger than %lu",
+			   hpriv->em_buf_sz, PAGE_SIZE);
+		count = PAGE_SIZE;
+	}
+
+	for (i = 0; i < count; i += 4) {
+		msg = readl(em_mmio + i);
+		buf[i] = msg & 0xff;
+		buf[i + 1] = (msg >> 8) & 0xff;
+		buf[i + 2] = (msg >> 16) & 0xff;
+		buf[i + 3] = (msg >> 24) & 0xff;
+	}
+
+	spin_unlock_irqrestore(ap->lock, flags);
+
+	return i;
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
+	if (!(ap->flags & ATA_FLAG_EM) ||
+	    size % 4 || size > hpriv->em_buf_sz)
+		return -EINVAL;
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
+		msg = buf[i] | buf[i + 1] << 8 |
+		      buf[i + 2] << 16 | buf[i + 3] << 24;
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
@@ -2098,6 +2200,7 @@ void ahci_set_em_messages(struct ahci_host_priv *hpriv,
 	if ((messages & 0x01) && (ahci_em_messages == 1)) {
 		/* store em_loc */
 		hpriv->em_loc = ((em_loc >> 16) * 4);
+		hpriv->em_buf_sz = ((em_loc & 0xff) * 4);
 		pi->flags |= ATA_FLAG_EM;
 		if (!(em_ctl & EM_CTL_ALHD))
 			pi->flags |= ATA_FLAG_SW_ACTIVITY;
-- 
1.6.4.2



