From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 3/3] pata_hpt3x2n: coding style cleanup
Date: Tue, 28 Dec 2010 23:11:36 +0300
Message-ID: <201012282311.36576.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:57806 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750900Ab0L1UMy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Dec 2010 15:12:54 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Fix 8 errors and 3 warnings given by checkpatch.pl:

- *switch* and *case* not on the same indentation level;

- no space between *for*/*switch*/*while* and open parenthesis;

- space between an unary operator and its operand;

- spaces before tabs;

- lines over 80 characters.

In addition to these changes, also do the following:

- add new line after variable definitions;

- fix the style of some multi-line comments.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree plus the 3 patches I posted
before:

http://marc.info/?l=linux-ide&m=129356208121192
http://marc.info/?l=linux-ide&m=129330632207779
http://marc.info/?l=linux-ide&m=129356617425087

 drivers/ata/pata_hpt3x2n.c |   86 ++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt3x2n.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt3x2n.c
+++ linux-2.6/drivers/ata/pata_hpt3x2n.c
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.12"
+#define DRV_VERSION	"0.3.13"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
@@ -103,7 +103,7 @@ static u32 hpt3x2n_find_mode(struct ata_
 {
 	struct hpt_clock *clocks = hpt3x2n_clocks;
 
-	while(clocks->xfer_speed) {
+	while (clocks->xfer_speed) {
 		if (clocks->xfer_speed == speed)
 			return clocks->timing;
 		clocks++;
@@ -169,6 +169,7 @@ static int hpt3x2n_pre_reset(struct ata_
 {
 	struct ata_port *ap = link->ap;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+
 	/* Reset the state machine */
 	pci_write_config_byte(pdev, 0x50 + 4 * ap->port_no, 0x37);
 	udelay(100);
@@ -384,12 +385,12 @@ static int hpt3xn_calibrate_dpll(struct 
 	u32 reg5c;
 	int tries;
 
-	for(tries = 0; tries < 0x5000; tries++) {
+	for (tries = 0; tries < 0x5000; tries++) {
 		udelay(50);
 		pci_read_config_byte(dev, 0x5b, &reg5b);
 		if (reg5b & 0x80) {
 			/* See if it stays set */
-			for(tries = 0; tries < 0x1000; tries ++) {
+			for (tries = 0; tries < 0x1000; tries++) {
 				pci_read_config_byte(dev, 0x5b, &reg5b);
 				/* Failed ? */
 				if ((reg5b & 0x80) == 0)
@@ -397,7 +398,7 @@ static int hpt3xn_calibrate_dpll(struct 
 			}
 			/* Turn off tuning, we have the DPLL set */
 			pci_read_config_dword(dev, 0x5c, &reg5c);
-			pci_write_config_dword(dev, 0x5c, reg5c & ~ 0x100);
+			pci_write_config_dword(dev, 0x5c, reg5c & ~0x100);
 			return 1;
 		}
 	}
@@ -501,34 +502,36 @@ static int hpt3x2n_init_one(struct pci_d
 	if (rc)
 		return rc;
 
-	switch(dev->device) {
-		case PCI_DEVICE_ID_TTI_HPT366:
-			/* 372N if rev >= 6 */
-			if (rev < 6)
-				return -ENODEV;
-			goto hpt372n;
-		case PCI_DEVICE_ID_TTI_HPT371:
-			/* 371N if rev >= 2 */
-			if (rev < 2)
-				return -ENODEV;
-			break;
-		case PCI_DEVICE_ID_TTI_HPT372:
-			/* 372N if rev >= 2 */
-			if (rev < 2)
-				return -ENODEV;
-			goto hpt372n;
-		case PCI_DEVICE_ID_TTI_HPT302:
-			/* 302N if rev >= 2 */
-			if (rev < 2)
-				return -ENODEV;
-			break;
-		case PCI_DEVICE_ID_TTI_HPT372N:
-hpt372n:
-			ppi[0] = &info_hpt372n;
-			break;
-		default:
-			printk(KERN_ERR "pata_hpt3x2n: PCI table is bogus please report (%d).\n", dev->device);
+	switch (dev->device) {
+	case PCI_DEVICE_ID_TTI_HPT366:
+		/* 372N if rev >= 6 */
+		if (rev < 6)
+			return -ENODEV;
+		goto hpt372n;
+	case PCI_DEVICE_ID_TTI_HPT371:
+		/* 371N if rev >= 2 */
+		if (rev < 2)
+			return -ENODEV;
+		break;
+	case PCI_DEVICE_ID_TTI_HPT372:
+		/* 372N if rev >= 2 */
+		if (rev < 2)
+			return -ENODEV;
+		goto hpt372n;
+	case PCI_DEVICE_ID_TTI_HPT302:
+		/* 302N if rev >= 2 */
+		if (rev < 2)
 			return -ENODEV;
+		break;
+	case PCI_DEVICE_ID_TTI_HPT372N:
+hpt372n:
+		ppi[0] = &info_hpt372n;
+		break;
+	default:
+		printk(KERN_ERR
+		       "pata_hpt3x2n: PCI table is bogus please report (%d).\n",
+		       dev->device);
+		return -ENODEV;
 	}
 
 	/* Ok so this is a chip we support */
@@ -555,8 +558,10 @@ hpt372n:
 		pci_write_config_byte(dev, 0x50, mcr1);
 	}
 
-	/* Tune the PLL. HPT recommend using 75 for SATA, 66 for UDMA133 or
-	   50 for UDMA100. Right now we always use 66 */
+	/*
+	 * Tune the PLL. HPT recommend using 75 for SATA, 66 for UDMA133 or
+	 * 50 for UDMA100. Right now we always use 66
+	 */
 
 	pci_mhz = hpt3x2n_pci_clock(dev);
 
@@ -568,7 +573,7 @@ hpt372n:
 	pci_write_config_byte(dev, 0x5B, 0x21);
 
 	/* Unlike the 37x we don't try jiggling the frequency */
-	for(adjust = 0; adjust < 8; adjust++) {
+	for (adjust = 0; adjust < 8; adjust++) {
 		if (hpt3xn_calibrate_dpll(dev))
 			break;
 		pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low);
@@ -580,8 +585,11 @@ hpt372n:
 
 	printk(KERN_INFO "pata_hpt37x: bus clock %dMHz, using 66MHz DPLL.\n",
 	       pci_mhz);
-	/* Set our private data up. We only need a few flags so we use
-	   it directly */
+
+	/*
+	 * Set our private data up. We only need a few flags
+	 * so we use it directly.
+	 */
 	if (pci_mhz > 60)
 		hpriv = (void *)(PCI66 | USE_DPLL);
 
@@ -608,9 +616,9 @@ static const struct pci_device_id hpt3x2
 };
 
 static struct pci_driver hpt3x2n_pci_driver = {
-	.name 		= DRV_NAME,
+	.name		= DRV_NAME,
 	.id_table	= hpt3x2n,
-	.probe 		= hpt3x2n_init_one,
+	.probe		= hpt3x2n_init_one,
 	.remove		= ata_pci_remove_one
 };
 
