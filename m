From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 04/12] trm290: small ->init_hwif cleanup
Date: Mon, 19 Jan 2009 15:13:56 +0100
Message-ID: <20090119141356.27613.95935.sendpatchset@localhost.localdomain>
References: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:36546 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbZASONe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 09:13:34 -0500
In-Reply-To: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] trm290: small ->init_hwif cleanup

Core IDE PCI code takes care of assigning hwif->irq for both ports.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/trm290.c |    3 ---
 1 file changed, 3 deletions(-)

Index: b/drivers/ide/trm290.c
===================================================================
--- a/drivers/ide/trm290.c
+++ b/drivers/ide/trm290.c
@@ -277,9 +277,6 @@ static void __devinit init_hwif_trm290(i
 	if (reg & 0x10)
 		/* legacy mode */
 		hwif->irq = hwif->channel ? 15 : 14;
-	else if (!hwif->irq && hwif->mate && hwif->mate->irq)
-		/* sharing IRQ with mate */
-		hwif->irq = hwif->mate->irq;
 
 #if 1
 	{
