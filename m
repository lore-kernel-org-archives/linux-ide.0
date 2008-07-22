From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 01/10] ide: fix pre-EIDE SWDMA support on big-endian
Date: Tue, 22 Jul 2008 23:12:06 +0200
Message-ID: <20080722211206.20478.65791.sendpatchset@localhost.localdomain>
References: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:36945 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518AbYGVVOR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2008 17:14:17 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1285589mue.1
        for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2008 14:14:15 -0700 (PDT)
In-Reply-To: <20080722211159.20478.74184.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

id->tDMA is of 'unsigned char' type so endianness is already
correct and calling le16_to_cpu() is wrong.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -649,11 +649,7 @@ static unsigned int ide_get_mode_mask(id
 		if (id->field_valid & 2) {
 			mask = id->dma_1word & hwif->swdma_mask;
 		} else if (id->tDMA) {
-			/*
-			 * ide_fix_driveid() doesn't convert ->tDMA to the
-			 * CPU endianness so we need to do it here
-			 */
-			u8 mode = le16_to_cpu(id->tDMA);
+			u8 mode = id->tDMA;
 
 			/*
 			 * if the mode is valid convert it to the mask
