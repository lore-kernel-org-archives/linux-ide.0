From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/4] ide: fix sparse warning about shadowing 'flags' symbol
Date: Sun, 17 Feb 2008 20:52:10 +0100
Message-ID: <200802172052.10691.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:51808 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbYBQTjz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 14:39:55 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1462658fkz.5
        for <linux-ide@vger.kernel.org>; Sun, 17 Feb 2008 11:39:53 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

drivers/ide/ide.c:801:18: warning: symbol 'flags' shadows an earlier one
drivers/ide/ide.c:732:16: originally declared here

Also fix some whitespace damage while at it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -797,10 +797,9 @@ int generic_ide_ioctl(ide_drive_t *drive
 			drive->nice1 = (arg >> IDE_NICE_1) & 1;
 			return 0;
 		case HDIO_DRIVE_RESET:
-		{
-			unsigned long flags;
-			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-			
+			if (!capable(CAP_SYS_ADMIN))
+				return -EACCES;
+
 			/*
 			 *	Abort the current command on the
 			 *	group if there is one, taking
@@ -819,17 +818,15 @@ int generic_ide_ioctl(ide_drive_t *drive
 			ide_abort(drive, "drive reset");
 
 			BUG_ON(HWGROUP(drive)->handler);
-				
+
 			/* Ensure nothing gets queued after we
 			   drop the lock. Reset will clear the busy */
-		   
+
 			HWGROUP(drive)->busy = 1;
 			spin_unlock_irqrestore(&ide_lock, flags);
 			(void) ide_do_reset(drive);
 
 			return 0;
-		}
-
 		case HDIO_GET_BUSSTATE:
 			if (!capable(CAP_SYS_ADMIN))
 				return -EACCES;
