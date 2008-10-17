From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/4] pata_ninja32: suspend/resume support
Date: Fri, 17 Oct 2008 19:08:31 +0100
Message-ID: <20081017180826.7781.59704.stgit@localhost.localdomain>
References: <20081017180655.7781.15021.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38481 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753809AbYJQSIf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Oct 2008 14:08:35 -0400
In-Reply-To: <20081017180655.7781.15021.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

From: Alan Cox <alan@redhat.com>

I had assumed that the standard recovery would be sufficient for this
hardware but it isn't. Fix up the other registers on resume as needed. See
bug #11735

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/ata/pata_ninja32.c |   43 ++++++++++++++++++++++++++++++++++---------
 1 files changed, 34 insertions(+), 9 deletions(-)


diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index 565e67c..dd9bd55 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -45,7 +45,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_ninja32"
-#define DRV_VERSION "0.0.1"
+#define DRV_VERSION "0.1.1"
 
 
 /**
@@ -89,6 +89,17 @@ static struct ata_port_operations ninja32_port_ops = {
 	.set_piomode	= ninja32_set_piomode,
 };
 
+static void ninja32_program(void __iomem *base)
+{
+	iowrite8(0x05, base + 0x01);	/* Enable interrupt lines */
+	iowrite8(0xBE, base + 0x02);	/* Burst, ?? setup */
+	iowrite8(0x01, base + 0x03);	/* Unknown */
+	iowrite8(0x20, base + 0x04);	/* WAIT0 */
+	iowrite8(0x8f, base + 0x05);	/* Unknown */
+	iowrite8(0xa4, base + 0x1c);	/* Unknown */
+	iowrite8(0x83, base + 0x1d);	/* BMDMA control: WAIT0 */
+}
+
 static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct ata_host *host;
@@ -134,18 +145,28 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 	ap->ioaddr.bmdma_addr = base;
 	ata_sff_std_ports(&ap->ioaddr);
 
-	iowrite8(0x05, base + 0x01);	/* Enable interrupt lines */
-	iowrite8(0xBE, base + 0x02);	/* Burst, ?? setup */
-	iowrite8(0x01, base + 0x03);	/* Unknown */
-	iowrite8(0x20, base + 0x04);	/* WAIT0 */
-	iowrite8(0x8f, base + 0x05);	/* Unknown */
-	iowrite8(0xa4, base + 0x1c);	/* Unknown */
-	iowrite8(0x83, base + 0x1d);	/* BMDMA control: WAIT0 */
+	ninja32_program(base);
 	/* FIXME: Should we disable them at remove ? */
 	return ata_host_activate(host, dev->irq, ata_sff_interrupt,
 				 IRQF_SHARED, &ninja32_sht);
 }
 
+#ifdef CONFIG_PM
+
+static int ninja32_reinit_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+	ninja32_program(host->iomap[0]);
+	ata_host_resume(host);
+	return 0;			
+}
+#endif
+
 static const struct pci_device_id ninja32[] = {
 	{ 0x1145, 0xf021, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0x1145, 0xf024, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
@@ -156,7 +177,11 @@ static struct pci_driver ninja32_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= ninja32,
 	.probe 		= ninja32_init_one,
-	.remove		= ata_pci_remove_one
+	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
+	.suspend	= ata_pci_device_suspend,
+	.resume		= ninja32_reinit_one,
+#endif
 };
 
 static int __init ninja32_init(void)

