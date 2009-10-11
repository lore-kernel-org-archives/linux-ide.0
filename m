From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-tape: remove the BKL
Date: Sun, 11 Oct 2009 12:25:19 +0200
Message-ID: <20091011102519.GA2641@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f227.google.com ([209.85.220.227]:64765 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829AbZJKK0B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Oct 2009 06:26:01 -0400
Received: by fxm27 with SMTP id 27so7965212fxm.17
        for <linux-ide@vger.kernel.org>; Sun, 11 Oct 2009 03:25:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide <linux-ide@vger.kernel.org>

Hi,

one less BKL user. Tested on a Seagate STT8000A, ATAPI TAPE drive.

---
>From 16e58d4d74a5f3a02204e2fe861d2cb3b3ee65fb Mon Sep 17 00:00:00 2001
From: Borislav Petkov <petkovbb@gmail.com>
Date: Mon, 5 Oct 2009 07:57:26 +0200
Subject: [PATCH] ide-tape: remove the BKL

Replace the BKL calls in the chrdev_{open,release} interfaces with a
simple sleeping mutex.

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 58fc920..6a0e625 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -221,6 +221,8 @@ typedef struct ide_tape_obj {
 
 static DEFINE_MUTEX(idetape_ref_mutex);
 
+static DEFINE_MUTEX(idetape_chrdev_mutex);
+
 static struct class *idetape_sysfs_class;
 
 static void ide_tape_release(struct device *);
@@ -1457,10 +1459,11 @@ static int idetape_chrdev_open(struct inode *inode, struct file *filp)
 	if (i >= MAX_HWIFS * MAX_DRIVES)
 		return -ENXIO;
 
-	lock_kernel();
+	mutex_lock(&idetape_chrdev_mutex);
+
 	tape = ide_tape_get(NULL, true, i);
 	if (!tape) {
-		unlock_kernel();
+		mutex_unlock(&idetape_chrdev_mutex);
 		return -ENXIO;
 	}
 
@@ -1519,12 +1522,15 @@ static int idetape_chrdev_open(struct inode *inode, struct file *filp)
 				tape->door_locked = DOOR_LOCKED;
 		}
 	}
-	unlock_kernel();
+	mutex_unlock(&idetape_chrdev_mutex);
+
 	return 0;
 
 out_put_tape:
 	ide_tape_put(tape);
-	unlock_kernel();
+
+	mutex_unlock(&idetape_chrdev_mutex);
+
 	return retval;
 }
 
@@ -1551,7 +1557,8 @@ static int idetape_chrdev_release(struct inode *inode, struct file *filp)
 	ide_drive_t *drive = tape->drive;
 	unsigned int minor = iminor(inode);
 
-	lock_kernel();
+	mutex_lock(&idetape_chrdev_mutex);
+
 	tape = drive->driver_data;
 
 	ide_debug_log(IDE_DBG_FUNC, "enter");
@@ -1575,7 +1582,9 @@ static int idetape_chrdev_release(struct inode *inode, struct file *filp)
 	}
 	clear_bit(ilog2(IDE_AFLAG_BUSY), &drive->atapi_flags);
 	ide_tape_put(tape);
-	unlock_kernel();
+
+	mutex_unlock(&idetape_chrdev_mutex);
+
 	return 0;
 }
 
-- 
1.6.3.3


-- 
Regards/Gruss,
    Boris.
