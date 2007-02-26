From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] jmicron ATA: reimplement jmicron ATA quirk
Date: Mon, 26 Feb 2007 20:16:13 +0900
Message-ID: <20070226111613.GE20322@htj.dyndns.org>
References: <20070226110902.GD20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:16004 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbXBZLQR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Feb 2007 06:16:17 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1219944nze
        for <linux-ide@vger.kernel.org>; Mon, 26 Feb 2007 03:16:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070226110902.GD20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, justin@jmicron.com

Reimplement jmicron ATA quirk.

* renamed to quirk_jmicron_ata()
* quirk is invoked only for the affected controllers
* programming is stricter.  e.g. conf5 bit24 is cleared if
  unnecessary.
* code factored for readability
* JMB360 and JMB368 are programmed into proper mode

Verified on JMB360, 363 and 368.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/pci/quirks.c |   80 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 30 deletions(-)

Index: work/drivers/pci/quirks.c
===================================================================
--- work.orig/drivers/pci/quirks.c
+++ work/drivers/pci/quirks.c
@@ -1218,45 +1218,65 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_V
  *	do this early on to make the additional device appear during
  *	the PCI scanning.
  */
-
-static void quirk_jmicron_dualfn(struct pci_dev *pdev)
+static void quirk_jmicron_ata(struct pci_dev *pdev)
 {
-	u32 conf;
+	u32 conf1, conf5;
 	u8 hdr;
 
 	/* Only poke fn 0 */
 	if (PCI_FUNC(pdev->devfn))
 		return;
 
-	switch(pdev->device) {
-		case PCI_DEVICE_ID_JMICRON_JMB365:
-		case PCI_DEVICE_ID_JMICRON_JMB366:
-			/* Redirect IDE second PATA port to the right spot */
-			pci_read_config_dword(pdev, 0x80, &conf);
-			conf |= (1 << 24);
-			/* Fall through */
-			pci_write_config_dword(pdev, 0x80, conf);
-		case PCI_DEVICE_ID_JMICRON_JMB361:
-		case PCI_DEVICE_ID_JMICRON_JMB363:
-			pci_read_config_dword(pdev, 0x40, &conf);
-			/* Enable dual function mode, AHCI on fn 0, IDE fn1 */
-			/* Set the class codes correctly and then direct IDE 0 */
-			conf &= ~0x000FF200; /* Clear bit 9 and 12-19 */
-			conf |=  0x00C2A102; /* Set 1, 8, 13, 15, 17, 22, 23 */
-			pci_write_config_dword(pdev, 0x40, conf);
-
-			/* Reconfigure so that the PCI scanner discovers the
-			   device is now multifunction */
-
-			pci_read_config_byte(pdev, PCI_HEADER_TYPE, &hdr);
-			pdev->hdr_type = hdr & 0x7f;
-			pdev->multifunction = !!(hdr & 0x80);
+	pci_read_config_dword(pdev, 0x40, &conf1);
+	pci_read_config_dword(pdev, 0x80, &conf5);
+
+	conf1 &= ~0x00CFF302; /* Clear bit 1, 8, 9, 12-19, 22, 23 */
+	conf5 &= ~(1 << 24);  /* Clear bit 24 */
+
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_JMICRON_JMB360:
+		/* The controller should be in single function ahci mode */
+		conf1 |= 0x0002A100; /* Set 8, 13, 15, 17 */
+		break;
 
-			break;
+	case PCI_DEVICE_ID_JMICRON_JMB365:
+	case PCI_DEVICE_ID_JMICRON_JMB366:
+		/* Redirect IDE second PATA port to the right spot */
+		conf5 |= (1 << 24);
+		/* Fall through */
+	case PCI_DEVICE_ID_JMICRON_JMB361:
+	case PCI_DEVICE_ID_JMICRON_JMB363:
+		/* Enable dual function mode, AHCI on fn 0, IDE fn1 */
+		/* Set the class codes correctly and then direct IDE 0 */
+		conf1 |= 0x00C2A102; /* Set 1, 8, 13, 15, 17, 22, 23 */
+		break;
+
+	case PCI_DEVICE_ID_JMICRON_JMB368:
+		/* The controller should be in single function IDE mode */
+		conf1 |= 0x00C00000; /* Set 22, 23 */
+		break;
 	}
-}
-DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, quirk_jmicron_dualfn);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, quirk_jmicron_dualfn);
+
+	pci_write_config_dword(pdev, 0x40, conf1);
+	pci_write_config_dword(pdev, 0x80, conf5);
+
+	/* Update pdev accordingly */
+	pci_read_config_byte(pdev, PCI_HEADER_TYPE, &hdr);
+	pdev->hdr_type = hdr & 0x7f;
+	pdev->multifunction = !!(hdr & 0x80);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB360, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB360, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, quirk_jmicron_ata);
 
 #endif
 
