From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/10] ide-cris: add PIO autotune fallback to ->ide_dma_check
Date: Sat, 4 Aug 2007 22:11:26 +0200
Message-ID: <200708042211.26276.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:51646 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763552AbXHDUQQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Aug 2007 16:16:16 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1014338fkz
        for <linux-ide@vger.kernel.org>; Sat, 04 Aug 2007 13:16:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mikael Starvik <starvik@axis.com>


Since ide-cris allows separate PIO and DMA timings, and ide-cris always sets
->autotune this change shouldn't have any other effect than bringing ide-cris
driver in-line with other host drivers wrt ->ide_dma_check implementation.

Cc: Mikael Starvik <starvik@axis.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cris/ide-cris.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -1024,6 +1024,8 @@ static int cris_dma_check(ide_drive_t *d
 	if (ide_tune_dma(drive))
 		return 0;
 
+	ide_set_max_pio(drive);
+
 	return -1;
 }
 
