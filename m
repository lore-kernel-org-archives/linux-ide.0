From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix IDE_HFLAG_NO_ATAPI_DMA handling in config_drive_for_dma()
Date: Mon, 5 Nov 2007 21:26:43 +0100
Message-ID: <200711052126.43462.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:27989 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbXKEUUU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Nov 2007 15:20:20 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1709485fkz
        for <linux-ide@vger.kernel.org>; Mon, 05 Nov 2007 12:20:18 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


commit 33c1002ed912ac9dacedd5d5b166da3b72d18460 incorrectly changed return
value from '0' to '-1', fix it (ns87415 was the only host driver affected
since it uses both IDE_HFLAG_TRUST_BIOS_FOR_DMA and IDE_HFLAG_NO_ATAPI_DMA).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-dma.c
===================================================================
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -340,7 +340,7 @@ static int config_drive_for_dma (ide_dri
 
 	if (drive->media != ide_disk) {
 		if (hwif->host_flags & IDE_HFLAG_NO_ATAPI_DMA)
-			return -1;
+			return 0;
 	}
 
 	/*
