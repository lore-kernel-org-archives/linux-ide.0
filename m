From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/13] sgiioc4: add ide_toggle_bounce() calls
Date: Tue, 13 Nov 2007 00:01:44 +0100
Message-ID: <200711130001.44501.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:63838 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758187AbXKLW6X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 17:58:23 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1250581nfb
        for <linux-ide@vger.kernel.org>; Mon, 12 Nov 2007 14:58:20 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeremy Higdon <jeremy@sgi.com>


Add ide_toggle_bounce() call to ->ide_dma_on/->dma_off_quietly
methods so they match generic __ide_dma_on()/ide_dma_off_quietly().

Cc: Jeremy Higdon <jeremy@sgi.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/sgiioc4.c |    2 ++
 1 file changed, 2 insertions(+)

Index: b/drivers/ide/pci/sgiioc4.c
===================================================================
--- a/drivers/ide/pci/sgiioc4.c
+++ b/drivers/ide/pci/sgiioc4.c
@@ -281,6 +281,7 @@ static int
 sgiioc4_ide_dma_on(ide_drive_t * drive)
 {
 	drive->using_dma = 1;
+	ide_toggle_bounce(drive, 1);
 
 	return 0;
 }
@@ -288,6 +289,7 @@ sgiioc4_ide_dma_on(ide_drive_t * drive)
 static void sgiioc4_dma_off_quietly(ide_drive_t *drive)
 {
 	drive->using_dma = 0;
+	ide_toggle_bounce(drive, 0);
 
 	drive->hwif->dma_host_off(drive);
 }
