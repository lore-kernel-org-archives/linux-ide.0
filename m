From: Tobias Klauser <tklauser@nuerscht.ch>
Subject: [PATCH] drivers/ide/cs5520.c : Use the DMA_{64,32}BIT_MASK constants
Date: Tue, 8 Mar 2005 14:33:58 +0100
Message-ID: <20050308133358.GA5311@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from idmailgate2.unizh.ch ([130.60.68.106]:53946 "EHLO
	idmailgate2.unizh.ch") by vger.kernel.org with ESMTP
	id S262054AbVCHNee (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Mar 2005 08:34:34 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernel-janitors@lists.osdl.org
Cc: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl

Hello,

Description: Use the DMA_{64,32}BIT_MASK constants from dma-mapping.h
when calling pci_set_dma_mask() or pci_set_consistent_dma_mask()
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>

--- linux-2.6.11.orig/drivers/ide/pci/cs5520.c	2005-03-02 12:50:39.000000000 +0100
+++ linux-2.6.11/drivers/ide/pci/cs5520.c	2005-03-03 11:46:46.000000000 +0100
@@ -227,7 +227,7 @@ static int __devinit cs5520_init_one(str
 		return 1;
 	}
 	pci_set_master(dev);
-	if (pci_set_dma_mask(dev, 0xFFFFFFFF)) {
+	if (pci_set_dma_mask(dev, DMA_32BIT_MASK)) {
 		printk(KERN_WARNING "cs5520: No suitable DMA available.\n");
 		return -ENODEV;
 	}
