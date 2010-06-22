From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2 #upstream-fixes] ata_generic: implement ATA_GEN_* flags
 and force enable DMA on MBP 7,1
Date: Tue, 22 Jun 2010 12:27:26 +0200
Message-ID: <4C20900E.9010808@kernel.org>
References: <4C19EDFE.8040202@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52505 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351Ab0FVK1z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jun 2010 06:27:55 -0400
In-Reply-To: <4C19EDFE.8040202@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>
Cc: pchen@nvidia.com, grapz666@gmail.com, tixetsal@juno.com, damien.cassou@gmail.com, gschwind@gnu-log.net, andreas_graf@csgraf.de, stable <stable@kernel.org>

IDE mode of MCP89 on MBP 7,1 doesn't set DMA enable bits in the BMDMA
status register.  Make the following changes to work around the problem=
=2E

* Instead of using hard coded 1 in id->driver_data as class code
  match, use ATA_GEN_CLASS_MATCH and carry the matched id in
  host->private_data.

* Instead of matching PCI_VENDOR_ID_CENATEK, use ATA_GEN_FORCE_DMA
  flag in id instead.

* Add ATA_GEN_FORCE_DMA to the id entry of MBP 7,1.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peer Chen <pchen@nvidia.com>
Cc: stable@kernel.org
Reported-by: Anders =D8sthus <grapz666@gmail.com>
Reported-by: Andreas Graf <andreas_graf@csgraf.de>
Reported-by: Benoit Gschwind <gschwind@gnu-log.net>
Reported-by: Damien Cassou <damien.cassou@gmail.com>
Reported-by: tixetsal@juno.com
---
 drivers/ata/ata_generic.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

Index: ata/drivers/ata/ata_generic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ata.orig/drivers/ata/ata_generic.c
+++ ata/drivers/ata/ata_generic.c
@@ -32,6 +32,11 @@
  *	A generic parallel ATA driver using libata
  */

+enum {
+	ATA_GEN_CLASS_MATCH		=3D (1 << 0),
+	ATA_GEN_FORCE_DMA		=3D (1 << 1),
+};
+
 /**
  *	generic_set_mode	-	mode setting
  *	@link: link to set up
@@ -46,13 +51,17 @@
 static int generic_set_mode(struct ata_link *link, struct ata_device *=
*unused)
 {
 	struct ata_port *ap =3D link->ap;
+	const struct pci_device_id *id =3D ap->host->private_data;
 	int dma_enabled =3D 0;
 	struct ata_device *dev;
 	struct pci_dev *pdev =3D to_pci_dev(ap->host->dev);

-	/* Bits 5 and 6 indicate if DMA is active on master/slave */
-	if (ap->ioaddr.bmdma_addr)
+	if (id->driver_data & ATA_GEN_FORCE_DMA) {
+		dma_enabled =3D 0xff;
+	} else if (ap->ioaddr.bmdma_addr) {
+		/* Bits 5 and 6 indicate if DMA is active on master/slave */
 		dma_enabled =3D ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	}

 	if (pdev->vendor =3D=3D PCI_VENDOR_ID_CENATEK)
 		dma_enabled =3D 0xFF;
@@ -126,7 +135,7 @@ static int ata_generic_init_one(struct p
 	const struct ata_port_info *ppi[] =3D { &info, NULL };

 	/* Don't use the generic entry unless instructed to do so */
-	if (id->driver_data =3D=3D 1 && all_generic_ide =3D=3D 0)
+	if ((id->driver_data & ATA_GEN_CLASS_MATCH) && all_generic_ide =3D=3D=
 0)
 		return -ENODEV;

 	/* Devices that need care */
@@ -155,7 +164,7 @@ static int ata_generic_init_one(struct p
 			return rc;
 		pcim_pin_device(dev);
 	}
-	return ata_pci_bmdma_init_one(dev, ppi, &generic_sht, NULL, 0);
+	return ata_pci_bmdma_init_one(dev, ppi, &generic_sht, (void *)id, 0);
 }

 static struct pci_device_id ata_generic[] =3D {
@@ -167,13 +176,15 @@ static struct pci_device_id ata_generic[
 	{ PCI_DEVICE(PCI_VENDOR_ID_HINT,   PCI_DEVICE_ID_HINT_VXPROII_IDE), }=
,
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558), },
-	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE), },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CENATEK,PCI_DEVICE_ID_CENATEK_IDE),
+	  .driver_data =3D ATA_GEN_FORCE_DMA },
 	/*
 	 * For some reason, MCP89 on MacBook 7,1 doesn't work with
 	 * ahci, use ata_generic instead.
 	 */
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA,
-	  PCI_VENDOR_ID_APPLE, 0xcb89, },
+	  PCI_VENDOR_ID_APPLE, 0xcb89,
+	  .driver_data =3D ATA_GEN_FORCE_DMA },
 #if !defined(CONFIG_PATA_TOSHIBA) && !defined(CONFIG_PATA_TOSHIBA_MODU=
LE)
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1), =
},
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2), =
 },
@@ -181,7 +192,8 @@ static struct pci_device_id ata_generic[
 	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_5), =
 },
 #endif=09
 	/* Must come last. If you add entries adjust this table appropriately=
 */
-	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STO=
RAGE_IDE << 8, 0xFFFFFF00UL, 1},
+	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL),
+	  .driver_data =3D ATA_GEN_CLASS_MATCH },
 	{ 0, },
 };

