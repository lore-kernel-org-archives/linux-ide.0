From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 7/9] pdc202xx_old: implement test_irq() method
Date: Wed, 10 Jun 2009 23:01:09 +0400
Message-ID: <200906102301.09022.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37657 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753004AbZFJS7e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jun 2009 14:59:34 -0400
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Implement test_irq() method based on the driver's former dma_test_irq() method.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git 'for-next' branch.
Bart, it wouldn't hurt to check this against the documentation...

 drivers/ide/pdc202xx_old.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

Index: ide-2.6/drivers/ide/pdc202xx_old.c
===================================================================
--- ide-2.6.orig/drivers/ide/pdc202xx_old.c
+++ ide-2.6/drivers/ide/pdc202xx_old.c
@@ -104,6 +104,18 @@ static void pdc202xx_set_pio_mode(ide_dr
 	pdc202xx_set_mode(drive, XFER_PIO_0 + pio);
 }
 
+static int pdc202xx_test_irq(ide_hwif_t *hwif)
+{
+	struct pci_dev *dev	= to_pci_dev(hwif->dev);
+	unsigned long high_16	= pci_resource_start(dev, 4);
+	u8 sc1d			= inb(high_16 + 0x1d);
+
+	if (hwif->channel)
+		return ((sc1d & 0x50) == 0x40) ? 1 : 0;
+	else
+		return ((sc1d & 0x05) == 0x04) ? 1 : 0;
+}
+
 static u8 pdc2026x_cable_detect(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
@@ -231,6 +243,7 @@ static void __devinit pdc202ata4_fixup_i
 static const struct ide_port_ops pdc20246_port_ops = {
 	.set_pio_mode		= pdc202xx_set_pio_mode,
 	.set_dma_mode		= pdc202xx_set_mode,
+	.test_irq		= pdc202xx_test_irq,
 };
 
 static const struct ide_port_ops pdc2026x_port_ops = {

