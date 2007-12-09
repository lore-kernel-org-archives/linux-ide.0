From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pdc202xx_new: fix Promise TX4 support
Date: Sun, 9 Dec 2007 17:06:11 +0100
Message-ID: <200712091706.12081.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:3540 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbXLIS5Z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Dec 2007 13:57:25 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1357928ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Dec 2007 10:57:22 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


In case of Promise TX4 the first PCI device is located at slot 1
and the second one is at slot 2 so the offset used by pci_get_slot()
should be "+1" and not "+2".

Thanks goes out to Markus Dietz for bugreport and testing this patch.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/pdc202xx_new.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -482,8 +482,9 @@ static struct pci_dev * __devinit pdc202
 {
 	struct pci_dev *dev2;
 
-	dev2 = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn) + 2,
+	dev2 = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn) + 1,
 						PCI_FUNC(dev->devfn)));
+
 	if (dev2 &&
 	    dev2->vendor == dev->vendor &&
 	    dev2->device == dev->device) {
