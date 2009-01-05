From: Brandon Philips <brandon@ifup.org>
Subject: it821x: Add ultra_mask quirk for Vortex86SX
Date: Mon, 5 Jan 2009 08:58:11 -0800
Message-ID: <20090105165811.GF29255@jenkins.ifup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:43536 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbZAEQ6R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 11:58:17 -0500
Received: by wf-out-1314.google.com with SMTP id 27so7668347wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2009 08:58:15 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, Shawn Lin <shawn@dmp.com.tw>

On Vortex86SX with IDE controller revision 0x11 ultra DMA must be
disabled. This patch was tested by DMP and seems to work.

It is a cleaned up version of their older Kernel patch: 
 http://www.dmp.com.tw/tech/vortex86sx/patch-2.6.24-DMP.gz

Tested-by: Shawn Lin <shawn@dmp.com.tw>
Signed-off-by: Brandon Philips <bphilips@suse.de>

---
 drivers/ide/it821x.c    |   13 +++++++++++++
 include/linux/pci_ids.h |    1 +
 2 files changed, 14 insertions(+)

Index: linux-2.6/drivers/ide/it821x.c
===================================================================
--- linux-2.6.orig/drivers/ide/it821x.c
+++ linux-2.6/drivers/ide/it821x.c
@@ -68,6 +68,8 @@
 
 #define DRV_NAME "it821x"
 
+#define QUIRK_VORTEX86 1
+
 struct it821x_dev
 {
 	unsigned int smart:1,		/* Are we in smart raid mode */
@@ -79,6 +81,7 @@ struct it821x_dev
 	u16	pio[2];			/* Cached PIO values */
 	u16	mwdma[2];		/* Cached MWDMA values */
 	u16	udma[2];		/* Cached UDMA values (per drive) */
+	u16	quirks;
 };
 
 #define ATA_66		0
@@ -580,6 +583,13 @@ static void __devinit init_hwif_it821x(i
 
 	hwif->ultra_mask = ATA_UDMA6;
 	hwif->mwdma_mask = ATA_MWDMA2;
+
+	/* Vortex86SX quirk: prevent Ultra-DMA mode to fix BadCRC issue */
+	if (idev->quirks & QUIRK_VORTEX86) {
+		pci_read_config_byte(dev, 0x08, &conf);
+		if (conf == 0x11)
+			hwif->ultra_mask = 0;
+	}
 }
 
 static void it8212_disable_raid(struct pci_dev *dev)
@@ -652,6 +662,8 @@ static int __devinit it821x_init_one(str
 		return -ENOMEM;
 	}
 
+	itdevs->quirks = id->driver_data;
+
 	rc = ide_pci_init_one(dev, &it821x_chipset, itdevs);
 	if (rc)
 		kfree(itdevs);
@@ -671,6 +683,7 @@ static void __devexit it821x_remove(stru
 static const struct pci_device_id it821x_pci_tbl[] = {
 	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8211), 0 },
 	{ PCI_VDEVICE(ITE, PCI_DEVICE_ID_ITE_8212), 0 },
+	{ PCI_VDEVICE(RDC, PCI_DEVICE_ID_RDC_D1010), QUIRK_VORTEX86 },
 	{ 0, },
 };
 
Index: linux-2.6/include/linux/pci_ids.h
===================================================================
--- linux-2.6.orig/include/linux/pci_ids.h
+++ linux-2.6/include/linux/pci_ids.h
@@ -2173,6 +2173,7 @@
 #define PCI_DEVICE_ID_RDC_R6040		0x6040
 #define PCI_DEVICE_ID_RDC_R6060		0x6060
 #define PCI_DEVICE_ID_RDC_R6061		0x6061
+#define PCI_DEVICE_ID_RDC_D1010		0x1010
 
 #define PCI_VENDOR_ID_LENOVO		0x17aa
 
