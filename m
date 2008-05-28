From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/21] ide: remove unused XFER_UDMA_SLOW
Date: Wed, 28 May 2008 23:40:02 +0200
Message-ID: <20080528214002.16327.28489.sendpatchset@localhost.localdomain>
References: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:50110 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754061AbYE1Vm2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 May 2008 17:42:28 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2393895mue.1
        for <linux-ide@vger.kernel.org>; Wed, 28 May 2008 14:42:27 -0700 (PDT)
In-Reply-To: <20080528213944.16327.92950.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Remove unused XFER_UDMA_SLOW from ide_timing[].

While at it:

- fix re-defining XFER_PIO_5 (no need to define it in ide-timing.h as
  it is defined in <linux/ata.h> which is included by <linux/hdreg.h>)

- fix whitespace damage

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-timing.h |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Index: b/drivers/ide/ide-timing.h
===================================================================
--- a/drivers/ide/ide-timing.h
+++ b/drivers/ide/ide-timing.h
@@ -28,9 +28,6 @@
 #include <linux/kernel.h>
 #include <linux/hdreg.h>
 
-#define XFER_PIO_5		0x0d
-#define XFER_UDMA_SLOW		0x4f
-
 struct ide_timing {
 	short mode;
 	short setup;	/* t1 */
@@ -61,12 +58,10 @@ static struct ide_timing ide_timing[] = 
 	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0,   0,  80 },
 	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,   0, 120 },
 
-	{ XFER_UDMA_SLOW,  0,   0,   0,   0,   0,   0,   0, 150 },
-                                          
 	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 120,   0 },
 	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 150,   0 },
 	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 480,   0 },
-                                          
+
 	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 240,   0 },
 	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
 	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },
