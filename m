From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/64] pata_cs5520: convert to use ->init_host method
Date: Mon, 18 Jan 2010 18:15:28 +0100
Message-ID: <20100118171528.14623.44156.sendpatchset@localhost>
References: <20100118171349.14623.90030.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754419Ab0ARRQt@vger.kernel.org>
In-Reply-To: <20100118171349.14623.90030.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cs5520: convert to use ->init_host method

Remove bogus kernel warning while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cs5520.c |   55 +++++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

Index: b/drivers/ata/pata_cs5520.c
===================================================================
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -115,6 +115,25 @@ static struct ata_port_operations cs5520
 	.set_piomode		= cs5520_set_piomode,
 };
 
+/**
+ *	cs5520_fixup	-	device fixup
+ *	@dev: device
+ *
+ *	We need to restore DMA mode support on BIOSen which disabled it.
+ */
+
+static int cs5520_fixup(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	u8 pcicfg;
+
+	pci_read_config_byte(pdev, 0x60, &pcicfg);
+	if ((pcicfg & 0x40) == 0)
+		pci_write_config_byte(pdev, 0x60, pcicfg | 0x40);
+
+	return 0;
+}
+
 static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const unsigned int cmd_port[] = { 0x1F0, 0x170 };
@@ -148,11 +167,7 @@ static int __devinit cs5520_init_one(str
 	if (pcicfg & 2)
 		ppi[1] = &pi;
 
-	if ((pcicfg & 0x40) == 0) {
-		dev_printk(KERN_WARNING, &pdev->dev,
-			   "DMA mode disabled. Enabling.\n");
-		pci_write_config_byte(pdev, 0x60, pcicfg | 0x40);
-	}
+	cs5520_fixup(&pdev->dev);
 
 	pi.mwdma_mask = id->driver_data;
 
@@ -160,6 +175,8 @@ static int __devinit cs5520_init_one(str
 	if (!host)
 		return -ENOMEM;
 
+	host->init_host = cs5520_fixup;
+
 	/* Perform set up for DMA */
 	if (pci_enable_device_io(pdev)) {
 		printk(KERN_ERR DRV_NAME ": unable to configure BAR2.\n");
@@ -233,32 +250,6 @@ static int __devinit cs5520_init_one(str
 
 #ifdef CONFIG_PM
 /**
- *	cs5520_reinit_one	-	device resume
- *	@pdev: PCI device
- *
- *	Do any reconfiguration work needed by a resume from RAM. We need
- *	to restore DMA mode support on BIOSen which disabled it
- */
-
-static int cs5520_reinit_one(struct pci_dev *pdev)
-{
-	struct ata_host *host = dev_get_drvdata(&pdev->dev);
-	u8 pcicfg;
-	int rc;
-
-	rc = ata_pci_device_do_resume(pdev);
-	if (rc)
-		return rc;
-
-	pci_read_config_byte(pdev, 0x60, &pcicfg);
-	if ((pcicfg & 0x40) == 0)
-		pci_write_config_byte(pdev, 0x60, pcicfg | 0x40);
-
-	ata_host_resume(host);
-	return 0;
-}
-
-/**
  *	cs5520_pci_device_suspend	-	device suspend
  *	@pdev: PCI device
  *
@@ -299,7 +290,7 @@ static struct pci_driver cs5520_pci_driv
 	.remove		= ata_pci_remove_one,
 #ifdef CONFIG_PM
 	.suspend	= cs5520_pci_device_suspend,
-	.resume		= cs5520_reinit_one,
+	.resume		= ata_pci_device_resume,
 #endif
 };
 
