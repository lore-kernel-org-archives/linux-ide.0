From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] it8172.c: ide_init_hwif_ports() -> ide_std_init_ports()
Date: Wed, 21 Apr 2004 22:13:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404212213.43990.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7042 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263676AbUDUUOo
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 21 Apr 2004 16:14:44 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: linux-ide@vger.kernel.org


Self-explanatory. :-)


[PATCH] it8172.c: ide_init_hwif_ports() -> ide_std_init_ports()

This driver can be compiled only on mips (depends on MIPS_ITE8172 || MIPS_IVR)
so replace ide_init_hwif_ports() with ide_std_init_ports().

 linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/pci/it8172.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/ide/pci/it8172.c~it8172_std_init_ports drivers/ide/pci/it8172.c
--- linux-2.6.6-rc1-bk5/drivers/ide/pci/it8172.c~it8172_std_init_ports	2004-04-21 00:37:17.601970896 +0200
+++ linux-2.6.6-rc1-bk5-bzolnier/drivers/ide/pci/it8172.c	2004-04-21 00:37:17.605970288 +0200
@@ -263,8 +263,8 @@ static void __init init_hwif_it8172 (ide
 
 	cmdBase = dev->resource[0].start;
 	ctrlBase = dev->resource[1].start;
-    
-	ide_init_hwif_ports(&hwif->hw, cmdBase, ctrlBase | 2, NULL);
+
+	ide_std_init_ports(&hwif->hw, cmdBase, ctrlBase | 2);
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 	hwif->noprobe = 0;
 

_

