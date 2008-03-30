From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/5] ide-h8300: 32-bit I/O is unsupported
Date: Sun, 30 Mar 2008 17:10:45 +0200
Message-ID: <200803301710.45286.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:13117 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbYC3Pca (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 30 Mar 2008 11:32:30 -0400
Received: by ug-out-1314.google.com with SMTP id z38so296945ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 30 Mar 2008 08:32:29 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This host driver doesn't support 32-bit I/O (it sets hwif->INSL/OUTSL
to NULL) so IDE_HFLAG_NO_IO_32BIT host flag needs to be set.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/h8300/ide-h8300.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/h8300/ide-h8300.c
===================================================================
--- a/drivers/ide/h8300/ide-h8300.c
+++ b/drivers/ide/h8300/ide-h8300.c
@@ -107,6 +107,7 @@ static int __init h8300_ide_init(void)
 	index = hwif->index;
 	ide_init_port_hw(hwif, &hw);
 	hwif_setup(hwif);
+	hwif->host_flags = IDE_HFLAG_NO_IO_32BIT;
 	printk(KERN_INFO "ide%d: H8/300 generic IDE interface\n", index);
 
 	idx[0] = index;
