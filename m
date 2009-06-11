From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 8/9] siimage: implement test_irq() method
Date: Thu, 11 Jun 2009 22:41:35 +0400
Message-ID: <200906112241.35125.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906102305.36117.sshtylyov@ru.mvista.com> <4A301BD3.80307@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:3646 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754479AbZFKSj6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Jun 2009 14:39:58 -0400
In-Reply-To: <4A301BD3.80307@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Implement test_irq() method based on the driver's former dma_test_irq() methods.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This is a yesterday's patch after splitting.
The patch is atop of ide-2.6.git 'for-next' branch...

 drivers/ide/siimage.c |   12 ++++++++++++
 1 files changed, 12 insertions(+)

Index: ide-2.6/drivers/ide/siimage.c
===================================================================
--- ide-2.6.orig/drivers/ide/siimage.c
+++ ide-2.6/drivers/ide/siimage.c
@@ -337,6 +337,16 @@ static void sil_set_dma_mode(ide_drive_t
 	sil_iowrite16(dev, ultra, ua);
 }
 
+static int sil_test_irq(ide_hwif_t *hwif)
+{
+	struct pci_dev *dev	= to_pci_dev(hwif->dev);
+	unsigned long addr	= siimage_selreg(hwif, 1);
+	u8 val			= sil_ioread8(dev, addr);
+
+	/* Return 1 if INTRQ asserted */
+	return (val & 8) ? 1 : 0;
+}
+
 /**
  *	siimage_mmio_dma_test_irq	-	check we caused an IRQ
  *	@drive: drive we are testing
@@ -670,6 +680,7 @@ static const struct ide_port_ops sil_pat
 	.set_pio_mode		= sil_set_pio_mode,
 	.set_dma_mode		= sil_set_dma_mode,
 	.quirkproc		= sil_quirkproc,
+	.test_irq		= sil_test_irq,
 	.udma_filter		= sil_pata_udma_filter,
 	.cable_detect		= sil_cable_detect,
 };
@@ -680,6 +691,7 @@ static const struct ide_port_ops sil_sat
 	.reset_poll		= sil_sata_reset_poll,
 	.pre_reset		= sil_sata_pre_reset,
 	.quirkproc		= sil_quirkproc,
+	.test_irq		= sil_test_irq,
 	.udma_filter		= sil_sata_udma_filter,
 	.cable_detect		= sil_cable_detect,
 };

