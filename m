From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pdc202xx_old: fix 'pdc20246_dma_ops'
Date: Wed, 3 Jun 2009 22:34:44 +0400
Message-ID: <200906032234.45030.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:60631 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751988AbZFCSdY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Jun 2009 14:33:24 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Commit ac95beedf8bc97b24f9540d4da9952f07221c023 (ide: add struct ide_port_ops
(take 2)) erroneously converted the driver's dma_timeout() and dma_lost_irq()
methods to call the driver's resetproc() method regardless of whether it was
defined for this specific controller while it hadn't been defined and hence
called for PDC20246. So the dma_clear() method, the successor of dma_timeout(),
shouldn't exist and the dma_lost_irq() method should be standard for PDC20246.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the ide-2.6.git 'master' branch...

 drivers/ide/pdc202xx_old.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: ide-2.6/drivers/ide/pdc202xx_old.c
===================================================================
--- ide-2.6.orig/drivers/ide/pdc202xx_old.c
+++ ide-2.6/drivers/ide/pdc202xx_old.c
@@ -319,9 +319,8 @@ static const struct ide_dma_ops pdc20246
 	.dma_start		= ide_dma_start,
 	.dma_end		= ide_dma_end,
 	.dma_test_irq		= pdc202xx_dma_test_irq,
-	.dma_lost_irq		= pdc202xx_dma_lost_irq,
+	.dma_lost_irq		= ide_dma_lost_irq,
 	.dma_timer_expiry	= ide_dma_sff_timer_expiry,
-	.dma_clear		= pdc202xx_reset,
 	.dma_sff_read_status	= ide_dma_sff_read_status,
 };
 

