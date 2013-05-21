From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] sata_rcar: clear STOP bit in bmdma_start() method
Date: Tue, 21 May 2013 23:07:54 +0400
Message-ID: <201305212307.55385.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:53271 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677Ab3EUTH4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 May 2013 15:07:56 -0400
Received: by mail-lb0-f181.google.com with SMTP id w20so1187408lbh.26
        for <linux-ide@vger.kernel.org>; Tue, 21 May 2013 12:07:54 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org, vladimir.barinov@cogentembedded.com

Iff bmdma_setup() has to stop a DMA transfer before starting a new one, then the
STOP bit in the ATAPI_CONTROL1 register will remain set (it's only cleared when
setting the START bit to 1) and then bmdma_start() method will set both START
and STOP bits simultaneously which should abort the transfer being just started.
Avoid that by explicitly clearing the STOP bit in bmdma_start() method (in this
case it will be ignored on write).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'for-3.10-fixes' branch of Tejun Heo's 'libata.git' repo.

 drivers/ata/sata_rcar.c |    1 +
 1 file changed, 1 insertion(+)

Index: libata/drivers/ata/sata_rcar.c
===================================================================
--- libata.orig/drivers/ata/sata_rcar.c
+++ libata/drivers/ata/sata_rcar.c
@@ -549,6 +549,7 @@ static void sata_rcar_bmdma_start(struct
 
 	/* start host DMA transaction */
 	dmactl = ioread32(priv->base + ATAPI_CONTROL1_REG);
+	dmactl &= ~ATAPI_CONTROL1_STOP;
 	dmactl |= ATAPI_CONTROL1_START;
 	iowrite32(dmactl, priv->base + ATAPI_CONTROL1_REG);
 }
