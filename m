From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/4] pata_atp867x: PIO support fixes
Date: Wed, 7 Oct 2009 00:27:19 +0200
Message-ID: <200910070027.19753.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:60902 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933219AbZJFW1l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2009 18:27:41 -0400
Received: by mail-bw0-f210.google.com with SMTP id 6so3689389bwz.37
        for <linux-ide@vger.kernel.org>; Tue, 06 Oct 2009 15:27:29 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Jung-Ik Lee (John)" <jilee@google.com>, linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_atp867x: PIO support fixes

* use  8 clk setting for active clocks == 7 (was 12 clk)
* use 12 clk setting for active clocks > 12 (was  8 clk)
* do 66MHz bus fixup before mapping active clocks
* fix setup of PIO command timings

Acked-by: Jung-Ik (John) Lee <jilee@google.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_atp867x.c |   36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

Index: b/drivers/ata/pata_atp867x.c
===================================================================
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -155,30 +155,31 @@ static int atp867x_get_active_clocks_shi
 	struct atp867x_priv *dp = ap->private_data;
 	unsigned char clocks = clk;
 
+	/*
+	 * Doc 6.6.9: increase the clock value by 1 for safer PIO speed
+	 * on 66MHz bus
+	 */
+	if (dp->pci66mhz)
+		clocks++;
+
 	switch (clocks) {
 	case 0:
 		clocks = 1;
 		break;
-	case 1 ... 7:
-		break;
-	case 9 ... 12:
-		clocks = 7;
+	case 1 ... 6:
 		break;
 	default:
 		printk(KERN_WARNING "ATP867X: active %dclk is invalid. "
-			"Using default 8clk.\n", clk);
+			"Using 12clk.\n", clk);
+	case 9 ... 12:
+		clocks = 7;	/* 12 clk */
+		break;
+	case 7:
 	case 8:	/* default 8 clk */
 		clocks = 0;
 		goto active_clock_shift_done;
 	}
 
-	/*
-	 * Doc 6.6.9: increase the clock value by 1 for safer PIO speed
-	 * on 66MHz bus
-	 */
-	if (dp->pci66mhz && clocks < 7)
-		clocks++;
-
 active_clock_shift_done:
 	return clocks << ATP867X_IO_PIOSPD_ACTIVE_SHIFT;
 }
@@ -193,7 +194,8 @@ static int atp867x_get_recover_clocks_sh
 		break;
 	case 1 ... 11:
 		break;
-	case 13: case 14:
+	case 13:
+	case 14:
 		--clocks;	/* by the spec */
 		break;
 	case 15:
@@ -235,16 +237,16 @@ static void atp867x_set_piomode(struct a
 	iowrite8(b, dp->dma_mode);
 
 	b = atp867x_get_active_clocks_shifted(ap, t.active) |
-		atp867x_get_recover_clocks_shifted(t.recover);
+	    atp867x_get_recover_clocks_shifted(t.recover);
 
 	if (adev->devno & 1)
 		iowrite8(b, dp->slave_piospd);
 	else
 		iowrite8(b, dp->mstr_piospd);
 
-	/*
-	 * use the same value for comand timing as for PIO timimg
-	 */
+	b = atp867x_get_active_clocks_shifted(ap, t.act8b) |
+	    atp867x_get_recover_clocks_shifted(t.rec8b);
+
 	iowrite8(b, dp->eightb_piospd);
 }
 
