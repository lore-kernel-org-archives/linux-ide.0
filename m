From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] jmicron: make ide jmicron driver play nice with libata ones
Date: Fri, 16 Mar 2007 15:06:10 +0900
Message-ID: <20070316060610.GA6152@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:56972 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbXCPGGP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 02:06:15 -0400
Received: by nz-out-0506.google.com with SMTP id s1so177898nze
        for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 23:06:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org, justin@jmicron.com

When libata is configured, the device is configured such that SATA and
PATA ports live in separate functions with different programming
interfaces.  pata_jmicron and ide jmicron drivers can drive only the
PATA part.

This patch makes jmicron match PCI class code such that it doesn't
attach itself to the SATA part preventing the proper ahci driver from
attaching.

This change is suggested by Bartlomiej.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff --git a/drivers/ide/pci/jmicron.c b/drivers/ide/pci/jmicron.c
index 53f2550..be4fc96 100644
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -240,12 +240,31 @@ static int __devinit jmicron_init_one(struct pci_dev *dev, const struct pci_devi
 	return 0;
 }
 
+/* If libata is configured, jmicron PCI quirk will configure it such
+ * that the SATA ports are in AHCI function while the PATA ports are
+ * in a separate IDE function.  In such cases, match device class and
+ * attach only to IDE.  If libata isn't configured, keep the old
+ * behavior for backward compatibility.
+ */
+#if defined(CONFIG_ATA) || defined(CONFIG_ATA_MODULE)
+#define JMB_CLASS	PCI_CLASS_STORAGE_IDE << 8
+#define JMB_CLASS_MASK	0xffff00
+#else
+#define JMB_CLASS	0
+#define JMB_CLASS_MASK	0
+#endif
+
 static struct pci_device_id jmicron_pci_tbl[] = {
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
-	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361,
+	  PCI_ANY_ID, PCI_ANY_ID, JMB_CLASS, JMB_CLASS_MASK, 0},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363,
+	  PCI_ANY_ID, PCI_ANY_ID, JMB_CLASS, JMB_CLASS_MASK, 1},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365,
+	  PCI_ANY_ID, PCI_ANY_ID, JMB_CLASS, JMB_CLASS_MASK, 2},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366,
+	  PCI_ANY_ID, PCI_ANY_ID, JMB_CLASS, JMB_CLASS_MASK, 3},
+	{ PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368,
+	  PCI_ANY_ID, PCI_ANY_ID, JMB_CLASS, JMB_CLASS_MASK, 4},
 	{ 0, },
 };
 
