From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 61/86] pata_sis: Power Management fix
Date: Wed, 25 Nov 2009 18:09:40 +0100
Message-ID: <20091125170940.5446.67928.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759371AbZKYRK3@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_pdc202xx_old: Power Management fix

Enable burst mode on resume for PDC2026x controllers.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_pdc202xx_old.c |   33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_pdc202xx_old.c
===================================================================
--- a/drivers/ata/pata_pdc202xx_old.c
+++ b/drivers/ata/pata_pdc202xx_old.c
@@ -232,14 +232,21 @@ static void pdc2026x_dev_config(struct a
 	adev->max_sectors = 256;
 }
 
-static int pdc2026x_port_start(struct ata_port *ap)
+static void pdc2026x_bmdma_enable_burst(struct ata_port *ap)
 {
 	void __iomem *bmdma = ap->ioaddr.bmdma_addr;
+
 	if (bmdma) {
 		/* Enable burst mode */
 		u8 burst = ioread8(bmdma + 0x1f);
 		iowrite8(burst | 0x01, bmdma + 0x1f);
 	}
+}
+
+static int pdc2026x_port_start(struct ata_port *ap)
+{
+	pdc2026x_bmdma_enable_burst(ap);
+
 	return ata_sff_port_start32(ap);
 }
 
@@ -327,6 +334,28 @@ static int pdc202xx_init_one(struct pci_
 	return ata_pci_sff_init_one(dev, ppi, &pdc202xx_sht, NULL);
 }
 
+#ifdef CONFIG_PM
+static int pdc202xx_reinit_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc, i;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+
+		if (ap->udma_mask > ATA_UDMA2)
+			pdc2026x_bmdma_enable_burst(ap);
+	}
+
+	ata_host_resume(host);
+	return 0;
+}
+#endif
+
 static const struct pci_device_id pdc202xx[] = {
 	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20246), 0 },
 	{ PCI_VDEVICE(PROMISE, PCI_DEVICE_ID_PROMISE_20262), 1 },
@@ -344,7 +373,7 @@ static struct pci_driver pdc202xx_pci_dr
 	.remove		= ata_pci_remove_one,
 #ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
-	.resume		= ata_pci_device_resume,
+	.resume		= pdc202xx_reinit_one,
 #endif
 };
 
