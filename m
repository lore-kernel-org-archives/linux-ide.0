From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] libata-core: kill duplicate statement in ata_do_set_mode()
Date: Thu, 22 Dec 2011 22:41:32 +0300
Message-ID: <201112222241.32287.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:60664 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751651Ab1LVSmi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Dec 2011 13:42:38 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Commit b3a706014e56b1356e7b275fd25b833c63175bf0 (libata: Add a drivers/ide style
DMA disable) neglected to remove the line in ata_do_set_mode() it has obviously
made useless/duplicated.  Do this now, and make a line added back then wrapped
properly...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is against the recent Linus' tree.

 drivers/ata/libata-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/ata/libata-core.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-core.c
+++ linux-2.6/drivers/ata/libata-core.c
@@ -3248,10 +3248,10 @@ int ata_do_set_mode(struct ata_link *lin
 		ata_force_xfermask(dev);
 
 		pio_mask = ata_pack_xfermask(dev->pio_mask, 0, 0);
-		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
 
 		if (libata_dma_mask & mode_mask)
-			dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
+			dma_mask = ata_pack_xfermask(0, dev->mwdma_mask,
+						     dev->udma_mask);
 		else
 			dma_mask = 0;
 
