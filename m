From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [RFC PATCH] ide-floppy partitions
Date: Wed, 29 Oct 2008 08:13:19 +0100
Message-ID: <20081029071319.GA9205@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:55000 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbYJ2HNW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 03:13:22 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2643692fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 00:13:20 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hi Tejun,

recent changes at 0762b8bde9729f10f8e6249809660ff2ec3ad735 and around
break ide-floppy. Since it is a removable media drive and the partition
scan during boot returns empty (no media in the drive), when you later
put in a disk and try to mount it, mount returns saying

/dev/hdc4 is not a valid block device.

Which brings me to the other possible issue: Since having a hdc4
partition as a single FAT16 partition on a ZIP drive is the "factory
default" you could fabricate a case where you have a partition number> 1
as the only partition on a hard drive too, i.e. no continuous
partition numbering and the mount would theoretically fail there too
since, for example, there's a check in disk_get_part() which does:

if (likely(partno < ptbl->len)) {

and in this case the check will fail if partno >= 1 while you have only
one partition on the disk with a number higher than the partition table
length and the above described failure will happen too. Anyways, this is
just a hypothesis, but it happens with the ZIP drive here so other block
devices should behave similarly.

Here's a patch that fixes the ide-floppy case a bit clumsily, I admit.

---
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 88a776f..b798ea0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1011,6 +1011,23 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	disk = get_gendisk(bdev->bd_dev, &partno);
 	if (!disk)
 		goto out_unlock_kernel;
+
+	part = disk_get_part(disk, partno);
+	if (!part) {
+		struct block_device *whole;
+
+		mutex_lock_nested(&bdev->bd_mutex, for_part);
+		whole = bdget_disk(disk, 0);
+		ret = -ENOMEM;
+		if (!whole)
+			goto out_clear;
+		ret = __blkdev_get(whole, mode, 1);
+		if (ret)
+			goto out_clear;
+		bdev->bd_contains = whole;
+		mutex_unlock(&bdev->bd_mutex);
+	}
+
 	part = disk_get_part(disk, partno);
 	if (!part)
 		goto out_unlock_kernel;



-- 
Regards/Gruss,
    Boris.
