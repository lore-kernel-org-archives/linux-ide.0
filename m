From: domen@coderock.org
Subject: [patch 3/6] Resend: drivers/ide/pci/cs5520.c fix return code value
Date: Mon, 20 Jun 2005 23:52:19 +0200
Message-ID: <20050620215218.450082000@nd47.coderock.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coderock.org ([193.77.147.115]:33945 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261635AbVFTV4N (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jun 2005 17:56:13 -0400
Content-Disposition: inline; filename=return_code-drivers_ide_pci_cs5520.patch
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, Amit Gud <gud@eth.net>, domen@coderock.org

From: Amit Gud <amitg@calsoftinc.com>



The patch follows from the suggestions by AC and Felipe W Damasio for fixing the return codes from IDE drivers.

Do consider applying.

Signed-off-by: Amit Gud <gud@eth.net>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 cs5520.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: quilt/drivers/ide/pci/cs5520.c
===================================================================
--- quilt.orig/drivers/ide/pci/cs5520.c
+++ quilt/drivers/ide/pci/cs5520.c
@@ -225,7 +225,7 @@ static int __devinit cs5520_init_one(str
 	if(pci_enable_device_bars(dev, 1<<2))
 	{
 		printk(KERN_WARNING "%s: Unable to enable 55x0.\n", d->name);
-		return 1;
+		return -ENODEV;
 	}
 	pci_set_master(dev);
 	if (pci_set_dma_mask(dev, DMA_32BIT_MASK)) {

--
