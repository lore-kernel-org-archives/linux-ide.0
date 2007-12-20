From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 30/63] ide-cd: remove NO_DOOR_LOCKING define
Date: Thu, 20 Dec 2007 02:15:17 +0100
Message-ID: <200712200215.17436.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:11731 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758656AbXLTBef (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:35 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389247ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:34 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-cd.c |    3 ---
 drivers/ide/ide-cd.h |    7 -------
 2 files changed, 10 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -2834,9 +2834,6 @@ int ide_cdrom_setup (ide_drive_t *drive)
 
 	cd->cd_flags |= IDE_CD_FLAG_MEDIA_CHANGED;
 
-#if NO_DOOR_LOCKING
-	cd->cd_flags |= IDE_CD_FLAG_NO_DOORLOCK;
-#endif
 	if ((drive->id->config & 0x0060) == 0x20)
 		cd->cd_flags |= IDE_CD_FLAG_DRQ_INTERRUPT;
 	cd->cd_flags |= IDE_CD_FLAG_NO_EJECT;
Index: b/drivers/ide/ide-cd.h
===================================================================
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -28,13 +28,6 @@
 #endif
 
 
-/* Turning this on will disable the door-locking functionality.
-   This is apparently needed for supermount. */
-
-#ifndef NO_DOOR_LOCKING
-#define NO_DOOR_LOCKING 0
-#endif
-
 /*
  * typical timeout for packet command
  */
