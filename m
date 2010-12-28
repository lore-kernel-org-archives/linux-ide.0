From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/3] pata_hpt37x: coding style cleanup
Date: Tue, 28 Dec 2010 23:09:27 +0300
Message-ID: <201012282309.27941.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:57803 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750837Ab0L1UKq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Dec 2010 15:10:46 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Fix 12 errors and 15 warnings given by checkpatch.pl:

- *switch* and *case* not on the same indentation level;

- no space between *for*/*switch*/*while* and open parenthesis;

- space between an unary operator and its operand;

- drive blacklist arrays not being *const*;

- spaces before tabs;

- lines over 80 characters.

In addition to these changes, also do the following:

- add new line after variable definitions;

- fix the style of some multi-line comments.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree plus the patch I posted
before:

http://marc.info/?l=linux-ide&m=129330632207779

 drivers/ata/pata_hpt37x.c |  182 +++++++++++++++++++++++++---------------------
 1 file changed, 101 insertions(+), 81 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.16"
+#define DRV_VERSION	"0.6.17"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -210,7 +210,7 @@ static u32 hpt37x_find_mode(struct ata_p
 {
 	struct hpt_clock *clocks = ap->host->private_data;
 
-	while(clocks->xfer_speed) {
+	while (clocks->xfer_speed) {
 		if (clocks->xfer_speed == speed)
 			return clocks->timing;
 		clocks++;
@@ -219,7 +219,8 @@ static u32 hpt37x_find_mode(struct ata_p
 	return 0xffffffffU;	/* silence compiler warning */
 }
 
-static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr, const char *list[])
+static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
+			       const char * const list[])
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	int i = 0;
@@ -237,18 +238,23 @@ static int hpt_dma_blacklisted(const str
 	return 0;
 }
 
-static const char *bad_ata33[] = {
-	"Maxtor 92720U8", "Maxtor 92040U6", "Maxtor 91360U4", "Maxtor 91020U3", "Maxtor 90845U3", "Maxtor 90650U2",
-	"Maxtor 91360D8", "Maxtor 91190D7", "Maxtor 91020D6", "Maxtor 90845D5", "Maxtor 90680D4", "Maxtor 90510D3", "Maxtor 90340D2",
-	"Maxtor 91152D8", "Maxtor 91008D7", "Maxtor 90845D6", "Maxtor 90840D6", "Maxtor 90720D5", "Maxtor 90648D5", "Maxtor 90576D4",
+static const char * const bad_ata33[] = {
+	"Maxtor 92720U8", "Maxtor 92040U6", "Maxtor 91360U4", "Maxtor 91020U3",
+	"Maxtor 90845U3", "Maxtor 90650U2",
+	"Maxtor 91360D8", "Maxtor 91190D7", "Maxtor 91020D6", "Maxtor 90845D5",
+	"Maxtor 90680D4", "Maxtor 90510D3", "Maxtor 90340D2",
+	"Maxtor 91152D8", "Maxtor 91008D7", "Maxtor 90845D6", "Maxtor 90840D6",
+	"Maxtor 90720D5", "Maxtor 90648D5", "Maxtor 90576D4",
 	"Maxtor 90510D4",
 	"Maxtor 90432D3", "Maxtor 90288D2", "Maxtor 90256D2",
-	"Maxtor 91000D8", "Maxtor 90910D8", "Maxtor 90875D7", "Maxtor 90840D7", "Maxtor 90750D6", "Maxtor 90625D5", "Maxtor 90500D4",
-	"Maxtor 91728D8", "Maxtor 91512D7", "Maxtor 91303D6", "Maxtor 91080D5", "Maxtor 90845D4", "Maxtor 90680D4", "Maxtor 90648D3", "Maxtor 90432D2",
+	"Maxtor 91000D8", "Maxtor 90910D8", "Maxtor 90875D7", "Maxtor 90840D7",
+	"Maxtor 90750D6", "Maxtor 90625D5", "Maxtor 90500D4",
+	"Maxtor 91728D8", "Maxtor 91512D7", "Maxtor 91303D6", "Maxtor 91080D5",
+	"Maxtor 90845D4", "Maxtor 90680D4", "Maxtor 90648D3", "Maxtor 90432D2",
 	NULL
 };
 
-static const char *bad_ata100_5[] = {
+static const char * const bad_ata100_5[] = {
 	"IBM-DTLA-307075",
 	"IBM-DTLA-307060",
 	"IBM-DTLA-307045",
@@ -389,6 +395,7 @@ static int hpt37x_pre_reset(struct ata_l
 		{ 0x50, 1, 0x04, 0x04 },
 		{ 0x54, 1, 0x04, 0x04 }
 	};
+
 	if (!pci_test_config_bits(pdev, &hpt37x_enable_bits[ap->port_no]))
 		return -ENOENT;
 
@@ -673,12 +680,12 @@ static int hpt37x_calibrate_dpll(struct 
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
@@ -686,7 +693,7 @@ static int hpt37x_calibrate_dpll(struct 
 			}
 			/* Turn off tuning, we have the DPLL set */
 			pci_read_config_dword(dev, 0x5c, &reg5c);
-			pci_write_config_dword(dev, 0x5c, reg5c & ~ 0x100);
+			pci_write_config_dword(dev, 0x5c, reg5c & ~0x100);
 			return 1;
 		}
 	}
@@ -698,6 +705,7 @@ static u32 hpt374_read_freq(struct pci_d
 {
 	u32 freq;
 	unsigned long io_base = pci_resource_start(pdev, 4);
+
 	if (PCI_FUNC(pdev->devfn) & 1) {
 		struct pci_dev *pdev_0;
 
@@ -839,64 +847,68 @@ static int hpt37x_init_one(struct pci_de
 		if (rev == 6)
 			return -ENODEV;
 
-		switch(rev) {
-			case 3:
-				ppi[0] = &info_hpt370;
-				chip_table = &hpt370;
-				prefer_dpll = 0;
-				break;
-			case 4:
-				ppi[0] = &info_hpt370a;
-				chip_table = &hpt370a;
-				prefer_dpll = 0;
-				break;
-			case 5:
-				ppi[0] = &info_hpt372;
-				chip_table = &hpt372;
-				break;
-			default:
-				printk(KERN_ERR "pata_hpt37x: Unknown HPT366 "
-				       "subtype, please report (%d).\n", rev);
-				return -ENODEV;
+		switch (rev) {
+		case 3:
+			ppi[0] = &info_hpt370;
+			chip_table = &hpt370;
+			prefer_dpll = 0;
+			break;
+		case 4:
+			ppi[0] = &info_hpt370a;
+			chip_table = &hpt370a;
+			prefer_dpll = 0;
+			break;
+		case 5:
+			ppi[0] = &info_hpt372;
+			chip_table = &hpt372;
+			break;
+		default:
+			printk(KERN_ERR "pata_hpt37x: Unknown HPT366 subtype, "
+			       "please report (%d).\n", rev);
+			return -ENODEV;
 		}
 	} else {
-		switch(dev->device) {
-			case PCI_DEVICE_ID_TTI_HPT372:
-				/* 372N if rev >= 2 */
-				if (rev >= 2)
-					return -ENODEV;
-				ppi[0] = &info_hpt372;
-				chip_table = &hpt372a;
-				break;
-			case PCI_DEVICE_ID_TTI_HPT302:
-				/* 302N if rev > 1 */
-				if (rev > 1)
-					return -ENODEV;
-				ppi[0] = &info_hpt302;
-				/* Check this */
-				chip_table = &hpt302;
-				break;
-			case PCI_DEVICE_ID_TTI_HPT371:
-				if (rev > 1)
-					return -ENODEV;
-				ppi[0] = &info_hpt302;
-				chip_table = &hpt371;
-				/* Single channel device, master is not present
-				   but the BIOS (or us for non x86) must mark it
-				   absent */
-				pci_read_config_byte(dev, 0x50, &mcr1);
-				mcr1 &= ~0x04;
-				pci_write_config_byte(dev, 0x50, mcr1);
-				break;
-			case PCI_DEVICE_ID_TTI_HPT374:
-				chip_table = &hpt374;
-				if (!(PCI_FUNC(dev->devfn) & 1))
-					*ppi = &info_hpt374_fn0;
-				else
-					*ppi = &info_hpt374_fn1;
-				break;
-			default:
-				printk(KERN_ERR "pata_hpt37x: PCI table is bogus please report (%d).\n", dev->device);
+		switch (dev->device) {
+		case PCI_DEVICE_ID_TTI_HPT372:
+			/* 372N if rev >= 2 */
+			if (rev >= 2)
+				return -ENODEV;
+			ppi[0] = &info_hpt372;
+			chip_table = &hpt372a;
+			break;
+		case PCI_DEVICE_ID_TTI_HPT302:
+			/* 302N if rev > 1 */
+			if (rev > 1)
+				return -ENODEV;
+			ppi[0] = &info_hpt302;
+			/* Check this */
+			chip_table = &hpt302;
+			break;
+		case PCI_DEVICE_ID_TTI_HPT371:
+			if (rev > 1)
+				return -ENODEV;
+			ppi[0] = &info_hpt302;
+			chip_table = &hpt371;
+			/*
+			 * Single channel device, master is not present
+			 * but the BIOS (or us for non x86) must mark it
+			 * absent
+			 */
+			pci_read_config_byte(dev, 0x50, &mcr1);
+			mcr1 &= ~0x04;
+			pci_write_config_byte(dev, 0x50, mcr1);
+			break;
+		case PCI_DEVICE_ID_TTI_HPT374:
+			chip_table = &hpt374;
+			if (!(PCI_FUNC(dev->devfn) & 1))
+				*ppi = &info_hpt374_fn0;
+			else
+				*ppi = &info_hpt374_fn1;
+			break;
+		default:
+			printk(KERN_ERR
+			       "pata_hpt37x: PCI table is bogus, please report (%d).\n",
+			       dev->device);
 				return -ENODEV;
 		}
 	}
@@ -927,9 +939,11 @@ static int hpt37x_init_one(struct pci_de
 	if (chip_table == &hpt372a)
 		outb(0x0e, iobase + 0x9c);
 
-	/* Some devices do not let this value be accessed via PCI space
-	   according to the old driver. In addition we must use the value
-	   from FN 0 on the HPT374 */
+	/*
+	 * Some devices do not let this value be accessed via PCI space
+	 * according to the old driver. In addition we must use the value
+	 * from FN 0 on the HPT374.
+	 */
 
 	if (chip_table == &hpt374) {
 		freq = hpt374_read_freq(dev);
@@ -943,10 +957,11 @@ static int hpt37x_init_one(struct pci_de
 		u8 sr;
 		u32 total = 0;
 
-		printk(KERN_WARNING "pata_hpt37x: BIOS has not set timing clocks.\n");
+		printk(KERN_WARNING
+		       "pata_hpt37x: BIOS has not set timing clocks.\n");
 
 		/* This is the process the HPT371 BIOS is reported to use */
-		for(i = 0; i < 128; i++) {
+		for (i = 0; i < 128; i++) {
 			pci_read_config_byte(dev, 0x78, &sr);
 			total += sr & 0x1FF;
 			udelay(15);
@@ -981,17 +996,22 @@ static int hpt37x_init_one(struct pci_de
 
 		/* Select the DPLL clock. */
 		pci_write_config_byte(dev, 0x5b, 0x21);
-		pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low | 0x100);
+		pci_write_config_dword(dev, 0x5C,
+				       (f_high << 16) | f_low | 0x100);
 
-		for(adjust = 0; adjust < 8; adjust++) {
+		for (adjust = 0; adjust < 8; adjust++) {
 			if (hpt37x_calibrate_dpll(dev))
 				break;
-			/* See if it'll settle at a fractionally different clock */
+			/*
+			 * See if it'll settle at a fractionally
+			 * different clock
+			 */
 			if (adjust & 1)
 				f_low -= adjust >> 1;
 			else
 				f_high += adjust >> 1;
-			pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low | 0x100);
+			pci_write_config_dword(dev, 0x5C,
+					       (f_high << 16) | f_low | 0x100);
 		}
 		if (adjust == 8) {
 			printk(KERN_ERR "pata_hpt37x: DPLL did not stabilize!\n");
@@ -1010,7 +1030,7 @@ static int hpt37x_init_one(struct pci_de
 		 *	Perform a final fixup. Note that we will have used the
 		 *	DPLL on the HPT372 which means we don't have to worry
 		 *	about lack of UDMA133 support on lower clocks
- 		 */
+		 */
 
 		if (clock_slot < 2 && ppi[0] == &info_hpt370)
 			ppi[0] = &info_hpt370_33;
@@ -1035,9 +1055,9 @@ static const struct pci_device_id hpt37x
 };
 
 static struct pci_driver hpt37x_pci_driver = {
-	.name 		= DRV_NAME,
+	.name		= DRV_NAME,
 	.id_table	= hpt37x,
-	.probe 		= hpt37x_init_one,
+	.probe		= hpt37x_init_one,
 	.remove		= ata_pci_remove_one
 };
 
