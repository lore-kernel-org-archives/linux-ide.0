From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cmd64x: fix overclocking of UDMA0-2 modes
Date: Sun, 20 Dec 2009 19:22:33 +0100
Message-ID: <200912201922.33210.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:52738 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZLTS1q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2009 13:27:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@kernel.org


adev->dma_mode stores the transfer mode value not UDMA mode number
so the condition in cmd64x_set_dmamode() is always true and the higher
UDMA clock is always selected.  This can potentially result in data
corruption when UDMA33 device is used, when 40-wire cable is used or
when the error recovery code decides to lower the device speed down.

The issue was introduced in the commit 6a40da0 ("libata cmd64x: whack
into a shape that looks like the documentation") which goes back to
kernel 2.6.20.

Cc: stable@kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
it is patch #116 in my local working queue but I thought it would
be nice to get it upstream ahead of other patches..

 drivers/ata/pata_cmd64x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ata/pata_cmd64x.c
===================================================================
--- a/drivers/ata/pata_cmd64x.c
+++ b/drivers/ata/pata_cmd64x.c
@@ -254,7 +254,7 @@ static void cmd64x_set_dmamode(struct at
 		regU |= udma_data[adev->dma_mode - XFER_UDMA_0] << shift;
 		/* Merge the control bits */
 		regU |= 1 << adev->devno; /* UDMA on */
-		if (adev->dma_mode > 2)	/* 15nS timing */
+		if (adev->dma_mode > XFER_UDMA_2) /* 15nS timing */
 			regU |= 4 << adev->devno;
 	} else {
 		regU &= ~ (1 << adev->devno);	/* UDMA off */
