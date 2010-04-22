From: Harry Zhang <harry.zhang@amd.com>
Subject: [PATCH 2/2] ahci EM message type auto detect
Date: Thu, 22 Apr 2010 18:16:49 +0800
Message-ID: <1271931409.3745.9.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:31471 "EHLO
	TX2EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780Ab0DVKRI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Apr 2010 06:17:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org, "Zhang, Harry" <Harry.Zhang@amd.com>, hane.Huang@amd.com

To detect enclosure management message type automatically at driver
initialization, instead of using module parameter "ahci_em_messages"

Signed-off-by: Harry Zhang <harry.zhang@amd.com>
---
 drivers/ata/ahci.c    |    2 +-
 drivers/ata/ahci.h    |    8 +++++++-
 drivers/ata/libahci.c |   38 ++++++++++++++++++++------------------
 3 files changed, 28 insertions(+), 20 deletions(-)

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
index e941af6..7113c57 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -230,6 +230,12 @@ enum {
 	EM_CTL_ALHD		= (1 << 26), /* Activity LED */
 	EM_CTL_XMT		= (1 << 25), /* Transmit Only */
 	EM_CTL_SMB		= (1 << 24), /* Single Message Buffer */
+
+	/* em message type */
+	EM_MSG_TYPE_LED		= (1 << 0), /* LED */
+	EM_MSG_TYPE_SAFTE	= (1 << 1), /* SAF-TE */
+	EM_MSG_TYPE_SES2	= (1 << 2), /* SES-2 */
+	EM_MSG_TYPE_SGPIO	= (1 << 3), /* SGPIO */
 };
 
 struct ahci_cmd_hdr {
@@ -286,9 +292,9 @@ struct ahci_host_priv {
 	u32			saved_port_map;	/* saved initial port_map */
 	u32 			em_loc; /* enclosure management location */
 	u32			em_buf_sz;	/* EM buffer size in byte */
+	u32			em_msg_type;	/* EM message type */
 };
 
-extern int ahci_em_messages;
 extern int ahci_ignore_sss;
 
 extern struct scsi_host_template ahci_sht;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 9ed38e0..0383a21 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -192,7 +192,7 @@ EXPORT_SYMBOL_GPL(ahci_em_messages);
 module_param(ahci_em_messages, int, 0444);
 /* add other LED protocol types when they become supported */
 MODULE_PARM_DESC(ahci_em_messages,
-	"Set AHCI Enclosure Management Message type (0 = disabled, 1 = LED");
+	"AHCI Enclosure Management Message control (0 = off, 1 = on)");
 
 static void ahci_enable_ahci(void __iomem *mmio)
 {
@@ -1033,27 +1033,29 @@ static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 		return -EBUSY;
 	}
 
-	/*
-	 * create message header - this is all zero except for
-	 * the message size, which is 4 bytes.
-	 */
-	message[0] |= (4 << 8);
+	if (hpriv->em_msg_type & EM_MSG_TYPE_LED) {
+		/*
+		 * create message header - this is all zero except for
+		 * the message size, which is 4 bytes.
+		 */
+		message[0] |= (4 << 8);
+
+		/* ignore 0:4 of byte zero, fill in port info yourself */
+		message[1] = ((state & ~EM_MSG_LED_HBA_PORT) | ap->port_no);
 
-	/* ignore 0:4 of byte zero, fill in port info yourself */
-	message[1] = ((state & ~EM_MSG_LED_HBA_PORT) | ap->port_no);
+		/* write message to EM_LOC */
+		writel(message[0], mmio + hpriv->em_loc);
+		writel(message[1], mmio + hpriv->em_loc+4);
 
-	/* write message to EM_LOC */
-	writel(message[0], mmio + hpriv->em_loc);
-	writel(message[1], mmio + hpriv->em_loc+4);
+		/*
+		 * tell hardware to transmit the message
+		 */
+		writel(em_ctl | EM_CTL_TM, mmio + HOST_EM_CTL);
+	}
 
 	/* save off new led state for port/slot */
 	emp->led_state = state;
 
-	/*
-	 * tell hardware to transmit the message
-	 */
-	writel(em_ctl | EM_CTL_TM, mmio + HOST_EM_CTL);
-
 	spin_unlock_irqrestore(ap->lock, flags);
 	return size;
 }
@@ -2196,11 +2198,11 @@ void ahci_set_em_messages(struct ahci_host_priv *hpriv,
 
 	messages = (em_ctl & EM_CTRL_MSG_TYPE) >> 16;
 
-	/* we only support LED message type right now */
-	if ((messages & 0x01) && (ahci_em_messages == 1)) {
+	if (messages) {
 		/* store em_loc */
 		hpriv->em_loc = ((em_loc >> 16) * 4);
 		hpriv->em_buf_sz = ((em_loc & 0xff) * 4);
+		hpriv->em_msg_type = messages;
 		pi->flags |= ATA_FLAG_EM;
 		if (!(em_ctl & EM_CTL_ALHD))
 			pi->flags |= ATA_FLAG_SW_ACTIVITY;
-- 
1.6.4.2



