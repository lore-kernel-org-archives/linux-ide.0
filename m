From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 02/18] ide-disk: lock media before checking for media change
Date: Mon, 08 Sep 2008 00:14:37 +0200
Message-ID: <20080907221437.24285.70475.sendpatchset@localhost.localdomain>
References: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.185]:54949 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711AbYIGWQq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Sep 2008 18:16:46 -0400
Received: by gv-out-0910.google.com with SMTP id e6so75275gvc.37
        for <linux-ide@vger.kernel.org>; Sun, 07 Sep 2008 15:16:45 -0700 (PDT)
In-Reply-To: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Borislav Petkov <petkovbb@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Cc: Borislav Petkov <petkovbb@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-disk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -836,7 +836,6 @@ static int idedisk_open(struct inode *in
 	idkp->openers++;
 
 	if ((drive->dev_flags & IDE_DFLAG_REMOVABLE) && idkp->openers == 1) {
-		check_disk_change(inode->i_bdev);
 		/*
 		 * Ignore the return code from door_lock,
 		 * since the open() has already succeeded,
@@ -845,6 +844,7 @@ static int idedisk_open(struct inode *in
 		if ((drive->dev_flags & IDE_DFLAG_DOORLOCKING) &&
 		    idedisk_set_doorlock(drive, 1))
 			drive->dev_flags &= ~IDE_DFLAG_DOORLOCKING;
+		check_disk_change(inode->i_bdev);
 	}
 	return 0;
 }
