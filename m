From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/6] ide: remove superfluous hwif variable assignment from ide_timer_expiry()
Date: Mon, 29 Dec 2008 20:04:29 +0100
Message-ID: <20081229190429.1020.49267.sendpatchset@localhost.localdomain>
References: <20081229190415.1020.43119.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:63827 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbYL2TEJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 14:04:09 -0500
In-Reply-To: <20081229190415.1020.43119.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove superfluous hwif variable assignment from ide_timer_expiry()

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |    1 -
 1 file changed, 1 deletion(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -946,7 +946,6 @@ void ide_timer_expiry (unsigned long dat
 			 * globally mask the specific IRQ:
 			 */
 			spin_unlock(&hwif->lock);
-			hwif = drive->hwif;
 			/* disable_irq_nosync ?? */
 			disable_irq(hwif->irq);
 			/* local CPU only,
