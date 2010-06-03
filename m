From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] ahci: add pci quirk for JMB362
Date: Thu, 03 Jun 2010 11:57:04 +0200
Message-ID: <4C077C70.4030500@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Aries Lee <arieslee@jmicron>
List-Id: linux-ide@vger.kernel.org

JMB362 is a new variant of jmicron controller which is similar to
JMB360 but has two SATA ports instead of one.  As there is no PATA
port, single function AHCI mode can be used as in JMB360.  Add pci
quirk for JMB362.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Aries Lee <arieslee@jmicron.com>
Cc: stable@kernel.org
---
Although this is a pci quirk, I think it's better routed thorugh
libata tree but either way it's a pretty trivial patch.

Thanks.

 drivers/pci/quirks.c    |    5 ++++-
 include/linux/pci_ids.h |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b7512cf..477345d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1457,7 +1457,8 @@ static void quirk_jmicron_ata(struct pci_dev *pdev)
 	conf5 &= ~(1 << 24);  /* Clear bit 24 */

 	switch (pdev->device) {
-	case PCI_DEVICE_ID_JMICRON_JMB360:
+	case PCI_DEVICE_ID_JMICRON_JMB360: /* SATA single port */
+	case PCI_DEVICE_ID_JMICRON_JMB362: /* SATA dual ports */
 		/* The controller should be in single function ahci mode */
 		conf1 |= 0x0002A100; /* Set 8, 13, 15, 17 */
 		break;
@@ -1493,12 +1494,14 @@ static void quirk_jmicron_ata(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB360, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB362, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB360, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, quirk_jmicron_ata);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB362, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB363, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB365, quirk_jmicron_ata);
 DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, quirk_jmicron_ata);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ae66851..843883e 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2321,6 +2321,7 @@
 #define PCI_VENDOR_ID_JMICRON		0x197B
 #define PCI_DEVICE_ID_JMICRON_JMB360	0x2360
 #define PCI_DEVICE_ID_JMICRON_JMB361	0x2361
+#define PCI_DEVICE_ID_JMICRON_JMB362	0x2362
 #define PCI_DEVICE_ID_JMICRON_JMB363	0x2363
 #define PCI_DEVICE_ID_JMICRON_JMB365	0x2365
 #define PCI_DEVICE_ID_JMICRON_JMB366	0x2366
