From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/1] ide: ide-generic, add another device exception
Date: Mon,  4 Jun 2007 11:20:51 +0200 (CEST)
Message-ID: <20601315171560711667@wsc.cz>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cacti.profiwh.com ([85.93.165.66]:41910 "EHLO smtp.wsc.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751486AbXFDJUw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Jun 2007 05:20:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Ingo Korb <ml@akana.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

ide-generic, add another device exception

This device is char device and is grabbed by generic ide driver:
00:0b.0 Class ffff: National Semiconductor Corporation 87410 IDE (rev ff) (prog-if ff)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-

Disallow generic driver to grab it by adding next condition. Also
consolidate exceptions to one bigger 'switch (dev->vendor)'.

Cc: Ingo Korb <ml@akana.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 879404085754892c27ff2d1c73d310582b872a98
tree abb7f3b7522c4076da230125afa9d34cbf48ff91
parent f6d5d1877b0f7ac82f5e1fec2ead0429eeb069c8
author Jiri Slaby <jirislaby@gmail.com> Mon, 04 Jun 2007 11:19:39 +0200
committer Jiri Slaby <jirislaby@gmail.com> Mon, 04 Jun 2007 11:19:39 +0200

 drivers/ide/pci/generic.c |   37 +++++++++++++++++++++++--------------
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
index f2c5a14..0d51a11 100644
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -198,32 +198,41 @@ static ide_pci_device_t generic_chipsets[] __devinitdata = {
 static int __devinit generic_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	ide_pci_device_t *d = &generic_chipsets[id->driver_data];
-	u16 command;
 	int ret = -ENODEV;
 
 	/* Don't use the generic entry unless instructed to do so */
 	if (id->driver_data == 0 && ide_generic_all == 0)
 			goto out;
 
-	if (dev->vendor == PCI_VENDOR_ID_UMC &&
-	    dev->device == PCI_DEVICE_ID_UMC_UM8886A &&
-	    (!(PCI_FUNC(dev->devfn) & 1)))
-		goto out; /* UM8886A/BF pair */
-
-	if (dev->vendor == PCI_VENDOR_ID_OPTI &&
-	    dev->device == PCI_DEVICE_ID_OPTI_82C558 &&
-	    (!(PCI_FUNC(dev->devfn) & 1)))
-		goto out;
-
-	if (dev->vendor == PCI_VENDOR_ID_JMICRON) {
-		if (dev->device != PCI_DEVICE_ID_JMICRON_JMB368 && PCI_FUNC(dev->devfn) != 1)
+	switch (dev->vendor) {
+	case PCI_VENDOR_ID_UMC:
+		if (dev->device == PCI_DEVICE_ID_UMC_UM8886A &&
+				!(PCI_FUNC(dev->devfn) & 1))
+			goto out; /* UM8886A/BF pair */
+		break;
+	case PCI_VENDOR_ID_OPTI:
+		if (dev->device == PCI_DEVICE_ID_OPTI_82C558 &&
+				!(PCI_FUNC(dev->devfn) & 1))
+			goto out;
+		break;
+	case PCI_VENDOR_ID_JMICRON:
+		if (dev->device != PCI_DEVICE_ID_JMICRON_JMB368 &&
+				PCI_FUNC(dev->devfn) != 1)
+			goto out;
+		break;
+	case PCI_VENDOR_ID_NS:
+		if (dev->device == PCI_DEVICE_ID_NS_87410 &&
+				(dev->class >> 8) != PCI_CLASS_STORAGE_IDE)
 			goto out;
+		break;
 	}
 
 	if (dev->vendor != PCI_VENDOR_ID_JMICRON) {
+		u16 command;
 		pci_read_config_word(dev, PCI_COMMAND, &command);
 		if (!(command & PCI_COMMAND_IO)) {
-			printk(KERN_INFO "Skipping disabled %s IDE controller.\n", d->name);
+			printk(KERN_INFO "Skipping disabled %s IDE "
+					"controller.\n", d->name);
 			goto out;
 		}
 	}
