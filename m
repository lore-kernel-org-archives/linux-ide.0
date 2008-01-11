From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: [PATCH 15/21] ide-floppy: disambiguate function names
Date: Fri, 11 Jan 2008 12:58:13 +0100
Message-ID: <1200052699-28420-16-git-send-email-bbpetkov@yahoo.de>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-2-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-3-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-4-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-5-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-6-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-7-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-8-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-9-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-10-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-11-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-12-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-13-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-14-git-send-email-bbpetkov@yahoo.de>
 <1200052699-28420-15-git-send-email-bbpetkov@yahoo.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp107.plus.mail.re1.yahoo.com ([69.147.102.70]:20680 "HELO
	smtp107.plus.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759449AbYAKMDm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 07:03:42 -0500
In-Reply-To: <1200052699-28420-15-git-send-email-bbpetkov@yahoo.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej@gollum.tnic, Zolnierkiewicz@gollum.tnic, bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

There were two almost identical function names in ide-floppy.c, which makes their
distinction almost impossible. While ide_floppy_release() cleans up the object
after the last reference to it has been dropped, idefloppy_release() is the blkdev
.release method from struct block_device_operations which releases that last reference.

Rename ide_floppy_release() to idefloppy_cleanup_obj() in order to make its purpose
more clear. There should be no functionality change resulting from this patch.

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
---
 drivers/ide/ide-floppy.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
index b718615..6e8926a 100644
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -234,12 +234,12 @@ static struct ide_floppy_obj *ide_floppy_get(struct gendisk *disk)
 	return floppy;
 }
 
-static void ide_floppy_release(struct kref *);
+static void idefloppy_cleanup_obj(struct kref *);
 
 static void ide_floppy_put(struct ide_floppy_obj *floppy)
 {
 	mutex_lock(&idefloppy_ref_mutex);
-	kref_put(&floppy->kref, ide_floppy_release);
+	kref_put(&floppy->kref, idefloppy_cleanup_obj);
 	mutex_unlock(&idefloppy_ref_mutex);
 }
 
@@ -1431,7 +1431,7 @@ static void ide_floppy_remove(ide_drive_t *drive)
 	ide_floppy_put(floppy);
 }
 
-static void ide_floppy_release(struct kref *kref)
+static void idefloppy_cleanup_obj(struct kref *kref)
 {
 	struct ide_floppy_obj *floppy = to_ide_floppy(kref);
 	ide_drive_t *drive = floppy->drive;
-- 
1.5.3.7

