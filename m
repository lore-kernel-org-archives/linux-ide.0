From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] icside: icside_dma_setup() fixes
Date: Sun, 1 Feb 2009 20:12:23 +0100
Message-ID: <200902012012.23761.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:22397 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbZBATPB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Feb 2009 14:15:01 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Check for ide_build_sglist() return value and re-map sg table if necessary.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/icside.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: b/drivers/ide/icside.c
===================================================================
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -326,6 +326,10 @@ static int icside_dma_setup(ide_drive_t 
 	BUG_ON(dma_channel_active(ec->dma));
 
 	hwif->sg_nents = ide_build_sglist(drive, rq);
+	if (hwif->sg_nents == 0) {
+		ide_map_sg(drive, rq);
+		return 1;
+	}
 
 	/*
 	 * Ensure that we have the right interrupt routed.
