From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/3] ahci/pata_jmicron: match class not function number
Date: Mon, 26 Feb 2007 20:24:03 +0900
Message-ID: <20070226112403.GF20322@htj.dyndns.org>
References: <20070226110902.GD20322@htj.dyndns.org> <20070226111613.GE20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:18725 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932813AbXBZLYN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Feb 2007 06:24:13 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1221506nze
        for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2007 03:24:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070226111613.GE20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, justin@jmicron.com

Make jmiron_ata quirk update pdev->class after programming the device
and update ahci and pata_jmicron such that they match class code
instead of checking function number manually.  For ahci, it matches
for vendor and class.  For pata_jmicron, it matches vendor, device and
class as IDE class isn't as well defined as AHCI class.

This makes jmicron device matching more conventional and script
friendly.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c         |   16 +++-------------
 drivers/ata/pata_jmicron.c |   19 ++++++++++---------
 drivers/pci/quirks.c       |    5 ++++-
 3 files changed, 17 insertions(+), 23 deletions(-)

Index: work/drivers/pci/quirks.c
===================================================================
--- work.orig/drivers/pci/quirks.c
+++ work/drivers/pci/quirks.c
@@ -1220,7 +1220,7 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_V
  */
 static void quirk_jmicron_ata(struct pci_dev *pdev)
 {
-	u32 conf1, conf5;
+	u32 conf1, conf5, class;
 	u8 hdr;
 
 	/* Only poke fn 0 */
@@ -1264,6 +1264,9 @@ static void quirk_jmicron_ata(struct pci
 	pci_read_config_byte(pdev, PCI_HEADER_TYPE, &hdr);
 	pdev->hdr_type = hdr & 0x7f;
 	pdev->multifunction = !!(hdr & 0x80);
+
+	pci_read_config_dword(pdev, PCI_CLASS_REVISION, &class);
+	pdev->class = class >> 8;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB360, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, quirk_jmicron_ata);
Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -385,12 +385,9 @@ static const struct pci_device_id ahci_p
 	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci_pi }, /* ICH9 */
 	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_pi }, /* ICH9M */
 
-	/* JMicron */
-	{ PCI_VDEVICE(JMICRON, 0x2360), board_ahci_ign_iferr }, /* JMB360 */
-	{ PCI_VDEVICE(JMICRON, 0x2361), board_ahci_ign_iferr }, /* JMB361 */
-	{ PCI_VDEVICE(JMICRON, 0x2363), board_ahci_ign_iferr }, /* JMB363 */
-	{ PCI_VDEVICE(JMICRON, 0x2365), board_ahci_ign_iferr }, /* JMB365 */
-	{ PCI_VDEVICE(JMICRON, 0x2366), board_ahci_ign_iferr }, /* JMB366 */
+	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
+	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci_ign_iferr },
 
 	/* ATI */
 	{ PCI_VDEVICE(ATI, 0x4380), board_ahci }, /* ATI SB600 non-raid */
@@ -1665,13 +1662,6 @@ static int ahci_init_one(struct pci_dev 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
-	if (pdev->vendor == PCI_VENDOR_ID_JMICRON) {
-		/* Function 1 is the PATA controller except on the 368, where
-		   we are not AHCI anyway */
-		if (PCI_FUNC(pdev->devfn))
-			return -ENODEV;
-	}
-
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
Index: work/drivers/ata/pata_jmicron.c
===================================================================
--- work.orig/drivers/ata/pata_jmicron.c
+++ work/drivers/ata/pata_jmicron.c
@@ -202,19 +202,20 @@ static int jmicron_init_one (struct pci_
 	};
 	struct ata_port_info *port_info[2] = { &info, &info };
 
-	/* PATA controller is fn 1, AHCI is fn 0 */
-	if (id->driver_data != 368 && PCI_FUNC(pdev->devfn) != 1)
-		return -ENODEV;
-
 	return ata_pci_init_one(pdev, port_info, 2);
 }
 
 static const struct pci_device_id jmicron_pci_tbl[] = {
-	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB361), 361},
-	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB363), 363},
-	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB365), 365},
-	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB366), 366},
-	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB368), 368},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 361 },
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 363 },
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 365 },
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 366 },
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368,
+	  PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 368 },
 
 	{ }	/* terminate list */
 };
