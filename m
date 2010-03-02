From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH 08/12] ahci: Factor out PCI specifics from ahci_print_info()
Date: Tue, 2 Mar 2010 21:29:38 +0300
Message-ID: <20100302182938.GH3445@oksana.dev.rtsoft.ru>
References: <20100302182850.GA32057@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100302182850.GA32057@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Introduce ahci_pci_print_info() that now handles PCI stuff.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/ata/ahci.c |   40 +++++++++++++++++++++++-----------------
 1 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index aaeac15..18443e9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2627,15 +2627,12 @@ static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
 	return 0;
 }
 
-static void ahci_print_info(struct ata_host *host)
+static void ahci_print_info(struct ata_host *host, const char *scc_s)
 {
 	struct ahci_host_priv *hpriv = host->private_data;
-	struct pci_dev *pdev = to_pci_dev(host->dev);
 	void __iomem *mmio = hpriv->mmio;
 	u32 vers, cap, cap2, impl, speed;
 	const char *speed_s;
-	u16 cc;
-	const char *scc_s;
 
 	vers = readl(mmio + HOST_VERSION);
 	cap = hpriv->cap;
@@ -2652,17 +2649,7 @@ static void ahci_print_info(struct ata_host *host)
 	else
 		speed_s = "?";
 
-	pci_read_config_word(pdev, 0x0a, &cc);
-	if (cc == PCI_CLASS_STORAGE_IDE)
-		scc_s = "IDE";
-	else if (cc == PCI_CLASS_STORAGE_SATA)
-		scc_s = "SATA";
-	else if (cc == PCI_CLASS_STORAGE_RAID)
-		scc_s = "RAID";
-	else
-		scc_s = "unknown";
-
-	dev_printk(KERN_INFO, &pdev->dev,
+	dev_info(host->dev,
 		"AHCI %02x%02x.%02x%02x "
 		"%u slots %u ports %s Gbps 0x%x impl %s mode\n"
 		,
@@ -2678,7 +2665,7 @@ static void ahci_print_info(struct ata_host *host)
 		impl,
 		scc_s);
 
-	dev_printk(KERN_INFO, &pdev->dev,
+	dev_info(host->dev,
 		"flags: "
 		"%s%s%s%s%s%s%s"
 		"%s%s%s%s%s%s%s"
@@ -2708,6 +2695,25 @@ static void ahci_print_info(struct ata_host *host)
 		);
 }
 
+static void ahci_pci_print_info(struct ata_host *host)
+{
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+	u16 cc;
+	const char *scc_s;
+
+	pci_read_config_word(pdev, 0x0a, &cc);
+	if (cc == PCI_CLASS_STORAGE_IDE)
+		scc_s = "IDE";
+	else if (cc == PCI_CLASS_STORAGE_SATA)
+		scc_s = "SATA";
+	else if (cc == PCI_CLASS_STORAGE_RAID)
+		scc_s = "RAID";
+	else
+		scc_s = "unknown";
+
+	ahci_print_info(host, scc_s);
+}
+
 /* On ASUS P5W DH Deluxe, the second port of PCI device 00:1f.2 is
  * hardwired to on-board SIMG 4726.  The chipset is ICH8 and doesn't
  * support PMP and the 4726 either directly exports the device
@@ -3229,7 +3235,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return rc;
 
 	ahci_pci_init_controller(host);
-	ahci_print_info(host);
+	ahci_pci_print_info(host);
 
 	pci_set_master(pdev);
 	return ata_host_activate(host, pdev->irq, ahci_interrupt, IRQF_SHARED,
-- 
1.7.0
