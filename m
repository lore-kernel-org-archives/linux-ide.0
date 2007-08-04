From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/11] ide-pmac: add PIO autotune fallback to ->ide_dma_check
Date: Sat, 4 Aug 2007 22:12:19 +0200
Message-ID: <200708042212.19711.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:12507 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760939AbXHDUQN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 16:16:13 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1508364mue
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 13:16:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Since ide-pmac allows separate PIO and DMA timings, and ide-pmac always sets
->autotune this change shouldn't have any other effect than bringing ide-pmac
driver in-line with other host drivers wrt ->ide_dma_check implementation.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1587,6 +1587,8 @@ pmac_ide_dma_check(ide_drive_t *drive)
 	if (ide_tune_dma(drive))
 		return 0;
 
+	ide_set_max_pio(drive);
+
 	return -1;
 }
 
