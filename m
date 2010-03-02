From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 05/12] ahci: Factor out PCI specifics from
 ahci_reset_controller()
Date: Tue, 2 Mar 2010 21:29:33 +0300
Message-ID: <20100302182933.GE3445@oksana.dev.rtsoft.ru>
References: <20100302182850.GA32057@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:38726 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754231Ab0CBS3e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Mar 2010 13:29:34 -0500
Content-Disposition: inline
In-Reply-To: <20100302182850.GA32057@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Move PCI stuff into ahci_pci_reset_controller().

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/ata/ahci.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index acfdcb5..c46a064 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1318,7 +1318,6 @@ static int ahci_deinit_port(struct ata_port *ap, const char **emsg)
 
 static int ahci_reset_controller(struct ata_host *host)
 {
-	struct pci_dev *pdev = to_pci_dev(host->dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 	u32 tmp;
@@ -1362,7 +1361,17 @@ static int ahci_reset_controller(struct ata_host *host)
 		dev_printk(KERN_INFO, host->dev,
 			   "skipping global host reset\n");
 
+	return 0;
+}
+
+static int ahci_pci_reset_controller(struct ata_host *host)
+{
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+
+	ahci_reset_controller(host);
+
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
+		struct ahci_host_priv *hpriv = host->private_data;
 		u16 tmp16;
 
 		/* configure PCS */
@@ -2499,7 +2508,7 @@ static int ahci_pci_device_resume(struct pci_dev *pdev)
 		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
-		rc = ahci_reset_controller(host);
+		rc = ahci_pci_reset_controller(host);
 		if (rc)
 			return rc;
 
@@ -3207,7 +3216,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = ahci_reset_controller(host);
+	rc = ahci_pci_reset_controller(host);
 	if (rc)
 		return rc;
 
-- 
1.7.0

