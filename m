From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/3] pata_pdc202xx_old: update documentation
Date: Sat, 13 Feb 2010 14:36:05 +0100
Message-ID: <20100213133605.11564.60246.sendpatchset@localhost>
References: <20100213133538.11564.94218.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:41586 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab0BMNnW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Feb 2010 08:43:22 -0500
In-Reply-To: <20100213133538.11564.94218.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_pdc202xx_old: update documentation

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/Kconfig |    1 -
 1 file changed, 1 deletion(-)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -599,7 +599,6 @@ config PATA_PDC_OLD
 	  20265 and 20267 adapters.
 
 	  Known issues:
-	  - UDMA transfers fail mysteriously on some chipsets
 	  - ATAPI DMA is unsupported currently
 
 	  If unsure, say N.
