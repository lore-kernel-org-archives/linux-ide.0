From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/4] ide: don't set hwif->dma_ops in init_dma() method
Date: Wed, 31 Dec 2008 22:52:47 +0400
Message-ID: <200812312152.48007.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:12288 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752551AbYLaSwX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Dec 2008 13:52:23 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Replace setting of 'hwif->dma_ops' in the 'alim16x3' and 'palm_bk3710' drivers'
init_dma() methods with initializing the corresponding member of their 'struct
ide_port_info' instances and remove such setting from the 'hpt366' driver that
just doesn't use 'sff_dma_ops'. Along with some code save, this prepares us for
the next patch...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Here are the unfortunate series of patches that hadn't gotten into 2.6.28 --
I decided not to leave it to the next year despite an extreme overload I had
during the past several months... :-)
The patch is atop of the current pata-2.6 series...
                                          
 drivers/ide/alim15x3.c    |    3 +--
 drivers/ide/hpt366.c      |    2 --
 drivers/ide/palm_bk3710.c |    3 +--
 3 files changed, 2 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/ide/alim15x3.c
===================================================================
--- linux-2.6.orig/drivers/ide/alim15x3.c
+++ linux-2.6/drivers/ide/alim15x3.c
@@ -490,8 +490,6 @@ static int __devinit init_dma_ali15x3(id
 	if (ide_allocate_dma_engine(hwif))
 		return -1;
 
-	hwif->dma_ops = &sff_dma_ops;
-
 	return 0;
 }
 
@@ -519,6 +517,7 @@ static const struct ide_port_info ali15x
 	.init_hwif	= init_hwif_ali15x3,
 	.init_dma	= init_dma_ali15x3,
 	.port_ops	= &ali_port_ops,
+	.dma_ops	= &sff_dma_ops,
 	.pio_mask	= ATA_PIO5,
 	.swdma_mask	= ATA_SWDMA2,
 	.mwdma_mask	= ATA_MWDMA2,
Index: linux-2.6/drivers/ide/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/hpt366.c
+++ linux-2.6/drivers/ide/hpt366.c
@@ -1349,8 +1349,6 @@ static int __devinit init_dma_hpt366(ide
 	if (ide_allocate_dma_engine(hwif))
 		return -1;
 
-	hwif->dma_ops = &sff_dma_ops;
-
 	return 0;
 }
 
Index: linux-2.6/drivers/ide/palm_bk3710.c
===================================================================
--- linux-2.6.orig/drivers/ide/palm_bk3710.c
+++ linux-2.6/drivers/ide/palm_bk3710.c
@@ -324,8 +324,6 @@ static int __devinit palm_bk3710_init_dm
 
 	hwif->dma_base = hwif->io_ports.data_addr - IDE_PALM_ATA_PRI_REG_OFFSET;
 
-	hwif->dma_ops = &sff_dma_ops;
-
 	return 0;
 }
 
@@ -338,6 +336,7 @@ static const struct ide_port_ops palm_bk
 static struct ide_port_info __devinitdata palm_bk3710_port_info = {
 	.init_dma		= palm_bk3710_init_dma,
 	.port_ops		= &palm_bk3710_ports_ops,
+	.dma_ops		= &sff_dma_ops,
 	.host_flags		= IDE_HFLAG_MMIO,
 	.pio_mask		= ATA_PIO4,
 	.mwdma_mask		= ATA_MWDMA2,

