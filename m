From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: [PATCH] IDE: always release DMA engine
Date: Wed, 29 Mar 2006 23:31:53 +0400
Message-ID: <442AE0A9.7090106@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090607080001050302070402"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:11926 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750803AbWC2Tdb
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Mar 2006 14:33:31 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This is a multi-part message in MIME format.
--------------090607080001050302070402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hail.

     Release the DMA engine for the custom mapping IDE drivers also (for
example, siimage.c does allocate it in both I/O-mapped and custom-mapped
modes). Remove useless code from the error path of ide_allocate_dma_engine().

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------090607080001050302070402
Content-Type: text/plain;
 name="IDE-always-release-DMA-engine.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="IDE-always-release-DMA-engine.patch"

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index c481be8..92e9088 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -811,15 +811,14 @@ static int ide_release_iomio_dma(ide_hwi
 /*
  * Needed for allowing full modular support of ide-driver
  */
-int ide_release_dma (ide_hwif_t *hwif)
+int ide_release_dma(ide_hwif_t *hwif)
 {
+	ide_release_dma_engine(hwif);
+
 	if (hwif->mmio == 2)
 		return 1;
-	if (hwif->chipset == ide_etrax100)
-		return 1;
-
-	ide_release_dma_engine(hwif);
-	return ide_release_iomio_dma(hwif);
+	else
+		return ide_release_iomio_dma(hwif);
 }
 
 static int ide_allocate_dma_engine(ide_hwif_t *hwif)
@@ -831,10 +830,9 @@ static int ide_allocate_dma_engine(ide_h
 	if (hwif->dmatable_cpu)
 		return 0;
 
-	printk(KERN_ERR "%s: -- Error, unable to allocate%s DMA table(s).\n",
-			hwif->cds->name, !hwif->dmatable_cpu ? " CPU" : "");
+	printk(KERN_ERR "%s: -- Error, unable to allocate DMA table.\n",
+	       hwif->cds->name);
 
-	ide_release_dma_engine(hwif);
 	return 1;
 }
 




--------------090607080001050302070402--
