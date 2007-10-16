From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [git patch] libata build fix
Date: Wed, 17 Oct 2007 01:23:43 +0200
Message-ID: <200710170123.43244.bzolnier@gmail.com>
References: <20071015221329.GA8778@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:49485 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbXJPXSe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Oct 2007 19:18:34 -0400
Received: by ug-out-1314.google.com with SMTP id z38so182760ugc
        for <linux-ide@vger.kernel.org>; Tue, 16 Oct 2007 16:18:32 -0700 (PDT)
In-Reply-To: <20071015221329.GA8778@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>

On Tuesday 16 October 2007, Jeff Garzik wrote:

> Jeff Garzik (1):
>       [libata] pata_cs5536: new API build fix

We probably need also this one for pata_cs5536:

[PATCH] pata_cs5536: MWDMA fix

* Fix out-of-bound array access for MWDMA modes.

* Bump driver version.

Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cs5536.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_cs5536.c
===================================================================
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -40,7 +40,7 @@
 #include <asm/msr.h>
 
 #define DRV_NAME	"pata_cs5536"
-#define DRV_VERSION	"0.0.5"
+#define DRV_VERSION	"0.0.6"
 
 enum {
 	CFG			= 0,
@@ -214,7 +214,7 @@ static void cs5536_set_dmamode(struct at
 		cs5536_read(pdev, DTC, &dtc);
 
 		dtc &= ~(IDE_DRV_MASK << dshift);
-		dtc |= mwdma_timings[mode] << dshift;
+		dtc |= mwdma_timings[mode - XFER_MW_DMA_0] << dshift;
 
 		cs5536_write(pdev, DTC, dtc);
 	}
