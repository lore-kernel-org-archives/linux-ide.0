From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 8/10] pdc202xx_old: implement test_irq() method (take 2)
Date: Sat, 13 Jun 2009 17:38:16 +0400
Message-ID: <200906131738.16931.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:52457 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754963AbZFMNgg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Jun 2009 09:36:36 -0400
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
Hopefully it won't break the driver -- previosly the bits have been effectively
ignored...

Changes sice previos take:
- decided to document the register bits...

 drivers/ide/pdc202xx_old.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+)

Index: ide-2.6/drivers/ide/pdc202xx_old.c
===================================================================
--- ide-2.6.orig/drivers/ide/pdc202xx_old.c
+++ ide-2.6/drivers/ide/pdc202xx_old.c
@@ -104,6 +104,27 @@ static void pdc202xx_set_pio_mode(ide_dr
 	pdc202xx_set_mode(drive, XFER_PIO_0 + pio);
 }
 
+static int pdc202xx_test_irq(ide_hwif_t *hwif)
+{
+	struct pci_dev *dev	= to_pci_dev(hwif->dev);
+	unsigned long high_16	= pci_resource_start(dev, 4);
+	u8 sc1d			= inb(high_16 + 0x1d);
+
+	if (hwif->channel) {
+		/*
+		 * bit 7: error, bit 6: interrupting,
+		 * bit 5: FIFO full, bit 4: FIFO empty
+		 */
+		return ((sc1d & 0x50) == 0x40) ? 1 : 0;
+	} else	{
+		/*
+		 * bit 3: error, bit 2: interrupting,
+		 * bit 1: FIFO full, bit 0: FIFO empty
+		 */
+		return ((sc1d & 0x05) == 0x04) ? 1 : 0;
+	}
+}
+
 static u8 pdc2026x_cable_detect(ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
@@ -231,6 +252,7 @@ static void __devinit pdc202ata4_fixup_i
 static const struct ide_port_ops pdc20246_port_ops = {
 	.set_pio_mode		= pdc202xx_set_pio_mode,
 	.set_dma_mode		= pdc202xx_set_mode,
+	.test_irq		= pdc202xx_test_irq,
 };
 
 static const struct ide_port_ops pdc2026x_port_ops = {

