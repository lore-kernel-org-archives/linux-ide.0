From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream-fixes] ahci/pata_jmicron: fix JMicron quirk
Date: Fri, 2 Feb 2007 14:51:09 +0900
Message-ID: <20070202055109.GM8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:42590 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423119AbXBBFvZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 00:51:25 -0500
Received: by nz-out-0506.google.com with SMTP id s1so770420nze
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 21:51:22 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, justin@jmicron.com

For all JMicrons except for 361 and 368, AHCI mode enable bits in the
Control(1) should be set.  This used to be done in both ahci and
pata_jmicron but while moving programming to PCI quirk, it was removed
from ahci part while still left in pata_jmicron.

The implemented JMicron PCI quirk was incorrect in that it didn't
program AHCI mode enable bits.  If pata_jmicron is loaded first and
programs those bits, the ahci ports work; otherwise, ahci device
detection fails miserably.

This patch makes JMicron PCI quirk clear SATA IDE mode bits and set
AHCI mode bits and remove the respective part from pata_jmicron.
Tested on JMB361, 363 and 368.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, gotta be included in 2.6.20.
Justin, is this the problem you were seeing on suse?

diff --git a/drivers/ata/pata_jmicron.c b/drivers/ata/pata_jmicron.c
index 2d406a7..26365c1 100644
--- a/drivers/ata/pata_jmicron.c
+++ b/drivers/ata/pata_jmicron.c
@@ -202,20 +202,12 @@ static int jmicron_init_one (struct pci_dev *pdev, const struct pci_device_id *i
 
 	u32 reg;
 
-	if (id->driver_data != 368) {
-		/* Put the controller into AHCI mode in case the AHCI driver
-		   has not yet been loaded. This can be done with either
-		   function present */
+	/* PATA controller is fn 1, AHCI is fn 0 */
+	if (id->driver_data != 368 && PCI_FUNC(pdev->devfn) != 1)
+		return -ENODEV;
 
-		/* FIXME: We may want a way to override this in future */
-		pci_write_config_byte(pdev, 0x41, 0xa1);
-
-		/* PATA controller is fn 1, AHCI is fn 0 */
-		if (PCI_FUNC(pdev->devfn) != 1)
-			return -ENODEV;
-	}
-	if ( id->driver_data == 365 || id->driver_data == 366) {
-		/* The 365/66 have two PATA channels, redirect the second */
+	/* The 365/66 have two PATA channels, redirect the second */
+	if (id->driver_data == 365 || id->driver_data == 366) {
 		pci_read_config_dword(pdev, 0x80, &reg);
 		reg |= (1 << 24);	/* IDE1 to PATA IDE secondary */
 		pci_write_config_dword(pdev, 0x80, reg);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5c34379..6f3e1bf 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1260,8 +1260,8 @@ static void quirk_jmicron_dualfn(struct pci_dev *pdev)
 			pci_read_config_dword(pdev, 0x40, &conf);
 			/* Enable dual function mode, AHCI on fn 0, IDE fn1 */
 			/* Set the class codes correctly and then direct IDE 0 */
-			conf &= ~0x000F0200;	/* Clear bit 9 and 16-19 */
-			conf |=  0x00C20002;	/* Set bit 1, 17, 22, 23 */
+			conf &= ~0x000FF200; /* Clear bit 9 and 12-19 */
+			conf |=  0x00C2A102; /* Set 1, 8, 13, 15, 17, 22, 23 */
 			pci_write_config_dword(pdev, 0x40, conf);
 
 			/* Reconfigure so that the PCI scanner discovers the
