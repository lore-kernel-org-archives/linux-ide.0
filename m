From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ata: use pci_dev->revision
Date: Tue, 24 Nov 2009 22:54:49 +0400
Message-ID: <200911242154.49540.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:29561 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S933857AbZKXSx7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Nov 2009 13:53:59 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Some places were using PCI_CLASS_REVISION instead of PCI_REVISION_ID, so
they weren't converted by commit 44c10138fd4bbc4b6d6bff0873c24902f2a9da65
(PCI: Change all drivers to use pci_device->revision).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_cmd64x.c  |    9 ++-------
 drivers/ata/pata_hpt366.c  |    8 ++------
 drivers/ata/pata_hpt37x.c  |   21 +++++++++------------
 drivers/ata/pata_hpt3x2n.c |   15 +++++----------
 drivers/ata/pata_sil680.c  |    6 ++----
 5 files changed, 20 insertions(+), 39 deletions(-)

Index: linux-2.6/drivers/ata/pata_cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_cmd64x.c
+++ linux-2.6/drivers/ata/pata_cmd64x.c
@@ -294,8 +294,6 @@ static struct ata_port_operations cmd648
 
 static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	u32 class_rev;
-
 	static const struct ata_port_info cmd_info[6] = {
 		{	/* CMD 643 - no UDMA */
 			.flags = ATA_FLAG_SLAVE_POSS,
@@ -345,18 +343,15 @@ static int cmd64x_init_one(struct pci_de
 	if (rc)
 		return rc;
 
-	pci_read_config_dword(pdev, PCI_CLASS_REVISION, &class_rev);
-	class_rev &= 0xFF;
-
 	if (id->driver_data == 0)	/* 643 */
 		ata_pci_bmdma_clear_simplex(pdev);
 
 	if (pdev->device == PCI_DEVICE_ID_CMD_646) {
 		/* Does UDMA work ? */
-		if (class_rev > 4)
+		if (pdev->revision > 4)
 			ppi[0] = &cmd_info[2];
 		/* Early rev with other problems ? */
-		else if (class_rev == 1)
+		else if (pdev->revision == 1)
 			ppi[0] = &cmd_info[3];
 	}
 
Index: linux-2.6/drivers/ata/pata_hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt366.c
+++ linux-2.6/drivers/ata/pata_hpt366.c
@@ -344,7 +344,6 @@ static int hpt36x_init_one(struct pci_de
 	const struct ata_port_info *ppi[] = { &info_hpt366, NULL };
 
 	void *hpriv = NULL;
-	u32 class_rev;
 	u32 reg1;
 	int rc;
 
@@ -352,13 +351,10 @@ static int hpt36x_init_one(struct pci_de
 	if (rc)
 		return rc;
 
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
-	class_rev &= 0xFF;
-
 	/* May be a later chip in disguise. Check */
 	/* Newer chips are not in the HPT36x driver. Ignore them */
-	if (class_rev > 2)
-			return -ENODEV;
+	if (dev->revision > 2)
+		return -ENODEV;
 
 	hpt36x_init_chipset(dev);
 
Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -790,9 +790,8 @@ static int hpt37x_init_one(struct pci_de
 	static const int MHz[4] = { 33, 40, 50, 66 };
 	void *private_data = NULL;
 	const struct ata_port_info *ppi[] = { NULL, NULL };
-
+	u8 rev = dev->revision;
 	u8 irqmask;
-	u32 class_rev;
 	u8 mcr1;
 	u32 freq;
 	int prefer_dpll = 1;
@@ -807,19 +806,16 @@ static int hpt37x_init_one(struct pci_de
 	if (rc)
 		return rc;
 
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
-	class_rev &= 0xFF;
-
 	if (dev->device == PCI_DEVICE_ID_TTI_HPT366) {
 		/* May be a later chip in disguise. Check */
 		/* Older chips are in the HPT366 driver. Ignore them */
-		if (class_rev < 3)
+		if (rev < 3)
 			return -ENODEV;
 		/* N series chips have their own driver. Ignore */
-		if (class_rev == 6)
+		if (rev == 6)
 			return -ENODEV;
 
-		switch(class_rev) {
+		switch(rev) {
 			case 3:
 				ppi[0] = &info_hpt370;
 				chip_table = &hpt370;
@@ -835,28 +831,29 @@ static int hpt37x_init_one(struct pci_de
 				chip_table = &hpt372;
 				break;
 			default:
-				printk(KERN_ERR "pata_hpt37x: Unknown HPT366 subtype please report (%d).\n", class_rev);
+				printk(KERN_ERR "pata_hpt37x: Unknown HPT366 "
+				       "subtype, please report (%d).\n", rev);
 				return -ENODEV;
 		}
 	} else {
 		switch(dev->device) {
 			case PCI_DEVICE_ID_TTI_HPT372:
 				/* 372N if rev >= 2*/
-				if (class_rev >= 2)
+				if (rev >= 2)
 					return -ENODEV;
 				ppi[0] = &info_hpt372;
 				chip_table = &hpt372a;
 				break;
 			case PCI_DEVICE_ID_TTI_HPT302:
 				/* 302N if rev > 1 */
-				if (class_rev > 1)
+				if (rev > 1)
 					return -ENODEV;
 				ppi[0] = &info_hpt372;
 				/* Check this */
 				chip_table = &hpt302;
 				break;
 			case PCI_DEVICE_ID_TTI_HPT371:
-				if (class_rev > 1)
+				if (rev > 1)
 					return -ENODEV;
 				ppi[0] = &info_hpt372;
 				chip_table = &hpt371;
Index: linux-2.6/drivers/ata/pata_hpt3x2n.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt3x2n.c
+++ linux-2.6/drivers/ata/pata_hpt3x2n.c
@@ -446,10 +446,8 @@ static int hpt3x2n_init_one(struct pci_d
 		.port_ops = &hpt3x2n_port_ops
 	};
 	const struct ata_port_info *ppi[] = { &info, NULL };
-
+	u8 rev = dev->revision;
 	u8 irqmask;
-	u32 class_rev;
-
 	unsigned int pci_mhz;
 	unsigned int f_low, f_high;
 	int adjust;
@@ -461,26 +459,23 @@ static int hpt3x2n_init_one(struct pci_d
 	if (rc)
 		return rc;
 
-	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
-	class_rev &= 0xFF;
-
 	switch(dev->device) {
 		case PCI_DEVICE_ID_TTI_HPT366:
-			if (class_rev < 6)
+			if (rev < 6)
 				return -ENODEV;
 			break;
 		case PCI_DEVICE_ID_TTI_HPT371:
-			if (class_rev < 2)
+			if (rev < 2)
 				return -ENODEV;
 			/* 371N if rev > 1 */
 			break;
 		case PCI_DEVICE_ID_TTI_HPT372:
 			/* 372N if rev >= 2*/
-			if (class_rev < 2)
+			if (rev < 2)
 				return -ENODEV;
 			break;
 		case PCI_DEVICE_ID_TTI_HPT302:
-			if (class_rev < 2)
+			if (rev < 2)
 				return -ENODEV;
 			break;
 		case PCI_DEVICE_ID_TTI_HPT372N:
Index: linux-2.6/drivers/ata/pata_sil680.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_sil680.c
+++ linux-2.6/drivers/ata/pata_sil680.c
@@ -212,13 +212,11 @@ static struct ata_port_operations sil680
 
 static u8 sil680_init_chip(struct pci_dev *pdev, int *try_mmio)
 {
-	u32 class_rev	= 0;
 	u8 tmpbyte	= 0;
 
-        pci_read_config_dword(pdev, PCI_CLASS_REVISION, &class_rev);
-        class_rev &= 0xff;
         /* FIXME: double check */
-	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, (class_rev) ? 1 : 255);
+	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE,
+			      pdev->revision ? 1 : 255);
 
 	pci_write_config_byte(pdev, 0x80, 0x00);
 	pci_write_config_byte(pdev, 0x84, 0x00);

