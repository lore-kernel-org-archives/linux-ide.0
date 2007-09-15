From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide: call udma_filter() before resorting to the UltraDMA mask
Date: Sat, 15 Sep 2007 20:42:37 +0400
Message-ID: <200709152042.37892.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:7864 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751286AbXIOQjW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Sep 2007 12:39:22 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Give the udma_filter() method call taking precedence over using the mode masks.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Posting this change separately as have been asked.  Should apply to the current
Linus' tree...

 drivers/ide/ide-dma.c |    7 +++---
 1 files changed, 4 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ide/ide-dma.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-dma.c
+++ linux-2.6/drivers/ide/ide-dma.c
@@ -664,10 +664,11 @@ static unsigned int ide_get_mode_mask(id
 		if ((id->field_valid & 4) == 0)
 			break;
 
-		mask = id->dma_ultra & hwif->ultra_mask;
-
 		if (hwif->udma_filter)
-			mask &= hwif->udma_filter(drive);
+			mask = hwif->udma_filter(drive);
+		else
+			mask = hwif->ultra_mask;
+		mask &= id->dma_ultra;
 
 		if ((mask & 0x78) && (eighty_ninty_three(drive) == 0))
 			mask &= 0x07;

