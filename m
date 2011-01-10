From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH v2] pata_hpt37x: fold 'if' statement into 'switch'
Date: Mon, 10 Jan 2011 22:31:13 +0300
Message-ID: <201101102231.13495.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:58562 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754171Ab1AJTcd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 14:32:33 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

hpt37x_init_one() has a large *if* statement which should really be folded into
the *switch* statement that currently constitutes its *else* branch, reducing
one level of indentation...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree plus 2 patches I posted
before:

http://marc.info/?l=linux-ide&m=129468455026976
http://marc.info/?l=linux-ide&m=129468485927420

 drivers/ata/pata_hpt37x.c |   89 ++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.20"
+#define DRV_VERSION	"0.6.21"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -838,7 +838,8 @@ static int hpt37x_init_one(struct pci_de
 	if (rc)
 		return rc;
 
-	if (dev->device == PCI_DEVICE_ID_TTI_HPT366) {
+	switch (dev->device) {
+	case PCI_DEVICE_ID_TTI_HPT366:
 		/* May be a later chip in disguise. Check */
 		/* Older chips are in the HPT366 driver. Ignore them */
 		if (rev < 3)
@@ -867,50 +868,46 @@ static int hpt37x_init_one(struct pci_de
 			       "please report (%d).\n", rev);
 			return -ENODEV;
 		}
-	} else {
-		switch (dev->device) {
-		case PCI_DEVICE_ID_TTI_HPT372:
-			/* 372N if rev >= 2 */
-			if (rev >= 2)
-				return -ENODEV;
-			ppi[0] = &info_hpt372;
-			chip_table = &hpt372a;
-			break;
-		case PCI_DEVICE_ID_TTI_HPT302:
-			/* 302N if rev > 1 */
-			if (rev > 1)
-				return -ENODEV;
-			ppi[0] = &info_hpt302;
-			/* Check this */
-			chip_table = &hpt302;
-			break;
-		case PCI_DEVICE_ID_TTI_HPT371:
-			if (rev > 1)
-				return -ENODEV;
-			ppi[0] = &info_hpt302;
-			chip_table = &hpt371;
-			/*
-			 * Single channel device, master is not present
-			 * but the BIOS (or us for non x86) must mark it
-			 * absent
-			 */
-			pci_read_config_byte(dev, 0x50, &mcr1);
-			mcr1 &= ~0x04;
-			pci_write_config_byte(dev, 0x50, mcr1);
-			break;
-		case PCI_DEVICE_ID_TTI_HPT374:
-			chip_table = &hpt374;
-			if (!(PCI_FUNC(dev->devfn) & 1))
-				*ppi = &info_hpt374_fn0;
-			else
-				*ppi = &info_hpt374_fn1;
-			break;
-		default:
-			pr_err(DRV_NAME
-			       ": PCI table is bogus, please report (%d).\n",
-			       dev->device);
-				return -ENODEV;
-		}
+		break;
+	case PCI_DEVICE_ID_TTI_HPT372:
+		/* 372N if rev >= 2 */
+		if (rev >= 2)
+			return -ENODEV;
+		ppi[0] = &info_hpt372;
+		chip_table = &hpt372a;
+		break;
+	case PCI_DEVICE_ID_TTI_HPT302:
+		/* 302N if rev > 1 */
+		if (rev > 1)
+			return -ENODEV;
+		ppi[0] = &info_hpt302;
+		/* Check this */
+		chip_table = &hpt302;
+		break;
+	case PCI_DEVICE_ID_TTI_HPT371:
+		if (rev > 1)
+			return -ENODEV;
+		ppi[0] = &info_hpt302;
+		chip_table = &hpt371;
+		/*
+		 * Single channel device, master is not present but the BIOS
+		 * (or us for non x86) must mark it absent
+		 */
+		pci_read_config_byte(dev, 0x50, &mcr1);
+		mcr1 &= ~0x04;
+		pci_write_config_byte(dev, 0x50, mcr1);
+		break;
+	case PCI_DEVICE_ID_TTI_HPT374:
+		chip_table = &hpt374;
+		if (!(PCI_FUNC(dev->devfn) & 1))
+			*ppi = &info_hpt374_fn0;
+		else
+			*ppi = &info_hpt374_fn1;
+		break;
+	default:
+		pr_err(DRV_NAME ": PCI table is bogus, please report (%d).\n",
+		       dev->device);
+		return -ENODEV;
 	}
 	/* Ok so this is a chip we support */
 
