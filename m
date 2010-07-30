From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: more PCI IDs for jmicron controllers
Date: Fri, 30 Jul 2010 11:42:42 +0200
Message-ID: <4C529E92.5060506@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40249 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432Ab0G3Jmp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jul 2010 05:42:45 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Aries Lee <arieslee@jmicron.com>

Add support for JMB364 and 369.

Patch-originally-from: Aries Lee <arieslee@jmicron.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/pci/quirks.c    |    6 ++++++
 include/linux/pci_ids.h |    2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 477345d..a0c20d9 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1459,6 +1459,7 @@ static void quirk_jmicron_ata(struct pci_dev *pdev)
 	switch (pdev->device) {
 	case PCI_DEVICE_ID_JMICRON_JMB360: /* SATA single port */
 	case PCI_DEVICE_ID_JMICRON_JMB362: /* SATA dual ports */
+	case PCI_DEVICE_ID_JMICRON_JMB364: /* SATA dual ports */
 		/* The controller should be in single function ahci mode */
 		conf1 |= 0x0002A100; /* Set 8, 13, 15, 17 */
 		break;
@@ -1470,6 +1471,7 @@ static void quirk_jmicron_ata(struct pci_dev *pdev)
 		/* Fall through */
 	case PCI_DEVICE_ID_JMICRON_JMB361:
 	case PCI_DEVICE_ID_JMICRON_JMB363:
+	case PCI_DEVICE_ID_JMICRON_JMB369:
 		/* Enable dual function mode, AHCI on fn 0, IDE fn1 */
 		/* Set the class codes correctly and then direct IDE 0 */
 		conf1 |= 0x00C2A1B3; /* Set 0, 1, 4, 5, 7, 8, 13, 15, 17, 22, 23 */
@@ -1496,16 +1498,20 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB360, qui
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB362, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB364, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB369, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB360, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB362, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB364, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB369, quirk_jmicron_ata);

 #endif

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 3bedcc1..eb200e6 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2324,9 +2324,11 @@
 #define PCI_DEVICE_ID_JMICRON_JMB361	0x2361
 #define PCI_DEVICE_ID_JMICRON_JMB362	0x2362
 #define PCI_DEVICE_ID_JMICRON_JMB363	0x2363
+#define PCI_DEVICE_ID_JMICRON_JMB364	0x2364
 #define PCI_DEVICE_ID_JMICRON_JMB365	0x2365
 #define PCI_DEVICE_ID_JMICRON_JMB366	0x2366
 #define PCI_DEVICE_ID_JMICRON_JMB368	0x2368
+#define PCI_DEVICE_ID_JMICRON_JMB369	0x2369
 #define PCI_DEVICE_ID_JMICRON_JMB38X_SD	0x2381
 #define PCI_DEVICE_ID_JMICRON_JMB38X_MMC 0x2382
 #define PCI_DEVICE_ID_JMICRON_JMB38X_MS	0x2383
