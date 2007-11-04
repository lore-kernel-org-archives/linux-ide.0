From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/18] ide: fix ide_find_dma_mode() to print human-readable info
Date: Mon, 5 Nov 2007 00:13:58 +0100
Message-ID: <200711050013.58563.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:52656 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbXKDX3c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Nov 2007 18:29:32 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1219889nfb
        for <linux-ide@vger.kernel.org>; Sun, 04 Nov 2007 15:29:31 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mikael Pettersson <mikpe@it.uu.se>


Problem reported by Mikael.

Cc: Mikael Pettersson <mikpe@it.uu.se>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -752,7 +752,8 @@ u8 ide_find_dma_mode(ide_drive_t *drive,
 			mode = XFER_MW_DMA_1;
 	}
 
-	printk(KERN_DEBUG "%s: selected mode 0x%x\n", drive->name, mode);
+	printk(KERN_DEBUG "%s: %s mode selected\n", drive->name,
+			  mode ? ide_xfer_verbose(mode) : "no DMA");
 
 	return min(mode, req_mode);
 }
