From: celestar@t-online.de (Frank Victor Fischer)
Subject: VIA VT6410 chipset patch
Date: Tue, 11 May 2004 15:50:11 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405111550.11303.celestar@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout11.sul.t-online.com ([194.25.134.85]:53947 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264692AbUEKNuU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 May 2004 09:50:20 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hey there,

I have an ASUS P4P Mainboard with a VIA VT6410 IDE RAID controller onboard, so 
I have taken a 2.4 patch that existed, and adopted it a little for the 2.6
( works with .4, .5, .6) source tree, for people who are not too found of 
VIA's binary drivers (which are hassleful to install) and don't need the RAID 
functionality anyway.

Would it make any sense to include it in the kernel tree?

Victor

Note: -l switch needed most likely.

--- linux/drivers/ide/pci/generic.h     Mon Aug 25 13:44:41 2003
+++ linux-2.4.22.2/drivers/ide/pci/generic.h    Mon Sep 22 20:36:26 2003
@@ -129,6 +129,18 @@
                .enablebits     = {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
                .bootable       = OFF_BOARD,
                .extra          = 0,
+       },{     /* 10 */
+               .vendor         = PCI_VENDOR_ID_VIA,
+               .device         = PCI_DEVICE_ID_VIA_610,
+               .name           = "VIA_610",
+               .init_chipset   = init_chipset_generic,
+               .init_iops      = NULL,
+               .init_hwif      = init_hwif_generic,
+               .channels       = 2,
+               .autodma        = AUTODMA,
+               .enablebits     = {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
+               .bootable       = ON_BOARD,
+               .extra          = 0,
        },{
                .vendor         = 0,
                .device         = 0,
--- linux/drivers/ide/pci/generic.c     Mon Aug 25 13:44:41 2003
+++ linux-2.4.22.2/drivers/ide/pci/generic.c    Mon Sep 22 20:42:48 2003
@@ -65,6 +65,8 @@
        hwif->ultra_mask = 0x7f;
        hwif->mwdma_mask = 0x07;
        hwif->swdma_mask = 0x07;
+        if (hwif->pci_dev->device == PCI_DEVICE_ID_VIA_610)
+            hwif->udma_four = 1; /* mj */

        if (!noautodma)
                hwif->autodma = 1;
@@ -132,5 +132,6 @@
        { PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_82C561,          PCI_ANY_ID, 
PCI_ANY_ID, 0, 0, 7},
        { PCI_VENDOR_ID_OPTI,   PCI_DEVICE_ID_OPTI_82C558,         PCI_ANY_ID, 
PCI_ANY_ID, 0, 0, 8},
        { PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_8237_SATA,       PCI_ANY_ID, 
PCI_ANY_ID, 0, 0, 9},
+        { PCI_VENDOR_ID_VIA,    PCI_DEVICE_ID_VIA_610,             
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 10},
        { 0, },
 };
--- linux/include/linux/pci_ids.h       Mon Aug 25 13:44:44 2003
+++ linux-2.4.22.2/include/linux/pci_ids.h      Mon Sep 22 20:36:13 2003
@@ -1205,6 +1205,7 @@
 #define PCI_DEVICE_ID_VIA_8703_51_0     0x3148
 #define PCI_DEVICE_ID_VIA_8237_SATA     0x3149
 #define PCI_DEVICE_ID_VIA_XN266         0x3156
+#define PCI_DEVICE_ID_VIA_610          0x3164
 #define PCI_DEVICE_ID_VIA_8754C_0       0x3168
 #define PCI_DEVICE_ID_VIA_8235          0x3177
 #define PCI_DEVICE_ID_VIA_P4N333        0x3178

