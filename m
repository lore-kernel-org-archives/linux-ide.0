From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] sata_via: Enable optional hotplug on VT6420
Date: Sun, 25 Jun 2017 22:25:36 +0200
Message-ID: <20170625202536.14925-1-linux@rainbow-software.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

VT6420 seems to have the same hotplug capability as VT6421.

However, enabling hotplug needs to expose SCR registers which can cause
problems. It works for me but might break elsewhere. So add a module
parameter vt6420_hotplug to enable this feature.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/ata/sata_via.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index f3f538eec7b3..50d1c1b1131c 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -80,6 +80,10 @@ struct svia_priv {
 	bool			wd_workaround;
 };
 
+static int vt6420_hotplug;
+module_param_named(vt6420_hotplug, vt6420_hotplug, int, 0644);
+MODULE_PARM_DESC(vt6420_hotplug, "Enable hot-plug support for VT6420 (0=Don't support, 1=support)");
+
 static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
 #ifdef CONFIG_PM_SLEEP
 static int svia_pci_device_resume(struct pci_dev *pdev);
@@ -473,6 +477,11 @@ static int vt6420_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 	struct ata_host *host;
 	int rc;
 
+	if (vt6420_hotplug) {
+		ppi[0]->port_ops->scr_read = svia_scr_read;
+		ppi[0]->port_ops->scr_write = svia_scr_write;
+	}
+
 	rc = ata_pci_bmdma_prepare_host(pdev, ppi, &host);
 	if (rc)
 		return rc;
@@ -556,7 +565,7 @@ static void svia_wd_fix(struct pci_dev *pdev)
 	pci_write_config_byte(pdev, 0x52, tmp8 | BIT(2));
 }
 
-static irqreturn_t vt6421_interrupt(int irq, void *dev_instance)
+static irqreturn_t vt642x_interrupt(int irq, void *dev_instance)
 {
 	struct ata_host *host = dev_instance;
 	irqreturn_t rc = ata_bmdma_interrupt(irq, dev_instance);
@@ -644,7 +653,7 @@ static void svia_configure(struct pci_dev *pdev, int board_id,
 		pci_write_config_byte(pdev, SATA_NATIVE_MODE, tmp8);
 	}
 
-	if (board_id == vt6421) {
+	if ((board_id == vt6420 && vt6420_hotplug) || board_id == vt6421) {
 		/* enable IRQ on hotplug */
 		pci_read_config_byte(pdev, SVIA_MISC_3, &tmp8);
 		if ((tmp8 & SATA_HOTPLUG) != SATA_HOTPLUG) {
@@ -744,8 +753,8 @@ static int svia_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	svia_configure(pdev, board_id, hpriv);
 
 	pci_set_master(pdev);
-	if (board_id == vt6421)
-		return ata_host_activate(host, pdev->irq, vt6421_interrupt,
+	if ((board_id == vt6420 && vt6420_hotplug) || board_id == vt6421)
+		return ata_host_activate(host, pdev->irq, vt642x_interrupt,
 					 IRQF_SHARED, &svia_sht);
 	else
 		return ata_host_activate(host, pdev->irq, ata_bmdma_interrupt,
-- 
Ondrej Zary
