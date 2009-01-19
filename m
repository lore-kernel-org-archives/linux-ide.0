From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 07/12] ide: use ide_pci_is_in_compatibility_mode() in ide_pci_init_{one,two}()
Date: Mon, 19 Jan 2009 15:14:37 +0100
Message-ID: <20090119141437.27613.8610.sendpatchset@localhost.localdomain>
References: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:49200 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbZASOOP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 09:14:15 -0500
In-Reply-To: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: use ide_pci_is_in_compatibility_mode() in ide_pci_init_{one,two}()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -568,13 +568,11 @@ int ide_pci_init_one(struct pci_dev *dev
 		goto out;
 
 	/* fixup IRQ */
-	hw[1].irq = hw[0].irq = ret;
-
-	if ((ret == 0 && (d->host_flags & IDE_HFLAG_LEGACY_IRQS)) ||
-	    (d->host_flags & IDE_HFLAG_FORCE_LEGACY_IRQS)) {
+	if (ide_pci_is_in_compatibility_mode(dev)) {
 		hw[0].irq = pci_get_legacy_ide_irq(dev, 0);
 		hw[1].irq = pci_get_legacy_ide_irq(dev, 1);
-	}
+	} else
+		hw[1].irq = hw[0].irq = ret;
 
 	ret = ide_host_register(host, d, hws);
 	if (ret)
@@ -625,13 +623,11 @@ int ide_pci_init_two(struct pci_dev *dev
 			goto out;
 
 		/* fixup IRQ */
-		hw[i*2 + 1].irq = hw[i*2].irq = ret;
-
-		if ((ret == 0 && (d->host_flags & IDE_HFLAG_LEGACY_IRQS)) ||
-		    (d->host_flags & IDE_HFLAG_FORCE_LEGACY_IRQS)) {
+		if (ide_pci_is_in_compatibility_mode(pdev[i])) {
 			hw[i*2].irq = pci_get_legacy_ide_irq(pdev[i], 0);
 			hw[i*2 + 1].irq = pci_get_legacy_ide_irq(pdev[i], 1);
-		}
+		} else
+			hw[i*2 + 1].irq = hw[i*2].irq = ret;
 	}
 
 	ret = ide_host_register(host, d, hws);
