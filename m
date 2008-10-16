From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] scc_pata: kill unused variables
Date: Thu, 16 Oct 2008 23:05:31 +0400
Message-ID: <200810162305.31300.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:7507 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754660AbYJPTFt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 15:05:49 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Fix the "unused variable" warning in init_hwif_scc() caused by the commit
48c3c1072651922ed153bcf0a33ea82cf20df390 (ide: add struct ide_host (take 3)).
Moreover, remove the write-only variable 'dma_status_port' in init_setup_scc()
about which gcc gives no warning and which has been there from the very start...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent Linus' kernel...

 drivers/ide/pci/scc_pata.c |    4 ----
 1 files changed, 4 deletions(-)

Index: linux-2.6/drivers/ide/pci/scc_pata.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/scc_pata.c
+++ linux-2.6/drivers/ide/pci/scc_pata.c
@@ -617,7 +617,6 @@ static int __devinit init_setup_scc(stru
 	unsigned long intmask_port;
 	unsigned long mode_port;
 	unsigned long ecmode_port;
-	unsigned long dma_status_port;
 	u32 reg = 0;
 	struct scc_ports *ports;
 	int rc;
@@ -637,7 +636,6 @@ static int __devinit init_setup_scc(stru
 	intmask_port = dma_base + 0x010;
 	mode_port = ctl_base + 0x024;
 	ecmode_port = ctl_base + 0xf00;
-	dma_status_port = dma_base + 0x004;
 
 	/* controller initialization */
 	reg = 0;
@@ -843,8 +841,6 @@ static u8 scc_cable_detect(ide_hwif_t *h
 
 static void __devinit init_hwif_scc(ide_hwif_t *hwif)
 {
-	struct scc_ports *ports = ide_get_hwifdata(hwif);
-
 	/* PTERADD */
 	out_be32((void __iomem *)(hwif->dma_base + 0x018), hwif->dmatable_dma);
 

