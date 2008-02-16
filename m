From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/12] ide: remove ppc ifdef from init_ide_data()
Date: Sat, 16 Feb 2008 17:39:04 +0100
Message-ID: <20080216163904.10174.29572.sendpatchset@localhost.localdomain>
References: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:28566 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755671AbYBPQYc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 11:24:32 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1114981fkz.5
        for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 08:24:31 -0800 (PST)
In-Reply-To: <20080216163856.10174.72546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On PPC32 ide_init_default_irq() is non-zero only for PPLUS and PPC_PREP
(the latter marked as BROKEN currently) so this ifdef can be removed.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -214,11 +214,9 @@ static void __init init_ide_data (void)
 		ide_std_init_ports(&hw, io_addr, ctl_addr);
 		memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
-#if !defined(CONFIG_PPC32) || defined(CONFIG_PPLUS) || !defined(CONFIG_PCI)
 		hwif->irq =
 			ide_init_default_irq(hwif->io_ports[IDE_DATA_OFFSET]);
 #endif
-#endif
 	}
 }
 
