From: Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Can't disable IDE DMA on 2.6.0-test9 (patch)
Date: Fri, 21 Nov 2003 10:05:35 +1100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <16317.18623.912339.111750@wombat.disy.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Received: From wombat.disy.cse.unsw.edu.au ([129.94.239.42]) (for <akpm@osdl.org>)
	(for <B.Zolnierkiewicz@elka.pw.edu.pl>)
	(for <linux-ide@vger.kernel.org>)
	(for <linux-kernel@vger.kernel.org>) By note With Smtp ;
	Fri, 21 Nov 2003 10:05:36 +1100
To: akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi Folks,
   If you try to disable IDE DMA from Kconfig, you'll end up with an
undefined symbol, ide_hwif_setup_dma().

The attached rather ugly patch fixes the problem by defining a dummy
function.

===== setup-pci.c 1.19 vs edited =====
--- 1.19/drivers/ide/setup-pci.c	Sat Oct 18 01:22:22 2003
+++ edited/setup-pci.c	Wed Nov 19 13:52:25 2003
@@ -474,6 +474,11 @@
  *	state
  */
  
+#ifndef CONFIG_BLK_DEV_IDEDMA_PCI
+static void ide_hwif_setup_dma(struct pci_dev *dev, ide_pci_device_t *d, ide_hwif_t *hwif)
+{
+}
+#else
 static void ide_hwif_setup_dma(struct pci_dev *dev, ide_pci_device_t *d, ide_hwif_t *hwif)
 {
 	u16 pcicmd;
@@ -516,6 +521,7 @@
 		}
 	}
 }
+#endif /* CONFIG_BLK_DEV_IDEDMA_PCI*/
 
 /**
  *	ide_setup_pci_controller	-	set up IDE PCI
