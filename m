From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ide: make jmicron match vendor and device class
Date: Mon, 8 Oct 2007 11:21:39 +0900
Message-ID: <20071008022139.GE12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.185]:45234 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbXJHCVr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Oct 2007 22:21:47 -0400
Received: by rv-out-0910.google.com with SMTP id k20so636591rvb
        for <linux-ide@vger.kernel.org>; Sun, 07 Oct 2007 19:21:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, ethanhsiao@jmicron.com, justin@jmicron.com

PATA part of all current JMB controllers behave the same way and
JMicron confirms that all future ones will stay compatible.  Matching
vendor and device class is enough.

For backward compatibility, jmicron still needs to match 361,3,5,6,8
DIDs regardless of device class if libata is not configured but won't
need further DID update from this point.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Ethan Hsiao <ethanhsiao@jmicron.com>
Cc: Justin Tsai <justin@jmicron.com>
---
 drivers/ide/pci/jmicron.c |   65 +++++++++++++++++-----------------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

diff --git a/drivers/ide/pci/jmicron.c b/drivers/ide/pci/jmicron.c
index 65a0ff3..072d3ec 100644
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -160,22 +160,13 @@ fallback:
 	return;
 }
 
-#define DECLARE_JMB_DEV(name_str)			\
-	{						\
-		.name		= name_str,		\
-		.init_hwif	= init_hwif_jmicron,	\
-		.autodma	= AUTODMA,		\
-		.bootable	= ON_BOARD,		\
-		.enablebits	= { {0x40, 1, 1}, {0x40, 0x10, 0x10} }, \
-		.pio_mask	= ATA_PIO5,		\
-	}
-
-static ide_pci_device_t jmicron_chipsets[] __devinitdata = {
-	/* 0 */ DECLARE_JMB_DEV("JMB361"),
-	/* 1 */ DECLARE_JMB_DEV("JMB363"),
-	/* 2 */ DECLARE_JMB_DEV("JMB365"),
-	/* 3 */ DECLARE_JMB_DEV("JMB366"),
-	/* 4 */ DECLARE_JMB_DEV("JMB368"),
+static ide_pci_device_t jmicron_chipset __devinitdata = {
+		.name		= "JMB",
+		.init_hwif	= init_hwif_jmicron,
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
+		.enablebits	= { {0x40, 1, 1}, {0x40, 0x10, 0x10} },
+		.pio_mask	= ATA_PIO5,
 };
 
 /**
@@ -189,35 +180,29 @@ static ide_pci_device_t jmicron_chipsets[] __devinitdata = {
 
 static int __devinit jmicron_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_setup_pci_device(dev, &jmicron_chipsets[id->driver_data]);
+	ide_setup_pci_device(dev, &jmicron_chipset);
 	return 0;
 }
 
-/* If libata is configured, jmicron PCI quirk will configure it such
- * that the SATA ports are in AHCI function while the PATA ports are
- * in a separate IDE function.  In such cases, match device class and
- * attach only to IDE.  If libata isn't configured, keep the old
- * behavior for backward compatibility.
+/* All JMB PATA controllers have and will continue to have the same
+ * interface.  Matching vendor and device class is enough for all
+ * current and future controllers if the controller is programmed
+ * properly.
+ *
+ * If libata is configured, jmicron PCI quirk programs the controller
+ * into the correct mode.  If libata isn't configured, match known
+ * device IDs too to maintain backward compatibility.
  */
-#if defined(CONFIG_ATA) || defined(CONFIG_ATA_MODULE)
-#define JMB_CLASS	PCI_CLASS_STORAGE_IDE << 8
-#define JMB_CLASS_MASK	0xffff00
-#else
-#define JMB_CLASS	0
-#define JMB_CLASS_MASK	0
-#endif
-
 static struct pci_device_id jmicron_pci_tbl[] = {
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361,
-	  PCI_ANY_ID, PCI_ANY_ID, JMB_CLASS, JMB_CLASS_MASK, 0},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363,
-	  PCI_ANY_ID, PCI_ANY_ID, JMB_CLASS, JMB_CLASS_MASK, 1},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365,
-	  PCI_ANY_ID, PCI_ANY_ID, JMB_CLASS, JMB_CLASS_MASK, 2},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366,
-	  PCI_ANY_ID, PCI_ANY_ID, JMB_CLASS, JMB_CLASS_MASK, 3},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368,
-	  PCI_ANY_ID, PCI_ANY_ID, JMB_CLASS, JMB_CLASS_MASK, 4},
+#if !defined(CONFIG_ATA) && !defined(CONFIG_ATA_MODULE)
+	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB361) },
+	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB363) },
+	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB365) },
+	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB366) },
+	{ PCI_VDEVICE(JMICRON, PCI_DEVICE_ID_JMICRON_JMB368) },
+#endif
+	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_STORAGE_IDE << 8, 0xffff00, 0 },
 	{ 0, },
 };
 
