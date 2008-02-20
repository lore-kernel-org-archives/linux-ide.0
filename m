From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/2] ide: fix enabling DMA on it821x in "smart" mode
Date: Wed, 20 Feb 2008 21:31:19 +0100
Message-ID: <200802202131.19761.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:46308 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbYBTUSz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 15:18:55 -0500
Received: by nf-out-0910.google.com with SMTP id g13so881959nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 20 Feb 2008 12:18:53 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

ide_tune_dma() should return '1' if IDE_HFLAG_NO_SET_MODE host flag is set.

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
I wonder how this could have slipped in :(

Sergei, please double-check this patch.  Thanks!

 drivers/ide/ide-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -757,7 +757,7 @@ static int ide_tune_dma(ide_drive_t *dri
 	}
 
 	if (hwif->host_flags & IDE_HFLAG_NO_SET_MODE)
-		return 0;
+		return 1;
 
 	if (ide_set_dma_mode(drive, speed))
 		return 0;
