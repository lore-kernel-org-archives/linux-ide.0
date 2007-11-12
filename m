From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/13] au1xxx-ide: add ide_toggle_bounce() calls
Date: Tue, 13 Nov 2007 00:01:54 +0100
Message-ID: <200711130001.54740.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:63930 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837AbXKLW6Y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:24 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1250598nfb
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:23 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add ide_toggle_bounce() call to ->ide_dma_on/->dma_off_quietly
methods so they match generic __ide_dma_on()/ide_dma_off_quietly().

Since there is no PCI device there should be no functionality
changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/mips/au1xxx-ide.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -402,6 +402,7 @@ static void auide_dma_host_on(ide_drive_
 static int auide_dma_on(ide_drive_t *drive)
 {
 	drive->using_dma = 1;
+	ide_toggle_bounce(drive, 1);
 
 	return 0;
 }
@@ -413,6 +414,7 @@ static void auide_dma_host_off(ide_drive
 static void auide_dma_off_quietly(ide_drive_t *drive)
 {
 	drive->using_dma = 0;
+	ide_toggle_bounce(drive, 0);
 }
 
 static void auide_dma_lost_irq(ide_drive_t *drive)
