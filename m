From: Mark Nelson <mdnelson8@gmail.com>
Subject: [PATCH] ahci: let users know that Promise PDC42819 support is limited
	to SATA devices
Date: Sun, 22 Nov 2009 12:07:41 +1100
Message-ID: <65a6ef750911211707m3cece36fsc464e8e5d9273782@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60728 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbZKVBHh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Nov 2009 20:07:37 -0500
Received: by ewy19 with SMTP id 19so773958ewy.21
        for <linux-ide@vger.kernel.org>; Sat, 21 Nov 2009 17:07:42 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

ahci can drive the Promise PDC42819, but obviously it can only use SATA
disks connected to this controller. The controller can actually support
SAS disks as well, but we only know how to use it in it's AHCI mode.

Add a message to let users know that because ahci is driving their chip
they can only use the SATA disks connected to this controller.

Signed-off-by: Mark Nelson <mdnelson8@gmail.com>
---
 drivers/ata/ahci.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6/drivers/ata/ahci.c
===================================================================
--- linux-2.6.orig/drivers/ata/ahci.c
+++ linux-2.6/drivers/ata/ahci.c
@@ -2988,6 +2988,14 @@ static int ahci_init_one(struct pci_dev
 	if (pdev->vendor == PCI_VENDOR_ID_MARVELL && !marvell_enable)
 		return -ENODEV;

+	/* Promise's PDC42819 is a SAS/SATA controller that has an AHCI mode.
+	 * At the moment, we can only use the AHCI mode. Let the users know
+	 * that for SAS drives they're out of luck.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_PROMISE)
+		dev_printk(KERN_INFO, &pdev->dev, "PDC42819 "
+			   "can only drive SATA devices with this driver\n");
+
 	/* acquire resources */
 	rc = pcim_enable_device(pdev);
 	if (rc)
