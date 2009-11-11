From: Mark Nelson <mdnelson8@gmail.com>
Subject: [PATCH] ahci: add parameter to disable ahci driver on Promise
	PDC42819
Date: Wed, 11 Nov 2009 20:54:34 +1100
Message-ID: <65a6ef750911110154h4eff3b9cp4f5259f37834ea7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:45096 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512AbZKKJy3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Nov 2009 04:54:29 -0500
Received: by ey-out-2122.google.com with SMTP id 9so199356eyd.5
        for <linux-ide@vger.kernel.org>; Wed, 11 Nov 2009 01:54:34 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

ahci can drive the Promise PDC42819, but obviously it can only use SATA
disks connected to this controller. The controller can actually support
SAS disks as well, but at the moment only with Promise's own binary
t3sas driver.

To allow users to use both the ahci and the t3sas drivers in the same
system (with t3sas controlling the PDC42819) we add a parameter,
promise_enable that can be used to disable ahci on the Promise chip (by
setting it to 0). This way even if the ahci driver is loaded first the
t3sas driver can grab the Promise chip and the user's SAS disks will be
operational.

By default the parameter is 1 so ahci drives the controller.

While we're at it, add a message letting users know that with ahci
driving their Promise chip they won't be able to use their SAS disks.

Signed-off-by: Mark Nelson <mdnelson8@gmail.com>
---
 drivers/ata/ahci.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

Index: linux-2.6/drivers/ata/ahci.c
===================================================================
--- linux-2.6.orig/drivers/ata/ahci.c
+++ linux-2.6/drivers/ata/ahci.c
@@ -700,6 +700,9 @@ static int marvell_enable = 1;
 module_param(marvell_enable, int, 0644);
 MODULE_PARM_DESC(marvell_enable, "Marvell SATA via AHCI (1 = enabled)");

+static int promise_enable = 1;
+module_param(promise_enable, int, 0644);
+MODULE_PARM_DESC(promise_enable, "Promise PDC42819 via AHCI (1 = enabled)");

 static inline int ahci_nr_ports(u32 cap)
 {
@@ -2988,6 +2991,26 @@ static int ahci_init_one(struct pci_dev
 	if (pdev->vendor == PCI_VENDOR_ID_MARVELL && !marvell_enable)
 		return -ENODEV;

+	/* Promise's PDC42819 is a SAS/SATA controller that has an AHCI mode.
+	 * At the moment, Promise's t3sas driver is required for SAS
+	 * functionality. Disable ahci on this device if the user asked for
+	 * it.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_PROMISE) {
+		if (promise_enable) {
+			dev_printk(KERN_INFO, &pdev->dev, "Promise PDC42819 "
+							  "support enabled\n");
+			dev_printk(KERN_INFO, &pdev->dev, "Only SATA devices "
+							  "will function with"
+							  " this driver\n");
+
+		} else {
+			dev_printk(KERN_INFO, &pdev->dev, "Promise PDC42819 "
+							  "support disabled\n");
+			return -ENODEV;
+		}
+	}
+
 	/* acquire resources */
 	rc = pcim_enable_device(pdev);
 	if (rc)
