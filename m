From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/11] sl82c105: add PIO autotune fallback to ->ide_dma_check
Date: Sat, 4 Aug 2007 22:10:37 +0200
Message-ID: <200708042210.37185.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:12431 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759060AbXHDUQM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 16:16:12 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1508336mue
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 13:16:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Since sl82c105 re-programs DMA/PIO timings for DMA enable/disable, and sets
->autotune this change shouldn't have any other effect than bringing sl82c105
driver in-line with other host drivers wrt ->ide_dma_check implementation.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sl82c105.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -154,6 +154,8 @@ static int sl82c105_ide_dma_check(ide_dr
 	if (ide_tune_dma(drive))
 		return 0;
 
+	ide_set_max_pio(drive);
+
 	return -1;
 }
 
