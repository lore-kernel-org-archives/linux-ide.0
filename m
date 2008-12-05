From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/7] pata_ali: force initialise a few bits
Date: Fri, 05 Dec 2008 19:42:49 +0000
Message-ID: <20081205194244.17133.4891.stgit@localhost.localdomain>
References: <20081205194231.17133.42760.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40156 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755557AbYLETmk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Dec 2008 14:42:40 -0500
In-Reply-To: <20081205194231.17133.42760.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kai@kaishome.de, linux-ide@vger.kernel.org, jeff@garzik.org

From: Alan Cox <alan@redhat.com>

We can't assume some of the setup here on non x86 boxes.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/ata/pata_ali.c |   71 ++++++++++++++++++++++++++----------------------
 1 files changed, 38 insertions(+), 33 deletions(-)


diff --git a/drivers/ata/pata_ali.c b/drivers/ata/pata_ali.c
index 73c466e..d2ea2db 100644
--- a/drivers/ata/pata_ali.c
+++ b/drivers/ata/pata_ali.c
@@ -19,7 +19,9 @@
  *
  *  TODO/CHECK
  *	Cannot have ATAPI on both master & slave for rev < c2 (???) but
- *	otherwise should do atapi DMA.
+ *	otherwise should do atapi DMA (For now for old we do PIO only for
+ *	ATAPI)
+ *	Review Sunblade workaround.
  */
 
 #include <linux/kernel.h>
@@ -33,12 +35,14 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME "pata_ali"
-#define DRV_VERSION "0.7.5"
+#define DRV_VERSION "0.7.7"
 
 static int ali_atapi_dma = 0;
 module_param_named(atapi_dma, ali_atapi_dma, int, 0644);
 MODULE_PARM_DESC(atapi_dma, "Enable ATAPI DMA (0=disable, 1=enable)");
 
+static struct pci_dev *isa_bridge;
+
 /*
  *	Cable special cases
  */
@@ -401,52 +405,49 @@ static struct ata_port_operations ali_c5_port_ops = {
 static void ali_init_chipset(struct pci_dev *pdev)
 {
 	u8 tmp;
-	struct pci_dev *north, *isa_bridge;
+	struct pci_dev *north;
 
 	/*
 	 * The chipset revision selects the driver operations and
 	 * mode data.
 	 */
 
-	if (pdev->revision >= 0x20 && pdev->revision < 0xC2) {
-		/* 1543-E/F, 1543C-C, 1543C-D, 1543C-E */
-		pci_read_config_byte(pdev, 0x4B, &tmp);
-		/* Clear CD-ROM DMA write bit */
-		tmp &= 0x7F;
-		pci_write_config_byte(pdev, 0x4B, tmp);
-	} else if (pdev->revision >= 0xC2) {
-		/* Enable cable detection logic */
+	if (pdev->revision <= 0x20) {
+		pci_read_config_byte(pdev, 0x53, &tmp);
+		tmp |= 0x03;
+		pci_write_config_byte(pdev, 0x53, tmp);
+	} else {
+		pci_read_config_byte(pdev, 0x4a, &tmp);
+		pci_write_config_byte(pdev, 0x4a, tmp | 0x20);
 		pci_read_config_byte(pdev, 0x4B, &tmp);
-		pci_write_config_byte(pdev, 0x4B, tmp | 0x08);
-	}
-	north = pci_get_bus_and_slot(0, PCI_DEVFN(0,0));
-	isa_bridge = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
-
-	if (north && north->vendor == PCI_VENDOR_ID_AL && isa_bridge) {
-		/* Configure the ALi bridge logic. For non ALi rely on BIOS.
-		   Set the south bridge enable bit */
-		pci_read_config_byte(isa_bridge, 0x79, &tmp);
-		if (pdev->revision == 0xC2)
-			pci_write_config_byte(isa_bridge, 0x79, tmp | 0x04);
-		else if (pdev->revision > 0xC2 && pdev->revision < 0xC5)
-			pci_write_config_byte(isa_bridge, 0x79, tmp | 0x02);
-	}
-	if (pdev->revision >= 0x20) {
+		if (pdev->revision < 0xC2)
+			/* 1543-E/F, 1543C-C, 1543C-D, 1543C-E */
+			/* Clear CD-ROM DMA write bit */
+			tmp &= 0x7F;
+		/* Cable and UDMA */
+		pci_write_config_byte(pdev, 0x4B, tmp | 0x09);
 		/*
 		 * CD_ROM DMA on (0x53 bit 0). Enable this even if we want
 		 * to use PIO. 0x53 bit 1 (rev 20 only) - enable FIFO control
 		 * via 0x54/55.
 		 */
 		pci_read_config_byte(pdev, 0x53, &tmp);
-		if (pdev->revision <= 0x20)
-			tmp &= ~0x02;
 		if (pdev->revision >= 0xc7)
 			tmp |= 0x03;
 		else
 			tmp |= 0x01;	/* CD_ROM enable for DMA */
 		pci_write_config_byte(pdev, 0x53, tmp);
 	}
-	pci_dev_put(isa_bridge);
+	north = pci_get_bus_and_slot(0, PCI_DEVFN(0,0));
+	if (north && north->vendor == PCI_VENDOR_ID_AL && isa_bridge) {
+		/* Configure the ALi bridge logic. For non ALi rely on BIOS.
+		   Set the south bridge enable bit */
+		pci_read_config_byte(isa_bridge, 0x79, &tmp);
+		if (pdev->revision == 0xC2)
+			pci_write_config_byte(isa_bridge, 0x79, tmp | 0x04);
+		else if (pdev->revision > 0xC2 && pdev->revision < 0xC5)
+			pci_write_config_byte(isa_bridge, 0x79, tmp | 0x02);
+	}
 	pci_dev_put(north);
 	ata_pci_bmdma_clear_simplex(pdev);
 }
@@ -516,7 +517,6 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	const struct ata_port_info *ppi[] = { NULL, NULL };
 	u8 tmp;
-	struct pci_dev *isa_bridge;
 	int rc;
 
 	rc = pcim_enable_device(pdev);
@@ -543,14 +543,12 @@ static int ali_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	ali_init_chipset(pdev);
 
-	isa_bridge = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
 	if (isa_bridge && pdev->revision >= 0x20 && pdev->revision < 0xC2) {
 		/* Are we paired with a UDMA capable chip */
 		pci_read_config_byte(isa_bridge, 0x5E, &tmp);
 		if ((tmp & 0x1E) == 0x12)
 	        	ppi[0] = &info_20_udma;
 	}
-	pci_dev_put(isa_bridge);
 
 	return ata_pci_sff_init_one(pdev, ppi, &ali_sht, NULL);
 }
@@ -590,13 +588,20 @@ static struct pci_driver ali_pci_driver = {
 
 static int __init ali_init(void)
 {
-	return pci_register_driver(&ali_pci_driver);
+	int ret;
+	isa_bridge = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
+
+	ret = pci_register_driver(&ali_pci_driver);
+	if (ret < 0)
+		pci_dev_put(isa_bridge);
+	return ret;
 }
 
 
 static void __exit ali_exit(void)
 {
 	pci_unregister_driver(&ali_pci_driver);
+	pci_dev_put(isa_bridge);
 }
 
 

