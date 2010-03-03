From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 04/11] ahci: Factor out PCI specifics from
 ahci_reset_controller()
Date: Wed, 3 Mar 2010 20:17:39 +0300
Message-ID: <20100303171739.GD12362@oksana.dev.rtsoft.ru>
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

Move PCI stuff into ahci_pci_reset_controller().

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/ata/ahci.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9d9af3c..830a6fe 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1343,7 +1343,6 @@ static int ahci_deinit_port(struct ata_port *ap, const char **emsg)
 
 static int ahci_reset_controller(struct ata_host *host)
 {
-	struct pci_dev *pdev = to_pci_dev(host->dev);
 	struct ahci_host_priv *hpriv = host->private_data;
 	void __iomem *mmio = hpriv->mmio;
 	u32 tmp;
@@ -1387,7 +1386,17 @@ static int ahci_reset_controller(struct ata_host *host)
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
@@ -2670,7 +2679,7 @@ static int ahci_pci_device_resume(struct pci_dev *pdev)
 		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
-		rc = ahci_reset_controller(host);
+		rc = ahci_pci_reset_controller(host);
 		if (rc)
 			return rc;
 
@@ -3398,7 +3407,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
-	rc = ahci_reset_controller(host);
+	rc = ahci_pci_reset_controller(host);
 	if (rc)
 		return rc;
 
-- 
1.7.0
