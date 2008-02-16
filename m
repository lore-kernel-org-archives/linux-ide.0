From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 08/12] ide: remove needless hwif->irq check from ide_hwif_configure()
Date: Sat, 16 Feb 2008 17:39:46 +0100
Message-ID: <20080216163946.10174.2795.sendpatchset@localhost.localdomain>
References: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:35411 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758852AbYBPQZP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 11:25:15 -0500
Received: by mu-out-0910.google.com with SMTP id i10so1055989mue.5
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 08:25:13 -0800 (PST)
In-Reply-To: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

ide_init_default_irq() is always zero for CONFIG_PCI=y so hwif->irq
check in ide_hwif_configure() can be safely removed.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/setup-pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/setup-pci.c
===================================================================
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -371,7 +371,7 @@ static ide_hwif_t *ide_hwif_configure(st
 		return NULL;	/* no room in ide_hwifs[] */
 
 	memset(&hw, 0, sizeof(hw));
-	hw.irq = hwif->irq ? hwif->irq : irq;
+	hw.irq = irq;
 	hw.dev = &dev->dev;
 	hw.chipset = d->chipset ? d->chipset : ide_pci;
 	ide_std_init_ports(&hw, base, ctl | 2);
