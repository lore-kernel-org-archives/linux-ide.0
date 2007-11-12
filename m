From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/13] icside: add ide_toggle_bounce() calls
Date: Tue, 13 Nov 2007 00:01:49 +0100
Message-ID: <200711130001.49683.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:63392 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758174AbXKLW6X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:23 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1250510nfb
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:22 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>


Add ide_toggle_bounce() call to ->ide_dma_on/->dma_off_quietly
methods so they match generic __ide_dma_on()/ide_dma_off_quietly().

Since there is no PCI device there should be no functionality
changes caused by this patch.

Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/arm/icside.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -294,6 +294,7 @@ static void icside_dma_host_off(ide_driv
 static void icside_dma_off_quietly(ide_drive_t *drive)
 {
 	drive->using_dma = 0;
+	ide_toggle_bounce(drive, 0);
 }
 
 static void icside_dma_host_on(ide_drive_t *drive)
@@ -303,6 +304,7 @@ static void icside_dma_host_on(ide_drive
 static int icside_dma_on(ide_drive_t *drive)
 {
 	drive->using_dma = 1;
+	ide_toggle_bounce(drive, 1);
 
 	return 0;
 }
