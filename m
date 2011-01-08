From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH v2] pata_hpt366: coding style cleanup
Date: Sat, 8 Jan 2011 18:49:29 +0300
Message-ID: <201101081849.29384.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:36910 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753012Ab1AHPuu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2011 10:50:50 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Fix 2 errors and 11 warnings given by checkpatch.pl:

- *switch* and *case* not on the same indentation level;

- no space between *switch* and open parenthesis;

- drive blacklist arrays not being *const*;

- spaces before tabs;

- lines over 80 characters.

In addition to these changes, also add new line after variable definition in
hpt36x_init_chipset()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

Changes from the previous version:
- fixed one case of a line over 80 chars that checkpatch.pl didn't report.

 drivers/ata/pata_hpt366.c |   54 ++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt366.c
+++ linux-2.6/drivers/ata/pata_hpt366.c
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt366"
-#define DRV_VERSION	"0.6.8"
+#define DRV_VERSION	"0.6.9"
 
 struct hpt_clock {
 	u8	xfer_mode;
@@ -110,18 +110,23 @@ static const struct hpt_clock hpt366_25[
 	{	0,		0x01208585	}
 };
 
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
 
-static const char *bad_ata66_4[] = {
+static const char * const bad_ata66_4[] = {
 	"IBM-DTLA-307075",
 	"IBM-DTLA-307060",
 	"IBM-DTLA-307045",
@@ -140,12 +145,13 @@ static const char *bad_ata66_4[] = {
 	NULL
 };
 
-static const char *bad_ata66_3[] = {
+static const char * const bad_ata66_3[] = {
 	"WDC AC310200R",
 	NULL
 };
 
-static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr, const char *list[])
+static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr,
+			       const char * const list[])
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	int i = 0;
@@ -154,7 +160,8 @@ static int hpt_dma_blacklisted(const str
 
 	while (list[i] != NULL) {
 		if (!strcmp(list[i], model_num)) {
-			printk(KERN_WARNING DRV_NAME ": %s is not supported for %s.\n",
+			printk(KERN_WARNING DRV_NAME
+				": %s is not supported for %s.\n",
 				modestr, list[i]);
 			return 1;
 		}
@@ -288,6 +295,7 @@ static struct ata_port_operations hpt366
 static void hpt36x_init_chipset(struct pci_dev *dev)
 {
 	u8 drive_fast;
+
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x78);
 	pci_write_config_byte(dev, PCI_MIN_GNT, 0x08);
@@ -349,16 +357,16 @@ static int hpt36x_init_one(struct pci_de
 
 	/* PCI clocking determines the ATA timing values to use */
 	/* info_hpt366 is safe against re-entry so we can scribble on it */
-	switch((reg1 & 0x700) >> 8) {
-		case 9:
-			hpriv = &hpt366_40;
-			break;
-		case 5:
-			hpriv = &hpt366_25;
-			break;
-		default:
-			hpriv = &hpt366_33;
-			break;
+	switch ((reg1 & 0x700) >> 8) {
+	case 9:
+		hpriv = &hpt366_40;
+		break;
+	case 5:
+		hpriv = &hpt366_25;
+		break;
+	default:
+		hpriv = &hpt366_33;
+		break;
 	}
 	/* Now kick off ATA set up */
 	return ata_pci_bmdma_init_one(dev, ppi, &hpt36x_sht, hpriv, 0);
@@ -385,9 +393,9 @@ static const struct pci_device_id hpt36x
 };
 
 static struct pci_driver hpt36x_pci_driver = {
-	.name 		= DRV_NAME,
+	.name		= DRV_NAME,
 	.id_table	= hpt36x,
-	.probe 		= hpt36x_init_one,
+	.probe		= hpt36x_init_one,
 	.remove		= ata_pci_remove_one,
 #ifdef CONFIG_PM
 	.suspend	= ata_pci_device_suspend,
