From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/12] amd74xx: use ide_pci_is_in_compatibility_mode()
Date: Mon, 19 Jan 2009 15:13:37 +0100
Message-ID: <20090119141337.27613.43908.sendpatchset@localhost.localdomain>
References: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:36546 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbZASONO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 09:13:14 -0500
In-Reply-To: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] amd74xx: use ide_pci_is_in_compatibility_mode()

Fix ->init_hwif to check if IDE PCI controller is in compatibility
mode instead of checking for hwif->irq == 0.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/amd74xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/amd74xx.c
===================================================================
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -187,7 +187,7 @@ static void __devinit init_hwif_amd74xx(
 {
 	struct pci_dev *dev = to_pci_dev(hwif->dev);
 
-	if (hwif->irq == 0) /* 0 is bogus but will do for now */
+	if (ide_pci_is_in_compatibility_mode(dev))
 		hwif->irq = pci_get_legacy_ide_irq(dev, hwif->channel);
 }
 
