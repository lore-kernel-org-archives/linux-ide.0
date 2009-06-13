From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 10/10] sl82c105: implement test_irq() method
Date: Sat, 13 Jun 2009 17:39:08 +0400
Message-ID: <200906131739.08262.sshtylyov@ru.mvista.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:52461 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758161AbZFMNh1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Jun 2009 09:37:27 -0400
In-Reply-To: <200702140101.26639.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Implement test_irq() method.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of ide-2.6.git 'for-next' branch.

 drivers/ide/sl82c105.c |   11 +++++++++++
 1 files changed, 11 insertions(+)

Index: ide-2.6/drivers/ide/sl82c105.c
===================================================================
--- ide-2.6.orig/drivers/ide/sl82c105.c
+++ ide-2.6/drivers/ide/sl82c105.c
@@ -115,6 +115,16 @@ static void sl82c105_set_dma_mode(ide_dr
 	drive->drive_data |= (unsigned long)drv_ctrl << 16;
 }
 
+static int sl82c105_test_irq(ide_hwif_t *hwif)
+{
+	struct pci_dev *dev	= to_pci_dev(hwif->dev);
+	u32 val, mask		= hwif->channel ? CTRL_IDE_IRQB : CTRL_IDE_IRQA;
+
+	pci_read_config_dword(dev, 0x40, &val);
+
+	return (val & mask) ? 1 : 0;
+}
+
 /*
  * The SL82C105 holds off all IDE interrupts while in DMA mode until
  * all DMA activity is completed.  Sometimes this causes problems (eg,
@@ -289,6 +299,7 @@ static const struct ide_port_ops sl82c10
 	.set_pio_mode		= sl82c105_set_pio_mode,
 	.set_dma_mode		= sl82c105_set_dma_mode,
 	.resetproc		= sl82c105_resetproc,
+	.test_irq		= sl82c105_test_irq,
 };
 
 static const struct ide_dma_ops sl82c105_dma_ops = {

