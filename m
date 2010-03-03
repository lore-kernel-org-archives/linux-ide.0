From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 08/11] ahci: Introduce ahci_set_em_messages()
Date: Wed, 3 Mar 2010 20:17:45 +0300
Message-ID: <20100303171745.GH12362@oksana.dev.rtsoft.ru>
References: <20100303171713.GA6322@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100303171713.GA6322@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Factor out some ahci_em_messages handling code from ahci_init_one().
We would like to reuse it for non-PCI devices.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/ata/ahci.c |   41 ++++++++++++++++++++++++-----------------
 1 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index f904683..4f05cf0 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -3231,6 +3231,29 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
 {}
 #endif
 
+static void ahci_set_em_messages(struct ahci_host_priv *hpriv,
+				 struct ata_port_info *pi)
+{
+	u8 messages;
+	void __iomem *mmio = hpriv->mmio;
+	u32 em_loc = readl(mmio + HOST_EM_LOC);
+	u32 em_ctl = readl(mmio + HOST_EM_CTL);
+
+	if (!ahci_em_messages || !(hpriv->cap & HOST_CAP_EMS))
+		return;
+
+	messages = (em_ctl & EM_CTRL_MSG_TYPE) >> 16;
+
+	/* we only support LED message type right now */
+	if ((messages & 0x01) && (ahci_em_messages == 1)) {
+		/* store em_loc */
+		hpriv->em_loc = ((em_loc >> 16) * 4);
+		pi->flags |= ATA_FLAG_EM;
+		if (!(em_ctl & EM_CTL_ALHD))
+			pi->flags |= ATA_FLAG_SW_ACTIVITY;
+	}
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
@@ -3334,23 +3357,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (hpriv->cap & HOST_CAP_PMP)
 		pi.flags |= ATA_FLAG_PMP;
 
-	if (ahci_em_messages && (hpriv->cap & HOST_CAP_EMS)) {
-		u8 messages;
-		void __iomem *mmio = hpriv->mmio;
-		u32 em_loc = readl(mmio + HOST_EM_LOC);
-		u32 em_ctl = readl(mmio + HOST_EM_CTL);
-
-		messages = (em_ctl & EM_CTRL_MSG_TYPE) >> 16;
-
-		/* we only support LED message type right now */
-		if ((messages & 0x01) && (ahci_em_messages == 1)) {
-			/* store em_loc */
-			hpriv->em_loc = ((em_loc >> 16) * 4);
-			pi.flags |= ATA_FLAG_EM;
-			if (!(em_ctl & EM_CTL_ALHD))
-				pi.flags |= ATA_FLAG_SW_ACTIVITY;
-		}
-	}
+	ahci_set_em_messages(hpriv, &pi);
 
 	if (ahci_broken_system_poweroff(pdev)) {
 		pi.flags |= ATA_FLAG_NO_POWEROFF_SPINDOWN;
-- 
1.7.0
