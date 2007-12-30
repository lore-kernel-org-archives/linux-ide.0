From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] ide-pmac: macio resource freeing bugfix
Date: Sun, 30 Dec 2007 18:24:50 +0100
Message-ID: <200712301824.51003.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:7625 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbXL3Rbl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Dec 2007 12:31:41 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2175205ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 30 Dec 2007 09:31:39 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Release DMA resource before zeroing pmif.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1228,12 +1228,12 @@ pmac_ide_macio_attach(struct macio_dev *
 		/* The inteface is released to the common IDE layer */
 		dev_set_drvdata(&mdev->ofdev.dev, NULL);
 		iounmap(base);
-		if (pmif->dma_regs)
+		if (pmif->dma_regs) {
 			iounmap(pmif->dma_regs);
+			macio_release_resource(mdev, 1);
+		}
 		memset(pmif, 0, sizeof(*pmif));
 		macio_release_resource(mdev, 0);
-		if (pmif->dma_regs)
-			macio_release_resource(mdev, 1);
 	}
 
 	return rc;
