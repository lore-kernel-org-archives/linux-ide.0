From: domen@coderock.org
Subject: [patch 3/6] Resend: drivers/ide/pci/cs5520.c fix return code value
Date: Sun, 06 Mar 2005 11:42:10 +0100
Message-ID: <20050306104210.C3D331F203@trashy.coderock.org>
Received: from coderock.org ([193.77.147.115]:30634 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261373AbVCFKmQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Mar 2005 05:42:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, domen@coderock.org, amitg@calsoftinc.com, gud@eth.net



The patch follows from the suggestions by AC and Felipe W Damasio for fixing the return codes from IDE drivers.

Do consider applying.

Signed-off-by: Amit Gud <gud@eth.net>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/ide/pci/cs5520.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ide/pci/cs5520.c~return_code-drivers_ide_pci_cs5520 drivers/ide/pci/cs5520.c
--- kj/drivers/ide/pci/cs5520.c~return_code-drivers_ide_pci_cs5520	2005-03-05 16:11:10.000000000 +0100
+++ kj-domen/drivers/ide/pci/cs5520.c	2005-03-05 16:11:10.000000000 +0100
@@ -224,7 +224,7 @@ static int __devinit cs5520_init_one(str
 	if(pci_enable_device_bars(dev, 1<<2))
 	{
 		printk(KERN_WARNING "%s: Unable to enable 55x0.\n", d->name);
-		return 1;
+		return -ENODEV;
 	}
 	pci_set_master(dev);
 	if (pci_set_dma_mask(dev, 0xFFFFFFFF)) {
_
