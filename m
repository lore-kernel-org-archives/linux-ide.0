From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 11/16] ide: unexport SELECT_DRIVE()
Date: Tue, 22 Jan 2008 00:31:50 +0100
Message-ID: <20080121233150.30311.27777.sendpatchset@localhost.localdomain>
References: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:43625 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760790AbYAUXSp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 18:18:45 -0500
Received: by ug-out-1314.google.com with SMTP id z38so975308ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 15:18:44 -0800 (PST)
In-Reply-To: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    2 --
 1 file changed, 2 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -163,8 +163,6 @@ void SELECT_DRIVE (ide_drive_t *drive)
 	HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);
 }
 
-EXPORT_SYMBOL(SELECT_DRIVE);
-
 void SELECT_MASK (ide_drive_t *drive, int mask)
 {
 	if (HWIF(drive)->maskproc)
