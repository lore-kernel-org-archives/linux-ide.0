From: akpm@linux-foundation.org
Subject: [patch 1/1] drivers/ata/pata_ali.c: s/isa_bridge/ali_isa_bridge/ to fix alpha build
Date: Wed, 14 Jan 2009 16:48:42 -0800
Message-ID: <200901150048.n0F0mgnQ026848@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60574 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754589AbZAOAsz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 19:48:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk

From: Andrew Morton <akpm@linux-foundation.org>

drivers/ata/pata_ali.c:44: error: static declaration of 'isa_bridge' follows non-static declaration
arch/alpha/include/asm/pci.h:274: error: previous declaration of 'isa_bridge' was here

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_ali.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff -puN drivers/ata/pata_ali.c~drivers-ata-pata_alic-s-isa_bridge-ali_isa_bridge-to-fix-alpha-build drivers/ata/pata_ali.c
--- a/drivers/ata/pata_ali.c~drivers-ata-pata_alic-s-isa_bridge-ali_isa_bridge-to-fix-alpha-build
+++ a/drivers/ata/pata_ali.c
@@ -41,7 +41,7 @@ static int ali_atapi_dma = 0;
 module_param_named(atapi_dma, ali_atapi_dma, int, 0644);
 MODULE_PARM_DESC(atapi_dma, "Enable ATAPI DMA (0=disable, 1=enable)");
 
-static struct pci_dev *isa_bridge;
+static struct pci_dev *ali_isa_bridge;
 
 /*
  *	Cable special cases
@@ -346,13 +346,13 @@ static void ali_c2_c3_postreset(struct a
 	int port_bit = 4 << link->ap->port_no;
 
 	/* If our bridge is an ALI 1533 then do the extra work */
-	if (isa_bridge) {
+	if (ali_isa_bridge) {
 		/* Tristate and re-enable the bus signals */
-		pci_read_config_byte(isa_bridge, 0x58, &r);
+		pci_read_config_byte(ali_isa_bridge, 0x58, &r);
 		r &= ~port_bit;
-		pci_write_config_byte(isa_bridge, 0x58, r);
+		pci_write_config_byte(ali_isa_bridge, 0x58, r);
 		r |= port_bit;
-		pci_write_config_byte(isa_bridge, 0x58, r);
+		pci_write_config_byte(ali_isa_bridge, 0x58, r);
 	}
 	ata_sff_postreset(link, classes);
 }
@@ -467,14 +467,14 @@ static void ali_init_chipset(struct pci_
 		pci_write_config_byte(pdev, 0x53, tmp);
 	}
 	north = pci_get_bus_and_slot(0, PCI_DEVFN(0,0));
-	if (north && north->vendor == PCI_VENDOR_ID_AL && isa_bridge) {
+	if (north && north->vendor == PCI_VENDOR_ID_AL && ali_isa_bridge) {
 		/* Configure the ALi bridge logic. For non ALi rely on BIOS.
 		   Set the south bridge enable bit */
-		pci_read_config_byte(isa_bridge, 0x79, &tmp);
+		pci_read_config_byte(ali_isa_bridge, 0x79, &tmp);
 		if (pdev->revision == 0xC2)
-			pci_write_config_byte(isa_bridge, 0x79, tmp | 0x04);
+			pci_write_config_byte(ali_isa_bridge, 0x79, tmp | 0x04);
 		else if (pdev->revision > 0xC2 && pdev->revision < 0xC5)
-			pci_write_config_byte(isa_bridge, 0x79, tmp | 0x02);
+			pci_write_config_byte(ali_isa_bridge, 0x79, tmp | 0x02);
 	}
 	pci_dev_put(north);
 	ata_pci_bmdma_clear_simplex(pdev);
@@ -571,9 +571,9 @@ static int ali_init_one(struct pci_dev *
 
 	ali_init_chipset(pdev);
 
-	if (isa_bridge && pdev->revision >= 0x20 && pdev->revision < 0xC2) {
+	if (ali_isa_bridge && pdev->revision >= 0x20 && pdev->revision < 0xC2) {
 		/* Are we paired with a UDMA capable chip */
-		pci_read_config_byte(isa_bridge, 0x5E, &tmp);
+		pci_read_config_byte(ali_isa_bridge, 0x5E, &tmp);
 		if ((tmp & 0x1E) == 0x12)
 	        	ppi[0] = &info_20_udma;
 	}
@@ -617,11 +617,11 @@ static struct pci_driver ali_pci_driver 
 static int __init ali_init(void)
 {
 	int ret;
-	isa_bridge = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
+	ali_isa_bridge = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
 
 	ret = pci_register_driver(&ali_pci_driver);
 	if (ret < 0)
-		pci_dev_put(isa_bridge);
+		pci_dev_put(ali_isa_bridge);
 	return ret;
 }
 
@@ -629,7 +629,7 @@ static int __init ali_init(void)
 static void __exit ali_exit(void)
 {
 	pci_unregister_driver(&ali_pci_driver);
-	pci_dev_put(isa_bridge);
+	pci_dev_put(ali_isa_bridge);
 }
 
 
_
